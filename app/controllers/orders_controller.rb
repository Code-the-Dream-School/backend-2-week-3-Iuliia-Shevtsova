class OrdersController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :catch_not_found
    # before_action :set_customer
    # before_action :set_order

    def index
        @orders = Order.all  
    end

    def create
        # @customer = Customer.find(params[:customer_id])
        # # Create associated model, just like we did in the console before
        # @order = @customer.orders.create(order_params)
        # # We want to show the order in the context of the customer
        # redirect_to @customer

        @customer = Customer.find(params[:order][:customer_id])
        @order = @customer.orders.create(order_params)

        # @order = Order.new(order_params)
        respond_to do |format|
            if @order.save 
                format.html { redirect_to @order, notice: 'Order was successfully created.' }
                format.json { render :show, status: :created, location: @order }
                # if (request.referer == "http://localhost:3000/customers/#{@order.customer_id}")           
                #     format.html { redirect_to request.referer, notice: 'Order was successfully updated.' }
                #     format.json { render :show, status: :created, location: @order }
                # end
                # if (request.referer == "http://localhost:3000/orders/new")           
                #     format.html { redirect_to "http://localhost:3000/orders", notice: 'Order was successfully updated.' }
                #     format.json { render :show, status: :created, location: @order }
                # end
                # # ?????????????
                # if (request.referer == "http://localhost:3000/orders")           
                #     format.html { redirect_to "http://localhost:3000/customers/#{@order.customer_id}", notice: 'Order was successfully updated.' }
                #     format.json { render :show, status: :created, location: @order }
                # end
            else
                format.html { render :new }
                # format.html { redirect_to request.referer }
                format.json { render json: @order.errors, status: :unprocessable_entity }
            end
        end
        
    end

    def show
        @order = Order.find(params[:id]) 
    end

    def new
        @order = Order.new
    end

    def edit
        # @customer = Customer.find(params[:customer_id])
        @order = Order.find(params[:id])
    end    

    def update 
        # # @customer = Customer.find(params[:customer_id])
        # @order = Order.find(params[:id])
        # @order.update(order_params)
        # redirect_to @customer 

        @order = Order.find(params[:id])
        respond_to do |format|
            if @order.update(order_params)
                # format.html { redirect_to @order, notice: 'Order was successfully updated.' }  
                if (request.referer == "http://localhost:3000/customers/#{@order.customer_id}/orders/#{@order.id}/edit")           
                    format.html { redirect_to "http://localhost:3000/customers/#{@order.customer_id}", notice: 'Order was successfully updated.' }
                end
                if (request.referer == "http://localhost:3000/orders/#{@order.id}/edit")           
                    format.html { redirect_to "http://localhost:3000/orders/#{@order.id}", notice: 'Order was successfully updated.' }
                end
                # ?????????????
                if (request.referer == "http://localhost:3000/orders/#{@order.id}")           
                    format.html { redirect_to "http://localhost:3000/customers/#{@order.customer_id}", notice: 'Order was successfully updated.' }
                end
              format.json { render :show, status: :ok, location: @order }
            else
              format.html { render :edit }
              format.json { render json: @order.errors, status: :unprocessable_entity }
            end
        end
    end   
    
    def destroy
        # @order = Order.find(params[:id])
        # @order.destroy
        # redirect_to @customer

        @order = Order.find(params[:id])
        @order.destroy
        respond_to do |format|
            # format.html { redirect_to orders_url, notice: 'Order was successfully updated.' }  
            format.html { redirect_to request.referer, notice: 'Customer was successfully destroyed.' }

            format.json { head :no_content }
        end
    end    

    private
    
    def order_params
        params.require(:order).permit(:product_name, :product_count)
    end    

    # def set_customer
    #     @customer = Customer.find(params[:customer_id])
    # end

    # def set_order
    #     @order = Order.find(params[:id])
    # end

    def catch_not_found(e)
        Rails.logger.debug("We had a not found exception.")
        flash.alert = e.to_s
        redirect_to orders_path
    end 
end
