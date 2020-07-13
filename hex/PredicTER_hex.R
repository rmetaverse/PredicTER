# hex sticker for revtools

# revtools logo

# install.packages("extrafont")
# install.packages("hexSticker")
# library(devtools)
# install_github("mjwestgate/circleplot")

library(hexSticker)
library(viridis)
library(ggplot2)
library(magick)

sticker(
  ggplot() + theme_void() + theme_transparent(),
  package = "PredicTER",
  p_y = 1,
  p_color = "black", # "#21908CFF",
  p_family = "sans",
  h_fill = "white",
  h_size = 3,
  h_color = "black",
  url = "predicter.org",
  u_family = "sans",
  u_y = 0.15,
  u_size = 2.5,
  u_color = "black",
  filename = "mask_text.png",
  dpi = 600
)



# following code based on example from greta:
# https://github.com/greta-dev/greta/blob/master/logos/make_hex.R
# create a blank hex sticker to act as a mask to our completed version
sticker(
  ggplot() + theme_void() + theme_transparent(),
  package = "",
  h_fill = "black", # "#21908CFF",
  h_size = 0,
  filename = "mask.png",
  dpi = 600
)


data <- expand.grid(x = c(1:80), y = seq_len(100))
p <- ggplot(data, aes(x = x, y = y)) +
  coord_fixed() +
  geom_raster(aes(fill = x)) +
  scale_fill_viridis(
    option = "viridis",
    begin = 0.15,
    end = 0.9,
    direction = -1
  ) +
  theme_void() + theme(legend.position = "none")

sticker(
  p,
  s_x = 1,
  s_y = 1,
  s_width = 2,
  s_height = 3,
  package = "",
  filename = "viridis.png",
  h_size = 0,
  dpi = 600
)
# ggsave("virids_mask.png")


# crop new sticker by 'mask'
mask_text <- image_read("mask_text.png") #, strip = TRUE)
mask_text <- image_transparent(mask_text, "black")
# mask <- image_background(mask, "blue")
# plot(mask_text)
background <- image_read("viridis.png")
img <- c(background, mask_text)
grouped_image <- image_mosaic(img)
plot(grouped_image)
mask <- image_read("mask.png") #, strip = TRUE)

mask <- image_background(mask, "white")
mask <- image_transparent(mask, "white")
cropped_image <- image_composite(grouped_image, mask, "CopyOpacity")
plot(cropped_image)
image_write(cropped_image, "PredicTER_hex.png")