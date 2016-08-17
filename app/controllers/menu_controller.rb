class MenuController < ApplicationController

  before_filter :authorize
  def index
    #session[:cot_id] = nil
  end
end
