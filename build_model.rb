#!/usr/bin/env ruby

# Parse command line variables
input_data_file = ARGV[0]
output_path = ARGV[1]

# Initialize the model
hourly_models = {}.tap { |m| (0..23).each { |i| m[i] = {} } }

count = 0
tweet_data = File.open(input_data_file, 'r')
tweet_data.readline # read the first line, its junk
tweet_data.each_line do |line|
  splits = line.split("\t")
  time = Time.at(splits[0].to_i)
  lat = splits[4].to_f.round(1)
  lng = splits[5].to_f.round(1)
  model = hourly_models[Time.at(time).hour]
  key = [lat,lng]
  val = model[key]
  if val.nil?
    model[key] = 1
  else
    model[key] = val + 1
  end

  count +=1
  puts "Processed #{count}" if count % 500000 == 0
end


hourly_models.each_key { |m|
  output_file = "#{output_path}#{m}.model"
  File.open(output_file, "w+") { |file|
    hourly_models[m].each_pair { |k,v|
      file.write("#{k[0]},#{k[1]},#{v}\n")
    }
  } unless hourly_models[m].empty?
}
