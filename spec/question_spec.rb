require 'spec_helper'

describe Question do
  it { should belong_to :survey }
  it { should have_many :choices }
  it { should have_many :responses }
  it { should validate_presence_of :description }

  it { should validate_presence_of :choices}
end
