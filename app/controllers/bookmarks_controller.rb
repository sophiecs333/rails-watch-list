class BookmarksController < ApplicationController
  def new
    @bookmark = Bookmark.new
    @list = List.find(params[:list_id]) # bookmark list AND movie?
  end

  def create
    @list = List.find(params[:list_id])
    @movie = Movie.find(params[:bookmark][:movie_id])
    @bookmark = Bookmark.new(bookmark_params)
    @bookmark.list = @list
    @bookmark.movie = @movie
    if @bookmark.save
      redirect_to list_path(@list), notice: 'Your new bookmark was successfully created.'
    else
      render :new, notice: 'Error, your bookmark was not saved, try again.'
    end
  end

  def edit
    @list = List.find(params[:id])
    @bookmark = Bookmark.find(params[:list_id])

  end

  def update
    @bookmark = Bookmark.find(params[:id])
    @list = List.find(params[:list_id])
    @bookmark.update(bookmark_params)
    if @bookmark.save
      redirect_to list_path(@bookmark.list), notice: 'Your bookmark was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:list_id])
    @bookmark.destroy
    redirect_to list_path(@bookmark.list), method: :delete
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:comment, :movie_id, :photo, :list_id)
  end

end
