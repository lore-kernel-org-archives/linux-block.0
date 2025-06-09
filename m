Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3AA9209F56
	for <linux-block@vger.kernel.org>; Mon,  9 Jun 2025 15:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749483700; cv=none; b=CNOqUCV7cGG8JRjNujCoMJLGHuZdSLP4jr7K7aIBx6yiFGZ5rInYEYyUi7dMvqvUwgbgyOpFyoPdhme9Fup85sYOizhOKDmvRo+A+fzh+4dLOG68KktYeFxG5WWXRt0XMQoFzWBdNWzs1/6b6sczeF+9yIZyvr9PTQJJI0i9qrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749483700; c=relaxed/simple;
	bh=PzUKxiAQ3H8I5ChG3h1aAuxUxA13WMEcHTrrollELp8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OZclvG9b6cuKDV1YWcyXt0kO4L8N1T41dnoLyeZY4coA/9y0H6hrEYxuUhMM7LEPpT8CLYYkgT6PJxgpDCRhAdO5/Jki1WWTZIWAReiLF7nfD7ZoPsQMpYSLMjmBkoz/XW5jDpJ2rttSt9pJ614MzNHPS/wuD/G/0tgP4JJa7oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=NRCKHW6N; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="NRCKHW6N"
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 559Cv7dk004966
	for <linux-block@vger.kernel.org>; Mon, 9 Jun 2025 08:41:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2021-q4; bh=XufrGqSlTLq9Yi3fGa
	uNO4bAfVI0GxGA1PpQHaHaKno=; b=NRCKHW6NJH+P+ZzLBHqYjr2yn4ckJOwEFM
	Tzd1g4J5ewMwix7ms4+HuTaF5akvQQHNKxH+gpGUl3tgXKMzQTSpI+i9WqnashmC
	OYQ/osuwSoJA0qgyyuseT6R+Ku6xXQ/1CJIxmlQYF5I+ZyHlfz43TqZza0M6x+kp
	K4I6Fdn1QXP6gDNnmU11EQ4ynuvusgllFsFDlsiTCV/bUh5P+ZfhfycAryVX3SDE
	GcU0j1dpMK24vjl+h5/EGUSwCAGCKzgzMyUdZ9DY22QeDDrGybDiMuEyLHjoyHag
	EgVLvW0YWIlFlMiCVUAonUmCH2cYOfPp5tHUWmdmmYSBMXLJhDHg==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 475hncvgd0-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Mon, 09 Jun 2025 08:41:34 -0700 (PDT)
Received: from twshared35278.32.frc3.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.24; Mon, 9 Jun 2025 15:41:32 +0000
Received: by devbig209.atn5.facebook.com (Postfix, from userid 544533)
	id 87C387BC49E; Mon,  9 Jun 2025 08:41:22 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <shinichiro.kawasaki@wdc.com>
CC: <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv2] block tests: nvme metadata passthrough
Date: Mon, 9 Jun 2025 08:41:22 -0700
Message-ID: <20250609154122.2119007-1-kbusch@meta.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA5MDExNiBTYWx0ZWRfX5O02C0agPIHd xZdOol1ksdYx9g/rq/dJrJoM+0ZSLxj2M/lJPzDQC+amJn1spV/s7Cy2tOodEtxnzQvtvQAgeHf mGMu355dC4e1M94XWGRBLjQ2/jPYYpXCcrmKlbgDruVqsU9NesijyjAHRItnfpXfRTakX5de5Yh
 QJY/ENJ5ba8pDYirUzoCLnE+yOdF4wh1pYAsxYm5h4XcSkiYYcmOlxt+kEkjlZbZ1IeGBSC620k GO/EoUZut6zr9DajvRzgbc9S1XHK8jD223DkUkn7b5Ekl3JOffq/veio8Tv37OSKiI3rsNQDAjj KizlYt8TIB7mdiyVblkX6+f0bYW+su0kX3IU8bm1Cx6s0uTpz49zbP1S/YYIlYtr9ByDriG1v1i
 fYdLsTdf8TFo8xBRFRdC4f5VAzi/ZJom80dCNnoFX2Vgh/tO/BkpuKHRmZFraYmW4/gOD+RH
X-Proofpoint-ORIG-GUID: AgtjK7igyEGGuLlOGeujyjZOQl8KGdue
X-Authority-Analysis: v=2.4 cv=SoKQ6OO0 c=1 sm=1 tr=0 ts=684700ae cx=c_pps a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=gv7vcHTE1w2SKThykOQA:9
X-Proofpoint-GUID: AgtjK7igyEGGuLlOGeujyjZOQl8KGdue
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-09_06,2025-06-09_01,2025-03-28_01

From: Keith Busch <kbusch@kernel.org>

Get more coverage on nvme metadata passthrough. Specifically in this
test, read-only metadata is targeted as this had been a gap in previous
test coveraged.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---

This one should fail on 6.15 and pass on 6.16.

v1->v2:

  Correctly used the "test_device()" function name instead of "test()".

  Use the NSID value we got from the device instead of assuming 1.

  Fixed the logic for which command is expected to fail when given
  read-only memory.

 src/Makefile                |   1 +
 src/nvme-passthrough-meta.c | 230 ++++++++++++++++++++++++++++++++++++
 tests/nvme/064              |  24 ++++
 tests/nvme/064.out          |   2 +
 4 files changed, 257 insertions(+)
 create mode 100644 src/nvme-passthrough-meta.c
 create mode 100755 tests/nvme/064
 create mode 100644 tests/nvme/064.out

diff --git a/src/Makefile b/src/Makefile
index a94e5f2..f91ac62 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -13,6 +13,7 @@ C_TARGETS :=3D \
 	loop_change_fd \
 	loop_get_status_null \
 	mount_clear_sock \
+	nvme-passthrough-meta \
 	nbdsetsize \
 	openclose \
 	sg/dxfer-from-dev \
diff --git a/src/nvme-passthrough-meta.c b/src/nvme-passthrough-meta.c
new file mode 100644
index 0000000..d19ee25
--- /dev/null
+++ b/src/nvme-passthrough-meta.c
@@ -0,0 +1,230 @@
+// SPDX-License-Identifier: GPL-3.0+
+// Copyright (C) 2025 Keith Busch
+
+/*
+ * Simple test exercising the user metadata interfaces used by nvme pass=
through
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
+#define NVME_IOCTL_ADMIN_CMD    _IOWR('N', 0x41, struct nvme_passthru_cm=
d)
+#define NVME_IOCTL_IO_CMD       _IOWR('N', 0x43, struct nvme_passthru_cm=
d)
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
+	void *buffer, *mptr =3D NULL, *meta =3D NULL;
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
+	fd =3D open(argv[1], O_RDONLY);
+	if (fd < 0)
+		return fd;
+
+	nsid =3D ioctl(fd, NVME_IOCTL_ID);
+	if (nsid < 0) {
+		perror("namespace id");
+		return errno;
+	}
+
+	cmd =3D (struct nvme_passthru_cmd) {
+		.opcode		=3D 0x6,
+		.nsid		=3D nsid,
+		.addr		=3D (__u64)(uintptr_t)&ns,
+		.data_len       =3D sizeof(ns),
+	};
+
+	ret =3D ioctl(fd, NVME_IOCTL_ADMIN_CMD, &cmd);
+	if (ret < 0) {
+		perror("id-ns");
+		return errno;
+	}
+
+	lbaf =3D ns.lbaf[ns.flbas & 0xf];
+	block_size =3D 1 << lbaf.ds;
+	meta_size =3D lbaf.ms;
+
+	/* format not appropriate for this test */
+	if (meta_size =3D=3D 0)
+		return 0;
+
+	blocks =3D BUFFER_SIZE / block_size;
+	meta_buffer_size =3D blocks * meta_size;
+
+	buffer =3D malloc(BUFFER_SIZE);
+	mptr =3D mmap(NULL, 8192, PROT_READ | PROT_WRITE,
+		MAP_PRIVATE|MAP_ANONYMOUS, -1, 0);
+	if (mptr =3D=3D MAP_FAILED) {
+		perror("mmap");
+		return errno;
+	}
+
+	/* this should directly use the user space buffer */
+	meta =3D mptr;
+	cmd =3D (struct nvme_passthru_cmd) {
+		.opcode		=3D 1,
+		.nsid		=3D nsid,
+		.addr		=3D (uintptr_t)buffer,
+		.metadata       =3D (uintptr_t)meta,
+		.data_len       =3D BUFFER_SIZE,
+		.metadata_len   =3D meta_buffer_size,
+		.cdw12		=3D blocks - 1,
+	};
+
+	ret =3D ioctl(fd, NVME_IOCTL_IO_CMD, &cmd);
+	if (ret < 0) {
+		perror("nvme-write");
+		return ret;
+	}
+
+	cmd.opcode =3D 2;
+	ret =3D ioctl(fd, NVME_IOCTL_IO_CMD, &cmd);
+	if (ret < 0) {
+		perror("nvme-read");
+		return ret;
+	}
+
+	/*
+	 * this offset should either force a kernel copy if we don't have
+	 * contiguous pages, or test the device's metadata sgls
+	 */
+	meta =3D mptr + 4096 - 16;
+	cmd.opcode =3D 1;
+	cmd.metadata =3D (uintptr_t)meta;
+
+	ret =3D ioctl(fd, NVME_IOCTL_IO_CMD, &cmd);
+	if (ret < 0) {
+		perror("nvme-write (offset)");
+		return errno;
+	}
+
+	cmd.opcode =3D 2;
+	ret =3D ioctl(fd, NVME_IOCTL_IO_CMD, &cmd);
+	if (ret < 0) {
+		perror("nvme-read (offset)");
+		return errno;
+	}
+
+	/*
+	 * This buffer is read-only, so should not be successful with commands
+	 * where it is the destination (reads)
+	 */
+	mptr =3D mmap(NULL, 8192, PROT_READ, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0);
+	if (mptr =3D=3D MAP_FAILED) {
+		perror("mmap");
+		return errno;
+	}
+
+	meta =3D mptr;
+
+	cmd.opcode =3D 1;
+	cmd.metadata =3D (uintptr_t)meta;
+	ret =3D ioctl(fd, NVME_IOCTL_IO_CMD, &cmd);
+	if (ret < 0) {
+		perror("nvme-write (prot_read)");
+		return ret;
+	}
+
+	cmd.opcode =3D 2;
+	ret =3D ioctl(fd, NVME_IOCTL_IO_CMD, &cmd);
+	if (ret =3D=3D 0) {
+		perror("nvme-read (expect Failure)");
+		return EFAULT;
+	}
+
+	return 0;
+}
diff --git a/tests/nvme/064 b/tests/nvme/064
new file mode 100755
index 0000000..fd72d4a
--- /dev/null
+++ b/tests/nvme/064
@@ -0,0 +1,24 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2025 Keith Busch <kbusch@kernel.org>
+#
+# Test out metadata through the passthrough interfaces
+
+. tests/nvme/rc
+
+requires() {
+	_nvme_requires
+}
+
+DESCRIPTION=3D"exercise the nvme metadata usage with passthrough command=
s"
+QUICK=3D1
+
+test_device() {
+	echo "Running ${TEST_NAME}"
+
+	if src/nvme-passthrough-meta "${TEST_DEV}"; then
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
--=20
2.47.1

