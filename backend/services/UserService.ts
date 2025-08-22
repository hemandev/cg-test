import { User } from '../api/users';

export class UserService {
  private users: User[] = [
    { id: '1', name: 'John Doe', email: 'john@example.com', createdAt: new Date() },
    { id: '2', name: 'Jane Smith', email: 'jane@example.com', createdAt: new Date() },
  ];

  async getAllUsers(): Promise<User[]> {
    return this.users;
  }

  async getUserById(id: string): Promise<User | null> {
    return this.users.find(user => user.id === id) || null;
  }

  async createUser(userData: Omit<User, 'id' | 'createdAt'>): Promise<User> {
    const newUser: User = {
      id: Date.now().toString(),
      ...userData,
      createdAt: new Date(),
    };
    this.users.push(newUser);
    return newUser;
  }

  async updateUser(id: string, userData: Partial<User>): Promise<User | null> {
    const index = this.users.findIndex(user => user.id === id);
    if (index === -1) return null;

    this.users[index] = { ...this.users[index], ...userData };
    return this.users[index];
  }

  async deleteUser(id: string): Promise<boolean> {
    const index = this.users.findIndex(user => user.id === id);
    if (index === -1) return false;

    this.users.splice(index, 1);
    return true;
  }
}