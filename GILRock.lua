import React, { useState } from 'react';

export default function ExecutorDownScreen() {
  const scriptName = 'Universal Script'; // Change this to your script name

  return (
    <div className="min-h-screen bg-black flex flex-col items-center justify-center p-4">
      <div className="text-center space-y-6">
        <div className="text-red-500 text-6xl mb-8">⚠</div>
        
        <h1 className="text-4xl font-bold text-white mb-4">
          {scriptName} is Down
        </h1>
        
        <p className="text-2xl text-gray-400">
          Come back later
        </p>

        <div className="mt-12">
          <div className="flex items-center justify-center space-x-2">
            <div className="w-3 h-3 bg-red-500 rounded-full animate-pulse"></div>
            <div className="w-3 h-3 bg-red-500 rounded-full animate-pulse" style={{ animationDelay: '0.2s' }}></div>
            <div className="w-3 h-3 bg-red-500 rounded-full animate-pulse" style={{ animationDelay: '0.4s' }}></div>
          </div>
        </div>
      </div>

      <button
        onClick={() => window.location.reload()}
        className="absolute bottom-8 right-8 text-gray-600 hover:text-gray-400 text-sm transition-colors"
      >
        Reload
      </button>
    </div>
  );
}
