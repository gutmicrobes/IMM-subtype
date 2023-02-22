Module 1: Microbiological data

1. data1 is the original data of bacteria, 2852 bacteria, 203 samples

2. data2 is the result of deleting bacteria with high NA value, 65 bacteria and 203 samples

3. Data3 contains 68 viruses and 208 samples (the samples are heavy, and 5 were later deleted)

4. data4 is the data of 65 bacteria+12 viruses, that is, 77 microorganisms, 203 samples



Module 2: Immune gene data

5. Download the manifest file, meta file and cart package of stomach cancer on the official website of TCGA

6. Extract the cart file, put movefiles.pl into it and run it, perl movefiles.pl, and generate files file

7. Put the merge.pl and meta files into the files file and run it to get the mRNAmatrix file

8. mRNAmatrix row name is the name of ensample, and column name is the sample name

9. With the help of the human.gtf file and the script getMrna.pl, use the command: perl getMrna.pl, and the output result is symbol.txt (the gene expression profile matrix). The row is the gene name, and the column is the sample id

10. Standardize, use normalize. R and symbol.txt to generate data5, which contains 19512 genes

11. Download the GeneList of immune genes from IMMPORT. There are 2483 immune genes in the list

12. Take the intersection of data5 and GeneList to get gene_ expression_ 1355_ 203, there are 1355 immune gene expression profile data



Module 3: Immune cell data

13. data5 is the gene expression profile data, namely the input data of cibersort

14. data6 is the configuration file for running cibersort, code1 is the code for cibersort, and code2 is the configuration file for code1



Module 4: Drawing a violin picture

15. data7 is the data of 77 microorganisms+22 immune cells+1355 immune genes, 203 samples

      77 microorganisms in data7 are the result of module 1, 22 immune cells are the result of module 3, and 1355 immune genes are the result of module 2

16. data8 is the sorted data of data7 and the input data of violin chart

17. Code3 is a program for drawing violin pictures



Module 4: Clustering

18. data9 is 22cell+1355gene, 153 cancer samples, and also the input file of clustering

19. Code4 is the clustering procedure

20. data10 is labeled 22cell+1355gene, 153 cancer samples

21. Code5 is the program of lasso. After screening the immune genes with lasso, there are 18 left

22. data11 is 22 cell+18 gene, 153 cancer samples

23. data12 is a tagged 22cell+18gene, 153 cancer samples after re-clustering