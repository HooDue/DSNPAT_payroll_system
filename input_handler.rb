class InputHandler
    # Gets the user’s main menu choice and validates it.
    def get_main_menu_choice
      print "Enter your choice: "
      # input = gets
      # if input.nil?
      #   exit
      # else
      input = gets&.chomp
      input ? validate_integer(input) : exit
    end
  
    # Gets the configuration menu choice.
    def get_config_menu_choice
      print "Enter your choice: "
      input = gets.chomp
      validate_integer(input)
    end
  
    # General method to get an integer input within an optional valid range.
    def get_integer_input(prompt, valid_range = nil)
      loop do
        print prompt
        input = gets.chomp
        num = validate_integer(input)
        if valid_range && !valid_range.include?(num)
          puts "Input must be within #{valid_range}. Please try again."
        else
          return num
        end
      end
    end
  
    # Gets a day number (between 1 and 7).
    def get_day_number(prompt)
      get_integer_input(prompt, 1..7)
    end
  
    # Gets a valid military time (e.g., 0900 or 1700).
    def get_time_input(prompt)
      loop do
        print prompt
        input = gets.chomp
        if valid_time?(input)
          return input.to_i
        else
          puts "Invalid time format. Please enter a valid military time (e.g., 0900, 1700)."
        end
      end
    end
  
    # Gets a valid day type (1 through 6) from the user.
    def get_day_type(prompt)
      loop do
        puts prompt
        puts "[1] Normal day"
        puts "[2] Rest day"
        puts "[3] Regular Holiday"
        puts "[4] Special non working day"
        puts "[5] Rest day and Special non working day"
        puts "[6] Rest day and Regular Holiday"
        print "Enter your choice: "
        input = gets.chomp
        num = validate_integer(input)
        if (1..6).include?(num)
          return num
        else
          puts "Invalid day type. Please choose a value between 0 and 5."
        end
      end
    end
  
    private
  
    # Attempts to convert input to an integer; returns -1 if conversion fails.
    def validate_integer(input)
      Integer(input) rescue -1
    end
  
    # Validates a military time string. It must be 3–4 digits and the hour/minute parts must be within valid ranges.
    def valid_time?(input)
      return false unless input =~ /^\d{3,4}$/
      time = input.to_i
      hour = time / 100
      minute = time % 100
      return false if hour < 0 || hour > 24
      return false if minute < 0 || minute >= 60
      true
    end
  end
  