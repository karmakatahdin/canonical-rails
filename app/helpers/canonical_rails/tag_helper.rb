module CanonicalRails
  module TagHelper
    
    def trailing_slash_needed?
      CanonicalRails.sym_collection_actions.include? request.params['action'].to_sym
    end
    
    def trailing_slash_if_needed
      "/" if trailing_slash_needed? and request.path.present?
    end
    
    def canonical_host
      CanonicalRails.host || request.host
    end
    
    def canonical_tag
      "#{request.protocol}#{canonical_host}/#{request.path}#{trailing_slash_if_needed}#{whitelisted_query_string}"
    end
    
    def whitelisted_params
      request.params.select do |key, value|
        value.present? and
        CanonicalRails.sym_whitelisted_parameters.include? key.to_sym
      end
    end
    
    def whitelisted_query_string
      "?#{whitelisted_params.to_a.join('=')}" if whitelisted_params.present?
    end
  end
end
