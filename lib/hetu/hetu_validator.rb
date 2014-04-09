require 'active_model/validator'

class HetuValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if Hetu.valid?(value) == true # Is a Finnish person
      return true
    else
      begin 
        # Create a new swedish personnummer from the value
        p = Personnummer.new(value)
      rescue
        # Rescue from the attribute error
        record.errors.add(attribute, :invalid)
      end
      p.valid?
    end
  end
end
