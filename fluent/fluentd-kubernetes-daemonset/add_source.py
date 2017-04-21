import os,re
files = os.listdir('/var/log/containers')
names=[]
for f in files:
    if not re.search('log$',f):continue
    fs = f.split('_')
    name = '-'.join(fs[0].split('-')[:-2])
    if name not in names:names.append(name)

kfile = '/fluentd/etc/ks.conf'
fr=open(kfile,'w')
for name in names:
    out='''
<source>
  type tail
  multiline_flush_interval 5s
  path /var/log/containers/{name}*.log
  pos_file /var/log/{name}.log.pos
  tag {name}
</source>
'''.format(name=name)
    fr.write(out)
fr.close()
