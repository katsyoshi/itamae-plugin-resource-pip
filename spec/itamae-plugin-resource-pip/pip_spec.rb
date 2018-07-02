require "spec_helper"

describe file("/.pip/lib/python3.6/site-packages/tornado") do
  it { should be_directory }
end

describe file("/.pip/lib/python3.6/site-packages/tornado-4.1-py3.6.egg-info") do
  it { should be_directory }
end
