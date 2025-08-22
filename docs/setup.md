# Setup Guide

## Prerequisites

- Node.js (v18 or higher)
- npm or yarn
- Git

## Installation

1. Clone the repository:
```bash
git clone https://github.com/hemandev/cg-test.git
cd cg-test
```

2. Install dependencies:
```bash
npm install
```

3. Set up environment variables:
```bash
cp .env.example .env
```

4. Start the development server:
```bash
npm run dev
```

## Project Structure

```
cg-test/
├── frontend/          # React frontend components
│   ├── components/    # Reusable UI components
│   ├── pages/         # Page components
│   ├── utils/         # Frontend utilities
│   └── ui/            # UI-specific components
├── backend/           # Node.js backend
│   ├── api/           # API route handlers
│   ├── controllers/   # Business logic controllers
│   ├── services/      # Service layer
│   ├── models/        # Data models
│   └── middleware/    # Express middleware
├── shared/            # Shared code between frontend and backend
│   ├── types/         # TypeScript type definitions
│   └── utils/         # Shared utilities
├── docs/              # Documentation
└── config/            # Configuration files
```

## Development

### Frontend Development
```bash
npm run dev:frontend
```

### Backend Development
```bash
npm run dev:backend
```

### Running Tests
```bash
npm test
```

## Contributing

Please read our contributing guidelines before submitting pull requests.