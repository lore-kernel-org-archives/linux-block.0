Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC253F1055
	for <linux-block@vger.kernel.org>; Fri,  9 Oct 2026 23:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791590035; cv=none; b=U7Algx9zHMRBcwp0L8VYvOzuKon5LfGg1FDTVWE1HOuz5ni1vETBHCQvVdmscU7ZJx3pQJr2Tiz+Qp92O8fYJa3BKpDJOgqMiYalcYGERvkvAqlCAGR6MXbInjxnhMrXBqvKD/czYFm81+Us0jDwkr52vGKn+QFdlQ595HsHaTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791590035; c=relaxed/simple;
	bh=Mw0KXNQRrJhxH78r4DflzN0lDBE0g92kYlOB7ULQXc0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rcQb7HYPtQoMWV3TlU5CzV4x96Z/Zwzo/oS8TiFtrhLgkOakrsfW1a9X1iSRkhP3l6g8d2njk0TmaVq+7W48T6Vppk8o2hONwRjtWk4C1URahcexjXaORGQI1ySIkddNnkWhjiEs7ZLXyRu5sfE3snXNxlkusww6UZpI8KLiG9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=DQQA+SBf; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=g17MTE32; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="DQQA+SBf";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="g17MTE32"
Received: from pps.filterd (m0167073.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 699MYOUv1392940
	for <linux-block@vger.kernel.org>; Fri, 9 Oct 2026 19:53:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=8tci
	ogFsGD2Ws7aLXYXgi4IZlNxhxAX90NgewKRnmzU=; b=DQQA+SBfl5S+kpNnZs7F
	LSUy/I99mnh4PM5KFN/BP3q0Plz81XikzLAsZGJIX3kH/z511hlBzLo4tu3nql9B
	e2t7DZWSVwPC3f97JMSfmlXMdpFr5lguQ8/eq7ZZK8lZL9zFB0q61RiohU5asUcb
	IwxAtA5orCVu9dbmqFdCUzDSlWtyZ3BqIldm5Diy9eSNUt28iQcGYxfKg8RqG09W
	eQYpjQSzQsPqIkf7gyi39xVCrL5i9kCGg5y8xJ15sQKCZsqR09O0zKaGSbMOtDaJ
	5b6i3jzt0mpzvKA894cvXIYBEi/yYW6Q4AGP2R1hDMDKmr6Zs7tlBYGc6w43+OZV
	LA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4h74ta3452-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Fri, 09 Oct 2026 19:53:52 -0400 (EDT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-53397338004so6990851cf.2
        for <linux-block@vger.kernel.org>; Fri, 09 Oct 2026 16:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1791590032; x=1792194832; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8tciogFsGD2Ws7aLXYXgi4IZlNxhxAX90NgewKRnmzU=;
        b=g17MTE32j5mM3qKl/daWmz/LQANmzxRIMK7qxjUflm7QUU62c34hJ/FDfU6abuHozQ
         Ev6S1JuYdReo5k3UBCDWcd5pQ/8UImu5GKLbC+7oiWud53aQuE65Nf8f1UJAfsHc5Kue
         b9XsPKgNW4UW2tGght/Y5aGrd32hKJhunI/B1Kfve130CdwiHzdGLZazU5PFaZJg6IEt
         5sDcJIorYvzRdKjblgKh+Zs9FV7bthxtPeE2DtLD08GA8w2TvGRJobeu6np9+DlExQv2
         b0YKv12GFsW79m2vZgOLN9ifWbC4SIONoezsVJK+2OBInq+xUu2KO1NYsNnqxAlIVlGO
         IF0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791590032; x=1792194832;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8tciogFsGD2Ws7aLXYXgi4IZlNxhxAX90NgewKRnmzU=;
        b=k5hTp22nJ5SpQ/wX3MsLkwJ1C7ze3Pjl6568QjSqWoL8gYYVj32ZK49y/aRhsjhWmd
         BvFWIyoum1e8Fz+3sRZanpCHw8GQj7bTZkzN5HkpX8UJmH5Z8mlcL2XnOpzA4nMG954s
         inp/4MmHR2dVJoAPVKnwsystOppVlBvGU6x/2CG4X1guS1eRjF5aNzAe15wt9JFsyVqF
         4QWg65YQfiuLT/MCjmLcOSD0dBRUFh2n/hotxsZ+/S/HgqqFEl/R8U5cGouMRUgVtvqB
         vv3+zJ1z1TOlTxxRgx1Tuf2dWvJxumiJTqM/LO+2Fix8dn6VWGllyhmORBSU70oWhjbZ
         opKw==
X-Forwarded-Encrypted: i=1; AKwUvBzV9JkDVrvnVcwZk5z+Qo6nc1c+iWl0u0N8QJVXDFoffu4Jr6iSGQTVZLmeHu3icmBGw4JnPhHzhfEM3w==@vger.kernel.org
X-Gm-Message-State: AFq9FYKuj9SKPJjN1yIijXcDzGmmd4TASHQ13TEiFZkSgEOycDyqqwVH
	4qr8RyWE+QHr9JF1Z8OX3XzZCVvW5UssdW/lEDcr8fscpzz/ZiDma010n42+5DY3EV2SySe9xAa
	vJk8SUGdxAZKPQzojs7mFwsYetdBE/ZMtvyMujzA18sRUycvdcU9S/OgSrB3z
X-Gm-Gg: AYBFou1By/uzU9o7OWSNHzHsJ9iEx3ePMbKJCbuCpoHhRUj+ajrcOXMM0u9jQ4KAQcA
	ywTosnLFQitwTv6iamEYKMh5NAmqwS8gVLeoYGpeKxUPFAsa4KmNrhdaxPmQLLW1yVniDGI4KF+
	r8NsnOIK4/4DZiWH8noNx9AkBW7AzJBgmKQdNEY1qzscF3RnrgbfZ704DaBBk086wMWYldX7Q4S
	U4lNhRhJlE7KYerm6rhEKDn19UJbf4sD8lUuFM7MVkAaEL0g1Q6EuaAyeuwloDJeD3m+4I/c2ds
	Lf8UtctYS+tzvnhd8xaF85QOzDpFRgST8Tu0uNzReP2ntuXtELMBqliTkh7NR9+Px6EPi5P2Ntv
	x+Vle798JpH0JF42uvLsNwJyzWHtkYMBStsLQaFli8gS0278=
X-Received: by 2002:a05:620a:4611:b0:93c:5bfb:9a80 with SMTP id af79cd13be357-93ebd0c0178mr565344085a.3.1791590031511;
        Fri, 09 Oct 2026 16:53:51 -0700 (PDT)
X-Received: by 2002:a05:620a:4611:b0:93c:5bfb:9a80 with SMTP id af79cd13be357-93ebd0c0178mr565341885a.3.1791590031073;
        Fri, 09 Oct 2026 16:53:51 -0700 (PDT)
Received: from [127.0.1.1] (nat-128-59-178-194.net.columbia.edu. [128.59.178.194])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93eb984889fsm304517485a.13.2026.10.09.16.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 16:53:50 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Fri, 09 Oct 2026 19:53:46 -0400
Subject: [PATCH blktests v2 2/4] block/050: add a splice read race test for
 block devices
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-blkdev-fixes-tests-v2-2-fcb3599e47f7@columbia.edu>
References: <20261009-blkdev-fixes-tests-v2-0-fcb3599e47f7@columbia.edu>
In-Reply-To: <20261009-blkdev-fixes-tests-v2-0-fcb3599e47f7@columbia.edu>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>, John Garry <john.garry@linux.dev>,
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791590027; l=7576;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=Mw0KXNQRrJhxH78r4DflzN0lDBE0g92kYlOB7ULQXc0=;
 b=C4vwqaKU5mTCQDOBm03gUsvY/UI7svEQo/iWpD1h76x5re4v2faq6cMzHZhiMxBerbsDnf0Pr
 jospWowt3xDAlXKm6ByaeHl1LPs141lgQU3SCCwupjprR+sDKSpGjbH
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA5NSBTYWx0ZWRfX50AaZfTryn0z
 27L0FcK8gYmZpIjLF2v83fjuD9BKOGzzVX0oGPyMm/me5nleIZpOfT2pJp4SpI1KIFUGnrQlFmV
 M3px/uWL7GUUaXraMpHCH95L69mpkf++fNCm/bxErzzsmE6uwg3l980/k+7pgycaknyQcLRYJwC
 Use+cm0QRIau6gJX5E87ynL3N827lqF1Rw++ymJgamvxlaIdBN3D+bkRkzx+rxVIzQqpWnnm8wB
 /SAK+f8R8vIUuwP4nrkGmDkZaAf5Qilq19Ivc0hpjxM1QNxovv8NJxQby5M/0sNGkkCGtkm0PyQ
 lkQESWHc2Np2C6BkbuRxGkjGZdsfKK14Q7bdnKr4pilfpEP3O2UNNs2M3KyprU+k2+aoo5JSzTn
 yQPb6ha25znYMweOKX1YoldRM2RRoJ6qnH25Fx+QlU+KRu5Pl6F5Il7QV4JYwqpPHNTsHB8BmcX
 lP6d48rN3CKdMhucuKw==
X-Proofpoint-ORIG-GUID: 2vg3WV94RSggZQAF40hiABvNbLzEx0SG
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA5NSBTYWx0ZWRfX5sviRVZ6IBmc
 +YjBOhWOYtKO1mS0N2iHsNS8ikMveKcecX4xzPXMViZPSm+YKU9H6uyfCTs/Y2Evu2rJQcTgPR5
 D/nkgn3DUpUIMNPpT2TQT0f+ml5Vl4znOKWkgS8dNbwwXFVcHNIN
X-Proofpoint-GUID: 2vg3WV94RSggZQAF40hiABvNbLzEx0SG
X-Authority-Analysis: v=2.4 cv=Lu8HWXdc c=1 sm=1 tr=0 ts=6ac97e90 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=u0MKzLA9JmpizDwXU9Rxjg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=jHxIr1HyPKZ_Q5_91PL3:22
 a=VwQbUJbxAAAA:8 a=BO-O2x_ebyKE4gWa1f0A:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11930
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=10 adultscore=0 spamscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=10 bulkscore=10 suspectscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610090095

The block device splice read path has to hold i_rwsem like the plain
read path, so that it does not race set_blocksize() raising the
mapping's minimum folio order and add a folio that is too small for the
mapping.

This is a regression test for that issue, fixed in the kernel patch
"block: take i_rwsem for the splice read path" [1].

splice() from a memory-backed null_blk device into a pipe while toggling
the block size between 512 bytes and 64K with BLKBSZSET. A
CONFIG_DEBUG_VM kernel reports the folio order mismatch as a BUG, which
blktests picks up from dmesg.

The minimum folio order only moves with block sizes above the page size,
i.e. with CONFIG_TRANSPARENT_HUGEPAGE raising BLK_MAX_BLOCK_SIZE to 64K.

[1]: https://lore.kernel.org/linux-block/20261009-blkdev-fixes-v6-3-307939c387df@columbia.edu/

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 src/.gitignore      |   1 +
 src/Makefile        |   3 +-
 src/splice-race.c   | 171 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/block/050     |  54 +++++++++++++++++
 tests/block/050.out |   2 +
 5 files changed, 230 insertions(+), 1 deletion(-)

diff --git a/src/.gitignore b/src/.gitignore
index 754beef..dbebc22 100644
--- a/src/.gitignore
+++ b/src/.gitignore
@@ -11,6 +11,7 @@
 /mount_clear_sock
 /nbdsetsize
 /openclose
+/splice-race
 /sg/dxfer-from-dev
 /sg/syzkaller1
 /zbdioctl
diff --git a/src/Makefile b/src/Makefile
index 4590639..b7e8ca9 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -33,7 +33,8 @@ C_TARGETS := \
 C_URING_TARGETS := metadata \
 	nvme-passthru-admin-uring
 C_UBLK_TARGETS := miniublk
-C_THREAD_TARGETS := dio-fallback-race
+C_THREAD_TARGETS := dio-fallback-race \
+	splice-race
 
 HAVE_LIBURING := $(call HAVE_C_MACRO,liburing.h,IORING_OP_URING_CMD)
 HAVE_UBLK_HEADER := $(call HAVE_C_HEADER,linux/ublk_cmd.h,1)
diff --git a/src/splice-race.c b/src/splice-race.c
new file mode 100644
index 0000000..e411752
--- /dev/null
+++ b/src/splice-race.c
@@ -0,0 +1,171 @@
+// SPDX-License-Identifier: GPL-3.0+
+/*
+ * Copyright (C) 2026 Tal Zussman
+ *
+ * Race splice() from a block device against BLKBSZSET.
+ *
+ * Splicer threads splice from the device into a pipe while another thread
+ * toggles the block size between 512 bytes and 64K with BLKBSZSET.
+ *
+ * The splice read path has to run under i_rwsem like the plain read path.
+ * If it does not, it races set_blocksize() raising the mapping's minimum
+ * folio order and adds a folio that is too small for the mapping, which a
+ * CONFIG_DEBUG_VM kernel reports as a BUG. The caller checks dmesg.
+ *
+ * usage: splice-race <blockdev> <seconds>
+ *
+ * exit:  0 = ran for <seconds>
+ *        1 = setup error
+ */
+#define _GNU_SOURCE
+#include <fcntl.h>
+#include <pthread.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/ioctl.h>
+#include <unistd.h>
+
+#include <linux/fs.h>
+
+#define CHUNK		(64 * 1024)
+#define RANGE		(2 * 1024 * 1024)	/* keep the race on a few folios */
+#define NR_SPLICERS	4
+
+#define SMALL_BS	512
+#define LARGE_BS	(64 * 1024)
+
+static const char *dev;
+static int bszfd;
+static volatile int stop;
+static int failed;
+
+/* filemap_splice_read() from the device */
+static void *splicer(void *arg)
+{
+	int pipefd[2];
+	loff_t off = 0;
+	char *sink;
+	int fd;
+
+	fd = open(dev, O_RDONLY);
+	if (fd < 0) {
+		perror("open");
+		failed = 1;
+		return NULL;
+	}
+
+	if (pipe(pipefd)) {
+		perror("pipe");
+		failed = 1;
+		return NULL;
+	}
+
+	sink = malloc(CHUNK);
+	if (!sink) {
+		perror("malloc");
+		failed = 1;
+		return NULL;
+	}
+
+	while (!stop) {
+		ssize_t n = splice(fd, &off, pipefd[1], NULL, CHUNK, 0);
+
+		if (n < 0) {
+			perror("splice");
+			failed = 1;
+			break;
+		}
+
+		/* drain the pipe so the next splice does not block on it */
+		while (n > 0) {
+			ssize_t d = read(pipefd[0], sink, n);
+
+			if (d <= 0) {
+				perror("read");
+				failed = 1;
+				return NULL;
+			}
+			n -= d;
+		}
+
+		if (off >= RANGE)
+			off = 0;
+	}
+
+	return NULL;
+}
+
+/* change i_blkbits and the mapping's minimum folio order underneath them */
+static void *resizer(void *arg)
+{
+	int bs = SMALL_BS;
+
+	while (!stop) {
+		if (ioctl(bszfd, BLKBSZSET, &bs)) {
+			perror("BLKBSZSET");
+			failed = 1;
+			break;
+		}
+		bs = bs == SMALL_BS ? LARGE_BS : SMALL_BS;
+	}
+
+	return NULL;
+}
+
+static int spawn(pthread_t *t, void *(*fn)(void *))
+{
+	int err = pthread_create(t, NULL, fn, NULL);
+
+	if (err)
+		fprintf(stderr, "pthread_create: %s\n", strerror(err));
+
+	return err;
+}
+
+int main(int argc, char **argv)
+{
+	pthread_t splicers[NR_SPLICERS];
+	pthread_t resizer_t;
+	int bs = LARGE_BS;
+	int i;
+
+	if (argc != 3) {
+		fprintf(stderr, "usage: %s <blockdev> <seconds>\n", argv[0]);
+		return EXIT_FAILURE;
+	}
+
+	dev = argv[1];
+
+	bszfd = open(dev, O_RDONLY);
+	if (bszfd < 0) {
+		perror("open");
+		return EXIT_FAILURE;
+	}
+
+	/*
+	 * The minimum folio order only moves with block sizes above the page
+	 * size, which needs BLK_MAX_BLOCK_SIZE above PAGE_SIZE, i.e.
+	 * CONFIG_TRANSPARENT_HUGEPAGE.
+	 */
+	if (ioctl(bszfd, BLKBSZSET, &bs)) {
+		perror("BLKBSZSET");
+		return EXIT_FAILURE;
+	}
+
+	for (i = 0; i < NR_SPLICERS; i++) {
+		if (spawn(&splicers[i], splicer))
+			return EXIT_FAILURE;
+	}
+	if (spawn(&resizer_t, resizer))
+		return EXIT_FAILURE;
+
+	sleep(atoi(argv[2]));
+	stop = 1;
+
+	for (i = 0; i < NR_SPLICERS; i++)
+		pthread_join(splicers[i], NULL);
+	pthread_join(resizer_t, NULL);
+
+	return failed ? EXIT_FAILURE : EXIT_SUCCESS;
+}
diff --git a/tests/block/050 b/tests/block/050
new file mode 100755
index 0000000..64c0406
--- /dev/null
+++ b/tests/block/050
@@ -0,0 +1,54 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2026 Tal Zussman
+#
+# Race splice() from a block device against BLKBSZSET. The splice read path
+# has to hold i_rwsem like the plain read path so that it does not race
+# set_blocksize() raising the mapping's minimum folio order. Without it, the
+# splice adds a folio that is too small for the mapping, which a
+# CONFIG_DEBUG_VM kernel reports as a BUG.
+#
+# Regression test for patch "block: take i_rwsem for the splice read path".
+
+. tests/block/rc
+. common/null_blk
+
+DESCRIPTION="race splice() from a block device against BLKBSZSET"
+TIMED=1
+
+requires() {
+	_have_null_blk
+	_have_kernel_option TRANSPARENT_HUGEPAGE
+	_have_kernel_option DEBUG_VM
+	_have_src_program splice-race
+	if (( $(_get_page_size) >= 65536 )); then
+		SKIP_REASONS+=("a 64K block size is not above the page size")
+		return 1
+	fi
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	: "${TIMEOUT:=30}"
+
+	if ! _configure_null_blk nullb1 blocksize=512 memory_backed=1 \
+	     size=64 power=1; then
+		echo "configuring null_blk failed"
+		return 1
+	fi
+
+	if ! blockdev --setbsz 65536 /dev/nullb1; then
+		SKIP_REASONS+=("kernel does not support a 64K block size")
+		_exit_null_blk
+		return
+	fi
+
+	if ! src/splice-race /dev/nullb1 "${TIMEOUT}" >>"${FULL}" 2>&1; then
+		echo "splice-race helper failed"
+	fi
+
+	_exit_null_blk
+
+	echo "Test complete"
+}
diff --git a/tests/block/050.out b/tests/block/050.out
new file mode 100644
index 0000000..fc4e537
--- /dev/null
+++ b/tests/block/050.out
@@ -0,0 +1,2 @@
+Running block/050
+Test complete

-- 
2.39.5

