
crypt_file = 'encrypted.txt'
base = 'plain.txt'

#Placed text for both files into arrays.
encrypted = File.readlines(crypt_file)
plain = File.readlines(base)

#Deleted blank lines
encrypted.delete("\n")
plain.delete("\n")

#Broke base down into different works by looking for a start and end.
beggining = 1
ending = 1
base_sliced = []
for i in 0...plain.length
	if plain[i] == "by William Shakespeare\n"
		beggining=i-1 #To start at title
	end
	if plain[i] == "THE END\n"
		ending = i 
		base_sliced.push(plain[beggining..ending])
	end
end

#Assuming length of the encrypted array is close to the length of one of the base_sliced sub array lengths. Give or take 100 lines just in case.
possible_works = []
decrypted_work = []
for i in 0...base_sliced.length
	if base_sliced[i].length <= encrypted.length + 100 and base_sliced[i].length > encrypted.length - 100
		possible_works.push(base_sliced[i])
	end
	#narrowed down to one by comparing length of first two lines
	if possible_works.length > 1
		for work in possible_works
			if work.first.length == encrypted.first.length and work[3].length == encrypted[3].length
				decrypted_work = work
			end
		end
	elsif possible_works.length == 1
		decrypted_work = possible_works[0]
	end
end

#Created hash with alphabet, uppercase and lowercase.
cipher_key = {}
alphabet = ('A'..'Z').to_a
alphabet.each do |letter|
	cipher_key[letter] = 1
end

alphabet = ('a'..'z').to_a
alphabet.each do |letter|
	cipher_key[letter] = 1
end

# p decrypted_work[line][letter]
# p decrypted_work.first
# while cipher_key.has_value? 1
# 	if cipher_key.key? decrypted_work[line][letter]
# 		cipher_key[decrypted_work[line][letter]] = encrypted[line][letter]
# 	end
# 	line +=1
# 	letter +=1
# end

for string in 0...50
	p decrypted_work[string]
	for char in 0...decrypted_work[string].length
		if cipher_key.key?(decrypted_work[string][char])
			cipher_key[decrypted_work[string][char]] = encrypted[string][char]
		end
	end
end


p cipher_key

File.open("deciphered.txt", "w+") { |file| file.write(decrypted_work) }


  




