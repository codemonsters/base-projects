# IMPORTANTE: No llaméis a vuestro script pygame.pyp ara evitar colisiones con el nombre de la librería
# Es necesario instalar PyGame (instalarlo en todo el sistema o sino crear un virtualenv e instalar PyGame dentro)

import sys

import pygame
from pygame.locals import *

WORLD_WIDTH = 256       # ancho fijo de la pantalla de juego (se escala automáticamente cuando redimensionemos la ventana)
WORLD_HEIGHT = 256      # alto fijo de la pantalla de juego (se escala automáticamente)


def mi_error(mensaje):
    print(f"ERROR: {mensaje}")
    pygame.quit()
    sys.exit()


def get_new_scale_factor(display_x_resolution, display_y_resolution):
    max_x_scale_factor = int(display_x_resolution / WORLD_WIDTH)
    max_y_scale_factor = int(display_y_resolution / WORLD_HEIGHT)
    new_scale_factor = min(max_x_scale_factor, max_y_scale_factor)
    new_scale_factor = max(1, new_scale_factor) # el factor de escala mínimo es 1
    return new_scale_factor


def scale_and_show_surface(surface):
    scaled_draw_surface = pygame.transform.scale(surface, (WORLD_WIDTH * scale_factor, WORLD_HEIGHT * scale_factor))
    display_surface.fill((0, 0, 0))
    display_surface.blit(scaled_draw_surface, ((surface.get_width() - scaled_draw_surface.get_width()) / 2, (surface.display_surface.get_height() - scaled_draw_surface.get_height()) / 2))
    pygame.display.update()


def screen_menu():
    global screen, scale_factor
    
    # lectura cola de eventos
    for event in pygame.event.get():
        if event.type == QUIT:
            pygame.quit()
            sys.exit()
        elif event.type == VIDEORESIZE:
            new_x_resolution, new_y_resolution = event.dict['size']
            scale_factor = get_new_scale_factor(new_x_resolution, new_y_resolution)
        elif event.type == pygame.KEYDOWN:
            if event.key == K_SPACE:
                init_game()
                screen = "game"

    draw_surface.fill((0, 0, 0))
    draw_surface.blit(img_menu_test_text, ((WORLD_WIDTH - img_menu_test_text.get_width()) / 2, 100))


def screen_game():
    global screen, scale_factor
    
    # lectura cola de eventos
    for event in pygame.event.get():
        if event.type == QUIT:
            pygame.quit()
            sys.exit()
        elif event.type == VIDEORESIZE:
            new_x_resolution, new_y_resolution = event.dict['size']
            scale_factor = get_new_scale_factor(new_x_resolution, new_y_resolution)
        elif event.type == pygame.KEYDOWN:
            if event.key == K_SPACE:
                pass    # TODO: if de ejemplo, cambiar para atender la pulsación de la tecla que necesite atender el juego

    draw_surface.fill((0, 0, 0))
    draw_surface.blit(img_game_test_text, ((WORLD_WIDTH - img_game_test_text.get_width()) / 2, 100))



# *** CUERPO PRINCIPAL DEL PROGRAMA ***

pygame.init()

# Definimos el factor inicial de escalado. Se usa para definir el tamaño inicial de la ventana
# del juego y para multiplicar la superficie draw_surface al mostrarla en display_surface
scale_factor = get_new_scale_factor(int(pygame.display.Info().current_w * 0.7), int(pygame.display.Info().current_h))

display_surface = pygame.display.set_mode((WORLD_WIDTH * scale_factor, WORLD_HEIGHT * scale_factor),  HWSURFACE | DOUBLEBUF | RESIZABLE)
draw_surface = pygame.Surface((WORLD_WIDTH, WORLD_HEIGHT),  HWSURFACE | DOUBLEBUF)

pygame.display.set_caption('Título de la ventana aquí')

font_medium = pygame.font.Font("assets/arcade_i.ttf", 11)

img_menu_test_text = font_medium.render("Texto de prueba para EL MENÚ", False, (0, 255, 0))
img_menu_test_text = font_medium.render("Texto de prueba para LA PARTIDA", False, (0, 255, 0))

frame_counter = 0
screen = "menu"
clock = pygame.time.Clock()
while True:  # Game loop
    if screen == "menu":
        screen_menu()
    elif screen == "game":
        screen_game()
    else:
        mi_error(f"Pantalla no válida: {screen}")
    
    scaled_draw_surface = pygame.transform.scale(draw_surface, (WORLD_WIDTH * scale_factor, WORLD_HEIGHT * scale_factor))
    display_surface.fill((0, 0, 0))
    display_surface.blit(scaled_draw_surface, ((display_surface.get_width() - scaled_draw_surface.get_width()) / 2, (display_surface.get_height() - scaled_draw_surface.get_height()) / 2))
    pygame.display.update()

    clock.tick(30)
    frame_counter += 1

