**EE282 HW2**

Prompt 1: Ask a problem that requires a student to understand navigation and manipulation of directories in a filesystem. Your question should require an answer using at least the following commands/concepts: cd, ../, mkdir, rmdir
1. Navigate on your local computer to your Downloads folder and make a parent directory called **Patients_images**, next inside this directory make 4 directories to hold each of the patient’s radiology images you may label these **Patient1, Patient2, etc.** and inside each directory download **XXX.pdf** this file to your downloads and move it into each patient’s folder. Finally use the tree command to ensure you correctly moved all the files to their correct location


Prompt 2: Ask a question that requires a student to understand the difference between accessing a column in a matrix with numeric indices versus accessing a column in a data frame with numeric indices. Your question should require an answer comparing the following: mymatrix[,1] vs. mydf[,1] vs. mydf[1] vs. mydf[[1]]
2. A clinic stores lab results for four patients in R:
labs <- data.frame(
  hemoglobin = c(13.5, 12.1, 14.2, 11.8),
  age        = c(34, 51, 28, 63),
  sex        = c("F", "M", "F", "M")
)
labs_mat <- as.matrix(labs[, c("hemoglobin", "age")])

For each of the four expressions below:
(a) predict what R prints
(b) give the result of `class()`
(c) say whether `mean()` of it returns the average hemoglobin
1. labs_mat[, 1]
2. labs[, 1]
3. labs[1]
4. labs[[1]]
Finally, explain why labs[1] behaves differently from the other three, even though they all use the number 1 to refer to the first column

Prompt 3: Ask a question that requires a student to understand how to share access to a directory and a file in that directory on a Unix/Linux filesystem from their home directory with a colleague without exposing the user's entire directory. Your question should require an answer using chmod {u,g,o}{+,-}{r,w,x} (not using octal permissions).

3. In your home directory (`~`), you have a directory called patient_study. Inside patient_study are two subdirectories: raw_data, which contains the file patient_ids.csv, and results which contains the file hemoglobin_summary.csv. Right now, every directory and file is private to only you the owner have access to. Someone in your lab needs to open  hemoglobin_summary.csv. However, they should **not** be able to list the contents of your home directory,or open anything in raw_data.Using only chmod with the {u,g,o}{+,-}{r,w,x} format how would you go about giving them access. 


** Answer key **
1.	cd ~/Downloads
mkdir Patients_images
cd Patients_images
mkdir Patient1 Patient2 Patient3 Patient4
cd ..
cp XXX.pdf Patients_images/Patient1/
cp XXX.pdf Patients_images/Patient2/
cp XXX.pdf Patients_images/Patient3/
cp XXX.pdf Patients_images/Patient4/
( cd into each patient and ls to double check) 
tree ~/Downloads/Patients_images
2.	a) labs_mat[, 1] returns a numeric vector.
labs_mat[, 1]
[1] 13.5 12.1 14.2 11.8
class(labs_mat[, 1])
[1] "numeric"
mean(labs_mat[, 1])
[1] 12.9

b) labs[, 1] returns a numeric vector, because matrix-style indexing drops a single column to a vector.
labs[, 1]
[1] 13.5 12.1 14.2 11.8

class(labs[, 1])
[1] "numeric"

mean(labs[, 1])
[1] 12.9

c) labs[1] returns a data frame with one column, so mean() fails
labs[1]
  hemoglobin
1       13.5
2       12.1
3       14.2
4       11.8

class(labs[1])
[1] "data.frame"

mean(labs[1])
[1] NA
Warning message:
argument is not numeric or logical: returning NA

d) labs[[1]] returns the column itself as a numeric vector.
labs[[1]]
[1] 13.5 12.1 14.2 11.8

class(labs[[1]])
[1] "numeric"

mean(labs[[1]])
[1] 12.9

3.	chmod g+x ~
chmod g+x ~/patient_study
chmod g+x ~/patient_study/results
chmod g+r ~/patient_study/results/hemoglobin_summary.csv
