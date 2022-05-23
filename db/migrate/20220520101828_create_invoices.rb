class CreateInvoices < ActiveRecord::Migration[6.1]
  def change
    create_table :invoices do |t|
      t.string :to_full_name
      t.string :to_address
      t.string :to_email
      t.string :to_phone
      t.string :status
      t.decimal :discount
      t.decimal :vat
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
