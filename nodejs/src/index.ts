import express, { Request, Response } from 'express';
import { json } from 'body-parser';
import authRoutes from './routes/authRoutes';
import cors from 'cors';
import conversationsRoutes from './models/conversationsRoutes';
// import authRoutes from './routes/authRoutes';

const app = express();

app.use(cors());
app.use(json());
app.use('/auth', authRoutes);
app.use('/conversations', conversationsRoutes);



// app.get('/', (req: Request, res: Response) => {
//   console.log("test");
//   res.send("yes it works");
// });

const PORT = process.env.PORT || 5000;
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
