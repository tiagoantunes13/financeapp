class UserStocksController < ApplicationController
  def create
    p params
    @stock = Stock.check_db(params[:ticker])
    @user = User.find(params[:user])
    if @stock.blank?
      @stock = Stock.new_lookup(params[:ticker])
      @stock.save
    end
    @user_stock = UserStock.create(user: @user, stock: @stock)
    @tracked_stocks = @user.stocks
    respond_to do |format|
      format.turbo_stream do
        flash[:notice] = "Stock adicionado"
        render turbo_stream: [
          turbo_stream.update(:idteste),
          turbo_stream.update(:listastocks, partial: "stocks/list"),
          turbo_stream.update(:messagess, partial: "layouts/messages")
        ]
        #format.html { render 'users/my_portfolio'} ## Specify the format in which you are rendering "new" page
      end
    end
  end


  def destroy
    stock = Stock.find(params[:id])
    user_stock = UserStock.where(user_id: current_user.id, stock_id: stock.id).first
    user_stock.destroy
    flash.now[:notice] = "Stock #{stock.ticker} successfully deleted"
    #redirect_to my_portfolio_path, status: :see_other
    #
    @tracked_stocks = current_user.stocks
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.update(:listastocks, partial: "stocks/list"),
          turbo_stream.update(:messagess, partial: "layouts/messages")

        ]
        #format.html { render 'users/my_portfolio'} ## Specify the format in which you are rendering "new" page
      end
    end
  end
end
