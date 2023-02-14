1. codesign
> https://red.macoder.tech/1/2/#_2

2. objdump
    ```bash
    # https://en.wikipedia.org/wiki/Object_file
    $ gcc toolsdemo.m -c # <==> clang toolsdemo.m -c

    # -m/--macho 解析为Mach-O文
    # --dylibs-used 所加载的dylibs
    $ objdump -m --dylibs-used toolsdemo
    $ objdump -m --dylibs-used shared_cache/usr/lib/libSystem.B.dylib

    # 使用 -h 或 --section-headers 将显示每节的标题信息
    $ objdump -m -h toolsdemo

    # 展示符号表
    $ objdump -m --syms toolsdemo

    # Mach-O头文件和所有的加载命令
    $ objdump -m --all-headers toolsdemo

    # 转储原始数据
    ## __cstring <==> C字符串
    ## __objc_methname <==> Objective-C方法名称
    $ objdump -m --full-contents toolsdemo

    # 代码反汇编
    # -x86-asm-syntax=att
    $ objdump --disassemble-symbols=_hello -x86-asm-syntax=intel toolsdemo
    $ objdump -d toolsdemo
    ```

3. jtool2
    
    [http://www.newosxbook.com/tools/jtool.html](http://www.newosxbook.com/tools/jtool.html)
    
    `brew install --cask jtool2`
    
    m1 下运行有点问题，`lipo jtool2 -thin x86_64 -output jtool2.x86_64` 瘦身为`x86`就能跑了。
    
    ```bash
    # 加载命令
    $ jtool2 -l toolsdemo
    # 加载动态
    $ jtool2 -L toolsdemo
    # 显示符号信息
    $ jtool2 -S toolsdemo
    # --sig 签名信息
    $ ARCH=arm64e jtool2 --sig /System/Applications/Automator.app/Contents/MacOS/Automator
    $ ARCH=x86_64 jtool2 --sig /System/Applications/Automator.app/Contents/MacOS/Automator
    # --ent 权限信息
    $ ARCH=arm64e jtool2 --ent /System/Applications/Automator.app/Contents/MacOS/Automator
    $ ARCH=x86_64 jtool2 --ent /System/Applications/Automator.app/Contents/MacOS/Automator
    # 反编译 （only arm）
    $ jtool2 -d toolsdemo
    ```