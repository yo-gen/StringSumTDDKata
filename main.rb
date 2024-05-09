def sum_number_string(number_string)
  return 0 if number_string.empty?

  delimiter = ','
  delimiters_str = ''

  if number_string.start_with?('//')
    delimiters_str = number_string.split("\n")[0][2..-1]
    delimiters = delimiters_str.scan(/\[(.*?)\]/).flatten
    
    delimiter = delimiters_str if delimiters.empty?

    number_string = number_string.split("\n")[1]
    delimiters.each { |d| number_string.gsub!("#{d}", delimiter) }
  else
    number_string.gsub!("\n", delimiter)
  end

  number_string.split(delimiter).map(&:to_i).each do |num|
    raise ArgumentError, "Negative numbers not allowed: #{number_string.scan(/-\d+/).join(', ')}" if num.negative?
  end

  number_string.split(delimiter).map(&:to_i).reject { |num| num > 1000 }.sum
end
