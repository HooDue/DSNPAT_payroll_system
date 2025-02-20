class SalaryCalculator
    # Aggregates the weekly salary and shift statistics.
    def calculate_weekly_summary(workdays)
      week_total_daypay = 0
      total_dayshift = 0
      total_nightshift = 0
      total_day_OT = 0
      total_night_OT = 0
  
      workdays.each do |wd|
        # Ensure each workday calculates its own values.
        wd.calculate_shift_time
        wd.calculate_Rate
        week_total_daypay += wd.get_dayPay
        total_dayshift += wd.get_dayshift
        total_nightshift += wd.get_nightshift
        total_day_OT += wd.get_overtime_day
        total_night_OT += wd.get_overtime_night
      end
  
      {
        week_total_daypay: week_total_daypay,
        total_dayshift: total_dayshift,
        total_nightshift: total_nightshift,
        total_day_OT: total_day_OT,
        total_night_OT: total_night_OT
      }
    end
  end
  