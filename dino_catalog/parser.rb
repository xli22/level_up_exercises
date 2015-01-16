require 'csv'
require_relative 'dinosaur'

class DinoParse
  attr_accessor :file_name, :dinos
  
  def initialize(file_name)
    @file_name = file_name
    @dinos = []
    convert_csv_file
  end

  def convert_csv_file
    CSV::Converters[:blank_to_nil] = lambda do |field|
      field && field.empty? ? nil : field
    end
    
    CSV.foreach(file_name, :headers => true, :header_converters => :symbol, :converters => [:all, :blank_to_nil]) do |row|
      @dinos << Dinosaur.new(format(row))
    end
  end
  
  def format(current_row)
    row = current_row.to_hash
    if row.has_key? :genus
      rename(:name, :genus,row)
      
      is_carnivore = row[:carnivore]
      rename(:diet, :carnivore, row)
      row[:diet]=diet_type(is_carnivore)
      
      weight = row[:weight]
      rename(:weight_in_lbs, :weight,row)
      row[:weight_in_lbs] = to_lbs(weight)
      
      row.merge!(continent: "Africa")
    end
    row
  end

  def rename(new_name, old_name, current_row)
    current_row[new_name] = current_row.delete old_name
  end

  def to_lbs(weight)
   (weight.to_f / 2.20462).to_i
  end
  
  def diet_type(is_carnivore)
    is_carnivore == "Yes" ? "Carnivore" : "Herbivore"
  end
end

