desc 'build and test a new image'
task :ci do
#   docker run --name ${JOB_NAME} -v ${WORKSPACE}:/project zapier/project-tests
#
# # copy build artifacts out of the container
#   docker cp ${JOB_NAME}:/project/nosetests.xml .
#       docker cp ${JOB_NAME}:/project/coverage.xml .
#       docker cp ${JOB_NAME}:/project/cover .
#
# # remove the container
#       docker rm ${JOB_NAME}
  require 'logger'

  logger = Logger.new(STDOUT)

  begin
    `mkdir artifacts`

    build_command = "docker build -t sholden/docking:#{ENV['BUILD_NUMBER']} ."
    logger.info "Building container: #{build_command}"
    `#{build_command}`

    db_run_command = "docker run -d -p 3306:3306 -e MYSQL_PASS=docking tutum/mysql"
    logger.info "Starting database: #{db_run_command}"
    db_container_id = `#{db_run_command}`.strip
    logger.info "Started db container: #{db_container_id}"

    db_stop_command = "docker stop #{db_container_id}"
    logger.info "Stopping database container: #{db_stop_command}"
    `#{db_stop_command}`

    db_rm_command = "docker rm #{db_container_id}"
    logger.info "Removing db container: #{db_rm_command}"
    `#{db_rm_command}`
  end
end