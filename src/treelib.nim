import macros
import options
import questionable
import questionable/results

type
  TreeNode*[V] {.explain.} = concept t, type T
    t.value is V
    t.children is seq[type t]
    t.parent is ?T

using self: TreeNode

# proc `$`*(self; indent = "", last = true): string =
#   let name = if self.isWindow: self.value.window.title
#              else: "Container"
#   let nextIndent = if last: "   "
#                    else: "|  "
#   result = indent & "+- " & name & '\n'

#   for i, child in self.children:
#     result.add `$`(child, indent & nextIndent, i == self.children.len)

# proc allSiblings*(self): seq[TreeNode] =
#   if not self.isRootNode:
#     result = self.parent.children

proc nodeIndex(self): ?!int =
  result = failure "Could not find self amongst parent children"
  if allSiblings =? self.parent.?children:
    let index = allSiblings.find(self)
    if index >= 0:
      result = success index

# proc siblingIndex*(self; dir: SiblingDirection): ?int =
#   if not self.isRootNode:
#     let index = self.nodeIndex
#     let siblingIndex = clamp(index + ord(dir), 0, self.allSiblings.len-1)
#     if index != siblingIndex:
#       result = some siblingIndex

# proc findSibling*(self; dir: SiblingDirection): ?TreeNode =
#   if not self.isRootNode:
#     if si =? self.siblingIndex(dir):
#       result = some self.allSiblings[si]

proc insert*(self; value: TreeNode, index: int) =
    value.parent = some self
    self.children.insert(value, index)

proc add*(self, value: TreeNode) =
  value.parent = some self
  self.children.add(value)


# proc add*[T](self: TreeNode[T], value: T): TreeNode[T] {.discardable.} =
#   ## Add values as new nodes to self
#   ## return last node to be added
#   result = newTreeNode[T](value, self)
#   self.children.add(result)

# proc add*[T](self: TreeNode[T], values: seq[T]): seq[TreeNode[T]] {.discardable.} =
#   ## Add values as new nodes to self
#   ## return last node to be added
#   result = values.mapIt(self.add(it))

proc drop*(self) =
  if index =? self.nodeIndex and parent =? self.parent:
      parent.children.delete(index)
      self.parent = none type parent

# proc delete*(self) =
#   if not self.isRootNode:
#     let index = self.nodeIndex
#     self.drop()
#     for i, child in self.children:
#       self.parent.insert(child, index+i)

# proc walk*(self; operation: (TreeNode)->bool) =
#   if operation self: return
#   for child in self.children:
#     child.walk operation

# template walkIt*[T](self: TreeNode[T], body: untyped) =
#   self.walk do (it {.inject.}: TreeNode[T])->bool:
#     body

# template firstIt*[T](self: TreeNode[T], predicate: untyped): Option[TreeNode[T]] =
#   var matchinNode: Option[TreeNode[T]]
#   self.walkIt:
#     if predicate:
#       matchinNode = some it
#       return true
#   matchinNode

# template allIt*[T](self: TreeNode[T], predicate: untyped): seq[TreeNode[T]] =
#   var matchinNodes = newSeq[TreeNode[T]]()
#   self.walkIt:
#     if predicate:
#       matchinNodes.add it
#   matchinNodes