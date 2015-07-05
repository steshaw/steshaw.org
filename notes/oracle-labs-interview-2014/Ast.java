class Main {

  // data OpType = Mul | Plus
  enum OpType { 
    Mul, 
    Plus 
  }



  interface Function<R, A> {

  }

  // data Node = Leaf Int | Operator OpType Node Node
  interface Node {
    <T> T fold(Function<Int, T> leaf, Function<OpType, Node, Node, T> operator);
  }

  // ctr leaf
  public Node leaf(final int n) {
    return new Node() {
      <T> T fold(Function<Int, T> l, Function<OpType, Node, Node, T> operator) {
        return l.apply(n);
      }
    };
  }

  // ctr operator
  public Node operator(final OpType opType, final Node left, final Node right) {
    return new Node() {
      <T> T fold(Function<Int, T> leaf, Function<OpType, Node, Node, T> o) {
        return o.apply(opType, left, right);
      }
    };
  }

  final Node exp = operator(Mul, leaf(4), operator(Plus, leaf(2), leaf(3)));

  public int applyOp(OpType ot, Node left, Node right) {
    switch (ot) {
      case Num:
        return eval(left) + 
        break;

      case Plus:
        break;
    }
  }

  public int eval(Node n) {
    n.fold(identity, applyOp);
  }

  // TODO: Implement distribution of multiplication.

  // i.e. Mul(e0, Plus(e1, e2)) => Plus(Mul(e0, e1), Mul(e0, e2))

}