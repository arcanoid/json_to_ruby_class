require 'spec_helper'

describe JsonToRubyClass do
  subject { JsonToRubyClass }

  describe ".produce_models" do
    context "Given a JSON" do
      let(:json) do
        <<-JSON
          {
            "students": [
              {
                "firstName": "Json",
                "lastName": "Doe",
                "age": 15
              },
              {
                "firstName": "Anna",
                "lastName": "Smith",
                "age": 22
              }
            ]
          }
        JSON
      end
      
      before do
        str_class = subject.produce_models(json)
        eval(str_class)
      end

      it 'defines the classes correctly' do
        example = Example.new
        student = Student.new

        expect(example).to respond_to(:students)
        expect(student).to respond_to(:age)
        expect(student).to respond_to(:first_name)
        expect(student).to respond_to(:last_name)
      end
    end
  end
end
