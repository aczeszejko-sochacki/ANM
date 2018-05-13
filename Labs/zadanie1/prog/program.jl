function moler_morisson(p, q)
    
    r = (q/p)^2
    s = r/(4 + r)
    p = p + 2*s*p
    q = s*q
    
    return p, q
end

function moler_morisson_iterable(a, b, k)
    a = abs(a)
    b = abs(b)
    p = max(a, b)
    q = min(a,b)
    
    for i in 1:k
        p, q = moler_morisson(p, q)
        println(p)
    end
end

set_bigfloat_precision(128)

moler_morisson_iterable(3, 4, 3)
moler_morisson_iterable(BigFloat(3), BigFloat(4), 3)

moler_morisson_iterable(-5, 12, 3)
moler_morisson_iterable(BigFloat(-5), BigFloat(12), 3)

moler_morisson_iterable(7, -24, 3)
moler_morisson_iterable(BigFloat(7), BigFloat(-24), 3)

moler_morisson_iterable(1, 1, 3)
moler_morisson_iterable(BigFloat(1), BigFloat(1), 3)

moler_morisson_iterable(1000000000, 2, 3)
moler_morisson_iterable(BigFloat(1000000000), BigFloat(2), 3)

moler_morisson_iterable(71075075103, 1000000000, 3)
moler_morisson_iterable(BigFloat(71075075103), BigFloat(1000000000), 3)

function exact_result(a, b)
    println(sqrt((BigFloat(a))^2 + (BigFloat(b))^2))
end

exact_result(3, 4)
exact_result(-5, 12)
exact_result(7, -24)
exact_result(1, 1)
exact_result(1000000000, 2)
exact_result(71075075103, 1000000000)

function relative_error(incorrect, exact)
    println(abs(BigFloat(incorrect) - exact) / exact)
end

relative_error(5.000000000000001, 5.0000000000000000000000000000000)
relative_error(13.000000000000002, 1.300000000000000000000000000000000000000e+01)
relative_error(25.000000000000004, 2.500000000000000000000000000000000000000e+01)
relative_error(1.4142135623730951, 1.414213562373095048801688724209698078569)
relative_error(1.0e9, 1.000000000000000001999999999999999998001e+09)
relative_error(7.10821095698284e10, 7.108210956982840179871838428090505048092e+10)

relative_error(4.999999999999999999999999828030176654495, 5.0000000000000000000000000000000)
relative_error(1.299999999999999999999999999999999999948e+01, 1.300000000000000000000000000000000000000e+01)
relative_error(2.500000000000000000000000000000000000000e+01, 2.500000000000000000000000000000000000000e+01)
relative_error(1.41421356237309504879564008075425994635, 1.414213562373095048801688724209698078569)
relative_error(1.000000000000000001999999999999999998001e+09, 1.000000000000000001999999999999999998001e+09)
relative_error(7.108210956982840179871838428090505048132e+10, 7.108210956982840179871838428090505048092e+10)