class SqlmapController < ApplicationController
  def index
    Insecure.where("name = #{params[:search]}")
    render :text => "ok"
  end
end
