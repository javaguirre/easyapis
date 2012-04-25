require "rubygems" if RUBY_VERSION < "1.9"
require "sinatra"
require "sinatra/json"
require "sinatra/config_file"
require "sinatra/memcache"
require "./calls"

config_file = 'config.yml'

class EasyApis < Sinatra::Base
    helpers Sinatra::JSON
    helpers Sinatra::MemCache

    use Rack::Auth::Basic, "Restricted Area" do |username, password|
        [username, password] == ['javaguirre', 'javaguirre']
    end

    get "/" do
        settings.title
    end

    get %r{/([\w]+)} do
        json Calls.send params[:captures].first.to_sym
    end
end

EasyApis.run!
