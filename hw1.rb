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

def euclidean_distance(x,y)
	sum = 0.0
	x.each_with_index do |xi, i|
		sum += (x[i] - y[i])**2
	end
	return Math.sqrt(sum)
end

def loadData(path)
	data = []
	File.open(path).each do |line|
		line = line.split(" ").collect{|i| i.to_f}
		data.push Neighbor.new(line.pop,line)
	end
	return data
end

def classify(x,ys,k)
	results = {}
	ys.each do |y|
		results[y] = euclidean_distance(x.vector,y.vector)
	end
	results = results.sort_by{|key,value| value}
	numbers = Array.new(10,0)
	count = 1
	results.each do |key,value|
		puts "#{key} : #{key.klass} : #{value}"
		numbers[key.klass.to_i] += 1
		count += 1
		break if count > k
	end
	puts "#{numbers.rindex(numbers.max).to_f}"
	numbers.rindex(numbers.max).to_f
end
k = 3
puts "K: #{k}"

klass = "A"
training_matrix = loadData("optdigits_tra.dat")
trail_matrix = loadData("optdigits_trial.dat")

correct = 0.0 #number correctly identified
trail_matrix.each do |x|
	correct += 1 if classify(x,training_matrix,k) == x.klass
end

#classify(training_matrix.last,training_matrix,k)

puts "Number correctly identified: #{correct}"
puts "Percentage correctly identified: #{correct/trail_matrix.size}"

