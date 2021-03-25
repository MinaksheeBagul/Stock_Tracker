class StocksController < ApplicationController
   def search
      # putting validation for random search or search blank.
      if params[:stock].present?
      # called new_lookup method and display stock params 
            @stock = Stock.new_lookup(params[:stock])
            if @stock
               # rendering on stock page
               # render json: @stock
               # for js response then it will render to results, and results expected js.erb file.
               respond_to do |format|
                  format.js { render partial: 'users/result'}
               end
               # render 'users/my_portfolio'
            else
               # JS responses to the erros.
               respond_to do |format|
                  # .now will persist one cycle
                  flash.now[:alert] = "Please enter a valid symbol to search"
                  format.js {render partial: 'users/result'}
               end
               # redirect_to my_portfolio_path
            end
      else
            # JS responses to the erros.
            respond_to do |format|
               # will give an error msg to user.
               flash.now[:alert] = "Please enter a symbol to search"
               format.js {render partial: 'users/result'}
            end
      end
   end
end