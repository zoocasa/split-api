require 'sinatra/base'
require 'split'
require 'multi_json'

module Split
  class API < Sinatra::Base
    enable :sessions
    helpers Split::Helper

    get '/ab_test' do
      experiment = params[:experiment]
      control = params[:control]
      alternatives = params[:alternatives]
      alternative = ab_test(experiment, control, *alternatives)
      MultiJson.encode({:alternative => alternative})
    end

    post '/finished' do
      experiment = params[:experiment]
      ab_finished(experiment)
      204
    end
  end
end
