Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96EA051614F
	for <linux-block@vger.kernel.org>; Thu, 15 Oct 2026 16:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792081785; cv=none; b=fXmSSPai1d+MlKRds9YVHscj4mbu1OPTpHO+DVn26+qx6KsRFK1sZIn484KnFl5R8NEZacCGzgGlmpjDhK4TW/m4i1OM9TkBcxUMp0HY6vfamvUEWCjpbZycgduwTSQrhkAsXwMUfwzd5/PPxnvn64FIQa54RO8rTkoUffRWUlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792081785; c=relaxed/simple;
	bh=Alwa3dvi2zwVj1x3Pi0FNHCnrwyRT2mPAFk3JS/Kt/k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GxHJmrDr+ylGzVkVwHGEwgbelUHWmi7xdERxeHjIyy9hUD/pVk8dpnT8ys4Etx3oo5sS9gpVKgxB2DiYHu3rkqHOVjKJFzxN4GbwdJV9sWnd2cebpMHSy9Ih1kjFK8W7+MAoxeNOGuiJSFIYyht4T8nxH3hBQON0ibggBA01MqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=CPMXgcU5; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=ViRybKOk; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="CPMXgcU5";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="ViRybKOk"
Received: from pps.filterd (m0167076.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69FEYP0P855761
	for <linux-block@vger.kernel.org>; Thu, 15 Oct 2026 12:29:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=iZ8O
	mQ1SzMZl8ffiLN02jr1RT+sDEMabssc1/+gsuOc=; b=CPMXgcU5PUxJ6dOKv8vv
	kciZnHHF14cbJsK4fwCzFcS5hhydkCwgPDQhOKAxBRHTx4MorTqQAPgntgKiqowF
	AedXZR6QyTDoEvaA3M0Y9wf91iw6BiykcIVo1NBEF+EwiZneWLnrommetfLBKfZV
	MXktCcYY0/MX6RVODnSSSA250EdLgZ5pmJpwB+UZzxK7LD4TpdXd+FviyC4ur5Om
	LOFbNTHHKDSp87i6AORc+Fxr7sIrmcO14lLQy20M2jWB/+VHdPXLcd2yuRd8K23s
	IebbINMRgN/bV3hiypcYedtNyWR0eG+u6f6G+OpBJ75LSnE7ge6/pYHzrjfoxHEi
	xg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4hatthketw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Thu, 15 Oct 2026 12:29:25 -0400 (EDT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-92e82060977so34568185a.1
        for <linux-block@vger.kernel.org>; Thu, 15 Oct 2026 09:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1792081765; x=1792686565; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iZ8OmQ1SzMZl8ffiLN02jr1RT+sDEMabssc1/+gsuOc=;
        b=ViRybKOk71QIdzwcEurJz4Zi/gWp/232x9wvePwgxjUn0y5edB3+MYVwqADOP63wsh
         4yZGmAuGqxNg5e+Ip6SB3orBEkyTB92I8BdFAu3A3DZKsm156ILmM6GFeIgUww4L2YIu
         5TYmX2Tw6s3Mbnhf7sByX5kTYEqFXAFbTeim20y78JM9+43rHI+jQsmUU6mcDrfUkPTz
         bEgP6P1ClgWlqU8MEPwGqSsTmOZlm8+6bcoQ1qeGx1UZj9ju82YKD1O5ifeFsxchVgAx
         YpZbTk1fie2ufkdBy19PlAntRcPfusjH85TIXF4/5XzBGKqnrTqNpyrBqedDhhjZqJs7
         pmeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792081765; x=1792686565;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iZ8OmQ1SzMZl8ffiLN02jr1RT+sDEMabssc1/+gsuOc=;
        b=v8u9YYPZQSVGVOfKIxJFus4xdkHFu0p3Yb4dF3l9JR6vbhmMtihmkksRdmqUx2tWiS
         4ZisIhmIOh3fGf2FZCu+O4f6YmRerFi2/zmXOWqVq3noOXaWTSgjJHfkOtv9Q/HV7daj
         FyY2mYgYXza2/q78tHL7RXU2CcEVrkVhxxm5q0ev7sz+yLwN689yM2U/wV5AqG9COLbB
         Y/YRD6D0LkXIK945Bv6nj2brrjfrrovh1ztCZqfePywEWtBwNtdnOFPOSpxgyCUk9TPv
         /t021wTnBUu3GhiwciVPuCaYjgd2nVbEnfAKBph0xDFNPByHPrF2wm/vl0ZXbYhj+hsl
         zVhQ==
X-Forwarded-Encrypted: i=1; AKwUvBwj8d+tcoClOZfIuvDCQklNdUf7Q4ITkeDVUmq0J00ULe5gtcfAVYFa4DXHD8mPvh8ocebVcJwEZSjIDQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYJeTkft6O5PepELPtjcwY4y8GuOcfP3Gp7qhcotQOVT+jFSHviY
	qFnAXQcslKFoxnxn2Zd3bb3rrd/RfnSxp77eA46cSJ96EXjPn03aO8GsKSYEvKmqdFWdi0dQqcA
	D6YSE+vSOozZYgJXivzku2VkKzn+5WXlE/Jfu5awX76MAfW1Ytq4LNYbQD52irXm4Fqq5
X-Gm-Gg: AYBFou2YNbvx1MoL4t39LTIY+BjLBBfs+/ytnB33PzKdoQaBV39FP56Pu5WHSIrp/4K
	LRoGRabpz9kJ+AhQd1sMWvusn4oBzPsvCagF8js9MKlOwc5ryU4oIQcqC3DE4u5NecHHbEIE/0N
	YlFCmNmNWYNWUvtEzUvFfWz85J8DC9NXQtsW1Cc3y/W8OleRupv+9Edbw+d8WWNxB384z/OUfCC
	Qxvu3SF3KZDsqBCxB4q6ak5AcIBkfwIECs/YEDAzGM2QuODr4YkUWBEn5OsDq7tJlFZjzlfsT88
	cpp+KfDy3ms/BH61qRGzHIlK2mU/ohLc4HZr0gLJw9Vr8uoLyoYyephXS/i6+iG/SOfNr1XRDWo
	HfspVoSedGPt9riJlQ7dN+4eZxWn3rSWzN7fXUlSvpGlf
X-Received: by 2002:a05:620a:4593:b0:93e:c173:f68d with SMTP id af79cd13be357-93f17e7911dmr104834185a.33.1792081764769;
        Thu, 15 Oct 2026 09:29:24 -0700 (PDT)
X-Received: by 2002:a05:620a:4593:b0:93e:c173:f68d with SMTP id af79cd13be357-93f17e7911dmr104828685a.33.1792081764084;
        Thu, 15 Oct 2026 09:29:24 -0700 (PDT)
Received: from [127.0.1.1] (nat-128-59-176-51.net.columbia.edu. [128.59.176.51])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93ef5086fe3sm803716285a.37.2026.10.15.09.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 09:29:23 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Thu, 15 Oct 2026 12:29:14 -0400
Subject: [PATCH blktests v3 4/4] block/053: add a torn atomic write test
 for block devices
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-blkdev-fixes-tests-v3-4-b6ffa6410514@columbia.edu>
References: <20261015-blkdev-fixes-tests-v3-0-b6ffa6410514@columbia.edu>
In-Reply-To: <20261015-blkdev-fixes-tests-v3-0-b6ffa6410514@columbia.edu>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>, John Garry <john.garry@linux.dev>,
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792081758; l=10912;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=Alwa3dvi2zwVj1x3Pi0FNHCnrwyRT2mPAFk3JS/Kt/k=;
 b=IMB4i5qaExUq+g4QQ05T+b94FU/UV0soCw8dDjPCofnMCXUUPkFA2cw/oLLUwZLscWzJ08qof
 5s4b4GeRiNxClbKN44nEvJJ0TeHXaV2clo8rhKpAzAkCnLyNeGgYGmU
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-GUID: i7N6xz-o22znzyYX_QRYoffBNEB0ECup
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA2NSBTYWx0ZWRfX4XNj035R/Irx
 p4aCLbKmBCMGyJ4CfIY4NDf1L27ES5jmS8gEVOo76Puxm5GMUFz0mWVv6/x9wc51WrP1MfbmIER
 fluSvihzteVESQ4LtPJRsWMtSN0pmWfgif08wrUr3sSojgnRBPOD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA2NSBTYWx0ZWRfX95BDgDnNyfkr
 VjdWjcBA8jgNh1bl8ynOY/OtjfYd+5LnxpkuuKxd6cKAZMRJg4JzA0F/akeAAUtzIuECsL/Mxdn
 TukMrPxra/zJ7KUQsm8tHLvYeCQaEisvchJIxhEvEKC6XShaKIrFfTb67NCslSjoEH8yZGMP4E4
 38BPH6xJ+mSIRk7FXWNM5PXxPsN3VsxeUs88Nq/KoMOA8Rqc1T7UiKkz0pytpkpDBG83Gsr+iCU
 5yYTwyiGZ4yMfuP8iOx7ZH9X2LUD9ZVuJkB6t1RbIVty6Qj/0GnOlOKRFNL4ILhw+CdLtwQhKLs
 Srddzd8ZSh5nyKj+cv+DIMAFchuaQqP9OBRYRJ+820aQ7mFevW+j1ZlCYkwyJnUHr+Y1KR40UAX
 KF2foFRe6a9Il6HYk0rml/y1ncYX2JpXADrxGW0AgtHrH0GD6UZzw4nVCh8Ptxt8HPPEKYHFZQr
 548lhCVWHMgFzpdCHQw==
X-Authority-Analysis: v=2.4 cv=WJvqzXsR c=1 sm=1 tr=0 ts=6ad0ff65 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=NKoNGjn6KhAaSQkl0TXC/A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=Qm0qsxP7aFY2tkT6R2MF:22
 a=VwQbUJbxAAAA:8 a=PSHdrYPxbzaCfHOPYYgA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: i7N6xz-o22znzyYX_QRYoffBNEB0ECup
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11936
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 impostorscore=10 lowpriorityscore=10
 bulkscore=10 priorityscore=1501 adultscore=0 clxscore=1015 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610150065

A block device atomic write is a hardware atomic write, submitted as a
single bio, so when its buffer can't be fully pinned, the direct I/O
path has to fail the write rather than submit the pinned part.
Otherwise, it submits what was pinned with REQ_ATOMIC set and leaves
the rest to the buffered fallback, tearing the write at the pin
boundary.

This is a regression test for that issue, fixed in the kernel patch
"block: fail a short atomic pin in bio_iov_iter_get_pages()" [1].

Issue a two-page pwritev2() with RWF_ATOMIC to a scsi_debug device with
atomic_wr=1 from a buffer whose last page is PROT_NONE, so that pinning
the buffer stops one page short. Check with statx() that the device
supports an atomic write of that size, then check that the write fails
with EINVAL and that the range still reads back as the old data.

Two pages is the smallest write that leaves one page unpinnable, and
atomic_wr_max_length=256 raises the atomic write unit max to 128K so
that two pages fit for any page size up to 64K.

[1]: https://lore.kernel.org/linux-block/20261009-blkdev-fixes-v6-5-307939c387df@columbia.edu/

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 src/.gitignore          |   1 +
 src/Makefile            |   1 +
 src/atomic-write-torn.c | 233 ++++++++++++++++++++++++++++++++++++++++++++++++
 tests/block/053         |  60 +++++++++++++
 tests/block/053.out     |   2 +
 5 files changed, 297 insertions(+)

diff --git a/src/.gitignore b/src/.gitignore
index 92c08d1..76a1c5e 100644
--- a/src/.gitignore
+++ b/src/.gitignore
@@ -1,3 +1,4 @@
+/atomic-write-torn
 /bio-bounce-read
 /bio-full-trim
 /bio-trim-pin-leak
diff --git a/src/Makefile b/src/Makefile
index f3f338b..b244405 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -14,6 +14,7 @@ HAVE_C_DEF = $(shell if printf '$(H)include <%s>\n$(H)ifdef %s\nHAVE_%s\n$(H)end
 		then echo 1;else echo 0; fi)
 
 C_TARGETS := \
+	atomic-write-torn \
 	bio-bounce-read \
 	bio-full-trim \
 	bio-trim-pin-leak \
diff --git a/src/atomic-write-torn.c b/src/atomic-write-torn.c
new file mode 100644
index 0000000..f6f3ccf
--- /dev/null
+++ b/src/atomic-write-torn.c
@@ -0,0 +1,233 @@
+// SPDX-License-Identifier: GPL-3.0+
+/*
+ * Copyright (C) 2026 Tal Zussman
+ *
+ * Check that a RWF_ATOMIC direct write to a block device is all or nothing
+ * when only part of its buffer can be pinned.
+ *
+ * Fill two pages of the device with one byte value, then issue a pwritev2()
+ * with RWF_ATOMIC of a two-page buffer holding another value whose last page
+ * is PROT_NONE, so that pinning the buffer stops one page short. The direct
+ * I/O path must fail the write with EINVAL rather than submit what it pinned.
+ *
+ * Read the range back with O_DIRECT and count the bytes of each value, once
+ * before the atomic write to check the baseline and once after it. The write
+ * has to fail with EINVAL and leave only old bytes on the device.
+ *
+ * The device has to support atomic writes of two pages, which is checked
+ * with statx(). The first two pages of <blockdev> are overwritten.
+ *
+ * usage: atomic-write-torn <blockdev>
+ *
+ * exit:  0 = the write failed with EINVAL and the device is unchanged
+ *        1 = setup error
+ *        2 = the write was torn
+ *        3 = the write did not fail with EINVAL, or went through
+ */
+#define _GNU_SOURCE
+#include <errno.h>
+#include <fcntl.h>
+#include <stdbool.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/mman.h>
+#include <sys/syscall.h>
+#include <sys/uio.h>
+#include <unistd.h>
+
+#ifndef RWF_ATOMIC
+#define RWF_ATOMIC	0x00000040
+#endif
+
+#ifndef STATX_WRITE_ATOMIC
+#define STATX_WRITE_ATOMIC	0x00010000U
+#endif
+#ifndef STATX_ATTR_WRITE_ATOMIC
+#define STATX_ATTR_WRITE_ATOMIC	0x00400000
+#endif
+
+/*
+ * The atomic write fields of struct statx are only in glibc 2.43 and later,
+ * so use a local copy of the kernel's layout and call the syscall directly.
+ */
+struct atomic_statx {
+	uint32_t stx_mask;
+	uint32_t stx_blksize;
+	uint64_t stx_attributes;
+	uint32_t stx_nlink;
+	uint32_t stx_uid;
+	uint32_t stx_gid;
+	uint16_t stx_mode;
+	uint16_t __spare0[1];
+	uint64_t stx_ino;
+	uint64_t stx_size;
+	uint64_t stx_blocks;
+	uint64_t stx_attributes_mask;
+	uint64_t stx_times[8];	/* stx_atime, stx_btime, stx_ctime, stx_mtime */
+	uint32_t stx_rdev_major;
+	uint32_t stx_rdev_minor;
+	uint32_t stx_dev_major;
+	uint32_t stx_dev_minor;
+	uint64_t stx_mnt_id;
+	uint32_t stx_dio_mem_align;
+	uint32_t stx_dio_offset_align;
+	uint64_t stx_subvol;
+	uint32_t stx_atomic_write_unit_min;
+	uint32_t stx_atomic_write_unit_max;
+	uint32_t stx_atomic_write_segments_max;
+	uint32_t stx_dio_read_offset_align;
+	uint32_t stx_atomic_write_unit_max_opt;
+	uint32_t __spare2[1];
+	uint64_t __spare3[8];
+};
+
+_Static_assert(sizeof(struct atomic_statx) == 256, "struct statx is 256 bytes");
+
+#define EXIT_TORN	2
+#define EXIT_UNEXPECTED	3
+
+#define OLD	'A'
+#define NEW	'B'
+
+/* Does the device support an atomic write of len bytes? */
+static bool can_write_atomically(int fd, size_t len)
+{
+	struct atomic_statx stx = { 0 };
+
+	if (syscall(SYS_statx, fd, "", AT_EMPTY_PATH, STATX_WRITE_ATOMIC,
+		    &stx)) {
+		perror("statx");
+		return false;
+	}
+	if (!(stx.stx_mask & STATX_WRITE_ATOMIC) ||
+	    !(stx.stx_attributes & STATX_ATTR_WRITE_ATOMIC)) {
+		fprintf(stderr, "device does not support atomic writes\n");
+		return false;
+	}
+	printf("atomic write unit min %u, max %u\n",
+	       stx.stx_atomic_write_unit_min, stx.stx_atomic_write_unit_max);
+	if (len < stx.stx_atomic_write_unit_min ||
+	    len > stx.stx_atomic_write_unit_max) {
+		fprintf(stderr, "device cannot write %zu bytes atomically\n",
+			len);
+		return false;
+	}
+	return true;
+}
+
+/* Read the range back past the page cache and count the bytes of each value. */
+static int count_bytes(int fd, char *buf, size_t len, size_t *old_bytes,
+		       size_t *new_bytes)
+{
+	size_t i;
+
+	if (pread(fd, buf, len, 0) != (ssize_t)len) {
+		perror("pread");
+		return -1;
+	}
+
+	*old_bytes = *new_bytes = 0;
+	for (i = 0; i < len; i++) {
+		if (buf[i] == OLD)
+			(*old_bytes)++;
+		else if (buf[i] == NEW)
+			(*new_bytes)++;
+	}
+	printf("on disk: %zu old bytes, %zu new bytes, %zu other\n",
+	       *old_bytes, *new_bytes, len - *old_bytes - *new_bytes);
+	return 0;
+}
+
+int main(int argc, char **argv)
+{
+	size_t old_bytes, new_bytes;
+	size_t len, pgsz;
+	struct iovec iov;
+	char *buf;
+	ssize_t ret;
+	int fd, err, status = 1;
+
+	if (argc != 2) {
+		fprintf(stderr, "usage: %s <blockdev>\n", argv[0]);
+		return 1;
+	}
+
+	pgsz = sysconf(_SC_PAGESIZE);
+	len = 2 * pgsz;
+
+	fd = open(argv[1], O_RDWR | O_DIRECT);
+	if (fd < 0) {
+		perror("open");
+		return 1;
+	}
+
+	if (!can_write_atomically(fd, len))
+		goto out_close;
+
+	buf = mmap(NULL, len, PROT_READ | PROT_WRITE,
+		   MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	if (buf == MAP_FAILED) {
+		perror("mmap");
+		goto out_close;
+	}
+
+	/* Write the old contents and check that they read back. */
+	memset(buf, OLD, len);
+	if (pwrite(fd, buf, len, 0) != (ssize_t)len) {
+		perror("pwrite");
+		goto out_unmap;
+	}
+	if (count_bytes(fd, buf, len, &old_bytes, &new_bytes))
+		goto out_unmap;
+	if (old_bytes != len) {
+		fprintf(stderr, "old contents did not read back\n");
+		goto out_unmap;
+	}
+
+	/* Fill in the new contents and make the last page unreadable. */
+	memset(buf, NEW, len);
+	if (mprotect(buf + len - pgsz, pgsz, PROT_NONE)) {
+		perror("mprotect");
+		goto out_unmap;
+	}
+
+	iov.iov_base = buf;
+	iov.iov_len = len;
+	ret = pwritev2(fd, &iov, 1, 0, RWF_ATOMIC);
+	err = errno;
+	if (ret < 0)
+		printf("pwritev2(RWF_ATOMIC) failed: %s\n", strerror(err));
+	else
+		printf("pwritev2(RWF_ATOMIC) returned %zd of %zu\n", ret, len);
+
+	/* Make the last page readable again and reuse the buffer. */
+	if (mprotect(buf + len - pgsz, pgsz, PROT_READ | PROT_WRITE)) {
+		perror("mprotect");
+		goto out_unmap;
+	}
+	if (count_bytes(fd, buf, len, &old_bytes, &new_bytes))
+		goto out_unmap;
+
+	if (old_bytes != len && new_bytes != len) {
+		printf("atomic write was torn: %zu of %zu bytes written\n",
+		       new_bytes, len);
+		status = EXIT_TORN;
+	} else if (ret >= 0 || err != EINVAL) {
+		printf("atomic write did not fail with EINVAL\n");
+		status = EXIT_UNEXPECTED;
+	} else if (new_bytes) {
+		printf("atomic write went through despite the unreadable page\n");
+		status = EXIT_UNEXPECTED;
+	} else {
+		printf("atomic write failed with EINVAL and left the device unchanged\n");
+		status = 0;
+	}
+
+out_unmap:
+	munmap(buf, len);
+out_close:
+	close(fd);
+	return status;
+}
diff --git a/tests/block/053 b/tests/block/053
new file mode 100755
index 0000000..c7a24b4
--- /dev/null
+++ b/tests/block/053
@@ -0,0 +1,60 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2026 Tal Zussman
+#
+# Issue a RWF_ATOMIC direct write to a block device from a buffer whose last
+# page cannot be pinned and check that the write is all or nothing. A block
+# device atomic write is a hardware atomic write, submitted as a single bio,
+# so the direct I/O path has to fail the write outright when pinning its
+# buffer comes up short. Without that, it submits what was pinned with
+# REQ_ATOMIC set and leaves the rest to the buffered fallback, tearing the
+# write at the pin boundary.
+#
+# Regression test for patch "block: fail a short atomic pin in
+# bio_iov_iter_get_pages()".
+
+. tests/block/rc
+. common/scsi_debug
+
+DESCRIPTION="check that a partially pinned atomic write is not torn"
+QUICK=1
+
+requires() {
+	_have_scsi_debug && _have_module_param scsi_debug atomic_wr
+	_have_src_program atomic-write-torn
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	local ret
+
+	# The helper writes two pages atomically. An atomic write unit max of
+	# 256 blocks, 128K, covers page sizes up to 64K.
+	if ! _configure_scsi_debug delay=0 atomic_wr=1 atomic_wr_max_length=256 \
+	     dev_size_mb=16; then
+		echo "configuring scsi_debug failed"
+		return 1
+	fi
+
+	src/atomic-write-torn "/dev/${SCSI_DEBUG_DEVICES[0]}" >>"${FULL}" 2>&1
+	ret=$?
+
+	_exit_scsi_debug
+
+	case $ret in
+	0)
+		;;
+	2)
+		echo "atomic write was torn"
+		;;
+	3)
+		echo "atomic write did not fail cleanly"
+		;;
+	*)
+		echo "atomic-write-torn helper failed"
+		;;
+	esac
+
+	echo "Test complete"
+}
diff --git a/tests/block/053.out b/tests/block/053.out
new file mode 100644
index 0000000..43d1b4b
--- /dev/null
+++ b/tests/block/053.out
@@ -0,0 +1,2 @@
+Running block/053
+Test complete

-- 
2.39.5

