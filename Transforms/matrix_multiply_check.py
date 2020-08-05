from sympy import *


#print(M)
#print(T)

#M_prime = T.multiply(M)
#print(M_prime)

#M_prime = M.multiply(T)
#print(M_prime)

def to_latex(M):
    lines = []
    lines.append("\\begin{bmatrix}")
    for i in range(M.rows):
        row = M.row(i)
        symbols = list(row)
        stringified = " & ".join([str(symbol) for symbol in symbols])

        if i != 3:
            stringified += " \\\\"

        stringified = stringified\
            .replace("*", " \cdot ")\
            .replace("_prime", " \\prime ")\
            .replace("ap", "a \\prime ")\
            .replace("bp", "b \\prime ")\
            .replace("cp", "c \\prime ")\
            .replace("dp", "d \\prime ")\
            .replace("ep", "e \\prime ")\
            .replace("fp", "f \\prime ")\
            .replace("gp", "g \\prime ")\
            .replace("hp", "h \\prime ")\
            .replace("ip", "i \\prime ")\
            .replace("jp", "j \\prime ")\
            .replace("xp", "x \\prime ")\
            .replace("yp", "y \\prime ")\
            .replace("zp", "z \\prime ")

        lines.append(stringified)

    lines.append("\\end{bmatrix}")
    return "\n".join(lines)


def print_multiplication(A, B):
    print(to_latex(A))
    print("\cdot")
    print(to_latex(B))
    print("~=~")
    print(to_latex(A.multiply(B)))


def check_translation():
    var('a b c d e f g h i j x y z x_prime y_prime z_prime s_x s_y s_z')
    T = Matrix([
        [1, 0, 0, x_prime],
        [0, 1, 0, y_prime],
        [0, 0, 1, z_prime],
        [0, 0, 0, 1],
    ])
    M = Matrix([
        [a, b, c, x],
        [d, e, f, y],
        [g, h, i, z],
        [0, 0, 0, 1],
    ])

    print("\nTranslation left multiply")
    print_multiplication(T, M)

    print("\nTranslation right multiply")
    print_multiplication(M, T)


def check_transform():
    var('a b c d e f g h i j x y z ap bp cp dp ep fp gp hp ip jp xp yp zp')
    M1 = Matrix([
        [a, b, c, x],
        [d, e, f, y],
        [g, h, i, z],
        [0, 0, 0, 1],
    ])
    M2 = Matrix([
        [ap, bp, cp, xp],
        [dp, ep, fp, yp],
        [gp, hp, ip, zp],
        [0, 0, 0, 1],
    ])

    print("\nTransforms left multiply")
    print_multiplication(M1, M2)

    print("\nTransforms right multiply")
    print_multiplication(M2, M1)


check_translation()
check_transform()
