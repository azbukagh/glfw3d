/**
*	Publically imports all hight-level modules.
*/
module glfw3d;

public import glfw3d.Main;
public import glfw3d.Window;
public import glfw3d.Monitor;
public import glfw3d.Input;
version(Have_derelict_glfw3) {
	public import derelict.glfw3.glfw3;
} else {
	public import glfw3d.glfw3;
}
