require "hetu/version"
require "hetu/hetu_validator" if defined? ActiveModel

class Hetu

  def self.valid?(pin)
    new(pin).valid?
  end

	def initialize(pin)
		@pin = pin
	end

	def valid?
		valid_format? and valid_checksum? and valid_person_number?
	end

	def date_of_birth
		@pin[0..5]
	end

	def century_sign
		@pin[6]
	end

	def person_number
		@pin[7..9]
	end

	def gender
		["female", "male"][person_number.to_i % 2]
	end

	def male?
		gender == "male"
	end

	def female?
		gender == "female"
	end

	def checksum
		@pin[10]
	end

	def valid_format?
		!!(@pin =~ /^\d{6}[-+A]\d{3}[0-9A-Z]$/)
	end

	def valid_checksum?
		compute_checksum == checksum
	end

	def valid_person_number?
		(2..899).cover?(person_number.to_i)
	end

	def to_s
		@pin
	end

	private

	def compute_checksum
		"0123456789ABCDEFHJKLMNPRSTUVWXY"[ (date_of_birth + person_number).to_i % 31 ]
	end

end