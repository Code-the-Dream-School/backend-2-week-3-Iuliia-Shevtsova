class OrdersController < ApplicationController
    before_action :set_customer
    # before_action :set_order

    def index
        @orders = Order.all 
    end

    def create
        # @customer = Customer.find(params[:customer_id])
        # Create associated model, just like we did in the console before
        @order = @customer.orders.create(order_params)
        # We want to show the order in the context of the customer
        redirect_to @customer
    end

    def edit
        # @customer = Customer.find(params[:customer_id])
        @order = Order.find(params[:id])
    end    

    def update
        @order = Order.find(params[:id])
        @order.update(order_params)
        redirect_to @customer 
    end   
    
    def destroy
        @order = Order.find(params[:id])
        @order.destroy
        redirect_to @customer
    end    

    private
    
    def order_params
        params.require(:order).permit(:product_name, :product_count)
    end    

    def set_customer
        @customer = Customer.find(params[:customer_id])
    end

    def set_order
        @order = Order.find(params[:id])
    end
end
