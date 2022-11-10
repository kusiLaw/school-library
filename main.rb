require './student'
require './classroom'



clasrom = Classroom.new('p5')
student = Student.new(12, clasrom, 'law')
clasrom.add_student(student)
p clasrom
