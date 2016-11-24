require 'pp'

keys = ['edible','cap-shape','cap-surface','cap-color','bruises?','odor','gill-attachment','gill-spacing','gill-size','gill-color','stalk-shape','stalk-root','stalk-surface-above-ring','stalk-surface-below-ring','stalk-color-above-ring','stalk-color-below-ring','veil-type','veil-color','ring-number','ring-type','spore-print-color','population','habitat']
training_set = []

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

puts "Quantidade de cogumelos: #{training_set.length}"
flat_mushrooms = training_set.select do |feature|
  feature['cap-shape'] == 'FLAT'
end

pp flat_mushrooms.length

