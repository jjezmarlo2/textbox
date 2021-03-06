require 'colorize'
def make_user_name(user_pw)
	return user_pw[0...-1]
end
def extra_symbol
 ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "!", "@", "#", "$"].sample
end

def find_colors(person)
	file = File.open('PW.txt', 'a+')
	file_read = file.read
	file_array = file_read.split(" ")
	i = 0
	file_array.each do |password|
		username = make_user_name(password)
		if username == person
			@pw_index = i
		end
		i+=1
	end
	file.close
	file = File.open('colors.txt', 'a+')
	file_read = file.read
	file_array = file_read.split("\n")
	colors = file_array[@pw_index]
	color_array = colors.split(" ")
	return color_array
end

def file_include?(file, thing, first_boolean)
	filen = File.open(file, 'a+')
	file_read = filen.read
	file_array = file_read.split(" ")
	if first_boolean == true
		if file_array[0] == thing
			return true
		else
			return false
		end
	else
		if file_array.include?(thing)
			return true
		else
			return false
		end
	end
	filen.close
end

def add_someone(person, doc)
	puts "#{person} added."
	file = File.open(doc, 'a+')
	file.puts person
	file.close
end
def sub_someone(person, doc)
	file = File.open(doc, 'a+')
	file_read = file.read
	file_array = file_read.split("\n")
	puts file_array
	puts ""
	person_idx = file_array.find_index(person)
	file_array.delete_at(person_idx)
	puts file_array
	file.close
	file = File.open(doc, 'w')
	file_array.each do |person_left|
		file.puts person_left
	end
	
	puts "#{person} subtracted."
	file.close
end



def in_home(person, chat_doc, colors_array)
  text_color = colors_array[0].to_sym
  back_color = colors_array[1].to_sym
  puts ""
  
  @user = make_user_name(person)
    

  @real_chat = chat_doc + '.txt'
  file = File.open(@real_chat,'a+')
  file.each do |line|
	line_splitted = line.split(" ")
	line = make_user_name(line)
	if line_splitted[0] == @user + ":"
		puts line.colorize(:color => text_color, :background => back_color)
		puts ""
	else
		other_user = line_splitted[0]
		other_user = make_user_name(other_user)
		colors_for_other = find_colors(other_user)
		textcolor = colors_for_other[0].to_sym
		backcolor = colors_for_other[1].to_sym
		puts line.colorize(:color => textcolor, :background => backcolor)
		puts ""
	end
	end
 # puts file.read

puts ""
print ">>> "
@what_to_write = gets.chomp
file.close


if @what_to_write == "manage"
	chat_people = chat_doc + "_people.txt"
	if file_include?(chat_people, @user, true)
		puts ""
		print "Would you like to add a person to your chat?: "
		add_or_not = gets.chomp
		if add_or_not == "yes"
			puts ""
			print "Person to add: "
			person = gets.chomp
			add_someone(person, chat_people)
		end
		puts ""
		print "Would you like to take away a person from your chat?: "
		sub_or_not = gets.chomp
		if sub_or_not == "yes"
			puts "Person to take away: "
			person = gets.chomp
			sub_someone(person, chat_people)
		end
		puts ""
		print "Would you like to delete the current conversation?: "
		delete_or_not = gets.chomp
		if delete_or_not == "yes"
			file = File.open(@real_chat,'w')
			file.write ""
		end
	else
		puts ""
		puts "You are not authorized to manage this conversation. Please contact the creator of the chat."
	end
elsif @what_to_write == "r"
  in_home(person, chat_doc)
elsif @what_to_write == "leave"
elsif @what_to_write == "quit"
elsif @what_to_write == "change colors"
	new_file_array = []
	puts ""
	print "What color would you like your text to be?: "
	textcolor = gets.chomp
	puts ""
	print "What background color would you like your text to have?: "
	backgroundcolor = gets.chomp
	puts ""
	file = File.open('PW.txt', 'a+')
		file_read = file.read
		file_array = file_read.split(" ")
		@user_index = file_array.index(person)
	file.close
	file = File.open("colors.txt", 'a+')
		file_read = file.read
		file_array = file_read.split("\n")
		user_colors = file_array[@user_index]
		i = 0
		file_array.each do |color_set|
			if i == @user_index
				new_colors = "#{textcolor} #{backgroundcolor}"
				new_file_array.push(new_colors)
			else
				new_file_array.push(color_set)
			end
			i+=1
		end
	file.close
	file = File.open('colors.txt', 'w')
		new_file_array.each do |color_set|
			file.puts color_set
		end
	file.close
elsif @what_to_write == "available colors"
	puts String.colors
else
  @real_chat = chat_doc + '.txt'
  file = File.open(@real_chat, 'a+')
  file.puts "#{@user}: #{@what_to_write}"
  file.close
  in_home(person, chat_doc, colors_array)
end
end

@pws = []


def open_how_to_use
	puts "Do not type the '.txt' part when it asks for the chat document."
	puts "To contact the manager, type 'contact manager' when you are in the chat."
	puts "Type 'r' to refresh."
end

puts ""
puts "---------------------------------------------------------------------"
puts "|                                                                   |"
puts "|                        Welcome to Textbox!                        |"
puts "|              Password login managed by Bronze Password.           |"
puts "|                                                                   |"
puts "---------------------------------------------------------------------"
puts ""
puts "                      Are you new? Yes or no: "
puts ""
print '>>> '
new_or_not = gets.chomp

if new_or_not == "yes"
puts ""
puts "                   What will your username be?: "
puts ""
print ">>> "
username = gets.chomp
password = username + extra_symbol
puts "Your password is \"#{password}\""
file = File.open('pw.txt','a+')
file.puts password
file.close
puts ""
print "What color would you like your text to be?: "
textcolor = gets.chomp
puts ""
print "What background color would you like your text to have?: "
backgroundcolor = gets.chomp
puts ""
file = File.open("colors.txt", 'a+')
	file.puts textcolor + " " + backgroundcolor
file.close

elsif new_or_not == "no"
puts ""
puts "                     What is your password?: "
puts ""
print ">>> "
supposed_password = gets.chomp

if supposed_password == "cookies.and.milk"
manager_is_in
end
if file_include?("PW.txt", supposed_password, "false")
filepw = File.open('PW.txt', 'a+')
	file_read = filepw.read
	file_array = file_read.split(" ")
	file_array.each do |pw|
		if pw == supposed_password
			@pw_index = file_array.index(pw)
		end
	end
filepw.close

file = File.open('colors.txt', 'a+')
file_read = file.read
file_split = file_read.split("\n")
this_colors = file_split[@pw_index]
colors = this_colors.split(" ")
this_colors = colors
	
puts ""
puts "               What chat would you like to go into?: "
puts ""
print ">>> "
chat_doc = gets.chomp
actual_doc = chat_doc + ".txt"
@you = make_user_name(supposed_password)

unless File.exist?(actual_doc)
	puts ""
	puts "      Who would you like to be allowed in #{chat_doc}?"
	puts ""
	person = "random_guy"
	i=0
	make_file_name = chat_doc + "_people.txt"
	file = File.open(make_file_name, 'a+')
	file.puts @you
	until person === "done"
		puts ""
		person = gets.chomp
		unless person === "done"
			file.puts person
		end
	end
	file.close
end
chat_people_name = chat_doc + "_people.txt"
@chat_people_doc = File.open(chat_people_name, 'a+')
unless file_include?(@chat_people_doc, @you, false)
	puts "You are not authorized to be part of this conversation."
else
puts ""
puts "                 --------------------------"
puts "                |        You're in!        |"
puts "                |    Welcome to the chat!  |"
puts "                 --------------------------"
puts ""
in_home(supposed_password, chat_doc, this_colors)
end
end
elsif new_or_not == "version"
	puts ""
	puts "Textbox 3.0"
end
