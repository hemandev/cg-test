# cg-test

Test repository for [codeowners-git](https://github.com/hemandev/codeowners-git) end-to-end testing.

## Purpose

This repository serves as a realistic test environment for the `codeowners-git` CLI tool. It contains:

- Multiple directories with different code ownership patterns
- Diverse file types (TypeScript, JSON, Markdown)
- Realistic project structure with frontend, backend, and shared code
- Comprehensive CODEOWNERS configuration

## Structure

```
cg-test/
├── .github/
│   └── CODEOWNERS              # Defines code ownership patterns
├── frontend/                   # @frontend-team
│   ├── components/             # @ui-team
│   ├── pages/                  # @frontend-team
│   ├── utils/                  # @frontend-team
│   └── ui/                     # @ui-team
├── backend/                    # @backend-team
│   ├── api/                    # @api-team
│   ├── controllers/            # @backend-team
│   ├── services/               # @backend-team
│   ├── models/                 # @backend-team
│   └── middleware/             # @backend-team
├── shared/                     # @shared-team
│   ├── types/                  # @shared-team
│   └── utils/                  # @shared-team
├── docs/                       # @docs-team
├── config/                     # @devops-team
└── README.md                   # @docs-team
```

## Code Ownership

The repository uses a comprehensive CODEOWNERS file that defines ownership for:

### Teams
- `@global-team` - Default owners for all files
- `@frontend-team` - Frontend application code
- `@ui-team` - UI components and design system
- `@backend-team` - Backend services and APIs
- `@api-team` - API endpoints and related code
- `@shared-team` - Shared utilities and types
- `@docs-team` - Documentation and markdown files
- `@devops-team` - Configuration and deployment files

### File Patterns
- Frontend directories: `@frontend-team`
- UI components: `@ui-team`
- Backend directories: `@backend-team`
- API endpoints: `@api-team`
- Documentation: `@docs-team`
- Configuration files: `@devops-team`
- Shared code: `@shared-team`

## Testing Scenarios

This repository enables testing of:

### Basic Functionality
- File listing by owner
- Branch creation for specific owners
- Multi-branch creation for all owners

### Advanced Scenarios
- Overlapping ownership patterns
- Nested directory structures
- Mixed file operations (add, modify, delete)
- Filter patterns (include/exclude)

### Edge Cases
- Files with no specific owners (fall back to global)
- Deep directory nesting
- Various file types and extensions
- Large numbers of files

## Usage with codeowners-git

### Clone for Local Testing
```bash
git clone https://github.com/hemandev/cg-test.git
cd cg-test
```

### Stage Some Files for Testing
```bash
# Add some frontend files
echo "export const NewComponent = () => <div>New</div>;" > frontend/components/NewComponent.tsx
echo "export const utils = {};" > frontend/utils/newUtils.ts

# Add some backend files  
echo "export const newApi = () => {};" > backend/api/newEndpoint.ts
echo "export class NewService {}" > backend/services/NewService.ts

# Stage the files
git add .
```

### Test codeowners-git Commands
```bash
# List all staged files by owner
codeowners-git list

# Create branch for frontend team
codeowners-git branch -o @frontend-team -b feature/frontend-updates -m "Frontend updates"

# Create branches for all teams
codeowners-git multi-branch -b feature/updates -m "Update files for"
```

## Maintenance

This repository should be kept minimal but realistic. When adding new files or patterns:

1. Update the CODEOWNERS file if needed
2. Ensure new patterns are covered by e2e tests
3. Keep file content simple but realistic
4. Document any new ownership patterns

## Related

- [codeowners-git](https://github.com/hemandev/codeowners-git) - The CLI tool this repository tests
- [GitHub CODEOWNERS documentation](https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/customizing-your-repository/about-code-owners)