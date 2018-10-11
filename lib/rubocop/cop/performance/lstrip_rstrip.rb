# encoding: utf-8

module RuboCop
  module Cop
    module Performance
      # This cop identifies places where `lstrip.rstrip` can be replaced by
      # `strip`.
      #
      # @example
      #   @bad
      #   'abc'.lstrip.rstrip
      #   'abc'.rstrip.lstrip
      #
      #   @good
      #   'abc'.strip
      class LstripRstrip < Cop
        MSG = 'Use `strip` instead of `%s.%s`.'

        def_node_matcher :lstrip_rstrip, <<-END
          {(send $(send _ $:rstrip) $:lstrip)
           (send $(send _ $:lstrip) $:rstrip)}
        END

        def on_send(node)
          lstrip_rstrip(node) do |first_send, method_one, method_two|
            range = Parser::Source::Range.new(node.loc.expression.source_buffer,
                                              first_send.loc.selector.begin_pos,
                                              node.loc.expression.end_pos)
            add_offense(node, range, format(MSG, method_one, method_two))
          end
        end

        def autocorrect(node)
          first_send, = *node
          range = Parser::Source::Range.new(node.loc.expression.source_buffer,
                                            first_send.loc.selector.begin_pos,
                                            node.loc.expression.end_pos)
          ->(corrector) { corrector.replace(range, 'strip') }
        end
      end
    end
  end
end
