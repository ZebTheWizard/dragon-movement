extends Node


var tween: Tween
func Animate() -> Tween:
	if tween:
		tween.kill() # Abort the previous animation.
	tween = create_tween()
	return tween
