class Report < ActiveRecord::Base
  
  validates :name, :query, presence: true
  validates :name, length: {in: 5...255}
  
  belongs_to :user
  
  before_validation :perform, :if => :query_changed?
  
  
  def perform!
    perform
    save!
    results
  end
  
  
  def columns
    super.map { |column| column.is_a?(String) ? { name: column, type: "general" } : column }
  end
  
  
private
  
  def perform
    start = Time.now
    results = Log.connection.select_all(query)
    
    self.performed_at = Time.now
    self.results = results.to_hash
    self.columns = results.column_types.map { |name, type| { name: name, type: identify_type(type, name) } }
    self.query_time = (self.performed_at - start) * 1000
  rescue ActiveRecord::StatementInvalid
    errors.add :query, $!.message
  end
  
  def identify_type(type, name)
    case type
    when ActiveRecord::Type::Text, ActiveRecord::Type::String then "text"
    when ActiveRecord::Type::Boolean then "boolean"
    when ActiveRecord::ConnectionAdapters::PostgreSQL::OID::Integer then "integer"
    when ActiveRecord::ConnectionAdapters::PostgreSQL::OID::Decimal
      return "percent" if name =~ /Percent/i
      "decimal"
    else
      if Rails.env.development?
        binding.pry
      else
        Rails.logger.warn "\e[33mUnrecognized type: #{type.inspect}"
      end
      "general"
    end
  end
  
end
