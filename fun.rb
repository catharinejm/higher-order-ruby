def foo *args
  p = proc { |x| x * 5 }
  if args.empty?
    p
  else
    p.call *args
  end
end

def fun name, &block
  self.class.send :define_method, name do |*args|
    if args.empty? && block.arity.nonzero?
      block
    else
      block.call *args
    end
  end
end

fun :bar do |x|
  x * 3
end

puts bar(5,1)

