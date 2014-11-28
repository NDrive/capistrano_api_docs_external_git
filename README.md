capistranoApiDocsExternalGit
=================

Add tasks to capistrano to a Rails project to work with gem api_docs.
It only works with capistrano 3. Older versions until 0.3 works with capistrano 2.

Currently

* Add documentation files to git
* Clone documentation repository to tmp folder
* Copy documentation files from local respository to documentation repository
* Remove temporary documentation repository

Feel free to fork and to add new tasks.

Install
=======

Add it as a gem:

```ruby
    gem "capistrano_api_docs_external_git"
```

Change your Capfile:

```ruby
   require 'capistrano/api_docs_external_git'
```

Add if you want change any of this options on your config/deploy.rb:
```ruby
    # This one is required
    # Set Your destination git repository e.g. (git@github.com:guiferrpereira/api-docs.git)
    set :doc_git_repository, nil

    # Optionals
    # Set Your destination repository name e.g. "api-docs"
    set :doc_repository_name, "api-docs"
    # Rails Application root folder
    set :rails_root, Pathname.new(Dir.pwd)
    # Temporary folder where you want save git repository temporary
    set :rails_root_tmp_path, fetch(:rails_root).join("tmp")
    # You should set with ApiDocs.config.docs_path
    set :api_docs_path, fetch(:rails_root).join("doc", "api")
```

Available tasks
===============

    cap api_docs_external_git:add_files_git  # Add files to documentation git
    cap api_docs_external_git:clone_repo     # Clone documentation repository to tmp folder
    cap api_docs_external_git:copy_files     # Copy documentation files from local respository to documentation repository
    cap api_docs_external_git:remove_files   # Remove documentation repository

Example
=======

    By default will run after your deploy is finished

TODO
====
* Add tests

Copyright (c) 2014 [Guilherme Pereira - NDrive], released under the MIT license