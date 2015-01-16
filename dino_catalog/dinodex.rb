require "json"

class DinoDex
  def initialize(dinos)
    @dinos = dinos
  end

  def filter(title, value)
    filtered_dinos = []
    @dinos.each do |dino|
      dino_value = dino.send("#{title}")
      filtered_dinos << dino if (dino_value == value)
    end
    filtered_dinos
  end

  def to_json(*args)
    @dinos.to_json(*args)
  end
  
end
