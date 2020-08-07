import requests

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


def stringify_multiplication(A, B):
    return "\n".join([
        to_latex(A),
        "\cdot",
        to_latex(B),
        "~=~",
        to_latex(A.multiply(B)),
    ])


class Ops(object):
    def __init__(self, num_mul, num_add):
        self.num_mul = num_mul
        self.num_add = num_add

    @property
    def num_ops(self):
        return self.num_mul + self.num_add

    def __str__(self):
        return "{} ({} mul, {} add)".format(self.num_ops, self.num_mul, self.num_add)


def count_multiplication_ops(A, B):
    s = to_latex(A.multiply(B))
    num_mul = s.count("\\cdot")
    num_add = s.count("+")
    return Ops(num_mul, num_add)


def fetch_rendered_formula(filename, latex):
    r = requests.get("https://latex.codecogs.com/png.latex?{}".format(latex), allow_redirects=True)

    # Hack for "formula too long"
    if r.status_code == 414:
        latex = latex.split("~=~")[-1]
        r = requests.get("https://latex.codecogs.com/png.latex?{}".format(latex), allow_redirects=True)

    assert r.status_code == 200

    with open(filename, "wb") as f:
        f.write(r.content)

    # import IPython; IPython.embed()


def check(name, A, M):
    print("\n *** {}".format(name))

    expression_lm = stringify_multiplication(A, M)
    expression_rm = stringify_multiplication(M, A)

    ops_lm = count_multiplication_ops(A, M)
    ops_rm = count_multiplication_ops(M, A)

    print("\nLeft multiply:\n")
    print(expression_lm)
    print("\nOperations: {}".format(ops_lm))

    print("\nRight multiply:\n")
    print(expression_rm)
    print("\nOperations: {}".format(ops_rm))

    fetch_rendered_formula("formulas/{}_lm.png".format(name), expression_lm)
    fetch_rendered_formula("formulas/{}_rm.png".format(name), expression_rm)


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
    check("Translation", T, M)


def check_scale():
    var('a b c d e f g h i j x y z s_x s_y s_z')
    T = Matrix([
        [s_x, 0,   0,   0],
        [0,   s_y, 0,   0],
        [0,   0,   s_z, 0],
        [0,   0,   0,   1],
    ])
    M = Matrix([
        [a, b, c, x],
        [d, e, f, y],
        [g, h, i, z],
        [0, 0, 0, 1],
    ])
    check("Scale", T, M)


def check_rotation():
    var('a b c d e f g h i j x y z ap bp cp dp ep fp gp hp ip jp')
    R = Matrix([
        [ap, bp, cp, 0],
        [dp, ep, fp, 0],
        [gp, hp, ip, 0],
        [0, 0, 0, 1],
    ])
    M = Matrix([
        [a, b, c, x],
        [d, e, f, y],
        [g, h, i, z],
        [0, 0, 0, 1],
    ])
    check("Rotation", R, M)


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
    check("Transform", M1, M2)


check_translation()
check_scale()
check_rotation()
check_transform()
