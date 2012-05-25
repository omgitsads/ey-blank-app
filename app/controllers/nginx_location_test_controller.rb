class NginxLocationTestController < ApplicationController
  def show
    Rails.logger.debug(request.headers)
    render :text => "I'm from Rails!"
  end

  def envvars
    render :text => "Here is an Env Variable: #{ENV['TEST']}"
  end
end
