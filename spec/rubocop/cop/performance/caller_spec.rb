# frozen_string_literal: true

describe RuboCop::Cop::Performance::Caller do
  subject(:cop) { described_class.new }

  it "doesn't register an offense when caller is called" do
    inspect_source(cop, 'caller')
    expect(cop.messages).to be_empty
  end

  it "doesn't register an offense when caller with arguments is called" do
    inspect_source(cop, 'caller(1..1).first')
    inspect_source(cop, 'caller(1, 1).first')
    expect(cop.messages).to be_empty
  end

  it 'registers an offense when :first is called on caller' do
    expect_offense(<<-RUBY.strip_indent)
      caller.first
             ^^^^^ Use `caller(n..n)` instead of `caller[n]`.
    RUBY
  end

  it 'registers an offense when :first is called on caller with 1' do
    expect_offense(<<-RUBY.strip_indent)
      caller(1).first
                ^^^^^ Use `caller(n..n)` instead of `caller[n]`.
    RUBY
  end

  it 'registers an offense when :first is called on caller with 2' do
    expect_offense(<<-RUBY.strip_indent)
      caller(2).first
                ^^^^^ Use `caller(n..n)` instead of `caller[n]`.
    RUBY
  end

  it 'registers an offense when :[] is called on caller' do
    expect_offense(<<-RUBY.strip_indent)
      caller[1]
            ^^^ Use `caller(n..n)` instead of `caller[n]`.
    RUBY
  end

  it 'registers an offense when :[] is called on caller with 1' do
    expect_offense(<<-RUBY.strip_indent)
      caller(1)[1]
               ^^^ Use `caller(n..n)` instead of `caller[n]`.
    RUBY
  end

  it 'registers an offense when :[] is called on caller with 2' do
    expect_offense(<<-RUBY.strip_indent)
      caller(2)[1]
               ^^^ Use `caller(n..n)` instead of `caller[n]`.
    RUBY
  end
end
