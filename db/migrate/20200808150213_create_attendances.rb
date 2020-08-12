class CreateAttendances < ActiveRecord::Migration[5.2]
  def change
    create_table :attendances do |t|
      t.string :stripe_customer_id

      t.timestamps
    end

    add_reference :attendances, :event, foreign_key: true
    add_reference :attendances, :attendee, foreign_key: { to_table: :users }
  end
end
