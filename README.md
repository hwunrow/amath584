# AMATH 584

Univeristy of Washington Applied Math 584, Autumn 2020
Professor J. Nathan Kutz

## Projects
### HW 2
I performed a SVD analysis of cropped and uncropped images from the [Yale Face Database B](http://vision.ucsd.edu/~leekc/ExtYaleDatabase/Yale%20Face%20Database.htm).
To validate we split the images into a training and test dataset. I then conducted a low-rank reconstruction of images from the test dataset by varying the number of principal compents and calculate the reconstruction error. All analysis was completed using Python 3.

### HW 5
I applied power iteration to approximated the principal eigenface of cropped images from the [Yale Face Database B](http://vision.ucsd.edu/~leekc/ExtYaleDatabase/Yale%20Face%20Database.htm). I took the economy SVD of $A = U\Sigma V^\*$ where $A$ is the matrix of images where each column represents a single image. I then power iterate on the correlation matrix $A^TA$, which has size 2414 x 2414. We compare the dominant eigenvector from the power iteration method to the first column in $V$. 

### HW 6
I built a linear classifier on the MNIST database of handwritten digits, and classify an image as either a 1,2,3,4,5,6,7,8,9, or 0 using logistic regression with both LASSO, Ridge, and Elastic Net. I used Grid Search to tune the hyperparameters $\lambda_1$, $\lambda_2$, and l1 ratio using $k$-fold crossvalidation with $k = 3$. We rank each pixel using the absolute value of the coeficients for each of the models and subset the training and test sets to the top 100 pixels. When evaluating on the full test set, LASSO had the highest test accuracy with 92.62%, followed by Ridge with 92.54% and Elastic Net with 92.52%. However, after subseting to the top 100 pixels, Elastic
Net had the highest accuracy of 87.5% followed by Ridge with 88.3% and LASSO with 79.7%. We used Python 3 and Google Collaboratory for this analysis.
