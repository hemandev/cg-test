import React from 'react';
import { Header } from '../components/Header';

export const About: React.FC = () => {
  return (
    <div className="about-page">
      <Header title="About Us" />
      <main>
        <section>
          <p>Learn more about our company and mission.</p>
          <p>We are dedicated to building great software solutions.</p>
        </section>
      </main>
    </div>
  );
};