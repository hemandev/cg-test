import React from 'react';
import { Header } from '../components/Header';
import { Footer } from '../components/Footer';

export const Home: React.FC = () => {
  return (
    <div className="home-page">
      <Header title="Welcome Home" subtitle="Your dashboard awaits" />
      <main>
        <section>
          <h2>Dashboard</h2>
          <p>Welcome to your personal dashboard.</p>
        </section>
      </main>
      <Footer copyright="2024 My App" />
    </div>
  );
};