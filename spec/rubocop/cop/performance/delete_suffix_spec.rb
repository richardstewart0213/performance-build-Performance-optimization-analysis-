# frozen_string_literal: true

RSpec.describe RuboCop::Cop::Performance::DeleteSuffix, :config do
  subject(:cop) { described_class.new(config) }

  context 'TargetRubyVersion <= 2.4', :ruby24 do
    it "does not register an offense when using `gsub(/suffix\z/, '')`" do
      expect_no_offenses(<<~RUBY)
        str.gsub(/suffix\\z/, '')
      RUBY
    end

    it "does not register an offense when using `gsub!(/suffix\z/, '')`" do
      expect_no_offenses(<<~RUBY)
        str.gsub!(/suffix\\z/, '')
      RUBY
    end
  end

  context 'TargetRubyVersion >= 2.5', :ruby25 do
    context 'when using `\z` as ending pattern' do
      it "registers an offense and corrects when `gsub(/suffix\z/, '')`" do
        expect_offense(<<~RUBY)
          str.gsub(/suffix\\z/, '')
              ^^^^ Use `delete_suffix` instead of `gsub`.
        RUBY

        expect_correction(<<~RUBY)
          str.delete_suffix('suffix')
        RUBY
      end

      it "registers an offense and corrects when `gsub!(/suffix\z/, '')`" do
        expect_offense(<<~RUBY)
          str.gsub!(/suffix\\z/, '')
              ^^^^^ Use `delete_suffix!` instead of `gsub!`.
        RUBY

        expect_correction(<<~RUBY)
          str.delete_suffix!('suffix')
        RUBY
      end
    end

    context 'when using `$` as ending pattern' do
      it 'registers an offense and corrects when using `gsub`' do
        expect_offense(<<~RUBY)
          str.gsub(/suffix$/, '')
              ^^^^ Use `delete_suffix` instead of `gsub`.
        RUBY

        expect_correction(<<~RUBY)
          str.delete_suffix('suffix')
        RUBY
      end

      it 'registers an offense and corrects when using `gsub!`' do
        expect_offense(<<~RUBY)
          str.gsub!(/suffix$/, '')
              ^^^^^ Use `delete_suffix!` instead of `gsub!`.
        RUBY

        expect_correction(<<~RUBY)
          str.delete_suffix!('suffix')
        RUBY
      end
    end

    context 'when using non-ending pattern' do
      it 'does not register an offense when using `gsub`' do
        expect_no_offenses(<<~RUBY)
          str.gsub(/pattern/, '')
        RUBY
      end

      it 'does not register an offense when using `gsub!`' do
        expect_no_offenses(<<~RUBY)
          str.gsub!(/pattern/, '')
        RUBY
      end
    end

    context 'with starting pattern `\A` and ending pattern `\z`' do
      it 'does not register an offense and corrects when using `gsub`' do
        expect_no_offenses(<<~RUBY)
          str.gsub(/\\Asuffix\\z/, '')
        RUBY
      end

      it 'does not register an offense and corrects when using `gsub!`' do
        expect_no_offenses(<<~RUBY)
          str.gsub!(/\\Asuffix\\z/, '')
        RUBY
      end
    end

    context 'when using a non-blank string as replacement string' do
      it 'does not register an offense and corrects when using `gsub`' do
        expect_no_offenses(<<~RUBY)
          str.gsub(/suffix\\z/, 'foo')
        RUBY
      end

      it 'does not register an offense and corrects when using `gsub!`' do
        expect_no_offenses(<<~RUBY)
          str.gsub!(/suffix\\z/, 'foo')
        RUBY
      end
    end

    it 'does not register an offense when using `delete_suffix`' do
      expect_no_offenses(<<~RUBY)
        str.delete_suffix('suffix')
      RUBY
    end

    it 'does not register an offense when using `delete_suffix!`' do
      expect_no_offenses(<<~RUBY)
        str.delete_suffix!('suffix')
      RUBY
    end
  end
end
