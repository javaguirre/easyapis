require "httparty"
require "nokogiri"
require "json"

response = HTTParty.get("http://countrycode.org/")

doc = Nokogiri::HTML(response.body)

table = doc.xpath("//table[@id='main_table_blue']").first
tbody = table.children[1]
phone_codes = Hash.new

tbody.children.each do |item|
    code = item.children[2].content.chop.split(" / ")[0]
    phone_code = item.children[4].content.chop
    phone_codes[code] = phone_code
end

File.open("phone_codes.js", "w") do |f1|
    phone_codes = phone_codes.to_json
    f1.puts "var phone_codes = #{phone_codes}"
end
