class Api::V1::BestSeatController < ApplicationController
    # for test and dev only
    ActionController::Parameters.permit_all_parameters = true
    before_action :check_row_limit,:set_venue,:set_seats
    
    def index
        @model = BestSeat.new
        draw_circuit_design
        best_seats_reference = @model.find_best_seats_for_unique_request(@rows,@columns)
        result = @model.is_group_of_best_seats(best_seats_reference,@available_seats,@number_of_seats,@priority)
        render json:{ suggestion: result}
    end


    #method responsible to map scenario, for this demo, its easier to visualize all steps this way
    def draw_circuit_design
        
        @rows = set_venue[:layout][:rows].to_i
        
        @columns = set_venue[:layout][:columns].to_i
        @available_seats =  @model.available_seats(@seats.to_hash)
        @number_of_seats = params[:number_of_seats].nil? ? 1 : params[:number_of_seats]
        @priority = params[:priority]
    end


    protected

    def check_row_limit
        
        if (set_venue[:layout][:rows].to_i > BestSeat::ROW_LIMIT_MAX)
            render json: {error:"Row limit exceeded."}
            #throw :abort
        end
    end

    def set_venue
        @venue = params[:venue]
    end

    def set_seats
        @seats = params[:seats]
    end

    
end
