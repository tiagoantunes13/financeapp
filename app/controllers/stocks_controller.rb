class StocksController < ApplicationController
  def search
    p params
    if params[:stock].present?
      @stock = Stock.new_lookup(params[:stock])
      if @stock == nil
        respond_to do |format|
          flash[:alert] = "Enter a valid Stock"
          format.turbo_stream do
            render turbo_stream: [
              turbo_stream.update(:messagess, partial: "layouts/messages"),
              turbo_stream.update(:formUpdate, partial: "stocks/searchform", locals: {stock: "asdsda"})
            ]
          end
          #format.turbo_stream { render turbo_stream: turbo_stream.update(:idteste, partial: "users/result")}
          #format.html { render root_path, alert: "Please enter a valid symbolaa"} ## Specify the format in which you are rendering "new" page
        end
      else
        #render "users/my_portfolio"
        if current_user.stocks.size == 10
          var = false
        else
          var = true
        end

        respond_to do |format|
          format.turbo_stream do
            render turbo_stream: [
              turbo_stream.prepend(:idteste, partial: "users/result", locals:{variable: var}),
              turbo_stream.update(:formUpdate, partial: "stocks/searchform", locals: {stock: "Asdasd"})
            ]
            #format.html { render 'users/my_portfolio'} ## Specify the format in which you are rendering "new" page
          end
        end
        #render 'users/my_portfolio'
      end
    else
      respond_to do |format|
        flash[:alert] = "Enter a Stock"
        format.turbo_stream { render turbo_stream: turbo_stream.update(:messagess, partial: "layouts/messages")}
        #format.html { render 'users/my_portfolio'} ## Specify the format in which you are rendering "new" page
      end
    end
  end
end
