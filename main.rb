=begin
Last name: Hong
Language: Ruby
Paradigm(s): OOP, Functional, Procedural
=end


require_relative 'payroll_system'

system1 = PayrollSystem.new(WorkdayConfig::DEFAULT_WORKDAYS)
system1.run

