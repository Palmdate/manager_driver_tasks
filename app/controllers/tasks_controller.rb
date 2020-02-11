class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy, :update_to_done]

  # GET /tasks
  # GET /tasks.json
  def index
    if current_driver
      
    else
      redirect_to root_path
      
    end
    @tasks = Task.all
  end

  def list_task_nearby
    @location = params[:location]
    Driver.find(current_driver.id).update(location: @location)
    @tasks = Task.where(status: nil).pluck(:id, :pickup_loc)
    @list_id_task = @tasks.select{|location| Geocoder::Calculations.distance_between(location.last, @location) < 20.0 }.map{|id| id.first}
    @tasks_nearby = Task.where(id: @list_id_task)
    respond_to do |format|
      format.js { render json: { html: render_to_string(partial: 'list_task_nearby', locals: { tasks_nearby: @tasks_nearby, location: @location }) } }
    end
  end
  # GET /tasks/1
  # GET /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    if current_manager
      @task = Task.new
    else
      redirect_to root_path
    end
    
  end

  # GET /tasks/1/edit
  def edit
    respond_to do |format|
      if @task.update(status: 'assigned', driver_id: current_driver.id)
        format.html { redirect_to driver_index_path, notice: 'Task was successfully change to assignrd.' }
        format.json { render :index, status: :created, location: @task }
      else
        format.html { render :index }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # POST /tasks
  # POST /tasks.json
  def create
    @task = Task.create(description: params[:description], pickup_loc: params[:pickup_loc], deliver_loc: params[:deliver_loc], status: 'new')

    respond_to do |format|
      if @task.save
        format.html { redirect_to manager_index_path, notice: 'Task was successfully created.' }
        format.json { render :index, status: :created, location: @task }
      else
        format.html { render :new }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(status: 'done')
        format.html { redirect_to driver_index_path, notice: 'Task was successfully change to done.' }
        format.json { render :index, status: :created, location: @task }
      else
        format.html { render :index }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def update_to_done
    respond_to do |format|
      if @task.update(status: 'done')
        format.html { redirect_to driver_index_path, notice: 'Task was successfully change to assignrd.' }
        format.json { render :index, status: :created, location: @task }
      else
        format.html { render :index }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
    
  end
  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to manager_index_path, notice: 'Task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.fetch(:task, {}).permit(:description, :pickup_loc, :deliver_loc, :status)
    end
end
