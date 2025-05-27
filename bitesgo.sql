-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 22/05/2025 às 18:24
-- Versão do servidor: 10.4.32-MariaDB
-- Versão do PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `bitesgo`
--

-- --------------------------------------------------------

--
-- Estrutura para tabela `avaliacoes`
--

CREATE TABLE `avaliacoes` (
  `id` int(11) NOT NULL,
  `pedido_id` int(11) NOT NULL,
  `nota` int(11) NOT NULL CHECK (`nota` between 1 and 5),
  `comentario` text DEFAULT NULL,
  `data_avaliacao` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `categorias`
--

CREATE TABLE `categorias` (
  `id` int(11) NOT NULL,
  `nome` varchar(50) NOT NULL,
  `descricao` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `categorias`
--

INSERT INTO `categorias` (`id`, `nome`, `descricao`) VALUES
(1, 'Pizzas', 'Pizzas em diversos sabores'),
(2, 'Hambúrgueres', 'Hambúrgueres artesanais'),
(3, 'Porções', 'Porções para compartilhar'),
(4, 'Bebidas Alcoólicas', 'Cervejas, vinhos e destilados'),
(5, 'Bebidas Não Alcoólicas', 'Refrigerantes, sucos e água');

-- --------------------------------------------------------

--
-- Estrutura para tabela `enderecos`
--

CREATE TABLE `enderecos` (
  `id` int(11) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  `rua` varchar(100) NOT NULL,
  `numero` varchar(20) NOT NULL,
  `complemento` varchar(100) DEFAULT NULL,
  `bairro` varchar(50) NOT NULL,
  `cidade` varchar(50) NOT NULL,
  `cep` varchar(10) NOT NULL,
  `referencia` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `itens_pedido`
--

CREATE TABLE `itens_pedido` (
  `id` int(11) NOT NULL,
  `pedido_id` int(11) NOT NULL,
  `produto_id` int(11) NOT NULL,
  `quantidade` int(11) NOT NULL,
  `preco_unitario` decimal(10,2) NOT NULL,
  `observacoes` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `metodos_pagamento`
--

CREATE TABLE `metodos_pagamento` (
  `id` int(11) NOT NULL,
  `nome` varchar(50) NOT NULL,
  `ativo` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `metodos_pagamento`
--

INSERT INTO `metodos_pagamento` (`id`, `nome`, `ativo`) VALUES
(1, 'Dinheiro', 1),
(2, 'Cartão de Crédito', 1),
(3, 'Cartão de Débito', 1),
(4, 'PIX', 1),
(5, 'Vale Refeição', 1);

-- --------------------------------------------------------

--
-- Estrutura para tabela `opcoes_personalizacao`
--

CREATE TABLE `opcoes_personalizacao` (
  `id` int(11) NOT NULL,
  `produto_id` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `tipo` enum('adicional','remocao') NOT NULL,
  `valor_adicional` decimal(10,2) DEFAULT 0.00
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `pedidos`
--

CREATE TABLE `pedidos` (
  `id` int(11) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  `endereco_id` int(11) NOT NULL,
  `metodo_pagamento_id` int(11) NOT NULL,
  `status` enum('pendente','em_preparo','saiu_para_entrega','entregue','cancelado') DEFAULT 'pendente',
  `data_hora` timestamp NOT NULL DEFAULT current_timestamp(),
  `valor_subtotal` decimal(10,2) NOT NULL,
  `valor_entrega` decimal(10,2) NOT NULL,
  `valor_total` decimal(10,2) NOT NULL,
  `observacoes_gerais` text DEFAULT NULL,
  `troco_para` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `personalizacoes_item`
--

CREATE TABLE `personalizacoes_item` (
  `id` int(11) NOT NULL,
  `item_pedido_id` int(11) NOT NULL,
  `opcao_personalizacao_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `produtos`
--

CREATE TABLE `produtos` (
  `id` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `descricao` text DEFAULT NULL,
  `preco` decimal(10,2) NOT NULL,
  `categoria_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `telefone` varchar(20) NOT NULL,
  `senha` varchar(255) NOT NULL,
  `data_cadastro` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `avaliacoes`
--
ALTER TABLE `avaliacoes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `pedido_id` (`pedido_id`);

--
-- Índices de tabela `categorias`
--
ALTER TABLE `categorias`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `enderecos`
--
ALTER TABLE `enderecos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `usuario_id` (`usuario_id`);

--
-- Índices de tabela `itens_pedido`
--
ALTER TABLE `itens_pedido`
  ADD PRIMARY KEY (`id`),
  ADD KEY `pedido_id` (`pedido_id`),
  ADD KEY `produto_id` (`produto_id`);

--
-- Índices de tabela `metodos_pagamento`
--
ALTER TABLE `metodos_pagamento`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `opcoes_personalizacao`
--
ALTER TABLE `opcoes_personalizacao`
  ADD PRIMARY KEY (`id`),
  ADD KEY `produto_id` (`produto_id`);

--
-- Índices de tabela `pedidos`
--
ALTER TABLE `pedidos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `usuario_id` (`usuario_id`),
  ADD KEY `endereco_id` (`endereco_id`),
  ADD KEY `metodo_pagamento_id` (`metodo_pagamento_id`);

--
-- Índices de tabela `personalizacoes_item`
--
ALTER TABLE `personalizacoes_item`
  ADD PRIMARY KEY (`id`),
  ADD KEY `item_pedido_id` (`item_pedido_id`),
  ADD KEY `opcao_personalizacao_id` (`opcao_personalizacao_id`);

--
-- Índices de tabela `produtos`
--
ALTER TABLE `produtos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `categoria_id` (`categoria_id`);

--
-- Índices de tabela `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `avaliacoes`
--
ALTER TABLE `avaliacoes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `categorias`
--
ALTER TABLE `categorias`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de tabela `enderecos`
--
ALTER TABLE `enderecos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `itens_pedido`
--
ALTER TABLE `itens_pedido`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `metodos_pagamento`
--
ALTER TABLE `metodos_pagamento`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de tabela `opcoes_personalizacao`
--
ALTER TABLE `opcoes_personalizacao`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `pedidos`
--
ALTER TABLE `pedidos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `personalizacoes_item`
--
ALTER TABLE `personalizacoes_item`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `produtos`
--
ALTER TABLE `produtos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Restrições para tabelas despejadas
--

--
-- Restrições para tabelas `avaliacoes`
--
ALTER TABLE `avaliacoes`
  ADD CONSTRAINT `avaliacoes_ibfk_1` FOREIGN KEY (`pedido_id`) REFERENCES `pedidos` (`id`);

--
-- Restrições para tabelas `enderecos`
--
ALTER TABLE `enderecos`
  ADD CONSTRAINT `enderecos_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`);

--
-- Restrições para tabelas `itens_pedido`
--
ALTER TABLE `itens_pedido`
  ADD CONSTRAINT `itens_pedido_ibfk_1` FOREIGN KEY (`pedido_id`) REFERENCES `pedidos` (`id`),
  ADD CONSTRAINT `itens_pedido_ibfk_2` FOREIGN KEY (`produto_id`) REFERENCES `produtos` (`id`);

--
-- Restrições para tabelas `opcoes_personalizacao`
--
ALTER TABLE `opcoes_personalizacao`
  ADD CONSTRAINT `opcoes_personalizacao_ibfk_1` FOREIGN KEY (`produto_id`) REFERENCES `produtos` (`id`);

--
-- Restrições para tabelas `pedidos`
--
ALTER TABLE `pedidos`
  ADD CONSTRAINT `pedidos_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`),
  ADD CONSTRAINT `pedidos_ibfk_2` FOREIGN KEY (`endereco_id`) REFERENCES `enderecos` (`id`),
  ADD CONSTRAINT `pedidos_ibfk_3` FOREIGN KEY (`metodo_pagamento_id`) REFERENCES `metodos_pagamento` (`id`);

--
-- Restrições para tabelas `personalizacoes_item`
--
ALTER TABLE `personalizacoes_item`
  ADD CONSTRAINT `personalizacoes_item_ibfk_1` FOREIGN KEY (`item_pedido_id`) REFERENCES `itens_pedido` (`id`),
  ADD CONSTRAINT `personalizacoes_item_ibfk_2` FOREIGN KEY (`opcao_personalizacao_id`) REFERENCES `opcoes_personalizacao` (`id`);

--
-- Restrições para tabelas `produtos`
--
ALTER TABLE `produtos`
  ADD CONSTRAINT `produtos_ibfk_1` FOREIGN KEY (`categoria_id`) REFERENCES `categorias` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
