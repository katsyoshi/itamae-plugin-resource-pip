require "spec_helper"

describe file("/.pip/lib/python3.5/site-packages/tornado") do
  it { should be_directory }
end

describe file("/.pip/lib/python3.5/site-packages/tornado-4.1.dist-info") do
  it { should be_directory }
end
