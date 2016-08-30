module glfw3d.Window;

import glfw3d.glfw3;
import glfw3d.Main;
import glfw3d.Monitor;
import std.string : fromStringz;

struct WindowPosition {
	int x, y;
}

struct WindowSize {
	int width, height;
}

struct FrameSize {
	int left, top, right, bottom;
}

struct CursorPosition {
	double x, y;
}

class Cursor {
	private GLFWcursor* cursor;

	GLFWcursor* ptr() {
		return this.cursor;
	}

	~this() {
		this.destroy();
	}

	this() {
		this(GLFW_ARROW_CURSOR);
	}

	this(int shape) {
		this.cursor = glfwCreateStandardCursor(shape);
	}

	this(const(GLFWimage)* img, int xhot, int yhot) {
		this.cursor = glfwCreateCursor(img, xhot, yhot);
	}

	void destroy() {
		glfwDestroyCursor(this.cursor);
	}
}

class Window {
	private GLFWwindow* window;

	GLFWwindow* ptr() {
		return this.window;
	}

	~this() {
		this.destroy();
	}

	this(int width,
		int height,
		string title) {
			this(width,
				height,
				title,
				cast(GLFWmonitor*) null,
				cast(GLFWwindow*) null);
	}

	this(int width,
		int height,
		string title,
		glfw3d.Monitor.Monitor mon) {
			this(width, height, title, mon.ptr, null);
	}

	this(int width,
		int height,
		string title,
		glfw3d.Window.Window share) {
			this(width, height, title, null, share.ptr);
	}

	this(int width,
		int height,
		string title,
		glfw3d.Monitor.Monitor mon,
		glfw3d.Window.Window share) {
			this(width, height, title, mon.ptr, share.ptr);
	}

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

	void defaultHints() {
		glfwDefaultWindowHints();
	}

	void hint(int hint, int value) {
		glfwWindowHint(hint, value);
	}

	void destroy() {
		glfwDestroyWindow(this.window);
	}

	int shouldClose() {
		return glfwWindowShouldClose(this.window);
	}

	void setShouldClose(int v) {
		glfwSetWindowShouldClose(this.window, v);
	}

	void setTitle(string t) {
		glfwSetWindowTitle(this.window, cast(const(char)*) t);
	}

	void setIcon(int count, const(GLFWimage)* img) {
		glfwSetWindowIcon(this.window, count, img);
	}

	WindowPosition getPosition() {
		int x, y;
		glfwGetWindowPos(this.window, &x, &y);
		return WindowPosition(x, y);
	}

	void setPosition(WindowPosition w) {
		this.setPosition(w.x, w.y);
	}

	void setPosition(int x, int y) {
		glfwSetWindowPos(this.window, x, y);
	}

	WindowSize getSize() {
		int w, h;
		glfwGetWindowSize(this.window, &w, &h);
		return WindowSize(w, h);
	}

	void setSize(WindowSize w) {
		this.setSize(w.width, w.height);
	}

	void setSize(int width, int height) {
		glfwSetWindowSize(this.window, width, height);
	}

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

	void setAspectRation(int number, int denom) {
		glfwSetWindowAspectRatio(this.window, number, denom);
	}

	WindowSize getFramebufferSize() {
		int w, h;
		glfwGetFramebufferSize(this.window, &w, &h);
		return WindowSize(w, h);
	}

	FrameSize getFrameSize() {
		int l, t, r, b;
		glfwGetWindowFrameSize(this.window, &l, &t, &r, &b);
		return FrameSize(l, t, r, b);
	}

	void iconify() {
		glfwIconifyWindow(this.window);
	}

	void restore() {
		glfwRestoreWindow(this.window);
	}

	void maximize() {
		glfwMaximizeWindow(this.window);
	}

	void show() {
		glfwShowWindow(this.window);
	}

	void hide() {
		glfwHideWindow(this.window);
	}

	void focus() {
		glfwFocusWindow(this.window);
	}

	glfw3d.Monitor.Monitor getMonitor() {
		return new glfw3d.Monitor.Monitor(
			glfwGetWindowMonitor(this.window)
		);
	}

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

	int getAttrib(int a) {
		return glfwGetWindowAttrib(this.window, a);
	}

	void setUserPointer(void* pointer) {
		glfwSetWindowUserPointer(this.window, pointer);
	}

	void* getUserPointer() {
		return glfwGetWindowUserPointer(this.window);
	}

	void swapBuffers() {
		glfwSwapBuffers(this.window);
	}

	int getInputMode(int mode) {
		return glfwGetInputMode(this.window, mode);
	}

	void setInputMode(int mode, int value) {
		return glfwSetInputMode(this.window, mode, value);
	}

	int getKey(int key) {
		return glfwGetKey(this.window, key);
	}

	int getMouseButton(int button) {
		return glfwGetMouseButton(this.window, button);
	}

	CursorPosition getCursorPosition() {
		double x, y;
		glfwGetCursorPos(this.window, &x, &y);
		return CursorPosition(x, y);
	}

	void setCursorPosition(CursorPosition c) {
		this.setCursorPosition(c.x, c.y);
	}

	void setCursorPosition(double x, double y) {
		glfwSetCursorPos(this.window, x, y);
	}

	void setCursor(Cursor c) {
		this.setCursor(c.ptr());
	}

	void setCursor(GLFWcursor* c) {
		glfwSetCursor(this.window, c);
	}

	void setClipboard(string s) {
		glfwSetClipboardString(this.window, cast(const(char)*) s);
	}

	string getClipboard() {
		return glfwGetClipboardString(this.window).fromStringz.idup;
	}

	GLFWwindowposfun setPositionCallback(GLFWwindowposfun cb) {
		return glfwSetWindowPosCallback(this.window, cb);
	}

	GLFWwindowsizefun setSizeCallback(GLFWwindowsizefun cb) {
		return glfwSetWindowSizeCallback(this.window, cb);
	}

	GLFWwindowclosefun setCloseCallback(GLFWwindowclosefun cb) {
		return glfwSetWindowCloseCallback(this.window, cb);
	}

	GLFWwindowrefreshfun setRefreshCallback(GLFWwindowrefreshfun cb) {
		return glfwSetWindowRefreshCallback(this.window, cb);
	}

	GLFWwindowfocusfun setFocusCallback(GLFWwindowfocusfun cb) {
		return glfwSetWindowFocusCallback(this.window, cb);
	}

	GLFWwindowiconifyfun setIconifyCallback(GLFWwindowiconifyfun cb) {
		return glfwSetWindowIconifyCallback(this.window, cb);
	}

	GLFWframebuffersizefun setFramebufferSizeCallback(
		GLFWframebuffersizefun cb
	) {
		return glfwSetFramebufferSizeCallback(this.window, cb);
	}

	GLFWkeyfun setKeyCallback(GLFWkeyfun cb) {
		return glfwSetKeyCallback(this.window, cb);
	}

	GLFWcharfun setCharCallback(GLFWcharfun cb) {
		return glfwSetCharCallback(this.window, cb);
	}

	GLFWcharmodsfun setCharModsCallback(GLFWcharmodsfun cb) {
		return glfwSetCharModsCallback(this.window, cb);
	}

	GLFWmousebuttonfun setMouseButtonCallback(GLFWmousebuttonfun cb) {
		return glfwSetMouseButtonCallback(this.window, cb);
	}

	GLFWcursorposfun setCursorPosCallback(GLFWcursorposfun cb) {
		return glfwSetCursorPosCallback(this.window, cb);
	}

	GLFWcursorenterfun setCursorEnterCallback(GLFWcursorenterfun cb) {
		return glfwSetCursorEnterCallback(this.window, cb);
	}

	GLFWscrollfun setScrollCallback(GLFWscrollfun cb) {
		return glfwSetScrollCallback(this.window, cb);
	}

	GLFWdropfun setDropCallback(GLFWdropfun cb) {
		return glfwSetDropCallback(this.window, cb);
	}
}

