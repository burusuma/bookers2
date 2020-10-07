class BooksController < ApplicationController
	before_action :authenticate_user!, :except => [:top, :about]
  before_action :ensure_correct_user, :only => [:edit, :update]

  def create
    # Hash
    #  {:book => {:title => 'Ruby', :body => 'programming language'}}

    # user=User.find(params[:id])
  	@post_book = Book.new(post_book_params)
  	@post_book.user_id = current_user.id
  	if @post_book.save
       
  	   redirect_to book_path(@post_book.id), notice: "You have creatad book successfully."
    else
      @post_books=Book.all
      @user=current_user
      render :index
    end

  end

  def index
   @post_book=Book.new
   @post_books=Book.all
   
   @user=current_user
  end

  def update
  	@post_book=Book.find(params[:id])
  	if @post_book.update(post_book_params)
  	  redirect_to book_path, notice: "You have updated book successfully."
    else
      render :edit
    end

  end
  

  def edit
  	@post_book=Book.find(params[:id])
  end

  def destroy
  	@post_book=Book.find(params[:id])
  	@post_book.destroy
  	redirect_to books_path
  end

  def top
  end

  def show
    # /books/:id
  	@post_book = Book.find(params[:id])
    @new_post_book = Book.new
  	# @user=User.new
  	# @user.id=@post_book.user_id
  	# @user=User.find_by(id: @user.id)
    @user = @post_book.user
  end

  def about
  end

  def ensure_correct_user
    @post = Book.find_by(id:params[:id])
    if @post.user_id != current_user.id
      flash[:notice] = "権限がありません"
      redirect_to books_path
    end
  end

  private
  def post_book_params
  	params.require(:book).permit(:title, :body)
  end

end
