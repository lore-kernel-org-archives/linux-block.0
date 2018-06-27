Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:46714 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934753AbeF0VtL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Jun 2018 17:49:11 -0400
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Omar Sandoval <osandov@fb.com>
Cc: linux-block@vger.kernel.org,
        Bart Van Assche <bart.vanassche@wdc.com>
Subject: [PATCH blktests v2 3/3] Add tests for the SRP initiator and target drivers
Date: Wed, 27 Jun 2018 14:49:08 -0700
Message-Id: <20180627214908.26379-4-bart.vanassche@wdc.com>
In-Reply-To: <20180627214908.26379-1-bart.vanassche@wdc.com>
References: <20180627214908.26379-1-bart.vanassche@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This patch adds the following tests:
001: Create and remove LUNs
002: File I/O on top of multipath concurrently with logout and login (mq)
003: File I/O on top of multipath concurrently with logout and login (sq)
004: File I/O on top of multipath concurrently with logout and login (sq-on-mq)
005: Direct I/O with large transfer sizes, cmd_sg_entries=255 and bs=4M
006: Direct I/O with large transfer sizes, cmd_sg_entries=255 and bs=8M
007: Direct I/O with large transfer sizes, cmd_sg_entries=1 and bs=4M
008: Direct I/O with large transfer sizes, cmd_sg_entries=1 and bs=8M
009: Buffered I/O with large transfer sizes, cmd_sg_entries=255 and bs=4M
010: Buffered I/O with large transfer sizes, cmd_sg_entries=255 and bs=8M
011: Block I/O on top of multipath concurrently with logout and login
012: dm-mpath on top of multiple I/O schedulers
013: Direct I/O using a discontiguous buffer

Other changes in this patch are:
- Document required kernel config options, user space packages and
  multipath.conf in README.md.
- Add file tests/srp/functions with shell functions that are used by
  multiple SRP tests.
- Add file tests/srp/rc.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
---
 README.md           |   71 +++
 tests/srp/001       |   71 +++
 tests/srp/001.out   |    8 +
 tests/srp/002       |   49 ++
 tests/srp/002.out   |    7 +
 tests/srp/003       |   50 ++
 tests/srp/003.out   |    7 +
 tests/srp/004       |   50 ++
 tests/srp/004.out   |    7 +
 tests/srp/005       |   40 ++
 tests/srp/005.out   |    7 +
 tests/srp/006       |   40 ++
 tests/srp/006.out   |    7 +
 tests/srp/007       |   40 ++
 tests/srp/007.out   |    7 +
 tests/srp/008       |   39 ++
 tests/srp/008.out   |    7 +
 tests/srp/009       |   40 ++
 tests/srp/009.out   |    7 +
 tests/srp/010       |   40 ++
 tests/srp/010.out   |    7 +
 tests/srp/011       |   44 ++
 tests/srp/011.out   |    7 +
 tests/srp/012       |   52 ++
 tests/srp/012.out   |    8 +
 tests/srp/013       |   48 ++
 tests/srp/013.out   |    8 +
 tests/srp/functions | 1288 +++++++++++++++++++++++++++++++++++++++++++
 tests/srp/rc        |   54 ++
 29 files changed, 2110 insertions(+)
 create mode 100755 tests/srp/001
 create mode 100644 tests/srp/001.out
 create mode 100755 tests/srp/002
 create mode 100644 tests/srp/002.out
 create mode 100755 tests/srp/003
 create mode 100644 tests/srp/003.out
 create mode 100755 tests/srp/004
 create mode 100644 tests/srp/004.out
 create mode 100755 tests/srp/005
 create mode 100644 tests/srp/005.out
 create mode 100755 tests/srp/006
 create mode 100644 tests/srp/006.out
 create mode 100755 tests/srp/007
 create mode 100644 tests/srp/007.out
 create mode 100755 tests/srp/008
 create mode 100644 tests/srp/008.out
 create mode 100755 tests/srp/009
 create mode 100644 tests/srp/009.out
 create mode 100755 tests/srp/010
 create mode 100644 tests/srp/010.out
 create mode 100755 tests/srp/011
 create mode 100644 tests/srp/011.out
 create mode 100755 tests/srp/012
 create mode 100644 tests/srp/012.out
 create mode 100755 tests/srp/013
 create mode 100644 tests/srp/013.out
 create mode 100755 tests/srp/functions
 create mode 100755 tests/srp/rc

diff --git a/README.md b/README.md
index 78a41567416e..d8df938700cd 100644
--- a/README.md
+++ b/README.md
@@ -6,6 +6,38 @@ filesystem testing framework.
 
 ## Getting Started
 
+Make sure that at least the following symbols are set in the kernel config:
+
+* CONFIG_BLK_DEV_DM
+* CONFIG_BLK_DEV_NULL_BLK
+* CONFIG_BLK_DEV_RAM
+* CONFIG_BLK_DEV_SD
+* CONFIG_CHR_DEV_SG
+* CONFIG_DM_MULTIPATH
+* CONFIG_DM_MULTIPATH_QL
+* CONFIG_DM_MULTIPATH_ST
+* CONFIG_INFINIBAND
+* CONFIG_INFINIBAND_ADDR_TRANS
+* CONFIG_INFINIBAND_IPOIB
+* CONFIG_INFINIBAND_SRP
+* CONFIG_INFINIBAND_SRPT
+* CONFIG_INFINIBAND_USER_ACCESS
+* CONFIG_INFINIBAND_USER_MAD
+* CONFIG_INFINIBAND_USER_MEM
+* CONFIG_NVME_CORE
+* CONFIG_NVME_RDMA
+* CONFIG_NVME_TARGET
+* CONFIG_NVME_TARGET_RDMA
+* CONFIG_RDMA_RXE
+* CONFIG_SCSI_DEBUG
+* CONFIG_SCSI_DH_ALUA
+* CONFIG_SCSI_DH_EMC
+* CONFIG_SCSI_DH_RDAC
+* CONFIG_SCSI_SRP_ATTRS
+* CONFIG_TARGET_CORE
+* CONFIG_TCM_FILEIO
+* CONFIG_TCM_IBLOCK
+
 The dependencies are minimal, but make sure you have them installed:
 
 - bash 4
@@ -13,6 +45,10 @@ The dependencies are minimal, but make sure you have them installed:
 - GNU awk
 - util-linux
 - fio
+- gcc
+- make
+- multipath-tools or device-mapper-multipath
+- e2fsprogs and xfsprogs
 
 Add the list of block devices you want to test on in a file named `config`:
 
@@ -20,6 +56,41 @@ Add the list of block devices you want to test on in a file named `config`:
 TEST_DEVS=(/dev/nvme0n1 /dev/sdb)
 ```
 
+For the SRP tests, merge or copy the following into /etc/multipathd.conf and
+restart multipathd:
+
+<span></span>
+
+    defaults {
+        user_friendly_names     yes
+        queue_without_daemon    no
+    }
+    devices {
+        device {
+            vendor       "LIO-ORG|SCST_BIO|FUSIONIO"
+            product      ".*"
+            features     "1 queue_if_no_path"
+            path_checker tur
+        }
+    }
+    blacklist {
+        device {
+            vendor  "ATA"
+        }
+        device {
+            vendor  "QEMU"
+        }
+        device {
+            vendor  "Linux"
+            product "scsi_debug"
+        }
+        devnode     "^nullb.*"
+    }
+    blacklist_exceptions {
+        property        ".*"
+        devnode         "^nvme"
+    }
+
 And as root, run the default set of tests with `./check`.
 
 Note that these tests are destructive, so don't add anything to the `TEST_DEVS`
diff --git a/tests/srp/001 b/tests/srp/001
new file mode 100755
index 000000000000..03f17de44707
--- /dev/null
+++ b/tests/srp/001
@@ -0,0 +1,71 @@
+#!/bin/bash
+#
+# Copyright (c) 2016-2018 Western Digital Corporation or its affiliates
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License
+# as published by the Free Software Foundation; either version 2
+# of the License, or (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write to the Free Software
+# Foundation, Inc.
+
+. tests/srp/functions
+
+DESCRIPTION="Create and remove LUNs"
+
+# Count the number of LUNs created by start_srpt() from the initiator side.
+count_srp_luns() {
+	local h luns=0 p
+
+	for p in /sys/class/srp_remote_ports/*; do
+		[ -e "$p" ] || continue
+		h="${p##*/}"; h="${h#port-}"; h="${h%:1}";
+		for d in "/sys/class/scsi_device/${h}:"*; do
+			[ -e "$d" ] && ((luns++))
+		done
+		[ "$luns" -gt 0 ] && break
+	done
+	echo $luns
+}
+
+count_nvme_devs() {
+	local d devs=0
+
+	for d in /sys/class/nvme-fabrics/ctl/*/*/device; do
+		[ -d "$d" ] && ((devs++))
+	done
+	echo $devs
+}
+
+count_luns() {
+	if [ -n "$nvme" ]; then
+		count_nvme_devs
+	else
+		count_srp_luns
+	fi
+}
+
+wait_for_luns() {
+	local i luns
+
+	use_blk_mq y y || return $?
+	for ((i=0;i<100;i++)); do
+		luns=$(count_luns)
+		[ "$luns" -ge ${#vdev_path[@]} ] && break
+		sleep .1
+	done
+	echo "count_luns(): $luns <> ${#vdev_path[@]}" >>"$FULL"
+	echo "count_luns(): $luns <> ${#vdev_path[@]}"
+	[ "$luns" -ge ${#vdev_path[@]} ]
+}
+
+test() {
+	setup && wait_for_luns && teardown
+}
diff --git a/tests/srp/001.out b/tests/srp/001.out
new file mode 100644
index 000000000000..eae5d6b0e5b2
--- /dev/null
+++ b/tests/srp/001.out
@@ -0,0 +1,8 @@
+Unloaded the ib_srpt kernel module
+Unloaded the rdma_rxe kernel module
+
+Configured SRP target driver
+Unloaded the ib_srp kernel module
+count_luns(): 3 <> 3
+Unloaded the ib_srpt kernel module
+Unloaded the rdma_rxe kernel module
diff --git a/tests/srp/002 b/tests/srp/002
new file mode 100755
index 000000000000..80912ffb82a8
--- /dev/null
+++ b/tests/srp/002
@@ -0,0 +1,49 @@
+#!/bin/bash
+#
+# Copyright (c) 2016-2018 Western Digital Corporation or its affiliates
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License
+# as published by the Free Software Foundation; either version 2
+# of the License, or (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write to the Free Software
+# Foundation, Inc.
+
+. tests/srp/functions
+
+DESCRIPTION="File I/O on top of multipath concurrently with logout and login (mq)"
+TIMED=1
+
+test_disconnect_repeatedly() {
+	local dev fio_status m
+
+	use_blk_mq y y || return $?
+	dev=$(get_bdev 0) || return $?
+	m=$(mountpoint 0) || return $?
+	create_filesystem "$dev" || return $?
+	mount_and_check "$dev" "$m" || return $?
+	simulate_network_failure_loop "$dev" "$TIMEOUT" &
+	run_fio --verify=md5 -rw=randwrite --bs=4K --loops=$((10**6)) \
+		--iodepth=64 --group_reporting --sync=1 --direct=1 \
+		--ioengine=libaio --directory="$m" --runtime="${TIMEOUT}" \
+		--name=data-integrity-test-mq --thread --numjobs=16 \
+		--output="${TMPDIR}/fio-output-srp-002.txt" \
+		>/dev/null
+	fio_status=$?
+	wait
+	[ -z "$nvme" ] && log_in
+	[ "$fio_status" = 0 ] || return "$fio_status"
+	unmount_and_check "$m" || return $?
+	return $fio_status
+}
+
+test() {
+	setup && test_disconnect_repeatedly && teardown
+}
diff --git a/tests/srp/002.out b/tests/srp/002.out
new file mode 100644
index 000000000000..6f14079ec4c6
--- /dev/null
+++ b/tests/srp/002.out
@@ -0,0 +1,7 @@
+Unloaded the ib_srp kernel module
+Unloaded the ib_srpt kernel module
+Unloaded the rdma_rxe kernel module
+Configured SRP target driver
+Unloaded the ib_srp kernel module
+Unloaded the ib_srpt kernel module
+Unloaded the rdma_rxe kernel module
diff --git a/tests/srp/003 b/tests/srp/003
new file mode 100755
index 000000000000..7506a9504430
--- /dev/null
+++ b/tests/srp/003
@@ -0,0 +1,50 @@
+#!/bin/bash
+#
+# Copyright (c) 2016-2018 Western Digital Corporation or its affiliates
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License
+# as published by the Free Software Foundation; either version 2
+# of the License, or (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write to the Free Software
+# Foundation, Inc.
+
+. tests/srp/functions
+
+DESCRIPTION="File I/O on top of multipath concurrently with logout and login (sq)"
+TIMED=1
+
+test_disconnect_repeatedly() {
+	local dev fio_status m
+
+	use_blk_mq n n || return $?
+	dev=$(get_bdev 0) || return $?
+	m=$(mountpoint 0) || return $?
+	create_filesystem "$dev" || return $?
+	mount_and_check "$dev" "$m" || return $?
+	simulate_network_failure_loop "$dev" "$TIMEOUT" &
+	run_fio --verify=md5 -rw=randwrite --bs=4K --loops=$((10**6)) \
+		--iodepth=64 --group_reporting --sync=1 --direct=1 \
+		--ioengine=libaio --directory="$m" --runtime="${TIMEOUT}" \
+		--name=data-integrity-test-sq --thread --numjobs=16 \
+		--output="${TMPDIR}/fio-output-srp-003.txt" \
+		>/dev/null
+	fio_status=$?
+	wait
+	[ -z "$nvme" ] && log_in
+	[ "$fio_status" = 0 ] || return "$fio_status"
+	unmount_and_check "$m" || return $?
+	log_out
+	return $fio_status
+}
+
+test() {
+	setup && test_disconnect_repeatedly && teardown
+}
diff --git a/tests/srp/003.out b/tests/srp/003.out
new file mode 100644
index 000000000000..6f14079ec4c6
--- /dev/null
+++ b/tests/srp/003.out
@@ -0,0 +1,7 @@
+Unloaded the ib_srp kernel module
+Unloaded the ib_srpt kernel module
+Unloaded the rdma_rxe kernel module
+Configured SRP target driver
+Unloaded the ib_srp kernel module
+Unloaded the ib_srpt kernel module
+Unloaded the rdma_rxe kernel module
diff --git a/tests/srp/004 b/tests/srp/004
new file mode 100755
index 000000000000..60bd4077ac08
--- /dev/null
+++ b/tests/srp/004
@@ -0,0 +1,50 @@
+#!/bin/bash
+#
+# Copyright (c) 2016-2018 Western Digital Corporation or its affiliates
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License
+# as published by the Free Software Foundation; either version 2
+# of the License, or (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write to the Free Software
+# Foundation, Inc.
+
+. tests/srp/functions
+
+DESCRIPTION="File I/O on top of multipath concurrently with logout and login (sq-on-mq)"
+TIMED=1
+
+test_disconnect_repeatedly() {
+	local dev fio_status m
+
+	use_blk_mq n y || return $?
+	dev=$(get_bdev 0) || return $?
+	m=$(mountpoint 0) || return $?
+	create_filesystem "$dev" || return $?
+	mount_and_check "$dev" "$m" || return $?
+	simulate_network_failure_loop "$dev" "$TIMEOUT" &
+	run_fio --verify=md5 -rw=randwrite --bs=4K --loops=$((10**6)) \
+		--iodepth=64 --group_reporting --sync=1 --direct=1 \
+		--ioengine=libaio --directory="$m" \
+		--name=data-integrity-test-02-sq-on-mq --thread \
+		--numjobs=16 --runtime="${TIMEOUT}" \
+		--output="${TMPDIR}/fio-output-srp-004.txt" >/dev/null
+	fio_status=$?
+	wait
+	[ -z "$nvme" ] && log_in
+	[ "$fio_status" = 0 ] || return "$fio_status"
+	unmount_and_check "$m" || return $?
+	log_out
+	return $fio_status
+}
+
+test() {
+	setup && test_disconnect_repeatedly && teardown
+}
diff --git a/tests/srp/004.out b/tests/srp/004.out
new file mode 100644
index 000000000000..6f14079ec4c6
--- /dev/null
+++ b/tests/srp/004.out
@@ -0,0 +1,7 @@
+Unloaded the ib_srp kernel module
+Unloaded the ib_srpt kernel module
+Unloaded the rdma_rxe kernel module
+Configured SRP target driver
+Unloaded the ib_srp kernel module
+Unloaded the ib_srpt kernel module
+Unloaded the rdma_rxe kernel module
diff --git a/tests/srp/005 b/tests/srp/005
new file mode 100755
index 000000000000..2a64e2ff091f
--- /dev/null
+++ b/tests/srp/005
@@ -0,0 +1,40 @@
+#!/bin/bash
+#
+# Copyright (c) 2016-2018 Western Digital Corporation or its affiliates
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License
+# as published by the Free Software Foundation; either version 2
+# of the License, or (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write to the Free Software
+# Foundation, Inc.
+
+. tests/srp/functions
+
+DESCRIPTION="Direct I/O with large transfer sizes, cmd_sg_entries=255 and bs=4M"
+QUICK=1
+
+test_large_transfer_size() {
+	local dev m
+
+	srp_login_params+=ch_count=1,queue_size=32,max_cmd_per_lun=32,max_sect=$((1<<17))
+	use_blk_mq y y cmd_sg_entries=255 || return $?
+	dev=$(get_bdev 0) || return $?
+	run_fio --verify=md5 -rw=randwrite --bs=4M --loops=$((10**6)) \
+		--iodepth=4 --group_reporting --sync=1 --direct=1 \
+		--ioengine=libaio \
+		--filename="$dev" --name=large-io-test --thread --numjobs=1 \
+		--runtime=10 --output="${TMPDIR}/fio-output-srp-005.txt" \
+		>/dev/null
+}
+
+test() {
+	setup && test_large_transfer_size && teardown
+}
diff --git a/tests/srp/005.out b/tests/srp/005.out
new file mode 100644
index 000000000000..6f14079ec4c6
--- /dev/null
+++ b/tests/srp/005.out
@@ -0,0 +1,7 @@
+Unloaded the ib_srp kernel module
+Unloaded the ib_srpt kernel module
+Unloaded the rdma_rxe kernel module
+Configured SRP target driver
+Unloaded the ib_srp kernel module
+Unloaded the ib_srpt kernel module
+Unloaded the rdma_rxe kernel module
diff --git a/tests/srp/006 b/tests/srp/006
new file mode 100755
index 000000000000..a0cba7116c4b
--- /dev/null
+++ b/tests/srp/006
@@ -0,0 +1,40 @@
+#!/bin/bash
+#
+# Copyright (c) 2016-2018 Western Digital Corporation or its affiliates
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License
+# as published by the Free Software Foundation; either version 2
+# of the License, or (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write to the Free Software
+# Foundation, Inc.
+
+. tests/srp/functions
+
+DESCRIPTION="Direct I/O with large transfer sizes, cmd_sg_entries=255 and bs=8M"
+QUICK=1
+
+test_large_transfer_size() {
+	local dev m
+
+	srp_login_params+=ch_count=1,queue_size=32,max_cmd_per_lun=32,max_sect=$((1<<17))
+	use_blk_mq y y cmd_sg_entries=255 || return $?
+	dev=$(get_bdev 0) || return $?
+	run_fio --verify=md5 -rw=randwrite --bs=8M --loops=$((10**6)) \
+		--iodepth=4 --group_reporting --sync=1 --direct=1 \
+		--ioengine=libaio \
+		--filename="$dev" --name=large-io-test --thread --numjobs=1 \
+		--runtime=10 --output="${TMPDIR}/fio-output-srp-006.txt" \
+		>/dev/null
+}
+
+test() {
+	setup && test_large_transfer_size && teardown
+}
diff --git a/tests/srp/006.out b/tests/srp/006.out
new file mode 100644
index 000000000000..6f14079ec4c6
--- /dev/null
+++ b/tests/srp/006.out
@@ -0,0 +1,7 @@
+Unloaded the ib_srp kernel module
+Unloaded the ib_srpt kernel module
+Unloaded the rdma_rxe kernel module
+Configured SRP target driver
+Unloaded the ib_srp kernel module
+Unloaded the ib_srpt kernel module
+Unloaded the rdma_rxe kernel module
diff --git a/tests/srp/007 b/tests/srp/007
new file mode 100755
index 000000000000..bbb56cef865c
--- /dev/null
+++ b/tests/srp/007
@@ -0,0 +1,40 @@
+#!/bin/bash
+#
+# Copyright (c) 2016-2018 Western Digital Corporation or its affiliates
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License
+# as published by the Free Software Foundation; either version 2
+# of the License, or (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write to the Free Software
+# Foundation, Inc.
+
+. tests/srp/functions
+
+DESCRIPTION="Direct I/O with large transfer sizes, cmd_sg_entries=1 and bs=4M"
+QUICK=1
+
+test_low_sg_size() {
+	local dev m
+
+	srp_login_params+=ch_count=1
+	use_blk_mq y y "cmd_sg_entries=1" || return $?
+	dev=$(get_bdev 0) || return $?
+	run_fio --verify=md5 -rw=randwrite --bs=4M --loops=$((10**6)) \
+		--iodepth=4 --group_reporting --sync=1 --direct=1 \
+		--ioengine=libaio \
+		--filename="$dev" --name=low-sg-test --thread --numjobs=1 \
+		--size=${ramdisk_size} --runtime=10 \
+		--output="${TMPDIR}/fio-output-srp-007.txt" >/dev/null
+}
+
+test() {
+	setup && test_low_sg_size && teardown
+}
diff --git a/tests/srp/007.out b/tests/srp/007.out
new file mode 100644
index 000000000000..6f14079ec4c6
--- /dev/null
+++ b/tests/srp/007.out
@@ -0,0 +1,7 @@
+Unloaded the ib_srp kernel module
+Unloaded the ib_srpt kernel module
+Unloaded the rdma_rxe kernel module
+Configured SRP target driver
+Unloaded the ib_srp kernel module
+Unloaded the ib_srpt kernel module
+Unloaded the rdma_rxe kernel module
diff --git a/tests/srp/008 b/tests/srp/008
new file mode 100755
index 000000000000..d88f6dcd39c0
--- /dev/null
+++ b/tests/srp/008
@@ -0,0 +1,39 @@
+#!/bin/bash
+#
+# Copyright (c) 2016-2018 Western Digital Corporation or its affiliates
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License
+# as published by the Free Software Foundation; either version 2
+# of the License, or (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write to the Free Software
+# Foundation, Inc.
+
+. tests/srp/functions
+
+DESCRIPTION="Direct I/O with large transfer sizes, cmd_sg_entries=1 and bs=8M"
+QUICK=1
+
+test_low_sg_size() {
+	local dev m
+
+	srp_login_params+=ch_count=1
+	use_blk_mq y y "cmd_sg_entries=1" || return $?
+	dev=$(get_bdev 0) || return $?
+	run_fio --verify=md5 -rw=randwrite --bs=8M --loops=$((10**6)) \
+		--iodepth=4 --group_reporting --sync=1 --direct=1 \
+		--ioengine=libaio --size=${ramdisk_size} --runtime=10 \
+		--filename="$dev" --name=low-sg-test --thread --numjobs=1 \
+		--output="${TMPDIR}/fio-output-srp-008.txt" >/dev/null
+}
+
+test() {
+	setup && test_low_sg_size && teardown
+}
diff --git a/tests/srp/008.out b/tests/srp/008.out
new file mode 100644
index 000000000000..6f14079ec4c6
--- /dev/null
+++ b/tests/srp/008.out
@@ -0,0 +1,7 @@
+Unloaded the ib_srp kernel module
+Unloaded the ib_srpt kernel module
+Unloaded the rdma_rxe kernel module
+Configured SRP target driver
+Unloaded the ib_srp kernel module
+Unloaded the ib_srpt kernel module
+Unloaded the rdma_rxe kernel module
diff --git a/tests/srp/009 b/tests/srp/009
new file mode 100755
index 000000000000..6785ccee7abe
--- /dev/null
+++ b/tests/srp/009
@@ -0,0 +1,40 @@
+#!/bin/bash
+#
+# Copyright (c) 2016-2018 Western Digital Corporation or its affiliates
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License
+# as published by the Free Software Foundation; either version 2
+# of the License, or (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write to the Free Software
+# Foundation, Inc.
+
+. tests/srp/functions
+
+DESCRIPTION="Buffered I/O with large transfer sizes, cmd_sg_entries=255 and bs=4M"
+QUICK=1
+
+test_large_transfer_size() {
+	local dev m
+
+	srp_login_params+=ch_count=1,queue_size=32,max_cmd_per_lun=32,max_sect=$((1<<17))
+	use_blk_mq y y cmd_sg_entries=255 || return $?
+	dev=$(get_bdev 0) || return $?
+	run_fio --verify=md5 -rw=randwrite --bs=4M --loops=$((10**6)) \
+		--iodepth=4 --group_reporting --sync=1 --direct=0 \
+		--ioengine=libaio \
+		--filename="$dev" --name=large-io-test --thread --numjobs=1 \
+		--runtime=10 --output="${TMPDIR}/fio-output-srp-009.txt" \
+		>/dev/null
+}
+
+test() {
+	setup && test_large_transfer_size && teardown
+}
diff --git a/tests/srp/009.out b/tests/srp/009.out
new file mode 100644
index 000000000000..6f14079ec4c6
--- /dev/null
+++ b/tests/srp/009.out
@@ -0,0 +1,7 @@
+Unloaded the ib_srp kernel module
+Unloaded the ib_srpt kernel module
+Unloaded the rdma_rxe kernel module
+Configured SRP target driver
+Unloaded the ib_srp kernel module
+Unloaded the ib_srpt kernel module
+Unloaded the rdma_rxe kernel module
diff --git a/tests/srp/010 b/tests/srp/010
new file mode 100755
index 000000000000..a16638d34c73
--- /dev/null
+++ b/tests/srp/010
@@ -0,0 +1,40 @@
+#!/bin/bash
+#
+# Copyright (c) 2016-2018 Western Digital Corporation or its affiliates
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License
+# as published by the Free Software Foundation; either version 2
+# of the License, or (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write to the Free Software
+# Foundation, Inc.
+
+. tests/srp/functions
+
+DESCRIPTION="Buffered I/O with large transfer sizes, cmd_sg_entries=255 and bs=8M"
+QUICK=1
+
+test_large_transfer_size() {
+	local dev m
+
+	srp_login_params+=ch_count=1,queue_size=32,max_cmd_per_lun=32,max_sect=$((1<<17))
+	use_blk_mq y y cmd_sg_entries=255 || return $?
+	dev=$(get_bdev 0) || return $?
+	run_fio --verify=md5 -rw=randwrite --bs=8M --loops=$((10**6)) \
+		--iodepth=4 --group_reporting --sync=1 --direct=0 \
+		--ioengine=libaio \
+		--filename="$dev" --name=large-io-test --thread --numjobs=1 \
+		--runtime=10 --output="${TMPDIR}/fio-output-srp-010.txt" \
+		>/dev/null
+}
+
+test() {
+	setup && test_large_transfer_size && teardown
+}
diff --git a/tests/srp/010.out b/tests/srp/010.out
new file mode 100644
index 000000000000..6f14079ec4c6
--- /dev/null
+++ b/tests/srp/010.out
@@ -0,0 +1,7 @@
+Unloaded the ib_srp kernel module
+Unloaded the ib_srpt kernel module
+Unloaded the rdma_rxe kernel module
+Configured SRP target driver
+Unloaded the ib_srp kernel module
+Unloaded the ib_srpt kernel module
+Unloaded the rdma_rxe kernel module
diff --git a/tests/srp/011 b/tests/srp/011
new file mode 100755
index 000000000000..5f467377c356
--- /dev/null
+++ b/tests/srp/011
@@ -0,0 +1,44 @@
+#!/bin/bash
+#
+# Copyright (c) 2016-2018 Western Digital Corporation or its affiliates
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License
+# as published by the Free Software Foundation; either version 2
+# of the License, or (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write to the Free Software
+# Foundation, Inc.
+
+. tests/srp/functions
+
+DESCRIPTION="Block I/O on top of multipath concurrently with logout and login"
+TIMED=1
+
+test_disconnect_repeatedly() {
+	local dev fio_status m
+
+	use_blk_mq y y || return $?
+	dev=$(get_bdev 0) || return $?
+	simulate_network_failure_loop "$dev" "$TIMEOUT" &
+	run_fio --verify=md5 -rw=randwrite --bs=4K --loops=10000 \
+		--ioengine=libaio --iodepth=64 --iodepth_batch=32 \
+		--group_reporting --sync=1 \ --direct=1 \ --filename="$dev" \
+		--name=data-integrity-test-06 --thread \ --numjobs=1 \
+		--runtime="${TIMEOUT}" --output="${TMPDIR}/fio-output-011.txt" \
+		>/dev/null
+	fio_status=$?
+	wait
+	[ -z "$nvme" ] && log_in
+	return $fio_status
+}
+
+test() {
+	setup && test_disconnect_repeatedly && teardown
+}
diff --git a/tests/srp/011.out b/tests/srp/011.out
new file mode 100644
index 000000000000..6f14079ec4c6
--- /dev/null
+++ b/tests/srp/011.out
@@ -0,0 +1,7 @@
+Unloaded the ib_srp kernel module
+Unloaded the ib_srpt kernel module
+Unloaded the rdma_rxe kernel module
+Configured SRP target driver
+Unloaded the ib_srp kernel module
+Unloaded the ib_srpt kernel module
+Unloaded the rdma_rxe kernel module
diff --git a/tests/srp/012 b/tests/srp/012
new file mode 100755
index 000000000000..392f660921c1
--- /dev/null
+++ b/tests/srp/012
@@ -0,0 +1,52 @@
+#!/bin/bash
+#
+# Copyright (c) 2018 Western Digital Corporation or its affiliates
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License
+# as published by the Free Software Foundation; either version 2
+# of the License, or (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write to the Free Software
+# Foundation, Inc.
+
+. tests/srp/functions
+
+DESCRIPTION="dm-mpath on top of multiple I/O schedulers"
+QUICK=1
+
+test_io_schedulers() {
+	local dev m
+
+	# Load all I/O scheduler kernel modules
+	for m in "/lib/modules/$(uname -r)/kernel/block/"*.ko; do
+		modprobe "$(basename "$m")" >&/dev/null
+	done
+	for mq in y n; do
+		use_blk_mq ${mq} ${mq} || return $?
+		dev=$(get_bdev 0) || return $?
+		for sched in noop deadline bfq cfq; do
+			set_scheduler "$(basename "$(readlink -f "${dev}")")" $sched \
+				      >>"$FULL" 2>&1 || continue
+			echo "I/O scheduler: $sched; use_blk_mq: $mq" >>"$FULL"
+			run_fio --verify=md5 -rw=randwrite --bs=4K --size=64K \
+				--ioengine=libaio --iodepth=64 \
+				--iodepth_batch=32 --group_reporting --sync=1 \
+				--direct=1 --filename="$dev" \
+				--name=${sched} --thread --numjobs=1 \
+				--output="${RESULTS_DIR}/012-${sched}-${mq}.txt" \
+				>/dev/null ||
+			    return $?
+		done
+	done
+}
+
+test() {
+	setup && test_io_schedulers && teardown
+}
diff --git a/tests/srp/012.out b/tests/srp/012.out
new file mode 100644
index 000000000000..e08ad3b777cf
--- /dev/null
+++ b/tests/srp/012.out
@@ -0,0 +1,8 @@
+Unloaded the ib_srp kernel module
+Unloaded the ib_srpt kernel module
+Unloaded the rdma_rxe kernel module
+Configured SRP target driver
+Unloaded the ib_srp kernel module
+Unloaded the ib_srp kernel module
+Unloaded the ib_srpt kernel module
+Unloaded the rdma_rxe kernel module
diff --git a/tests/srp/013 b/tests/srp/013
new file mode 100755
index 000000000000..f2ce57cde26b
--- /dev/null
+++ b/tests/srp/013
@@ -0,0 +1,48 @@
+#!/bin/bash
+#
+# Copyright (c) 2018 Western Digital Corporation or its affiliates
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License
+# as published by the Free Software Foundation; either version 2
+# of the License, or (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write to the Free Software
+# Foundation, Inc.
+
+. tests/srp/functions
+
+DESCRIPTION="Direct I/O using a discontiguous buffer"
+QUICK=1
+
+discontiguous_io() {
+	local byte bytes dev m
+
+	use_blk_mq y y || return $?
+	dev=$(get_bdev 0) || return $?
+	dd if="${dev}" bs=512 count=1 iflag=direct status=none |
+	    od -An -v -tu1 -w1 |
+	    while read -r byte; do
+		    # shellcheck disable=SC2059
+		    printf "\\x$(printf "%x" $((byte ^ 0xa5)))"
+	    done >"${TMPDIR}/data_block"
+	wc -c < "${TMPDIR}/data_block"
+	src/discontiguous-io -s -w "${dev}" <"${TMPDIR}/data_block" >>"$FULL" ||
+	    return $?
+	dd if="${dev}" bs=512 count=1 iflag=direct status=none |
+	    cmp - "${TMPDIR}/data_block" ||
+	    return $?
+	src/discontiguous-io -s "${dev}" 2>>"$FULL" |
+	    cmp - "${TMPDIR}/data_block" ||
+	    return $?
+}
+
+test() {
+	setup && discontiguous_io && teardown
+}
diff --git a/tests/srp/013.out b/tests/srp/013.out
new file mode 100644
index 000000000000..1058c5aee157
--- /dev/null
+++ b/tests/srp/013.out
@@ -0,0 +1,8 @@
+Unloaded the ib_srp kernel module
+Unloaded the ib_srpt kernel module
+Unloaded the rdma_rxe kernel module
+Configured SRP target driver
+Unloaded the ib_srp kernel module
+512
+Unloaded the ib_srpt kernel module
+Unloaded the rdma_rxe kernel module
diff --git a/tests/srp/functions b/tests/srp/functions
new file mode 100755
index 000000000000..8fe654711613
--- /dev/null
+++ b/tests/srp/functions
@@ -0,0 +1,1288 @@
+#!/bin/bash
+#
+# Copyright (c) 2016-2018 Western Digital Corporation or its affiliates
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License
+# as published by the Free Software Foundation; either version 2
+# of the License, or (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write to the Free Software
+# Foundation, Inc.
+
+have_brd() {
+	modinfo brd >/dev/null 2>&1
+}
+
+scsi_debug_dev_path() {
+	local bd d
+
+	for d in /sys/bus/pseudo/drivers/scsi_debug/adapter*/host*/target*/*/block/*; do
+		[ -e "$d" ] || continue
+		bd=${d/*\//}
+	done
+	[ -n "$bd" ] || return 1
+	echo "/dev/$bd"
+}
+
+vdev_path=(/dev/ram0 /dev/ram1 "$(scsi_debug_dev_path)")
+scsi_serial=(ramdisk1 ramdisk2 scsidbg)
+memtotal=$(sed -n 's/^MemTotal:[[:blank:]]*\([0-9]*\)[[:blank:]]*kB$/\1/p' /proc/meminfo)
+max_ramdisk_size=$((1<<25))
+if have_brd; then
+    ramdisk_size=$((memtotal*(1024/16)))  # in bytes
+    if [ $ramdisk_size -gt $max_ramdisk_size ]; then
+	ramdisk_size=$max_ramdisk_size
+    fi
+elif [ -e /sys/class/block/ram0 ]; then
+    # in bytes
+    ramdisk_size=$(($(</sys/class/block/ram0/size) * 512))
+else
+	echo "Error: could not find /dev/ram0"
+	exit 1
+fi
+
+debug=
+elevator=none
+filesystem_type=ext4
+fio_aux_path=/tmp/fio-state-files
+nvme=
+nvme_subsysnqn="nvme-test"
+nvme_port=7777
+roce=1
+TIMEOUT=${TIMEOUT:-600}
+scsi_timeout=1
+srp_login_params=
+srp_rdma_cm_port=5555
+
+# Log out, set dm and SCSI use_blk_mq parameters and log in. $1: device mapper
+# use_blk_mq mode; $2: SCSI use_blk_mq mode; $3..${$#}: SRP kernel module
+# parameters.
+use_blk_mq() {
+	local dm_mode=$1 scsi_mode=$2 kmod_params
+
+	shift
+	shift
+	kmod_params=("$@")
+
+	(
+		cd /sys/module/dm_mod/parameters || return $?
+		if [ -e use_blk_mq ]; then
+		    echo "$dm_mode" >use_blk_mq || return $?
+		fi
+	)
+	(
+		cd /sys/module/scsi_mod/parameters || return $?
+		echo "$scsi_mode" >use_blk_mq || return $?
+	)
+
+	log_out &&
+	    remove_mpath_devs &&
+	    stop_client &&
+	    start_client indirect_sg_entries=2048 "${kmod_params[@]}" &&
+	    log_in
+}
+
+get_ipv4_addr() {
+	ip -4 -o addr show dev "$1" |
+	    sed -n 's/.*[[:blank:]]inet[[:blank:]]*\([^[:blank:]/]*\).*/\1/p'
+}
+
+expand_ipv6_addr() {
+	awk -F : 'BEGIN{left=1} { for(i=1;i<=NF;i++) { a=substr("0000", 1+length($i)) $i; if ($i == "") left=0; else if (left) pre = pre ":" a; else suf = suf ":" a }; mid=substr(":0000:0000:0000:0000:0000:0000:0000:0000", 1+length(pre)+length(suf)); print substr(pre,2) mid suf}'
+}
+
+get_ipv6_addr() {
+	ip -6 -o addr show dev "$1" |
+	    sed -n 's/.*[[:blank:]]inet6[[:blank:]]*\([^[:blank:]/]*\).*/\1/p'
+}
+
+srp_single_login() {
+	local login=$1 p=$2 status
+
+	if ! status=$(LC_ALL=C; { echo "$login" >"$p"; } 2>&1); then
+		status="${status/*: }"
+		case "$status" in
+			"File exists" | "Invalid argument")
+				;;
+			*)
+				echo "$login >$p failed: $status"
+				return 1
+				;;
+		esac
+	fi
+	return 0
+}
+
+# Arguments: $1: SRP target IOC GUID; $2: IB device to log in to; $3: IB device
+# port to log in to; $4: additional login parameters.
+do_ib_cm_login() {
+	local add_param gid ibdev ioc_guid p port
+
+	ioc_guid=$1
+	ibdev=$2
+	port=$3
+	add_param=$4
+	gid=$(<"/sys/class/infiniband/$ibdev/ports/$port/gids/0")
+	gid=${gid//:}
+	for p in /sys/class/infiniband_srp/*; do
+		[ -e "$p" ] || continue
+		srp_single_login "id_ext=$ioc_guid,ioc_guid=$ioc_guid,dgid=$gid,pkey=7fff,service_id=$ioc_guid,$add_param" "$p/add_target" || return $?
+	done
+}
+
+# Arguments: $1: SRP target IOC GUID; $2: IB device to log in to; $3: additional
+# login parameters.
+do_rdma_cm_login() {
+	local a b add_param d dest dests ibdev ioc_guid pd
+
+	ioc_guid=$1
+	ibdev=$2
+	add_param=$3
+	pd=/sys/class/infiniband/$ibdev/parent
+	if [ -e "$pd" ]; then
+	    d=$(<"$pd")
+	    a=$(get_ipv4_addr "$(basename "$d")")
+	    b=$(get_ipv6_addr "$(basename "$d")")
+	fi
+	[ -n "$a$b" ] || return 1
+	dests=()
+	[ -n "$a" ] && dests+=("${a}:${srp_rdma_cm_port}")
+	[ -n "$b" ] && dests+=("[${b}]:${srp_rdma_cm_port}")
+	for dest in "${dests[@]}"; do
+		for p in /sys/class/infiniband_srp/*; do
+			[ -e "$p" ] || continue
+			srp_single_login "id_ext=$ioc_guid,ioc_guid=$ioc_guid,dest=$dest,$add_param" "$p/add_target" || return $?
+		done
+	done
+}
+
+# Make the SRP initiator driver log in to each SRP target port.
+srp_log_in() {
+	local a add_param=$1 d dest gid ibdev ioc_guid login port p sysfsdir
+
+	ioc_guid=$(</sys/module/ib_srpt/parameters/srpt_service_guid)
+
+	for ((i=0;i<10;i++)); do
+		for d in /sys/class/infiniband_mad/umad*; do
+			[ -e "$d" ] || continue
+			sysfsdir=/sys/class/infiniband_mad/$(basename "$d")
+			ibdev=$(<"$sysfsdir/ibdev")
+			port=$(<"$sysfsdir/port")
+			link_layer=$(<"/sys/class/infiniband/$ibdev/ports/$port/link_layer")
+			case $link_layer in
+				InfiniBand)
+					do_ib_cm_login   "$ioc_guid" "$ibdev" "$port" "$add_param" &&
+					    do_rdma_cm_login "$ioc_guid" "$ibdev" "$add_param";;
+				*)
+					do_rdma_cm_login "$ioc_guid" "$ibdev" "$add_param";;
+			esac || break
+		done
+
+		for p in /sys/class/scsi_host/*/orig_dgid; do
+			[ -e "$p" ] && return 0
+		done
+		sleep .1
+	done
+
+	echo "SRP login failed"
+
+	return 1
+}
+
+# Tell the SRP initiator driver to log out.
+srp_log_out() {
+	local p
+
+	if [ -e /sys/class/srp_remote_ports ]; then
+	    for p in /sys/class/srp_remote_ports/*; do
+		    [ -e "$p" ] && echo 1 >"$p/delete" &
+	    done
+	fi
+	wait
+}
+
+is_number() {
+	[ "$1" -eq "0$1" ] 2>/dev/null
+}
+
+# Check whether a device is an RDMA device. An example argument:
+# /sys/devices/pci0000:00/0000:00:03.0/0000:04:00.0
+is_rdma_device() {
+	local d i inode1 inode2
+
+	inode1=$(stat -c %i "$1")
+	# echo "inode1 = $inode1"
+	for i in /sys/class/infiniband/*; do
+		d=/sys/class/infiniband/"$(readlink "$i")"
+		d=$(dirname "$(dirname "$d")")
+		inode2=$(stat -c %i "$d")
+		# echo "inode2 = $inode2"
+		if [ "$inode1" = "$inode2" ]; then
+		    return
+		fi
+	done
+	false
+}
+
+# Lists RDMA network interface names, e.g. ib0 ib1
+rdma_network_interfaces() {
+	(
+		cd /sys/class/net &&
+		    for i in *; do
+			    [ -e "$i" ] || continue
+			    [ -L "$i/device" ] || continue
+			    d=$(readlink "$i/device" 2>/dev/null)
+			    if [ -n "$d" ] && is_rdma_device "$i/$d"; then
+				echo "$i"
+			    fi
+		    done
+	)
+}
+
+nvme_log_in() {
+	local i ipv4_addr
+
+	[ -c /dev/nvme-fabrics ] &&
+	    for i in $(rdma_network_interfaces); do
+		    ipv4_addr=$(get_ipv4_addr "$i")
+		    if [ -n "${ipv4_addr}" ]; then
+			echo -n "transport=rdma,traddr=${ipv4_addr},trsvcid=${nvme_port},nqn=$nvme_subsysnqn" > /dev/nvme-fabrics
+		    fi
+	    done &&
+	    echo reconfigure | multipathd -k >&/dev/null
+}
+
+nvme_log_out() {
+	local c
+
+	for c in /sys/class/nvme-fabrics/ctl/*/delete_controller; do
+		[ -e "$c" ] && echo 1 > "$c" &
+	done
+	wait
+}
+
+# Log in.
+log_in() {
+	if [ -n "$nvme" ]; then
+		nvme_log_in
+	else
+		srp_log_in "${srp_login_params}"
+	fi
+}
+
+log_out() {
+	if [ -n "$nvme" ]; then
+		nvme_log_out
+	else
+		srp_log_out
+	fi
+}
+
+held_by() {
+	local d e dev=$1
+
+	while [ -L "$dev" ]; do
+		dev=$(realpath "$dev")
+	done
+	dev=${dev%/dev/}
+	for d in /sys/class/block/*/holders/*; do
+		[ -e "$d" ] || continue
+		e=$(basename "$d")
+		if [ "$e" = "$dev" ]; then
+		    echo "/dev/$(basename "$(dirname "$(dirname "$d")")")"
+		fi
+	done
+}
+
+# System uptime in seconds.
+uptime_s() {
+	local a b
+
+	echo "$(</proc/uptime)" | { read -r a b && echo "${a%%.*}"; }
+}
+
+# Sleep until either $1 seconds have elapsed or until the deadline $2 has been
+# reached. Return 1 if and only if the deadline has been met.
+sleep_until() {
+	local duration=$1 deadline=$2 u
+
+	u=$(uptime_s)
+	if [ $((u + duration)) -le "$deadline" ]; then
+		sleep "$duration"
+	else
+		[ "$deadline" -gt "$u" ] && sleep $((deadline - u))
+		return 1
+	fi
+}
+
+# Simulate network failures for device $1 during $2 seconds.
+simulate_network_failure_loop() {
+	local d dev="$1" duration="$2" deadline i rc=0 s
+
+	[ -e "$dev" ] || return $?
+	[ -n "$duration" ] || return $?
+	deadline=$(($(uptime_s) + duration))
+	s=5
+	while [ $rc = 0 ]; do
+		sleep_until 5 ${deadline} || break
+		if [ -n "$nvme" ]; then
+			for d in $(held_by "$dev"); do
+				echo 1 >"$d/device/reset_controller"
+			done
+		else
+			log_out
+			sleep_until $s ${deadline}
+			rc=$?
+			s=$(((((s + 5) & 0xff) ^ 0xa6) * scsi_timeout / 60))
+			log_in
+		fi
+	done
+
+	for ((i=0;i<5;i++)); do
+		log_in && break
+		sleep 1
+	done
+}
+
+stop_bdev_users() {
+	[ -n "$1" ] || return $?
+	lsof -F p "$1" 2>/dev/null | while read -r line; do
+		p="${line#p}"
+		if [ "$p" != "$line" ]; then
+		    echo -n " (pid $p)"
+		    kill -9 "$p"
+		fi
+	done
+}
+
+# RHEL 6 dmsetup accepts mpath<n> but not /dev/dm-<n> as its first argument.
+# Hence this function that converts /dev/dm-<n> into mpath<n>.
+dev_to_mpath() {
+	local d e mm
+
+	d="${1#/dev/mapper/}";
+	if [ "$d" != "$1" ]; then
+		echo "$d"
+		return 0
+	fi
+
+	[ -e "$1" ] || return $?
+
+	if [ -h "$1" ]; then
+		e=$(readlink -f "$1")
+	else
+		e="$1"
+	fi
+	if ! mm=$(stat -c %t:%T "$e"); then
+		echo "stat $1 -> $e failed"
+		return 1
+	fi
+
+	for d in /dev/mapper/mpath*; do
+		if [ -h "$d" ]; then
+			e=$(readlink -f "$d")
+		elif [ -e "$d" ]; then
+			e="$d"
+		else
+			continue
+		fi
+		if [ "$(stat -c %t:%T "$e")" = "$mm" ]; then
+			basename "$d"
+			return 0
+		fi
+	done
+	return 1
+}
+
+remove_mpath_dev() {
+	local cmd dm i output t1 t2
+
+	for ((i=10;i>0;i--)); do
+		cmd="dm=\$(dev_to_mpath \"$1\")"
+		if ! eval "$cmd"; then
+			echo "$cmd: failed"
+		else
+			t1=$(dmsetup table "$dm")
+			cmd="dmsetup message $dm 0 fail_if_no_path"
+			if ! eval "$cmd"; then
+				echo "$cmd: failed"
+			else
+				t2=$(dmsetup table "$dm")
+				if echo "$t2" | grep -qw queue_if_no_path; then
+					echo "$dm: $t1 -> $t2"
+				fi
+				unmount_and_check "/dev/mapper/$dm"
+				cmd="dmsetup remove $dm"
+				if ! output=$(eval "$cmd" 2>&1); then
+					echo "$cmd: $output; retrying"
+				else
+					echo "done"
+					break
+				fi
+			fi
+		fi
+		if [ ! -e "$1" ]; then
+			break
+		fi
+		ls -l "$1"
+		stop_bdev_users "$(readlink -f "$1")"
+		sleep .5
+	done
+	if [ $i = 0 ]; then
+		echo "failed"
+		return 1
+	fi
+}
+
+# Check whether one or more arguments are stale device nodes (/dev/...).
+mpath_has_stale_dev() {
+	local d
+
+	for d in "$@"; do
+		if [ "${d/://}" != "$d" ]; then
+			grep -qw "$d" /sys/class/block/*/dev 2>/dev/null ||
+			    return 0
+		fi
+	done
+
+	return 1
+}
+
+is_qinp_def() {
+	case "$1" in
+		"3 queue_if_no_path queue_mode mq ")
+			return 0;;
+		"1 queue_if_no_path ")
+			return 0;;
+		*)
+			return 1;;
+	esac
+}
+
+remove_srp_mpath_devs() {
+	(
+		cd /sys/class/scsi_host &&
+		    for p in /sys/class/srp_remote_ports/*; do
+			    [ -e "$p" ] || continue
+			    h="${p##*/}"; h="${h#port-}"; h="${h%:1}"
+			    for d in "/sys/class/scsi_device/${h}:"*/device/block/*; do
+				    [ -e "$d" ] || continue
+				    s=$(dirname "$(dirname "$(dirname "$d")")")
+				    b=$(basename "$d")
+				    for h in "/sys/class/block/$b/holders/"*; do
+					    [ -e "$h" ] || continue
+					    dm=/dev/$(basename "$h")
+					    echo -n "SRP LUN $s / $b: removing $dm: "
+					    remove_mpath_dev "$dm" || [ -z "$debug" ] || return 1
+				    done
+			    done
+		    done
+	)
+	# Find all multipaths with one or more deleted devices and remove these
+	dmsetup table | while read -r mpdev fs ls type def; do
+		echo "$fs $ls" >/dev/null
+		# shellcheck disable=SC2086
+		if [ "$type" = multipath ] &&
+		       { is_qinp_def "$def" || mpath_has_stale_dev $def; }; then
+		    echo "${mpdev%:}"
+		fi
+	done |
+	    sort -u |
+	    while read -r mpdev; do
+		    mpdev="/dev/mapper/$mpdev"
+		    echo -n "removing $mpdev: "
+		    remove_mpath_dev "$mpdev" || [ -z "$debug" ] || return 1
+	    done
+}
+
+remove_nvme_mpath_devs() {
+	local dm h
+
+	for h in /sys/class/block/nvme*/holders/*; do
+		[ -e "$h" ] || continue
+		d=$(basename "$(dirname "$(dirname "$h")")")
+		dm=/dev/$(basename "$h")
+		echo -n "NVME dev $d: removing $dm: "
+		dmsetup remove "$(dev_to_mpath "$dm")" && echo "done"
+	done
+}
+
+remove_mpath_devs() {
+	if [ -n "$nvme" ]; then
+		remove_nvme_mpath_devs
+	else
+		remove_srp_mpath_devs
+	fi >>"$FULL" 2>&1
+}
+
+# Arguments: module to unload ($1) and retry count ($2).
+unload_module() {
+	local i m=$1 rc=${2:-1}
+
+	[ ! -e "/sys/module/$m" ] && return 0
+	for ((i=rc;i>0;i--)); do
+		modprobe -r "$m"
+		[ ! -e "/sys/module/$m" ] && return 0
+		sleep .1
+	done
+	return 1
+}
+
+# Load the SRP initiator driver with kernel module parameters $1..$n.
+start_srp() {
+	modprobe scsi_transport_srp || return $?
+	modprobe ib_srp "$@" dyndbg=+pmf || return $?
+}
+
+# Unload the SRP initiator driver.
+stop_srp() {
+	local i
+
+	srp_log_out
+	for ((i=40;i>=0;i--)); do
+		remove_mpath_devs || return $?
+		unload_module ib_srp >/dev/null 2>&1 && break
+		sleep 1
+	done
+	if [ -e /sys/module/ib_srp ]; then
+		echo "Error: unloading kernel module ib_srp failed"
+		return 1
+	fi
+	unload_module scsi_transport_srp || return $?
+	echo "Unloaded the ib_srp kernel module"
+}
+
+start_nvme_client() {
+	modprobe nvme dyndbg=+pmf &&
+	    modprobe nvme-core dyndbg=+pmf &&
+	    modprobe nvme-fabrics dyndbg=+pmf &&
+	    modprobe nvme-rdma dyndbg=+pmf
+}
+
+stop_nvme_client() {
+	unload_module nvme_rdma &&
+	    unload_module nvme
+}
+
+# Load the initiator kernel driver with kernel module parameters $1..$n.
+start_client() {
+	if [ -n "$nvme" ]; then
+		start_nvme_client "$@"
+	else
+		start_srp "$@"
+	fi
+}
+
+stop_client() {
+	if [ -n "$nvme" ]; then
+		stop_nvme_client
+	else
+		stop_srp
+	fi
+}
+
+# Load the configfs kernel module and mount it.
+mount_configfs() {
+	if [ ! -e /sys/module/configfs ]; then
+		modprobe configfs || return $?
+	fi
+	if ! mount | grep -qw configfs; then
+		mount -t configfs none /sys/kernel/config || return $?
+	fi
+}
+
+# Associate the LIO device with name $1/$2 with file $3 and SCSI serial $4.
+configure_lio_vdev() {
+	local dirname=$1 vdev=$2 path=$3 serial=$4
+
+	(
+		cd /sys/kernel/config/target/core &&
+		    mkdir "$dirname" &&
+		    cd "$dirname" &&
+		    mkdir "$vdev" &&
+		    cd "$vdev" &&
+		    if [ -b "$(readlink -f "$path")" ]; then
+			echo "udev_path=$path," >control
+		    elif [ -e "$path" ]; then
+			size=$(stat -c %s "${path}") &&
+			    [ "$size" -gt 0 ] &&
+			    echo "fd_dev_name=$path,fd_dev_size=$size," >control
+		    else
+			    {
+				    ls -l "$path"
+				    readlink -f "$path"
+			    } >>"$FULL" 2>&1
+			    false
+		    fi &&
+		    echo "${serial}" >wwn/vpd_unit_serial &&
+		    echo 1 > enable
+	)
+}
+
+lio_scsi_mpath_id() {
+	local i=$1 hs
+
+	is_number "$i" || return $?
+	hs=$(echo -n "${scsi_serial[i]}" | od -v -tx1 -w99 |
+		 { read -r offset bytes;
+		   echo "${bytes// }";
+		   echo "$offset" > /dev/null
+		 })
+	while [ ${#hs} -lt 25 ]; do
+		hs="${hs}0"
+	done
+	# See also spc_emulate_evpd_83() in drivers/target/target_core_spc.c.
+	echo "36001405$hs"
+}
+
+scsi_mpath_id() {
+	lio_scsi_mpath_id "$@"
+}
+
+get_nvme_bdev() {
+	local i=$1 j=0
+
+	for d in /sys/class/nvme-fabrics/ctl/*/*/device; do
+		[ -d "$d" ] || continue
+		if [ $j -ge "$i" ]; then
+			echo "/dev/$(basename "$(dirname "$d")")"
+			return 0
+		fi
+		((j++))
+	done
+	return 1
+}
+
+# Get a the uuid or wwid of block device number $1 with $1 >= 0. See also
+# the bin/getuid_callout script.
+get_bdev_uid() {
+	local i=$1
+
+	is_number "$i" || return $?
+	if [ -n "$nvme" ]; then
+		bdev=$(get_nvme_bdev "$i") || return $?
+		wwid=$(<"/sys/block/${bdev#/dev/}/wwid")
+		wwid=${wwid#nvme.0000-}
+		echo "${wwid%-4c696e75780000000000000000000000000000000000000000000000000000000000000000000000-00000001}"
+	else
+		scsi_mpath_id "$i"
+	fi
+}
+
+# Set scheduler of $1 to $2
+set_scheduler() {
+	local b=$1 p s=$2
+
+	p=/sys/class/block/$b/queue/scheduler
+	if [ -e "/sys/block/$b/mq" ]; then
+		case "$s" in
+			noop)        s=none;;
+			deadline)    s=mq-deadline;;
+			bfq)         s=bfq;;
+		esac
+	else
+		case "$s" in
+			none)        s=noop;;
+			mq-deadline) s=deadline;;
+			bfq-mq)      s=bfq;;
+		esac
+	fi
+	if ! echo "$s" > "$p"; then
+		echo "Changing scheduler of $b from $(<"$p") into $s failed" >&2
+		return 1
+	fi
+}
+
+# Get a /dev/... path that points at dm device number $1 with $1 >= 0.
+get_bdev() {
+	local b d dev h i=$1 j realdev
+
+	is_number "$i" || return $?
+	echo reconfigure | multipathd -k >&/dev/null
+	dev="/dev/disk/by-id/dm-uuid-mpath-$(get_bdev_uid "$i")" || return $?
+	for ((j=0;j<50;j++)); do
+		[ -e "$dev" ] && break
+		sleep .1
+	done
+	if [ ! -e "$dev" ]; then
+		echo "$dev: not found" >&2
+		return 1
+	fi
+	if [ ! -L "$dev" ]; then
+		echo "$dev: not a soft link" >&2
+		return 1
+	fi
+	realdev=$(readlink "$dev" 2>/dev/null || echo "?")
+	echo "Using $dev -> ${realdev}" >>"$FULL"
+	for ((j=0; j<50; j++)); do
+		blockdev --getbsz "$dev" >&/dev/null && break
+		echo reconfigure | multipathd -k >& /dev/null
+		sleep .1
+	done
+	if ! blockdev --getbsz "$dev" >&/dev/null; then
+		return 1
+	fi
+	b=$(basename "$realdev")
+	set_scheduler "$b" "${elevator}"
+	for d in /sys/class/block/*"/holders/$b"; do
+		[ -e "$d" ] || continue
+		h="$(basename "$(dirname "$(dirname "$d")")")"
+		set_scheduler "$h" "${elevator}"
+		if [ -e "/sys/class/block/$h/device/timeout" ]; then
+			echo $scsi_timeout > "/sys/class/block/$h/device/timeout"
+		fi
+	done
+	echo "$dev"
+}
+
+# Configure zero or more target ports such that these accept connections from
+# zero or more initiator ports. Target and initiator port lists are separated
+# by "--".
+configure_target_ports() {
+	local i ini initiators target_port target_ports
+
+	target_ports=()
+	while [ $# -gt 0 ]; do
+		if [ "$1" = "--" ]; then
+			shift
+			break
+		fi
+		target_ports+=("$1")
+		shift
+	done
+
+	initiators=()
+	while [ $# -gt 0 ]; do
+		initiators+=("$1")
+		shift
+	done
+
+	for target_port in "${target_ports[@]}"; do
+		mkdir "$target_port" || return $?
+		[ -e "$target_port" ] || continue
+		#echo "$target_port"
+		mkdir "$target_port/$target_port" || continue
+		i=0
+		for v in "${vdev[@]}"; do
+			mkdir "$target_port/$target_port/lun/lun_$i" || return $?
+			(
+				cd "$target_port/$target_port/lun/lun_$i" &&
+				    ln -s "../../../../../core/$v" .
+			) || return $?
+			i=$((i+1))
+		done
+		for ini in "${initiators[@]}"; do
+			(
+				cd "$target_port/$target_port/acls" &&
+				    mkdir "${ini}" &&
+				    cd "${ini}" &&
+				    for ((i = 0; i < ${#vdev[@]}; i++)) do
+					(
+						mkdir lun_$i &&
+						    cd lun_$i &&
+						    ln -s ../../../lun/lun_$i .
+					) || return $?
+				    done
+			) || return $?
+		done
+		echo 1 >"$target_port/$target_port/enable"
+	done
+}
+
+function mountpoint() {
+	if [ -z "$TMPDIR" ]; then
+		echo "Error: \$TMPDIR has not been set." 1>&2
+		exit 1
+	fi
+	if [ -z "$1" ]; then
+		echo "Error: missing argument" 1>&2
+		exit 1
+	fi
+	echo "$TMPDIR/mnt$1"
+}
+
+all_primary_gids() {
+	find /sys/devices -name infiniband | while read -r p; do
+		cat "$p"/*/ports/*/gids/0
+	done | grep -v ':0000:0000:0000:0000$'
+}
+
+# Load LIO and configure the SRP target driver and LUNs
+start_lio_srpt() {
+	local b d gid guid i ini_gids ini_guids opts p target_gids target_guids vdev
+
+	target_guids=($(all_primary_gids | sed 's/^fe80:0000:0000:0000://'))
+	target_gids=($(all_primary_gids | sed 's/^/0x/;s/://g'))
+	for p in /sys/class/infiniband/*/ports/*; do
+		[ -e "$p" ] || continue
+		link_layer=$(<"$p/link_layer")
+		case "$link_layer" in
+			InfiniBand)
+				guid=$(<"$p/gids/0")
+				gid=$(echo "${guid}" | sed 's/^fe8/0x000/;s/://g')
+				guid=${guid#fe80:0000:0000:0000:}
+				[ "$guid" = "0000:0000:0000:0000" ] && continue
+				ini_guids+=("$guid")
+				ini_gids+=("$gid")
+				;;
+			*)
+				d=$(<"$(dirname "$(dirname "$p")")/parent")
+				for b in $(get_ipv4_addr "$d") \
+					     $(get_ipv6_addr "$d"|expand_ipv6_addr); do
+					ini_guids+=("$b")
+					ini_gids+=("$b")
+				done
+				;;
+		esac
+	done
+	mount_configfs || return $?
+	modprobe target_core_mod || return $?
+	modprobe target_core_iblock || return $?
+	opts=("srp_max_req_size=4200" "dyndbg=+pmf")
+	if modinfo ib_srpt | grep -q '^parm:[[:blank:]]*rdma_cm_port:'; then
+		opts+=("rdma_cm_port=${srp_rdma_cm_port}")
+	fi
+	insmod "/lib/modules/$(uname -r)/kernel/drivers/infiniband/ulp/srpt/ib_srpt.ko" "${opts[@]}" || return $?
+	i=0
+	for r in "${vdev_path[@]}"; do
+		if [ -b "$(readlink -f "$r")" ]; then
+			oflag=oflag=direct
+		else
+			oflag=
+		fi
+		echo -n "Zero-initializing $r ... " >>"$FULL"
+		dd if=/dev/zero of="${r}" bs=1M count=$((ramdisk_size>>20)) ${oflag} >/dev/null 2>&1 || return $?
+		echo "done" >>"$FULL"
+		mkdir -p "$(mountpoint $i)" || return $?
+		((i++))
+	done
+	vdev=(iblock_0/vdev0 iblock_1/vdev1 iblock_2/vdev2)
+	for ((i=0; i < ${#vdev[@]}; i++)); do
+		d="$(dirname "${vdev[i]}")"
+		b="$(basename "${vdev[i]}")"
+		hs=$(lio_scsi_mpath_id "$i")
+		hs=${hs#36001405}
+		configure_lio_vdev "$d" "$b" "${vdev_path[i]}" "$hs" ||
+		    return $?
+	done
+	(
+		cd /sys/kernel/config/target || return $?
+		mkdir srpt || return $?
+		cd srpt || return $?
+		if [ -e discovery_auth/rdma_cm_port ]; then
+			echo "${srp_rdma_cm_port}" > discovery_auth/rdma_cm_port ||
+			    return $?
+		fi
+		configure_target_ports "${target_guids[@]}" -- "${ini_guids[@]}" || {
+			echo "Retrying with old port name format"
+			configure_target_ports "${target_gids[@]}" -- "${ini_gids[@]}"
+		}
+	)
+}
+
+# Check whether or not an rdma_rxe instance has been associated with network
+# interface $1.
+has_rdma_rxe() {
+	local f
+
+	for f in /sys/class/infiniband/*/parent; do
+		if [ -e "$f" ] && [ "$(<"$f")" = "$1" ]; then
+			return 0
+		fi
+	done
+
+	return 1
+}
+
+# Load the rdma_rxe kernel module and associate it with all network interfaces
+# except "lo".
+start_rdma_rxe() {
+	if [ -n "$roce" ]; then
+		modprobe rdma_rxe || return $?
+		(
+			cd /sys/class/net &&
+			    for i in *; do
+				    if [ -e "$i" ] && [ "$i" != "lo" ] &&
+					   ! has_rdma_rxe "$i"; then
+					echo "$i" > /sys/module/rdma_rxe/parameters/add
+				    fi
+			    done
+		)
+		{
+			echo -n "SoftRoCE network interfaces:"
+			(
+				cd /sys/class/infiniband &&
+				    for i in rxe*; do
+					    [ -e "$i" ] && echo -n " $i"
+				    done
+			)
+			echo
+		} >>"$FULL"
+	fi
+}
+
+# Dissociate the rdma_rxe kernel module from all network interfaces and unload
+# the rdma_rxe kernel module.
+stop_rdma_rxe() {
+	(
+		cd /sys/class/net &&
+		    for i in *; do
+			    if [ -e "$i" ] && has_rdma_rxe "$i"; then
+				{ echo "$i" > /sys/module/rdma_rxe/parameters/remove; } \
+				    2>/dev/null
+			    fi
+		    done
+	)
+	if ! unload_module rdma_rxe; then
+		echo "Unloading rdma_rxe failed"
+		return 1
+	fi
+}
+
+# Unload the LIO SRP target driver.
+stop_lio_srpt() {
+	local e hca m
+
+	mount_configfs
+	for e in /sys/kernel/config/target/srpt/$hca/$hca/enable; do
+		if [ -e "$e" ]; then
+			echo 0 >"$e"
+		fi
+	done
+
+	if [ -e /sys/kernel/config/target/srpt ]; then
+	    (
+		    cd /sys/kernel/config/target/srpt && (
+			    for d in */*/acls/*/*/lun*; do [ -L "$d" ] && rm "$d"; done
+			    for d in */*/acls/*/lun*; do [ -d "$d" ] && rmdir "$d"; done
+			    for d in */*/acls/*; do [ -d "$d" ] && rmdir "$d"; done
+			    for d in */*/lun/lun*/*; do [ -L "$d" ] && rm "$d"; done
+			    for d in */*/lun/lun*; do [ -d "$d" ] && rmdir "$d"; done
+			    for d in */*; do [ -e "$d/lun" ] && rmdir "$d"; done
+			    for d in *; do [ -e "$d/fabric_statistics" ] && rmdir "$d"; done
+			    true
+		    ) &&
+			cd .. &&
+			for ((i=0;i<10;i++)); do
+				rmdir srpt
+				[ -e srpt ] || break
+				sleep .1
+			done &&
+			[ ! -e srpt ] &&
+			unload_module ib_srpt 10
+	    ) || return $?
+	fi
+
+	rmdir /sys/kernel/config/target/core/*/* >&/dev/null
+	rmdir /sys/kernel/config/target/core/* >&/dev/null
+
+	for m in ib_srpt target_core_pscsi target_core_iblock target_core_file \
+			 target_core_stgt target_core_user target_core_mod
+	do
+		unload_module $m 10 || return $?
+	done
+}
+
+# Load and configure the SRP target driver
+start_srpt() {
+	local bd i
+
+	have_brd &&
+	    modprobe brd rd_nr=${#vdev_path[@]} rd_size=$((ramdisk_size>>10))
+	modprobe scsi_debug delay=0 dif=3 dix=1 dev_size_mb=$((ramdisk_size>>20))
+	for ((i=0;i<10;i++)); do
+		bd=$(scsi_debug_dev_path) && break
+		sleep .1
+	done
+	if [ -z "$bd" ]; then
+		echo "scsi_debug device instance not found"
+		return 1
+	fi
+	vdev_path[2]=$bd
+	modprobe ib_uverbs
+	modprobe ib_umad
+	modprobe rdma_cm
+	start_lio_srpt || return $?
+	echo "Configured SRP target driver"
+}
+
+# Unload the SRP target driver.
+stop_srpt() {
+	stop_lio_srpt || return $?
+	unload_module scsi_debug
+	if have_brd; then
+		unload_module brd || return $?
+		rm -f "${vdev_path[@]}"
+	fi
+	echo "Unloaded the ib_srpt kernel module"
+}
+
+configure_nvmet_port() {
+	local p=$1 ipv4_addr=$2 i
+
+	echo "Configuring $p with address $ipv4_addr as an NVMeOF target port"
+	(
+		cd /sys/kernel/config/nvmet/ports &&
+		    for ((i=1;;i++)); do [ -e "$i" ] || break; done &&
+			     mkdir "$i" &&
+			     cd "$i" &&
+			     echo ipv4            > addr_adrfam &&
+			     echo rdma            > addr_trtype &&
+			     echo -n "$ipv4_addr" > addr_traddr &&
+			     echo -n ${nvme_port} > addr_trsvcid
+	)
+}
+
+start_nvme_target() {
+	local d i ipv4_addr num_ports=0 nvme_dev=1
+
+	if have_brd; then
+		modprobe brd rd_nr=${#vdev_path[@]} rd_size=$((ramdisk_size>>10))
+	fi &&
+	    modprobe nvme dyndbg=+pmf &&
+	    modprobe nvmet-rdma dyndbg=+pmf &&
+	    sleep .1 &&
+	    (
+		    cd /sys/kernel/config/nvmet/subsystems &&
+			mkdir ${nvme_subsysnqn} &&
+			cd ${nvme_subsysnqn} &&
+			cd namespaces &&
+			mkdir "${nvme_dev}" &&
+			cd "${nvme_dev}" &&
+			echo 00000000-0000-0000-0000-000000000000 >device_nguid &&
+			echo -n /dev/ram0 >device_path &&
+			echo 1 >enable &&
+			cd ../.. &&
+			echo 1 >attr_allow_any_host
+	    ) && for i in $(rdma_network_interfaces); do
+		    ipv4_addr=$(get_ipv4_addr "$i")
+		    if [ -n "${ipv4_addr}" ]; then
+			configure_nvmet_port "$i" "${ipv4_addr}"
+			((num_ports++))
+			true
+		    fi
+	    done &&
+	    if [ $num_ports = 0 ]; then
+		echo "No NVMeOF target ports"
+		false
+	    fi && (
+		    cd /sys/kernel/config/nvmet/ports &&
+			for i in *; do
+				[ -e "$i" ] && (
+					cd "$i/subsystems" &&
+					    ln -s "../../../subsystems/${nvme_subsysnqn}" .
+				)
+			done
+	    )
+}
+
+stop_nvme_target() {
+	local d
+
+	(
+		cd /sys/kernel/config/nvmet 2>/dev/null &&
+		    rm -f -- ports/*/subsystems/* &&
+		    for d in {*/*/*/*,*/*}; do
+			    [ -e "$d" ] && rmdir "$d"
+		    done
+	)
+	unload_module nvmet_rdma &&
+	    unload_module nvmet &&
+	    have_brd && unload_module brd
+}
+
+start_target() {
+	start_rdma_rxe
+	if [ -n "$nvme" ]; then
+		start_nvme_target
+	else
+		start_srpt
+	fi
+}
+
+stop_target() {
+	if [ -n "$nvme" ]; then
+		stop_nvme_target
+	else
+		stop_srpt
+	fi
+	stop_rdma_rxe || return $?
+	echo "Unloaded the rdma_rxe kernel module"
+}
+
+# Look up the block device below the filesystem on which directory $1 exists.
+block_dev_of_dir() {
+	df "$1" | {
+		read -r header
+		echo "$header" >/dev/null
+		read -r blockdev rest
+		echo "$blockdev"
+	}
+}
+
+create_filesystem() {
+	local dev=$1
+
+	case "$filesystem_type" in
+		ext4)
+			mkfs.ext4 -F -O ^has_journal -q "$dev";;
+		xfs)
+			mkfs.xfs -f -q "$dev";;
+		*)
+			return 1;;
+	esac
+}
+
+is_mountpoint() {
+	[ -n "$1" ] &&
+	    [ -d "$1" ] &&
+	    [ "$(block_dev_of_dir "$1")" != \
+					 "$(block_dev_of_dir "$(dirname "$1")")" ]
+}
+
+mount_and_check() {
+	local dir last
+
+	dir=$(for last; do :; done; echo "$last")
+	mount "$@"
+	if ! is_mountpoint "$dir"; then
+		echo "Error: mount $* failed"
+		return 1
+	fi
+}
+
+unmount_and_check() {
+	local bd m=$1 mp
+
+	if is_mountpoint "$m"; then
+		bd=$(block_dev_of_dir "$m")
+		mp=$(dev_to_mpath "$bd") 2>/dev/null
+		if [ -n "$mp" ]; then
+			dmsetup message "$mp" 0 fail_if_no_path
+		fi
+		echo "Unmounting $m from $bd" >> "$FULL"
+		umount "$m"
+	fi
+	if is_mountpoint "$m"; then
+		echo "Error: unmounting $m failed"
+		return 1
+	fi
+}
+
+# Test whether fio supports command-line options "$@"
+test_fio_opt() {
+	local opt
+
+	for opt in "$@"; do
+		opt=${opt//=*}
+		fio --help |& grep -q -- "${opt}=" && continue
+		opt=${opt#--}
+		fio --cmdhelp=all |& grep -q "^${opt}[[:blank:]]" && continue
+		return 1
+	done
+}
+
+run_fio() {
+	local a args avail_kb bd d j opt
+
+	args=("$@")
+	j=1
+	for opt in "${args[@]}"; do
+		case "$opt" in
+			--directory=*) d="${opt#--directory=}";;
+			--filename=*)  bd="${opt#--filename=}";;
+			--numjobs=*)   j="${opt#--numjobs=}";;
+		esac
+	done
+	if [ -n "$d" ]; then
+		a=$(df "$d" | grep "^/" |
+		    {
+			    if read -r fs blocks used avail use mnt; then
+				echo "$avail"
+				echo "$fs $blocks $used $use $mnt" >/dev/null
+			    fi
+		    }
+		 )
+		avail_kb=$a
+	fi
+	if [ -n "$bd" ]; then
+		avail_kb=$(("$(blockdev --getsz "$bd")" / 2))
+	fi
+	if [ -n "$avail_kb" ]; then
+		args+=("--size=$(((avail_kb * 1024 * 7 / 10) / j & ~4095))")
+	fi
+	for opt in --exitall_on_error=1 --gtod_reduce=1 --aux-path=${fio_aux_path}
+	do
+		if test_fio_opt "$opt"; then
+			args+=("$opt")
+		fi
+	done
+	mkdir -p "${fio_aux_path}"
+	echo "fio ${args[*]}" >>"${FULL}"
+	fio "${args[@]}" 2>&1
+	if [ -n "$output" ]; then
+		# Return exit code 1 if no I/O has been performed.
+		grep -q ', io=[0-9].*, run=[0-9]' "$output"
+	fi
+}
+
+shutdown_client() {
+	remove_mpath_devs &&
+	    log_out &&
+	    stop_client
+}
+
+# Undo setup()
+teardown() {
+	stop_target
+}
+
+# Set up test configuration
+setup() {
+	local i m
+
+	if [ -e /etc/init.d/srpd ]; then
+		/etc/init.d/srpd stop >/dev/null 2>&1
+	else
+		systemctl stop srp_daemon
+	fi >>"$FULL" 2>&1
+	if pidof srp_daemon >/dev/null; then
+		echo "Error: failed to stop srp_daemon"
+		return 1
+	fi
+
+	shutdown_client || return $?
+
+	if ! teardown; then
+		echo "teardown() failed"
+		return 1
+	fi
+
+	[ -e /sys/module/scsi_mod ] || modprobe scsi_mod
+	[ -e /sys/module/dm_mod   ] || modprobe dm_mod
+	# Load configfs
+	grep -wq configfs /proc/filesystems || modprobe configfs || return $?
+
+	# Load the I/O scheduler kernel modules
+	(
+		cd "/lib/modules/$(uname -r)/kernel/block" &&
+		    for m in *.ko; do
+			    modprobe "${m%.ko}"
+		    done
+	)
+
+	if [ -d /sys/kernel/debug/dynamic_debug ]; then
+		for m in ; do
+			echo "module $m +pmf" >/sys/kernel/debug/dynamic_debug/control
+		done
+	fi
+
+	start_target
+}
diff --git a/tests/srp/rc b/tests/srp/rc
new file mode 100755
index 000000000000..f5de9610dc2b
--- /dev/null
+++ b/tests/srp/rc
@@ -0,0 +1,54 @@
+#!/bin/bash
+#
+# Copyright (c) 2018 Western Digital Corporation or its affiliates
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License
+# as published by the Free Software Foundation; either version 2
+# of the License, or (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write to the Free Software
+# Foundation, Inc.
+
+. common/rc
+
+is_lio_configured() {
+	(
+		cd /sys/kernel/config/target >&/dev/null || return 1
+		for e in target/* core/fileio* core/iblock* core/pscsi*; do
+			[ -d "$e" ] && [ "$e" != core ] && return 0
+		done
+	)
+
+	return 1
+}
+
+group_requires() {
+	_have_configfs || return $?
+	if is_lio_configured; then
+		echo "Error: LIO must be unloaded before the SRP tests are run"
+		return 1
+	fi
+	_have_module dm_multipath || return $?
+	_have_module ib_srp || return $?
+	_have_module ib_srpt || return $?
+	_have_module sd_mod || return $?
+	_have_program mkfs.ext4 || return $?
+	_have_program mkfs.xfs || return $?
+	_have_program multipath || return $?
+	_have_program multipathd || return $?
+	_have_program pidof || return $?
+	_have_program sg_reset || return $?
+	_have_root || return $?
+
+	if ! pidof multipathd >/dev/null; then
+		echo "Error: multipathd is not running"
+		return 1
+	fi
+}
-- 
2.17.1
