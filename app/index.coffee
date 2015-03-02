'use strict'
yeoman  = require('yeoman-generator')
chalk   = require('chalk')
yosay   = require('yosay')

module.exports = yeoman.generators.Base.extend
  initializing: ->
    @pkg = require('../package.json')

  prompting: ->
    done = @async()

    # Have Yeoman greet the user.
    @log(yosay(
      'Yo ! Ready to get lazy ? relax and enjoy your \'' + chalk.red('Icecream') + '\' generator!'
    ))

    prompts = [
      {
        type: 'checkbox'
        name: 'server'
        message: 'old school ?'
        choices: [
          {
            name: 'nodejs',
            value: 'node'
            checked: true
          }
          {
            name: 'apache',
            value: 'apache'
            checked: false
          }
        ]
      }
      {
        type: 'checkbox'
        name: 'styles'
        message: 'What more would you like?'
        choices: [
          {
            name: 'stylus',
            value: 'server-stylus'
            checked: true
          }
          {
            name: 'sass',
            value: 'server-sass'
            checked: false
          }
          {
            name: 'less',
            value: 'server-less'
            checked: false
          }
        ]
      }
      {
        type: 'confirm',
        name: 'someOption',
        message: 'Would you like to enable this option?',
        default: true
      }
    ]

    @prompt prompts, (props)=>
      @someOption = props.someOption
      done()

  writing:
    app: ->
      @fs.copy(
        @templatePath('_package.json')
        @destinationPath('package.json')
      )
      @fs.copy(
        @templatePath('_bower.json')
        @destinationPath('bower.json')
      )

    projectfiles: ->
      @fs.copy(
        @templatePath('editorconfig')
        @destinationPath('.editorconfig')
      )
      @fs.copy(
        @templatePath('jshintrc')
        @destinationPath('.jshintrc')
      )

  install: ->
    @installDependencies
      skipInstall: @options['skip-install']