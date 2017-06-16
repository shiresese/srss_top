gulp = require 'gulp'
$ = do require 'gulp-load-plugins'
webserver = require 'gulp-webserver'

__srcdir = './src/'
__distdir = './dist/'

gulp.task 'jade', () ->
  gulp.src __srcdir + 'jade/index.jade'
    .pipe $.plumber(errorHandler: $.notify.onError('Error: <%= error.message %>'))
    .pipe $.jade({
      pretty: true
      })
    .pipe gulp.dest(__distdir)

gulp.task 'coffee', () ->
  gulp.src __srcdir + 'coffee/*.coffee'
    .pipe $.plumber(errorHandler: $.notify.onError('Error: <%= error.message %>'))
    .pipe $.coffee(
      bare: true
    )
    .pipe gulp.dest(__distdir + 'js')

gulp.task 'less', () ->
  gulp.src __srcdir + 'css/*.less'
    .pipe $.plumber(errorHandler: $.notify.onError('Error: <%= error.message %>'))
    .pipe $.less()
    .pipe gulp.dest(__distdir + 'css')

gulp.task 'watch', ['jade', 'coffee', 'less', 'webserver'], () ->
  gulp.watch __srcdir + 'jade/*.jade', ['jade']
  gulp.watch __srcdir + 'css/*.less', ['less']
  gulp.watch __srcdir + 'coffee/*.coffee', ['coffee']

gulp.task 'webserver', () ->
  gulp.src __distdir
    .pipe webserver(
      fallback: 'index.html'
      port: 9001
      livereload: true
    )

gulp.task 'default', ['watch']
