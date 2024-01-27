require 'rails_helper'

RSpec.describe ErrorSerializer do
  describe '#serialize_json' do
    it 'serializes the error object correctly' do
      error_object = ErrorMessage.new('Not Found', 404)
      serializer = ErrorSerializer.new(error_object)

      expected_result = {
        error: "Not Found",
        status: 404
      }

      expect(serializer.serialize_json).to eq(expected_result)
    end

    it 'serializes a 401 Unauthorized error' do
      error_object = ErrorMessage.new('Unauthorized Access', 401)
      serializer = ErrorSerializer.new(error_object)

      expected_result = {
        error: "Unauthorized Access",
        status: 401
      }

      expect(serializer.serialize_json).to eq(expected_result)
    end

    it 'serializes a 500 Internal Server Error' do
      error_object = ErrorMessage.new('Internal Server Error', 500)
      serializer = ErrorSerializer.new(error_object)

      expected_result = {
        error: "Internal Server Error",
        status: 500
      }

      expect(serializer.serialize_json).to eq(expected_result)
    end
  end
end