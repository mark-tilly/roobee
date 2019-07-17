mode = "r+"
counter = 0 


file = File.open('C:\\Users\\rmtil\Documents\\macbeth.txt', mode).each do |line|
  arr = line.chomp              # place line of text in array, remove newline char
  word = arr.split (" ")        # divide line into words
  word.each do |word|           # check each word for size
    if word.size > 4 then       # word more than x chars?
	  counter += 1              # increment counter
	  if counter == 3           # when we find the second word larger than 4 chars
        puts word	            # write the word to the screen and bail 
        break
      file.close 	            # close the file 		
	  end
	end
  end
end

