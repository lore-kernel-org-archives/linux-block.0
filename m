Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82BA5476E6
	for <linux-block@vger.kernel.org>; Thu, 15 Oct 2026 16:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792081799; cv=none; b=m10TgvLv5hpaovL8b76MnwgL/xUrJy4Uao3OY6vbWLJu9JWCvqYXakhVZq4Rb2teukSCN5I8kEOhJsHJQuE1fLrtbSiLHL4h/OPptNmPJ1qqZMZOK5NZ7ssK58Rqg+7tTXpIqQbUaTbzk/E5a+RK8lDrkLp0wPBvlOwN0DrXa0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792081799; c=relaxed/simple;
	bh=mHOAyiyy81WJZTCe5P1ASgo7dqATnb0LORfpDxe3T00=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lTlf6nMAs7Clq3s1KDyyVBxp9sTY7YBJQOkhpQhEmo7E9nNEH1Zd3Vk7hV+8N0K8h2PeDhrRQpBsigsq0hxN4E+pD6IA0ne4PxiW50Uce9v28OcLCbnMylWYGpLjj12TcPlpfgNzFhhxArt969WQK6fieQx2TGz0Ld/D1JGF0wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=ZMqOOhI9; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=nNlo7AtD; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="ZMqOOhI9";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="nNlo7AtD"
Received: from pps.filterd (m0167071.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69FFbYjc2449024
	for <linux-block@vger.kernel.org>; Thu, 15 Oct 2026 12:29:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=lbNN
	KU2cBILeREFcF419aCP/fGQXAg5fGqMK+gbNsqY=; b=ZMqOOhI9CNtXDOqMQwTV
	MpD10Zn7O1ZYrMO11VhoTAInMIFgqT2tkBCX9NGK+Ibpam2jh9SkmTO16/fR4oRg
	qIfQM2gKLJLVj/OeyNyjkeOKspzwjmEKJI73ytCxohQVbvo0k7enz376NAXBIUfl
	rz3x13AjCyjTTCOPDDvkYgveE5tClorpsBzFs7wZAqFSDlfM5Kq2Dh/2IGyQttBI
	/YuWxZdNGONOV5Au/00fDOZCmtTwYDljSFslhNYaACZZfKFD8cp92EeJrN0y8fly
	XVZP6Ro0WsQmhFj9k7MJhycopQI1AAhYeJF/dgoRMj/rmb+5TGfZDTELmxnW2XZL
	vQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4hb1mv8g6y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Thu, 15 Oct 2026 12:29:42 -0400 (EDT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-91785bd637bso172626166d6.1
        for <linux-block@vger.kernel.org>; Thu, 15 Oct 2026 09:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1792081762; x=1792686562; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lbNNKU2cBILeREFcF419aCP/fGQXAg5fGqMK+gbNsqY=;
        b=nNlo7AtDGVFZclqfTLxA4EOMOMLoCK38ROtDClgaF5qTZ1H9Z+9Qh8yec7vyDUFp7m
         Z5ka5eogMXorRaOOrbIYmYR/6oO6zdYQQJAKqGXkraGcqfAtBwXrL3k9ewqiyR0axMqt
         KBW5nsmh/DnBVMJrB+UlZK2nIpwhiY1rtwPPN/yXAN6vwWnvU37OFiCxZ+QMuEBvYydT
         VbQXGCXnulKpZlzusSVdGBEKNvvsSiIRRlM+PKjg40q+OgE+kDzN4QbSGOiibwf1akOt
         rYWHsaJB+M4+eOgmihZZSXos7bwl7FtoYc4JZw3nXpU7FZdPwyArHLjk47CR80gL9QFZ
         2XFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792081762; x=1792686562;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lbNNKU2cBILeREFcF419aCP/fGQXAg5fGqMK+gbNsqY=;
        b=TYdR5+d8t3YMxFgUJkMYGtPn/iOP8ukrswS43UpN95DKiFTzSqCmYp50SntAxJLhFK
         H71W/KlF4qviq/CWfaCYKCa2T4JBO0CkgZIWh+1womPJG84AOjW4E6GEWNtD0Q1MB+3z
         bTPh+joz+rCR8nPQxhjD3hmAauSPTvmm/LhIgVXYvs61dFU5qHX69u5TeYjHvzhW98Lj
         bvMBTr3AG6/vs2sO8k8TINqBYxTjlLBoEOciVKU+cCs5jedEr/IwdlgmoIN5xHdxG3Qt
         DDytt5NwRczNolz+JzP0TDgSHLxInKy8VbKhyfTBjLcQGLCn4MzXbL0KIrbSpVY/fu3S
         7fsw==
X-Forwarded-Encrypted: i=1; AKwUvBxy3JuV3MDG86gvU/YI3kxfND8EQjS3ioO13dMVHjkF9MlDiF3gOMZxoija+vb3wZLJa2yanzJ7sC3jRQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYKcgSRIW0RUCw5H3jOghtjQVRsNQ6QDD61P76lpAagbjSC7kA/Q
	gSpNluWK5Uju5sNoLcdki9N/vnAcoL0W1rKQ5mbSi3yW7QI0z5ON8OKNJa9LDBk4qX84fdgJJ+e
	Umy40mStwQlzwkdIvF+dTibc4ZvLslOhocXmtg2wgXH+rKUjuSe4GdwAp55VNVhDL/42H
X-Gm-Gg: AYBFou1LoDRLkdtzRWBUWoxIE/JPUFiymhdrjBm1QoMNvOY7AA//SW+Rd1f0pUuaL+V
	OSP07JPYM4/xzBAPeOMNLKqBtuHvEBXgadNZCUeYN87ezj5T+H6rrMIvhoP7aTsFeZF3zyr0Rgf
	mQYnBTa/AQP8H6encbKKeoWLWvHNEUwzX2gK/IKJPow2EFAT4ZJyEAtXnbmPCqqhOZKecAdZHf5
	ZIlpnlVzL4ZXMIzKYwfX842hArsizMyWZPVUQMYxfrBIeszd03nzzU/OkZ43kb0EK+02ICs7uHX
	kdFDgRrDGBkaIt8Ddcwc529XKGsih1I2JQfuXuh4QVr7M0duK/2iHbUH4ndmx2tEns/eLmnAvMC
	Uk5WxHbgaAYpxjBUnCkXqS53do5fjJ8LN3ykRn76XM84N
X-Received: by 2002:a05:620a:3707:b0:93e:767f:345c with SMTP id af79cd13be357-93ebd25b8bemr3302779485a.39.1792081761451;
        Thu, 15 Oct 2026 09:29:21 -0700 (PDT)
X-Received: by 2002:a05:620a:3707:b0:93e:767f:345c with SMTP id af79cd13be357-93ebd25b8bemr3302774485a.39.1792081760836;
        Thu, 15 Oct 2026 09:29:20 -0700 (PDT)
Received: from [127.0.1.1] (nat-128-59-176-51.net.columbia.edu. [128.59.176.51])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93ef5086fe3sm803716285a.37.2026.10.15.09.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 09:29:20 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Thu, 15 Oct 2026 12:29:11 -0400
Subject: [PATCH blktests v3 1/4] block/050: add a direct I/O write fallback
 race test for block devices
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-blkdev-fixes-tests-v3-1-b6ffa6410514@columbia.edu>
References: <20261015-blkdev-fixes-tests-v3-0-b6ffa6410514@columbia.edu>
In-Reply-To: <20261015-blkdev-fixes-tests-v3-0-b6ffa6410514@columbia.edu>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>, John Garry <john.garry@linux.dev>,
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792081758; l=11348;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=mHOAyiyy81WJZTCe5P1ASgo7dqATnb0LORfpDxe3T00=;
 b=WqopW3VoBd4M2fX6AASXx6OrH/FN3mhuMuTSNJ9961wG0Jzl+u8FE7Vhra/dlyIqPYXzd4LSz
 UBecgCTydM7BmwdFoZJqaC6W21th1f4BQfvvbsbh5irFBcETdVNsrWM
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Authority-Analysis: v=2.4 cv=HeyB3SE8 c=1 sm=1 tr=0 ts=6ad0ff76 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=NKoNGjn6KhAaSQkl0TXC/A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=79PYxaXUQd1wl-QFWJnA:22
 a=VwQbUJbxAAAA:8 a=2Qm6IutkKbbWaStAUrAA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-GUID: 9xS-zd_1p2gbCB0UJhIhs-sLSgNfuxqV
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA2NSBTYWx0ZWRfX4AY3gDNgCsP4
 o0B36rdY0lvYXbMAeUYThBfNM0jLR3w5jrKbFrrh3ocMRFKS1r3itQojMkt55QKIeEjNXJ3C1xa
 nSasGvRzy//n5eGOA+8U8+fJge9LIQ4g0JtFGXJaEsEDKuxYoWhV
X-Proofpoint-ORIG-GUID: 9xS-zd_1p2gbCB0UJhIhs-sLSgNfuxqV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA2NSBTYWx0ZWRfX+0wOwTVwiutq
 luF+ETihjqaHmZsb9oNtlGLBooOkus6f5iyNYCms265cvTiV6zOptmZiMj3MG09R4ObepM5DusC
 azKjRcJueg82m70gG4kMQ1Tx3xOO1SHSst1Us3tYWSzKVIBwVLGmyxj+CzCPXblfnu2Un+I/IGe
 nPuU4yBpaYaZyQnJ3MlvyQIldd8g5VzrAA0R3TuMV/2KGNcqzcnnB7jgI5jpt4LuzP3dijnjDHs
 w8uXB8DiLoyM9xbCTRa64061GtQK/HEAq2kX9Ws62w+kPq/TeVuMD9V+5DW2OgJcN9rBIqPO+pb
 qy6oA4EL2ZVK/r585wiQVv3Ect8cIeYAObVv1uO/EJngl2EMthL9BTNHJYX3VWDif9bqyH5oO3B
 6YqfXkzyQFXtLEJ7N+RkJFK8KQRnYfxLMshtBkVd5lx/pjNezI3yA7Zi5muF1g2jIDKh1HMnK/p
 QofpRZ9McvB3k8xj8cg==
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11936
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=10 adultscore=0 bulkscore=10 suspectscore=0
 lowpriorityscore=10 spamscore=0 malwarescore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150065

A direct write to a block device that completes only partially finishes
as a buffered write through the direct I/O fallback. That buffered write
has to hold i_rwsem like the plain buffered write path, so that it does
not race set_blocksize() raising the mapping's minimum folio order and
add a folio that is too small for the mapping.

This is a regression test for that issue, fixed in the kernel patch
"block: take i_rwsem for the direct I/O write fallback" [1].

Issue O_DIRECT pwritev() to a memory-backed null_blk device with a
two-segment iovec whose second segment is an unreadable PROT_NONE
mapping, so that the direct path returns short and enters the fallback.
Meanwhile toggle the second segment's protection so that some fallbacks
get past the fault-in and reach the page cache, populate the page cache
with folios of the current block size, and toggle the block size between
512 bytes and 64K with BLKBSZSET. A CONFIG_DEBUG_VM kernel reports the
folio order mismatch as a BUG, which blktests picks up from dmesg.

The minimum folio order only moves with block sizes above the page size,
i.e. with CONFIG_TRANSPARENT_HUGEPAGE raising BLK_MAX_BLOCK_SIZE to 64K.

[1]: https://lore.kernel.org/linux-block/20261009-blkdev-fixes-v6-2-307939c387df@columbia.edu/

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 src/.gitignore          |   1 +
 src/Makefile            |   7 +-
 src/dio-fallback-race.c | 251 ++++++++++++++++++++++++++++++++++++++++++++++++
 tests/block/050         |  57 +++++++++++
 tests/block/050.out     |   2 +
 5 files changed, 317 insertions(+), 1 deletion(-)

diff --git a/src/.gitignore b/src/.gitignore
index e9869e1..754beef 100644
--- a/src/.gitignore
+++ b/src/.gitignore
@@ -1,5 +1,6 @@
 /bio-bounce-read
 /bio-full-trim
+/dio-fallback-race
 /dio-offsets
 /discontiguous-io
 /loblksize
diff --git a/src/Makefile b/src/Makefile
index 1e571c6..06cade9 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -34,6 +34,7 @@ C_URING_TARGETS := metadata \
 	metadata-iopoll \
 	nvme-passthru-admin-uring
 C_UBLK_TARGETS := miniublk
+C_THREAD_TARGETS := dio-fallback-race
 
 HAVE_LIBURING := $(call HAVE_C_MACRO,liburing.h,IORING_OP_URING_CMD)
 HAVE_UBLK_HEADER := $(call HAVE_C_HEADER,linux/ublk_cmd.h,1)
@@ -45,7 +46,7 @@ CXX_TARGETS := \
 SYZKALLER_TARGETS := \
 	sg/syzkaller1
 
-TARGETS := $(C_TARGETS) $(CXX_TARGETS) $(SYZKALLER_TARGETS)
+TARGETS := $(C_TARGETS) $(C_THREAD_TARGETS) $(CXX_TARGETS) $(SYZKALLER_TARGETS)
 
 ifeq ($(HAVE_UBLK_HEADER), 1)
 ifeq ($(HAVE_NEW_UBLK_INTF), 1)
@@ -70,6 +71,7 @@ override CXXFLAGS := -O2 -std=c++11 -Wall -Wextra -Wshadow -Wno-sign-compare \
 		     -Werror $(CXXFLAGS) $(CONFIG_DEFS)
 URING_FLAGS :=  -D_GNU_SOURCE
 URING_LIBS := -lpthread -luring
+THREAD_LIBS := -lpthread
 LDFLAGS ?=
 
 all: $(TARGETS)
@@ -90,6 +92,9 @@ $(CXX_TARGETS): %: %.cpp
 $(SYZKALLER_TARGETS): %: %.c
 	$(CC) $(CFLAGS) -Wno-unused-but-set-variable $(LDFLAGS) -o $@ $^
 
+$(C_THREAD_TARGETS): %: %.c
+	$(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(THREAD_LIBS)
+
 $(C_URING_TARGETS): %: %.c
 	$(CC) $(CFLAGS) $(LDFLAGS) $(URING_FLAGS) -o $@ $^ $(URING_LIBS)
 
diff --git a/src/dio-fallback-race.c b/src/dio-fallback-race.c
new file mode 100644
index 0000000..62475b4
--- /dev/null
+++ b/src/dio-fallback-race.c
@@ -0,0 +1,251 @@
+// SPDX-License-Identifier: GPL-3.0+
+/*
+ * Copyright (C) 2026 Tal Zussman
+ *
+ * Race partial O_DIRECT writes to a block device against BLKBSZSET.
+ *
+ * Writer threads issue O_DIRECT pwritev() with a two-segment iovec whose
+ * second segment is an unreadable PROT_NONE mapping. The direct path writes
+ * the first segment, fails to pin the second and returns short, so the write
+ * finishes as a buffered write through the direct I/O fallback. A second
+ * thread toggles the second segment's protection so that some fallbacks get
+ * past fault_in_iov_iter_readable() and reach the page cache, a third
+ * populates the page cache with folios of the current block size, and a
+ * fourth toggles the block size between 512 bytes and 64K with BLKBSZSET.
+ *
+ * The fallback has to run under i_rwsem like the plain buffered write path.
+ * If it does not, it races set_blocksize() raising the mapping's minimum
+ * folio order and adds a folio that is too small for the mapping, which a
+ * CONFIG_DEBUG_VM kernel reports as a BUG. The caller checks dmesg.
+ *
+ * usage: dio-fallback-race <blockdev> <seconds>
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
+#include <sys/mman.h>
+#include <sys/uio.h>
+#include <unistd.h>
+
+#include <linux/fs.h>
+
+#define GOOD		(8 * 1024)		/* written by the direct path */
+#define BAD		(64 * 1024)		/* unreadable, forces a short write */
+#define RANGE		(2 * 1024 * 1024)	/* keep the race on a few folios */
+#define NR_WRITERS	2
+
+#define SMALL_BS	512
+#define LARGE_BS	(64 * 1024)
+
+static const char *dev;
+static long pgsz;
+static char *badseg;
+static int bszfd;
+static volatile int stop;
+static int failed;
+
+/* partial direct write, finished as a buffered write by the fallback */
+static void *writer(void *arg)
+{
+	struct iovec iov[2];
+	off_t off = 0;
+	char *good;
+	int fd;
+
+	fd = open(dev, O_RDWR | O_DIRECT);
+	if (fd < 0) {
+		perror("open");
+		failed = 1;
+		return NULL;
+	}
+
+	if (posix_memalign((void **)&good, pgsz, GOOD)) {
+		perror("posix_memalign");
+		failed = 1;
+		goto out_close;
+	}
+	memset(good, 'A', GOOD);
+
+	iov[0].iov_base = good;
+	iov[0].iov_len = GOOD;
+	iov[1].iov_base = badseg;
+	iov[1].iov_len = BAD;
+
+	while (!stop) {
+		ssize_t n = pwritev(fd, iov, 2, off);
+
+		if (n < 0) {
+			perror("pwritev");
+			failed = 1;
+			break;
+		}
+		/* The direct part always lands; the fallback may add to it. */
+		if (n < GOOD) {
+			fprintf(stderr, "pwritev returned %zd, below %d\n", n,
+				GOOD);
+			failed = 1;
+			break;
+		}
+		off = (off + GOOD) % RANGE;
+	}
+
+	free(good);
+out_close:
+	close(fd);
+	return NULL;
+}
+
+/* let some fallbacks get past the fault-in and into the page cache */
+static void *flipper(void *arg)
+{
+	while (!stop) {
+		if (mprotect(badseg, BAD, PROT_READ | PROT_WRITE) ||
+		    mprotect(badseg, BAD, PROT_NONE)) {
+			perror("mprotect");
+			failed = 1;
+			break;
+		}
+	}
+
+	return NULL;
+}
+
+/* populate the page cache with folios sized for the current block size */
+static void *reader(void *arg)
+{
+	off_t off = 0;
+	char *buf;
+	int fd;
+
+	fd = open(dev, O_RDONLY);
+	if (fd < 0) {
+		perror("open");
+		failed = 1;
+		return NULL;
+	}
+
+	buf = malloc(GOOD);
+	if (!buf) {
+		perror("malloc");
+		failed = 1;
+		goto out_close;
+	}
+
+	while (!stop) {
+		if (pread(fd, buf, GOOD, off) < 0) {
+			perror("pread");
+			failed = 1;
+			break;
+		}
+		readahead(fd, off, RANGE / 4);
+		off = (off + GOOD) % RANGE;
+	}
+
+	free(buf);
+out_close:
+	close(fd);
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
+	pthread_t writers[NR_WRITERS];
+	pthread_t flipper_t, reader_t, resizer_t;
+	int status = EXIT_FAILURE;
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
+	pgsz = sysconf(_SC_PAGESIZE);
+	if (pgsz < 0) {
+		perror("sysconf");
+		return EXIT_FAILURE;
+	}
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
+		goto out_close;
+	}
+
+	badseg = mmap(NULL, BAD, PROT_NONE, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	if (badseg == MAP_FAILED) {
+		perror("mmap");
+		goto out_close;
+	}
+
+	for (i = 0; i < NR_WRITERS; i++) {
+		if (spawn(&writers[i], writer))
+			return EXIT_FAILURE;
+	}
+	if (spawn(&flipper_t, flipper) || spawn(&reader_t, reader) ||
+	    spawn(&resizer_t, resizer))
+		return EXIT_FAILURE;
+
+	sleep(atoi(argv[2]));
+	stop = 1;
+
+	for (i = 0; i < NR_WRITERS; i++)
+		pthread_join(writers[i], NULL);
+	pthread_join(flipper_t, NULL);
+	pthread_join(reader_t, NULL);
+	pthread_join(resizer_t, NULL);
+
+	if (!failed)
+		status = EXIT_SUCCESS;
+
+	munmap(badseg, BAD);
+out_close:
+	close(bszfd);
+	return status;
+}
diff --git a/tests/block/050 b/tests/block/050
new file mode 100755
index 0000000..aa5622a
--- /dev/null
+++ b/tests/block/050
@@ -0,0 +1,57 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2026 Tal Zussman
+#
+# Race partial O_DIRECT writes to a block device against BLKBSZSET. A direct
+# write that completes only partially finishes as a buffered write through the
+# direct I/O fallback, which has to hold i_rwsem like the plain buffered write
+# path so that it does not race set_blocksize() raising the mapping's minimum
+# folio order. Without it, the fallback adds a folio that is too small for the
+# mapping, which a CONFIG_DEBUG_VM kernel reports as a BUG.
+#
+# Regression test for patch "block: take i_rwsem for the direct I/O write
+# fallback".
+
+. tests/block/rc
+. common/null_blk
+
+DESCRIPTION="race the direct I/O write fallback against BLKBSZSET"
+TIMED=1
+
+requires() {
+	_have_null_blk
+	_have_kernel_option TRANSPARENT_HUGEPAGE
+	_have_kernel_option DEBUG_VM
+	_have_src_program dio-fallback-race
+	if (( $(_get_page_size) >= 65536 )); then
+		SKIP_REASONS+=("a 64K block size is not above the page size")
+		return 1
+	fi
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	# the race hits about once a minute on an unfixed kernel
+	: "${TIMEOUT:=60}"
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
+	if ! src/dio-fallback-race /dev/nullb1 "${TIMEOUT}" >>"${FULL}" 2>&1; then
+		echo "dio-fallback-race helper failed"
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

