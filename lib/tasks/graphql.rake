require 'graphql/rake_task'

GraphQL::RakeTask.new(schema_name: 'DefaultInitSchema')

# $ rails graphql:schema:idl
# Schema IDL dumped to ./schema.graphql
