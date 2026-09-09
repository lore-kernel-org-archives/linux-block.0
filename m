Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43F3339376
	for <linux-block@vger.kernel.org>; Wed,  9 Sep 2026 19:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788982793; cv=none; b=Ol62FVr2VqQNdsWsB4zagQUz/tFkUv5Jgj5+TckM9G3ZFuzgG5HBZRnIgyJu0Nu1bOaT3z4Iu4rMcQRaHwjW+y5SQ1bNh5z13+b5LxqLgN38vovgmD/v9dgQJJZo+rDe+D+PVrf7Dp2vLsvp7JU8Qnh+Ggcgjdm6Ee0N2HoSZGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788982793; c=relaxed/simple;
	bh=5mYluXL3APFeNnvNX/sl51f51jpUVVFIocJDOuJGSOo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DxwX8XR/+bXuPu8eTjMgKmSJE7dkoV5BaFiH4lx+fORrH3aKLOwT/0WxL61G6v1dWifuZTXokXEYpw6uuR8tNGNqvhMJB90cBowdj0DJY3ZwBRo2N6XLWSaNQkiwteaMppUp65cdcPyY730XJYGUVLfL2hAqUYhEGvPlyF3iZGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=hxrhvjyC; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=0tNxeAnb; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="hxrhvjyC";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="0tNxeAnb"
Received: from pps.filterd (m0167077.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 689If9iC849931
	for <linux-block@vger.kernel.org>; Wed, 9 Sep 2026 15:39:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=DIRO
	lFF1/K73bb2LBF+3C9pSGmL+Mm0FCwxxToDtaLI=; b=hxrhvjyCMDfnYBDJ0Z34
	Xtt28Egqcjd3TE8quAcU96pvLA2dMOFrfyZouCHErr8ymCQAKYg0RBp2w2E7ceLP
	195GMP5u2MHfCg4+/i2z4el7N4kptv7lRpSravAwpOhcJFHNAiSKrzllFpWt2fUe
	MVbi06a6pwps4nkoLBbbUiK2EEnaXw8hMoYKmkygkh47OrJSRPhWlmG69BUPgL23
	MkCt/uwh0EI3OfYvxsyFA5l4LbxqCflpjjio0FBkhttlcrgfQIG7+OomnfaGUqx/
	TU22ArYBw2KYo0yhciH7SSMGRkCLp+w3nRwVdh6AqeZlm4hEG8j6oa6OUdMHn6ds
	VQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4gkcy10h3w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Wed, 09 Sep 2026 15:39:49 -0400 (EDT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-52d33c89a29so137699451cf.1
        for <linux-block@vger.kernel.org>; Wed, 09 Sep 2026 12:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1788982789; x=1789587589; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DIROlFF1/K73bb2LBF+3C9pSGmL+Mm0FCwxxToDtaLI=;
        b=0tNxeAnbGLf4r1LviQVMx9OiRCdG/tsOBMCBgrU5136bpLHHqj7JQKJjceJgVbqbIY
         6AdWylrEcK4Q52Oszot5Mr9Qnh42o2+a6vbVDEffCx9AYeFFcoO+yZrmdqCj+dlzMNOm
         +8TE3rLQwGkqEx8INliaS+PRfGxw/ZCGOaJQevVa+KmHyLL3PO+u7FjMqjGBX8i8M1Ic
         LckzoI6G6G12djzz5B9LGHDAPKGw+dpcsQVPzFgjj1in1UIYWtO8l+u7sFJhlRtqDqwF
         Yt9Gku8tOjHAW3ly+yXDy2jkK+FEXdVfmyZpYXDS2Q+e4iOjlT7pYbT/YZM/cp8PZ+z7
         esiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788982789; x=1789587589;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DIROlFF1/K73bb2LBF+3C9pSGmL+Mm0FCwxxToDtaLI=;
        b=VII7kChDA9OI1zbcswKSJaMikWrKyExy1fDhCFnxibW8RjCbtoWQWCjAoHih3KMPTM
         XeJTv+fETeoaWOc0hydKymW/LrmMgFEGkM4MnbbwVklxdXy/OIerUBZMEBYiwBWkmQhT
         MwzSTmjru/ZxMXuZSFBH+3vC2tjey8OuwAkgecuLXfFtAqmJxTL6DIQZTay48LnF4pui
         jFsIWFVMvtmolMP2Fu6ktjIVS70DXMAZs1COPGj5ZBqOo+r7XYjNIV5LtoiJFe/M48R3
         JJ+qrPi/Me/cr6DWCZwUd/dyrwyBIwccoEYkiX24GFpDAhfECXn/MoiQ61HqprlyBr7v
         5yAA==
X-Forwarded-Encrypted: i=1; AKwUvBzqVOcCra7htwxY1kzWHWWj8XYF/1vp7qR0BPhqkuNZFSPvtrQ28T+/ldeVoJsj2jqMxbzrjYfQxxadvw==@vger.kernel.org
X-Gm-Message-State: AFuF++nTvVsR7gmKbIYabIgMq7RMgcXIbImvSMSxtSndL7QH8cEwYefH
	b+FEdIOBHBGFVeDt9LiGSYosk7ntaQKJycY666AD889ns9DdHW/9yG+SzDerGKEhIMFUbrmeXM1
	l1b5bnziKBRGZAZZnPMQ+ONRNAtScZ6+ZLq2uuaKLllJ5TFFpBbBoaiesysxW7Df2vW5PJ+s=
X-Gm-Gg: AYBFou1HgHxrzNzFhEl+q4R9A4I7A2NEhvpiQemXwWPbrBL3B1yHKxDwPmRaBeystxG
	/yS6GVPs5wn5yhBVEg1Yj1GtSkDUXbUEMXv0F2UDcuACaZ6pzZBd+rsfZ3JQ/32iqxQFL0fdS7u
	Tawe+dbpBo5Pcw0KmVrjZgal367Xi3DTD0htPR0XY/CvfR3PTRxGIe2Gu+hbjPe2Q2IVQ9lQz+M
	cFo92khqkFWl6wvOXttvbIj2uTcUVJNZ/8opEKpAlOuMNzL0cMg/kThnFMejH5kkvlFcpxCKncZ
	VG5sCpCbz9esDAY0gmbUXmrcIjxDOTsp36km+gTnELSR/ynpabz9Juvqw0Df5TXOMTrYxVFUWFw
	aEHb9d9AQp7MfFM7PMS4wNvJV9trOhefFnmt4oTQSpnTf8wPs
X-Received: by 2002:a05:622a:646:b0:52f:b627:6091 with SMTP id d75a77b69052e-530aeaf92d1mr50257341cf.5.1788982788583;
        Wed, 09 Sep 2026 12:39:48 -0700 (PDT)
X-Received: by 2002:a05:622a:646:b0:52f:b627:6091 with SMTP id d75a77b69052e-530aeaf92d1mr50256801cf.5.1788982788000;
        Wed, 09 Sep 2026 12:39:48 -0700 (PDT)
Received: from [127.0.1.1] (nat-128-59-176-193.net.columbia.edu. [128.59.176.193])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-530868ceb68sm83026191cf.29.2026.09.09.12.39.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 12:39:46 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Wed, 09 Sep 2026 15:39:29 -0400
Subject: [PATCH blktests 2/3] block/050: add a splice read race test for
 block devices
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-blkdev-fixes-tests-v1-2-1f8af8665d16@columbia.edu>
References: <20260909-blkdev-fixes-tests-v1-0-1f8af8665d16@columbia.edu>
In-Reply-To: <20260909-blkdev-fixes-tests-v1-0-1f8af8665d16@columbia.edu>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>, Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788982781; l=7576;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=5mYluXL3APFeNnvNX/sl51f51jpUVVFIocJDOuJGSOo=;
 b=M5QG65VumjYnaJN0i/2MBfE5KGP/NM3LKgF/Ae+xMRzpewODBMBbrT01GlrCoVmx01bm7Bn/t
 JwD6q7HaU0fCsrZuyv05iIJQcZxZnCfpxHsUQupfrQhyGDteriHlRaJ
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Authority-Analysis: v=2.4 cv=FrWQbGrq c=1 sm=1 tr=0 ts=6aa1b605 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=fJxgZNdXt3opHMdyAp+FXA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=QOCMdifcju39GKoXhKua:22
 a=VwQbUJbxAAAA:8 a=BO-O2x_ebyKE4gWa1f0A:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDIxOSBTYWx0ZWRfX9QQ/ecCHMbGq
 YWTvUsoHoucrAavmyiUMiGC7QZbmfIUGbtAg+SCy61BqJVCgAzrU9tibd9/rYjzAtWVGm5KStVu
 W7Mx0G9KsgrhGHtq0dvJ6WxLxu4+E1bo5Q8SBQ2mYfVPUawqbjL/
X-Proofpoint-ORIG-GUID: cbEAC-Iq3QlMcRB-coFsmUI4l-5y_kLK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDIxOSBTYWx0ZWRfXxvQEu3cksFp9
 0s6sS5zgYfNLqEqWt1AP/T0CXiOMfiagCTNw0Yv/27eMn0RJ2cnAn5vUnUZ4ksH3TquE1KWpOVT
 c8ZQxQmMjXFbfAGUxhAnAldZsxdAxyEHsk7X6rdmpzwAyAai3JQpCxDCYapw+9UttAykmC0rYkY
 /g2K3V/5/k1A+Wz2wZR3NTQybrfSlIqPbf6GoDHwRZM+qEmZxWuu6TGE802ROk7KM5ptJ/0gT9X
 ChyWSZgskABTHbLy/UvDgzPIpoxGg406TJx+o82U5TuN72PpftDRjw83ms3wVfCvNIMmyX91q/Q
 uE2qbTsQ5v10lQge4bXFi3juYTx1k/anSMw2GfYEw/poC9/IgX8DypCjPDh+MrbS+CnGTV0Ij0I
 hrK9mEmzEvVNp4xwkkQ8tKgnG2F3C9XrWb/lsREtLQNHLGzbEUembqRAYjP5BhK5iCyPIImpt3O
 /NBrGbqW42DTocW7Dtg==
X-Proofpoint-GUID: cbEAC-Iq3QlMcRB-coFsmUI4l-5y_kLK
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11900
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 spamscore=0 bulkscore=10 lowpriorityscore=10
 suspectscore=0 impostorscore=10 phishscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609090219

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

[1]: https://lore.kernel.org/linux-block/20260828-blkdev-fixes-v2-3-32f3f40cebed@columbia.edu/

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
index f789ff6..328f2c5 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -32,7 +32,8 @@ C_TARGETS := \
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

