class ManagerController < ApplicationController
  before_action :authenticate_manager!
  def index
    @new_tasks = Task.where(status: 'new')
    @assigned_tasks =  Task.where(status: 'assigned')
    @done_tasks =  Task.where(status: 'done')
  end
end
