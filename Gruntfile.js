module.exports = function(grunt) {
  require('matchdep').filterDev('grunt-*').forEach(grunt.loadNpmTasks)

  grunt.initConfig({
    watch: {
      coffee: {
        files: ['src/**/*.coffee', 'tests/*.coffee'],
        tasks: ['coffee:compile', 'uglify:min']
      },
      //karma: {
        //files: ['src/*.coffee'],
        //tasks: ['karma:unit:run']
      //}
    },
    pkg: grunt.file.readJSON('package.json'),
    coffee: {
      options: {
        join: true
      },
      compile: {
        files: {
          'dist/MakeUp.js': ['src/**/*.coffee']
        }
      }
    },
    karma: {
      unit: {
        configFile: 'karma.conf.js',
        background: true
      },
      test: {
        configFile: 'karma.conf.js',
        background: false
      }
    },
    uglify: {
      min: {
        files: {
          'dist/MakeUp.min.js': ['dist/MakeUp.js']
        }
      }
    }
  })

  grunt.registerTask('test', ['karma:test'])
  grunt.registerTask('develop', ['karma:unit', 'watch:coffee'])
  grunt.registerTask('ugly', ['uglify:min'])
}


