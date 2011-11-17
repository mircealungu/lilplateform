#  To create lilplateform, we will be using `ray` library. It's a game
#  engine DSL made for ruby. Have a look
#  (here)[http://mon-ouie.github.com/projects/ray.html] if you don't know
#  about it yet.
#  All the dependencies of the game are defined in the project's Gemfile,
#  under the "game" group. Let's require them now.
require 'bundler'
Bundler.setup
Bundler.require(:game)

#  The first thing to do is to require the `bundler` gem. Then we can
#  load all the defined gems in the path. Finally, we are able to require
#  the group of gem we want with the #require method on Bundler the
#  object.
#  In ray, a game is an object that handles the creation of the window
#  and the rendering of the different scene. Let's create one now.
Ray.game "lilplateform", :size => [800, 600] do

#  As you can see, the #game method on Ray object takes as a parameter
#  the size of the window. It also asks for a block. This block will be
#  evaled in the context of the Ray object. This is the place where we
#  specify the game.
#  We want to make sure to catch high level events such as one to quit
#  the game like `quit`. Since events are bound to a scene, we use ray's
#  `register` method to automatically register the high level methods
#  when a scene is loaded.
  register { add_hook :quit, method(:exit!) }

#  A game in ray is decomposed in scenes. Each scene is a different
#  screen rendered in the game's window. Let's create the menu scene
#  here.
  scene :menu do

    @title = text "Welcome to Lilplateform", :size => 30

    # Each scene has a render method. This is where the parent
    # (Ray's game window) draws element.
    render do |win|
      win.draw @title
    end
  end

#  Ray will display the first item on its scene stack. In order for a
#  scene to be displayed, it needs to be added to the stak. Let's add all
#  the scenes to the stack here.
  push_scene :menu

#  As soon as the #game method of the Ray object receives its block, the
#  game will be run. Let's just close the block here, and the game is
#  ready.
end

