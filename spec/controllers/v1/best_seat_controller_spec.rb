require 'rails_helper'
RSpec.describe Api::V1::BestSeatController do
  #for a venue with 10 rows and 12 columns with all seats open, the best seat would be A6
   describe "POST #index", :type => :request do
    before do
        post '/api/v1/track_best_seats', params: {"venue"=>{"layout"=>{"rows"=>10, "columns"=>12}}, "seats"=>{"a5"=>{"id"=>"a5", "row"=>"a", "column"=>5, "status"=>"AVAILABLE"}, "a4"=>{"id"=>"a4", "row"=>"a", "column"=>4, "status"=>"AVAILABLE"}, "a6"=>{"id"=>"a6", "row"=>"a", "column"=>6, "status"=>"AVAILABLE"}, "a3"=>{"id"=>"a3", "row"=>"a", "column"=>3, "status"=>"AVAILABLE"}, "a2"=>{"id"=>"a2", "row"=>"a", "column"=>2, "status"=>"AVAILABLE"}, "a1"=>{"id"=>"a1", "row"=>"a", "column"=>1, "status"=>"AVAILABLE"}, "a7"=>{"id"=>"a7", "row"=>"a", "column"=>7, "status"=>"AVAILABLE"}}}
    end
    
    it 'sets BestSeat::ROW_LIMIT_MAX' do
        expect(BestSeat::ROW_LIMIT_MAX).to eq(26)
    end
    it 'returns status code 200' do
        expect(response).to have_http_status(:success)
    end
    it "returns http success" do
      expect(response).to have_http_status(:success)
    end
    it "JSON body response contains expected best_seats attributes" do
      json_response = JSON.parse(response.body)
      expect(json_response.keys).to match_array(['suggestion'])
      expect(json_response['suggestion']).to match_array(["a6"])
    end

  end

  #best open group of seats together. for a venue with 10 rows and 12 columns, for 3 seats, it would be A5, A6, and A7.
  describe "POST #index", :type => :request do
    before do
        post '/api/v1/track_best_seats', params: {"venue"=>{"layout"=>{"rows"=>10, "columns"=>12}}, "number_of_seats"=>3, "seats"=>{"a5"=>{"id"=>"a5", "row"=>"a", "column"=>5, "status"=>"AVAILABLE"}, "a4"=>{"id"=>"a4", "row"=>"a", "column"=>4, "status"=>"AVAILABLE"}, "a6"=>{"id"=>"a6", "row"=>"a", "column"=>6, "status"=>"AVAILABLE"}, "a3"=>{"id"=>"a3", "row"=>"a", "column"=>3, "status"=>"AVAILABLE"}, "a2"=>{"id"=>"a2", "row"=>"a", "column"=>2, "status"=>"AVAILABLE"}, "a1"=>{"id"=>"a1", "row"=>"a", "column"=>1, "status"=>"AVAILABLE"}, "a7"=>{"id"=>"a7", "row"=>"a", "column"=>7, "status"=>"AVAILABLE"}}}
    end
    
    it 'sets BestSeat::ROW_LIMIT_MAX' do
        expect(BestSeat::ROW_LIMIT_MAX).to eq(26)
    end
    it 'returns status code 200' do
        expect(response).to have_http_status(:success)
    end
    it "returns http success" do
      expect(response).to have_http_status(:success)
    end
    it "JSON body response contains expected best_seats attributes" do
      json_response = JSON.parse(response.body)
      expect(json_response.keys).to match_array(['suggestion'])
      expect(json_response['suggestion']).to match_array(["a5", "a6", "a7"])
    end

  end
  #For 5 columns and 2 requested seats the best open seats - assuming the first row A is fully occupied and the second row B is fully open, would be B2 and B3.
  describe "POST #index", :type => :request do
  before do
      post '/api/v1/track_best_seats', params: {"venue"=>{"layout"=>{"rows"=>10, "columns"=>5}}, "number_of_seats"=>2, "seats"=>{"b5"=>{"id"=>"b5", "row"=>"b", "column"=>5, "status"=>"AVAILABLE"}, "b4"=>{"id"=>"b4", "row"=>"b", "column"=>4, "status"=>"AVAILABLE"}, "b3"=>{"id"=>"b3", "row"=>"b", "column"=>3, "status"=>"AVAILABLE"}, "b2"=>{"id"=>"b2", "row"=>"b", "column"=>2, "status"=>"AVAILABLE"}, "b1"=>{"id"=>"b1", "row"=>"b", "column"=>1, "status"=>"AVAILABLE"}}}
  end
  
  it 'sets BestSeat::ROW_LIMIT_MAX' do
      expect(BestSeat::ROW_LIMIT_MAX).to eq(26)
  end
  it 'returns status code 200' do
      expect(response).to have_http_status(:success)
  end
  it "returns http success" do
      expect(response).to have_http_status(:success)
  end
  it "JSON body response contains expected best_seats attributes" do
      json_response = JSON.parse(response.body)
      expect(json_response.keys).to match_array(['suggestion'])
      expect(json_response['suggestion']).to match_array(["b2", "b3"])
  end

  end

  describe "POST #index", :type => :request do
    before do
        post '/api/v1/track_best_seats', params: {"venue"=>{"layout"=>{"rows"=>27, "columns"=>12}}, "seats"=>{"a5"=>{"id"=>"a5", "row"=>"a", "column"=>5, "status"=>"AVAILABLE"}, "a4"=>{"id"=>"a4", "row"=>"a", "column"=>4, "status"=>"AVAILABLE"}, "a6"=>{"id"=>"a6", "row"=>"a", "column"=>6, "status"=>"AVAILABLE"}, "a3"=>{"id"=>"a3", "row"=>"a", "column"=>3, "status"=>"AVAILABLE"}, "a2"=>{"id"=>"a2", "row"=>"a", "column"=>2, "status"=>"AVAILABLE"}, "a1"=>{"id"=>"a1", "row"=>"a", "column"=>1, "status"=>"AVAILABLE"}, "a7"=>{"id"=>"a7", "row"=>"a", "column"=>7, "status"=>"AVAILABLE"}}}
    end
    
   
    it 'returns status code 200' do
        expect(response).to have_http_status(:success)
    end
    it "returns http success" do
      expect(response).to have_http_status(:success)
    end
    it "JSON body response contains expected best_seats attributes" do
      json_response = JSON.parse(response.body)
      expect(json_response.keys).to match_array(['error'])
    end
  end
end