class Display
    def display_main_menu
      puts "\n\nWeekly Payroll System"
      draw_line
      puts "1. Print all days"
      puts "2. Print specific day"
      puts "3. Edit system configurations"
      puts "4. Edit work day"
      puts "5. Exit program"
    end
  
    def display_weekly_summary(summary)
      puts "\n\n----------------------------------------"
      puts "Total salary for this week: #{summary[:week_total_daypay]} pesos"
      puts "Total dayshift hours worked: #{summary[:total_dayshift]} hours"
      puts "Total nightshift hours worked: #{summary[:total_nightshift]} hours"
      puts "Total dayshift overtime: #{summary[:total_day_OT]} hours"
      puts "Total nightshift overtime: #{summary[:total_night_OT]} hours"
      puts "----------------------------------------"
    end
  
    def display_all_days(workdays)
      workdays.each_with_index do |wd, index|
        display_day(index, wd)
      end
    end
  
    def display_day(index, workday)
      puts "\nWeekday #{index + 1}"
      puts "Daily Rate: #{workday.get_dailySalary}"
      if workday.get_timeIn == 2400
        puts "IN Time: 0000"
        puts "OUT Time: #{sprintf('%04d', workday.get_timeOut)}"
      elsif workday.get_timeOut == 2400
        puts "IN Time: #{sprintf('%04d', workday.get_timeIn)}"
        puts "OUT Time: 0000"
      else
        puts "IN Time: #{sprintf('%04d', workday.get_timeIn)}"
        puts "OUT Time: #{sprintf('%04d', workday.get_timeOut)}"
      end
      puts "Day shift work hours: #{workday.get_dayshift}"
      puts "Night shift work hours: #{workday.get_nightshift}"
      puts "Dayshift overtime: #{workday.get_overtime_day}"
      puts "Nightshift overtime: #{workday.get_overtime_night}"
      print_day_type(workday.get_dayType)
      puts "Salary of the day: #{workday.get_dayPay}"
      draw_line
    end
  
    def print_day_type(day_type)
      case day_type
      when 1 then puts "Day type: Normal day"
      when 2 then puts "Day type: Rest day"
      when 3 then puts "Day type: Regular Holiday"
      when 4 then puts "Day type: Special non working day"
      when 5 then puts "Day type: Rest day and Special non working day"
      when 6 then puts "Day type: Rest day and Regular Holiday"
      else puts "Day type: Unknown"
      end
    end
  
    def display_config_menu
      puts "\nSystem Configurations"
      puts "1. Change workday numbers"
      puts "2. Change max work hours per day"
      puts "3. Change daily salary"
      puts "4. Back to main menu"
    end
  
    def show_message(message)
      puts message
    end
  
    def draw_line
      puts "-----------------------------------------------"
    end
  end
  