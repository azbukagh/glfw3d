# glfw3d [![Page on DUB](https://img.shields.io/dub/v/glfw3d.svg)](http://code.dlang.org/packages/glfw3d) [![Licence](https://img.shields.io/dub/l/glfw3d.svg)](https://github.com/azbukagh/glfw3d/blob/master/LICENCE.md)
glfw3d is medium-level GLFW wrapper for D programming language.

## Why?
GLFW is very simple library. Just few calls to create OpenGL context and window.

This wrapper aimed to make it even more simplier.
- Uses std.experimental.logger. You can easily turn logging of or log to file
- OOP interfaice.

## Why "medium-level"?
High-level wrapper brings new enums, structs. You cannot just move from low-level wrapper to high-level, you have to rewrite a lot of code.
Medium-level wrapper uses both high and low-level features. You can use OOP interfaice, but you can also use low-level functions, if something went wrong.

## Licence
This wrapper licenced under terms of MIT licence.
GLFW licenced under terms of zlib/libpng licence.

