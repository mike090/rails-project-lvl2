# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# fill categories
%w[music poetry painting photo cinema sculpture prose].each { |c| Category.create name: c } unless Category.any?
cntr = 0

# fill users
unless User.any?
  7.times do
    User.create email: Faker::Internet.email, password: 'password'
    cntr += 1
  end
  Rails.logger.debug { "#{cntr} users added..." }
end

# fill posts
unless Post.any?
  categories = Category.all.to_a
  users = User.all.to_a
  12.times do
    Post.create title: Faker::Lorem.sentence,
                body: Faker::Lorem.paragraph(sentence_count: 5),
                category: categories.sample,
                creator: users.sample
    cntr += 1
  end
  Rails.logger.debug { "#{cntr} posts added..." }
end

# fill post comments
unless PostComment.any?
  cntr = 0
  users = User.all.to_a
  posts = Post.all.sample(8)
  posts.each do |post|
    [*1..5].sample.times do
      post.comments.create! content: Faker::Lorem.paragraph(sentence_count: [*1..5].sample),
                            creator: users.sample
      cntr += 1
    end
  end
  Rails.logger.debug { "#{cntr} comments on posts added..." }
end

# add comments to comments
unless PostComment.where.not(ancestry: :nil).any?
  4.times do
    users = User.all.to_a
    sample_comments = PostComment.all.sample(PostComment.count / 3)
    cntr = 0
    sample_comments.each do |comment|
      comment.children.create post: comment.post, creator: users.sample, content: Faker::Lorem.paragraph(sentence_count: [*1..5].sample)
      cntr += 1
    end
  end
  Rails.logger.debug { "#{cntr} comments on comments added..." }
end

# add likes
unless PostLike.any?
  posts = Post.all
  posts_count = Post.count
  cntr = 0
  User.all.each do |user|
    posts = Post.all.sample(rand(posts_count + 1))
    posts.each do |post|
      PostLike.create!(post: post, user: user)
      cntr += 1
    rescue ActiveRecord::ActiveRecordError => e
      Rails.logger.debug e
    end
  end
  Rails.logger.debug { "#{cntr} times post liked..." }
end

Rails.logger.debug 'no changes added...' if cntr.zero?
