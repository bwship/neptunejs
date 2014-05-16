module.exports = function (grunt) {

    grunt.initConfig({

        watch: {
            less: {
                files: ['public/less/**/*.less'],
                tasks: ['less']
            },
            coffee: {
                files: ['**/*.coffee'],
                tasks: ['coffee']
            }
        },
        less: {
            options: {
                relativeUrls: true,
                paths: ["public/less"]
            },
            src: {
                expand: true,
                relativeUrls: true,
                cwd: "public/less",
                src: "**/*.less",
                ext: ".css",
                dest: "public/stylesheets"
            }
        },
        shell: {
            devserver: {
                command: 'node app',
                options: {
                    async: true,
                },
            },
        },
        coffee: {

            glob_to_multiple: {
                expand: true,
                flatten: true,
                cwd: 'public/coffeescripts',
                src: ['*.coffee'],
                dest: 'public/javascripts/',
                ext: '.js'
            },
            compile: {
                files: {
                    'app.js': 'app.coffee',
                    'routes/main.js': 'routes/main.coffee'
                }
            }

        }
    });
    grunt.loadNpmTasks('grunt-contrib-coffee');
    grunt.loadNpmTasks('grunt-contrib-watch');
    grunt.loadNpmTasks('grunt-contrib-less');
    grunt.loadNpmTasks('grunt-shell-spawn');


    grunt.registerTask('default', ['less', 'coffee', 'shell:devserver', 'watch']);
    grunt.registerTask('build', ['less', 'coffee']);
};
