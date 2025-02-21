class PayStrategy
  def calculate(workday)
    raise NotImplementedError, 'Subclasses must implement the calculate method'
  end
end

class RegularPay < PayStrategy
  def calculate(workday)
    workday.daily_salary + ((workday.hourly_rate * 1.25) * workday.overTime_day) + ((workday.hourly_rate * 1.375) * workday.overTime_night)
  end
end

class HolidayPay < PayStrategy
  def calculate(workday)
    workday.daily_salary * 2
  end
end

class RestDayPay < PayStrategy
  def calculate(workday)
    workday.daily_salary * 1.3
  end
end

class Workday
  attr_accessor :pay_strategy, :daily_salary, :hourly_rate, :overTime_day, :overTime_night

  def initialize(pay_strategy, daily_salary, hourly_rate, overTime_day, overTime_night)
    @pay_strategy = pay_strategy
    @daily_salary = daily_salary
    @hourly_rate = hourly_rate
    @overTime_day = overTime_day
    @overTime_night = overTime_night
  end

  def calculate_rate
    @pay_strategy.calculate(self)
  end
end

# Example usage:
# workday = Workday.new(RegularPay.new, 1000, 100, 2, 3)
# puts workday.calculate_rate