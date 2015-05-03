require 'test/unit'
require_relative '../lib/factory_boy'

class User
end

class TestFactoryBoy < Test::Unit::TestCase
  def setup
    FactoryBoy.define do
      factory :user do
        name "test"
        cat "meow"
      end
    end
    @user = FactoryBoy.build :user
  end

  def test_creates_user
    assert_equal @user.class, User
  end

  def test_has_name
    assert_equal @user.name, "test"
  end
  
  def test_meow
    assert_equal @user.cat, "meow"
  end
end
