class UserStocksController < ApplicationController
    def create
        # this is method to verify entry is present in db or not (refer model-stocks.rb)
        stock = Stock.check_db(params[:ticker])
        # if stock is not available
        if stock.blank?
        # i.e when ticker is not present in table (what if ticker is present in table check model-stock.rb file.)
            stock = Stock.new_lookup(params[:ticker])
            # save in db
            stock.save
        end 
        # instance variable ,user going to be current logged in user and stock i.e need to create.
        @user_stock = UserStock.create(user: current_user, stock: stock)
        flash[:notice] = "Stock #{stock.name} was successfully added to your portfolio"
        redirect_to my_portfolio_path
    end

    def destroy
        # find in user stock by id
        stock = Stock.find(params[:id])
        # find it in UserStock table by user id and stock id(stock object)
        user_stock = UserStock.where(user_id: current_user, stock_id: stock.id).first
        # found delete it
        user_stock.destroy
        # flash error msg
        flash[:notice] = "#{stock.ticker} was successfully removed from portfolio"
        # redirect to the same page i.e my-portfolio.
        redirect_to my_portfolio_path
    end
end
