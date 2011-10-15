module ActionViewTemplateInheritance
  module ActionView
    def blocks
      @inheritance_blocks ||= { :appends => {} }
    end

    def block(name, value = nil, &block)
      raise ArgumentError, "Block has to have a name!" if name.nil?
      raise ArgumentError, "You have to provide value or block, not both of them!" if value && block
      self.blocks[name] ||= block ? capture(&block) : value
      if self.blocks[:appends][name]
        appends = self.blocks[:appends][name].join("\n").html_safe
      end
      return (self.blocks[name] || "") + (appends || "")
    end

    def enhance_block(name, value = nil, &block)
      raise ArgumentError, "Block has to have a name!" if name.nil?
      raise ArgumentError, "You have to provide value or block, not both of them!" if value && block
      self.blocks[:appends][name] ||= []
      self.blocks[:appends][name].unshift(block ? capture(&block) : value)
    end

    def clear_block(name)
      block(name, "")
    end

    def inherit(options = {}, &block)
      # We accept a shorthand syntax -- if options is a string, render as a file.
      return inherit({:file => options}, &block) if options.is_a?(String)

      bind = options[:binding]

      # Get our differences and additions to the view we're inheriting.
      if block_given?
        capture(&block)
        bind ||= block.binding
      end

      raise "Important: inherit() requires a block. Empty one ({}) is fine though." unless bind 

      # Render our parent view.
      render(options)
    end

    ::ActionView::Base.send :include, self
  end
end
