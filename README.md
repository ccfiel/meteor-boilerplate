# meteor-boilerplate

Fork - added jade and coffee. 
     - convert all html to jade
     - convert all js to coffee
   
A starting point for MeteorJS applications. Includes iron-router, Bootstrap 3, Font Awesome, LESS and more.

* [Included Packages](#included-packages)
* [Installation](#installation)
* [File Structure](#file-structure)
* [Bootstrap and Less](#bootstrap-and-less)
* [SEO](#seo)
* [Favicons and Touch Icons](#favicons-and-touch-icons)
* [Seed Data](#seed-data)

## <a name="included-packages"></a> Included Packages

* Collections:
  * [dburles:collection-helpers](https://github.com/dburles/meteor-collection-helpers)
  * [matb33:collection-hooks](https://github.com/matb33/meteor-collection-hooks)
  * [reywood:publish-composite](https://github.com/englue/meteor-publish-composite)
* Router:
  * [iron:router](https://github.com/EventedMind/iron-router)
  * [zimme:iron-router-active](https://github.com/zimme/meteor-iron-router-active)
  * [yasinuslu:blaze-meta](https://github.com/yasinuslu/blaze-meta)
* Authentication
  * [splendido:accounts-templates-bootstrap](https://github.com/splendido/accounts-templates-bootstrap)
  * [alanning:roles](https://github.com/alanning/meteor-roles)
* Seed Data
  * [dburles:factory](https://github.com/percolatestudio/meteor-factory)
  * [anti:fake](https://github.com/anticoders/meteor-fake/)
* [Less](http://lesscss.org)
  * [Bootstrap](http://getbootstrap.com)
  * [Font Awesome](http://fontawesome.io)
* Misc:
  * [Moment.js](http://momentjs.com/)
  * [Underscore.js](http://underscorejs.org/)
  * [Underscore.string](http://epeli.github.io/underscore.string/)
  * [cunneen:mailgun](https://github.com/cunneen/meteor-mailgun)

## <a name="installation"></a> Installation

1. Clone this repo to `<yourapp>`

  `git clone https://github.com/Differential/meteor-boilerplate.git <yourapp>`

2. Remove `.git`

  `cd <yourapp> && rm -rf .git`

3. Start coding!

## <a name="file-structure"></a> File Structure

We have a common file structure we use across all of our Meteor apps. Client-only files are stored in the `client` directory, server-only files are stored in the `server` directory, and shared files are stored in the `both` directory. The `private` and `public` directories are for either private or public assets. 

## <a name="bootstrap-and-less"></a> Bootstrap and LESS

The majority of Bootstrap can be customized with LESS variables. If you look in `client/stylesheets/base/lib/bootstrap/variables.import.less` you will see a slew of configuration variables that can be tweaked to drastically change the look and feel of your site without having to write a single line of CSS.

However we should avoid modifying the core Bootstrap Less files (in case we want to update them later), and should instead override the variables in our own LESS files.

For example, to change the color of all primary buttons and links, simply add a `@brand-primary` variable to `stylesheets/base/variables.import.less`:

```
// variables.import.less
@brand-primary: #DC681D;
```

If you'd like to override a feature of Bootstrap that can't be modified using variables, simply create a new file in the `client/stylesheets/components` directory named after the corresponding Bootstrap component (eg. `buttons` in this case), and make your changes there.

```
// buttons.import.less
.btn {
  text-transform: uppercase;
}
```

After your file is ready, you need to import it into `client/stylesheets/base/global.less`. So, you would add in this statement:
```
@import '@{components}/buttons.import.less';
```

The reason that this is done is to avoid any issues when the LESS files are compiled into CSS. That way, if one component relies on another or you want a certain order for your components, you can avoid any issues.

## <a name="seo"></a> SEO

Page titles, meta descriptions and Facebook and Twitter meta tags are handled by the [yasinuslu:blaze-meta](https://github.com/yasinuslu/blaze-meta) package. Global settings are configured in `both/router/meta.js`, while individual page settings are set at the controller level.

* Note: the `spiderable` package will need to be installed and configured on your server in order for bots to read your meta tags.

```
PostsShowController = AppController.extend({
  path: '/posts/:_id',
  waitOn: function() {
    return this.subscribe('post', params._id);
  },
  data: function() {
    return {
      post: Post.find({_id: params._id})
    };
  },
  onAfterAction: function() {
    if(this.ready()) {
      Meta.setTitle(this.data().post.title);
    }
  }
});
```

## <a name="favicons-and-touch-icons"></a> Favicons and Touch Icons

Upload your image to http://realfavicongenerator.net/ and place the resulting images in `public/images/favicons`

## Seed Data

You can use the [dburles:factory](https://github.com/percolatestudio/meteor-factory) and [anti:fake](https://github.com/anticoders/meteor-fake/) packages to generate fake collection data for testing your UI. See `server/seeds.js` for an example:

```
Meteor.startup(function() {

  Factory.define('item', Items, {
    name: function() { return Fake.sentence(); },
    rating: function() { return _.random(1, 5); }
  });

  if (Items.find({}).count() === 0) {

    _(10).times(function(n) {
      Factory.create('item');
    });

  }

});

```
