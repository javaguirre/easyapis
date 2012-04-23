require "json"
require "rubygems"
require "sinatra"
require_relative "calls"


use Rack::Auth::Basic, "Restricted Area" do |username, password|
    [username, password] == ['javaguirre', 'javaguirre']
end

get "/" do
    content_type :json
    phone_codes
end
