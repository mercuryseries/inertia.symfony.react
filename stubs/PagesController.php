<?php

namespace App\Controller;

use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Rompetomp\InertiaBundle\Service\InertiaInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;

class PagesController extends AbstractController
{
    #[Route('/', name: 'app_home', options: ['expose' => true])]
    public function home(InertiaInterface $inertia): Response
    {
        return $inertia->render('Home', ['name' => 'Honoré', 'birthYear' => 2002]);
    }

    #[Route('/about-us', name: 'app_about', options: ['expose' => true])]
    public function about(InertiaInterface $inertia): Response
    {
        return $inertia->render('About');
    }
}
