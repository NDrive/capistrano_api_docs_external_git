namespace :api_docs_external_git do

  set :doc_git_repository, nil
  set :doc_repository_name, "api-docs"
  set :rails_root, Pathname.new(Dir.pwd)
  set :rails_root_tmp_path, fetch(:rails_root).join("tmp")
  # You should set with ApiDocs.config.docs_path
  set :api_docs_path, fetch(:rails_root).join("doc", "api")

  task :setup do
    puts "**********************************"
    puts "Updating API Documentation"
    puts "**********************************"
    invoke :'api_docs_external_git:clone_repo'
    invoke :'api_docs_external_git:copy_files'
    invoke :'api_docs_external_git:add_files_git'
    invoke :'api_docs_external_git:remove_files'
  end

  desc 'Clone documentation repository to tmp folder'
  task :clone_repo do
    puts "Cloning #{fetch(:doc_git_repository).to_s} for temporary folder"
    @git_repo = Git.clone(fetch(:doc_git_repository), fetch(:doc_repository_name), path: fetch(:rails_root_tmp_path))
  end

  desc 'Copy documentation files from local respository to documentation repository'
  task :copy_files do
    files = Dir.glob(fetch(:api_docs_path).join('*.{yml,md}'))
    destination_folder = fetch(:rails_root_tmp_path).join(fetch(:doc_repository_name), fetch(:api_docs_path).relative_path_from(fetch(:rails_root))).join(fetch(:application))

    FileUtils.rm_r destination_folder, force: true

    puts "Copying documentation files"
    FileUtils.mkdir_p destination_folder
    FileUtils.cp_r files, destination_folder
  end

  desc 'Remove documentation repository'
  task :remove_files do
    puts "Removing documentation repository"
    FileUtils.rm_r fetch(:rails_root_tmp_path).join(fetch(:doc_repository_name))
  end

  desc 'Add files to documentation git'
  task :add_files_git do
    puts "Saving documentation files on git repository"

    @git_repo.add(all: true)
    begin
      @git_repo.commit_all('Automatic add documentation')
      @git_repo.push
    rescue Git::GitExecuteError => e
      invoke :'api_docs_external_git:remove_files'
      raise e unless e.message.include?("nothing to commit")
    end
  end

  before 'deploy:finishing', 'api_docs_external_git:setup'
end