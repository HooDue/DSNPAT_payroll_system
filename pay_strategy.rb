class PayStrategy
  def calculate(workday)
    raise NotImplementedError, 'Subclasses must implement the calculate method'
  end

  protected

  # If the workday is marked absent, then if it’s a rest day return daily_salary, otherwise 0.
  # Returns a numeric value if absence applies, or nil if calculation should continue.
  def check_absence(workday)
    if workday.absent?
      return workday.restday? ? workday.daily_salary : 0.0
    end
    nil
  end
end

# Strategy for a Normal Day (day type 0):
class NormalDayPayStrategy < PayStrategy
  def calculate(workday)
    absent_value = check_absence(workday)
    return absent_value unless absent_value.nil?

    if workday.timeIN < workday.timeOUT
      workday.daily_salary +
        ((workday.hourly_rate * 1.25) * workday.overTime_day) +
        ((workday.hourly_rate * 1.375) * workday.overTime_night)
    else
      workday.daily_salary +
        ((workday.hourly_rate * 1.10) * workday.nightshift_hours) +
        ((workday.hourly_rate * 1.375) * workday.overTime_night)
    end
  end
end

# Strategy for a Rest Day (day type 1):
class RestDayPayStrategy < PayStrategy
  def calculate(workday)
    absent_value = check_absence(workday)
    return absent_value unless absent_value.nil?

    pay_rate = workday.daily_salary * 1.3
    pay_rate +
      ((workday.hourly_rate * 1.69) * workday.overTime_day) +
      ((workday.hourly_rate * 1.859) * workday.overTime_night)
  end
end

# Strategy for a Regular Holiday (day type 2):
class RegularHolidayPayStrategy < PayStrategy
  def calculate(workday)
    absent_value = check_absence(workday)
    return absent_value unless absent_value.nil?

    pay_rate = workday.daily_salary * 2
    pay_rate +
      ((workday.hourly_rate * 2.6) * workday.overTime_day) +
      ((workday.hourly_rate * 2.86) * workday.overTime_night)
  end
end

# Strategy for a Special Non Working Day (day type 3):
class SpecialNonWorkingDayPayStrategy < PayStrategy
  def calculate(workday)
    absent_value = check_absence(workday)
    return absent_value unless absent_value.nil?

    pay_rate = workday.daily_salary * 1.3
    pay_rate +
      ((workday.hourly_rate * 1.69) * workday.overTime_day) +
      ((workday.hourly_rate * 1.859) * workday.overTime_night)
  end
end

# Strategy for a Rest Day and Special Non Working Day (day type 4):
class RestDayAndSpecialNonWorkingDayPayStrategy < PayStrategy
  def calculate(workday)
    absent_value = check_absence(workday)
    return absent_value unless absent_value.nil?

    pay_rate = workday.daily_salary * 1.5
    pay_rate +
      ((workday.hourly_rate * 1.95) * workday.overTime_day) +
      ((workday.hourly_rate * 2.145) * workday.overTime_night)
  end
end

# Strategy for a Regular Holiday that is also a Rest Day (day type 5):
class RegularHolidayRestDayPayStrategy < PayStrategy
  def calculate(workday)
    absent_value = check_absence(workday)
    return absent_value unless absent_value.nil?

    pay_rate = workday.daily_salary * 2.6
    pay_rate +
      ((workday.hourly_rate * 3.38) * workday.overTime_day) +
      ((workday.hourly_rate * 3.718) * workday.overTime_night)
  end
end
