class BooksController < ApplicationController
	def top
	end

	def about
	end

  def create
  	# @books = @user.books.page(params[:page]).reverse_order
  	@user = current_user
  	@books = Book.all
  	@book = Book.new(book_params)
  	@book.user_id = current_user.id
  	if @book.save
  		flash[:notice] = "Book was successfully created."
  	   redirect_to book_path(@book.id)
  	else
  		render 'index'
  	end
  end
  def index
  	@book = Book.new
  	@books = Book.all
  	@user = current_user
  end

  def show
  	@book_new = Book.new
  	@book = Book.find(params[:id])
  	@user = User.find(@book.user_id)
  end

  def edit
  	@book = Book.find(params[:id])
  	if @book.user_id != current_user.id
  		redirect_to books_path
  	end
  end

  def update
  	@book = Book.find(params[:id])
  	if @book.update(book_params)
  		flash[:notice] = "Book was successfully updates."
  	   redirect_to book_path(@book.id)
  	else
  		render 'edit'
  	end
  end

  def destroy
  	@book = Book.find(params[:id])
  	if @book.destroy
  		flash[:notice] = "Book was successfully deleted."
  	   redirect_to books_path
  	end

  end

  private
  def book_params
  	params.require(:book).permit(:title, :body)
  end
end
