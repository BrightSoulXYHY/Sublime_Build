# Sublime_Build

虽然网上已有不少关于[sublime编译系统的教程](https://blog.qiujinfeng.com/archives/making-Sublime-Text-cplusplus-IDE.html)，但他们都没有解决python无法输入，c/c++文件编译无报错无回显等问题。

自定义Sublime的编译系统，完美解决python编译无法输入，C++编译无法报错等问题（基于VS2017）。并设置了8086的编译。

最开始折腾这些的想法是VS过于臃肿，最初折腾了MinGW的GCC和G++编译C，但编译无报错和是不是提示无法定位接口程序之类的十分蛋疼。之后查阅资料发现可以调用VS的cl编译便动了这个想法。不启动VS只是调用VS的编译器。
<!-- more -->

本文的所有编译脚本均以上传至[github](https://github.com/BrightSoulXYHY/Sublime_Build)

## Sublime的编译系统

sublime的编译系统为*.sublime-build，存于Sublime Text 64\Data\Packages\User文件夹下，可以自定义自己的编译系统，基本实例如下

Here is a footnote reference, and another.



```
{
     "shell_cmd":"F:/Progroming/_Path/build_cpp.bat $file_base_name $file_extension", 
    "file_regex": "^(..[^:]*):([0-9]+):?([0-9]+)?:? (.*)$",
    "working_dir": "${file_path}",
    "selector": "source.c, source.c++",
    "encoding": "cp936",
   
   "variants":
    [
        {   
        "name": "Run",
            "shell_cmd": "g++ -Wall -std=c++11 \"${file}\" -o \"${file_base_name}\" && start cmd /c \"\"${file_path}/${file_base_name}\" & pause\""
        }
    ]
}
}

```

| key | meaning |
| :--: | :--: |
|shell_cmd|调用编译的DOS命令|
|file_regex|获取编译错误时的信息|
|working_dir|工作目录|
|selector|筛选器与自动编译相关，source标识语言文件的定义中寻找*.tmPreferences|
|encoding|编码格式[^1]|
|variants|同一编译模式下的不同选项，可自定义改变一些参数|
|file_patterns|编译系统应该支持的文件模式，可以自定义设置，形如：["\*.py"]|
[^1]: 编码格式参考链接：https://docs.python.org/3.3/library/codecs.html#id3

一些常用的宏变量[^2]可以用于设置编译文件

[^2]: Sublime官方文档: https://www.sublimetext.com/docs/3/build_systems.html 

| 宏选项 | 意义 |
| :----: | :--: |
| $file_path | 当前文件所在路径, 比如 C:\Files. |
| $file | 当前文件的完整路径, 比如 C:\Files\Chapter1.txt. |
| $file_name  | 当前文件的文件名, 比如 Chapter1.txt. |
| $file_extension  | 当前文件的扩展名, 比如 txt. |
| $file_base_name  | 当前文件仅包含文件名的部分, 比如 Document. |
| $packages | Packages 文件夹的完整路径. |
| $project | 当前项目文件的完整路径. |
| $project_path | 当前项目文件的路径. |
| $project_name | 当前项目文件的名称. |
| $project_extension   | 当前项目文件的扩展部分. |
| $project_base_name   | 当前项目仅包括名的部分. |

## 自定义编译系统

虽然网上已有不少关于sublime编译系统的教程，但他们都没有解决python无法输入，c/c++文件编译无报错无回显等问题。

### python编译

由于python通过`"shell_cmd":"python -u $file"`已经可以解决编译运行问题，考虑的是如何新建窗口并进行输入和自动关闭。多次试验`"shell_cmd":"cmd /k start"`和`"shell_cmd":"cmd /c start"`后反应到sublime最下的显示框也是一个cmd窗口，调用`cmd /k start`是多此一举。

直接`start cmd /c python -u $file_name `即可
<img src="http://phpddgkm5.bkt.clouddn.com/18-11-9/88509459.jpg" alt="效果演示" style="height:600px" /> 
### C/C++编译

一段时间的应用之后MinGW终于崩溃了，总算是动了解决它的心思。查阅VS2017官方文档[^3]，发现可以调用开发者工具将一个DOS命令窗设置为不同的编译环境[^4]。因而解决问题的基本思路是打开DOS窗口设置为特定的编译环境，编译并运行*.exe。get✔

[^3]: MS官方文档: https://docs.microsoft.com/en-us/cpp/build/setting-the-path-and-environment-variables-for-command-line-builds?view=vs-2017

[^4]: 设置不同的编译模式:https://docs.microsoft.com/en-us/cpp/build/building-on-the-command-line?view=vs-2017

在`Microsoft Visual Studio\2017\Community\VC\Auxiliary\Build`目录中找到了需要的文件，考虑到32位代码更为通用，选择`vcvars32.bat"`进行设置。
编译脚本：

```bash
@echo off
REM 将打开的dos设置为32位编译环境
call "D:\SoftWare\Microsoft Visual Studio\2017\Community\VC\Auxiliary\Build\vcvars32.bat"
cl /EHsc %1.%2
start cmd /c %1.exe
```

<img src="http://phpddgkm5.bkt.clouddn.com/18-11-9/55585052.jpg" alt="效果演示" style="height:600px" />

### 基于8086的汇编语言编译

8086的汇编语言使用masm编译，奈何大部分机器不支持16位的远古程序因而得借用DOSBox模拟DOS进行编译和链接。关于[DOSBox的设置参见](https://www.dosbox.com/wiki/Basic_Setup_and_Installation_of_DosBoxhttps://www.dosbox.com/wiki/Basic_Setup_and_Installation_of_DosBox)

考虑到它是将一个文件夹目录映射为DOS的盘符，因而以下步骤需要将MASM全家桶和编译脚本放入一个固定的文件夹中。

查阅DOSBox的文档发现里面有一点启动选项的设置，果断使用执行name后退出的-exit选项，但效果不好。

最终在脚本中使用exit退出。

`dosbox [name] [-exit] [-c command] [-fullscreen] [-userconf]
​       [-conf congfigfilelocation] [-lang languagefilelocation]
​       [-machine machine type] [-noconsole] [-startmapper] [-noautoexec]
​       [-securemode] [-scaler scaler | -forcescaler scaler] [-version]
​       [-socket socket]`

>   name
> ​        If "name" is a directory it will mount that as the C: drive.
> ​        If "name" is an executable it will mount the directory of "name"
> ​        as the C: drive and execute "name".
>
>   -exit
> ​        DOSBox will close itself when the DOS application "name" ends.
>
>   -c command
> ​        Runs the specified command before running "name". Multiple commands
> ​        can be specified. Each command should start with "-c" though.
> ​        A command can be: an Internal Program, a DOS command or an executable
> ​        on a mounted drive.
>
>   -noconsole (Windows Only)
> ​        Start DOSBox without showing DOSBox Status Window (console).
> ​        Output will be redirected to stdout.txt and stderr.txt

<img src="http://phpddgkm5.bkt.clouddn.com/18-11-9/2220504.jpg" alt="效果演示" style="height:600px" /> 
