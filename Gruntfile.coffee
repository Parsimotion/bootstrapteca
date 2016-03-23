name = "bootstrapteca"

module.exports = (grunt) ->

  # Load grunt tasks automatically, when needed
  require("jit-grunt") grunt

  grunt.initConfig
    pkg: grunt.file.readJSON "package.json"

    meta:
      banner: '/* <%= pkg.name %> - v<%= pkg.version %> - <%= grunt.template.today("yyyy-mm-dd") %> */\n'

    coffeelint:
      src: "src/**/*.coffee"
      options:
        max_line_length:
          level: "ignore"
        line_endings:
          value: "unix"
          level: "error"
        no_stand_alone_at:
          level: "error"

    clean:
      options:
        force: true
      compile: ["compile"]
      build: ["compile/**", "build/**"]

    coffee:
      compile:
        files: [
          expand: true
          cwd: "src/"
          src: "**/*.coffee"
          dest: "compile/"
          ext: ".js"
        ]
        options:
          bare: true

    sass:
      compile:
        files: [
          expand: true
          cwd: "src/"
          src: ["**/*.scss"]
          dest: "compile/"
          ext: ".css"
        ]

    concat:
      options:
        banner: "<%= meta.banner %>"
      js:
        src: ["compile/**/*.js"]
        dest: "build/#{name}.js"
      css:
        src: ["compile/**/*.css"]
        dest: "build/#{name}.css"

    uglify:
      options:
        banner: "<%= meta.banner %>"
      js:
        src: ["build/#{name}.js"]
        dest: "build/#{name}.min.js"

    karma:
      unit:
        configFile: "karma.conf.js"
        singleRun: true

  grunt.registerTask "default", ["clean:build", "sass", "concat:css", "clean:compile"]

  grunt.registerTask "test", [
    "coffee"
    "karma"
  ]
