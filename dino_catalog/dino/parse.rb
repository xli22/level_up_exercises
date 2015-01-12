require 'csv'
class DinoParse
  attr_accessor :dinos
  
  def initialize(file_name)
    @file_name = file_name
    @dinos = []
    convert_csv_file(file_name)
  end

  def convert_csv_file(file_name)
    CSV::Converters[:blank_to_nil] = lambda do |field|
      field && field.empty? ? nil : field
    end
    CSV.foreach(file_name, :headers => true, :header_converters => :symbol, :converters => [:all, :blank_to_nil]) do |row|
      @dinos << format(row)
    end
 #   puts @dinos
  end

  def format(row)
    current_row = row.to_hash
    current_row.delete_if{ |key, value| value == nil }
    if current_row.has_key?(:genus)
      current_row[:name]  = current_row.delete :genus
      current_row.merge!(continent: "Africa")
    end

    if current_row.has_key?(:carnivore)
      is_carnivore = current_row[:carnivore]
      current_row[:diet] = current_row.delete :carnivore
      current_row[:diet] = is_carnivore == "Yes" ? "Carnivore" : "Herbivore"
    end

    if current_row.has_key?(:weight)
      old_weight = current_row[:weight].to_f
      new_weight = old_weight/2.2046
      current_row[:weight] = (new_weight).to_i
      current_row[:weight_in_lbs] = current_row.delete :weight
    end

   
    
    current_row
  end

end

#DinoParse.new('african_dinosaur_export.csv')
