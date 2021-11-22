require 'nokogiri'
require 'open-uri'
require 'cgi'

Target = URI(ARGV[0])
Parameter = ARGV[1]

XSS_VECTORS = ["<script>alert(123456)</script>"]
Testing_Values = ["alert(123456)"]

Query = CGI.parse(Target.query)

XSS_VECTORS.zip(Testing_Values).each do |vect,test|

	Query[Parameter] = vect
	Target.query = URI.encode_www_form(Query)
	doc = Nokogiri::HTML(open(Target))

	doc.search("//text()[contains(.,'#{test}')]").each do	|el|
		if el.parent.name == 'script'then
			puts "----- Probable XSS found -------"
			puts "Injection Vector: #{vect}","\n"
			puts "FOUND IN THE FOLLOWING CODE"
			puts el.parent.parent.to_html	
			puts "--------------------------------","\n"
		end
	end 

end
