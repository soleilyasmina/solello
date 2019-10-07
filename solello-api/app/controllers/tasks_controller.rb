class TasksController < ApplicationController
  before_action :set_task, except: [:index, :create]
  before_action :set_column, only: [:create, :swap_tasks, :swap_columns]
  before_action :cleanup, only: [:swap_columns]
  after_action :cleanup, only: [:destroy]

  # GET /tasks
  def index
    @tasks = Task.all

    render json: @tasks
  end

  # GET /tasks/1
  def show
    render json: @task
  end

  # POST /tasks
  def create
    order = @column.tasks.length
    @task = Task.new({
      title: task_params[:title],
      column: @column,
      order: order
    })

    if @task.save
      render json: @task, status: :created
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  def swap_tasks
    Task.swap @task, params[:new_order], Column.find(@task.column_id)
    render json: @task
  end

  def swap_columns
    order = @column.tasks.length
    @task.update(order: order, column_id: @column.id)
    Task.swap @task, params[:new_order], @column
    render json: @task
  end

  # PATCH/PUT /tasks/1
  def update
    if @task.update(task_params)
      render json: @task
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  # DELETE /tasks/1
  def destroy
    @task.destroy
    render json: @task
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    def set_column
      @column = Column.find(params[:column_id])
    end

    def cleanup
      Task.cleanup @task
    end

    # Only allow a trusted parameter "white list" through.
    def task_params
      params.require(:task).permit(:title)
    end
end
