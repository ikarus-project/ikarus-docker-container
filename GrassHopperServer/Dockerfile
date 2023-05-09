FROM ikarusproject/ikarus:latest

USER user

ENV DEBIAN_FRONTEND "noninteractive"
ENV CI true
EXPOSE 5000

RUN /dune/dune-common/build-cmake/run-in-dune-env python -m pip install ghhops_server flask

USER root
RUN chmod +x /entrypoint.sh
USER user

ENTRYPOINT ["/entrypoint.sh"]


