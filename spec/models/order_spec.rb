require 'rails_helper'

RSpec.describe Order, type: :model do
  subject { Order.new( product_name: "gears", product_count: 7, customer: FactoryBot.create(:customer))}
  
  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without a product_name" do
    subject.product_name=nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a product_count" do
    subject.product_count=nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a customer" do
    subject.customer=nil
    expect(subject).to_not be_valid
  end

  it "is not valid if the product_count is not all digits" do 
    subject.product_count='5g'
    expect(subject).to_not be_valid
  end

  #????????????????
  it "is valid if order's customer_id corresponds to a real customer" do 
    expect(subject.customer.id).to be(subject.customer_id)
    # expect(subject).to be_valid
  end
end
