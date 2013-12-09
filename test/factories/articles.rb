# coding: utf-8

FactoryGirl.define do
  factory :article do
    sequence(:title) { |n| "記事#{n}" }
    body "笑 笑 笑！"
    released_at 2.weeks.ago
    expired_at 2.weeks.from_now
  end
end
