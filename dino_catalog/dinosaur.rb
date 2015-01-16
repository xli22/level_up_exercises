class Dinosaur
  attr_accessor :name,
                :period,
                :continent,
                :diet,
                :weight_in_lbs,
                :walking,
                :description

  def initialize(row)
    row.each do |title, value|
      instance_variable_set "@#{title}", value
    end
  end

  def to_hash
    dinosaur = {}
    instance_variables.each do |variable|
      dinosaur[variable.to_s.delete("@")] = instance_variable_get(variable)
    end
    dinosaur
  end

  def to_s
    to_hash.map do |title, value|
      "#{title}: #{value}"
    end.join("\n")
   end
    
end
