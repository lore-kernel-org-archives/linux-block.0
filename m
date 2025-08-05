Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A48B21C19A
	for <linux-block@vger.kernel.org>; Tue,  5 Aug 2025 06:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754375413; cv=none; b=WT2FCKwWpXfnEmFtS59/X2Gaft0bB3i5s3szWJ5siq5EhE9i/1TLBYff6021NEQmnYE7/9nEjdjei3FLghq3vO2q1UnrOk9morsCi+Xf14bfWJ3ixlPJpBQpEoRtcWVFd2eWpPYf8P1XIC9uP5CxZkKW3Fn78BYzHVlf/p4uzoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754375413; c=relaxed/simple;
	bh=GG5aUDXcyTyqo8mHVB6XoUC7ZiZK0nqIx3rRpv/xpCM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=lVK3JkIhiqv0VKlmgqtM46Sn45MH29J8+F4l1Q8z/3wlWyRxkrZH55y/jVWS9Kj7/a3lgrVK43WdU/hZLT3ytn7u762fH7QXJ6zpdOgoOiZoAI12TdBlL56FpsE3YDokksFnmgBWMnXkyiPCKpKaGF4V4AKPe9xnTxODJv73hbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=XaK91+4d; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="XaK91+4d"
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250805063008epoutp03161386326f220128ad38339ed755573e~YyyODDtkO1025510255epoutp03D
	for <linux-block@vger.kernel.org>; Tue,  5 Aug 2025 06:30:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250805063008epoutp03161386326f220128ad38339ed755573e~YyyODDtkO1025510255epoutp03D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1754375408;
	bh=SZdCazulQcSssYYVNyYkLB+QGxDx2dq11PG26FG9+OM=;
	h=From:To:Cc:Subject:Date:References:From;
	b=XaK91+4dXRIUk9i6gq1mF090W1EGT0uZGInj/ArQhcKsH+PPiAcHtxxlO14zvvgFS
	 XFSEdhgo2f4ahwsl3S3sjOaktxOQZWXaSV1BxphsIjBy10EhIr+jvscfYSAB+p16Xx
	 b3yMc9xBJn1GEBb3MEBUYGjxTEO3UG/EFrVLlApA=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20250805063007epcas5p3bac311c4b5eddce0dcd54d361517e2f0~YyyNfYh7I2184521845epcas5p3i;
	Tue,  5 Aug 2025 06:30:07 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.88]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4bx3SZ4K12z6B9mF; Tue,  5 Aug
	2025 06:30:06 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20250805061730epcas5p4ae7a8eda6d1d11cc90317a80738eb2ea~YynMbQzfw2621326213epcas5p4v;
	Tue,  5 Aug 2025 06:17:30 +0000 (GMT)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250805061729epsmtip26b30a408a9bc30f9befb5021b86e9358~YynLGSVDu3224232242epsmtip2l;
	Tue,  5 Aug 2025 06:17:29 +0000 (GMT)
From: Anuj Gupta <anuj20.g@samsung.com>
To: vincent.fu@samsung.com, anuj1072538@gmail.com, axboe@kernel.dk,
	hch@infradead.org, martin.petersen@oracle.com, shinichiro.kawasaki@wdc.com
Cc: linux-block@vger.kernel.org, joshi.k@samsung.com, gost.dev@samsung.com,
	Anuj Gupta <anuj20.g@samsung.com>
Subject: [blktests v1] block: add test for io_uring Protection Information
 (PI) interface using FS_IOC_GETLBMD_CAP
Date: Tue,  5 Aug 2025 11:46:55 +0530
Message-Id: <20250805061655.65690-1-anuj20.g@samsung.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250805061730epcas5p4ae7a8eda6d1d11cc90317a80738eb2ea
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250805061730epcas5p4ae7a8eda6d1d11cc90317a80738eb2ea
References: <CGME20250805061730epcas5p4ae7a8eda6d1d11cc90317a80738eb2ea@epcas5p4.samsung.com>

This test verifies end-to-end support for integrity metadata via the
io-uring interface. It uses the FS_IOC_GETLBMD_CAP ioctl to query the
logical block metadata capabilities of the device. These values are then
passed to fio using the md_per_io_size option.

io_uring PI interface: https://lore.kernel.org/all/20241128112240.8867-1-anuj20.g@samsung.com/
fio support for interface: https://lore.kernel.org/all/20250725175808.2632-2-vincent.fu@samsung.com/
ioctl: https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/log/?h=vfs-6.17.integrity
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
Signed-off-by: Vincent Fu <vincent.fu@samsung.com>
---
 src/.gitignore         |  1 +
 src/Makefile           |  1 +
 src/ioctl-lbmd-query.c | 60 +++++++++++++++++++++++++++++++++++++
 tests/block/041        | 68 ++++++++++++++++++++++++++++++++++++++++++
 tests/block/041.out    |  2 ++
 5 files changed, 132 insertions(+)
 create mode 100644 src/ioctl-lbmd-query.c
 create mode 100644 tests/block/041
 create mode 100644 tests/block/041.out

diff --git a/src/.gitignore b/src/.gitignore
index 399a046..2ece754 100644
--- a/src/.gitignore
+++ b/src/.gitignore
@@ -10,3 +10,4 @@
 /zbdioctl
 /miniublk
 /nvme-passthrough-meta
+/ioctl-lbmd-query
diff --git a/src/Makefile b/src/Makefile
index f91ac62..ba0d9b7 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -14,6 +14,7 @@ C_TARGETS := \
 	loop_get_status_null \
 	mount_clear_sock \
 	nvme-passthrough-meta \
+	ioctl-lbmd-query \
 	nbdsetsize \
 	openclose \
 	sg/dxfer-from-dev \
diff --git a/src/ioctl-lbmd-query.c b/src/ioctl-lbmd-query.c
new file mode 100644
index 0000000..0b60320
--- /dev/null
+++ b/src/ioctl-lbmd-query.c
@@ -0,0 +1,60 @@
+#include <stdio.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <string.h>
+#include <sys/ioctl.h>
+#include <linux/fs.h>
+#include <errno.h>
+
+#ifndef FS_IOC_GETLBMD_CAP
+#define FS_IOC_GETLBMD_CAP		_IOWR(0x15, 2, struct logical_block_metadata_cap)
+
+#define	LBMD_PI_CAP_INTEGRITY		(1 << 0)
+
+struct logical_block_metadata_cap {
+	__u32	lbmd_flags;
+	__u16	lbmd_interval;
+	__u8	lbmd_size;
+	__u8	lbmd_opaque_size;
+	__u8	lbmd_opaque_offset;
+	__u8	lbmd_pi_size;
+	__u8	lbmd_pi_offset;
+	__u8	lbmd_guard_tag_type;
+	__u8	lbmd_app_tag_size;
+	__u8	lbmd_ref_tag_size;
+	__u8	lbmd_storage_tag_size;
+	__u8	pad;
+};
+#endif
+
+int main(int argc, char *argv[])
+{
+	if (argc != 2) {
+		fprintf(stderr, "Usage: %s <block-device>\n", argv[0]);
+		return 1;
+	}
+
+	const char *dev = argv[1];
+	int fd = open(dev, O_RDONLY);
+	if (fd < 0) {
+		perror("open");
+		return 1;
+	}
+
+	struct logical_block_metadata_cap cap = {};
+	if (ioctl(fd, FS_IOC_GETLBMD_CAP, &cap) < 0) {
+		perror("FS_IOC_GETLBMD_CAP");
+		close(fd);
+		return 1;
+	}
+	close(fd);
+
+	if (!(cap.lbmd_flags & LBMD_PI_CAP_INTEGRITY)) {
+		printf("unsupported\n");
+		return 0;
+	}
+
+	printf("lbmd_flags=%u lbmd_interval=%u lbmd_size=%u\n",
+	       cap.lbmd_flags, cap.lbmd_interval, cap.lbmd_size);
+	return 0;
+}
diff --git a/tests/block/041 b/tests/block/041
new file mode 100644
index 0000000..ddb8117
--- /dev/null
+++ b/tests/block/041
@@ -0,0 +1,68 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2025 Anuj Gupta, Samsung Electronics
+
+# Test: io_uring read with metadata buffer using FIO's io_uring PI interface
+
+. tests/nvme/rc
+
+DESCRIPTION="io_uring read with PI metadata buffer on block device"
+
+device_requires() {
+	_test_dev_has_metadata
+	_test_dev_disables_extended_lba
+}
+
+requires() {
+	_have_fio
+	_have_kernel_option IO_URING
+	_have_kernel_option BLK_DEV_INTEGRITY
+	_have_fio_ver 3 40
+}
+
+test_device() {
+	echo "Running ${TEST_NAME}"
+
+	local lbmd_flags lbmd_size lbmd_interval
+	local cap_out bs md_per_io_size
+
+	# Query integrity capabilities via ioctl helper
+	cap_out=$(src/ioctl-lbmd-query "$TEST_DEV")
+	ret=$?
+	if [[ $ret != 0 ]]; then
+		SKIP_REASONS+=("FS_IOC_GETLBMD_CAP ioctl not supported")
+		return
+	fi
+	if [[ $cap_out == "unsupported" ]]; then
+		SKIP_REASONS+=("Integrity not supported on $TEST_DEV")
+		return
+	fi
+
+	# Parse fields
+	eval "$cap_out"  # sets lbmd_flags, lbmd_size, lbmd_interval
+
+	# Calculate md_per_io_size = (bs / interval) * size
+	bs=$(_min_io "$TEST_DEV")
+	md_per_io_size=$((bs / lbmd_interval * lbmd_size))
+
+	local fio_args=(
+		--name=pi_read_test
+		--filename="$TEST_DEV"
+		--size=1M
+		--bs="$bs"
+		--rw=randread
+		--ioengine=io_uring
+		--iodepth=8
+		--numjobs=1
+		--direct=1
+		--time_based
+		--runtime=3
+		--md_per_io_size="$md_per_io_size"
+		--pi_act=0            # Host supplies metadata
+		--pi_chk=APPTAG       # Only check app tag
+		--apptag=0x1234
+	)
+
+	_run_fio "${fio_args[@]}"
+	echo "Test complete"
+}
diff --git a/tests/block/041.out b/tests/block/041.out
new file mode 100644
index 0000000..6706a76
--- /dev/null
+++ b/tests/block/041.out
@@ -0,0 +1,2 @@
+Running block/041
+Test complete
-- 
2.25.1

