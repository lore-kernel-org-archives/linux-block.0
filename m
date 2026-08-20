Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1271A275
	for <linux-block@vger.kernel.org>; Thu, 20 Aug 2026 20:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787256050; cv=none; b=hxl+O+W/POC/YLKqSq0FXk6ONCtR03kgOu17L+TPaVY2rIsRnV9dMJy/zP5Jl+qlF+oV0tHNveJjwN225Q9C3Pff3jzIapLu6D44jIBUETtWFIStz2E72xHyCA9QOmuJWnP6D8kxLvIQIX26bfFwDIFP41FsLVIhMUtMR62o6ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787256050; c=relaxed/simple;
	bh=7t+xciM56+QyMUk+OJl9RE1r6uyOeKLtj/bCYAR3pGE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e4NVMrIa9hsLfWVDj7tvUr4jKDYgQIkG/ktxBVCSbv+q/fghtacNtf009UrC6nMLLe87M5WvDRpfYuxRr5GQlOWCw7PJ8KiK9YqylhLf71L6Nso2jRxCxzAa3i62k0q+eCfKA9z2XQN/oZODo6+2ezS7GGjNoOdBu3BHwh1VtMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=qfLLkR5N; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="qfLLkR5N"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4hQvSc3JSHz1XM5kY;
	Thu, 20 Aug 2026 20:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:from:from:received:received; s=mr01; t=
	1787256044; x=1789848045; bh=KlJM8o7MTMOsPeHKj9v9bh32CL/rv40NHJe
	GRtq2PpI=; b=qfLLkR5NigMOuDaJTEmEffQhdw7gsBGpDNsl//ddRkGF9o9Ig41
	skbAV7RfGXbKL971dEntHhfv1P9KZR1/oPYatfFNuTBua61QZtMHldauPLLl2x6y
	J9NuPvZR5ayhuiVkObfmUNLgnXC3dbScf4a6rntsW0Zd7jz0NnuB4D2rX1LODa6V
	bwH5VLo9ulH3lABKwPyv+nVeqX1girkUdVKg+1WLbv7aQkiu2ceO2kXe6paXwdsL
	LkzuG1FXRWyjXGH9lXBcIsE/mGK++FfjkWgJUATQes2kEivya+Snn+7dOdu49GNA
	EKWnvNiykgapF8fzGZRFd0xtyVUfFWB2G5w==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id X3i7A_E427hZ; Thu, 20 Aug 2026 20:00:44 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (148.60.168.34.bc.googleusercontent.com [34.168.60.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4hQvSX09qTz1XM4Sx;
	Thu, 20 Aug 2026 20:00:43 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH blktests] loop/014: Add test for backing file on loop device partition
Date: Thu, 20 Aug 2026 13:00:34 -0700
Message-ID: <20260820200034.3849080-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.55.0.766.g2966f0265a-goog
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add a new loop driver test that verifies that attempting to set the
backing file of a loop device to a file located on a filesystem on one of
the same loop device's partitions fails as expected by triggering the
kernel function loop_validate_file().

Modify src/loop_change_fd.c to accept a -r option to open the loop device
and backing file in read-only mode (O_RDONLY).

The test performs the following steps:
- Create a 1 GB image file ($TMPDIR/img).
- Instantiate a loop device for the image file with partition scanning
  enabled.
- Create two partitions of equal size on that loop device.
- Format the second partition with the ext4 filesystem and mount it.
- Create a 1 GB file on the mounted filesystem.
- Unmount the filesystem, detach the loop device, and re-instantiate it i=
n
  read-only mode.
- Mount the partition read-only.
- Use src/loop_change_fd -r to attempt to change the backing file
  descriptor of the loop device to the file on its own partition via
  LOOP_CHANGE_FD, and verify that loop_validate_file() rejects it.
- Clean up by unmounting the filesystem and detaching the loop device.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 src/loop_change_fd.c |  20 ++++++--
 tests/loop/014       | 107 +++++++++++++++++++++++++++++++++++++++++++
 tests/loop/014.out   |   2 +
 3 files changed, 125 insertions(+), 4 deletions(-)
 create mode 100755 tests/loop/014
 create mode 100644 tests/loop/014.out

diff --git a/src/loop_change_fd.c b/src/loop_change_fd.c
index b124d829f380..722f14d3d91f 100644
--- a/src/loop_change_fd.c
+++ b/src/loop_change_fd.c
@@ -11,25 +11,37 @@
=20
 void usage(const char *progname)
 {
-	fprintf(stderr, "usage: %s LOOPDEV PATH\n", progname);
+	fprintf(stderr, "usage: %s [-r] LOOPDEV PATH\n", progname);
 	exit(EXIT_FAILURE);
 }
=20
 int main(int argc, char **argv)
 {
+	int flags =3D O_RDWR;
 	int ret;
 	int fd, filefd;
+	int c;
=20
-	if (argc !=3D 3)
+	while ((c =3D getopt(argc, argv, "r")) !=3D -1) {
+		switch (c) {
+		case 'r':
+			flags =3D O_RDONLY;
+			break;
+		default:
+			usage(argv[0]);
+		}
+	}
+
+	if (optind + 2 !=3D argc)
 		usage(argv[0]);
=20
-	fd =3D open(argv[1], O_RDWR);
+	fd =3D open(argv[optind], flags);
 	if (fd =3D=3D -1) {
 		perror("open");
 		return EXIT_FAILURE;
 	}
=20
-	filefd =3D open(argv[2], O_RDWR);
+	filefd =3D open(argv[optind + 1], flags);
 	if (filefd =3D=3D -1) {
 		perror("open");
 		return EXIT_FAILURE;
diff --git a/tests/loop/014 b/tests/loop/014
new file mode 100755
index 000000000000..5814b8148a26
--- /dev/null
+++ b/tests/loop/014
@@ -0,0 +1,107 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2026 Google LLC
+#
+# Verify that attempting to change a loop device's backing file (via
+# LOOP_CHANGE_FD) to a file on a filesystem residing on one of its own
+# partitions triggers the kernel function loop_validate_file() and fails=
.
+
+. tests/loop/rc
+
+DESCRIPTION=3D"trigger loop_validate_file() when changing backing file t=
o own partition"
+QUICK=3D1
+
+loop_device=3D
+mount_dir=3D
+
+requires() {
+	_have_program mkfs.ext4
+	_have_program parted
+	_have_src_program loop_change_fd
+}
+
+cleanup() {
+	if [[ -n "$mount_dir" ]]; then
+		umount "$mount_dir" &>/dev/null
+	fi
+	if [[ -n "$loop_device" ]]; then
+		losetup --detach "$loop_device" &>/dev/null
+	fi
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+	_register_test_cleanup cleanup
+
+	mount_dir=3D"$TMPDIR/mnt"
+
+	truncate -s 1G "$TMPDIR/img"
+
+	if ! loop_device=3D"$(losetup --find --partscan --show "$TMPDIR/img")";=
 then
+		echo "Failed to instantiate loop device"
+		return 1
+	fi
+
+	if ! parted --script "$loop_device" \
+		mklabel gpt \
+		mkpart primary 0% 50% \
+		mkpart primary 50% 100% >>"$FULL" 2>&1; then
+		echo "Failed to create partitions on loop device"
+		return 1
+	fi
+
+	udevadm settle
+
+	local part=3D"${loop_device}p2"
+	if [[ ! -b "$part" ]]; then
+		echo "Partition $part does not exist"
+		return 1
+	fi
+
+	if ! mkfs.ext4 -F "$part" >>"$FULL" 2>&1; then
+		echo "Failed to format $part with ext4"
+		return 1
+	fi
+
+	mkdir -p "$mount_dir"
+	if ! mount -t ext4 "$part" "$mount_dir" >>"$FULL" 2>&1; then
+		echo "Failed to mount $part on $mount_dir"
+		return 1
+	fi
+
+	truncate -s 1G "$mount_dir/file"
+
+	umount "$mount_dir"
+	losetup --detach "$loop_device"
+	udevadm settle
+
+	# Reopen the loop device in read-only mode so that LOOP_CHANGE_FD can b=
e used.
+	if ! loop_device=3D"$(losetup --read-only --partscan --find --show "$TM=
PDIR/img")"; then
+		echo "Failed to re-instantiate loop device in read-only mode"
+		return 1
+	fi
+
+	udevadm settle
+
+	part=3D"${loop_device}p2"
+	if ! mount -o ro -t ext4 "$part" "$mount_dir" >>"$FULL" 2>&1; then
+		echo "Failed to mount $part read-only on $mount_dir"
+		return 1
+	fi
+
+	# LOOP_CHANGE_FD triggers loop_validate_file() in the kernel, which mus=
t
+	# detect that the backing file resides on a partition of this loop devi=
ce
+	# and reject the change.
+	if src/loop_change_fd -r "$loop_device" "$mount_dir/file" >>"$FULL" 2>&=
1; then
+		echo "Changing backing file succeeded unexpectedly"
+	fi
+
+	umount "$mount_dir"
+	mount_dir=3D
+
+	losetup --detach "$loop_device"
+	loop_device=3D
+	udevadm settle
+
+	echo "Test complete"
+}
diff --git a/tests/loop/014.out b/tests/loop/014.out
new file mode 100644
index 000000000000..78a7928c5249
--- /dev/null
+++ b/tests/loop/014.out
@@ -0,0 +1,2 @@
+Running loop/014
+Test complete
