import { Request, Response } from 'express';

export interface Post {
  id: string;
  title: string;
  content: string;
  authorId: string;
  createdAt: Date;
}

export const getPosts = async (req: Request, res: Response) => {
  try {
    // Mock implementation
    const posts: Post[] = [
      {
        id: '1',
        title: 'First Post',
        content: 'This is the content of the first post.',
        authorId: '1',
        createdAt: new Date(),
      },
      {
        id: '2',
        title: 'Second Post',
        content: 'This is the content of the second post.',
        authorId: '2',
        createdAt: new Date(),
      },
    ];
    res.json(posts);
  } catch (error) {
    res.status(500).json({ error: 'Failed to fetch posts' });
  }
};

export const createPost = async (req: Request, res: Response) => {
  try {
    const { title, content, authorId } = req.body;
    const newPost: Post = {
      id: Date.now().toString(),
      title,
      content,
      authorId,
      createdAt: new Date(),
    };
    res.status(201).json(newPost);
  } catch (error) {
    res.status(500).json({ error: 'Failed to create post' });
  }
};