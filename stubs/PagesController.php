<?php

namespace App\Controller;

use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Rompetomp\InertiaBundle\Service\InertiaInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;

class PagesController extends AbstractController
{
    #[Route('/', name: 'app_home')]
    public function home(InertiaInterface $inertia): Response
    {
        return $inertia->render('Home', ['name' => 'World']);
    }

    #[Route('/about-us', name: 'app_about')]
    public function about(InertiaInterface $inertia): Response
    {
        return $inertia->render('About');
    }
}
