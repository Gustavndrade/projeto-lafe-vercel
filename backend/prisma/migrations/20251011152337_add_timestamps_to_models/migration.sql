/*
  Warnings:

  - Added the required column `updatedAt` to the `Curso` table without a default value. This is not possible if the table is not empty.
  - Added the required column `updatedAt` to the `Jogador` table without a default value. This is not possible if the table is not empty.
  - Added the required column `updatedAt` to the `Time` table without a default value. This is not possible if the table is not empty.

*/
-- RedefineTables
PRAGMA defer_foreign_keys=ON;
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Curso" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "nome" TEXT NOT NULL,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL
);
INSERT INTO "new_Curso" ("id", "nome") SELECT "id", "nome" FROM "Curso";
DROP TABLE "Curso";
ALTER TABLE "new_Curso" RENAME TO "Curso";
CREATE TABLE "new_Jogador" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "nome" TEXT NOT NULL,
    "rm" TEXT NOT NULL,
    "curso_id" INTEGER NOT NULL,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    CONSTRAINT "Jogador_curso_id_fkey" FOREIGN KEY ("curso_id") REFERENCES "Curso" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Jogador" ("curso_id", "id", "nome", "rm") SELECT "curso_id", "id", "nome", "rm" FROM "Jogador";
DROP TABLE "Jogador";
ALTER TABLE "new_Jogador" RENAME TO "Jogador";
CREATE UNIQUE INDEX "Jogador_rm_key" ON "Jogador"("rm");
CREATE INDEX "Jogador_curso_id_idx" ON "Jogador"("curso_id");
CREATE TABLE "new_Time" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "nome" TEXT NOT NULL,
    "jogador1_id" INTEGER NOT NULL,
    "jogador2_id" INTEGER NOT NULL,
    "suporte_id" INTEGER NOT NULL,
    "curso_id" INTEGER NOT NULL,
    "cadastrado_por" TEXT NOT NULL,
    "data_cadastro" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    CONSTRAINT "Time_curso_id_fkey" FOREIGN KEY ("curso_id") REFERENCES "Curso" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "Time_jogador1_id_fkey" FOREIGN KEY ("jogador1_id") REFERENCES "Jogador" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "Time_jogador2_id_fkey" FOREIGN KEY ("jogador2_id") REFERENCES "Jogador" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "Time_suporte_id_fkey" FOREIGN KEY ("suporte_id") REFERENCES "Jogador" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Time" ("cadastrado_por", "curso_id", "data_cadastro", "id", "jogador1_id", "jogador2_id", "nome", "suporte_id") SELECT "cadastrado_por", "curso_id", "data_cadastro", "id", "jogador1_id", "jogador2_id", "nome", "suporte_id" FROM "Time";
DROP TABLE "Time";
ALTER TABLE "new_Time" RENAME TO "Time";
CREATE INDEX "Time_curso_id_idx" ON "Time"("curso_id");
CREATE INDEX "Time_jogador1_id_idx" ON "Time"("jogador1_id");
CREATE INDEX "Time_jogador2_id_idx" ON "Time"("jogador2_id");
CREATE INDEX "Time_suporte_id_idx" ON "Time"("suporte_id");
PRAGMA foreign_keys=ON;
PRAGMA defer_foreign_keys=OFF;
