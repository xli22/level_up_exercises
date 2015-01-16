require_relative "dinodex"
require_relative "collection"

class Controller
  attr_accessor :all_dinos
  def initialize
    @all_dinos = DinoCollection.new
    @all_dinos.add_from_csv("dinodex.csv")
    @all_dinos.add_from_csv("african_dinosaur_export.csv")
    print_results
  end

  def print_results
   puts "\nTotal dinosaurs: "
   puts @all_dinos.dinosaurs.to_s
   puts @all_dinos.dinosaurs.to_json
   dinodex = DinoDex.new(@all_dinos.dinosaurs)
   puts "\nAfter filtering walking:"
   puts dinodex.filter(:walking, "Biped").to_s
   puts dinodex.filter(:walking, "Biped").to_json
   puts "\nAfter filtering diet:"
   puts dinodex.filter(:diet, "Carnivore").to_s
   puts dinodex.filter(:diet, "Carnivore").to_json
  end
end

Controller.new
