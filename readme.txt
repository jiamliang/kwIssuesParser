�ýű����ڽ�Klocwork 9.x ������issues.xml�ļ�ת��ΪHTML��ʽ������issues�б��Լ�HTML��ʽ��
report�������issues.xml�а�����������Ϣ��ownership��������ͨ�����ݲ�����������ݲ��õ���
���ߣ������������߶�Ӧ��HTML��ʽ��issues�����б�

�ýű�ʹ������Perlģ�飺
Getopt::Long
Pod::Usage;
File::Path;
File::Basename;

�÷���
kwIssuesParser.pl [options]

OPTIONS��

 --help, -h            ��ʾ������Ϣ
 --version, -v         ��ӡ�汾��Ϣ
 --homepath, -H	PATH   saxon9he.jar, xslt�ļ������·����Ĭ��Ϊ��ǰ·����
 --input, -i FILE      Klocwork������XML��ʽȱ���ļ�(Ĭ��Ϊissues.xml)
 --output, -o FILE     ������HTMLȱ���б��ļ��� (Ĭ��Ϊissues.htm) 
 --report, -r FILE     HTML��ʽ��ȱ��ͳ�Ʊ����ļ��� (Ĭ��Ϊreport.htm)
 --indivpath, -p PATH  ����ȱ���б��ļ����·�� ("."��ʾ��ǰ·����Ĭ�ϲ���������ȱ���б��ļ�)
 --debug, -d           ��ת�������д�ӡ��ϸ��Ϣ