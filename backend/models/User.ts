export interface UserModel {
  id: string;
  name: string;
  email: string;
  password: string;
  role: 'admin' | 'user';
  isActive: boolean;
  createdAt: Date;
  updatedAt: Date;
}

export class User implements UserModel {
  constructor(
    public id: string,
    public name: string,
    public email: string,
    public password: string,
    public role: 'admin' | 'user' = 'user',
    public isActive: boolean = true,
    public createdAt: Date = new Date(),
    public updatedAt: Date = new Date()
  ) {}

  static create(data: Omit<UserModel, 'id' | 'createdAt' | 'updatedAt'>): User {
    return new User(
      Date.now().toString(),
      data.name,
      data.email,
      data.password,
      data.role,
      data.isActive
    );
  }

  update(data: Partial<UserModel>): void {
    Object.assign(this, data);
    this.updatedAt = new Date();
  }

  toJSON(): Omit<UserModel, 'password'> {
    const { password, ...user } = this;
    return user;
  }
}
// Test change - 20251109-120930
