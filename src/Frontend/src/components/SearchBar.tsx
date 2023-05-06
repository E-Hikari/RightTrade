import React, { useState } from 'react';
import { HiOutlineMagnifyingGlass } from "react-icons/hi2";

function SearchBar() {
  const [searchTerm, setSearchTerm] = useState('');

  const handleChange = (event: React.ChangeEvent<HTMLInputElement>) => {
    setSearchTerm(event.target.value);
  };

  const handleSubmit = (event: React.FormEvent<HTMLFormElement>) => {
    event.preventDefault();
    console.log('Pesquisar por:', searchTerm);
  };

  return (
    <div className="flex justify-center mt-4">
      <form onSubmit={handleSubmit} className="flex">
        <input
          type="text"
          placeholder="Pesquisar..."
          value={searchTerm}
          onChange={handleChange}
          className="w-[400px] px-4 py-2 border border-gray-300 rounded-l-md focus:outline-none focus:ring focus:border-blue-300"
        />
        <button
          type="submit"
          className="px-4 py-2 bg-white text-black font-semibold rounded-r-md hover:bg-gray-400 focus:outline-none focus:bg-blue-600"
        >
          <HiOutlineMagnifyingGlass />
        </button>
      </form>
    </div>
  );
}

export default SearchBar;
