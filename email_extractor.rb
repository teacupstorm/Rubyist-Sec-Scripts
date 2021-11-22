require 'open-uri'

Target = ARGV[0]
Email_re = /[-0-9a-zA-Z.+_]+@[-0-9a-zA-Z.+_]+\.[a-zA-Z]{2,4}/

emails = open(Target){ |res| res.read.scan(Email_re) }

emails.each {|email| puts email}
