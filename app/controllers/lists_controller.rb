class ListsController < ApplicationController
  # def index
  #   if params[:query].present?
  #     @lists = List.where("name ILIKE ?", "%#{params[:query]}%")
  #   else
  #     @lists = List.all
  #   end
  # end

  def index
    @lists = List.all

    if params[:query].present?
      query = "%#{params[:query]}%"
      @lists = @lists.joins(bookmarks: :movie).where("lists.name ILIKE :query OR movies.title ILIKE :query OR movies.overview ILIKE :query", query: query).distinct
    end
  end

  def show
    @list = List.find(params[:id])
  end

  def new
    @list = List.new
  end

  def create
    @list = List.new(list_params)
    if @list.save
      redirect_to list_path(@list)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @list = List.find(params[:id])
  end

  def update
    @list = List.find(params[:id])
    if @list.update(list_params)
      redirect_to list_path(@list)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @list = List.find(params[:id])
    @list.destroy
    redirect_to lists_path
  end

  private

  def list_params
    params.require(:list).permit(:name, :photo)
  end
end
