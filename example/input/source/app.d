import std.stdio;
import glfw3d;
import glfw3d.glfw3;
import std.array;
import std.format;

template Key(string name) {
	const char[] Key = q{
		case GLFW_KEY_} ~ name ~ q{:
			output.put(} ~ "\"" ~ name ~ ": \"); " ~ q{
			break;
	};
}

template Mod(string name) {
	const char[] Mod = q{
		case GLFW_MOD_} ~ name ~ q{:
			output.put(} ~ "\"" ~ name ~ "; \"); " ~ q{
			break;
	};
}

extern(C) nothrow void key_callback(GLFWwindow* window,
	int key,
	int scancode,
	int action,
	int mods) {
		auto output = appender!string();
		switch(key) {
			mixin(Key!("UNKNOWN"));
			mixin(Key!("SPACE"));
			mixin(Key!("APOSTROPHE"));
			mixin(Key!("COMMA"));
			mixin(Key!("MINUS"));
			mixin(Key!("PERIOD"));
			mixin(Key!("SLASH"));
			mixin(Key!("0"));
			mixin(Key!("1"));
			mixin(Key!("2"));
			mixin(Key!("3"));
			mixin(Key!("4"));
			mixin(Key!("5"));
			mixin(Key!("6"));
			mixin(Key!("7"));
			mixin(Key!("8"));
			mixin(Key!("9"));
			mixin(Key!("SEMICOLON"));
			mixin(Key!("EQUAL"));
			mixin(Key!("A"));
			mixin(Key!("B"));
			mixin(Key!("C"));
			mixin(Key!("D"));
			mixin(Key!("E"));
			mixin(Key!("F"));
			mixin(Key!("G"));
			mixin(Key!("H"));
			mixin(Key!("I"));
			mixin(Key!("J"));
			mixin(Key!("K"));
			mixin(Key!("L"));
			mixin(Key!("M"));
			mixin(Key!("N"));
			mixin(Key!("O"));
			mixin(Key!("P"));
			mixin(Key!("Q"));
			mixin(Key!("R"));
			mixin(Key!("S"));
			mixin(Key!("T"));
			mixin(Key!("U"));
			mixin(Key!("V"));
			mixin(Key!("W"));
			mixin(Key!("X"));
			mixin(Key!("Y"));
			mixin(Key!("Z"));
			mixin(Key!("LEFT_BRACKET"));
			mixin(Key!("BACKSLASH"));
			mixin(Key!("RIGHT_BRACKET"));
			mixin(Key!("GRAVE_ACCENT"));
			mixin(Key!("WORLD_1"));
			mixin(Key!("WORLD_2"));
			mixin(Key!("ESCAPE"));
			mixin(Key!("ENTER"));
			mixin(Key!("TAB"));
			mixin(Key!("BACKSPACE"));
			mixin(Key!("INSERT"));
			mixin(Key!("DELETE"));
			mixin(Key!("RIGHT"));
			mixin(Key!("LEFT"));
			mixin(Key!("DOWN"));
			mixin(Key!("UP"));
			mixin(Key!("PAGE_UP"));
			mixin(Key!("PAGE_DOWN"));
			mixin(Key!("HOME"));
			mixin(Key!("END"));
			mixin(Key!("CAPS_LOCK"));
			mixin(Key!("SCROLL_LOCK"));
			mixin(Key!("NUM_LOCK"));
			mixin(Key!("PRINT_SCREEN"));
			mixin(Key!("PAUSE"));
			mixin(Key!("F1"));
			mixin(Key!("F2"));
			mixin(Key!("F3"));
			mixin(Key!("F4"));
			mixin(Key!("F5"));
			mixin(Key!("F6"));
			mixin(Key!("F7"));
			mixin(Key!("F8"));
			mixin(Key!("F9"));
			mixin(Key!("F10"));
			mixin(Key!("F11"));
			mixin(Key!("F12"));
			mixin(Key!("F13"));
			mixin(Key!("F14"));
			mixin(Key!("F15"));
			mixin(Key!("F16"));
			mixin(Key!("F17"));
			mixin(Key!("F18"));
			mixin(Key!("F19"));
			mixin(Key!("F20"));
			mixin(Key!("F21"));
			mixin(Key!("F22"));
			mixin(Key!("F23"));
			mixin(Key!("F24"));
			mixin(Key!("F25"));
			mixin(Key!("KP_0"));
			mixin(Key!("KP_1"));
			mixin(Key!("KP_2"));
			mixin(Key!("KP_3"));
			mixin(Key!("KP_4"));
			mixin(Key!("KP_5"));
			mixin(Key!("KP_6"));
			mixin(Key!("KP_7"));
			mixin(Key!("KP_8"));
			mixin(Key!("KP_9"));
			mixin(Key!("KP_DECIMAL"));
			mixin(Key!("KP_DIVIDE"));
			mixin(Key!("KP_MULTIPLY"));
			mixin(Key!("KP_SUBTRACT"));
			mixin(Key!("KP_ADD"));
			mixin(Key!("KP_ENTER"));
			mixin(Key!("KP_EQUAL"));
			mixin(Key!("LEFT_SHIFT"));
			mixin(Key!("LEFT_CONTROL"));
			mixin(Key!("LEFT_ALT"));
			mixin(Key!("LEFT_SUPER"));
			mixin(Key!("RIGHT_SHIFT"));
			mixin(Key!("RIGHT_CONTROL"));
			mixin(Key!("RIGHT_ALT"));
			mixin(Key!("RIGHT_SUPER"));
			mixin(Key!("MENU"));
			default:
				output.put("UNKNOWN: ");
				break;
		}

		switch(action) {
			case GLFW_RELEASE:
				output.put("release; ");
				break;
			case GLFW_PRESS:
				output.put("press; ");
				break;
			case GLFW_REPEAT:
				output.put("repeat; ");
				break;
			default:
				output.put("unknown; ");
				break;
		}

		string[] modifiers;
		(mods & GLFW_MOD_SHIFT) ? modifiers ~= "SHIFT" :
			modifiers ~= [];
		(mods & GLFW_MOD_CONTROL) ? modifiers ~= "CONTROL" :
			modifiers ~= [];
		(mods & GLFW_MOD_ALT) ? modifiers ~= "ALT" :
			modifiers ~= [];
		(mods & GLFW_MOD_SUPER) ? modifiers ~= "SUPER" :
			modifiers ~= [];

		try {
			output.formattedWrite("%-(%s+%); %3d;", modifiers, scancode);
		} catch(Throwable) {}

		try {
			writeln(output.data);
		} catch(Throwable) {}
}


void main() {
	glfwInit();
	glfw3dInit();
	Window w = new Window(640, 480, "glfw3d example");
	w.setKeyCallback(&key_callback);
	while(!w.shouldClose()) {
		glfwPollEvents();
	}

	glfw3dTerminate();
}
