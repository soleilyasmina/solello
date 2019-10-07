class ColumnsController < ApplicationController
  before_action :set_column, only: [:show, :update, :destroy, :swap_columns]
  before_action :set_board, only: [:create, :swap_columns]
  after_action :cleanup, only: [:destroy]

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
    order = @board.columns.length
    @column = Column.new({
      title: column_params[:title], 
      board: @board,
      order: order 
    }) 
    if @column.save
      render json: @column, status: :created
    else
      render json: @column.errors, status: :unprocessable_entity
    end
  end

  # PUT /columns/:id/:new_order
  def swap_columns
    Column.swap @column, params[:new_order], @board 
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
    render json: @column
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_column
      @column = Column.find(params[:id])
    end

    def set_board
      @board = Board.find(params[:board_id])
    end

    def cleanup
      Column.cleanup @column
    end

    # Only allow a trusted parameter "white list" through.
    def column_params
      params.permit(:title)
    end
end
