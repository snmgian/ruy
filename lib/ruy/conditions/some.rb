module Ruy
  module Conditions

    # Iterates over an Enumerable evaluating that some value matches the set of sub-conditions.
    class Some < CompoundCondition
      attr_reader :attr

      # @param attr Context attribute's name
      def initialize(attr)
        super
        @attr = attr
      end

      def call(ctx)
        enumerable = ctx.resolve(@attr)

        enumerable.any? do |context|
          ctx = Ruy::Context.new(context)

          Ruy::Utils::Rules.evaluate_conditions(conditions, ctx)
        end
      end

      def ==(o)
        o.kind_of?(Some) &&
          attr == o.attr &&
          conditions == o.conditions
      end
    end
  end
end