class UsersController < ApplicationController
	before_action :authenticate_user!
	before_action :ensure_correct_user, :only => [:edit, :update]

	def new
		@user=User.new
		@user.save
		if @user.save
			redirect_to user_path, notice: "Welcome! You have signed up successfully."
		else
			render :new
		end
	end

	def create
		@user=User.find(params[:id])
		@post_books
	end

	def edit
		@user=User.find(params[:id])
	end

	def update
		@user=User.find(params[:id])
		if @user.update(user_params)
			redirect_to user_path, notice: "You have Update User successfully."
		else
			render :edit
		end
	end

	def destroy
	end

	def index
		@users=User.all
		@user=current_user
		@post_book=Book.new
	end

	def show
		@user=User.find(params[:id])
		@post_books=@user.books.all
		@post_book=Book.new
	end

	def user_params
  		params.require(:user).permit(:name, :introduction, :profile_image)
	end

	def ensure_correct_user
       	@user = User.find_by(id:params[:id])
	    if @user.id != current_user.id
	       flash[:notice] = "権限がありません"
	       redirect_to user_path(current_user)
	 	end
    end

end
