#!/usr/bin/env jruby
# Copyright 2015, Mike & Myles Martin

# Add lib and vendor to our load path
$:.push File.expand_path('../../lib', __FILE__)
$:.push File.expand_path('../../lib/gamejam', __FILE__)
$:.push File.expand_path('../../third_party', __FILE__)

# Java imports for libgdx
require 'java'
require 'gdx-backend-lwjgl-natives.jar'
require 'gdx-backend-lwjgl.jar'
require 'gdx-natives.jar'
require 'gdx.jar'
java_import com.badlogic.gdx.ApplicationAdapter
java_import com.badlogic.gdx.ApplicationListener
java_import com.badlogic.gdx.Game
java_import com.badlogic.gdx.Gdx
java_import com.badlogic.gdx.Screen
java_import com.badlogic.gdx.Input
java_import com.badlogic.gdx.backends.lwjgl.LwjglApplication
java_import com.badlogic.gdx.backends.lwjgl.LwjglApplication
java_import com.badlogic.gdx.backends.lwjgl.LwjglApplicationConfiguration
java_import com.badlogic.gdx.backends.lwjgl.LwjglApplicationConfiguration
java_import com.badlogic.gdx.graphics.Color
java_import com.badlogic.gdx.graphics.FPSLogger
java_import com.badlogic.gdx.graphics.GL20
java_import com.badlogic.gdx.graphics.OrthographicCamera
java_import com.badlogic.gdx.graphics.Texture
java_import com.badlogic.gdx.graphics.g2d.BitmapFont
java_import com.badlogic.gdx.graphics.g2d.Sprite
java_import com.badlogic.gdx.graphics.g2d.SpriteBatch
java_import com.badlogic.gdx.graphics.g2d.TextureRegion
java_import com.badlogic.gdx.utils.viewport.FitViewport

require 'gamejam'
require 'logger'

$logger = Logger.new(STDERR)
$logger.level = Logger::DEBUG
$logger.info "It's time to game jam!"

$screen_width = 1280
$screen_height = 720
cfg = LwjglApplicationConfiguration.new
cfg.title = '20 Seconds To Try Again'
cfg.width = $screen_width
cfg.height = $screen_height

LwjglApplication.new(GameJam.new, cfg)
