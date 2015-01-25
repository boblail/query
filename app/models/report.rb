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
  
  
private
  
  def perform
    start = Time.now
    results = Log.connection.select_all(query)
    
    self.performed_at = Time.now
    self.results = results.to_hash
    self.columns = results.columns
    self.query_time = (self.performed_at - start) * 1000
  rescue ActiveRecord::StatementInvalid
    errors.add :query, $!.message
  end
  
end
