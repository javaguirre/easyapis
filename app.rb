require "rubygems" if RUBY_VERSION < "1.9"
require "sinatra"
require "sinatra/json"
require "sinatra/config_file"
require "sinatra/memcache"
require "./calls"


class EasyApis < Sinatra::Base
    register Sinatra::ConfigFile
    register Sinatra::MemCache
    helpers Sinatra::JSON
    #helpers Sinatra::MemCache::Helpers

    config_file 'config.yml'

    use Rack::Auth::Basic, "Restricted Area" do |username, password|
        [username, password] == [settings.username, settings.password]
    end

    get "/" do
        settings.title
    end

    #TODO experiment, we need security
    get %r{/([\w]+)} do
        call_action = params[:captures].first.to_sym
        hash = cache "API" do
            {call_action => json(Calls.send(call_action))}
        end
        content_type :json
        hash[call_action]
    end
end

EasyApis.run!
