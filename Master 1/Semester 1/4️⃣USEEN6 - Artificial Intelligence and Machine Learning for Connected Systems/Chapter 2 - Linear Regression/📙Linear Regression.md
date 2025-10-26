> [!faq] Reminder: Matrices crash course
> - [Multiplication](https://youtu.be/2spTnAiQg4M?si=Jng562Us_Unm3wX0)
> - [Transpose](https://youtu.be/TZrKrNVhbjI)
> - [Determinant](https://youtu.be/CcbyMH3Noow?si=_QOSfm8jBShl84ow)
> - [Inverse](https://youtu.be/kWorj5BBy9k?si=2qeNDVP-nBYmlvgW)

---

Its a very simple approach for [[Master 1/Semester 1/4️⃣USEEN6 - Artificial Intelligence and Machine Learning for Connected Systems/Chapter 1 - Introduction/📙Introduction#Machine learning approaches|supervised learning]]. It is a useful tool for predicting a quantitative response and serves as a good jumping-off point for newer approaches.

# Simple linear regression
> [!info] goal
> it is an approach for predicting a **quantitative response Y**. On the basis of a **single predictor variable X**

It assumes an approximately linear relationship between X and Y:
$$\Large Y \approx \beta_0 + \beta_1X $$
where we have to find the values of betas to get the best model.
![[Pasted image 20251016153846.png]]

## Measuring closeness
There are different ways to know if our linear model makes a good approximation of our data
### RSS: Residual Sum of Squares
We can measure the error for a specific prediction like so ($\hat y$ is a point on the line):
$$\Large e_i = y_i - \hat y_i$$
The closer it is to 0, the more accurate it is.

Now we can sum up all the data in our data set and get the RSS: $$\color{cyan} \LARGE RSS = \sum^n_{i=1} e_i^2$$
> [!warning] Why we squared?
> We square so we can avoid negative values, and it helps with larger residuals somehow

#### General form
We call the output of the model (y) as **Hypothesis** ($h_\theta$)
Generalized we get: $h_{\theta}(x) = \theta_{0} + \theta_{1}x_{1} + \theta_{2}x_{2} + \theta_{d}x_{d}$
Where $\theta$ are called **Weights** except for $\theta_0$ called **Intercept term**; and $x_i$ as the features/parameters.

This is also called the vector form (where $x_0=1$): $$\color{magenta}\Large h(x) = \sum_{i=0}^{d} \theta_{i}x_{i} = \theta^{T}x$$


Rewriting the previous [[#RSS Residual Sum of Squares|RSS function]] minimized for machine learning (obtained by derivative) we get:
$$\color{cyan} \LARGE J(\beta)=\frac{1}{2}\sum^n_{i=1}(h_\beta(x_i)-y_i)^2$$

## How do we find $\theta$
> [!info] Definition: Cost Function
> Measuring how close the model gets to our data set

### MSE: Mean Square Error
it is similar to the [[#General form|general form of RSS]] but simply take the average instead of just dividing by 2: $$\LARGE \color{cyan} \mathrm{MSE}(\mathbf{X}, h_{\theta}) = \frac{1}{m} \sum_{i=1}^{m} (\mathbf{\theta}^{T}\mathbf{x}^{(i)} - y^{(i)})^{2}$$
