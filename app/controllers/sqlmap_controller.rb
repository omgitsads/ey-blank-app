class SqlmapController < ApplicationController
  def index
    Insecure.where("name = #{params[:search]}")
  end
end
