import os
import tempfile

from tesserocr import image_to_text
from pdf2image import convert_from_path
from tqdm import tqdm


curr_directory = os.getcwd()
input_path = os.path.join(curr_directory, "input")


def read_pdf(pdf):
    full_text = ''
    pdf = os.path.join(input_path, pdf)
    with tempfile.TemporaryDirectory() as path:
        images_from_path = convert_from_path(
            pdf, 350, output_folder=path)

        for page in tqdm(images_from_path):
            full_text += image_to_text(page, lang='spa')
    return full_text


print(read_pdf("input.pdf"))
print("hello")
