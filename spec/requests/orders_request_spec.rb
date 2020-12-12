require 'rails_helper'

RSpec.describe "OrdersControllers", type: :request do
    describe "get order_path" do
        it "renders the index view" do 
            FactoryBot.create(:customer) do |customer|
                FactoryBot.create_list(:order, 10, customer: customer)
            end
            get orders_path
            expect(response.status).to eq(200)
        end
      end

      describe "get order_path" do
        it "renders the :show template" do
            FactoryBot.create(:customer) do |customer|
                order = FactoryBot.create(:order, customer: customer)
                get order_path(id: order.id)
            end
            expect(response.status).to eq(200)
        end
 
        
        it "redirects to the index path if the order id is invalid" do
            get order_path(id: 5000) #an ID that doesn't exist
            expect(response).to redirect_to orders_path
        end
    end

    describe "get new_order_path" do
        it "renders the :new template" do
            get new_order_path
            expect(response.status).to eq(200)
        end
    end

    describe "get edit_order_path" do
        it "renders the :edit template" do
            FactoryBot.create(:customer) do |customer|
                order = FactoryBot.create(:order, customer: customer)
                get edit_order_path(id: order.id)
            end            
            expect(response.status).to eq(200)
        end
    end

    # ??????????????????????????
    # describe "post orders_path with valid data" do
    #     it "saves a new entry and redirects to the show path for the entry" do
    #         FactoryBot.create(:customer) do |customer|
    #             # order_attributes = FactoryBot.attributes_for(:order, customer: customer)
    #             order = FactoryBot.create(:order, customer: customer)
    #             expect { post orders_path, params: {order: order}}.to change(Order, :count)
    #         end 
            
    #         expect(response).to redirect_to order_path(id: Order.last.id)
    #     end
    # end
    
end
