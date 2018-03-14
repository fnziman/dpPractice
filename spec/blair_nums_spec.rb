require 'rspec'
require 'practice'
require 'rspec-benchmark'

describe 'Blair Numbers' do
  include RSpec::Benchmark::Matchers
  let(:dp) { DynamicProgramming.new() }

  it 'handles base cases' do
    expect(dp.blair_numbers(1)).to equal(1)
    expect(dp.blair_numbers(2)).to equal(2)
  end

  it 'handles recursive cases' do
    expect(dp.blair_numbers(6)).to equal(48)
    expect(dp.blair_numbers(100)).to eq(2782118076579236997325)
  end

  it 'runs in non-exponential time' do
    expect { dp.blair_numbers(1000) }.to perform_under(100).ms
  end
end