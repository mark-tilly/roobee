require 'fileutils'
mode = "r+"
counter = 0

puts "Welcome to the Word Finder!"   # user greeting

puts "Please enter the complete filepath of the file you wish to search!"  # instructions to user
fileName = gets.chomp                          # accept user input, remove newline at end
gotIt = File.file?(fileName)                   # verify file exists

puts "Please enter the size of the word you are searching for EX: 4 will return a word greater than 3 chars in length"  #prompt user for string length
longish = gets.chomp                           # accept user input, remove newline at end
longish1 = Integer(longish)                    # gets returns string - convert to int

puts "Please enter the number of occurence for this word EX 2"  # instructions to user
occurence = gets.chomp                         # accept user input, remove newline at end
occurence1 = Integer(occurence)                # gets returns string - convert to int
  

if gotIt == false
  puts "That file cannot be located. Please check the spelling and be sure to include the file extension."
else file = File.open(fileName, mode).each do |line|  # open file and for each line
  arr = line.chomp                                    # put line in array
  word = arr.split(" ")                               # split array into words
  word.each do |word|                                 # for each word
    if word.size > longish1                           # check size of word
      counter += 1                                    # increment counter    
	  if counter == occurence1                        # when counter = user specification
	    puts word                                     # display the word
	    break                                         # goodnight, drive carefully
	  file.close                                      # close the file
      end
    end
  end
end
end


