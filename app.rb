require "json"
require "sinatra"
require "sinatra/json"
require "sinatra/config_file"
require_relative "calls"

config_file = 'config.yml'

use Rack::Auth::Basic, "Restricted Area" do |username, password|
    [username, password] == ['javaguirre', 'javaguirre']
end

get "/" do
    settings.title
end

get %r{/([\w]+)} do
    json send params[:captures].first.to_sym
end
