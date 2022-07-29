class FriendshipsController < ApplicationController




  def create
    p params
    Friendship.create(user_id: current_user.id,friend_id: params[:id])
    @users = current_user.friends
    respond_to do |format|
       flash.now[:notice] = "Started following user #{User.find(params[:id]).first_name}"
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.update(:listafriends, partial: "users/list_friends"),
          turbo_stream.update(:idteste1, partial: "users/friend_result"),
          turbo_stream.update(:messagess, partial: "layouts/messages")
        ]
        format.html { render 'users/my_portfolio'} ## Specify the format in which you are rendering "new" page
      end
    end
  end


  def destroy
    @users = current_user.friends
    Friendship.where(user_id: current_user, friend_id: params[:id]).first.destroy
    respond_to do |format|
      flash.now[:notice] = "User no longer followed"
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.update(:listafriends, partial: "users/list_friends"),
          turbo_stream.update(:messagess, partial: "layouts/messages")

        ]
        #format.html { render 'users/my_portfolio'} ## Specify the format in which you are rendering "new" page
      end
    end
    #redirect_to my_friends_path, status: :see_other
  end
end
