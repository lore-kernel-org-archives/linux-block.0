Return-Path: <mcgrof@kernel.org>
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: damien.lemoal@wdc.com
Cc: hare@suse.de,
	axboe@kernel.dk,
	jaegeuk@kernel.org,
	yuchao0@huawei.com,
	ghe@suse.com,
	mwilck@suse.com,
	tchvatal@suse.com,
	zren@suse.com,
	agk@redhat.com,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: [PATCH] dm-zoned-tools: add zoned disk udev rules for scheduler / dmsetup
Date: Wed, 13 Jun 2018 17:11:47 -0700
Message-Id: <20180614001147.1545-1-mcgrof@kernel.org>
List-ID: <linux-block@vger.kernel.org>

Setting up a zoned disks in a generic form is not so trivial. There
is also quite a bit of tribal knowledge with these devices which is not
easy to find.

The currently supplied demo script works but it is not generic enough to be
practical for Linux distributions or even developers which often move
from one kernel to another.

This tries to put a bit of this tribal knowledge into an initial udev
rule for development with the hopes Linux distributions can later
deploy. Three rule are added. One rule is optional for now, it should be
extended later to be more distribution-friendly and then I think this
may be ready for consideration for integration on distributions.

1) scheduler setup
2) backlist f2fs devices
3) run dmsetup for the rest of devices

Note that this udev rule will not work well if you want to use a disk
with f2fs on part of the disk and another filesystem on another part of
the disk. That setup will require manual love so these setups can use
the same backlist on rule 2).

Its not widely known for instance that as of v4.16 it is mandated to use
either deadline or the mq-deadline scheduler for *all* SMR drivers. Its
also been determined that the Linux kernel is not the place to set this up,
so a udev rule *is required* as per latest discussions. This is the
first rule we add.

Furthermore if you are *not* using f2fs you always have to run dmsetup.
dmsetups do not persist, so you currently *always* have to run a custom
sort of script, which is not ideal for Linux distributions. We can invert
this logic into a udev rule to enable users to blacklist disks they know they
want to use f2fs for. This the second optional rule. This blacklisting
can be generalized further in the future with an exception list file, for
instance using INPUT{db} or the like.

The third and final rule added then runs dmsetup for the rest of the disks
using the disk serial number for the new device mapper name.

Note that it is currently easy for users to make a mistake and run mkfs
on the the original disk, not the /dev/mapper/ device for non f2fs
arrangements. If that is done experience shows things can easily fall
apart with alignment *eventually*. We have no generic way today to
error out on this condition and proactively prevent this.

Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
---
 README                    | 10 +++++-
 udev/99-zoned-disks.rules | 78 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 87 insertions(+), 1 deletion(-)
 create mode 100644 udev/99-zoned-disks.rules

diff --git a/README b/README
index 65e96c34fd04..f49541eaabc8 100644
--- a/README
+++ b/README
@@ -168,7 +168,15 @@ Options:
                      reclaiming random zones if the percentage of
                      free random data zones falls below <perc>.
 
-V. Example scripts
+V. Udev zone disk deployment
+============================
+
+A udev rule is provided which enables you to set the IO scheduler, blacklist
+driver to run dmsetup, and runs dmsetup for the rest of the zone drivers.
+If you use this udev rule the below script is not needed. Be sure to mkfs only
+on the resulting /dev/mapper/zone-$serial device you end up with.
+
+VI. Example scripts
 ==================
 
 [[
diff --git a/udev/99-zoned-disks.rules b/udev/99-zoned-disks.rules
new file mode 100644
index 000000000000..e19b738dcc0e
--- /dev/null
+++ b/udev/99-zoned-disks.rules
@@ -0,0 +1,78 @@
+# To use a zone disks first thing you need to:
+#
+# 1) Enable zone disk support in your kernel
+# 2) Use the deadline or mq-deadline scheduler for it - mandated as of v4.16
+# 3) Blacklist devices dedicated for f2fs as of v4.10
+# 4) Run dmsetup other disks
+# 5) Create the filesystem -- NOTE: use mkfs /dev/mapper/zone-serial if
+#    you enabled use dmsetup on the disk.
+# 6) Consider using nofail mount option in case you run an supported kernel
+#
+# You can use this udev rules file for 2) 3) and 4). Further details below.
+#
+# 1) Enable zone disk support in your kernel
+#
+#    o CONFIG_BLK_DEV_ZONED
+#    o CONFIG_DM_ZONED
+#
+# This will let the kernel actually see these devices, ie, via fdisk /dev/sda
+# for instance. Run:
+#
+# 	dmzadm --format /dev/sda
+
+# 2) Set deadline or mq-deadline for all disks which are zoned
+#
+# Zoned disks can only work with the deadline or mq-deadline scheduler. This is
+# mandated for all SMR drives since v4.16. It has been determined this must be
+# done through a udev rule, and the kernel should not set this up for disks.
+# This magic will have to live for *all* zoned disks.
+# XXX: what about distributions that want mq-deadline ? Probably easy for now
+#      to assume deadline and later have a mapping file to enable
+#      mq-deadline for specific serial devices?
+ACTION=="add|change", KERNEL=="sd*[!0-9]", ATTRS{queue/zoned}=="host-managed", \
+	ATTR{queue/scheduler}="deadline"
+
+# 3) Blacklist f2fs devices as of v4.10
+# We don't have to run dmsetup on on disks where you want to use f2fs, so you
+# can use this rule to skip dmsetup for it. First get the serial short number.
+#
+#	udevadm info --name=/dev/sda  | grep -i serial_shor
+# XXX: To generalize this for distributions consider using INPUT{db} to or so
+# and then use that to check if the serial number matches one on the database.
+#ACTION=="add", SUBSYSTEM=="block", ENV{ID_SERIAL_SHORT}=="XXA1ZFFF", GOTO="zone_disk_group_end"
+
+# 4) We need to run dmsetup if you want to use other filesystems
+#
+# dmsetup is not persistent, so it needs to be run on upon every boot.  We use
+# the device serial number for the /dev/mapper/ name.
+ACTION=="add", KERNEL=="sd*[!0-9]", ATTRS{queue/zoned}=="host-managed", \
+	RUN+="/sbin/dmsetup create zoned-$env{ID_SERIAL_SHORT} --table '0 %s{size} zoned $devnode'", $attr{size}
+
+# 4) Create a filesystem for the device
+#
+# Be 100% sure you use /dev/mapper/zone-$YOUR_DEVICE_SERIAL for the mkfs
+# command as otherwise things can break.
+#
+# XXX: preventing the above proactively in the kernel would be ideal however
+# this may be hard.
+#
+# Once you create the filesystem it will get a UUID.
+#
+# Find out what UUID is, you can do this for instance if your zoned disk is
+# your second device-mapper device, ie dm-1 by:
+#
+# 	ls -l /dev/disk/by-uuid/dm-1
+#
+# To figure out which dm-$number it is, use dmsetup info, the minor number
+# is the $number.
+#
+# 5) Add an etry in /etc/fstab with nofail for example:
+#
+# UUID=99999999-aaaa-bbbb-c1234aaaabbb33456 /media/monster xfs nofail 0 0
+#
+# nofail will ensure system boots fine even if you boot into a kernel which
+# lacks support for the device and so it is not found. Since the UUID will
+# always match the device we don't care if the device moves around the bus
+# on the system. We just need to get the UUID once.
+
+LABEL="zone_disk_group_end"
-- 
2.16.3
