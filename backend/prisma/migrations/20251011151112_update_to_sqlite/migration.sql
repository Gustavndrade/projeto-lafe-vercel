-- CreateTable
CREATE TABLE "Usuario" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "nome" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "senha" TEXT NOT NULL,
    "role" TEXT NOT NULL DEFAULT 'ADMIN',
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL
);

-- CreateTable
CREATE TABLE "Curso" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "nome" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "Jogador" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "nome" TEXT NOT NULL,
    "rm" TEXT NOT NULL,
    "curso_id" INTEGER NOT NULL,
    CONSTRAINT "Jogador_curso_id_fkey" FOREIGN KEY ("curso_id") REFERENCES "Curso" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Time" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "nome" TEXT NOT NULL,
    "jogador1_id" INTEGER NOT NULL,
    "jogador2_id" INTEGER NOT NULL,
    "suporte_id" INTEGER NOT NULL,
    "curso_id" INTEGER NOT NULL,
    "cadastrado_por" TEXT NOT NULL,
    "data_cadastro" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT "Time_curso_id_fkey" FOREIGN KEY ("curso_id") REFERENCES "Curso" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "Time_jogador1_id_fkey" FOREIGN KEY ("jogador1_id") REFERENCES "Jogador" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "Time_jogador2_id_fkey" FOREIGN KEY ("jogador2_id") REFERENCES "Jogador" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "Time_suporte_id_fkey" FOREIGN KEY ("suporte_id") REFERENCES "Jogador" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateIndex
CREATE UNIQUE INDEX "Usuario_email_key" ON "Usuario"("email");

-- CreateIndex
CREATE UNIQUE INDEX "Jogador_rm_key" ON "Jogador"("rm");

-- CreateIndex
CREATE INDEX "Jogador_curso_id_idx" ON "Jogador"("curso_id");

-- CreateIndex
CREATE INDEX "Time_curso_id_idx" ON "Time"("curso_id");

-- CreateIndex
CREATE INDEX "Time_jogador1_id_idx" ON "Time"("jogador1_id");

-- CreateIndex
CREATE INDEX "Time_jogador2_id_idx" ON "Time"("jogador2_id");

-- CreateIndex
CREATE INDEX "Time_suporte_id_idx" ON "Time"("suporte_id");
