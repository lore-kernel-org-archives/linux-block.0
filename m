Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B92A39D6DA
	for <linux-block@vger.kernel.org>; Thu, 15 Oct 2026 16:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792081776; cv=none; b=r05G2ZWNPV986F5AR/glR/alX7g7v6rIKuc9JVbo+fVAXzMGoWv9+fIz5Y7KzSot2qezZTBHvJDM3KAvBbzV4F2/fzBdJe8D2ip77ip5uCMyPkXR1pYHSYi89If/e2FpOWiQdOX+RK569CI+k3F5mpD+zHQ10Oei/UZhH3uQyxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792081776; c=relaxed/simple;
	bh=pkbJwTA2gbp8zvu9qU4E7aJgXdJv3JCCPS3sYs8LlLU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ghDllXqkywYzmcDclNKz57xJ+CrSETEvAdSjZ8gtFBKmdyw8mkQOl0iwsOkH3jSJIT6vxXJezzo987ETbYbz3JveCjUTPs5RoHP2ksuhTV14YLvUaFG4436MI51E3BgX+JpBMAViJqM7HMVUqN7IjnNR7Lm0CYHOs+T+C26YCIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=mr38tPTm; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=kXvaVCwy; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="mr38tPTm";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="kXvaVCwy"
Received: from pps.filterd (m0167077.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69FG0AcY1620028
	for <linux-block@vger.kernel.org>; Thu, 15 Oct 2026 12:29:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=S67O
	iff6NTVd2qheGGwperQsYs+TBqwu121rT4jWj/k=; b=mr38tPTmUY0yRJF0lJhA
	t8YSPY2GBDFdJW8UjEbOOpKzEXJeKDluS87klzATqZ8F0UZ13+BnrGXVOx0R5lto
	pLAGgdk3n3pi2SIYk6fskFiAr3P0/sU04epMl/sFPpJn5FelYsamw9MgQWnFdd5h
	sZXHRcclqSCdB4prTqvYMEFY48keVBuBodWS4No5YpgaXjyFntvJ1PiOjTz7pkWb
	NTpAcibCBWtExk5I8jmmo5PAFm6I23gd01JlMN61RE7ng6ZnO7JoIMuD00tU+W9q
	jCIZogC6J38xoKWFmdXHolWSZuwl2rIEOxpUs+1VL9voAxss0WdK7ineqHTyKCdD
	4A==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4hb1yh89mw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Thu, 15 Oct 2026 12:29:23 -0400 (EDT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93dd3c3badbso374910285a.2
        for <linux-block@vger.kernel.org>; Thu, 15 Oct 2026 09:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1792081763; x=1792686563; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S67Oiff6NTVd2qheGGwperQsYs+TBqwu121rT4jWj/k=;
        b=kXvaVCwybOgTuwZtiuWm1CxfaSgrNvAucRzlhzTidKrl6v79uUpPbh7mUr3ysgFMDJ
         S27V0XEXqI6UqS4cTBU1J616HWBPdOtb7l0E+ic1qaqxBYqFfsDMU+d5y1Tr3knBqjgP
         8LHP8kpWzY406NWkZo7hZZg0SaluLP6h5TJkxM8PhGXMw1VdWWIKm5aIHW4DGRmveN7I
         eyYj1UGZpZzyEoUHrfUL/olcCbaYO/Xo7iRauTIAgoa7Vbwa1fSiIG7AWHX/lwGXUSLP
         8m/JtnPxbk3h2RZG+sEzj2RNq813cVfD6Ow5lit8YHgEkkhQZpru8q6fmyzuBkwpmFEC
         2YfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792081763; x=1792686563;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S67Oiff6NTVd2qheGGwperQsYs+TBqwu121rT4jWj/k=;
        b=UqXQffRXhN67CNSOhEnOHPpoYGQz22D0rY1aZQM8xc5PM/PF6YXXFQUZ76jmok9UM6
         KlPBNhQcdHNdmA9L/C1rMar6sq8QYqBYn9nUIEsQpbRgFLh1J5sEql9PyguQ5ebTZrvq
         Z/CQPYebjVn9UVTLqoG3Obzki5FfjMyFIjG4nM8zCLo2Z0w8rAHVRQTKCyEsfJwVTzDi
         TLonvd5uo9xqZzjo3e3AAWz+vEsoEucaf/yT2WRkIGbdNwK6nsSOLKm9FwhYL/iBxghp
         2oHWGHXlEhePrmxXD7bBPffe4CzYQamhqX6XZmbphjUGslvsxPSeQI6lZhQAtGKSsutn
         2Ruw==
X-Forwarded-Encrypted: i=1; AKwUvByERQM2jjpraFZRhFc2C7aWxkmI8BqV+l3BkOdJrozjzoFQsRXBdzVWow5o5OISsn2c6PmQpoVTlKHtRg==@vger.kernel.org
X-Gm-Message-State: AFq9FYLiMBVjbzdO4IihTDYodUI4R1BzoYXAh/niXID/byiAbgJ4pMzp
	hP7n6GZtHyfLIzRDjAbJH5aFYoWIMImxMo3KKU9zZ4ZmnnXlEXHUdrfzp4Ko2FbAQNOXg3dGE/O
	/7X1ndtA+15JJP6nMJwwJqCoocdb8ul+XKGatslZq5flvI94CXOtnwDSGZNwQhmBVvxzM
X-Gm-Gg: AYBFou2X/5ZZfUAouzm9q7swhA1+TUHY1PPOMJSvsKj2ZCtWDBF92xJqAbgQ8G0eLTP
	BRdDemSBNZcQIV2OFk9fnOOE/x+ds3+gbX4zfcW8TUMs3bU+pU4tYPe3smU3WaTTE3S2YDBcf5E
	ZIw+dhfLw5TK50VN1hy6NRwB5HEVwpMzNa2qnWtQQtUUarJLFuBI5/ujw6+wMvBduot8v2Flowc
	rkjLPbzcuIQ7zCe+P3gv5O2RcBKIXnFrbuGmgiAlWaW04qIEO8sx0xjw2UL73VNh/iJY6BuQp55
	HqZtopvFQWlTZDO5daIfzr311UH2BLkz8BLnZio7NQIcHLZPd1/plckrfiptBee+OYZvMECwqrE
	41k5atLT2f4uivxCR4q+0/s5IFYmbc0Ju6nvU12GC1vNr
X-Received: by 2002:a05:620a:4402:b0:93e:5953:1cb7 with SMTP id af79cd13be357-93ebd2396c2mr3146344985a.54.1792081762433;
        Thu, 15 Oct 2026 09:29:22 -0700 (PDT)
X-Received: by 2002:a05:620a:4402:b0:93e:5953:1cb7 with SMTP id af79cd13be357-93ebd2396c2mr3146340385a.54.1792081761856;
        Thu, 15 Oct 2026 09:29:21 -0700 (PDT)
Received: from [127.0.1.1] (nat-128-59-176-51.net.columbia.edu. [128.59.176.51])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93ef5086fe3sm803716285a.37.2026.10.15.09.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 09:29:21 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Thu, 15 Oct 2026 12:29:12 -0400
Subject: [PATCH blktests v3 2/4] block/051: add a splice read race test for
 block devices
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-blkdev-fixes-tests-v3-2-b6ffa6410514@columbia.edu>
References: <20261015-blkdev-fixes-tests-v3-0-b6ffa6410514@columbia.edu>
In-Reply-To: <20261015-blkdev-fixes-tests-v3-0-b6ffa6410514@columbia.edu>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>, John Garry <john.garry@linux.dev>,
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792081758; l=7580;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=pkbJwTA2gbp8zvu9qU4E7aJgXdJv3JCCPS3sYs8LlLU=;
 b=SCj+LiZhLWj7W8bDZL+kogOOIJ0R82aysQZnO+RBz0tPg8bsxQH12ObE0VMck6TYlSMsZlkLy
 hURA4A5A8AODSbaFjRq1OMU7ejxf8RWTCCnJH//YE+UPFa2jFr9bPwk
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-ORIG-GUID: u_fn59IjQNz8XMPH4CO9-a4uHn_2v99d
X-Proofpoint-GUID: u_fn59IjQNz8XMPH4CO9-a4uHn_2v99d
X-Authority-Analysis: v=2.4 cv=TMnQ2Fla c=1 sm=1 tr=0 ts=6ad0ff63 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=NKoNGjn6KhAaSQkl0TXC/A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=QOCMdifcju39GKoXhKua:22
 a=VwQbUJbxAAAA:8 a=BO-O2x_ebyKE4gWa1f0A:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA2NSBTYWx0ZWRfX4vartsRVFqS1
 FfuOZ3/RSn88DgR+gohvOOEIVCeouGPNjIiN3TUjtU/6igZpxodGMV+0DFRo52Ina6NHlbEVlmq
 EB0VQf5EpTMrGl1EBtfzEEBKzIQH7XM2Acd0Tpsg2A1jrfa2k8Xq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA2NSBTYWx0ZWRfX6Gnq0Ok8Fftx
 zKo4prkTAEkXznETwa0yT9HbDT0v6AeHWx/Obwxdr1SBGCN9Kqj7g+/eSOWpogMrGZiIPOVlTu0
 WN8bRmtQaLd1k4qC/ekjsJRbhw0hglCvo1E4+B7904q0oG/gUDbdbc22aZgIDMuSWkcDNY/VQm1
 bviT4WUUMqEYaTEOZbLYpM4PGqJQxQTSLGqtDiNt4ChJMGWoWAhYOOQtK3/MAXc7wLiGXrRI5yK
 mUT6ToA1waAyJ6uM5RQE61zwRvDjuYYk1umOA1o5Ju4x2AiGJA1UyAghUwnxgOMN/jOu/FEkGe+
 w9gTg4IpHatQqTDpKgmgJalRFQtb7RysB8tblXk7tpeVu/CkK7cjRcvrfSy/a1NSlSQ/dCWS4u4
 QfuQSC55zS0FvztYfBOxEqOhN7+EEPGe4ateuipqH5g1U51h74UFXpvhjlK9EzbCYkP5KGcpNqI
 UIiTB6p9YsSwFoj6WvQ==
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11936
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=10 bulkscore=10
 impostorscore=10 adultscore=0 clxscore=1015 priorityscore=1501 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610150065

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
 tests/block/051     |  54 +++++++++++++++++
 tests/block/051.out |   2 +
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
index 06cade9..4d56623 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -34,7 +34,8 @@ C_URING_TARGETS := metadata \
 	metadata-iopoll \
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
diff --git a/tests/block/051 b/tests/block/051
new file mode 100755
index 0000000..64c0406
--- /dev/null
+++ b/tests/block/051
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
diff --git a/tests/block/051.out b/tests/block/051.out
new file mode 100644
index 0000000..e9a2745
--- /dev/null
+++ b/tests/block/051.out
@@ -0,0 +1,2 @@
+Running block/051
+Test complete

-- 
2.39.5

