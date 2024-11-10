# Use the official PostgreSQL image as the base image
FROM postgres:latest

# Install build dependencies and pgvector
RUN apt-get update && \
    apt-get install -y git build-essential postgresql-server-dev-all && \
    git clone https://github.com/pgvector/pgvector.git && \
    cd pgvector && \
    make && \
    make install && \
    cd .. && \
    rm -rf pgvector && \
    apt-get remove --purge -y git build-essential postgresql-server-dev-all && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Copy the custom configuration file to the container (if needed)
# COPY ./postgresql.conf /etc/postgresql/postgresql.conf

# Set the environment variables
ENV POSTGRES_PASSWORD=${POSTGRES_PASSWORD}
ENV POSTGRES_DB=${POSTGRES_DB}

# Expose the PostgreSQL port
EXPOSE 5432

# Run the PostgreSQL server
CMD ["postgres"]
