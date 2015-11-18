#!/usr/local/bin/gawk -f
# Usage coll.awk <<< e-mail@add.re.ss

BEGIN { FS="@"; }
{
 collision="^c0ffee";
 mailStart=$1; 
 mailEnd=$2;

 loops=10000000;
 cmd="sha1sum -t" 
};
{ 
  print "Finding collisions for " mailStart "+<number>@" mailEnd;

  for( seed=0; seed<=loops; seed++) {
    address = mailStart"+"seed"@"mailEnd;
    printf "%s",address |& cmd;
    close(cmd,"to");
    cmd |& getline hash
    close(cmd);
    if ( hash ~ collision ) {
      print address, hash;
      exit;
    };
  }; 
};
