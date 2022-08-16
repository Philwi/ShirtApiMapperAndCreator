# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_08_16_201352) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "i_hate_everything_shops", force: :cascade do |t|
    t.bigint "word_id"
    t.string "color"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["word_id"], name: "index_i_hate_everything_shops_on_word_id"
  end

  create_table "images", force: :cascade do |t|
    t.string "file_name"
    t.integer "height"
    t.integer "width"
    t.integer "size"
    t.string "mime_type"
    t.string "shopable_type"
    t.bigint "shopable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "word_id"
    t.text "image_data"
    t.index ["shopable_type", "shopable_id"], name: "index_images_on_shopable"
    t.index ["word_id"], name: "index_images_on_word_id"
  end

  create_table "printify_blueprints", force: :cascade do |t|
    t.integer "printify_id"
    t.string "title"
    t.string "description"
    t.string "brand"
    t.string "model"
    t.string "images", default: [], array: true
  end

  create_table "printify_images", force: :cascade do |t|
    t.string "printify_id"
    t.string "file_name"
    t.integer "height"
    t.integer "width"
    t.integer "size"
    t.string "mime_type"
    t.datetime "upload_time"
  end

  create_table "printify_print_providers", force: :cascade do |t|
    t.integer "printify_id"
    t.string "title"
    t.string "location"
    t.bigint "printify_blueprint_id"
    t.index ["printify_blueprint_id"], name: "index_printify_print_providers_on_printify_blueprint_id"
  end

  create_table "printify_products", force: :cascade do |t|
    t.string "prinfify_id"
    t.string "title"
    t.string "description"
    t.string "tags", default: [], array: true
    t.string "options", default: [], array: true
    t.string "variants", default: [], array: true
    t.string "images", default: [], array: true
    t.string "printify_created_at"
    t.string "printify_updated_at"
    t.boolean "visible", default: true
    t.integer "blueprint_id"
    t.integer "print_provider_id"
    t.integer "user_id"
    t.integer "shop_id"
    t.string "print_areas", default: [], array: true
    t.string "print_details", default: [], array: true
    t.boolean "is_locked", default: true
    t.string "sales_channel_properties", default: [], array: true
  end

  create_table "printify_variants", force: :cascade do |t|
    t.integer "printify_id"
    t.string "title"
    t.text "options"
    t.string "placeholders", default: [], array: true
    t.bigint "printify_print_provider_id"
    t.bigint "printify_blueprint_id"
    t.text "variants"
    t.index ["printify_blueprint_id"], name: "index_printify_variants_on_printify_blueprint_id"
    t.index ["printify_print_provider_id"], name: "index_printify_variants_on_printify_print_provider_id"
  end

  create_table "words", force: :cascade do |t|
    t.string "name"
    t.json "sync_data", default: {}
  end

end
