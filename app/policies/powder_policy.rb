class PowderPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end
  end

  def index?
    true
  end

  def show?
    true
  end

  def create?
    true
  end

  def new?
    create?
  end

  def update?
    true
  end

  def edit?
    update?
  end

  def destroy?
    true
  end

  def import
    true
  end

  def export
    true
  end

  def import_powder
    true
  end

  def export_powder
    true
  end

  class Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    # def resolve
    #   raise NotImplementedError, "You must define #resolve in #{self.class}"
    # end

    private

    attr_reader :user, :scope
  end
end
