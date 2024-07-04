require 'net/http'
require 'json'

class OrdersController < ApplicationController
  def index
    @order = Order.new
  end

  def show
    @order = Order.find(params[:id])
  end
  
  def create
    @order = Order.new(order_params)

    uri = URI("https://api-v2.distancematrix.ai/maps/api/distancematrix/json?origins=#{@order.departurepoint}&destinations=#{@order.destinationpoint}&key=h2LqIoEyIKH1yjHe9gwJYXnVzPhTvWxZSRtGbPmFQsKliZShc6Frvt95lDeXtufr")
    hash1 = JSON.parse(Net::HTTP.get_response(uri).body)

    distance = hash1['rows'][0]['elements'][0]['distance']['value'] / 1000

    @order.distance = distance

    if @order.height < 100 || @order.length < 100 || @order.width < 100
      @order.price = distance * 1
    elsif (@order.height >= 100 || @order.length >= 100 || @order.width >= 100) && @order.weight <= 10
      @order.price = distance * 2
    else 
      @order.price = distance * 3
    end

    if @order.save
      redirect_to @order
    else
      render :new, status: :unprocessable_entity
    end
    
  end

  private
  def order_params
    params.require(:order).permit(:fullname, :phonenumber, :emailadress, :weight, :length, :width, :height, :departurepoint, :destinationpoint)
  end

end