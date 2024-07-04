require 'net/http'
require 'json'


class DistanceMatrix

puts "Enter the parameters of the transported cargo."

puts "Weight (kg)"
weight = gets.chomp.to_i

puts "Lenght (cm)"
lenght = gets.chomp.to_i

puts "Width (cm)"
width = gets.chomp.to_i

puts "Height (cm)"
height = gets.chomp.to_i

puts "Enter the name of the departure point:"
POname = gets.chomp

puts "Enter the name of the destination point:"
PNname = gets.chomp

uri = URI("https://api-v2.distancematrix.ai/maps/api/distancematrix/json?origins=#{POname}&destinations=#{PNname}&key=h2LqIoEyIKH1yjHe9gwJYXnVzPhTvWxZSRtGbPmFQsKliZShc6Frvt95lDeXtufr")
hash1 = JSON.parse(Net::HTTP.get_response(uri).body)

distance = hash1['rows'][0]['elements'][0]['distance']['value'] / 1000

puts "The distance between the points: #{distance} km"

if height < 100 || lenght < 100 || width < 100
	price = distance * 1
elsif (height >= 100 || lenght >= 100 || width >= 100) && weight <= 10
	price = distance * 2
else 
	price = distance * 3
end

puts "Price: #{price} rub"

resultHash = Hash["weight" => weight, "lenght" => lenght, "width" => width, "height" => height, "distance" => distance, "price" => price]

puts "The end result:"
puts resultHash

end