class NginxLocationTestController < ApplicationController
  def show
    Rails.logger.debug(request.headers)
    render :text => "I'm from Rails!"
  end
end
