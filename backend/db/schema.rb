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

ActiveRecord::Schema[8.1].define(version: 2026_03_27_010014) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "categories", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "created_by_id"
    t.datetime "deleted_at"
    t.integer "deleted_by_id"
    t.text "description"
    t.integer "lock_version"
    t.string "name"
    t.integer "parent_id"
    t.string "slug"
    t.datetime "updated_at", null: false
    t.integer "updated_by_id"
    t.string "uuid"
  end

  create_table "form_definitions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "created_by_id"
    t.datetime "deleted_at"
    t.integer "deleted_by_id"
    t.text "description"
    t.jsonb "field_config", default: {}
    t.integer "lock_version", default: 0
    t.jsonb "logic_rules", default: []
    t.string "name", null: false
    t.jsonb "schema", default: {"fields"=>[]}, null: false
    t.string "slug", null: false
    t.string "status", default: "draft", null: false
    t.datetime "updated_at", null: false
    t.integer "updated_by_id"
    t.string "uuid"
    t.integer "version", default: 1, null: false
    t.index ["deleted_at"], name: "index_form_definitions_on_deleted_at"
    t.index ["slug"], name: "index_form_definitions_on_slug", unique: true
    t.index ["uuid"], name: "index_form_definitions_on_uuid", unique: true
  end

  create_table "form_submissions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "created_by_id"
    t.jsonb "data", default: {}, null: false
    t.datetime "deleted_at"
    t.integer "deleted_by_id"
    t.bigint "form_definition_id", null: false
    t.integer "lock_version", default: 0
    t.string "status", default: "draft", null: false
    t.integer "submitted_by_id"
    t.datetime "updated_at", null: false
    t.integer "updated_by_id"
    t.string "uuid"
    t.datetime "validated_at"
    t.index ["deleted_at"], name: "index_form_submissions_on_deleted_at"
    t.index ["form_definition_id"], name: "index_form_submissions_on_form_definition_id"
    t.index ["uuid"], name: "index_form_submissions_on_uuid", unique: true
  end

  create_table "groups", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "description"
    t.string "name"
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_groups_on_name", unique: true
  end

  create_table "groups_permissions", id: false, force: :cascade do |t|
    t.bigint "group_id", null: false
    t.bigint "permission_id", null: false
  end

  create_table "groups_users", id: false, force: :cascade do |t|
    t.bigint "group_id", null: false
    t.bigint "user_id", null: false
  end

  create_table "items", force: :cascade do |t|
    t.integer "category_id"
    t.datetime "created_at", null: false
    t.integer "created_by_id"
    t.datetime "deleted_at"
    t.integer "deleted_by_id"
    t.text "description"
    t.integer "lock_version"
    t.string "name"
    t.decimal "price"
    t.string "slug"
    t.datetime "updated_at", null: false
    t.integer "updated_by_id"
    t.string "uuid"
  end

  create_table "permissions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "description"
    t.string "name"
    t.string "slug"
    t.datetime "updated_at", null: false
    t.index ["slug"], name: "index_permissions_on_slug", unique: true
  end

  create_table "sessions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "ip_address"
    t.datetime "updated_at", null: false
    t.string "user_agent"
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "solid_queue_blocked_executions", force: :cascade do |t|
    t.string "concurrency_key", null: false
    t.datetime "created_at", null: false
    t.datetime "expires_at", null: false
    t.bigint "job_id", null: false
    t.integer "priority", default: 0, null: false
    t.string "queue_name", null: false
    t.index ["concurrency_key", "priority", "job_id"], name: "index_solid_queue_blocked_executions_for_release"
    t.index ["expires_at", "concurrency_key"], name: "index_solid_queue_blocked_executions_for_maintenance"
    t.index ["job_id"], name: "index_solid_queue_blocked_executions_on_job_id", unique: true
  end

  create_table "solid_queue_claimed_executions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "job_id", null: false
    t.bigint "process_id"
    t.index ["job_id"], name: "index_solid_queue_claimed_executions_on_job_id", unique: true
    t.index ["process_id", "job_id"], name: "index_solid_queue_claimed_executions_on_process_id_and_job_id"
  end

  create_table "solid_queue_failed_executions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "error"
    t.bigint "job_id", null: false
    t.index ["job_id"], name: "index_solid_queue_failed_executions_on_job_id", unique: true
  end

  create_table "solid_queue_jobs", force: :cascade do |t|
    t.string "active_job_id"
    t.text "arguments"
    t.string "class_name", null: false
    t.string "concurrency_key"
    t.datetime "created_at", null: false
    t.datetime "finished_at"
    t.integer "priority", default: 0, null: false
    t.string "queue_name", null: false
    t.datetime "scheduled_at"
    t.datetime "updated_at", null: false
    t.index ["active_job_id"], name: "index_solid_queue_jobs_on_active_job_id"
    t.index ["class_name"], name: "index_solid_queue_jobs_on_class_name"
    t.index ["finished_at"], name: "index_solid_queue_jobs_on_finished_at"
    t.index ["queue_name", "finished_at"], name: "index_solid_queue_jobs_for_filtering"
    t.index ["scheduled_at", "finished_at"], name: "index_solid_queue_jobs_for_alerting"
  end

  create_table "solid_queue_pauses", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "queue_name", null: false
    t.index ["queue_name"], name: "index_solid_queue_pauses_on_queue_name", unique: true
  end

  create_table "solid_queue_processes", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "hostname"
    t.string "kind", null: false
    t.datetime "last_heartbeat_at", null: false
    t.text "metadata"
    t.string "name", null: false
    t.integer "pid", null: false
    t.bigint "supervisor_id"
    t.index ["last_heartbeat_at"], name: "index_solid_queue_processes_on_last_heartbeat_at"
    t.index ["name", "supervisor_id"], name: "index_solid_queue_processes_on_name_and_supervisor_id", unique: true
    t.index ["supervisor_id"], name: "index_solid_queue_processes_on_supervisor_id"
  end

  create_table "solid_queue_ready_executions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "job_id", null: false
    t.integer "priority", default: 0, null: false
    t.string "queue_name", null: false
    t.index ["job_id"], name: "index_solid_queue_ready_executions_on_job_id", unique: true
    t.index ["priority", "job_id"], name: "index_solid_queue_poll_all"
    t.index ["queue_name", "priority", "job_id"], name: "index_solid_queue_poll_by_queue"
  end

  create_table "solid_queue_recurring_executions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "job_id", null: false
    t.datetime "run_at", null: false
    t.string "task_key", null: false
    t.index ["job_id"], name: "index_solid_queue_recurring_executions_on_job_id", unique: true
    t.index ["task_key", "run_at"], name: "index_solid_queue_recurring_executions_on_task_key_and_run_at", unique: true
  end

  create_table "solid_queue_recurring_tasks", force: :cascade do |t|
    t.text "arguments"
    t.string "class_name"
    t.string "command", limit: 2048
    t.datetime "created_at", null: false
    t.text "description"
    t.string "key", null: false
    t.integer "priority", default: 0
    t.string "queue_name"
    t.string "schedule", null: false
    t.boolean "static", default: true, null: false
    t.datetime "updated_at", null: false
    t.index ["key"], name: "index_solid_queue_recurring_tasks_on_key", unique: true
    t.index ["static"], name: "index_solid_queue_recurring_tasks_on_static"
  end

  create_table "solid_queue_scheduled_executions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "job_id", null: false
    t.integer "priority", default: 0, null: false
    t.string "queue_name", null: false
    t.datetime "scheduled_at", null: false
    t.index ["job_id"], name: "index_solid_queue_scheduled_executions_on_job_id", unique: true
    t.index ["scheduled_at", "priority", "job_id"], name: "index_solid_queue_dispatch_all"
  end

  create_table "solid_queue_semaphores", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "expires_at", null: false
    t.string "key", null: false
    t.datetime "updated_at", null: false
    t.integer "value", default: 1, null: false
    t.index ["expires_at"], name: "index_solid_queue_semaphores_on_expires_at"
    t.index ["key", "value"], name: "index_solid_queue_semaphores_on_key_and_value"
    t.index ["key"], name: "index_solid_queue_semaphores_on_key", unique: true
  end

  create_table "transition_logs", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.jsonb "data", default: {}
    t.string "from_state", null: false
    t.string "to_state", null: false
    t.integer "transitioned_by_id"
    t.datetime "updated_at", null: false
    t.bigint "workflow_instance_id", null: false
    t.index ["workflow_instance_id"], name: "index_transition_logs_on_workflow_instance_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "created_by_id"
    t.datetime "deleted_at"
    t.integer "deleted_by_id"
    t.string "email_address", null: false
    t.string "first_name"
    t.string "last_name"
    t.integer "lock_version"
    t.string "password_digest", null: false
    t.datetime "updated_at", null: false
    t.integer "updated_by_id"
    t.string "uuid"
    t.index ["email_address"], name: "index_users_on_email_address", unique: true
  end

  create_table "workflow_definitions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "created_by_id"
    t.datetime "deleted_at"
    t.integer "deleted_by_id"
    t.text "description"
    t.integer "lock_version", default: 0
    t.string "name", null: false
    t.string "slug", null: false
    t.jsonb "states", default: [], null: false
    t.string "target_type"
    t.jsonb "transitions", default: [], null: false
    t.datetime "updated_at", null: false
    t.integer "updated_by_id"
    t.string "uuid"
    t.index ["deleted_at"], name: "index_workflow_definitions_on_deleted_at"
    t.index ["slug"], name: "index_workflow_definitions_on_slug", unique: true
    t.index ["uuid"], name: "index_workflow_definitions_on_uuid", unique: true
  end

  create_table "workflow_instances", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "created_by_id"
    t.string "current_state", null: false
    t.datetime "deleted_at"
    t.integer "deleted_by_id"
    t.integer "lock_version", default: 0
    t.jsonb "metadata", default: {}
    t.datetime "updated_at", null: false
    t.integer "updated_by_id"
    t.string "uuid"
    t.bigint "workflow_definition_id", null: false
    t.integer "workflowable_id"
    t.string "workflowable_type"
    t.index ["deleted_at"], name: "index_workflow_instances_on_deleted_at"
    t.index ["uuid"], name: "index_workflow_instances_on_uuid", unique: true
    t.index ["workflow_definition_id"], name: "index_workflow_instances_on_workflow_definition_id"
    t.index ["workflowable_type", "workflowable_id"], name: "idx_on_workflowable_type_workflowable_id_a8a92819ec"
  end

  add_foreign_key "form_submissions", "form_definitions"
  add_foreign_key "sessions", "users"
  add_foreign_key "solid_queue_blocked_executions", "solid_queue_jobs", column: "job_id", on_delete: :cascade
  add_foreign_key "solid_queue_claimed_executions", "solid_queue_jobs", column: "job_id", on_delete: :cascade
  add_foreign_key "solid_queue_failed_executions", "solid_queue_jobs", column: "job_id", on_delete: :cascade
  add_foreign_key "solid_queue_ready_executions", "solid_queue_jobs", column: "job_id", on_delete: :cascade
  add_foreign_key "solid_queue_recurring_executions", "solid_queue_jobs", column: "job_id", on_delete: :cascade
  add_foreign_key "solid_queue_scheduled_executions", "solid_queue_jobs", column: "job_id", on_delete: :cascade
  add_foreign_key "transition_logs", "workflow_instances"
  add_foreign_key "workflow_instances", "workflow_definitions"
end
