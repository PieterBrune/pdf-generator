class Invoice < ApplicationRecord
  belongs_to :user
  has_many :invoice_items, dependent: :destroy
  accepts_nested_attributes_for :invoice_items, reject_if: proc { |attributes| attributes["name"].blank? || attributes["description"].blank? || attributes["price"].blank? || attributes["qty"].blank? }

  STATUSES = ["draft", "sent", "paid"]

  STATUS_CLASS = {
      :draft => "badge badge-secondary",
      :sent => "badge badge-primary",
      :paid => "badge badge-success"
  }

  def subtotal
    self.invoice_items.map { |item| item.qty * item.price }.sum
  end

  def discount_calculated
    subtotal * (self.discount / 100.0)
  end

  def vat_calculated
    (subtotal - discount_calculated) * (self.vat / 100.0)
  end

  def total
    subtotal - discount_calculated + vat_calculated
  end

  def status_class
    STATUS_CLASS[self.status.to_sym]
  end
end
