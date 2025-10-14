Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B97C2EFDA2
	for <linux-block@vger.kernel.org>; Tue, 14 Oct 2025 20:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760475270; cv=none; b=BToDYYjkqnl/fOCswuRQ30PHIk0I/ba+ht4QYM/qT6aSeIGiJGsY5ywoI1dphIyFWbC621YDRds9IGxxHg4OG4D8QzzlS5pf6IP5hl5Den2+mfZKCGsJYgMlQIsXWwwu0Y8KJltAA/oWgLHW0NiaUFmXf0eySXj3706/VmCkTa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760475270; c=relaxed/simple;
	bh=9UDdYmu78pymCopZX5GUa1gbACoq/Wf4nvxRukkVRP0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qWc7Hg/vunEOytgCQXoj9O5SMq2uQEMPqu2i5wVCo2IpA3Rn9f4uFN4JfH6/9jDtzuYZfYx8aIkKfsp4Cxq+DFGRv8gyL9irpAPpbyEtU2+YkSO+0GfGWzX2tOvpgzu+4fsmGDfhx+lY+SXbvC5yV7QEVpXtbMmhcR4Eu1D+Chc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=cbV2osAB; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="cbV2osAB"
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59EHMH6c3684087
	for <linux-block@vger.kernel.org>; Tue, 14 Oct 2025 13:54:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=dwNjWkCb0H6cf7GbQc
	xNarnMGjmWoV/zVqQp7ph99mA=; b=cbV2osABWVRFtS5pSySonPFzs/V8inAd8V
	0uHnwmt9j3gdH+TkNlLQis1lxXaQCm42mVUv7jSS/mxWOalTMuIOVFUY3PGA+OBz
	7/8mto+wfHs83h6J4A7Xm85nlwsMuSF4G0op94EZzsOZvn2d6pp4wMxTHenl+/B4
	b14NZyFJ3eOyiGp9kcyRIPKeGfNRPAVY+XxMAbMxbaRws3JX0aDTL55UYgj5xPWN
	n1z+dkJvWyhRPfMMy0Opom2mD+eBlS0aFLtfVpXs7nYcd2CYrL8NToJTiT+u4rS/
	y6+6XTGo7Y10lFN61DXRKEacgFtyJNGBL9UARw4Irbo4oBoCo46Q==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 49stuwa0k6-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Tue, 14 Oct 2025 13:54:26 -0700 (PDT)
Received: from twshared28390.17.frc2.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.20; Tue, 14 Oct 2025 20:54:25 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id F384E2B5AA03; Tue, 14 Oct 2025 13:54:21 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <shinichiro.kawasaki@wdc.com>
CC: Keith Busch <kbusch@kernel.org>
Subject: [PATCH blktests] create a test for direct io offsets
Date: Tue, 14 Oct 2025 13:54:20 -0700
Message-ID: <20251014205420.941424-1-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=BK6+bVQG c=1 sm=1 tr=0 ts=68eeb882 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8
 a=paeA-XSnAucybtUitt4A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE0MDE0NCBTYWx0ZWRfX5trdTT9ZkPiK
 vKN7tSSYyfXwXnGo/UU08bQO8wJgzyzpv9jh05+mM+JNXUQn0B+gBCMyYA4wbgV+fbVP1OPLsSZ
 b86cIDYO3ckD0eWjlugY6k/CkCDlRlWu3AbA7t4LIvXCPgDdaiKOIRaTCOm3aB5jF+zZOOIVy2b
 eGuVgFBDBPcRruMOlfJkTeLSBA/G6skcOpB6wm2oPUsI//BkPOovFCmVeAKD13RBe0zvC057QBr
 P9nc+/taXqYS0Evn0Zsh3fWsDzxrw/29IcSKC1skAvn60kzCZQYQzs12FpHWEvu8O3twmvb8u60
 ipl+E6TeGgXwY1QOnw4GSmmDkjtulwQ/cP0Y0y61x/Ulxd+KLGafkwrlfc3oqZ/glxRlUQJ54tY
 IeBh2kcE+udxIrPbq+id869ls9dGGg==
X-Proofpoint-GUID: -PTlDsGbI_HXb547NxxjjJ1Wluzqlp1f
X-Proofpoint-ORIG-GUID: -PTlDsGbI_HXb547NxxjjJ1Wluzqlp1f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_04,2025-10-13_01,2025-03-28_01

From: Keith Busch <kbusch@kernel.org>

Tests direct IO using various memory and length alignments against the
device's queue limits.

This should work on raw block devices, their partitions, or through
files on mounted filesystems. Much of the code is dedicated to
automatically finding the underlying block device's queue limits so that
it can work in a variety of environments.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 src/.gitignore      |   1 +
 src/Makefile        |   1 +
 src/dio-offsets.c   | 952 ++++++++++++++++++++++++++++++++++++++++++++
 tests/block/042     |  20 +
 tests/block/042.out |   2 +
 5 files changed, 976 insertions(+)
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
index 0000000..5961232
--- /dev/null
+++ b/src/dio-offsets.c
@@ -0,0 +1,952 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 Meta Platforms, Inc.  All Rights Reserved.
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
+#include <mntent.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <string.h>
+#include <unistd.h>
+#include <stdbool.h>
+
+#include <sys/stat.h>
+#include <sys/statfs.h>
+#include <sys/sysmacros.h>
+#include <sys/uio.h>
+#include <sys/utsname.h>
+
+#define power_of_2(x) ((x) && !((x) & ((x) - 1)))
+
+static unsigned long logical_block_size;
+static unsigned long dma_alignment;
+static unsigned long virt_boundary;
+static unsigned long max_segments;
+static unsigned long max_bytes;
+static int kernel_major;
+static int kernel_minor;
+static size_t buf_size;
+static long pagesize;
+static void *out_buf;
+static void *in_buf;
+static int test_fd;
+
+static void init_kernel_version()
+{
+	struct utsname buffer;
+	char *major_version_str;
+	char *minor_version_str;
+	if (uname(&buffer) !=3D 0)
+		err(errno, "uname");
+
+	major_version_str =3D strtok(buffer.release, ".");
+	minor_version_str =3D strtok(NULL, ".");
+
+	kernel_major =3D strtol(major_version_str, NULL, 0);
+	kernel_minor =3D strtol(minor_version_str, NULL, 0);
+}
+
+static void find_mount_point(const char *filepath, char *mount_point,
+			     size_t mp_len)
+{
+	char path[PATH_MAX - 1], abs_path[PATH_MAX], *pos;
+	struct stat file_stat, mp_stat, parent_stat;
+
+	if (stat(filepath, &file_stat) !=3D 0)
+		err(errno, "stat");
+
+	strncpy(path, filepath, sizeof(path) - 1);
+	path[sizeof(path) - 1] =3D '\0';
+	if (realpath(path, abs_path) =3D=3D NULL)
+		err(ENOENT, "realpath");
+
+	strncpy(path, abs_path, sizeof(path) - 1);
+	path[sizeof(path) - 1] =3D '\0';
+	while (1) {
+		if (stat(path, &mp_stat))
+			err(errno, "stat on path");
+
+		pos =3D strrchr(path, '/');
+		if (pos =3D=3D path) {
+			strcpy(path, "/");
+			break;
+		}
+
+		if (pos =3D=3D NULL)
+			break;
+
+		*pos =3D '\0';
+		if (path[0] =3D=3D '\0')
+			strcpy(path, "/");
+
+		if (stat(path, &parent_stat))
+			err(errno, "stat on parent");
+
+		if (parent_stat.st_dev !=3D mp_stat.st_dev) {
+			*pos =3D '/';
+			break;
+		}
+	}
+
+	strncpy(mount_point, path, mp_len - 1);
+	mount_point[mp_len - 1] =3D '\0';
+}
+
+static void find_block_device_from_mount(const char *mount_point, char *=
block_dev,
+					 size_t bd_len)
+{
+	struct mntent *ent;
+	FILE *mounts;
+
+	mounts =3D setmntent("/proc/mounts", "r");
+	if (!mounts)
+		err(ENOENT, "setmntent");
+
+	while ((ent =3D getmntent(mounts)) !=3D NULL) {
+		if (strcmp(ent->mnt_dir, mount_point) =3D=3D 0) {
+			strncpy(block_dev, ent->mnt_fsname, bd_len - 1);
+			block_dev[bd_len - 1] =3D '\0';
+			endmntent(mounts);
+			return;
+		}
+	}
+
+	endmntent(mounts);
+	err(ENOENT, "%s: not found", __func__);
+}
+
+static void resolve_to_sysblock(const char *dev_path, char *path, size_t=
 path_len)
+{
+	char resolved[PATH_MAX], class[PATH_MAX], target[PATH_MAX], base[256];
+	char *dev_name, *p, *slash, *block_pos;
+	struct stat st;
+	size_t len;
+
+	if (realpath(dev_path, resolved) !=3D NULL)
+		dev_path =3D resolved;
+
+	dev_name =3D strrchr(dev_path, '/');
+	if (dev_name)
+		dev_name++;
+	else
+		dev_name =3D (char *)dev_path;
+
+	strncpy(base, dev_name, sizeof(base) - 1);
+	base[sizeof(base) - 1] =3D '\0';
+
+	len =3D strlen(base);
+	p =3D base + len - 1;
+	while (p > base && *p >=3D '0' && *p <=3D '9')
+		p--;
+
+	if (p > base && *p =3D=3D 'p' && *(p + 1) !=3D '\0')
+		*p =3D '\0';
+	else if (len >=3D 4 && p > base && p < base + len - 1) {
+		if ((strncmp(base, "sd", 2) =3D=3D 0 ||
+		     strncmp(base, "hd", 2) =3D=3D 0 ||
+		     strncmp(base, "vd", 2) =3D=3D 0) &&
+		     (*p >=3D 'a' && *p <=3D 'z'))
+			*(p + 1) =3D '\0';
+	}
+
+	if (snprintf(path, path_len, "/sys/block/%s/queue", base) < 0)
+		err(errno, "base too long");
+	if (stat(path, &st) =3D=3D 0 && S_ISDIR(st.st_mode))
+		return;
+
+	if (snprintf(class, sizeof(class), "/sys/class/block/%s", dev_name) < 0=
)
+		err(errno, "class too long");
+	if (stat(class, &st) =3D=3D 0) {
+		len =3D readlink(class, target, sizeof(target) - 1);
+		if (len !=3D -1) {
+			target[len] =3D '\0';
+			block_pos =3D strstr(target, "/block/");
+			if (block_pos) {
+				block_pos +=3D 7;
+				slash =3D strchr(block_pos, '/');
+				if (slash) {
+					len =3D slash - block_pos;
+					if (len < sizeof(base)) {
+						strncpy(base, block_pos, len);
+						base[len] =3D '\0';
+						snprintf(path, path_len,
+							 "/sys/block/%s/queue", base);
+						if (stat(path, &st) =3D=3D 0 &&
+						    S_ISDIR(st.st_mode))
+							return;
+					}
+				} else {
+					snprintf(path, path_len,
+						 "/sys/block/%s/queue", block_pos);
+					if (stat(path, &st) =3D=3D 0 &&
+					    S_ISDIR(st.st_mode)) {
+						return;
+					}
+				}
+			}
+		}
+	}
+
+	if (strncmp(dev_name, "dm-", 3) =3D=3D 0) {
+		if (snprintf(path, path_len, "/sys/block/%s/queue", dev_name) < 0)
+			err(errno, "%s", dev_name);
+		if (stat(path, &st) =3D=3D 0 && S_ISDIR(st.st_mode))
+			return;
+	}
+
+	err(ENOENT, "%s: not found", dev_name);
+}
+
+static void find_block_device(const char *filepath, char *path, size_t p=
ath_len)
+{
+	char mount_point[PATH_MAX], block_dev[PATH_MAX];
+	struct stat st;
+
+	if (stat(filepath, &st) =3D=3D 0 && S_ISBLK(st.st_mode)) {
+		resolve_to_sysblock(filepath, path, path_len);
+		return;
+	}
+
+	find_mount_point(filepath, mount_point, sizeof(mount_point));
+	find_block_device_from_mount(mount_point, block_dev, sizeof(block_dev))=
;
+	resolve_to_sysblock(block_dev, path, path_len);
+}
+
+static void read_sysfs_attr(char *path, unsigned long *value)
+{
+	FILE *f;
+	int ret;
+
+	f =3D fopen(path, "r");
+	if (!f)
+		err(ENOENT, "%s", path);
+
+	ret =3D fscanf(f, "%lu", value);
+	fclose(f);
+	if (ret !=3D 1)
+		err(ENOENT, "%s", basename(path));
+}
+
+static void read_queue_attrs(const char *path)
+{
+	char attr[PATH_MAX];
+
+	if (snprintf(attr, sizeof(attr), "%s/max_segments", path) < 0)
+		err(errno, "max_segments");
+	read_sysfs_attr(attr, &max_segments);
+
+	if (snprintf(attr, sizeof(attr), "%s/dma_alignment", path) < 0)
+		err(errno, "dma_alignment");
+	read_sysfs_attr(attr, &dma_alignment);
+
+	if (snprintf(attr, sizeof(attr), "%s/virt_boundary_mask", path) < 0)
+		err(errno, "virt_boundary_mask");
+	read_sysfs_attr(attr, &virt_boundary);
+
+	if (snprintf(attr, sizeof(attr), "%s/logical_block_size", path) < 0)
+		err(errno, "logical_block_size");
+	read_sysfs_attr(attr, &logical_block_size);
+
+	if (snprintf(attr, sizeof(attr), "%s/max_sectors_kb", path) < 0)
+		err(errno, "max_sectors_kb");
+	read_sysfs_attr(attr, &max_bytes);
+
+	max_bytes *=3D 1024;
+	dma_alignment++;
+	virt_boundary++;
+
+	/*
+	printf("logical_block_size:%lu dma_alignment:%lu virt_boundary:%lu max_=
segments:%lu max_bytes:%lu\n",
+		logical_block_size, dma_alignment, virt_boundary, max_segments, max_by=
tes);
+	*/
+}
+
+static void init_args(char **argv)
+{
+	char sys_path[PATH_MAX];
+
+        test_fd =3D open(argv[1], O_RDWR | O_CREAT | O_TRUNC | O_DIRECT)=
;
+        if (test_fd < 0)
+		err(errno, "%s: failed to open %s", __func__, argv[1]);
+
+	init_kernel_version();
+	find_block_device(argv[1], sys_path, sizeof(sys_path));
+	read_queue_attrs(sys_path);
+
+	if (!power_of_2(virt_boundary) ||
+	    !power_of_2(dma_alignment) ||
+	    !power_of_2(logical_block_size))
+		err(EINVAL, "%s: bad parameters", __func__);
+
+	if (virt_boundary > 1 && virt_boundary < logical_block_size)
+		err(EINVAL, "%s: virt_boundary:%lu logical_block_size:%lu", __func__,
+			virt_boundary, logical_block_size);
+
+	if (dma_alignment > logical_block_size)
+		err(EINVAL, "%s: dma_alignment:%lu logical_block_size:%lu", __func__,
+			dma_alignment, logical_block_size);
+
+	if (max_segments > 4096)
+		max_segments =3D 4096;
+	if (max_bytes > 16384 * 1024)
+		max_bytes =3D 16384 * 1024;
+	if (max_bytes & (logical_block_size - 1))
+		max_bytes -=3D max_bytes & (logical_block_size - 1);
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
+	if (kernel_major > 6 || (kernel_major =3D=3D 6 && kernel_minor >=3D 18)=
)
+		should_fail =3D false;
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
+	bool should_fail =3D true;
+	struct iovec iov[vecs];
+	int i, ret, offset;
+
+	if ((kernel_major > 6 || (kernel_major =3D=3D 6 && kernel_minor >=3D 18=
)) &&
+	    virt_boundary <=3D 1)
+		should_fail =3D false;
+
+	memset(in_buf, 0, buf_size);
+	for (i =3D 0; i < vecs; i++) {
+		offset =3D logical_block_size * i * 8;
+		iov[i].iov_base =3D out_buf + offset;
+		iov[i].iov_len =3D logical_block_size / 2;
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
+		err(ENOTSUP, "%s: write buf unexpectedly succeeded ret:%d",
+			__func__, ret);
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
+}
+
diff --git a/tests/block/042 b/tests/block/042
new file mode 100644
index 0000000..9c05643
--- /dev/null
+++ b/tests/block/042
@@ -0,0 +1,20 @@
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
+	if ! src/dio-offsets ${TEST_DEV}; then
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

