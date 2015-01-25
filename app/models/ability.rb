class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user
    
    can :read, Report
    can :create, Report
    can :update, Report, user_id: user.id
    can :destroy, Report, user_id: user.id
  end
end
