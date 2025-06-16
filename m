Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7E92882DF
	for <linux-block@vger.kernel.org>; Mon, 16 Jun 2025 02:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750039650; cv=none; b=K0x2j45Ith0f80Z+90ytWMGSUay/NrHehJS3luxwCB8JFvy9RAxw4xHoL+zCF/cxPZ5sHvVvvs7OW2rzpyKpYHOncHrVhUawg0QHUIiGIBasz1iYAK4ExONOVVTzKmiz+AmoCW6P6KLFUu/7uslFMP122edAkIEUNWcrNYcg5ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750039650; c=relaxed/simple;
	bh=10u9nmpGeL4OB9jIfXl8AY5R12D0EBSud1cs2nqc2QU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rTWS5D/WBsyF9G8Y3juqmLi3Ado8RVFM+KgaKcP86x8TNhMmMOCHsjWxmLQf+Tw9AxKsTClhcpsWZsJcAbB1T3qBryA/ouF9s0cCH40OZJJusFplW2AIPQSzs+/B1rWzoPfU9Po2dPYJEv/fyLlbJeFdy/KZtMvNnUrTL8jPyPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=KZVmseX5; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="KZVmseX5"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1750039648; x=1781575648;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=10u9nmpGeL4OB9jIfXl8AY5R12D0EBSud1cs2nqc2QU=;
  b=KZVmseX5PEXEFddCGBIBCChvwefNzsf0LTVr+j7FSIYGgPWuE3LalgVu
   RzH9yUXWgSBMQqxiC0x9R8Z6ETsbAfjAf7ck1bRs12pD6MH3gauPJTwsT
   OBmBu2LrShVd92JYhc8RQRV+bRC/HCS3Lr+sBz+GWJmp5fdMRTLzv73YO
   uEdFAkbZBSbxPRSJm7PsEA8jPanAOcLgsXExOcw7CIxceCE60GwoJyXnm
   nMCF9FiwefK2ubykeH4s3BhMFqDA4G+nGdUI+AZWHdC/66VSFmSl5iw1H
   u65r8N6c6jgeegwJxn5AaNqXfW990thwhAbkemzDp+JdojFFEfIeCMXqP
   w==;
X-CSE-ConnectionGUID: 8mTa+J3gS8iNOcSVC+pPuA==
X-CSE-MsgGUID: mURt0b6aQOyRJgu0BLwq8w==
X-IronPort-AV: E=Sophos;i="6.16,240,1744041600"; 
   d="scan'208";a="84623415"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 Jun 2025 10:07:21 +0800
IronPort-SDR: 684f6de8_esChEGDnbBT+j+rhuUE39V615x3Rf8o/UAh+8Tiw+vNM9ri
 q7XAqB64U4ECHxTdcIywEEiYu9oQ9WgpK3s9G9g==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Jun 2025 18:05:44 -0700
WDCIronportException: Internal
Received: from wdap-do3irrikgj.ad.shared (HELO shinmob.flets-east.jp) ([10.224.163.172])
  by uls-op-cesaip01.wdc.com with ESMTP; 15 Jun 2025 19:07:20 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Cc: Keith Busch <kbusch@meta.com>,
	Keith Busch <kbusch@kernel.org>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 2/2] nvme: add nvme metadata passthrough test
Date: Mon, 16 Jun 2025 11:07:16 +0900
Message-ID: <20250616020716.2789576-3-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250616020716.2789576-1-shinichiro.kawasaki@wdc.com>
References: <20250616020716.2789576-1-shinichiro.kawasaki@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Keith Busch <kbusch@kernel.org>

Get more coverage on nvme metadata passthrough. Specifically in this
test, read-only metadata is targeted as this had been a gap in previous
test coveraged.

Link: https://lore.kernel.org/linux-block/20250603184752.1185676-1-csander@purestorage.com/
Signed-off-by: Keith Busch <kbusch@kernel.org>
[Shin'ichiro: added test device requirement checks and .gitignore line]
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 src/.gitignore              |   1 +
 src/Makefile                |   1 +
 src/nvme-passthrough-meta.c | 232 ++++++++++++++++++++++++++++++++++++
 tests/nvme/064              |  34 ++++++
 tests/nvme/064.out          |   2 +
 5 files changed, 270 insertions(+)
 create mode 100644 src/nvme-passthrough-meta.c
 create mode 100755 tests/nvme/064
 create mode 100644 tests/nvme/064.out

diff --git a/src/.gitignore b/src/.gitignore
index df7aff5..399a046 100644
--- a/src/.gitignore
+++ b/src/.gitignore
@@ -9,3 +9,4 @@
 /sg/syzkaller1
 /zbdioctl
 /miniublk
+/nvme-passthrough-meta
diff --git a/src/Makefile b/src/Makefile
index a94e5f2..f91ac62 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -13,6 +13,7 @@ C_TARGETS := \
 	loop_change_fd \
 	loop_get_status_null \
 	mount_clear_sock \
+	nvme-passthrough-meta \
 	nbdsetsize \
 	openclose \
 	sg/dxfer-from-dev \
diff --git a/src/nvme-passthrough-meta.c b/src/nvme-passthrough-meta.c
new file mode 100644
index 0000000..29980a2
--- /dev/null
+++ b/src/nvme-passthrough-meta.c
@@ -0,0 +1,232 @@
+// SPDX-License-Identifier: GPL-3.0+
+// Copyright (C) 2025 Keith Busch
+
+/*
+ * Simple test exercising the user metadata interfaces used by nvme passthrough
+ * commands.
+ */
+#define _GNU_SOURCE
+#include <dirent.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+
+#include <inttypes.h>
+#include <sys/ioctl.h>
+#include <sys/mman.h>
+#include <linux/types.h>
+
+#ifndef _LINUX_NVME_IOCTL_H
+#define _LINUX_NVME_IOCTL_H
+struct nvme_passthru_cmd {
+	__u8    opcode;
+	__u8    flags;
+	__u16   rsvd1;
+	__u32   nsid;
+	__u32   cdw2;
+	__u32   cdw3;
+	__u64   metadata;
+	__u64   addr;
+	__u32   metadata_len;
+	__u32   data_len;
+	__u32   cdw10;
+	__u32   cdw11;
+	__u32   cdw12;
+	__u32   cdw13;
+	__u32   cdw14;
+	__u32   cdw15;
+	__u32   timeout_ms;
+	__u32   result;
+};
+
+#define NVME_IOCTL_ID		_IO('N', 0x40)
+#define NVME_IOCTL_ADMIN_CMD    _IOWR('N', 0x41, struct nvme_passthru_cmd)
+#define NVME_IOCTL_IO_CMD       _IOWR('N', 0x43, struct nvme_passthru_cmd)
+#endif /* _UAPI_LINUX_NVME_IOCTL_H */
+
+struct nvme_lbaf {
+	__le16	ms;
+	__u8	ds;
+	__u8	rp;
+};
+
+struct nvme_id_ns {
+	__le64	nsze;
+	__le64	ncap;
+	__le64	nuse;
+	__u8	nsfeat;
+	__u8	nlbaf;
+	__u8	flbas;
+	__u8	mc;
+	__u8	dpc;
+	__u8	dps;
+	__u8	nmic;
+	__u8	rescap;
+	__u8	fpi;
+	__u8	dlfeat;
+	__le16	nawun;
+	__le16	nawupf;
+	__le16	nacwu;
+	__le16	nabsn;
+	__le16	nabo;
+	__le16	nabspf;
+	__le16	noiob;
+	__u8	nvmcap[16];
+	__le16	npwg;
+	__le16	npwa;
+	__le16	npdg;
+	__le16	npda;
+	__le16	nows;
+	__u8	rsvd74[18];
+	__le32	anagrpid;
+	__u8	rsvd96[3];
+	__u8	nsattr;
+	__le16	nvmsetid;
+	__le16	endgid;
+	__u8	nguid[16];
+	__u8	eui64[8];
+	struct nvme_lbaf lbaf[64];
+	__u8	vs[3712];
+};
+
+#define BUFFER_SIZE (32768)
+
+int main(int argc, char **argv)
+{
+	int ret, fd, nsid, blocks, meta_buffer_size;
+	void *buffer, *mptr = NULL, *meta = NULL;
+	struct nvme_passthru_cmd cmd;
+	struct nvme_lbaf lbaf;
+	struct nvme_id_ns ns;
+
+	__u64 block_size;
+	__u16 meta_size;
+
+	if (argc < 2) {
+		fprintf(stderr, "usage: %s /dev/nvmeXnY", argv[0]);
+		return EINVAL;
+	}
+
+	fd = open(argv[1], O_RDONLY);
+	if (fd < 0)
+		return fd;
+
+	nsid = ioctl(fd, NVME_IOCTL_ID);
+	if (nsid < 0) {
+		perror("namespace id");
+		return errno;
+	}
+
+	cmd = (struct nvme_passthru_cmd) {
+		.opcode		= 0x6,
+		.nsid		= nsid,
+		.addr		= (__u64)(uintptr_t)&ns,
+		.data_len       = sizeof(ns),
+	};
+
+	ret = ioctl(fd, NVME_IOCTL_ADMIN_CMD, &cmd);
+	if (ret < 0) {
+		perror("id-ns");
+		return errno;
+	}
+
+	lbaf = ns.lbaf[ns.flbas & 0xf];
+	block_size = 1 << lbaf.ds;
+	meta_size = lbaf.ms;
+
+	/* format not appropriate for this test */
+	if (meta_size == 0) {
+		fprintf(stderr, "Device format does not have metadata\n");
+		return -EINVAL;
+	}
+
+	blocks = BUFFER_SIZE / block_size;
+	meta_buffer_size = blocks * meta_size;
+
+	buffer = malloc(BUFFER_SIZE);
+	mptr = mmap(NULL, 8192, PROT_READ | PROT_WRITE,
+		MAP_PRIVATE|MAP_ANONYMOUS, -1, 0);
+	if (mptr == MAP_FAILED) {
+		perror("mmap");
+		return errno;
+	}
+
+	/* this should directly use the user space buffer */
+	meta = mptr;
+	cmd = (struct nvme_passthru_cmd) {
+		.opcode		= 1,
+		.nsid		= nsid,
+		.addr		= (uintptr_t)buffer,
+		.metadata       = (uintptr_t)meta,
+		.data_len       = BUFFER_SIZE,
+		.metadata_len   = meta_buffer_size,
+		.cdw12		= blocks - 1,
+	};
+
+	ret = ioctl(fd, NVME_IOCTL_IO_CMD, &cmd);
+	if (ret < 0) {
+		perror("nvme-write");
+		return ret;
+	}
+
+	cmd.opcode = 2;
+	ret = ioctl(fd, NVME_IOCTL_IO_CMD, &cmd);
+	if (ret < 0) {
+		perror("nvme-read");
+		return ret;
+	}
+
+	/*
+	 * this offset should either force a kernel copy if we don't have
+	 * contiguous pages, or test the device's metadata sgls
+	 */
+	meta = mptr + 4096 - 16;
+	cmd.opcode = 1;
+	cmd.metadata = (uintptr_t)meta;
+
+	ret = ioctl(fd, NVME_IOCTL_IO_CMD, &cmd);
+	if (ret < 0) {
+		perror("nvme-write (offset)");
+		return errno;
+	}
+
+	cmd.opcode = 2;
+	ret = ioctl(fd, NVME_IOCTL_IO_CMD, &cmd);
+	if (ret < 0) {
+		perror("nvme-read (offset)");
+		return errno;
+	}
+
+	/*
+	 * This buffer is read-only, so should not be successful with commands
+	 * where it is the destination (reads)
+	 */
+	mptr = mmap(NULL, 8192, PROT_READ, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0);
+	if (mptr == MAP_FAILED) {
+		perror("mmap");
+		return errno;
+	}
+
+	meta = mptr;
+
+	cmd.opcode = 1;
+	cmd.metadata = (uintptr_t)meta;
+	ret = ioctl(fd, NVME_IOCTL_IO_CMD, &cmd);
+	if (ret < 0) {
+		perror("nvme-write (prot_read)");
+		return ret;
+	}
+
+	cmd.opcode = 2;
+	ret = ioctl(fd, NVME_IOCTL_IO_CMD, &cmd);
+	if (ret == 0) {
+		perror("nvme-read (expect Failure)");
+		return EFAULT;
+	}
+
+	return 0;
+}
diff --git a/tests/nvme/064 b/tests/nvme/064
new file mode 100755
index 0000000..a10b6ee
--- /dev/null
+++ b/tests/nvme/064
@@ -0,0 +1,34 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2025 Keith Busch <kbusch@kernel.org>
+#
+# Test out metadata through the passthrough interfaces. This test confirms the
+# fix by the kernel commit 43a67dd812c5 ("block: flip iter directions in
+# blk_rq_integrity_map_user()"). This test requires TEST_DEV as a namespace
+# formatted with metadata, and extended LBA disabled. Such namespace can be
+# prepared with QEMU NVME emulation specifying -device option with "ms=8",
+# "ms=16" or "ms=64".
+
+. tests/nvme/rc
+
+requires() {
+	_nvme_requires
+}
+
+device_requires() {
+	_test_dev_has_metadata
+	_test_dev_disables_extended_lba
+}
+
+DESCRIPTION="exercise the nvme metadata usage with passthrough commands"
+QUICK=1
+
+test_device() {
+	echo "Running ${TEST_NAME}"
+
+	if ! src/nvme-passthrough-meta "${TEST_DEV}"; then
+		echo "src/nvme-passthrough-meta failed"
+	fi
+
+	echo "Test complete"
+}
diff --git a/tests/nvme/064.out b/tests/nvme/064.out
new file mode 100644
index 0000000..5b34d4e
--- /dev/null
+++ b/tests/nvme/064.out
@@ -0,0 +1,2 @@
+Running nvme/064
+Test complete
-- 
2.49.0

