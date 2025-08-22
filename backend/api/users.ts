import { Request, Response } from 'express';

export interface User {
  id: string;
  name: string;
  email: string;
  createdAt: Date;
}

export const getUsers = async (req: Request, res: Response) => {
  try {
    // Mock implementation
    const users: User[] = [
      { id: '1', name: 'John Doe', email: 'john@example.com', createdAt: new Date() },
      { id: '2', name: 'Jane Smith', email: 'jane@example.com', createdAt: new Date() },
    ];
    res.json(users);
  } catch (error) {
    res.status(500).json({ error: 'Failed to fetch users' });
  }
};

export const getUserById = async (req: Request, res: Response) => {
  try {
    const { id } = req.params;
    // Mock implementation
    const user: User = {
      id,
      name: 'John Doe',
      email: 'john@example.com',
      createdAt: new Date(),
    };
    res.json(user);
  } catch (error) {
    res.status(500).json({ error: 'Failed to fetch user' });
  }
};