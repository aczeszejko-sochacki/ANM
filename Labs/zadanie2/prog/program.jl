function search_bounds(x_p, x_k, x, nodes)
    if x_p + 1 == x_k
        return nodes[x_p], nodes[x_k]
    else
        if x > nodes[div((x_p + x_k), 2)]
            search_bounds(div((x_p + x_k), 2), x_k, x, nodes)
        else
            search_bounds(x_p, div((x_p + x_k), 2), x, nodes)
        end
    end
end;

function approx_derivate(f, nodes, x)
    interval = search_bounds(1, length(nodes), x, nodes)
    x_p = BigFloat(interval[1])
    x_k = BigFloat(interval[2])
    
    return Float64((f(x_k) - f(x_p)) / (x_k - x_p))
end;

function coefs(nodes, f) 
    all_coefs = [];
    
    quots = map(f, nodes)
    push!(all_coefs, quots[1])
    
    len = length(nodes)
    for i = 1:(len-1)
        for j = 1:(len-i)
           quots[j] = (quots[j+1] - quots[j] ) / (nodes[j+i] - nodes[j])
        end
        push!(all_coefs, quots[1])
    end
    
    return all_coefs
end;

function newton_interpolation(nodes, f)
    nodes_number = length(nodes)
    all_coefs = coefs(nodes, f)
    
    newton = Poly([all_coefs[1]])
    actual_poly = Poly([1])
    for i in 2:nodes_number
        actual_poly *= Poly([-nodes[i-1], 1])
        newton += actual_poly * all_coefs[i] 
    end
    
    return newton
end;

function newton_derivate(f, nodes, point)
    return Float64(polyval(polyder(newton_interpolation(nodes, f)), BigFloat(point)))
end;

function test_nodes(f, nodes1, nodes2, nodes3, x)
    return [approx_derivate(f, nodes1, x) approx_derivate(f, nodes2, x) approx_derivate(f, nodes3, x) newton_derivate(f, nodes1, x) newton_derivate(f, nodes2, x) newton_derivate(f, nodes3, x)]
end;

function relative_errors(p, f, nodes1, nodes2, nodes3, x)
    return map(y -> abs((y - p(x)) / p(x)), [approx_derivate(f, nodes1, x) approx_derivate(f, nodes2, x) approx_derivate(f, nodes3, x) newton_derivate(f, nodes1, x) newton_derivate(f, nodes2, x) newton_derivate(f, nodes3, x)])    
end;