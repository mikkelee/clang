set(LLVM_LINK_COMPONENTS support)

add_clang_library(clangFormat
  BreakableToken.cpp
  ContinuationIndenter.cpp
  Format.cpp
  FormatToken.cpp
  TokenAnnotator.cpp
  UnwrappedLineParser.cpp
  WhitespaceManager.cpp
  )

add_dependencies(clangFormat
  ClangAttrClasses
  ClangAttrList
  ClangDeclNodes
  ClangDiagnosticCommon
  ClangDiagnosticFrontend
  ClangStmtNodes
  )

target_link_libraries(clangFormat
  clangBasic
  clangLex
  clangTooling
  )
