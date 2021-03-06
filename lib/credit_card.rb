require_relative './luhn_validator.rb'
require 'json'
require 'openssl'

# Class CreditCard
class CreditCard
  # TODO: mixin the LuhnValidator using an 'include' statement
  include LuhnValidator
  # instance variables with automatic getter/setter methods
  attr_accessor :number, :expiration_date, :owner, :credit_network
  def initialize(number, expiration_date, owner, credit_network)
    # TODO: initialize the instance variables listed above (do not forget the '@')
    @number = number
    @expiration_date = expiration_date
    @owner = owner
    @credit_network = credit_network
  end
  # returns json string
  def to_json
    # TODO: setup the hash with all instance vairables to serialize into json
    { number: number, expiration_date: expiration_date, owner: owner, credit_network: credit_network }.to_json
  end
  # returns all card information as single string
  def self.to_s
    return "#{@number}, #{@expiration_date}, #{@owner}, #{@credit_network}"
  end

  # return a new CreditCard object given a serialized (JSON) representation
  def self.from_s(card_s)
    # TODO: deserializing a CreditCard object
    parsed = JSON.parse(card_s)
    new(parsed['number'], parsed['expiration_date'], parsed['owner'], parsed['credit_network'])
  end
  # return a hash of the serialized credit card object
  def hash
    # TODO: Produce a hash (using default hash method) of the credit card's
    #       serialized contents.
    #       Credit cards with identical information should produce the same hash.
    to_s.hash
  end
  # return a cryptographically secure hash
  def hash_secure
    # TODO: Use sha256 from openssl to create a cryptographically secure hash.
    #       Credit cards with identical information should produce the same hash.
    sha256 = OpenSSL::Digest::SHA256.new
    sha256.digest(to_s).unpack('H*')
  end
end
