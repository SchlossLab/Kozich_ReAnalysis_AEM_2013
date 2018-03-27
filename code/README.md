Obtained the Linux version of mothur (v1.39.5) from the mothur GitHub repository

```bash
wget --no-check-certificate https://github.com/mothur/mothur/releases/download/v1.39.5/Mothur.linux_64.zip
unzip Mothur.linux_64.zip
mv mothur code/
rm Mothur.linux_64.zip
rm -rf __MACOSX
```

mothur should output the version 1.39.5 by doing...

```bash
code/mothur/mothur -v
```

