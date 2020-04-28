class BestSeat < ApplicationRecord
    enum map_rows: {
    1 =>'A' ,
    2 =>'B' ,
    3 =>'C' ,
    4 =>'D' ,
    5 =>'E' ,
    6 =>'F' ,
    7 =>'G' ,
    8 =>'H' ,
    9 =>'I' ,
    10 =>'J' ,
    11 =>'K' ,
    12 =>'L' ,
    13 =>'M' ,
    14 =>'N' ,
    15 =>'O' ,
    16 =>'P' ,
    17 =>'Q' ,
    18 =>'R' ,
    19 =>'S' ,
    20 =>'T' ,
    21 =>'U' ,
    22 =>'V' ,
    23 =>'W' ,
    24 =>'X' ,
    25 =>'Y' ,
    26 =>'Z' ,
}
BestSeat::AVAILABLE = "AVAILABLE"
BestSeat::RESERVED = "RESERVED"
BestSeat::EXCEPTION_HANDLER = ""
BestSeat::STATUS = "status"
BestSeat::ROW_LIMIT_MAX = 26
BestSeat::CORRIDOR_PRIORITY = 1
BestSeat::EXCEPTION_PRIORITY = -1

    # method responsible for collect all available seats options received
    def available_seats(seats)
        arr = []
        seats.each do |key, value|
            #byebug
            if (seats[key][BestSeat::STATUS] == BestSeat::AVAILABLE)
                arr.push(key)
            end
            
        end
        return arr
    end

    def is_group_of_best_seats(best_seats_reference,available_seats,number,priority_value)
        priority = priority_value.nil? ? BestSeat::EXCEPTION_PRIORITY : priority_value
        seat_before = ''
        seat_after = ''
        # limit refer to number of seats requested
        limit = number.to_i
        result = []
        available_seats_sorted = available_seats.sort
        
        available_seats_sorted.each do |seat|
            # check if the best seats group contains such elements
                if best_seats_reference.has_value?(seat)
                    unless result.include?(seat)
                        if result.size < limit
                            result.push(seat)
                            
                        end
                    end
                    if BestSeat::CORRIDOR_PRIORITY != priority
                        # add seat right before if available
                        1.times do |i|
                            seat_before = seat[0] + ((seat[1,seat.size].to_i)-1).to_s
                            if  available_seats_sorted.include?(seat_before)
                                unless result.include?(seat_before)
                                    if result.size < limit
                                        result.push(seat_before)
                                        
                                    end
                                end
                            end
                        
                        end
                        
                        # add seat right next if available
                        1.times do |i|
                            seat_after = seat[0] + ((seat[1,seat.size].to_i)+1).to_s
                            if  available_seats_sorted.include?(seat_after)
                                unless result.include?(seat_after)
                                    if result.size < limit
                                        result.push(seat_after)
                                        
                                    end
                                end
                            end
                        end
                    end    
                end 
            
        end
       
        
        # this section check with another seats is closer than reference seats position, which are by corridor
        closer_to_ref=''
        aux = []
        best_seats_reference_parameter = best_seats_reference[1][1,best_seats_reference[1].size].to_i
        closer_to_ref_integer = best_seats_reference_parameter
        best_seats_reference.each do |key, value|
            available_seats.each do |seat|
                if best_seats_reference[key].include?(seat[0])
                    if (closer_to_ref_integer > (best_seats_reference_parameter - seat[1,seat.size].to_i).abs()) 
                        
                        aux.push(seat)
                        closer_to_ref = seat
                        closer_to_ref_integer = (best_seats_reference_parameter - seat[1,seat.size].to_i).abs()
                        
                        
                    end
                    
                end 
            end
        end
        while result.size < limit do
            unless result.include?(aux.last) && aux.size > 0
                if result.size < limit
                    result.push(aux.last)
                    aux.pop()
                    
                end
            end
        end
        
        return result.sort
    
    end


    def find_best_seats_for_unique_request(rows,columns)
        hash = {}
        position = 1 
        best_column = columns.fdiv(2).ceil
        
        Array(1..rows).each do |value| 
            1.times do |i|
                hash[position] = BestSeat.map_rows[value].downcase.concat(best_column.to_s)
                #add 1 in order to get second best
                best_column+=1 
            end
            position+=1
            1.times do |i|
                hash[position] = BestSeat.map_rows[value].downcase.concat(best_column.to_s)
                #minus 1 in order to get back to best column index
                best_column-=1 
            end
            position+=1
        end
        
       return hash
    end
end
