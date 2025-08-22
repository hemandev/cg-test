# API Documentation

## Overview

This API provides endpoints for user management, authentication, and content management.

## Authentication

All protected endpoints require a Bearer token in the Authorization header:

```
Authorization: Bearer <your-token>
```

## Endpoints

### Authentication

#### POST /api/auth/login
Login with email and password.

**Request Body:**
```json
{
  "email": "user@example.com",
  "password": "password"
}
```

**Response:**
```json
{
  "token": "jwt-token",
  "user": {
    "id": "1",
    "email": "user@example.com"
  }
}
```

#### POST /api/auth/register
Register a new user.

**Request Body:**
```json
{
  "name": "John Doe",
  "email": "john@example.com",
  "password": "securepassword"
}
```

### Users

#### GET /api/users
Get all users (protected).

**Response:**
```json
[
  {
    "id": "1",
    "name": "John Doe",
    "email": "john@example.com",
    "createdAt": "2024-01-01T00:00:00Z"
  }
]
```

#### GET /api/users/:id
Get user by ID (protected).

### Posts

#### GET /api/posts
Get all posts.

#### POST /api/posts
Create a new post (protected).

**Request Body:**
```json
{
  "title": "Post Title",
  "content": "Post content here",
  "authorId": "1"
}
```