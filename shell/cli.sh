#!/usr/bin/env bash
#
# Usage: ./cli.sh your-email@your-domain.com
#

HASH_START="c0ffee"
HASH_START_LEN=$(echo -n $HASH_START | wc -m)

email=$1

if [[ "x$email" == "x" ]]
then
    echo "Argument 1 must be an email address"
    exit 1
fi

email_user=$(echo -n "$email" | awk -F'@' '{ print $1 }')
email_domain=$(echo -n "$email" | awk -F'@' '{ print $2 }')

i=0
while [ $i -le 1000000000 ]
do
    variation=${email_user}+${i}@${email_domain}
    digest=$(echo -n "${variation}" | sha1sum | sed 's/\s*-$//')
    if [[ "${digest:0:$HASH_START_LEN}" == "${HASH_START}" ]]
    then
        echo "Round: $i"
        echo "Email: $variation"
        echo "Digest: $digest"
        break
    fi
    i=$(($i+1))
done
