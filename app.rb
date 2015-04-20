require 'sinatra'
require './lib/credit_card.rb'

class CreditCardAPI < Sinatra::Base
  get '/' do
  "CreditCardAPI is up and running. Try /api/v1/credit_card/validate"
  end

  get '/api/v1/credit_card/validate' do
    creditcard = CreditCard.new(params[:card_number], nil, nil, nil)
    {card: params[:card_number], validated: creditcard.validate_checksum}.to_json
  end
end
