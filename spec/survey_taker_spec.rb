require 'spec_helper'

describe Survey_taker do
  it {should have_many :responses}
  it {should have_many :choices}
end
