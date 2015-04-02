module.exports = function(grunt) {

  // Static Webserver
  grunt.loadNpmTasks('grunt-connect');

  // Project configuration.
  grunt.initConfig({
    connect: {
      server: {
        port: 80,
        base: ".",
        keepalive: true
      }
    }
  });

  // Default task(s).
  grunt.registerTask("default", ["connect"]);

};
