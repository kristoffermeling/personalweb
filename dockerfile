# Use the official lightweight Python image
FROM python:3.9

# Install Nginx
RUN apt-get update
RUN apt-get update && apt-get install -y nginx
RUN pip install gunicorn
#RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y certbot python3-certbot-nginx


# Set up the Flask application
WORKDIR /app
COPY . /app
RUN pip install --trusted-host pypi.python.org -r requirements.txt

# Copy the Nginx configuration file
COPY nginx.conf /etc/nginx/sites-available/default
COPY kmeling.info.pem /app/
COPY kmeling.info.key /app/
# Expose ports
EXPOSE 8080


# Run the app with Gunicorn
CMD service nginx start && gunicorn --bind 0.0.0.0:8080 run:app
