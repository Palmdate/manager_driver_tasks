class DriverController < ApplicationController
  before_action :authenticate_driver!
  def index
  end
end
