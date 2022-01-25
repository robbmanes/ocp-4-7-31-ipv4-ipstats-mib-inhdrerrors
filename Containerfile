FROM registry.redhat.io/ubi8:8.4
COPY entrypoint.sh /root/entrypoint.sh
COPY ipv4-ipstats-mib-inhdrerrors.stap /root/ipv4-ipstats-mib-inhdrerrors.stap
RUN chmod +x /root/entrypoint.sh & \
    yum install -y \
      --enablerepo=rhel-8-for-x86_64-appstream-debug-rpms \
      --enablerepo=rhel-8-for-x86_64-baseos-debug-rpms \
      systemtap \
      kernel-debuginfo-4.18.0-305.19.1.el8_4.x86_64 \
      kernel-devel-4.18.0-305.19.1.el8_4.x86_64
# Must run as root, unfortunately:
USER root
CMD ["/root/entrypoint.sh"]
