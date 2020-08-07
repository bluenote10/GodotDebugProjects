Title: Enable transform chaining by making scaled/rotated/translated consistent

# Issue

Basically every time I try to chain `.scaled`/`.rotated`/`.translated` I end up with a bug.

## General notes

Chaining transformation always requires to be aware of left-to-right or right-to-left thinking,
because the "mathematical reading order" is typically opposite to the "transformation order".
For instance
```
x' = C · B · A · x
```
first transforms `x` by `A`, then by `B`, then by `C`, opposite to how the mathematical equation is typically written.
Put another way:

- Transform left multiplication
  ```
  M' = A · M
  ```
  means that `A` is applied _after_ `M` is applied.

- Transform right multiplication
  ```
  M' = M · A
  ```
  means that `A` is applied _before_ `M` is applied.

## Current behavior

Currently the behavior is a mix of left and right multiplication.

- Scaled:
  ```
  var M_new = M.scaled(... S ...)
  ```
  has **left** multiplication semantics (i.e., happens _after_ in transformation order):
  ```
  M_new = S · M
  ```

- Rotated:
  ```
  var M_new = M.rotated(... R ...)
  ```
  has **left** multiplication semantics (i.e., happens _after_ in transformation order):
  ```
  M_new = R · M
  ```

- Translated:
  ```
  var M_new = M.translated(... T ...)
  ```
  has **right** multiplication semantics (i.e., happens _before_ in transformation order):
  ```
  M_new = M · T
  ```

## Hard to read

Because of mixing left and right multiplication, I find it fairly hard to look at chained
expressions and come up with the underlying mathematical order. Going from the code to the
mathematical expression cannot be done by reading in one direction, but rather requires to
switch between left-to-right and right-to-left thinking. For instance:

```gdscript
var M = Transform.IDENTITY\
    .scaled(... S ...)\
    .translated(... T ...)\
    .rotated(... R ...)
```
is equivalent to (if I didn't get it wrong again)
```
M = R · S · T
```
Note how `R` has moved from last to first, `S` has moved to the middle, and `T` ended up at the end.
The result feels almost like a random shuffle of the order written in the code.
Doing such transformations on longer expressions is a challenging and totally unnecessary mental exercise.

```
var M = Transform.IDENTITY\
    .scaled(... S ...)\
    .rotated(... R ...)\
    .translated(... T ...)
```
R S T



## Hard to write

Example 1: Impossible to write S T R with chaining

·

Example 2: Long example


## Performance aspects


# Solution

## API change

Similar to Eigen.

## Impact

Replace `translated` to `pre_translated`.
