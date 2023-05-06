import './styles/global.css'
import { Navbar } from './components/Navbar';
import { createBrowserRouter, RouterProvider, Outlet } from 'react-router-dom';
import { HomePage } from './components/HomePage';
import { ProcessoSeletivo } from './components/ProcessoSeletivo';

const AppLayout = () => (
  <div className="App">
    <Navbar />
    <Outlet />
    {/* <Footer /> */}
  </div>
)

const router = createBrowserRouter([
  {
    element: <AppLayout />,
    children: [
      {
        path: "/",
        element: <HomePage />,
      },
      {
        path: "/processo-seletivo",
        element: <ProcessoSeletivo />,
      },
      {
        path: "/sobre-nos",
        // element: <SobreNos />,
      },
    ],
  }
]);

export function App() {
  return <RouterProvider router={router} />
}

