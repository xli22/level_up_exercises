require_relative 'parser'

class DinoCollection
  attr_accessor :dinosaurs

  def initialize
    @dinosaurs = []
  end

  def add_from_csv(file_name)
   dino_parse = DinoParse.new(file_name)
   dino_parse.dinos.each{|dino| @dinosaurs << dino}
  end
end
