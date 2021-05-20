
import questionable
import ../../src/treelib

type NumberTree = ref object
  value: int
  children: seq[NumberTree]
  parent: ?NumberTree

block add:
  let numTree = NumberTree()
  let child = NumberTree()
  numTree.add(child)

  doAssert numTree.children.len == 1
  doAssert !child.parent == numTree

block drop:
  let numTree = NumberTree()
  let child = NumberTree()
  numTree.add(child)
  child.add(NumberTree())

  child.drop()
  doAssert numTree.children.len == 0
  doAssert child.parent.isNone

block insert:
  let numTree = NumberTree()
  let child = NumberTree()
  const index = 1
  numTree.add(NumberTree())
  numTree.add(NumberTree())
  numTree.insert(child, index)

  doAssert numTree.children[index] == child
  doAssert !child.parent == numTree
  doAssert numTree.children.len == 3
