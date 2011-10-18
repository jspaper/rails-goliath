require 'digest'

class HomeController < ApplicationController
  before_filter :authenticate_user!

  def index
    EM.synchrony do
      salt = 'supersecretsalt'
      query = { 'user_id' => current_user.id.to_s }
      query['signature'] = Digest::MD5.hexdigest(query.to_s+salt)

      @query = query

      req = EM::HttpRequest.new('http://localhost:9000').get :query => query

      req.callback do
        @data = req.response
        EM.stop
      end
    end
  end

end
