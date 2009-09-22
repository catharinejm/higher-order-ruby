class Class
  def method_added name
    return if name == "method_added" || name == @current_method
    @current_method = name
    m = instance_method(name)
    define_method name do |*args|
      if args.empty? && (m.arity > 0 || m.arity < -1)
        m.bind(self)
      else
        m.bind(self).call *args
      end
    end
    @current_method = nil
  end
end

class A
  def meth x
    x*5
  end
end

puts A.new.meth(5)
puts [1,2,3].map(&A.new.meth).inspect
