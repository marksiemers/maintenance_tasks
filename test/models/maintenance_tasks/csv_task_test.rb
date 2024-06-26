# frozen_string_literal: true

require "test_helper"

module MaintenanceTasks
  class CsvTaskTest < ActiveSupport::TestCase
    test ".collection creates a CSV from the csv_content string" do
      csv_file = file_fixture("sample.csv")

      csv_task = Maintenance::ImportPostsTask.new
      csv_task.csv_content = csv_file.read
      collection = csv_task.collection

      assert CSV, collection.class
      assert collection.headers

      first_row = collection.first
      assert_equal "My Title 1", first_row["title"]
      assert_equal "Hello World 1!", first_row["content"]
    end

    test ".collection passes options to the CSV parser" do
      csv_file = file_fixture("sample.csv")
      csv = csv_file.read
      csv.prepend("# Comment\n")
      csv.concat("# Another comment\n")

      csv_task = Maintenance::ImportPostsWithOptionsTask.new
      csv_task.csv_content = csv
      collection = csv_task.collection

      assert CSV, collection.class
      assert collection.headers

      all_rows = collection.to_a
      assert_equal 5, all_rows.count

      first_row = all_rows.first
      assert_equal "MY TITLE 1", first_row["title"]
      assert_equal "HELLO WORLD 1!", first_row["content"]
    end

    test ".count returns the number of rows to process, excluding headers and assuming a trailing newline" do
      csv_file = file_fixture("sample.csv")

      csv_task = Maintenance::ImportPostsTask.new
      csv_task.csv_content = csv_file.read
      assert_equal 5, csv_task.count
    end
  end
end
