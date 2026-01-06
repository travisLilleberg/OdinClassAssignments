# frozen_string_literal: true

def contains?(hash, search_value)
  hash.each_value do |val|
    return true if val == search_value || (val.instance_of?(Hash) && contains?(val, search_value))
  end
  false
end
