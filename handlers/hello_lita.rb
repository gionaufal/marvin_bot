module Lita
  module Handlers
    class HelloLita < Handler
      route(/say something/, :take_over_the_world,
            command: false,
            help: { "say something": "replies with Marvin classic quote" }
      )

      def take_over_the_world(response)
        response.reply(
          'Life! Dont talk to me about life!'
        )
      end

      Lita.register_handler(self)
    end
  end
end
