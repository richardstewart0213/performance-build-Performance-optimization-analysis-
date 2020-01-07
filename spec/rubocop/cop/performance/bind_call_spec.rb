# frozen_string_literal: true

RSpec.describe RuboCop::Cop::Performance::BindCall, :config do
  subject(:cop) { described_class.new(config) }

  context 'TargetRubyVersion <= 2.6', :ruby26 do
    it 'does not register an offense when using `bind(obj).call(args, ...)`' do
      expect_no_offenses(<<~RUBY)
        umethod.bind(obj).call(foo, bar)
      RUBY
    end
  end

  context 'TargetRubyVersion >= 2.7', :ruby27 do
    it 'registers an offense when using `bind(obj).call(args, ...)`' do
      expect_offense(<<~RUBY)
        umethod.bind(obj).call(foo, bar)
                ^^^^^^^^^^^^^^^^^^^^^^^^ Use `bind_call(obj, foo, bar)` instead of `bind(obj).call(foo, bar)`.
      RUBY

      expect_correction(<<~RUBY)
        umethod.bind_call(obj, foo, bar)
      RUBY
    end

    it 'registers an offense when using `bind(obj).()`' do
      expect_offense(<<~RUBY)
        umethod.bind(obj).()
                ^^^^^^^^^^^^ Use `bind_call(obj)` instead of `bind(obj).call()`.
      RUBY

      expect_correction(<<~RUBY)
        umethod.bind_call(obj)
      RUBY
    end

    it 'registers an offense when the argument of `bind` method is a string' do
      expect_offense(<<~RUBY)
        umethod.bind('obj').call(foo, bar)
                ^^^^^^^^^^^^^^^^^^^^^^^^^^ Use `bind_call('obj', foo, bar)` instead of `bind('obj').call(foo, bar)`.
      RUBY

      expect_correction(<<~RUBY)
        umethod.bind_call('obj', foo, bar)
      RUBY
    end

    it 'registers an offense when a argument of `call` method is a string' do
      expect_offense(<<~RUBY)
        umethod.bind(obj).call('foo', bar)
                ^^^^^^^^^^^^^^^^^^^^^^^^^^ Use `bind_call(obj, 'foo', bar)` instead of `bind(obj).call('foo', bar)`.
      RUBY

      expect_correction(<<~RUBY)
        umethod.bind_call(obj, 'foo', bar)
      RUBY
    end

    it 'does not register an offense when using `bind_call(obj, args, ...)`' do
      expect_no_offenses(<<~RUBY)
        umethod.bind_call(obj, foo, bar)
      RUBY
    end
  end
end
