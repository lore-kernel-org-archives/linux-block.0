Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF3D2F5302
	for <linux-block@vger.kernel.org>; Fri, 19 Sep 2025 10:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758276693; cv=none; b=RLizkBCz9Lqkg+Czew1wJWmFw/LfZ8GnUzrCi66v94S1JCFbUL1HnMtwxF3fCgtbjS2rINKNPMtk7bRp6D5tHOXDOXt6t2/LLa6qxgHBQbFSPdPMPYIdeNHN2HWxCWw0lahst+cpFDFGUtBqRbCAJ0YRgCNZEtlbGxq++jDNhTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758276693; c=relaxed/simple;
	bh=8UeZdK9nd2HgDzllyIY/A4pzgOR1L/yAXO1uQc112M0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=bppt6J6CmzVyfGiUlPlvExm4pI5ACcKuVjvWW18KUFqJzDgoBxjx9yUZuxMAcL92WMlXd10RSpgHrePgne8M0rKIyJ48nhJdanh5j5N6+maZbvdMlADSe2wC+Al0PGUj0CNmq5/nSaAUaUKLBe62vEgkmqeIakNVJGbQMpxH7Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=YHOSj1Sd; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="YHOSj1Sd"
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250919101123epoutp0274d2b767c2e7eda23542c4b57bcbe5f1~mp1PjcxxY0339903399epoutp02Y
	for <linux-block@vger.kernel.org>; Fri, 19 Sep 2025 10:11:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250919101123epoutp0274d2b767c2e7eda23542c4b57bcbe5f1~mp1PjcxxY0339903399epoutp02Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1758276683;
	bh=nPlCpCm3cUU731xDRiLcEeFEHtmCT/RWpHVCwJRpYc0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YHOSj1SdE38TO9IQsQSf04YIw4fL9cAk7E1iztCZHk1BHaJa96X4nfvDH1ppielgI
	 O0KT3usLPA8xY53VQIW5++ggAgx0ALQ80PsdR4Byt33mN25bs+ahvqgml49ej/dSBS
	 qNveVO3/h6unPBeKQdmgo+jrZG+ZtCAqmv84WDfA=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20250919101122epcas5p1ac61d8498e34adbbf6e793c9e77cc843~mp1PPLHtv3175931759epcas5p15;
	Fri, 19 Sep 2025 10:11:22 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.93]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4cSpF601N6z3hhT3; Fri, 19 Sep
	2025 10:11:22 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20250919101121epcas5p455497128b99b80c2f561a58dff5b6866~mp1Nx95mT2201822018epcas5p4I;
	Fri, 19 Sep 2025 10:11:21 +0000 (GMT)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250919101119epsmtip1d2c0145436ab42766b350b8d73bc170c~mp1MA9vHC0183501835epsmtip1p;
	Fri, 19 Sep 2025 10:11:19 +0000 (GMT)
From: Anuj Gupta <anuj20.g@samsung.com>
To: vincent.fu@samsung.com, anuj1072538@gmail.com, axboe@kernel.dk,
	hch@infradead.org, martin.petersen@oracle.com, shinichiro.kawasaki@wdc.com
Cc: linux-block@vger.kernel.org, joshi.k@samsung.com, Anuj Gupta
	<anuj20.g@samsung.com>
Subject: [blktests v2 2/2] block: add test for io_uring Protection
 Information (PI) interface using FS_IOC_GETLBMD_CAP
Date: Fri, 19 Sep 2025 15:40:28 +0530
Message-Id: <20250919101028.14245-3-anuj20.g@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250919101028.14245-1-anuj20.g@samsung.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250919101121epcas5p455497128b99b80c2f561a58dff5b6866
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250919101121epcas5p455497128b99b80c2f561a58dff5b6866
References: <20250919101028.14245-1-anuj20.g@samsung.com>
	<CGME20250919101121epcas5p455497128b99b80c2f561a58dff5b6866@epcas5p4.samsung.com>

This test verifies end-to-end support for integrity metadata via the
io-uring interface. It uses the FS_IOC_GETLBMD_CAP ioctl to query the
logical block metadata capabilities of the device. These values are then
passed to fio using the md_per_io_size option.

io_uring PI interface: https://lore.kernel.org/all/20241128112240.8867-1-anuj20.g@samsung.com/
fio support for interface: https://lore.kernel.org/all/20250725175808.2632-2-vincent.fu@samsung.com/
ioctl: https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/log/?h=vfs-6.17.integrity

Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
Signed-off-by: Vincent Fu <vincent.fu@samsung.com>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
---
 src/.gitignore         |  1 +
 src/Makefile           |  1 +
 src/ioctl-lbmd-query.c | 65 ++++++++++++++++++++++++++++++++++++++
 tests/block/041        | 71 ++++++++++++++++++++++++++++++++++++++++++
 tests/block/041.out    |  2 ++
 5 files changed, 140 insertions(+)
 create mode 100644 src/ioctl-lbmd-query.c
 create mode 100755 tests/block/041
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
index 0000000..cf6344d
--- /dev/null
+++ b/src/ioctl-lbmd-query.c
@@ -0,0 +1,65 @@
+// SPDX-License-Identifier: GPL-3.0+
+// Copyright (C) 2025 Anuj Gupta
+
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
+
+	if (fd < 0) {
+		perror("open");
+		return 1;
+	}
+
+	struct logical_block_metadata_cap cap = {};
+
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
new file mode 100755
index 0000000..1237982
--- /dev/null
+++ b/tests/block/041
@@ -0,0 +1,71 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2025 Anuj Gupta, Samsung Electronics
+
+# Test: io_uring read with metadata buffer using FIO's io_uring PI interface
+
+. tests/block/rc
+. common/nvme
+
+DESCRIPTION="io_uring read with PI metadata buffer on block device"
+
+device_requires() {
+	_require_test_dev_is_nvme
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
+	# shellcheck disable=SC2034
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
+	md_per_io_size=$((bs * lbmd_size / lbmd_interval))
+
+	local fio_args=(
+		--name=pi_read_test
+		--filename="$TEST_DEV"
+		--size=1M
+		--bs="$bs"
+		--rw=write
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

