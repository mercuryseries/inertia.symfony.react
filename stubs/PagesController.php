<?php

namespace App\Controller;

use Rompetomp\InertiaBundle\Service\InertiaInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class PagesController extends AbstractController
{
    public function __construct(private readonly InertiaInterface $inertia)
    {
    }

    #[Route('/', name: 'app_home', options: ['expose' => true])]
    public function home(): Response
    {
        return $this->inertia->render('Home', ['name' => 'John Doe']);
    }

    #[Route('/about-us', name: 'app_about', options: ['expose' => true])]
    public function about(): Response
    {
        return $this->inertia->render('About');
    }
}
