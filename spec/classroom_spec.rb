require_relative '../book'
require_relative '../classroom'
require_relative '../teacher'
require_relative '../student'
require_relative '../rentals'

describe Classroom do
  context 'Classroom could be created:' do
    it 'Created classroom created should be an instance of Book' do
      classroom = Classroom.new('Software Dev')
      expect(classroom).to be_an_instance_of Classroom
    end
  end

  context 'When label used to create a classroom instance:' do
    classroom = Classroom.new('Frontend')
    it 'Classroom label should reflect label argument' do
      expect(classroom.label).to eq 'Frontend'
    end

    it 'Classroom method "#add_student" should be used to add student' do
      classroom.add_student(Student.new(classroom, 20, 'Maximilianus', true))
      expect(classroom.students.length).to eq 1
    end
  end

  context 'When students are on added to classroom:' do
    classroom = Classroom.new('Frontend')
    it 'Students count should be zero(0) on initialization' do
      expect(classroom.students.length).to eq 0
    end

    it 'Addition of student to classroom should be possible' do
      student = Student.new(classroom, 20, 'Maximilianus', true)
      student.assign_classroom = (classroom)
      expect(classroom.students.length).to eq 1
    end

    it 'Should permit addition multiple different student' do
      student_a = Student.new(classroom, 17, 'Zeus', true)
      student_b = Student.new(classroom, 13, 'Venus', false)
      student_a.assign_classroom = (classroom)
      student_b.assign_classroom = (classroom)
      expect(classroom.students.length).to eq 3
    end
  end
end
