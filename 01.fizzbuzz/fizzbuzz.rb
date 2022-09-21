count = 0

while count <= 19 do
    count += 1
    if count % 15 == 0 
        puts "FizzBuzz"
    elsif count % 3 == 0
        puts "Fizz"
    elsif count % 5 == 0 
        puts "Buzz"
    else
        puts count
    end
end