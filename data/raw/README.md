Obtained the raw `fastq.gz` files from https://www.mothur.org/MiSeqDevelopmentData.html
* Downloaded https://www.mothur.org/MiSeqDevelopmentData/StabilityWMetaG.tar
* Ran the following from the project's root directory

```bash
wget --no-check-certificate https://www.mothur.org/MiSeqDevelopmentData/StabilityWMetaG.tar
tar xvf StabilityWMetaG.tar -C data/raw/
rm StabilityWMetaG.tar
```
