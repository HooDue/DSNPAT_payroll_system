module WorkdayConfig
  TIME_IN = 900
  TIME_OUT = 900
  DAILY_SALARY = 500
  MAX_WORK_HOURS = 8
  DEFAULT_WORKDAYS = 5
  TOTAL_WORKDAYS = 8 #EXTRA 1 FOR 1 BASED INDEXING
end

module WorkdayType
  NORMAL = 1
  REST = 2
  REG_HOLIDAY = 3
  SPECIAL_NW = 4
  REST_N_NW = 5
  REST_N_REGHOLIDAY = 6
end

require_relative 'workday'
require_relative 'salary_calculator'
require_relative 'display'
require_relative 'input_handler'

class PayrollSystem
  attr_accessor :workdays, :num_workdays

  def initialize(num_workdays = WorkdayConfig::DEFAULT_WORKDAYS)
    @num_workdays = num_workdays
    #for 1 based indexing days initialized to 8
    @workdays = Array.new(WorkdayConfig::TOTAL_WORKDAYS)
    init_days

    # Instantiate our helper classes.
    @input_handler = InputHandler.new
    @display = Display.new
    @salary_calculator = SalaryCalculator.new
  end

  # Initialize the workdays for the week.
  # For the first @num_workdays we create normal workdays; the remaining days become rest days.
  def init_days
    (1..@num_workdays).each do |i|
      @workdays[i] = Workday.new(WorkdayType::NORMAL, WorkdayConfig::TIME_IN, WorkdayConfig::TIME_OUT, WorkdayConfig::DAILY_SALARY, WorkdayConfig::MAX_WORK_HOURS)
      @workdays[i].define_dayType(WorkdayType::NORMAL)
    end

    ((@num_workdays + 1)..7).each do |i|
      @workdays[i] = Workday.new(WorkdayType::REST, WorkdayConfig::TIME_IN, WorkdayConfig::TIME_OUT, WorkdayConfig::DAILY_SALARY, WorkdayConfig::MAX_WORK_HOURS)
      @workdays[i].define_dayType(WorkdayType::REST)
    end
  end

  # Main program loop.
  def run
    loop do
      @display.display_main_menu
      choice = @input_handler.get_main_menu_choice
      case choice
      when 1
        print_all_days
      when 2
        print_specific_day
      when 3
        edit_config
      when 4
        edit_day
      when 5
        exit_program
      else
        @display.show_message("Invalid choice. Please try again.")
      end
    end
  end

  def print_all_days
    # For days with a rest day type and if time in equals time out, we assume a default day pay.
    (1..7).each do |i|
      wd = @workdays[i]
      if wd.get_dayType == WorkdayType::NORMAL && wd.get_timeIn == wd.get_timeOut
        wd.set_dayPay(WorkdayConfig::DAILY_SALARY)
      end
    end

    # Let SalaryCalculator gather weekly figures.
    weekly_summary = @salary_calculator.calculate_weekly_summary(@workdays[1..7])
    @display.display_weekly_summary(weekly_summary)
    @display.display_all_days(@workdays[1..7])
  end

  def print_specific_day
    day_num = @input_handler.get_day_number("Enter day number to print (1-7): ")
    # index = day_num - 1
    @display.display_day(day_num, @workdays[day_num-1])
  end

  def edit_day
    day_num = @input_handler.get_day_number("Enter day number to edit (1-7): ")
    # index = day_num - 1

    new_time_in = @input_handler.get_time_input("Enter time in (in military time, e.g., 0900): ")
    new_time_out = @input_handler.get_time_input("Enter time out (in military time, e.g., 1700): ")

    @workdays[day_num].set_timeIn(new_time_in)
    @workdays[day_num].set_timeOut(new_time_out)

    new_day_type = @input_handler.get_day_type("Enter new day type:")
    @workdays[day_num].set_dayType(new_day_type)
    @workdays[day_num].define_dayType(new_day_type)
    @workdays[day_num].calculate_shift_time
    @workdays[day_num].calculate_Rate

    @display.show_message("Edit successful. New day info:")
    @display.display_day(day_num-1, @workdays[day_num])
  end

  def edit_config
    loop do
      @display.display_config_menu
      config_choice = @input_handler.get_config_menu_choice
      case config_choice
      when 1
        change_workday_number
      when 2
        change_max_work_hours
      when 3
        change_daily_salary
      when 4
        break
      else
        @display.show_message("Invalid choice. Please try again.")
      end
    end
  end

  def change_workday_number
    new_num = @input_handler.get_integer_input("Enter new number of workdays (1-7): ", 1..7)
    @num_workdays = new_num
    init_days
    @display.show_message("Workday number updated successfully.")
  end

  def change_max_work_hours
    new_max = @input_handler.get_integer_input("Enter new max work hours per day: ", 1..24)
    @workdays.each { |wd| wd.set_maxWorkHours(new_max) }
    @display.show_message("Max work hours updated successfully.")
  end

  def change_daily_salary
    new_salary = @input_handler.get_integer_input("Enter new daily salary: ", 1..10000)
    @workdays.each { |wd| wd.set_dailySalary(new_salary) }
    @display.show_message("Daily salary updated successfully.")
  end

  def exit_program
    @display.show_message("Exiting program. Goodbye!")
    exit
  end
end
