require 'components/gravity'
require 'components/player_input'
require 'components/position'
require 'components/renderable'
require 'securerandom'

class EntityManager
  attr_accessor :gravity_components,
                :playerinput_components,
                :position_components,
                :renderable_components,
                :entities,
                :tags

  def initialize
    @gravity_components        = {}
    @playerinput_components          = {}
    @position_components       = {}
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

  def save_state
  end

  def restore_state
  end
end
