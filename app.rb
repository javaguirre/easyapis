require "json"
require "rubygems"
require "sinatra"


use Rack::Auth::Basic, "Restricted Area" do |username, password|
    [username, password] == ['javaguirre', 'javaguirre']
end

get "/" do
    content_type :json
    {:key => "value1", :key2 => "value2"}.to_json
end
