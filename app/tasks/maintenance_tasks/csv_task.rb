# frozen_string_literal: true

require 'csv'

module MaintenanceTasks
  # Base class that is inherited by the host application's Task classes for
  # processing CSV files.
  class CsvTask < Task
    # TODO: specify abstract_class

    EnumeratorBuilder = Struct.new(:collection) do
      def enumerator(context:)
        JobIteration::CsvEnumerator.new(collection).rows(cursor: context.cursor)
      end
    end

    # The contents of a CSV file to be processed by a Task.
    #
    # @return [String] the content of the CSV file to process.
    attr_accessor :csv_content

    def enumerator_builder(context:)
      EnumeratorBuilder.new(collection)
    end

    # The number of rows to be processed. Excludes the header row from the count
    # and assumed a trailing new line in the CSV file. Note that this number is
    # an approximation based on the number of new lines.
    #
    # @return [Integer] the approximate number of rows to process.
    def count
      csv_content.count("\n") - 1
    end

    private

    # Defines the collection to be iterated over, based on the provided CSV.
    #
    # @return [CSV] the CSV object constructed from the specified CSV content,
    #   with headers.
    def collection
      CSV.new(csv_content, headers: true)
    end
  end
end
