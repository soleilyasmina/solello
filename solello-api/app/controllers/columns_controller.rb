class ColumnsController < ApplicationController
  before_action :set_column, only: [:show, :update, :destroy, :swap_columns]

  # GET /columns
  def index
    @columns = Column.all

    render json: @columns
  end

  # GET /columns/1
  def show
    render json: @column
  end

  # POST /columns
  def create
    order = Column.where("board_id = ?", params[:board_id]).length
    @column = Column.new({
      title: params[:title], 
      board: Board.find(params[:board_id]),
      order: order 
    }) 
    if @column.save
      render json: @column, status: :created, location: @column
    else
      render json: @column.errors, status: :unprocessable_entity
    end
  end

  # PUT /columns/:id/:new_order
  def swap_columns
    puts Column.swap @column, params[:new_order], Board.find(@column.board_id)
    render json: @column
  end

  # PATCH/PUT /columns/1
  def update
    if @column.update({ title: params[:title] })
      render json: @column
    else
      render json: @column.errors, status: :unprocessable_entity
    end
  end

  # DELETE /columns/1
  def destroy
    @column.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_column
      @column = Column.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def column_params
      params.require(:column).permit(:title, :board_id)
    end
end
