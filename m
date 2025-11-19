Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE49366DDA
	for <linux-block@vger.kernel.org>; Wed, 19 Nov 2025 19:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763582107; cv=none; b=Pv/mWYBpPhgD6OMebq2WXf6ou2gSK7wpVLr3wjBFelIohi++dQeuZp46lDUFx6tEZoMsZzzS/7mLnwAbbm5ZOGm8p/TJtWsNbOGfa7cn0mToO8GhxRwinpHZagt3fXJXiSTzAGrvIlZ+IrZ43b/KZK7oI8V/75BPySr1Rt9ma0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763582107; c=relaxed/simple;
	bh=AgCMP7CepdQ3MIFxctHrXbCq5iyTm8FhpjPuQDLC35U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TLKnFsYWY+wo9klkai4OxTDtO1KoGYxU0Hc+bg2WsTfKF4Dt9NqNsfDK/DuvsJpzkhHJrf0oWQ9ocD0wwoLjfYprteRvh2YYtjDww+P0CVC6StDeH3zFWAnG/cxkVyNUxLWWsOh9fjwWFIzo0oE8ytDAXfQI7adcstJbHyy4eqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=M9ylzMKO; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="M9ylzMKO"
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AJIj5DH1987960
	for <linux-block@vger.kernel.org>; Wed, 19 Nov 2025 11:55:03 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=c4A669Gh3LRTMr9hxqc46w7TEnhC5EAZEpAAkMYqaAs=; b=M9ylzMKOi+AV
	tecNgZXNVqgTOfrCE+BGtdlyuJiuT/K37xoCBJhtR6fVfj8XbetrqtOm2rcObvA6
	6dsSruS5OZrxViHwF7syGg9oCj0JhObXpZSpL50LW3YWFTmSVihb6aa8vv/qbH4d
	S4I5e4aUdYGQFMs3GhciGKiUXwErMFCu/LNVAXpi1LVzKNxoREJUX/zYCKoZW2Z/
	rI7mgDmmF3qCMtW7Y276kdoi0j3bq6tEl/W6jdLgmVwog7n+WsV/DC11gnaNcOOe
	1SWIkn7MywZ71m0F8WfLCIfrQxlbrNMDNOgmsBTs+k0ArdM1+rxdJfvbj1x3To53
	L40fJjQAQw==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4ahdv0buj5-14
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Wed, 19 Nov 2025 11:55:02 -0800 (PST)
Received: from twshared22076.03.snb1.facebook.com (2620:10d:c0a8:fe::f072) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Wed, 19 Nov 2025 19:55:00 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id D65963F346F5; Wed, 19 Nov 2025 11:54:50 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <shinichiro.kawasaki@wdc.com>
CC: <chaitanyak@nvidia.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv2 2/2] blktests: test io_uring user metadata offsets
Date: Wed, 19 Nov 2025 11:54:49 -0800
Message-ID: <20251119195449.2922332-3-kbusch@meta.com>
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
X-Authority-Analysis: v=2.4 cv=F4pat6hN c=1 sm=1 tr=0 ts=691e2096 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8
 a=nizH3irr9US3bCsSST4A:9
X-Proofpoint-GUID: NLo7D4GD11ftr0koFnYwy27WlF6CMuHS
X-Proofpoint-ORIG-GUID: NLo7D4GD11ftr0koFnYwy27WlF6CMuHS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE5MDE1NiBTYWx0ZWRfX15BJ6ic1NSlH
 VlaC1nwpmcLiJNpOkT+cBE4GvzggEpg8i8LBv33JZFsGvW+rSFrTU73j6CVB3orlwRNUYrtdt5h
 Tf35D/c5IdwOF7PeF7TlI2aYa+19SSsYTv+5OEMKny9efLBMm6DJ4lLTiei+qJz4tKNLiIWm9qt
 IKfA4kldMoF1Bq6YyO76gzRatC4AGiAgcU08Pu76tC3t8TFOm6xO5V8niuGsDPwHcMvF6IJlfY9
 eJh82TYlNOe/lwXm6bs2HOKjzBLvhKy6GSwEzu3ZoDb+uKBQdCFtZ4H5+C8DxvKnixKFP8mGbIW
 EojcN9ZsqZxGOepxzNxZiIImh6L9d6BSemHqidfWvM2P0MSnqXi4iMCpT7J2FA9JhCo5Me9EXme
 4kxFbf3Phu9QXXCaDmQWvWo8vuxd7g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-19_05,2025-11-18_02,2025-10-01_01

From: Keith Busch <kbusch@kernel.org>

For devices with metadata, tests various userspace offsets with
io_uring capabilities. If the metadata is formatted with ref tag
protection information, test various seed offsets as well.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 src/.gitignore      |   1 +
 src/Makefile        |  16 +-
 src/metadata.c      | 488 ++++++++++++++++++++++++++++++++++++++++++++
 tests/block/043     |  33 +++
 tests/block/043.out |   2 +
 5 files changed, 532 insertions(+), 8 deletions(-)
 create mode 100644 src/metadata.c
 create mode 100755 tests/block/043
 create mode 100644 tests/block/043.out

diff --git a/src/.gitignore b/src/.gitignore
index 865675c..e6c6c38 100644
--- a/src/.gitignore
+++ b/src/.gitignore
@@ -3,6 +3,7 @@
 /loblksize
 /loop_change_fd
 /loop_get_status_null
+/metadata
 /mount_clear_sock
 /nbdsetsize
 /openclose
diff --git a/src/Makefile b/src/Makefile
index 179a673..dac07c7 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -22,7 +22,8 @@ C_TARGETS :=3D \
 	sg/syzkaller1 \
 	zbdioctl
=20
-C_MINIUBLK :=3D miniublk
+C_URING_TARGETS :=3D miniublk \
+		metadata
=20
 HAVE_LIBURING :=3D $(call HAVE_C_MACRO,liburing.h,IORING_OP_URING_CMD)
 HAVE_UBLK_HEADER :=3D $(call HAVE_C_HEADER,linux/ublk_cmd.h,1)
@@ -31,9 +32,9 @@ CXX_TARGETS :=3D \
 	discontiguous-io
=20
 ifeq ($(HAVE_LIBURING)$(HAVE_UBLK_HEADER), 11)
-TARGETS :=3D $(C_TARGETS) $(CXX_TARGETS) $(C_MINIUBLK)
+TARGETS :=3D $(C_TARGETS) $(CXX_TARGETS) $(C_URING_TARGETS)
 else
-$(info Skip $(C_MINIUBLK) build due to missing kernel header(v6.0+) or l=
iburing(2.2+))
+$(info Skip $(C_URING_TARGETS) build due to missing kernel header(v6.0+)=
 or liburing(2.2+))
 TARGETS :=3D $(C_TARGETS) $(CXX_TARGETS)
 endif
=20
@@ -42,8 +43,8 @@ CONFIG_DEFS :=3D $(call HAVE_C_HEADER,linux/blkzoned.h,=
-DHAVE_LINUX_BLKZONED_H)
 override CFLAGS   :=3D -O2 -Wall -Wshadow $(CFLAGS) $(CONFIG_DEFS)
 override CXXFLAGS :=3D -O2 -std=3Dc++11 -Wall -Wextra -Wshadow -Wno-sign=
-compare \
 		     -Werror $(CXXFLAGS) $(CONFIG_DEFS)
-MINIUBLK_FLAGS :=3D  -D_GNU_SOURCE
-MINIUBLK_LIBS :=3D -lpthread -luring
+URING_FLAGS :=3D  -D_GNU_SOURCE
+URING_LIBS :=3D -lpthread -luring
 LDFLAGS ?=3D
=20
 all: $(TARGETS)
@@ -61,8 +62,7 @@ $(C_TARGETS): %: %.c
 $(CXX_TARGETS): %: %.cpp
 	$(CXX) $(CPPFLAGS) $(CXXFLAGS) $(LDFLAGS) -o $@ $^
=20
-$(C_MINIUBLK): %: miniublk.c
-	$(CC) $(CFLAGS) $(LDFLAGS) $(MINIUBLK_FLAGS) -o $@ miniublk.c \
-		$(MINIUBLK_LIBS)
+$(C_URING_TARGETS): %: %.c
+	$(CC) $(CFLAGS) $(LDFLAGS) $(URING_FLAGS) -o $@ $^ $(URING_LIBS)
=20
 .PHONY: all clean install
diff --git a/src/metadata.c b/src/metadata.c
new file mode 100644
index 0000000..d935fd6
--- /dev/null
+++ b/src/metadata.c
@@ -0,0 +1,488 @@
+// SPDX-License-Identifier: GPL-3.0+
+/*
+ * Copyright (c) 2025 Meta Platforms, Inc.  All Rights Reserved.
+ *
+ * Description: test userspace metadata
+ */
+
+#ifndef _GNU_SOURCE
+#define _GNU_SOURCE
+#endif
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <errno.h>
+#include <sys/ioctl.h>
+#include <linux/fs.h>
+#include <liburing.h>
+
+#ifndef IORING_RW_ATTR_FLAG_PI
+#define PI_URING_COMPAT
+#define IORING_RW_ATTR_FLAG_PI  (1U << 0)
+/* PI attribute information */
+struct io_uring_attr_pi {
+	__u16   flags;
+	__u16   app_tag;
+	__u32   len;
+	__u64   addr;
+	__u64   seed;
+	__u64   rsvd;
+};
+#endif
+
+#ifndef FS_IOC_GETLBMD_CAP
+/* Protection info capability flags */
+#define LBMD_PI_CAP_INTEGRITY           (1 << 0)
+#define LBMD_PI_CAP_REFTAG              (1 << 1)
+
+/* Checksum types for Protection Information */
+#define LBMD_PI_CSUM_NONE               0
+#define LBMD_PI_CSUM_IP                 1
+#define LBMD_PI_CSUM_CRC16_T10DIF       2
+#define LBMD_PI_CSUM_CRC64_NVME         4
+
+/*
+ * Logical block metadata capability descriptor
+ * If the device does not support metadata, all the fields will be zero.
+ * Applications must check lbmd_flags to determine whether metadata is
+ * supported or not.
+ */
+struct logical_block_metadata_cap {
+	/* Bitmask of logical block metadata capability flags */
+	__u32	lbmd_flags;
+	/*
+	 * The amount of data described by each unit of logical block
+	 * metadata
+	 */
+	__u16	lbmd_interval;
+	/*
+	 * Size in bytes of the logical block metadata associated with each
+	 * interval
+	 */
+	__u8	lbmd_size;
+	/*
+	 * Size in bytes of the opaque block tag associated with each
+	 * interval
+	 */
+	__u8	lbmd_opaque_size;
+	/*
+	 * Offset in bytes of the opaque block tag within the logical block
+	 * metadata
+	 */
+	__u8	lbmd_opaque_offset;
+	/* Size in bytes of the T10 PI tuple associated with each interval */
+	__u8	lbmd_pi_size;
+	/* Offset in bytes of T10 PI tuple within the logical block metadata */
+	__u8	lbmd_pi_offset;
+	/* T10 PI guard tag type */
+	__u8	lbmd_guard_tag_type;
+	/* Size in bytes of the T10 PI application tag */
+	__u8	lbmd_app_tag_size;
+	/* Size in bytes of the T10 PI reference tag */
+	__u8	lbmd_ref_tag_size;
+	/* Size in bytes of the T10 PI storage tag */
+	__u8	lbmd_storage_tag_size;
+	__u8	pad;
+};
+
+#define FS_IOC_GETLBMD_CAP                      _IOWR(0x15, 2, struct lo=
gical_block_metadata_cap)
+#endif /* FS_IOC_GETLBMD_CAP */
+
+#ifndef IO_INTEGRITY_CHK_GUARD
+/* flags for integrity meta */
+#define IO_INTEGRITY_CHK_GUARD          (1U << 0) /* enforce guard check=
 */
+#define IO_INTEGRITY_CHK_REFTAG         (1U << 1) /* enforce ref check *=
/
+#define IO_INTEGRITY_CHK_APPTAG         (1U << 2) /* enforce app check *=
/
+#endif /* IO_INTEGRITY_CHK_GUARD */
+
+/* This size should guarantee at least one split */
+#define DATA_SIZE (8 * 1024 * 1024)
+
+static unsigned short lba_size;
+static unsigned char metadata_size;
+static unsigned char pi_size;
+static unsigned char pi_offset;
+static bool reftag_enabled;
+
+static long pagesize;
+
+struct t10_pi_tuple {
+        __be16 guard_tag;       /* Checksum */
+        __be16 app_tag;         /* Opaque storage */
+        __be32 ref_tag;         /* Target LBA or indirect LBA */
+};
+
+struct crc64_pi_tuple {
+        __be64 guard_tag;
+        __be16 app_tag;
+        __u8   ref_tag[6];
+};
+
+static int init_capabilities(int fd)
+{
+	struct logical_block_metadata_cap md_cap;
+	int ret;
+
+	ret =3D ioctl(fd, FS_IOC_GETLBMD_CAP, &md_cap);
+	if (ret < 0) {
+		perror("FS_IOC_GETLBMD_CAP");
+		return ret;
+	}
+
+	lba_size =3D md_cap.lbmd_interval;
+	metadata_size =3D md_cap.lbmd_size;
+	pi_size =3D md_cap.lbmd_pi_size;
+	pi_offset =3D md_cap.lbmd_pi_offset;
+	reftag_enabled =3D md_cap.lbmd_flags & LBMD_PI_CAP_REFTAG;
+
+	pagesize =3D sysconf(_SC_PAGE_SIZE);
+	return 0;
+}
+
+static unsigned int swap(unsigned int value)
+{
+	return ((value >> 24) & 0x000000ff) |
+		((value >> 8)  & 0x0000ff00) |
+		((value << 8)  & 0x00ff0000) |
+		((value << 24) & 0xff000000);
+}
+
+static inline void __put_unaligned_be48(const __u64 val, __u8 *p)
+{
+	*p++ =3D (val >> 40) & 0xff;
+	*p++ =3D (val >> 32) & 0xff;
+	*p++ =3D (val >> 24) & 0xff;
+	*p++ =3D (val >> 16) & 0xff;
+	*p++ =3D (val >> 8) & 0xff;
+	*p++ =3D val & 0xff;
+}
+
+static inline void put_unaligned_be48(const __u64 val, void *p)
+{
+	__put_unaligned_be48(val, p);
+}
+
+static inline __u64 __get_unaligned_be48(const __u8 *p)
+{
+	return (__u64)p[0] << 40 | (__u64)p[1] << 32 | (__u64)p[2] << 24 |
+		p[3] << 16 | p[4] << 8 | p[5];
+}
+
+static inline __u64 get_unaligned_be48(const void *p)
+{
+	return __get_unaligned_be48(p);
+}
+
+static void init_metadata(void *p, int intervals, int ref)
+{
+	int i, j;
+
+	for (i =3D 0; i < intervals; i++, ref++) {
+		int remaining =3D metadata_size - pi_offset;
+		unsigned char *m =3D p;
+
+		for (j =3D 0; j < pi_offset; j++)
+			m[j] =3D (unsigned char)(ref + j + i);
+
+		p +=3D pi_offset;
+		if (reftag_enabled) {
+			if (pi_size =3D=3D 8) {
+				struct t10_pi_tuple *tuple =3D p;
+
+				tuple->ref_tag =3D swap(ref);
+				remaining -=3D sizeof(*tuple);
+				p +=3D sizeof(*tuple);
+			} else if (pi_size =3D=3D 16) {
+				struct crc64_pi_tuple *tuple =3D p;
+
+				__put_unaligned_be48(ref, tuple->ref_tag);
+				remaining -=3D sizeof(*tuple);
+				p +=3D sizeof(*tuple);
+			}
+		}
+
+		m =3D p;
+		for (j =3D 0; j < remaining; j++)
+			m[j] =3D (unsigned char)~(ref + j + i);
+
+		p +=3D remaining;
+	}
+}
+
+static int check_metadata(void *p, int intervals, int ref)
+{
+	int i, j;
+
+	for (i =3D 0; i < intervals; i++, ref++) {
+		int remaining =3D metadata_size - pi_offset;
+		unsigned char *m =3D p;
+
+		for (j =3D 0; j < pi_offset; j++) {
+			if (m[j] !=3D (unsigned char)(ref + j + i)) {
+				fprintf(stderr, "(pre)interval:%d byte:%d expected:%x got:%x\n",
+					i, j, (unsigned char)(ref + j + i), m[j]);
+				return -1;
+			}
+		}
+
+		p +=3D pi_offset;
+		if (reftag_enabled) {
+			if (pi_size =3D=3D 8) {
+				struct t10_pi_tuple *tuple =3D p;
+
+				if (swap(tuple->ref_tag) !=3D ref) {
+					fprintf(stderr, "reftag interval:%d expected:%x got:%x\n",
+						i, ref, swap(tuple->ref_tag));
+					return -1;
+				}
+
+				remaining -=3D sizeof(*tuple);
+				p +=3D sizeof(*tuple);
+			} else if (pi_size =3D=3D 16) {
+				struct crc64_pi_tuple *tuple =3D p;
+				__u64 v =3D get_unaligned_be48(tuple->ref_tag);
+
+				if (v !=3D ref) {
+					fprintf(stderr, "reftag interval:%d expected:%x got:%llx\n",
+						i, ref, v);
+					return -1;
+				}
+				remaining -=3D sizeof(*tuple);
+				p +=3D sizeof(*tuple);
+			}
+		}
+
+		m =3D p;
+		for (j =3D 0; j < remaining; j++) {
+			if (m[j] !=3D (unsigned char)~(ref + j + i)) {
+				fprintf(stderr, "(post)interval:%d byte:%d expected:%x got:%x\n",
+					i, j, (unsigned char)~(ref + j + i), m[j]);
+				return -1;
+			}
+		}
+
+		p +=3D remaining;
+	}
+
+	return 0;
+}
+
+static void init_data(void *data, int offset)
+{
+	unsigned char *d =3D data;
+	int i;
+
+	for (i =3D 0; i < DATA_SIZE; i++)
+		d[i] =3D (unsigned char)(0xaa + offset + i);
+}
+
+static int check_data(void *data, int offset)
+{
+	unsigned char *d =3D data;
+	int i;
+
+	for (i =3D 0; i < DATA_SIZE; i++)
+		if (d[i] !=3D (unsigned char)(0xaa + offset + i))
+			return -1;
+
+	return 0;
+}
+
+int main(int argc, char *argv[])
+{
+	int fd, ret, i, offset, intervals, metabuffer_size, metabuffer_tx_size;
+	void *orig_data_buf, *orig_pi_buf, *data_buf;
+	struct io_uring_cqe *cqes[2];
+	struct io_uring_cqe *cqe;
+	struct io_uring_sqe *sqe;
+	struct io_uring ring;
+
+	if (argc < 2) {
+		fprintf(stderr, "Usage: %s <dev>\n", argv[0]);
+		return 1;
+	}
+
+	fd =3D open(argv[1], O_RDWR | O_DIRECT);
+	if (fd < 0) {
+		perror("Failed to open device with O_DIRECT");
+		return 1;
+	}
+
+	ret =3D init_capabilities(fd);
+	if (ret < 0)
+		return 1;
+	if (lba_size =3D=3D 0 || metadata_size =3D=3D 0)
+		return 1;
+
+	intervals =3D DATA_SIZE / lba_size;
+	metabuffer_tx_size =3D intervals * metadata_size;
+	metabuffer_size =3D metabuffer_tx_size * 2;
+
+	if (posix_memalign(&orig_data_buf, pagesize, DATA_SIZE)) {
+		perror("posix_memalign failed for data buffer");
+		ret =3D 1;
+		goto close;
+	}
+
+	if (posix_memalign(&orig_pi_buf, pagesize, metabuffer_size)) {
+		perror("posix_memalign failed for metadata buffer");
+		ret =3D 1;
+		goto free;
+	}
+
+	ret =3D io_uring_queue_init(8, &ring, 0);
+	if (ret < 0) {
+		perror("io_uring_queue_init failed");
+		goto cleanup;
+	}
+
+	data_buf =3D orig_data_buf;
+	for (offset =3D 0; offset < 512; offset++) {
+		void *pi_buf =3D (char *)orig_pi_buf + offset * 4;
+		struct io_uring_attr_pi pi_attr =3D {
+			.addr =3D (__u64)pi_buf,
+			.seed =3D offset,
+			.len =3D metabuffer_tx_size,
+		};
+
+		if (reftag_enabled)
+			pi_attr.flags =3D IO_INTEGRITY_CHK_REFTAG;
+
+		init_data(data_buf, offset);
+		init_metadata(pi_buf, intervals, offset);
+
+		sqe =3D io_uring_get_sqe(&ring);
+		if (!sqe) {
+			fprintf(stderr, "Failed to get SQE\n");
+			ret =3D 1;
+			goto ring_exit;
+		}
+
+		io_uring_prep_write(sqe, fd, data_buf, DATA_SIZE, offset * lba_size * =
8);
+		io_uring_sqe_set_data(sqe, (void *)1L);
+
+#ifdef PI_URING_COMPAT
+		/* old liburing, use fields that overlap in the union */
+		sqe->__pad2[0] =3D IORING_RW_ATTR_FLAG_PI;
+		sqe->addr3 =3D (__u64)&pi_attr;
+#else
+		sqe->attr_type_mask =3D IORING_RW_ATTR_FLAG_PI;
+		sqe->attr_ptr =3D (__u64)&pi_attr;
+#endif
+		ret =3D io_uring_submit(&ring);
+		if (ret < 1) {
+			perror("io_uring_submit failed (WRITE)");
+			ret =3D 1;
+			goto ring_exit;
+		}
+
+		ret =3D io_uring_wait_cqe(&ring, &cqe);
+		if (ret < 0) {
+			perror("io_uring_wait_cqe failed (WRITE)");
+			ret =3D 1;
+			goto ring_exit;
+		}
+
+		if (cqe->res < 0) {
+			fprintf(stderr, "write failed at offset %d: %s\n",
+				offset, strerror(-cqe->res));
+			ret =3D 1;
+			goto ring_exit;
+		}
+
+		io_uring_cqe_seen(&ring, cqe);
+
+		memset(data_buf, 0, DATA_SIZE);
+		memset(pi_buf, 0, metabuffer_tx_size);
+
+		sqe =3D io_uring_get_sqe(&ring);
+		if (!sqe) {
+			fprintf(stderr, "failed to get SQE\n");
+			ret =3D 1;
+			goto ring_exit;
+		}
+
+		io_uring_prep_read(sqe, fd, data_buf, DATA_SIZE, offset * lba_size * 8=
);
+		io_uring_sqe_set_data(sqe, (void *)2L);
+
+#ifdef PI_URING_COMPAT
+		sqe->__pad2[0] =3D IORING_RW_ATTR_FLAG_PI;
+		sqe->addr3 =3D (__u64)&pi_attr;
+#else
+		sqe->attr_type_mask =3D IORING_RW_ATTR_FLAG_PI;
+		sqe->attr_ptr =3D (__u64)&pi_attr;
+#endif
+
+		ret =3D io_uring_submit(&ring);
+		if (ret < 1) {
+			perror("io_uring_submit failed (read)");
+			ret =3D 1;
+			goto ring_exit;
+		}
+
+		ret =3D io_uring_wait_cqe(&ring, &cqe);
+		if (ret < 0) {
+			fprintf(stderr, "io_uring_wait_cqe failed (read): %s\n", strerror(-re=
t));
+			ret =3D 1;
+			goto ring_exit;
+		}
+
+		if (cqe->res < 0) {
+			fprintf(stderr, "read failed at offset %d: %s\n",
+				offset, strerror(-cqe->res));
+			ret =3D 1;
+			goto ring_exit;
+		}
+
+		ret =3D check_data(data_buf, offset);
+		if (ret) {
+			fprintf(stderr, "data corruption at offset %d\n",
+				offset);
+			ret =3D 1;
+			goto ring_exit;
+		}
+
+		ret =3D check_metadata(pi_buf, intervals, offset);
+		if (ret) {
+			fprintf(stderr, "metadata corruption at offset %d\n",
+				offset);
+			ret =3D 1;
+			goto ring_exit;
+		}
+
+		io_uring_cqe_seen(&ring, cqe);
+	}
+
+	memset(data_buf, 0, DATA_SIZE);
+	for (i =3D 0; i < 2; i++) {
+		sqe =3D io_uring_get_sqe(&ring);
+		if (!sqe) {
+			fprintf(stderr, "failed get sqe\n");
+			ret =3D 1;
+			goto ring_exit;
+		}
+
+		io_uring_prep_write(sqe, fd, data_buf, DATA_SIZE, DATA_SIZE * i);
+		io_uring_sqe_set_data(sqe, (void *)(uintptr_t)i + 1);
+	}
+
+	ret =3D io_uring_submit(&ring);
+	if (ret < 1) {
+		fprintf(stderr, "failed to submit sqes\n");
+		goto ring_exit;
+	}
+	ret =3D io_uring_wait_cqe_nr(&ring, cqes, 2);
+	if (ret)
+		fprintf(stderr, "failed to reap cqes\n");
+ring_exit:
+    io_uring_queue_exit(&ring);
+cleanup:
+    free(orig_pi_buf);
+free:
+    free(orig_data_buf);
+close:
+    close(fd);
+    return ret;
+}
diff --git a/tests/block/043 b/tests/block/043
new file mode 100755
index 0000000..dcd80d4
--- /dev/null
+++ b/tests/block/043
@@ -0,0 +1,33 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright 2025 Keith Busch <kbusch@kernel.org>
+#
+# Tests various user space metadata offsets with io_uring capabilities. =
If the
+# format uses ref tag protection, test various seed offsets as well.
+
+. tests/block/rc
+. common/nvme
+
+DESCRIPTION=3D"Test userspace metadata offsets"
+QUICK=3D1
+
+device_requires() {
+	_test_dev_has_metadata
+	_test_dev_disables_extended_lba
+}
+
+requires() {
+	_have_kernel_option IO_URING
+	_have_kernel_option BLK_DEV_INTEGRITY
+}
+
+test_device() {
+	echo "Running ${TEST_NAME}"
+
+	if ! src/metadata ${TEST_DEV}; then
+		echo "src/metadata failed"
+	fi
+
+	echo "Test complete"
+}
+
diff --git a/tests/block/043.out b/tests/block/043.out
new file mode 100644
index 0000000..fda7fca
--- /dev/null
+++ b/tests/block/043.out
@@ -0,0 +1,2 @@
+Running block/043
+Test complete
--=20
2.47.3

