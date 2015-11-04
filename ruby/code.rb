require 'digest/sha1'

def template(iteration)
  "you+#{iteration}@yourdomain.com"
end

i = 0

loop do
  email = template(i += 1)
  calculated_sum = Digest::SHA1.hexdigest(email)
  next unless calculated_sum.start_with?('c0ffee')
  puts "FOUND!"
  puts email
  puts calculated_sum
  break
end
