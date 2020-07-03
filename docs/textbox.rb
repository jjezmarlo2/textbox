def extra_symbol
 ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "!", "@", "#", "$"].sample
end

def file_include?(file, thing, first_boolean)
	filen = File.open(file, 'a+')
	file_read = filen.read
	file_array = file_read.split("\n")
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

def make_user_name(user_pw)
	return user_pw[0...-1]
end

def in_home(person, chat_doc)
  puts ""
  
  @user = make_user_name(person)
    

  @real_chat = chat_doc + '.txt'
  file = File.open(@real_chat,'a+')
  puts file.read

puts ""
puts ">>> "
@what_to_write = gets.chomp
file.close


if @what_to_write == "manage"
	chat_people = chat_doc + "_people.txt"
	if file_include?(chat_people, @user, true)
		puts ""
		puts "Would you like to add a person to your chat?:"
		add_or_not = gets.chomp
		if add_or_not == "yes"
			puts "Person to add: "
			person = gets.chomp
			add_someone(person, chat_people)
		end
		puts ""
		puts "Would you like to take away a person from your chat?: "
		sub_or_not = gets.chomp
		if sub_or_not == "yes"
			puts "Person to take away: "
			person = gets.chomp
			sub_someone(person, chat_people)
		end
		puts ""
		puts "Would you like to delete the current conversation?: "
		delete_or_not = gets.chomp
		if delete_or_not == "yes"
			file = File.open(@real_chat,'w')
			file.write
		end
	else
		puts ""
		puts "You are not authorized to manage this conversation. Please contact the creator of the chat."
	end
elsif @what_to_write == "see answers"
  file = File.open('replies.txt','a+')
  puts file.read
  ask_if_delete_reply
  file.close
elsif @what_to_write == "r"
  in_home(person, chat_doc)
elsif @what_to_write == "leave"
elsif @what_to_write == "quit"

else
  @real_chat = chat_doc + '.txt'
  file = File.open(@real_chat, 'a+')
  file.puts "#{@user}: #{@what_to_write}"
  file.close
  in_home(person, chat_doc)
end
end

@pws = []


def ask_if_delete_conversation
puts "                What chat would you like to see?"
puts ">>>"
what_chat = gets.chomp
actual_chat = what_chat + '.txt'

if what_chat == "none"
else
	puts "               Here is the current conversation: "
	puts ""
	file = File.open(actual_chat,'a+')
	puts file.read
	file.close
	puts ""
	puts "       Do you want to delete the current conversation?: "
	puts ">>>"
	conversation_gone = gets.chomp

	if conversation_gone == "yes"
		file = File.open(actual_chat,'w')
		file.write
	end
end
end

def open_how_to_use
	puts "Do not type the '.txt' part when it asks for the chat document."
	puts "To contact the manager, type 'contact manager' when you are in the chat."
	puts "Type 'r' to refresh."
end

puts ""
puts "                       Important Announcement!"
puts "   Now you have to be authorized to be part of a chat by the chat maker."
puts "      Please do not try to be part of a chat that doesn't include you."
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
puts '>>>'
new_or_not = gets.chomp

if new_or_not == "yes"
puts "                   What will your username be?: "
puts ">>>"
username = gets.chomp
password = username + extra_symbol
puts "Your password is \"#{password}\""
file = File.open('pw.txt','a+')
file.puts password
file.close
puts "Type the honor word 'yes' to say that you know your password: "
yes = gets.chomp
if yes == "yes"
end
elsif new_or_not == "no"
puts "                     What is your password?: "
puts ">>>"
supposed_password = gets.chomp

if supposed_password == "cookies.and.milk"
manager_is_in
end

if file_include?('PW.txt', supposed_password, false)

puts "            What chat would you like to go into?: "
puts ">>>"
chat_doc = gets.chomp
actual_doc = chat_doc + ".txt"
@you = make_user_name(supposed_password)

unless File.exist?(actual_doc)
	puts "Who would you like to be allowed in #{chat_doc}?"
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
in_home(supposed_password, chat_doc)
end
elsif new_or_not == "how to use"
	open_how_to_use
end
end
