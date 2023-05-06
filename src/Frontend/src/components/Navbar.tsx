import { useState } from "react";
import { Link } from 'react-router-dom';


import logoImage from '../assets/SOS-LOGO.jpg';
import SearchBar from "./SearchBar";

interface NavbarProps {
  logo: string;
  leaguename: string;
}

export const Navbar = () => {
  return(
    <nav className="w-full max-h-40 flex items-center justify-center flex-wrap">
      <div className="h-28 w-full flex items-center justify-between text-white border-b-2">
        <div className="flex items-center flex-shrink-0 text-white">
          <Link to={"/"}>
            <img src={logoImage} className="w-52 h-20" alt="Logo Echosec" />
          </Link>
          {/* <span className="font-bold text-4xl">ECHOSEC</span> */}
        </div>
        <div className="gap-16 flex items-center">
          <SearchBar />
        </div>
        <div>
          Perfil
        </div>
      </div>
      
    </nav>

  )
}