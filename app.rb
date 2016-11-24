require 'pp'

keys = ['edible','cap-shape','cap-surface','cap-color','bruises?','odor','gill-attachment','gill-spacing','gill-size','gill-color','stalk-shape','stalk-root','stalk-surface-above-ring','stalk-surface-below-ring','stalk-color-above-ring','stalk-color-below-ring','veil-type','veil-color','ring-number','ring-type','spore-print-color','population','habitat']

training_set = []
results = {}

File.readlines('expanded').each do |line|
  attributes = line.gsub(/\n/, '').split(',')

  if attributes.length < 23
    next
  end

  mushroom = {}

  attributes.each_with_index do |attribute, index|
    mushroom[keys[index]] = attribute
  end

  training_set.push(mushroom)
end

# poison_mushrooms = training_set.select do |feature|
#   feature['edible'] == 'POISONOUS'
# end

keys.each do |key|
  next if key == 'edible'

  types = training_set.uniq{|x| x[key]}.map{|i| i[key]}

  pp key
  pp types
end



cap_shape_flat_count = training_set.count{|f| f['cap-shape'] == "FLAT" }.to_f

cap_shape_count = training_set.count{|f| f['cap-shape'] == "FLAT" && f['edible'] == 'POISONOUS'}.to_f / cap_shape_flat_count * 100

pp cap_shape_count
