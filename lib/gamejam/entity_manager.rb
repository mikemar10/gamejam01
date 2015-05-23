require 'components/gravity'
require 'components/input'
require 'components/position'
require 'components/programmer_art'
require 'components/renderable'
require 'securerandom'

class EntityManager
  attr_accessor :gravity_components,
                :input_components,
                :position_components,
                :renderable_components,
                :entities,
                :tags

  def initialize
    @gravity_components        = {}
    @input_components          = {}
    @position_components       = {}
    @programmer_art_components = {}
    @renderable_components     = {}
    @entities                  = []
    @tags                      = {}
  end

  def create_entity(opts)
    entity_id = SecureRandom.uuid
    opts[:tags] ||= []
    opts[:components] ||= []
    opts[:tags].each { |t| @tags[t] = entity_id }
    opts[:components].each { |c| add_component(entity_id, c) }
    entity_id
  end

  def add_component(entity, component)
    component_store = instance_variable_get("@#{component.class.to_s.downcase}_components")
    component_store[entity] = component
  end
end
