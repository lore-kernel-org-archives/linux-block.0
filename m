Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160162472AE
	for <linux-block@vger.kernel.org>; Wed, 19 Nov 2025 19:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763582103; cv=none; b=IobNdDVGIb//mdpWmvz6+224ymfN/BVQxyTbaT+nlrso6kiZaX8enDpz9eHU2ufae1gX03ZGCt9wZ/qKGFZKwmSfbEcgwPY3cD/Jm4c05WmBtGgyTOGnouEhAUX1gm7aulRpzUlKgFmHVFORA4/QD/HSXToTNo75ewkYakwd/f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763582103; c=relaxed/simple;
	bh=QSTEbmL/C0jCtjgL7crQ11FamstHZ16UyLL0AYtnPvw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Aq5zzUkXfQOGTysiOhmuRg8MN8hbOZBjDFE2HQ+BEpwfCcPZNrhqeAbcBxsN6BgApLkEam7Gg6gwZxCZRb1vmvBB/P/2x1FiRd3H95Gn4ZBZeDkoHe0/nKjQEU5f6qaNrbcFc4ejsic4Leh09YDxd93P/98kwSsVyWT5jeYMTNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=ImyMv9sS; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="ImyMv9sS"
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AJIj5D61987960
	for <linux-block@vger.kernel.org>; Wed, 19 Nov 2025 11:54:58 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=sR8yrIGzZJ4yP79rVCv/GxmaKGwKF9atNrZud1HL9Pk=; b=ImyMv9sSVfJn
	LuhtaekbdtC+74UE6y1VwlJ8OTa15itQwemrikjjX8+Ulb4Hltt7zzFMk9SZB4xa
	rwQCC9AmMqo6OZga7yvutGCDokI31NdDMAfU8Uf8EkUnyDQfmVgUkzT9KWrlN2w2
	nAsnEUVURdLljNbYnYpt429BF1bCb8uSSBlsAeDVm81ujd/Pc88/7NSY2ADNH3oT
	AByKyk0DM/D0QjNurrBzdU7QYUh2TQPjxl7jHNloZXXB70CPWaZKDhqCkIDMBeFk
	ccdqDRGy9etyH7Q8IwnWu0RE7UMznnRXpsxBmSL9NV9c2N5/+OXdn+eQCDQyHLaV
	iXgOdzJmmg==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4ahdv0buj5-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Wed, 19 Nov 2025 11:54:57 -0800 (PST)
Received: from twshared13623.02.snb2.facebook.com (2620:10d:c0a8:1c::11) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Wed, 19 Nov 2025 19:54:55 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id BF5A23F346F4; Wed, 19 Nov 2025 11:54:50 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <shinichiro.kawasaki@wdc.com>
CC: <chaitanyak@nvidia.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv2 1/2] blktests: test direct io offsets
Date: Wed, 19 Nov 2025 11:54:48 -0800
Message-ID: <20251119195449.2922332-2-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251119195449.2922332-1-kbusch@meta.com>
References: <20251119195449.2922332-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=F4pat6hN c=1 sm=1 tr=0 ts=691e2091 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8
 a=BysCUAVz09fvk_P7r28A:9
X-Proofpoint-GUID: DWkBlUDTXsvdy71dQzoiI0_VOSFSZgFk
X-Proofpoint-ORIG-GUID: DWkBlUDTXsvdy71dQzoiI0_VOSFSZgFk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE5MDE1NiBTYWx0ZWRfX8fw6OdmYALig
 4oupTMJbbnr/Exgzx8TENdwFTsK14pC+CMHNHbve4O08a6CYzVTh9tVFzhJ5zFReaCizJ91Tdcw
 dFJHpdFPxG11eF/0O+L6HvDf6CJCXy8VSi41UW7em2i5dau1pBTb35i4fSoHi21y9GecW5ghMZv
 qVb4Z9iopZI4qea93eBaZctSs3uO17Mm5V/HWq0cYAPZZRIUvDvj9aTQmiMGjr4810EXyHDXQ5u
 JBYWA4GeOQd36pUwfmjlBpERsfvMrQENNiTGevI1D8LLS85Bzi0yClRCSTdkZrORtxCWxdCXJ7p
 Zxn7+GrGO3oONFqTtYym6QX1ovAG2jZHjI7WmOo3BOIIcXbP8bR7d/0RX5BeHYqYLgpc1LwYmNe
 RcIApBufQzs9KTXlvjKPVWWYe/IwSw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-19_05,2025-11-18_02,2025-10-01_01

From: Keith Busch <kbusch@kernel.org>

Tests various direct IO memory and length alignments against the
device's queue limits reported from sysfs.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 src/.gitignore      |   1 +
 src/Makefile        |   1 +
 src/dio-offsets.c   | 708 ++++++++++++++++++++++++++++++++++++++++++++
 tests/block/042     |  26 ++
 tests/block/042.out |   2 +
 5 files changed, 738 insertions(+)
 create mode 100644 src/dio-offsets.c
 create mode 100644 tests/block/042
 create mode 100644 tests/block/042.out

diff --git a/src/.gitignore b/src/.gitignore
index 2ece754..865675c 100644
--- a/src/.gitignore
+++ b/src/.gitignore
@@ -1,3 +1,4 @@
+/dio-offsets
 /discontiguous-io
 /loblksize
 /loop_change_fd
diff --git a/src/Makefile b/src/Makefile
index ba0d9b7..179a673 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -9,6 +9,7 @@ HAVE_C_MACRO =3D $(shell if echo "$(H)include <$(1)>" |	\
 		then echo 1;else echo 0; fi)
=20
 C_TARGETS :=3D \
+	dio-offsets \
 	loblksize \
 	loop_change_fd \
 	loop_get_status_null \
diff --git a/src/dio-offsets.c b/src/dio-offsets.c
new file mode 100644
index 0000000..8e46091
--- /dev/null
+++ b/src/dio-offsets.c
@@ -0,0 +1,708 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 Meta Platforms, Inc.  All Rights Reserved.
+ *
+ * Description: test direct-io memory alignment offsets
+ */
+
+#ifndef _GNU_SOURCE
+#define _GNU_SOURCE
+#endif
+
+#include <err.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <libgen.h>
+#include <limits.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <string.h>
+#include <unistd.h>
+#include <stdbool.h>
+#include <sys/stat.h>
+#include <sys/statfs.h>
+#include <sys/uio.h>
+
+#define power_of_2(x) ((x) && !((x) & ((x) - 1)))
+
+static unsigned long logical_block_size;
+static unsigned long dma_alignment;
+static unsigned long virt_boundary;
+static unsigned long max_segments;
+static unsigned long max_bytes;
+static size_t buf_size;
+static long pagesize;
+static void *out_buf;
+static void *in_buf;
+static int test_fd;
+
+static void init_args(char **argv)
+{
+        test_fd =3D open(argv[1], O_RDWR | O_CREAT | O_TRUNC | O_DIRECT)=
;
+        if (test_fd < 0)
+		err(errno, "%s: failed to open %s", __func__, argv[1]);
+
+	max_segments =3D strtoul(argv[2], NULL, 0);
+	max_bytes =3D strtoul(argv[3], NULL, 0) * 1024;
+	dma_alignment =3D strtoul(argv[4], NULL, 0) + 1;
+	virt_boundary =3D strtoul(argv[5], NULL, 0) + 1;
+	logical_block_size =3D strtoul(argv[6], NULL, 0);
+
+	if (!power_of_2(virt_boundary) ||
+	    !power_of_2(dma_alignment) ||
+	    !power_of_2(logical_block_size)) {
+		errno =3D EINVAL;
+		err(1, "%s: bad parameters", __func__);
+	}
+
+	if (virt_boundary > 1 && virt_boundary < logical_block_size) {
+		errno =3D EINVAL;
+		err(1, "%s: virt_boundary:%lu logical_block_size:%lu", __func__,
+			virt_boundary, logical_block_size);
+	}
+
+	if (dma_alignment > logical_block_size) {
+		errno =3D EINVAL;
+		err(1, "%s: dma_alignment:%lu logical_block_size:%lu", __func__,
+			dma_alignment, logical_block_size);
+	}
+
+	if (max_segments > 4096)
+		max_segments =3D 4096;
+	if (max_bytes > 16384 * 1024)
+		max_bytes =3D 16384 * 1024;
+	if (max_bytes & (logical_block_size - 1))
+		max_bytes -=3D max_bytes & (logical_block_size - 1);
+
+	pagesize =3D sysconf(_SC_PAGE_SIZE);
+}
+
+static void init_buffers()
+{
+	unsigned long lb_mask =3D logical_block_size - 1;
+	int fd, ret;
+
+	buf_size =3D max_bytes * max_segments / 2;
+	if (buf_size < logical_block_size * max_segments)
+		err(EINVAL, "%s: logical block size is too big", __func__);
+
+	if (buf_size < logical_block_size * 1024 * 4)
+		buf_size =3D logical_block_size * 1024 * 4;
+
+	if (buf_size & lb_mask)
+		buf_size =3D (buf_size + lb_mask) & ~(lb_mask);
+
+        ret =3D posix_memalign((void **)&in_buf, pagesize, buf_size);
+        if (ret)
+		err(EINVAL, "%s: failed to allocate in-buf", __func__);
+
+        ret =3D posix_memalign((void **)&out_buf, pagesize, buf_size);
+        if (ret)
+		err(EINVAL, "%s: failed to allocate out-buf", __func__);
+
+	fd =3D open("/dev/urandom", O_RDONLY);
+	if (fd < 0)
+		err(EINVAL, "%s: failed to open urandom", __func__);
+
+	ret =3D read(fd, out_buf, buf_size);
+	if (ret < 0)
+		err(EINVAL, "%s: failed to randomize output buffer", __func__);
+
+	close(fd);
+}
+
+static void __compare(void *a, void *b, size_t size, const char *test)
+{
+	if (!memcmp(a, b, size))
+		return;
+	err(EIO, "%s: data corruption", test);
+}
+#define compare(a, b, size) __compare(a, b, size, __func__)
+
+/*
+ * Test using page aligned buffers, single source
+ *
+ * Total size is aligned to a logical block size and exceeds the max tra=
nsfer
+ * size as well as the max segments. This should test the kernel's split=
 bio
+ * construction and bio splitting for exceeding these limits.
+ */
+static void test_full_size_aligned()
+{
+	int ret;
+
+	memset(in_buf, 0, buf_size);
+	ret =3D pwrite(test_fd, out_buf, buf_size, 0);
+	if (ret < 0)
+		err(errno, "%s: failed to write buf", __func__);
+
+	ret =3D pread(test_fd, in_buf, buf_size, 0);
+	if (ret < 0)
+		err(errno, "%s: failed to read buf", __func__);
+
+	compare(out_buf, in_buf, buf_size);
+}
+
+/*
+ * Test using dma aligned buffers, single source
+ *
+ * This tests the kernel's dio memory alignment
+ */
+static void test_dma_aligned()
+{
+	int ret;
+
+	memset(in_buf, 0, buf_size);
+	ret =3D pwrite(test_fd, out_buf + dma_alignment, max_bytes, 0);
+	if (ret < 0)
+		err(errno, "%s: failed to write buf", __func__);
+
+	ret =3D pread(test_fd, in_buf + dma_alignment, max_bytes, 0);
+	if (ret < 0)
+		err(errno, "%s: failed to read buf", __func__);
+
+	compare(out_buf + dma_alignment, in_buf + dma_alignment, max_bytes);
+}
+
+/*
+ * Test using page aligned buffers + logicaly block sized vectored sourc=
e
+ *
+ * This tests discontiguous vectored sources
+ */
+static void test_page_aligned_vectors()
+{
+	const int vecs =3D 4;
+
+	int i, ret, offset;
+	struct iovec iov[vecs];
+
+	memset(in_buf, 0, buf_size);
+	for (i =3D 0; i < vecs; i++) {
+		offset =3D logical_block_size * i * 4;
+		iov[i].iov_base =3D out_buf + offset;
+		iov[i].iov_len =3D logical_block_size * 2;
+	}
+
+        ret =3D pwritev(test_fd, iov, vecs, 0);
+        if (ret < 0)
+		err(errno, "%s: failed to write buf", __func__);
+
+	for (i =3D 0; i < vecs; i++) {
+		offset =3D logical_block_size * i * 4;
+		iov[i].iov_base =3D in_buf + offset;
+		iov[i].iov_len =3D logical_block_size * 2;
+	}
+
+        ret =3D preadv(test_fd, iov, vecs, 0);
+        if (ret < 0)
+		err(errno, "%s: failed to read buf", __func__);
+
+	for (i =3D 0; i < vecs; i++) {
+		offset =3D logical_block_size * i * 4;
+		compare(in_buf + offset, out_buf + offset, logical_block_size * 2);
+	}
+}
+
+/*
+ * Test using dma aligned buffers, vectored source
+ *
+ * This tests discontiguous vectored sources with incrementing dma align=
ed
+ * offsets
+ */
+static void test_dma_aligned_vectors()
+{
+	const int vecs =3D 4;
+
+	int i, ret, offset;
+	struct iovec iov[vecs];
+
+	memset(in_buf, 0, buf_size);
+	for (i =3D 0; i < vecs; i++) {
+		offset =3D logical_block_size * i * 8 + dma_alignment * (i + 1);
+		iov[i].iov_base =3D out_buf + offset;
+		iov[i].iov_len =3D logical_block_size * 2;
+	}
+
+        ret =3D pwritev(test_fd, iov, vecs, 0);
+        if (ret < 0)
+		err(errno, "%s: failed to write buf", __func__);
+
+	for (i =3D 0; i < vecs; i++) {
+		offset =3D logical_block_size * i * 8 + dma_alignment * (i + 1);
+		iov[i].iov_base =3D in_buf + offset;
+		iov[i].iov_len =3D logical_block_size * 2;
+	}
+
+        ret =3D preadv(test_fd, iov, vecs, 0);
+        if (ret < 0)
+		err(errno, "%s: failed to read buf", __func__);
+
+	for (i =3D 0; i < vecs; i++) {
+		offset =3D logical_block_size * i * 8 + dma_alignment * (i + 1);
+		compare(in_buf + offset, out_buf + offset, logical_block_size * 2);
+	}
+}
+
+/*
+ * Test vectored read with a total size aligned to a block, but some ind=
ividual
+ * vectors will not be aligned to to the block size.
+ *
+ * All the middle vectors start and end on page boundaries which should
+ * satisfy any virt_boundary condition. This test will fail prior to ker=
nel
+ * 6.18.
+ */
+static void test_unaligned_page_vectors()
+{
+	const int vecs =3D 4;
+
+	int i, ret, offset, mult;
+	struct iovec iov[vecs];
+	bool should_fail =3D true;
+
+	i =3D 0;
+	memset(in_buf, 0, buf_size);
+	mult =3D pagesize / logical_block_size;
+	if (mult < 2)
+		mult =3D 2;
+
+	offset =3D pagesize - (logical_block_size / 4);
+	if (offset & (dma_alignment - 1))
+		offset =3D pagesize - dma_alignment;
+
+	iov[i].iov_base =3D out_buf + offset;
+	iov[i].iov_len =3D pagesize - offset;
+
+	for (i =3D 1; i < vecs - 1; i++) {
+		offset =3D logical_block_size * i * 8 * mult;
+		iov[i].iov_base =3D out_buf + offset;
+		iov[i].iov_len =3D logical_block_size * mult;
+	}
+
+	offset =3D logical_block_size * i * 8 * mult;
+	iov[i].iov_base =3D out_buf + offset;
+	iov[i].iov_len =3D logical_block_size * mult - iov[0].iov_len;
+
+        ret =3D pwritev(test_fd, iov, vecs, 0);
+        if (ret < 0) {
+		if (should_fail)
+			return;
+		err(errno, "%s: failed to write buf", __func__);
+	}
+
+	i =3D 0;
+	offset =3D pagesize - (logical_block_size / 4);
+	if (offset & (dma_alignment - 1))
+		offset =3D pagesize - dma_alignment;
+
+	iov[i].iov_base =3D in_buf + offset;
+	iov[i].iov_len =3D pagesize - offset;
+
+	for (i =3D 1; i < vecs - 1; i++) {
+		offset =3D logical_block_size * i * 8 * mult;
+		iov[i].iov_base =3D in_buf + offset;
+		iov[i].iov_len =3D logical_block_size * mult;
+	}
+
+	offset =3D logical_block_size * i * 8 * mult;
+	iov[i].iov_base =3D in_buf + offset;
+	iov[i].iov_len =3D logical_block_size * mult - iov[0].iov_len;
+
+        ret =3D preadv(test_fd, iov, vecs, 0);
+        if (ret < 0)
+		err(errno, "%s: failed to read buf", __func__);
+
+	i =3D 0;
+	offset =3D pagesize - (logical_block_size / 4);
+	if (offset & (dma_alignment - 1))
+		offset =3D pagesize - dma_alignment;
+
+	compare(in_buf + offset, out_buf + offset, iov[i].iov_len);
+	for (i =3D 1; i < vecs - 1; i++) {
+		offset =3D logical_block_size * i * 8 * mult;
+		compare(in_buf + offset, out_buf + offset, iov[i].iov_len);
+	}
+	offset =3D logical_block_size * i * 8 * mult;
+	compare(in_buf + offset, out_buf + offset, iov[i].iov_len);
+}
+
+/*
+ * Total size is a logical block size multiple, but none of the vectors =
are.
+ *
+ * Total vectors will be less than the max. The vectors will be dma alig=
ned. If
+ * a virtual boundary exists, this should fail, otherwise it should succ=
ceed on
+ * kernels 6.18 and newer.
+ */
+static void test_unaligned_vectors()
+{
+	const int vecs =3D 4;
+
+	struct iovec iov[vecs];
+	int i, ret, offset;
+
+	memset(in_buf, 0, buf_size);
+	for (i =3D 0; i < vecs; i++) {
+		offset =3D logical_block_size * i * 8;
+		iov[i].iov_base =3D out_buf + offset;
+		iov[i].iov_len =3D logical_block_size / 2;
+	}
+
+        ret =3D pwritev(test_fd, iov, vecs, 0);
+        if (ret < 0)
+		return;
+
+	for (i =3D 0; i < vecs; i++) {
+		offset =3D logical_block_size * i * 8;
+		iov[i].iov_base =3D in_buf + offset;
+		iov[i].iov_len =3D logical_block_size / 2;
+	}
+
+        ret =3D preadv(test_fd, iov, vecs, 0);
+        if (ret < 0)
+		err(errno, "%s: failed to read buf", __func__);
+
+	for (i =3D 0; i < vecs; i++) {
+		offset =3D logical_block_size * i * 8;
+		compare(in_buf + offset, out_buf + offset, logical_block_size / 2);
+	}
+}
+
+/*
+ * Provide an invalid iov_base at the beginning to test the kernel catch=
ing it
+ * while building a bio.
+ */
+static void test_invalid_starting_addr()
+{
+	const int vecs =3D 4;
+
+	int i, ret, offset;
+	struct iovec iov[vecs];
+
+	i =3D 0;
+	iov[i].iov_base =3D 0;
+	iov[i].iov_len =3D logical_block_size;
+
+	for (i =3D 1; i < vecs; i++) {
+		offset =3D logical_block_size * i * 8;
+		iov[i].iov_base =3D out_buf + offset;
+		iov[i].iov_len =3D logical_block_size;
+	}
+
+        ret =3D pwritev(test_fd, iov, vecs, 0);
+        if (ret < 0)
+		return;
+
+	err(ENOTSUP, "%s: write buf unexpectedly succeeded with NULL address re=
t:%d",
+		__func__, ret);
+}
+
+/*
+ * Provide an invalid iov_base in the middle to test the kernel catching=
 it
+ * while building split bios. Ensure it is split by sending enough vecto=
rs to
+ * exceed bio's MAX_VEC; this should cause part of the io to dispatch.
+ */
+static void test_invalid_middle_addr()
+{
+	const int vecs =3D 1024;
+
+	int i, ret, offset;
+	struct iovec iov[vecs];
+
+	for (i =3D 0; i < vecs / 2 + 1; i++) {
+		offset =3D logical_block_size * i * 2;
+		iov[i].iov_base =3D out_buf + offset;
+		iov[i].iov_len =3D logical_block_size;
+	}
+
+	offset =3D logical_block_size * i * 2;
+	iov[i].iov_base =3D 0;
+	iov[i].iov_len =3D logical_block_size;
+
+	for (++i; i < vecs; i++) {
+		offset =3D logical_block_size * i * 2;
+		iov[i].iov_base =3D out_buf + offset;
+		iov[i].iov_len =3D logical_block_size;
+	}
+
+        ret =3D pwritev(test_fd, iov, vecs, 0);
+        if (ret < 0)
+		return;
+
+	err(ENOTSUP, "%s: write buf unexpectedly succeeded with NULL address re=
t:%d",
+		__func__, ret);
+}
+
+/*
+ * Test with an invalid DMA address. Should get caught early when splitt=
ing. If
+ * the device supports byte aligned memory (which is unusual), then this=
 should
+ * be successful.
+ */
+static void test_invalid_dma_alignment()
+{
+	int ret, offset;
+	size_t size;
+	bool should_fail =3D dma_alignment > 1;
+
+	memset(in_buf, 0, buf_size);
+	offset =3D 2 * dma_alignment - 1;
+	size =3D logical_block_size * 256;
+	ret =3D pwrite(test_fd, out_buf + offset, size, 0);
+	if (ret < 0) {
+		if (should_fail)
+			return;
+		err(errno, "%s: failed to write buf", __func__);
+	}
+
+	if (should_fail)
+		err(ENOTSUP, "%s: write buf unexpectedly succeeded with invalid DMA of=
fset address, ret:%d",
+			__func__, ret);
+
+	ret =3D pread(test_fd, in_buf + offset, size, 0);
+	if (ret < 0)
+		err(errno, "%s: failed to read buf", __func__);
+
+	compare(out_buf + offset, in_buf + offset, size);
+}
+
+/*
+ * Test with invalid DMA alignment in the middle. This should get split =
with
+ * the first part being dispatched, and the 2nd one failing without disp=
atch.
+ */
+static void test_invalid_dma_vector_alignment()
+{
+	const int vecs =3D 5;
+
+	bool should_fail =3D dma_alignment > 1;
+	struct iovec iov[vecs];
+	int ret, offset;
+
+	offset =3D dma_alignment * 2 - 1;
+	memset(in_buf, 0, buf_size);
+
+	iov[0].iov_base =3D out_buf;
+	iov[0].iov_len =3D max_bytes;
+
+	iov[1].iov_base =3D out_buf + max_bytes * 2;
+	iov[1].iov_len =3D max_bytes;
+
+	iov[2].iov_base =3D out_buf + max_bytes * 4 + offset;
+	iov[2].iov_len =3D max_bytes;
+
+	iov[3].iov_base =3D out_buf + max_bytes * 6;
+	iov[3].iov_len =3D max_bytes;
+
+	iov[4].iov_base =3D out_buf + max_bytes * 8;
+	iov[4].iov_len =3D max_bytes;
+
+        ret =3D pwritev(test_fd, iov, vecs, 0);
+        if (ret < 0) {
+		if (should_fail)
+			return;
+		err(errno, "%s: failed to write buf", __func__);
+	}
+	if (should_fail)
+		err(ENOTSUP, "%s: write buf unexpectedly succeeded with invalid DMA of=
fset address ret:%d",
+			__func__, ret);
+
+	iov[0].iov_base =3D in_buf;
+	iov[0].iov_len =3D max_bytes;
+
+	iov[1].iov_base =3D in_buf + max_bytes * 2;
+	iov[1].iov_len =3D max_bytes;
+
+	iov[2].iov_base =3D in_buf + max_bytes * 4 + offset;
+	iov[2].iov_len =3D max_bytes;
+
+	iov[3].iov_base =3D in_buf + max_bytes * 6;
+	iov[3].iov_len =3D max_bytes;
+
+	iov[4].iov_base =3D in_buf + max_bytes * 8;
+	iov[4].iov_len =3D max_bytes;
+
+        ret =3D preadv(test_fd, iov, vecs, 0);
+        if (ret < 0)
+		err(errno, "%s: failed to read buf", __func__);
+
+	compare(out_buf, in_buf, max_bytes);
+	compare(out_buf + max_bytes * 2, in_buf + max_bytes * 2, max_bytes);
+	compare(out_buf + max_bytes * 4 + offset, in_buf + max_bytes * 4 + offs=
et, max_bytes);
+	compare(out_buf + max_bytes * 6, in_buf + max_bytes * 6, max_bytes);
+	compare(out_buf + max_bytes * 8, in_buf + max_bytes * 8, max_bytes);
+}
+
+/*
+ * Test a bunch of small vectors if the device dma alignemnt allows it. =
We'll
+ * try to force a MAX_IOV split that can't form a valid IO so expect a f=
ailure.
+ */
+static void test_max_vector_limits()
+{
+	const int vecs =3D 320;
+
+	int ret, i, offset, iovpb, iov_size;
+	bool should_fail =3D true;
+	struct iovec iov[vecs];
+
+	memset(in_buf, 0, buf_size);
+	iovpb =3D logical_block_size / dma_alignment;
+	iov_size =3D logical_block_size / iovpb;
+
+	if ((pagesize  / iov_size) < 256 &&
+	    iov_size >=3D virt_boundary)
+		should_fail =3D false;
+
+	for (i =3D 0; i < vecs; i++) {
+		offset =3D i * iov_size * 2;
+		iov[i].iov_base =3D out_buf + offset;
+		iov[i].iov_len =3D iov_size;
+	}
+
+        ret =3D pwritev(test_fd, iov, vecs, 0);
+        if (ret < 0) {
+		if (should_fail)
+			return;
+		err(errno, "%s: failed to write buf", __func__);
+	}
+
+	if (should_fail)
+		err(ENOTSUP, "%s: write buf unexpectedly succeeded with excess vectors=
 ret:%d",
+			__func__, ret);
+
+	for (i =3D 0; i < vecs; i++) {
+		offset =3D i * iov_size * 2;
+		iov[i].iov_base =3D in_buf + offset;
+		iov[i].iov_len =3D iov_size;
+	}
+
+        ret =3D preadv(test_fd, iov, vecs, 0);
+        if (ret < 0)
+		err(errno, "%s: failed to read buf", __func__);
+
+	for (i =3D 0; i < vecs; i++) {
+		offset =3D i * iov_size * 2;
+		compare(in_buf + offset, out_buf + offset, logical_block_size / 2);
+	}
+}
+
+/*
+ * Start with a valid vector that can be split into a dispatched IO, but=
 poison
+ * the rest with an invalid DMA offset testing the kernel's late catch.
+ */
+static void test_invalid_dma_vector_alignment_large()
+{
+	const int vecs =3D 4;
+
+	struct iovec iov[vecs];
+	int i, ret;
+
+	i =3D 0;
+	iov[i].iov_base =3D out_buf;
+	iov[i].iov_len =3D max_bytes - logical_block_size;
+
+	i++;
+	iov[i].iov_base =3D out_buf + max_bytes + logical_block_size;
+	iov[i].iov_len =3D logical_block_size;
+
+	i++;
+	iov[i].iov_base =3D iov[1].iov_base + pagesize * 2 + (dma_alignment - 1=
);
+	iov[i].iov_len =3D logical_block_size;
+
+	i++;
+	iov[i].iov_base =3D out_buf + max_bytes * 8;
+	iov[i].iov_len =3D logical_block_size;
+
+        ret =3D pwritev(test_fd, iov, vecs, 0);
+        if (ret < 0)
+		return;
+
+	err(ENOTSUP, "%s: write buf unexpectedly succeeded with NULL address re=
t:%d",
+		__func__, ret);
+}
+
+/*
+ * Total size is block aligned, addresses are dma aligned, but invidual =
vector
+ * sizes may not be dma aligned. If device has byte sized dma alignment,=
 this
+ * should succeed. If not, part of this should get dispatched, and the o=
ther
+ * part should fail.
+ */
+static void test_invalid_dma_vector_length()
+{
+	const int vecs =3D 4;
+
+	bool should_fail =3D dma_alignment > 1;
+	struct iovec iov[vecs];
+	int ret;
+
+	iov[0].iov_base =3D out_buf;
+	iov[0].iov_len =3D max_bytes * 2 - max_bytes / 2;
+
+	iov[1].iov_base =3D out_buf + max_bytes * 4;
+	iov[1].iov_len =3D logical_block_size * 2 - (dma_alignment + 1);
+
+	iov[2].iov_base =3D out_buf + max_bytes * 8;
+	iov[2].iov_len =3D logical_block_size * 2 + (dma_alignment + 1);
+
+	iov[3].iov_base =3D out_buf + max_bytes * 12;
+	iov[3].iov_len =3D max_bytes - max_bytes / 2;
+
+        ret =3D pwritev(test_fd, iov, vecs, 0);
+        if (ret < 0) {
+		if (should_fail)
+			return;
+		err(errno, "%s: failed to write buf", __func__);
+	}
+
+	if (should_fail)
+		err(ENOTSUP, "%s: write buf unexpectedly succeeded with invalid DMA of=
fset address ret:%d",
+			__func__, ret);
+
+	iov[0].iov_base =3D in_buf;
+	iov[0].iov_len =3D max_bytes * 2 - max_bytes / 2;
+
+	iov[1].iov_base =3D in_buf + max_bytes * 4;
+	iov[1].iov_len =3D logical_block_size * 2 - (dma_alignment + 1);
+
+	iov[2].iov_base =3D in_buf + max_bytes * 8;
+	iov[2].iov_len =3D logical_block_size * 2 + (dma_alignment + 1);
+
+	iov[3].iov_base =3D in_buf + max_bytes * 12;
+	iov[3].iov_len =3D max_bytes - max_bytes / 2;
+
+        ret =3D pwritev(test_fd, iov, vecs, 0);
+        if (ret < 0)
+		err(errno, "%s: failed to read buf", __func__);
+
+	compare(out_buf, in_buf, iov[0].iov_len);
+	compare(out_buf + max_bytes * 4, in_buf + max_bytes * 4, iov[1].iov_len=
);
+	compare(out_buf + max_bytes * 8, in_buf + max_bytes * 8, iov[2].iov_len=
);
+	compare(out_buf + max_bytes * 12, in_buf + max_bytes * 12, iov[3].iov_l=
en);
+}
+
+static void run_tests()
+{
+	test_full_size_aligned();
+	test_dma_aligned();
+	test_page_aligned_vectors();
+	test_dma_aligned_vectors();
+	test_unaligned_page_vectors();
+	test_unaligned_vectors();
+	test_invalid_starting_addr();
+	test_invalid_middle_addr();
+	test_invalid_dma_alignment();
+	test_invalid_dma_vector_alignment();
+	test_max_vector_limits();
+	test_invalid_dma_vector_alignment_large();
+	test_invalid_dma_vector_length();
+}
+
+/* ./$prog-name file */
+int main(int argc, char **argv)
+{
+        if (argc < 2)
+                errx(EINVAL, "expect argments: file");
+
+	init_args(argv);
+	init_buffers();
+	run_tests();
+	close(test_fd);
+	free(out_buf);
+	free(in_buf);
+
+	return 0;
diff --git a/tests/block/042 b/tests/block/042
new file mode 100644
index 0000000..a911d82
--- /dev/null
+++ b/tests/block/042
@@ -0,0 +1,26 @@
+#!/bin/bash
+
+. tests/block/rc
+
+DESCRIPTION=3D"Test unusual direct-io offsets"
+QUICK=3D1
+
+device_requires() {
+        _require_test_dev_sysfs
+}
+
+test_device() {
+	echo "Running ${TEST_NAME}"
+
+	sys_max_segments=3D$(cat "${TEST_DEV_SYSFS}/queue/max_segments")
+	sys_dma_alignment=3D$(cat "${TEST_DEV_SYSFS}/queue/dma_alignment")
+	sys_virt_boundary_mask=3D$(cat "${TEST_DEV_SYSFS}/queue/virt_boundary_m=
ask")
+	sys_logical_block_size=3D$(cat "${TEST_DEV_SYSFS}/queue/logical_block_s=
ize")
+	sys_max_sectors_kb=3D$(cat "${TEST_DEV_SYSFS}/queue/max_sectors_kb")
+
+	if ! src/dio-offsets ${TEST_DEV} $sys_max_segments $sys_max_sectors_kb =
$sys_dma_alignment $sys_virt_boundary_mask $sys_logical_block_size; then
+		echo "src/dio-offsets failed"
+	fi
+
+	echo "Test complete"
+}
diff --git a/tests/block/042.out b/tests/block/042.out
new file mode 100644
index 0000000..b35c7ce
--- /dev/null
+++ b/tests/block/042.out
@@ -0,0 +1,2 @@
+Running block/042
+Test complete
--=20
2.47.3

