/**
*	Cursors and windows.
*/
module glfw3d.Window;

version(Have_derelict_glfw3) {
	import derelict.glfw3.glfw3;
} else {
	import glfw3d.glfw3;
}
import glfw3d.Main;
import glfw3d.Monitor;
import std.string : fromStringz;

/**
*	Utility structs. No documentation needed, isn't it?
*/
struct WindowPosition {
	int x, y;
}
/// ditto
struct WindowSize {
	int width, height;
}
/// ditto
struct FrameSize {
	int left, top, right, bottom;
}
/// ditto
struct CursorPosition {
	double x, y;
}

/**
*	Wrapper around GLFWcursor struct
*/
class Cursor {
	private GLFWcursor* cursor;

	/**
	*	It can be used to direct access to glfw3 functions.
	*	Returns: pointer to GLFWcursor
	*/
	GLFWcursor* ptr() {
		return this.cursor;
	}

	/**
	*	Destroys cursor
	*/
	~this() {
		this.destroy();
	}

	/**
	*	Creates basic arrow cursor
	*/
	this() {
		this(GLFW_ARROW_CURSOR);
	}

	/**
	*	Creates cursor with standard shape.
	*	See_Also:
	*		$(LINK http://www.glfw.org/docs/latest/group__shapes.html)
	*/
	this(int shape) {
		this.cursor = glfwCreateStandardCursor(shape);
	}

	/**
	*	Creates cursor with non-standard shape.
	*/
	this(const(GLFWimage)* img, int xhot, int yhot) {
		this.cursor = glfwCreateCursor(img, xhot, yhot);
	}

	/**
	*	Destroys current cursor
	*/
	void destroy() {
		glfwDestroyCursor(this.cursor);
	}
}

/**
*	Wrapper around GLFWwindow struct.
*/
class Window {
	private GLFWwindow* window;

	/**
	*	It can be used to direct access to glfw3 functions.
	*	Returns: pointer to GLFWwindow
	*/
	GLFWwindow* ptr() {
		return this.window;
	}

	/**
	*	Destroys window
	*/
	~this() {
		this.destroy();
	}

	/**
	*	Creates window
	*	Params:
	*		width = Width of new window
	*		height = Height of new window
	*		title = Title of new window
	*		mon = Make window full-screen on this monitor
	*		share = Share context with this window
	*/
	this(int width,
		int height,
		string title) {
			this(width,
				height,
				title,
				cast(GLFWmonitor*) null,
				cast(GLFWwindow*) null);
	}
	/// ditto
	this(int width,
		int height,
		string title,
		glfw3d.Monitor.Monitor mon) {
			this(width, height, title, mon.ptr, null);
	}
	/// ditto
	this(int width,
		int height,
		string title,
		glfw3d.Window.Window share) {
			this(width, height, title, null, share.ptr);
	}
	/// ditto
	this(int width,
		int height,
		string title,
		glfw3d.Monitor.Monitor mon,
		glfw3d.Window.Window share) {
			this(width, height, title, mon.ptr, share.ptr);
	}
	/// ditto
	this(int width,
		int height,
		string title,
		GLFWmonitor* mon,
		GLFWwindow* share) {
			this.window = glfwCreateWindow(width,
				height,
				cast(const(char)*) title,
				mon,
				share);
			if(!this.window)
				throw new glfw3dException("Window or OpenGL context creation failed");
	}

	/**
	*	Destroys window
	*/
	void destroy() {
		glfwDestroyWindow(this.window);
	}

	/**
	*	Example:
	*	---
	*	auto w = new Window(640, 480, "Test");
	*	while(!w.shouldClose()) {
	*		// Main app loop
	*	}
	*	---
	*/
	int shouldClose() {
		return glfwWindowShouldClose(this.window);
	}

	/**
	*	Sets shouldClose
	*/
	void setShouldClose(int v) {
		glfwSetWindowShouldClose(this.window, v);
	}

	/**
	*	Sets window title
	*/
	void setTitle(string t) {
		glfwSetWindowTitle(this.window, cast(const(char)*) t);
	}

	/**
	*	Sets window icon
	*/
	void setIcon(int count, const(GLFWimage)* img) {
		glfwSetWindowIcon(this.window, count, img);
	}

	/**
	*	Returns: position of current window
	*/
	WindowPosition getPosition() {
		int x, y;
		glfwGetWindowPos(this.window, &x, &y);
		return WindowPosition(x, y);
	}

	/**
	*	Sets position of window
	*/
	void setPosition(WindowPosition w) {
		this.setPosition(w.x, w.y);
	}
	/// ditto
	void setPosition(int x, int y) {
		glfwSetWindowPos(this.window, x, y);
	}

	/**
	*	Returns: size of current window
	*/
	WindowSize getSize() {
		int w, h;
		glfwGetWindowSize(this.window, &w, &h);
		return WindowSize(w, h);
	}

	/**
	*	Sets size of window
	*/
	void setSize(WindowSize w) {
		this.setSize(w.width, w.height);
	}
	/// ditto
	void setSize(int width, int height) {
		glfwSetWindowSize(this.window, width, height);
	}

	/**
	*	Sets size limits of window
	*/
	void setSizeLimits(int minWidth,
		int minHeight,
		int maxWidth,
		int maxHeight) {
			glfwSetWindowSizeLimits(
				this.window,
				minWidth,
				minHeight,
				maxWidth,
				maxHeight
			);
	}

	/**
	*	Example:
	*	---
	*	w.setAspectRatio(16, 9); // Window now always 16:9
	*	w.setAspectRatio(4, 3); // Window is 4:3
	*	---
	*/
	void setAspectRatio(int number, int denom) {
		glfwSetWindowAspectRatio(this.window, number, denom);
	}

	/**
	*	Returns: size of framebuffer
	*/
	WindowSize getFramebufferSize() {
		int w, h;
		glfwGetFramebufferSize(this.window, &w, &h);
		return WindowSize(w, h);
	}

	/**
	*	Returns: size, in screen coordinates, of each edge of the frame of the current window.
	*/
	FrameSize getFrameSize() {
		int l, t, r, b;
		glfwGetWindowFrameSize(this.window, &l, &t, &r, &b);
		return FrameSize(l, t, r, b);
	}

	/**
	*	Minimizes(Iconifiezes) current window.
	*/
	void iconify() {
		glfwIconifyWindow(this.window);
	}

	/**
	*	Restores iconified window.
	*/
	void restore() {
		glfwRestoreWindow(this.window);
	}

	/**
	*	Maximizes window.
	*/
	void maximize() {
		glfwMaximizeWindow(this.window);
	}

	/**
	*	Shows window.
	*/
	void show() {
		glfwShowWindow(this.window);
	}

	/**
	*	Hides window.
	*/
	void hide() {
		glfwHideWindow(this.window);
	}

	/**
	*	Gives input focus to window.
	*/
	void focus() {
		glfwFocusWindow(this.window);
	}

	/**
	*	Returns: Monitor for fullscreen windows, or NULL for non-fullscreen windows.
	*/
	glfw3d.Monitor.Monitor getMonitor() {
		return new glfw3d.Monitor.Monitor(
			glfwGetWindowMonitor(this.window)
		);
	}

	/**
	*	Makes window fullscreen on specified monitor.
	*/
	void setMonitor(glfw3d.Monitor.Monitor m,
		WindowPosition pos,
		WindowSize size,
		int refreshRate) {
			glfwSetWindowMonitor(
				this.window,
				m.ptr,
				pos.x,
				pos.y,
				size.width,
				size.height,
				refreshRate
			);
	}

	/**
	*	Returns: Value of attribute $U(a)
	*/
	int getAttrib(int a) {
		return glfwGetWindowAttrib(this.window, a);
	}

	/**
	*	Sets user pointer for the window.
	*/
	void setUserPointer(void* pointer) {
		glfwSetWindowUserPointer(this.window, pointer);
	}

	/**
	*	Returns: user pointer of the window.
	*/
	void* getUserPointer() {
		return glfwGetWindowUserPointer(this.window);
	}

	/**
	*	Swaps front and back buffer.
	*/
	void swapBuffers() {
		glfwSwapBuffers(this.window);
	}

	/**
	*	Returns: current input mode
	*/
	int getInputMode(int mode) {
		return glfwGetInputMode(this.window, mode);
	}

	/**
	*	Sets input mode.
	*/
	void setInputMode(int mode, int value) {
		return glfwSetInputMode(this.window, mode, value);
	}

	/**
	*	Returns: last reported state of $U(key)
	*/
	int getKey(int key) {
		return glfwGetKey(this.window, key);
	}

	/**
	*	Returns: last reported state of $U(button)
	*/
	int getMouseButton(int button) {
		return glfwGetMouseButton(this.window, button);
	}

	/**
	*	Returns: position of the cursor
	*/
	CursorPosition getCursorPosition() {
		double x, y;
		glfwGetCursorPos(this.window, &x, &y);
		return CursorPosition(x, y);
	}

	/**
	*	Sets cursor position.
	*/
	void setCursorPosition(CursorPosition c) {
		this.setCursorPosition(c.x, c.y);
	}
	/// ditto
	void setCursorPosition(double x, double y) {
		glfwSetCursorPos(this.window, x, y);
	}

	/**
	*	Sets cursor.
	*/
	void setCursor(Cursor c) {
		this.setCursor(c.ptr());
	}
	/// ditto
	void setCursor(GLFWcursor* c) {
		glfwSetCursor(this.window, c);
	}

	/**
	*	Sets clipboard text.
	*/
	void setClipboard(string s) {
		glfwSetClipboardString(this.window, cast(const(char)*) s);
	}

	/**
	*	Returns: clipboard text
	*/
	string getClipboard() {
		return glfwGetClipboardString(this.window).fromStringz.idup;
	}

	/**
	*	After creation of context this makes context current.
	*/
	void makeContextCurrent() {
		glfwMakeContextCurrent(this.window);
	}

	/**
	*	Callbacks. More information in GLFW3 documentation.
	*/
	GLFWwindowposfun setPositionCallback(GLFWwindowposfun cb) {
		return glfwSetWindowPosCallback(this.window, cb);
	}
	/// ditto
	GLFWwindowsizefun setSizeCallback(GLFWwindowsizefun cb) {
		return glfwSetWindowSizeCallback(this.window, cb);
	}
	/// ditto
	GLFWwindowclosefun setCloseCallback(GLFWwindowclosefun cb) {
		return glfwSetWindowCloseCallback(this.window, cb);
	}
	/// ditto
	GLFWwindowrefreshfun setRefreshCallback(GLFWwindowrefreshfun cb) {
		return glfwSetWindowRefreshCallback(this.window, cb);
	}
	/// ditto
	GLFWwindowfocusfun setFocusCallback(GLFWwindowfocusfun cb) {
		return glfwSetWindowFocusCallback(this.window, cb);
	}
	/// ditto
	GLFWwindowiconifyfun setIconifyCallback(GLFWwindowiconifyfun cb) {
		return glfwSetWindowIconifyCallback(this.window, cb);
	}
	/// ditto
	GLFWframebuffersizefun setFramebufferSizeCallback(
		GLFWframebuffersizefun cb
	) {
		return glfwSetFramebufferSizeCallback(this.window, cb);
	}
	/// ditto
	GLFWkeyfun setKeyCallback(GLFWkeyfun cb) {
		return glfwSetKeyCallback(this.window, cb);
	}
	/// ditto
	GLFWcharfun setCharCallback(GLFWcharfun cb) {
		return glfwSetCharCallback(this.window, cb);
	}
	/// ditto
	GLFWcharmodsfun setCharModsCallback(GLFWcharmodsfun cb) {
		return glfwSetCharModsCallback(this.window, cb);
	}
	/// ditto
	GLFWmousebuttonfun setMouseButtonCallback(GLFWmousebuttonfun cb) {
		return glfwSetMouseButtonCallback(this.window, cb);
	}
	/// ditto
	GLFWcursorposfun setCursorPosCallback(GLFWcursorposfun cb) {
		return glfwSetCursorPosCallback(this.window, cb);
	}
	/// ditto
	GLFWcursorenterfun setCursorEnterCallback(GLFWcursorenterfun cb) {
		return glfwSetCursorEnterCallback(this.window, cb);
	}
	/// ditto
	GLFWscrollfun setScrollCallback(GLFWscrollfun cb) {
		return glfwSetScrollCallback(this.window, cb);
	}
	/// ditto
	GLFWdropfun setDropCallback(GLFWdropfun cb) {
		return glfwSetDropCallback(this.window, cb);
	}
}
