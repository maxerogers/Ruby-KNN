# Step 1 calculate the Euclidean distance from the test vector from the training vectors
# Step 2 Sort the results and determine the min K neighbors
# Step 3 Print classification

puts "K-Nearest Neighbor"

class Neighbor
	attr_accessor :klass, :vector
	#can't use class since its a keyword
	def initialize(klass, vector)
		@klass = klass
		@vector = vector
	end
end

training_data = []
File.open('data.dat').each do |line|
	line = line.split(" ").collect{|i| i.to_f}
	training_data.push Neighbor.new(line.pop,line)
end

def euclidean_distance(x,y)
	sum = 0.0
	x.each_with_index do |xi, i|
		sum += (x[i] - y[i])**2
	end
	return Math.sqrt(sum)
end

test_point = [8,6]
results = {}
training_data.each do |x|
	results[x] = euclidean_distance(x.vector,test_point)
end

k = 3
puts "K: #{k}"
results = results.sort_by {|_key, value| value}
count = 1
classes = {}
results.each do |key,value|
	break if count > 3
	puts "#{key.klass} : #{value}"
	classes[key.klass] ||= 0
	classes[key.klass] = classes[key.klass] + 1
	count += 1
end

klass = ""
max = 0
classes.each do |c,v|
	if max < v
		max = v
		klass = c
	end
end

puts "It is a #{klass}"

puts ""