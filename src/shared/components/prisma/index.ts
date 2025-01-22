import { PrismaClient } from '@prisma/client';
import { config } from '@shared/components/config';

const prisma = new PrismaClient({
  datasourceUrl: config.db.url
});

export default prisma;
