require 'open-uri'
require 'nokogiri'

Target = ARGV[0]

doc = Nokogiri::HTML(open(Target))

doc.xpath("//form").each_with_index do |form,i|
	puts "---------- FORM #{i+1} ----------"
	puts "Action: " + form['action']
	puts "Method: " + form['method']
	puts "FIELD"
	form.xpath(".//input").each do |input|
		puts " Name: #{input['name']} - Type: #{input['type']}"
	end
	puts
end




