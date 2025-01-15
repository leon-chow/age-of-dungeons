extends Node

class_name Character

var hp: int
var atk: int
var def: int
var matk: int
var mdef: int

func _init(hp, atk, def, matk, mdef):
	self.hp = hp
	self.atk = atk
	self.def = def
	self.matk = matk
	self.mdef = mdef
