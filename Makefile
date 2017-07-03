PREFIX := /usr/local
SYSTEMD_HOME := $(PREFIX)/lib/systemd/system

all:
.PHONY: all

install: $(DESTDIR)$(SYSTEMD_HOME)
	install -m 0755 -d $(DESTDIR)$(PREFIX)/sbin $(DESTDIR)$(PREFIX)/share/man/man8
	install -m 0755 src/zfs-auto-snapshot.sh $(DESTDIR)$(PREFIX)/sbin/zfs-auto-snapshot
	install -m 0644 -t $(DESTDIR)$(PREFIX)/share/man/man8 src/zfs-auto-snapshot.8
	install -m 0644 -t $(DESTDIR)$(SYSTEMD_HOME) \
		timers/zfs-auto-snapshot-daily.service \
		timers/zfs-auto-snapshot-daily.timer \
		timers/zfs-auto-snapshot-frequent.service \
		timers/zfs-auto-snapshot-frequent.timer \
		timers/zfs-auto-snapshot-hourly.service \
		timers/zfs-auto-snapshot-hourly.timer \
		timers/zfs-auto-snapshot-monthly.service \
		timers/zfs-auto-snapshot-monthly.timer \
		timers/zfs-auto-snapshot-weekly.service \
		timers/zfs-auto-snapshot-weekly.timer \
		timers/zfs-auto-snapshot.target
.PHONY: install

$(DESTDIR)$(SYSTEMD_HOME):
	mkdir -p $(DESTDIR)$(SYSTEMD_HOME)
.PHONY: $(DESTDIR)$(SYSTEMD_HOME)

enable: install
	systemctl enable --now zfs-auto-snapshot.target
.PHONY: enable
