require 'matrix'

def derivated_with_respect_to_x a, b, x, y
  -2*(a-x) - 4*b*x*(y-(x*x))
end

def derivated_with_respect_to_y a, b, x, y
  2*b*(y-(x*x))
end

def derivate_f1_with_respect_to_x b, x, y
  2 - 4*b*(y-3*(x*x))
end

def derivate_f1_with_respect_to_y b, x
  -4*b*x
end

def derivate_f2_with_respect_to_x b, x
  -4*b*x
end

def derivate_f2_with_respect_to_y b
  2*b
end

print "What is your a? usually its 1"
a = gets
a = a.to_i

print "What is your b? usually its 100"
b = gets
b = b.to_i


# Formula for the Rosenbrock's valley function is
# f(x,y) = (a - x)^2 + b(y - x^2)^2

# First we will register our first guess for the x and y values.

x = 0.991
y = 1.01

# First we will need to derive two equation from the Rosenbrock's formula a(x,y) and b(x,y) for newton raphson method
# a(x, y) = f1 = derivate f(x, y) with respect to x by derivated_with_respect_to_x
# b(x, y) = f2 = derivate f(x, y) with respect to y by derivated_with_respect_to_y


# formula for the newton raphson method for multiple variables
# x^(i + 1) = x^i - inverse_of_matrix(J(x)^i) * (matrix([[f1], [f2]]) -> 2 X 1 matrix)
def calculate_minimum a, b, x, y, iterations=1
  inversed_matrix = Matrix[[derivate_f1_with_respect_to_x(b, x, y), derivate_f1_with_respect_to_y(b, x)], [derivate_f2_with_respect_to_x(b, x), derivate_f2_with_respect_to_y(b)]].inverse
  values = Matrix[[x], [y]] - (inversed_matrix * Matrix[[derivated_with_respect_to_x(a, b, x, y)], [derivated_with_respect_to_y(a, b, x, y)]])

  new_x, new_y = values[0, 0], values[1, 0]

  data = if (sprintf( "%0.05f", new_x).to_f == sprintf( "%0.05f", x).to_f && sprintf( "%0.05f", new_y).to_f == sprintf( "%0.05f", y).to_f)
    [new_x, new_y, iterations]
  else
    calculate_minimum(a, b, new_x, new_y, iterations + 1)
  end

  data
end

converged_data = calculate_minimum(a, b, x, y)

puts "Total number of iterations = #{converged_data[2]}"
puts "Converged to Minimum of x = #{converged_data[0]} and y = #{converged_data[1]}"
