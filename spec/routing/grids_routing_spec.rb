# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GridsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/grids').to route_to('grids#index')
    end

    it 'routes to #new' do
      expect(get: '/grids/new').to route_to('grids#new')
    end

    it 'routes to #show' do
      expect(get: '/grids/1').to route_to('grids#show', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/grids').to route_to('grids#create')
    end

    it 'routes to #destroy' do
      expect(delete: '/grids/1').to route_to('grids#destroy', id: '1')
    end
  end
end
