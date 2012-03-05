该脚本用于将Klocwork 9.x 导出的issues.xml文件转化为HTML格式的完整issues列表，以及HTML格式的
report报表。如果issues.xml中包含所有者信息（ownership），可以通过传递参数控制其根据不用的所
有者，生成与所有者对应的HTML格式的issues问题列表。

该脚本使用以下Perl模块：
Getopt::Long
Pod::Usage;
File::Path;
File::Basename;

用法：
kwIssuesParser.pl [options]

OPTIONS：

 --help, -h            显示帮助信息
 --version, -v         打印版本信息
 --homepath, -H	PATH   saxon9he.jar, xslt文件保存的路径（默认为当前路径）
 --input, -i FILE      Klocwork导出的XML格式缺陷文件(默认为issues.xml)
 --output, -o FILE     完整的HTML缺陷列表文件名 (默认为issues.htm) 
 --report, -r FILE     HTML格式的缺陷统计报告文件名 (默认为report.htm)
 --indivpath, -p PATH  个人缺陷列表文件输出路径 ("."表示当前路径，默认不创建个人缺陷列表文件)
 --debug, -d           在转换过程中打印详细信息