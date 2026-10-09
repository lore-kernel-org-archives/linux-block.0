Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071393C819C
	for <linux-block@vger.kernel.org>; Fri,  9 Oct 2026 23:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791590036; cv=none; b=SGRWf1QwKDz4za2p3d1LGgd5lKH3EqYWZWDhT8t9TIkHd6GOczB9DWGRN6+9rH30KKakAQoNGTdiZfzgS/sqDxxkk5Gmfpy0QqvhTtc6gZ2B2v6602+CTAJBAqQPopV1cMjY388Jym9c2DgR7QTa5NMWm0P/mZ0+NnCRc90g5nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791590036; c=relaxed/simple;
	bh=fbF5VGsWOxEbePw/cfXIojB0XGj+6U18dcekk9CtXd0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pMRphOvQZQBqwjSGl4reOL8VpBnwv1p+OkcXorn+J68Eqv2lGe5Lpa5JIjaLKjB8KFzS9q3eR60l7EHpUvBG6hEPJTqiXIpwzhfmm1eFjMbif36V9aXW5oW/dxsj7nuRT37AhvqtgqOO6Vxk99MaHQZFOiSdJ3K91vTIvotiQrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=pRDzAvWn; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=zg/V3aEv; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="pRDzAvWn";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="zg/V3aEv"
Received: from pps.filterd (m0167072.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 699MYEOg419716
	for <linux-block@vger.kernel.org>; Fri, 9 Oct 2026 19:53:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=Nk98
	OBNsibiOyRMUX1gr9GF4BaWFCcMBN67+RzqRJho=; b=pRDzAvWn0FBcpAgWSwzF
	ZlGAxf9mhULhmYdbB6tMgxCf/n5SgUgCw8NEGm7EF4Kr55pR5Uac2dSgTbBMPEjj
	g0hPP16MX4tLqrqz2R/FfpWTgpbQc1Y7S4stIf3u4xQfqIF/ioe4r8pgYL0Qyyo3
	g8UNAWjEyLnCuAHFCOILnPjbxsJENPl4AjAyV/OUClnzF3h9vx98m8nlZnfNwKSW
	8K6cugjjL4iWcgrhQ1JIZJD87bMoqPpvxJKg6ln2LFAObxmS7/U3XR5lfkIobiLk
	hZhBBadroCxe4upSEXFFf9Vsa6DjlvsGlmXDWbJwz7APZ+7weM7dGS4WcpyT7SXG
	Rw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4h74tdjfgf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Fri, 09 Oct 2026 19:53:54 -0400 (EDT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93cc0b31ecaso43135885a.1
        for <linux-block@vger.kernel.org>; Fri, 09 Oct 2026 16:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1791590033; x=1792194833; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Nk98OBNsibiOyRMUX1gr9GF4BaWFCcMBN67+RzqRJho=;
        b=zg/V3aEvTUN/iV0GcXQyTN1zCpchHzqXS08GoRRPF378Vi7bhzIceZk7qKO6yHuB6N
         xMxmJ4zsruko7/bntjg7DBYUebsFNyEPh3UypEF3wTstBWn0ScbG03KcpYPLr5KAPo+m
         e1w7xjtyfkfovPmHGb9/IbVgtUNe4z6wpikcC95WOweY17jtJbsMqmGlVzR3tJx5IjJM
         szB6VOHPQ4IhGmcvuTPaSs5et7Z4WjZp+phVVh/FMG2mEzWYZHH85X9TlwSf6xgTFpFq
         44TZEX/Lbx8qFjD+/26Es8yL2NnDmfW2jNrzLuNlSeh9oXo7WMG9gpqHiZ6fp3ysMq17
         9p9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791590033; x=1792194833;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Nk98OBNsibiOyRMUX1gr9GF4BaWFCcMBN67+RzqRJho=;
        b=ikYyK29QmNQdneyBJqVtYvxbk8ep7MY2J1gIByauVFntZgOf4Cnm7UWBvbtMD3WARh
         mOVANmGfQtzb7KiZiYv3flXHyjidc8jY6M1QoaCw4ujkt/PzXx8bBMo36pIXLwI3mBmk
         ft5uod8zt+fMW9DNGPb19edNEJJpDf+uIROkujWqDjKtnCgkgOSBLqIxN6w3E1X+QXhw
         F1E67pjlmRS/GjzndrsG+xAqBd6mmSxmkO0osXpTYaXFwr8PHLhbXAcbF1/EhsUJEgid
         Wfyeun8XSH8DbhXgC+5+MHX/er+A2lIAMvMuumrzW64FJJ/f56eQyvwF4CM6BbFOH5V2
         MZ3Q==
X-Forwarded-Encrypted: i=1; AKwUvByp7KnkJDaP6yAPKi1biyslMS6jKCUcW2NvlMqzrmGtZW0Va974i7anHrkKbqFHRV1i+EN6+s7D7Yb99g==@vger.kernel.org
X-Gm-Message-State: AFq9FYL6LhUyVVCW8ve8S3dOc/dMZ7c3/zTyElYBTThp6jI+lbZT2r5N
	0Ks1c61+8Hhw1AyqZNUTH+6IUbVFVGPj8LuFHRl1I5TuZTB6kc05XFM+VzXxAASXdo0fpI86Suh
	CXDK7V8vbS7V8IsFBsvja9fPPU0sJeB5fgGsdrlzMWBvIkPh/yvhpI7PEc+xb0RBJIfjj
X-Gm-Gg: AYBFou0fGWKt3Q3bCNjw/JKdE+GTtQcH7EDdw/PW1W+iMztdUaooKVWan+SI7UfoKV7
	AUwA6Sdg4FLTlX3ZtMKGQvBc2378ntM6vPAap9ltpG+M1HzaE9F9KyyU7f9S46XOE9fTvk27Bot
	ouA8yv5uQWkZ8PKpuvdMKXAQE4aMba9PL9t9oShsWiEfCSz3KDph3QxZPMt50E/7V8AAJJ/VC76
	27Vvx/3QYSU24aTiRkqJz+q+a2MR/o5VZ/XwyWVGmqzUvrL8m5UamRQAVT+MLP+vm3yAl8zAlFL
	wG5iNVey2CuAmdlfBjlfQk6Oo0+NTkIDwBxrNNuVDDuUcSn5NI7t/2mf6C7O+zUIJNfOArNici4
	zmAE9l6bwAOLvuG2ZGiosO4vGQVhhWXqNIrVmsQGik5sikZA=
X-Received: by 2002:a05:620a:462b:b0:93e:92f1:4222 with SMTP id af79cd13be357-93ebd0e57c4mr556859585a.4.1791590033014;
        Fri, 09 Oct 2026 16:53:53 -0700 (PDT)
X-Received: by 2002:a05:620a:462b:b0:93e:92f1:4222 with SMTP id af79cd13be357-93ebd0e57c4mr556857385a.4.1791590032580;
        Fri, 09 Oct 2026 16:53:52 -0700 (PDT)
Received: from [127.0.1.1] (nat-128-59-178-194.net.columbia.edu. [128.59.178.194])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93eb984889fsm304517485a.13.2026.10.09.16.53.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 16:53:52 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Fri, 09 Oct 2026 19:53:48 -0400
Subject: [PATCH blktests v2 4/4] block/052: add a torn atomic write test
 for block devices
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-blkdev-fixes-tests-v2-4-fcb3599e47f7@columbia.edu>
References: <20261009-blkdev-fixes-tests-v2-0-fcb3599e47f7@columbia.edu>
In-Reply-To: <20261009-blkdev-fixes-tests-v2-0-fcb3599e47f7@columbia.edu>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>, John Garry <john.garry@linux.dev>,
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791590027; l=7920;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=fbF5VGsWOxEbePw/cfXIojB0XGj+6U18dcekk9CtXd0=;
 b=sKzjVH7oLMGnD2YP1h6Y87Xv6bzJycBRzkOKwS67O1BDGdyFAbGO8TBVD2AMJL4TuieuT5WK5
 dh90OhemqLzAEC9ensVFLJajPa7bnB6k7HtT+Wz+z5BnwOwfRImT7bb
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA5NSBTYWx0ZWRfX0Iw3uownA0hb
 mbcpySKYcjutBuLckUgrpCtKK1Azwy11sIMYD5AWp9Y/MEcPp9ZWIR12XyCUV4HTulUg29uov/h
 W1p0VbdAyB25nzgmwZ9GITfloJhxwuhEHbL7O8Tyj8V0gnazVL9hk7obFvGuD/EKlcDAiw7l+rO
 h3ksvuZ0YlSsjgChrZQNs8H1wwT6zIHqB3seEhqzLtWfMkJ68ATmJd2X54QNyUdwc814xsoUIlP
 3eNqkYsew2aglWyJsMQrRioaMzPfHvL+QnmJ2k4+iv9LrLf/2XQc7fu5eTsS+fp64okR5cQG4fp
 JiobjnpO/CREUl/0srMOXsY31YQQFD+wAo+rbhRIGNCzuDwtc//ejdnHtfdhPDPSiBn9OHwvmnT
 GX5HcosWVsQ36e3BT3eBc9KaQmVCccW7slO24SjM+CSLIQ1N0r87k9OSikgmIGGPJ7myXs+VmkV
 1MFRILZ/uek6ac6nznA==
X-Authority-Analysis: v=2.4 cv=PKSaavqC c=1 sm=1 tr=0 ts=6ac97e92 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=u0MKzLA9JmpizDwXU9Rxjg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=SsB-OO3BMngHh3ZO9fOt:22
 a=VwQbUJbxAAAA:8 a=4RRKgcBwZ_zBFEaqlmYA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: 04j0_05nhgjO5j1gslKtlb-EGMIqM-kT
X-Proofpoint-GUID: 04j0_05nhgjO5j1gslKtlb-EGMIqM-kT
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA5NSBTYWx0ZWRfX6my/+WK3Z58G
 UFU8eoi87Rk8vmLxAVLwwx0YRDxMtSv8PzPc+b7uHdRt1IrzwUabgZ7oWcHOVPg0RhFGdMKfHi9
 /n73nR22RoevY17fDDfhtjg3VKlcgLUrL5o/8P5LbFS9ZFm2gsld
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11930
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 malwarescore=0 clxscore=1015 phishscore=0
 impostorscore=10 suspectscore=0 bulkscore=10 lowpriorityscore=10
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610090095

An atomic write is submitted as a single bio, so when its buffer can't
be fully pinned, the direct I/O path has to fail the write rather than
submit the pinned part. Otherwise, it submits what was pinned with
REQ_ATOMIC set and leaves the rest to the buffered fallback, tearing the
write at the pin boundary.

This is a regression test for that issue, fixed in the kernel patch
"block: fail a short atomic pin in bio_iov_iter_get_pages()" [1].

Issue pwritev2() with RWF_ATOMIC to a scsi_debug device with atomic_wr=1
from a buffer whose last page is PROT_NONE, so that pinning the buffer
stops one page short, then read the range back with O_DIRECT and fail if
it holds a mix of old and new data.

The write has to span at least two pages so that one can be left
unpinnable, and the device has to support it atomically. Use the largest
power of two up to 16K that the device's atomic write unit max allows,
and skip the test if that is below two pages.

[1]: https://lore.kernel.org/linux-block/20261009-blkdev-fixes-v6-5-307939c387df@columbia.edu/

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 src/.gitignore          |   1 +
 src/Makefile            |   1 +
 src/atomic-write-torn.c | 131 ++++++++++++++++++++++++++++++++++++++++++++++++
 tests/block/052         |  70 ++++++++++++++++++++++++++
 tests/block/052.out     |   2 +
 5 files changed, 205 insertions(+)

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
index 0bdfd05..54335d9 100644
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
index 0000000..e8ebba3
--- /dev/null
+++ b/src/atomic-write-torn.c
@@ -0,0 +1,131 @@
+// SPDX-License-Identifier: GPL-3.0+
+/*
+ * Copyright (C) 2026 Tal Zussman
+ *
+ * Check that a RWF_ATOMIC direct write to a block device is all or nothing
+ * when only part of its buffer can be pinned.
+ *
+ * Fill a range of the device with one byte value, then issue a pwritev2()
+ * with RWF_ATOMIC of a buffer holding another value whose last page is
+ * PROT_NONE, so that pinning the buffer stops one page short. The direct
+ * I/O path must fail the write outright rather than submit what it pinned.
+ *
+ * Read the range back with O_DIRECT and count the bytes of each value. A
+ * mix of old and new bytes means the write was torn.
+ *
+ * usage: atomic-write-torn <blockdev> <length>
+ *
+ * <length> is the size of the atomic write, a power of two of at least two
+ * pages that the device supports. The first <length> bytes of <blockdev>
+ * are overwritten.
+ *
+ * exit:  0 = the write was all or nothing
+ *        1 = setup error
+ *        2 = the write was torn
+ */
+#define _GNU_SOURCE
+#include <errno.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/mman.h>
+#include <sys/uio.h>
+#include <unistd.h>
+
+#ifndef RWF_ATOMIC
+#define RWF_ATOMIC	0x00000040
+#endif
+
+#define EXIT_TORN	2
+
+#define OLD	'A'
+#define NEW	'B'
+
+int main(int argc, char **argv)
+{
+	size_t old_bytes = 0, new_bytes = 0;
+	size_t len, pgsz, i;
+	struct iovec iov;
+	char *buf, *check;
+	ssize_t ret;
+	int fd;
+
+	if (argc != 3) {
+		fprintf(stderr, "usage: %s <blockdev> <length>\n", argv[0]);
+		return 1;
+	}
+
+	pgsz = sysconf(_SC_PAGESIZE);
+	len = strtoul(argv[2], NULL, 0);
+	if (len < 2 * pgsz || (len & (len - 1))) {
+		fprintf(stderr, "length must be a power of two of at least two pages\n");
+		return 1;
+	}
+
+	fd = open(argv[1], O_RDWR | O_DIRECT);
+	if (fd < 0) {
+		perror("open");
+		return 1;
+	}
+
+	buf = mmap(NULL, len, PROT_READ | PROT_WRITE,
+		   MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	if (buf == MAP_FAILED) {
+		perror("mmap");
+		return 1;
+	}
+
+	/* Write the old contents. */
+	memset(buf, OLD, len);
+	if (pwrite(fd, buf, len, 0) != (ssize_t)len) {
+		perror("pwrite");
+		return 1;
+	}
+
+	/* Fill in the new contents and make the last page unreadable. */
+	memset(buf, NEW, len);
+	if (mprotect(buf + len - pgsz, pgsz, PROT_NONE)) {
+		perror("mprotect");
+		return 1;
+	}
+
+	iov.iov_base = buf;
+	iov.iov_len = len;
+	ret = pwritev2(fd, &iov, 1, 0, RWF_ATOMIC);
+	if (ret < 0)
+		printf("pwritev2(RWF_ATOMIC) failed: %s\n", strerror(errno));
+	else
+		printf("pwritev2(RWF_ATOMIC) returned %zd of %zu\n", ret, len);
+
+	/* Read the range back past the page cache. */
+	if (posix_memalign((void **)&check, pgsz, len)) {
+		perror("posix_memalign");
+		return 1;
+	}
+	if (pread(fd, check, len, 0) != (ssize_t)len) {
+		perror("pread");
+		return 1;
+	}
+
+	for (i = 0; i < len; i++) {
+		if (check[i] == OLD)
+			old_bytes++;
+		else if (check[i] == NEW)
+			new_bytes++;
+	}
+	printf("on disk: %zu old bytes, %zu new bytes, %zu other\n",
+	       old_bytes, new_bytes, len - old_bytes - new_bytes);
+
+	free(check);
+	munmap(buf, len);
+	close(fd);
+
+	if (old_bytes != len) {
+		printf("atomic write was torn: %zu of %zu bytes written\n",
+		       new_bytes, len);
+		return EXIT_TORN;
+	}
+	printf("atomic write was all or nothing\n");
+	return 0;
+}
diff --git a/tests/block/052 b/tests/block/052
new file mode 100755
index 0000000..8ec115a
--- /dev/null
+++ b/tests/block/052
@@ -0,0 +1,70 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2026 Tal Zussman
+#
+# Issue a RWF_ATOMIC direct write to a block device from a buffer whose last
+# page cannot be pinned and check that the write is all or nothing. An atomic
+# write is submitted as a single bio, so the direct I/O path has to fail the
+# write outright when pinning its buffer comes up short. Without that, it
+# submits what was pinned with REQ_ATOMIC set and leaves the rest to the
+# buffered fallback, tearing the write at the pin boundary.
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
+	_have_scsi_debug
+	_have_module_param scsi_debug atomic_wr
+	_have_src_program atomic-write-torn
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	local dev len page_size unit_max ret
+
+	if ! _configure_scsi_debug delay=0 atomic_wr=1 dev_size_mb=16; then
+		echo "configuring scsi_debug failed"
+		return 1
+	fi
+	dev="/dev/${SCSI_DEBUG_DEVICES[0]}"
+
+	# The largest power of two the device can write atomically, capped at
+	# 16K. It has to span at least two pages so that one can be left
+	# unpinnable.
+	page_size=$(_get_page_size)
+	unit_max=$(< "/sys/block/${SCSI_DEBUG_DEVICES[0]}/queue/atomic_write_unit_max_bytes")
+	len=16384
+	while (( len > unit_max )); do
+		len=$(( len / 2 ))
+	done
+	if (( len < 2 * page_size )); then
+		SKIP_REASONS+=("atomic write unit max ${unit_max} is below two pages")
+		_exit_scsi_debug
+		return
+	fi
+
+	src/atomic-write-torn "${dev}" "${len}" >>"${FULL}" 2>&1
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
+	*)
+		echo "atomic-write-torn helper failed"
+		;;
+	esac
+
+	echo "Test complete"
+}
diff --git a/tests/block/052.out b/tests/block/052.out
new file mode 100644
index 0000000..71c1f0a
--- /dev/null
+++ b/tests/block/052.out
@@ -0,0 +1,2 @@
+Running block/052
+Test complete

-- 
2.39.5

