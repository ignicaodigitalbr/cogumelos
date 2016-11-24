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

types_attr = []

keys.each do |key|
  next if key == 'edible'

  types = training_set.uniq{|x| x[key]}.map{|i| i[key]}
  key_count = 0

  types.each do |type|
    type_attrs = training_set.select{|f| f[key] == type }
    percent = type_attrs.count{|f| f['edible'] == 'POISONOUS'}.to_f / type_attrs.count.to_f * 100

    if percent > 70 && type_attrs.count > 100
      pp " -> Cogumelos com #{key} igual a #{type} tem #{percent.round(2)}% de cogumelos venenosos de #{type_attrs.count}"
      key_count = key_count + type_attrs.count
    end
  end
  if (key_count > 0)
    pp "#{key} tem #{key_count} casos"
  end
end
