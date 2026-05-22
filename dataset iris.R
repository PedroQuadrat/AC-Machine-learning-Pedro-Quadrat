# Pacotes
library(rpart)
library(rpart.plot)
library(caret)

# Dados
data(iris)

set.seed(123)
indice_treino <- createDataPartition(
  y = iris$Petal.Width,
  p = 0.7,
  list = FALSE
)

treino <- iris[indice_treino, ]
teste  <- iris[-indice_treino, ]

# Treinamento (Regressão)
modelo_tree <- rpart(
  Petal.Width ~ .,
  data = treino,
  method = "anova"
) 

# Visualização da Árvore
rpart.plot(modelo_tree)

pred_tree <- predict(
  modelo_tree,
  teste
)


resultados <- data.frame(
  Real = teste$Petal.Width,
  Previsto = pred_tree
)
print(head(resultados))

metricas <- postResample(pred = pred_tree, obs = teste$Petal.Width)
print(metricas)