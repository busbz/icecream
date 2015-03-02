# icecream
========

## Warning
This is actualy work in progress !!!!!!!!!
Do not use now :)

## About

Yeoman generator for a prety flexible but badass workflow

## Current state

*nothing :/*

### New project

You will be able to create a project within 1 command and a nice prompt that will adapt the scafolding for you.

#### Flexible

+ *Server :* both apache and node
+ *JS :* things like amd, coffeescript, backbone, ractive, vue, gsap... or just vanilla
+ *CSS :* Stylus, Sass, Less within there own framework (koutoswiss, compass, lesshat...) or simply css

#### Laisy

+ Simply create prefiled files from command line

Here are few exemples:
```
yo lib-model [ClassName] -e coffee --> /javascript/app/models/[class-name.coffee]
yo lib-view [ClassName] -f [Framework] --> /javascript/app/views/[class-name.js]
yo lib-ui [ClassName] -f [Framework] --> /javascript/app/views/ui/[class-name.js] // extend AbstractUI
yo lib-component [ClassName] [-t|template] [-d|dir] [-rvc|require-plugin]
+ Some exemple within Ractive and Require Base
    + $yo lib-component Widget -rvc
        + --> /javascript/app/views/component/widget.html
    + $yo lib-component Widget -t Template -d widget
        + --> .../component/widget/widget.coffee
        + --> .../component/widget/template.html

yo tpl-page [name] --> /templates/[name.js]
yo style-page [name] --> /stylesheets/app/pages/[name.js]
```

+ Automaticaly watch your code, refresh your browser if you change a file, or inject css - so no need to always reopen this $#3K!& popin every time when qa time

#### Strong

+ JS optimisation within rjs
+ tests: jslint, (@todo mocha ?)
+ CSS Compression and minification, frameworks (koutoswiss...)
+ HTML Optimisation/Compression
...

## Wishlist

#### Server

    [*]  nodejs
    [ ]  apache

### Javascript

#### Engine
both engines will work together anyway, it's just to minimise build processes...

    [*] coffeescript
    [ ] iced-coffee
    [*] javascript

#### Frameworks

This generator is used to be adaptive, so you can even uncheck all and code in vanilla ;)

*Base :*

    [*] amd (require-js)
    [*] coffee (if checked, will init project within cs files)
    [*] backbone (depends on jquery and underscore)
    [*] ractive
        If checked within Backbone, it will replace Backbone view's system using backbone.adaptors.
        Use ractive templates and rv require module to optimize
    [ ] vuejs
        If checked within Backbone, it will *NOT* replace Backbone view's system.
    [*] jquery

*extras libs :*

    [*] lo-dash
        + replace underscore
        + if backbone, pront (y/n) for the underscore build.
    [ ] underscore
    [*] jquery
        [*] v2.latest
        [ ] v1.latest
        [ ] other (type your own considering google cdn)
    [*] isjs
    [ ] stringjs
    [*] gsap (TweenMax)
    [ ] rvc (ractive component loader)
    [ ] ... maybe more to come
    [*] require-text
    [*] require-json
    [ ] require-async
    [ ] require-css
    [ ] require-stylus

Frameworks are displayed order by base priority witch mean :

+ if backbone is checked, we will use Backbone MV* system
+ if only vuejs is checked, we will use vuejs MVVM system
+ if we check both ractive and vuejs, we well use ractive system as base but you will be able to also use vuejs - through it would be ridiculous...
+ if nothing checked, will use old friend vanilla - good luck

### Templating
both engines will work together anyway, it's just to minimise build processes...

#### server side (if node)

    [*] jade
    [ ] hbs (handlebar)
    [ ] ejs
    [ ] ractive

#### frontside

    [*] ractive (need ractive framework on js section)
    [ ] ejs
(see notes bellow)

#### extra

    [ ] twitter bootstrap
    [ ] google analytics (will prompt for id)
    [ ] facebook (will prompt for id) - add og tags etc

#### Notes for front templating

+ if, for exemple we use ractive *within* require, it will use rv require plugin to preparse templates
template.html
```html
    <h1>{{title}}</h1>
    <ul>
        <div id="widget"></div>
        <widget content="Component"></widget>
        {{#with {content:'Partial'}}}{{>widget}}{{/with}}
    </ul>
    <!-- output -->
    <ul>
        <li>View</li>
        <li>Component</li>
        <li>Partial</li>
    </ul>
```
partial.html
```html
    <li>{{title}}</li>
```
index.coffee
```coffee
define ['rv!.index','rv!.widget','ractive'], (Tpl, Widget, Ractive) ->
  'use strict'
  Ractive.extend
    template:Tpl
    partial:
        widget:Widget
    components:
        widget:Ractive.extend
            template:Widget
    onrender:->
        new Ractive
            el: '#widget'
            template:Widget
            data:
                content:'View'

```

+ if ractive *without* require, no external templates. but you can do :
index.html
```html
<body>
    <div id="content"></div>
    <script id="#tpl-index" type="html/template">
        <h1>{{title}}</h1>
        <ul>
            <div id="widget"></div>
            <widget content="Component"></widget>
            {{#with {content:'Partial'}}}{{>widget}}{{/with}}
        </ul>
        <!--{{>widget}}-->
            <li>{{content}}</li>
        <!--{{/widget}}-->
        <!-- output -->
        <ul>
            <li>View</li>
            <li>Component</li>
            <li>Partial</li>
        </ul>
    </script>
    <script id="#tpl-widget" type="html/template">
        <li>{{content}}</li>
    </script>
</body>
```
index.coffee
```coffee
class Index
    new Ractive
        el:'#content'
        template:'#tpl-index'
        components:
            widget:Ractive.extend
                template:Widget
        onrender:->
            new Ractive
                el: '#widget'
                template:"#tpl-widget"
                data:
                    content:'View'
```

### Style

if nothing checked, use simply css

    [*] stylus
        [*] koutoswiss
        [*] jeet
        [*] rapture
    [ ] sass
        [*] compass
    [ ] less