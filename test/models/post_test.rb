# frozen_string_literal: true

require 'test_helper'

class PostTest < ActiveSupport::TestCase
  def setup
    @post = posts(:one)
    @post.category = categories(:one)
    @post.creator = users(:one)
  end

  test 'post valid' do
    assert @post.valid?
  end

  test 'category required' do
    @post.category = nil
    assert_not @post.valid?
  end

  test 'creator required' do
    @post.creator = nil
    assert_not @post.valid?
  end
end
