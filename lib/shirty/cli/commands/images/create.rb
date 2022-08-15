require 'dry/cli'

module Shirty
  module Cli
    module Commands
      module Images
        extend Dry::CLI::Registry

        class Create < Dry::CLI::Command
          desc 'Creates Images from words'

          option :all, default: false, desc: 'Create all images from persisted not already created words'
          argument :text_color, type: :string, required: true, desc: 'The color of the text'

          def call(text_color: 'black', **options)
            @text_color = text_color

            create_all = Shirty::Helper::FetchBool.new.fetch_bool(hash: options, key: :all, default: false)
            create_all_images_from_persisted_words if create_all
          end

          private

          attr_reader :text_color

          def logger
            @logger ||= RainbowLogger.new
          end

          def create_all_images_from_persisted_words
            words = ::Shirty::Repositories::Words.new.not_created_images_from_words

            words.each do |word|
              create_image_from_word(word)
            end
          end

          def create_image_from_word(word)
            result = ::Shirty::Operations::Images::Create.new.call(word: word, color: text_color)
            if result.success?
              logger.call('Image created', color: :green)
            else
              message = "Image not created: #{result.failure}"
              logger.call(message, color: :red)
            end
          end
        end
      end
    end
  end
end
