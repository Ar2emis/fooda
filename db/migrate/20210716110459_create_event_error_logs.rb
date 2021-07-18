class CreateEventErrorLogs < ActiveRecord::Migration[6.1]
  def change
    create_table :event_error_logs do |t|
      t.json :data, null: false
      t.json :event_errors, null: false

      t.timestamps
    end
  end
end
