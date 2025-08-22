import { Request, Response } from 'express';
import bcrypt from 'bcrypt';
import jwt from 'jsonwebtoken';

export class AuthController {
  async login(req: Request, res: Response) {
    try {
      const { email, password } = req.body;
      
      // Mock user validation
      if (email === 'user@example.com' && password === 'password') {
        const token = jwt.sign({ userId: '1', email }, 'secret', { expiresIn: '1h' });
        res.json({ token, user: { id: '1', email } });
      } else {
        res.status(401).json({ error: 'Invalid credentials' });
      }
    } catch (error) {
      res.status(500).json({ error: 'Login failed' });
    }
  }

  async register(req: Request, res: Response) {
    try {
      const { name, email, password } = req.body;
      
      // Mock user creation
      const hashedPassword = await bcrypt.hash(password, 10);
      const user = {
        id: Date.now().toString(),
        name,
        email,
        password: hashedPassword,
      };
      
      res.status(201).json({ 
        message: 'User created successfully',
        user: { id: user.id, name: user.name, email: user.email }
      });
    } catch (error) {
      res.status(500).json({ error: 'Registration failed' });
    }
  }

  async logout(req: Request, res: Response) {
    res.json({ message: 'Logged out successfully' });
  }
}