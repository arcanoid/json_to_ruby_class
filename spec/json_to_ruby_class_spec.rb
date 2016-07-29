require 'spec_helper'

describe JsonToRubyClass do
  subject { JsonToRubyClass }

  describe ".produce_models" do
    context "Given a JSON without a type" do
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

    context "Given a JSON for Ruby" do
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

    context "Given a JSON for C#" do
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

      let(:result) { subject.produce_models(json, 'c#') }
      let(:expected_result) do
        <<-TEXT
public class Student
{
   public string firstName { get; set; }
   public string lastName { get; set; }
   public int age { get; set; }
}

public class Example
{
   public Student[] students { get; set; }
}

        TEXT
      end

      it 'defines the classes correctly' do
        expect(result).to eq(expected_result)
      end
    end
  end
end
