# Pacotes
library(rpart)
library(rpart.plot)
library(caret)

# Dados
data(dados_jurimetria)

# Separação treino/teste
set.seed(123)
indice_treino <- createDataPartition(
  y = dados_jurimetria$resultado,
  p = 0.7,
  list = FALSE
)

treino <- dados_jurimetria[indice_treino, ]
teste  <- dados_jurimetria[-indice_treino, ]

# Treinamento
modelo_tree <- rpart(
  resultado ~ .,
  data = treino,
  method = "class"
)

# Visualização
rpart.plot(modelo_tree)

# Previsão
pred_tree <- predict(
  modelo_tree,
  teste,
  type = "class"
)

# Avaliação
confusionMatrix(
  pred_tree,
  teste$Species
)