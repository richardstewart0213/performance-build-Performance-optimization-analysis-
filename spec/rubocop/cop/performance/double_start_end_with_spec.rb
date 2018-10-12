# frozen_string_literal: true

require 'spec_helper'

describe RuboCop::Cop::Performance::DoubleStartEndWith do
  subject(:cop) { described_class.new(config) }

  before do
    inspect_source(cop, source)
  end

  context 'IncludeActiveSupportAliases: false' do
    let(:config) do
      RuboCop::Config.new(
        'Performance/DoubleStartEndWith' => {
          'IncludeActiveSupportAliases' => false
        }
      )
    end

    context 'two #start_with? calls' do
      context 'with the same receiver' do
        context 'all parameters of the second call are pure' do
          let(:source) { 'x.start_with?(a, b) || x.start_with?("c", D)' }

          it 'registers an offense' do
            expect(cop.offenses.size).to eq(1)
            expect(cop.offenses.first.message).to eq(
              'Use `x.start_with?(a, b, "c", D)` instead of ' \
              '`x.start_with?(a, b) || x.start_with?("c", D)`.'
            )
            expect(cop.highlights).to eq(
              ['x.start_with?(a, b) || x.start_with?("c", D)']
            )
          end
        end

        context 'one of the parameters of the second call is not pure' do
          let(:source) { 'x.start_with?(a, "b") || x.start_with?(C, d)' }

          it "doesn't register an offense" do
            expect(cop.offenses).to be_empty
          end
        end
      end

      context 'with different receivers' do
        let(:source) { 'x.start_with?("a") || y.start_with?("b")' }

        it "doesn't register an offense" do
          expect(cop.offenses).to be_empty
        end
      end
    end

    context 'two #end_with? calls' do
      context 'with the same receiver' do
        context 'all parameters of the second call are pure' do
          let(:source) { 'x.end_with?(a, b) || x.end_with?("c", D)' }

          it 'registers an offense' do
            expect(cop.offenses.size).to eq(1)
            expect(cop.offenses.first.message).to eq(
              'Use `x.end_with?(a, b, "c", D)` instead of ' \
              '`x.end_with?(a, b) || x.end_with?("c", D)`.'
            )
            expect(cop.highlights).to eq(
              ['x.end_with?(a, b) || x.end_with?("c", D)']
            )
          end
        end

        context 'one of the parameters of the second call is not pure' do
          let(:source) { 'x.end_with?(a, "b") || x.end_with?(C, d)' }

          it "doesn't register an offense" do
            expect(cop.offenses).to be_empty
          end
        end
      end

      context 'with different receivers' do
        let(:source) { 'x.end_with?("a") || y.end_with?("b")' }

        it "doesn't register an offense" do
          expect(cop.offenses).to be_empty
        end
      end
    end

    context 'a .start_with? and .end_with? call with the same receiver' do
      let(:source) { 'x.start_with?("a") || x.end_with?("b")' }

      it "doesn't register an offense" do
        expect(cop.offenses).to be_empty
      end
    end

    context 'two #starts_with? calls' do
      let(:source) { 'x.starts_with?(a, b) || x.starts_with?("c", D)' }

      it "doesn't register an offense" do
        expect(cop.offenses).to be_empty
      end
    end

    context 'two #ends_with? calls' do
      let(:source) { 'x.ends_with?(a, b) || x.ends_with?("c", D)' }

      it "doesn't register an offense" do
        expect(cop.offenses).to be_empty
      end
    end
  end

  context 'IncludeActiveSupportAliases: true' do
    let(:config) do
      RuboCop::Config.new(
        'Performance/DoubleStartEndWith' => {
          'IncludeActiveSupportAliases' => true
        }
      )
    end

    context 'two #start_with? calls' do
      context 'with the same receiver' do
        context 'all parameters of the second call are pure' do
          let(:source) { 'x.start_with?(a, b) || x.start_with?("c", D)' }

          it 'registers an offense' do
            expect(cop.offenses.size).to eq(1)
            expect(cop.offenses.first.message)
              .to eq('Use `x.start_with?(a, b, "c", D)` instead of ' \
            '`x.start_with?(a, b) || x.start_with?("c", D)`.')
            expect(cop.highlights)
              .to eq(['x.start_with?(a, b) || x.start_with?("c", D)'])
          end
        end
      end
    end

    context 'two #end_with? calls' do
      context 'with the same receiver' do
        context 'all parameters of the second call are pure' do
          let(:source) { 'x.end_with?(a, b) || x.end_with?("c", D)' }

          it 'registers an offense' do
            expect(cop.offenses.size).to eq(1)
            expect(cop.offenses.first.message)
              .to eq('Use `x.end_with?(a, b, "c", D)` instead of ' \
            '`x.end_with?(a, b) || x.end_with?("c", D)`.')
            expect(cop.highlights)
              .to eq(['x.end_with?(a, b) || x.end_with?("c", D)'])
          end
        end
      end
    end

    context 'two #starts_with? calls' do
      context 'with the same receiver' do
        context 'all parameters of the second call are pure' do
          let(:source) { 'x.starts_with?(a, b) || x.starts_with?("c", D)' }

          it 'registers an offense' do
            expect(cop.offenses.size).to eq(1)
            expect(cop.offenses.first.message).to eq(
              'Use `x.starts_with?(a, b, "c", D)` instead of ' \
              '`x.starts_with?(a, b) || x.starts_with?("c", D)`.'
            )
            expect(cop.highlights).to eq(
              ['x.starts_with?(a, b) || x.starts_with?("c", D)']
            )
          end
        end

        context 'one of the parameters of the second call is not pure' do
          let(:source) { 'x.starts_with?(a, "b") || x.starts_with?(C, d)' }

          it "doesn't register an offense" do
            expect(cop.offenses).to be_empty
          end
        end
      end

      context 'with different receivers' do
        let(:source) { 'x.starts_with?("a") || y.starts_with?("b")' }

        it "doesn't register an offense" do
          expect(cop.offenses).to be_empty
        end
      end
    end

    context 'two #ends_with? calls' do
      context 'with the same receiver' do
        context 'all parameters of the second call are pure' do
          let(:source) { 'x.ends_with?(a, b) || x.ends_with?("c", D)' }

          it 'registers an offense' do
            expect(cop.offenses.size).to eq(1)
            expect(cop.offenses.first.message).to eq(
              'Use `x.ends_with?(a, b, "c", D)` instead of ' \
              '`x.ends_with?(a, b) || x.ends_with?("c", D)`.'
            )
            expect(cop.highlights).to eq(
              ['x.ends_with?(a, b) || x.ends_with?("c", D)']
            )
          end
        end

        context 'one of the parameters of the second call is not pure' do
          let(:source) { 'x.ends_with?(a, "b") || x.ends_with?(C, d)' }

          it "doesn't register an offense" do
            expect(cop.offenses).to be_empty
          end
        end
      end

      context 'with different receivers' do
        let(:source) { 'x.ends_with?("a") || y.ends_with?("b")' }

        it "doesn't register an offense" do
          expect(cop.offenses).to be_empty
        end
      end
    end
  end
end
