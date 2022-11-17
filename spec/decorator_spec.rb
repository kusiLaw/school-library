require_relative '../decorator'
require_relative '../person'

describe BaseDecorator do
  decorator = BaseDecorator.new('maximilianus')
  context 'Instance of Decorator could be created:' do
    it 'Should be an instance of Decorator' do
      expect(decorator).to be_an_instance_of BaseDecorator
    end
  end
  context 'When passed a name:' do
    it 'Nameable attribute should match nameable argument' do
      expect(decorator.nameable).to eq 'maximilianus'
    end
  end
end

describe CapitalizeDecorator do
  person = Person.new(22, 'maximilianus')
  capitalize_decorator = CapitalizeDecorator.new(person)
  context 'Instance of CapitalizeDecorator could be created' do
    it 'Should be an instance of CapitalizeDecorator' do
      expect(capitalize_decorator).to be_an_instance_of CapitalizeDecorator
    end
  end
  context 'When passed a name:' do
    it 'Name should be capitalized' do
      expect(capitalize_decorator.correct_name).to eq 'Maximilianus'
    end
  end
end

describe TrimmerDecorator do
  person = Person.new(22, 'Maximilianus')
  trimmer_decorator = TrimmerDecorator.new(person)
  context 'Instance of TrimmerDecorator could be created:' do
    it 'Should be an instance of TrimmerDecorator' do
      expect(trimmer_decorator).to be_an_instance_of TrimmerDecorator
    end
  end
  context 'When passed a name:' do
    it 'Instance name should be capitalized and trimmed to 10 characters' do
      expect(trimmer_decorator.correct_name).to eq 'Maximilian'
    end
  end
end
