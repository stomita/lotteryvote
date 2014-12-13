"use strict"
path = require 'path'

module.exports = (grunt) ->
    require("load-grunt-tasks") grunt
    
    grunt.initConfig
        watch:
            coffee:
                files: ["./client/scripts/**/*.coffee"]
                tasks: ["coffee", "browserify", "copy", "zip:app", "zip:force"]
            less:
                files: ["./client/styles/**/*.less"]
                tasks: ["less", "copy", "zip:app", "zip:force"]
            templates:
                files: ["./client/templates/**/*.html"]
                tasks: ["ngtemplates", "copy", "zip:app", "zip:force"]
            statics:
                files: ["./client/images/**/*"]
                tasks: ["copy", "zip:app", "zip:force"]
        clean:
            dist: ".tmp"
            server: ".tmp"

        less:
            server:
                options:
                    strictMath: true
                    dumpLineNumbers: true
                    sourceMap: true
                    sourceMapRootpath: ""
                    outputSourceFiles: true
                files: [
                    expand: true
                    cwd: "./client/styles"
                    src: "main.less"
                    dest: ".tmp/styles"
                    ext: ".css"
                ]
            dist:
                options:
                    cleancss: true,
                    report: 'min'
                files: [
                    expand: true
                    cwd: "./client/styles"
                    src: "main.less"
                    dest: ".tmp/styles"
                    ext: ".css"
                ]

        coffee:
            server:
                files: [
                    expand: true
                    cwd: "./client/scripts"
                    src: "**/*.coffee"
                    dest: ".tmp/scripts"
                    ext: ".js"
                ]
            dist:
                files: [
                    expand: true
                    cwd: "./client/scripts"
                    src: "**/*.coffee"
                    dest: ".tmp/scripts"
                    ext: ".js"
                ]

        # Put files not handled in other tasks here
        copy:
            dist:
                files: [
                    expand: true
                    dot: true
                    cwd: "./client"
                    dest: "./public"
                    src: [
                        "images/**/*"
                    ]
                ,
                    expand: true
                    cwd: ".tmp"
                    dest: "./public"
                    src: ["scripts/**", "styles/**"]
                ]

        ngtemplates:
            app:
                cwd: "./client"
                src: "templates/**/*.html"
                dest: ".tmp/scripts/angular-templates.js"

        browserify:
            dist:
                files: ".tmp/scripts/main-bundle.js": [".tmp/scripts/main.js"]

        zip:
            app:
                cwd: "./public"
                src: [ "./public/scripts/**/*", "./public/styles/**/*", "./public/assets/**/*" ]
                dest: "../force/src/staticresources/LotteryVote.resource"
                compression: 'DEFLATE'
            force:
                cwd: "../force"
                src: [ "../force/src/**/*" ]
                dest: "../force/LotteryVote.zip"
                compression: 'DEFLATE'


    grunt.registerTask "build", ["clean", "coffee", "less", "ngtemplates", "browserify", "copy", "zip:app", "zip:force" ]
    grunt.registerTask "server", ["build", "watch"]
    grunt.registerTask "default", ["server"]
