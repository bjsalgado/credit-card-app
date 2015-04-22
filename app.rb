require 'sinatra'
require './model/credit_card.rb'
require 'json'

class CreditCardAPI < Sinatra::Base
  get '/' do
  "CreditCardAPI is up and running. Try /api/v1/credit_card/validate"
  end

  get '/api/v1/credit_card/validate' do
    creditcard = CreditCard.new(params[:card_number], nil, nil, nil)
    {card: params[:card_number], validated: creditcard.validate_checksum}.to_json
  end
 
  post '/api/v1/credit_card' do
    request_json = request.body.read
    begin
      unless request_json.empty? 
        req = JSON.parse(request_json)
      end
      cc = CreditCard.new(:number => req['number'],
                          :expiration_date => req['expiration_date'],
                          :owner => req ['owner'], 
                          :credit_network => req['credit_network'])
      halt 400 if !cc.validate_checksum 
      cc.save
      halt 201, 'status 201'
    rescue
      halt 410, 'Check parameters'
    end
  end
  
  get '/index' do
    begin
      cards = CreditCard.all
      halt 200, cards.to_json
    rescue
      halt 500
    end
  end   
end
