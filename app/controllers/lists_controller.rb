class ListsController < ApplicationController
  def index
    @lists = List.all
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
      redirect_to list_path(@list), notice: 'Your new list was successfully created.'
    else
      render :new, notice: 'Error, your list was not saved, try again.'
    end
  end

  def edit
    @list = List.find(params[:id])
  end

  def update
    @list = List.find(params[:id])
    @list.update(list_params)
    if @list.save
      redirect_to @list, notice: 'Your list was successfully updated.'
    else
      render :edit
    end
  end

  private

  def list_params
    params.require(:list).permit(:name) # add something about the movies from this list?
  end
end
