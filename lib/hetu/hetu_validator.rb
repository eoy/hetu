require 'active_model/validator'

class HetuValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    
    # Create a new swedish personnummer from the value
    p = Personnummer.new(value)
    
    if Hetu.valid?(value) == true                 # Is a Finnish person
      return true
    elsif Hetu.valid?(value) == false && p.valid? # Is a Swedish person
      return true
    else                                          # Is invalid
      record.errors.add(attribute, :invalid)
    end
  end
end
