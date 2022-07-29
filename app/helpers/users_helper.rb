module UsersHelper
  def can_be_friend?(user_id)
    !(current_user.friends.include? User.find(user_id))
  end


  def can_buy_stock?(ticker)
    !(current_user.stocks.include? Stock.find_by_ticker(ticker))
  end

end
