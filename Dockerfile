FROM python:3.9
ENV LANG en_US.UTF-8

WORKDIR /opt/build

RUN apt update && apt-get install -y tesseract-ocr libtesseract-dev libleptonica-dev pkg-config poppler-utils


ADD requirements.txt requirements.txt
RUN pip install -r requirements.txt

# trained models
ADD tessdata/ tessdata/
ENV TESSDATA_PREFIX /opt/build/tessdata/

ADD app/ app/
RUN mkdir input

# cloud run environments
ENV PORT 8080
ENV HOST 0.0.0.0


ENTRYPOINT ["python"]
CMD ["app/main.py"]