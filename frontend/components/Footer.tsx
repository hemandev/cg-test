import React from 'react';

interface FooterProps {
  copyright: string;
  links?: Array<{ label: string; href: string }>;
}

export const Footer: React.FC<FooterProps> = ({ copyright, links = [] }) => {
  return (
    <footer className="footer">
      <div className="footer-content">
        <p>&copy; {copyright}</p>
        {links.length > 0 && (
          <nav>
            {links.map((link, index) => (
              <a key={index} href={link.href}>
                {link.label}
              </a>
            ))}
          </nav>
        )}
      </div>
    </footer>
  );
};