class UsersController < ApplicationController
  def my_portfolio
    @tracked_stocks = current_user.stocks
  end

  def show_friends
    @users = current_user.friends
  end

  def search
    if params[:user].present?
      @user = User.search(params[:user])
      @user = current_user.except_current_user(@user)
      p @user
      if @user
        respond_to do |format|
          format.turbo_stream do
            render turbo_stream: [
              turbo_stream.update(:idteste1, partial: "users/friend_result"),
              turbo_stream.update(:searchfriends, partial: "users/search_friends_form")
            ]
          end
        end
      else
        respond_to do |format|
          flash.now[:alert] = "No user found"
          format.turbo_stream do
            render turbo_stream: [
              turbo_stream.update(:searchfriends, partial: "users/search_friends_form"),
              turbo_stream.update(:messagess, partial: "layouts/messages")
            ]
            #format.html { render 'users/my_portfolio'} ## Specify the format in which you are rendering "new" page
          end
        end
      end
      else
    respond_to do |format|
      flash.now[:alert] = "Enter a name"
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.update(:searchfriends, partial: "users/search_friends_form"),
          turbo_stream.update(:messagess, partial: "layouts/messages")
        ]
        #format.html { render 'users/my_portfolio'} ## Specify the format in which you are rendering "new" page
      end
    end
    end

  end


  def show
    @user = User.find(params[:id])
    @tracked_stocks = @user.stocks

  end

end
