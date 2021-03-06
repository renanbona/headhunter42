class Ability
  include CanCan::Ability

  def initialize(user)
    can :manage, :all if user.admin?
    cannot :manage, Company unless user.admin?
    can :read, :all if user.reviewer?
  end

end
