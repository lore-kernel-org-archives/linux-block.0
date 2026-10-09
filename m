Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11323CF698
	for <linux-block@vger.kernel.org>; Fri,  9 Oct 2026 23:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791590034; cv=none; b=MKwXKwASKuJ7CuryhA9ayYCTxBMB+0xMYjM5pNGi0WDEECkH4pLOzohcrl0jCSfO89gsmh1Pnpt2bXNcaXhvmDr49Xwsz3UDfqhBGFUGnEdeYnRmKOfNIwcuYYZzZU21YVAQNBW2LxEp84Exvy93oYMyvMvIRoQR1BXSuyb7m0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791590034; c=relaxed/simple;
	bh=9MfsUTvtxExj4aOumircuxsPAVvgAJ+0gSt0+7S/5+4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=px1vSyVER27JllpU1hhGlgmIOV20opjwT7mdh2VzRsdvmVJv1+pknFcfFtVd6rUKmtOLLK7IV6waRZU1wNsrp7IY0XkkEu7hdDdDtjR+WpvgX/3pT76usBSB5QbfhYFXA2wVaWKp6kBfsGDKtJr3kIv/fcblSnpvYA/CycVFSEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=CvcU8Stt; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=E6LPP6EP; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="CvcU8Stt";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="E6LPP6EP"
Received: from pps.filterd (m0167071.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 699MZ2nm2056635
	for <linux-block@vger.kernel.org>; Fri, 9 Oct 2026 19:53:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=duR9
	czu0HCjQ6wXFKJcBa3Em7ds4MTohG5TeWup6DUY=; b=CvcU8SttmpfvgWP4TfqY
	xQQ/ynDrs2LA+Os0ZIifN9T898YDLts0m9jnQGsr511CjDfvFgWvO2Q6JfoJ0DVT
	tOJuL1BQSPAjDdvsoQw1tVr/JmKDRDDNIOPPhCpwfPSlwERRpvE+zslctJaO4ava
	nNt7C8EvIJxxm7kS52DSChN2Z+qNLv4kO38pBl70WZafea8dLKqu+cCtsnDG5qvH
	tLPyu0dkmjoH1J/awykpeUS1ycFiuGIY5/aTuRSxh3RQS4rnHYFnFz0wFIF2mkCF
	djQmaXDmzaGlrz/d5QY79wL5yBdMcE4xffltqirYhaTMkpe3+1nCycuS3cTJ7X8Y
	5w==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4h74tcjfk6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Fri, 09 Oct 2026 19:53:51 -0400 (EDT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93a082c014aso43808185a.0
        for <linux-block@vger.kernel.org>; Fri, 09 Oct 2026 16:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1791590030; x=1792194830; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=duR9czu0HCjQ6wXFKJcBa3Em7ds4MTohG5TeWup6DUY=;
        b=E6LPP6EPiUvhxwRP5at7iC5f96Wqb5Y7NLp3X85oJXaFmKLLBYtEcrB4E+Rt7FlbyZ
         TBIQnPQmZDWtLbkCZtKuxURVbK+X5iOqz2dem071qynTsOlGPXQa99/1RmS7f9rXJWFs
         yPLPXIuHepWQfA40kh9sRmA577d5xOhRLukeevW/DrsJalnflXyB3fVXRJCPzjIuYSjN
         ZmGaRWlLu7L3A4OQmT3qOziEDZaSmgZkT4oqwiFscCHg5+VJdJX767nIrbX9mUrMmgEs
         SGF5cxnmDT0ZhoiW9GjhivLMrNswtZYhAo/Y7MCpInARXUR/s7Cr9xEtSHCRQJCB/tqX
         ASRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791590030; x=1792194830;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=duR9czu0HCjQ6wXFKJcBa3Em7ds4MTohG5TeWup6DUY=;
        b=2T1RUxzu8XApcYqqhs5+F7C+0IezzlIjZJZTcYVGUUg7939FTpbQP09ODnmpqPhvmM
         ngDSc0Mh2x3SBCLW5lTnQDwImhfEU6jPPRW/KWqdjYK6AFJy9r0utqPHTXMoN0Gb6ERR
         fWSTJyt0hLsFJ1A51DoUlkSE8vHdABlkeVQwMOR5JN9KKUstxCIBoOnc6dlwlT4LIl5h
         mCv6ZviQbPipX6Hv/Qtd5K2Wk5Q4RV9t9LYmf0uoKlKGgIR9/5R5HVhUr+VClEKKev06
         goayfYA+U660HIJNhFqbDPg5kYrUOMTnBJiioKF61L4hhBtalgycMIvrFISvc37iK+IP
         7PqA==
X-Forwarded-Encrypted: i=1; AKwUvBxXtMCPl1wMAESRoQAMYI3nJtNSU7081/YOV7388Ysvwd7tTmaBhgR1I4TPMUzGs3CTOxRUpn5ZhWrkXw==@vger.kernel.org
X-Gm-Message-State: AFq9FYJXTFOXcUrW8NJBo0oAGUfWU/JIJwPgOIq0mZpXA64PPCD6qIq/
	XtSjyQ6rlUQBkw9q5CwArirkMBihq56g9BZ7FrCzv/NyJ0xUJgYMCWTM9FzipZTLSzcWjvNudp8
	6d4QeKjFQY/QS70i3iK+tFTt2A10iK1dEHXOcXViRVLcafpu3Orhi22goxXRO
X-Gm-Gg: AYBFou36MhAzApzrLyHuqcFjF+w7zzy2rICX9OwkalQ/IMTcK0glXoZTgccbiuWDZV3
	zh+3GyBCseLEhgk1B2iDRHZsWLyKl8kFHGX3swnPXOFKYGq1gT+knAKsLYWXyJNnmzJ5B/DyrvY
	r/Z4OGhONzYRU0ssYqb6Kek1aEygR+XotgDxm/3Lr4SB9Ta2y0OWcFSgmDMrgG3hMpzQDZ4SEkY
	2Vcxh6yUT8n7uC4rRC00g8xlDDu0srFFNw10qx3BRZslJDoNzkloojETnOBH/VhL+xLVHMbCqmh
	t9HYZVi1xnKHXxN4Z/7U/IGjGAdbHMPy1zqQXEANpqsh3V9wf5mUfh1xFX5rvYRFTy+3cBGejjU
	2vx83zh+uxcaHqcTMEK0ievZC3mzUtFEYngH6QFlG6OK5y9M=
X-Received: by 2002:a05:620a:7117:b0:93e:98a0:f9e6 with SMTP id af79cd13be357-93eb9668452mr648095885a.30.1791590030402;
        Fri, 09 Oct 2026 16:53:50 -0700 (PDT)
X-Received: by 2002:a05:620a:7117:b0:93e:98a0:f9e6 with SMTP id af79cd13be357-93eb9668452mr648093785a.30.1791590029894;
        Fri, 09 Oct 2026 16:53:49 -0700 (PDT)
Received: from [127.0.1.1] (nat-128-59-178-194.net.columbia.edu. [128.59.178.194])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93eb984889fsm304517485a.13.2026.10.09.16.53.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 16:53:49 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Fri, 09 Oct 2026 19:53:45 -0400
Subject: [PATCH blktests v2 1/4] block/049: add a direct I/O write fallback
 race test for block devices
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-blkdev-fixes-tests-v2-1-fcb3599e47f7@columbia.edu>
References: <20261009-blkdev-fixes-tests-v2-0-fcb3599e47f7@columbia.edu>
In-Reply-To: <20261009-blkdev-fixes-tests-v2-0-fcb3599e47f7@columbia.edu>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>, John Garry <john.garry@linux.dev>,
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791590027; l=10948;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=9MfsUTvtxExj4aOumircuxsPAVvgAJ+0gSt0+7S/5+4=;
 b=dN5nXQzhJGcxU5NKELpsp6eZrf7WjWJfq3xMUVuKe/rjbVlgyTwr+yNMSIgpxkhCm0D8p+xXc
 wixZiH6QZSeC7S6Ul5PLhjAFh/Fw0aaDpiopIbGTuS3MMGBpSRKCnn2
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA5NSBTYWx0ZWRfX3GnlmtDtfK+8
 /zLlF2Jzjda6M596SJCnORm/8jN/lQwG1MIjV3Dz3ocFU84nX5zrdHuV61iVAkX7+T9/FwyMCYC
 Ri7Trm24bLwR2UqFbT2FedI2+0uXfRjQjdMWFgJiTfLkhfU6qUZMkUswxPe09fIadnm4j8Ubmv3
 h0LwDKgVbQwDoogkZju/1YT8yf69rXyH4Hv6JrhpaEFWwa9LCnVua5govqCzIp07UNKmZmyyHqq
 CTogAZJOmkmSx9gzwi/lXc7OZR2o8o0E/TbuLowJn0cfcstt53cToWpxM8QprTB+KoC77dq4eWy
 R6DYWm7R18risLB56nNDe/5TRv3Y9Fy0IRrmnAeCQ2/FqFfBHTv/hAzKxScJR/gh0sgHhdHyljf
 HoEfoFRuZZiWvEJ9YtLDU2CIQE1smLryhM/2Lb7xro3z3y0v++aGJ6nCT7yK9sLgYYFxPKO6mO7
 Zf3zR+QiexLJtXccliQ==
X-Authority-Analysis: v=2.4 cv=TKTQ2Fla c=1 sm=1 tr=0 ts=6ac97e8f cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=u0MKzLA9JmpizDwXU9Rxjg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=79PYxaXUQd1wl-QFWJnA:22
 a=VwQbUJbxAAAA:8 a=2Qm6IutkKbbWaStAUrAA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: pf1-mNt6wrsBm86pt7o6Q5JRw_7LQUqJ
X-Proofpoint-GUID: pf1-mNt6wrsBm86pt7o6Q5JRw_7LQUqJ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA5NSBTYWx0ZWRfX1z6bxuSyLTXq
 ZuoLTfX4x41WJ86QEU+sGAkbggi6XXfGKpxk8D6Nxuah3QazbvwqNRviqurJTIuDQskGhpcS0qa
 teJIc3AsSDTE15+rkkwltz0rbWbc2KFYGwLDUfv00f6PpeUSeVrv
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11930
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=10 adultscore=0 suspectscore=0 clxscore=1015
 impostorscore=10 priorityscore=1501 spamscore=0 malwarescore=0 bulkscore=10
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610090095

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
 src/dio-fallback-race.c | 229 ++++++++++++++++++++++++++++++++++++++++++++++++
 tests/block/049         |  57 ++++++++++++
 tests/block/049.out     |   2 +
 5 files changed, 295 insertions(+), 1 deletion(-)

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
index dd64694..4590639 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -33,6 +33,7 @@ C_TARGETS := \
 C_URING_TARGETS := metadata \
 	nvme-passthru-admin-uring
 C_UBLK_TARGETS := miniublk
+C_THREAD_TARGETS := dio-fallback-race
 
 HAVE_LIBURING := $(call HAVE_C_MACRO,liburing.h,IORING_OP_URING_CMD)
 HAVE_UBLK_HEADER := $(call HAVE_C_HEADER,linux/ublk_cmd.h,1)
@@ -44,7 +45,7 @@ CXX_TARGETS := \
 SYZKALLER_TARGETS := \
 	sg/syzkaller1
 
-TARGETS := $(C_TARGETS) $(CXX_TARGETS) $(SYZKALLER_TARGETS)
+TARGETS := $(C_TARGETS) $(C_THREAD_TARGETS) $(CXX_TARGETS) $(SYZKALLER_TARGETS)
 
 ifeq ($(HAVE_UBLK_HEADER), 1)
 ifeq ($(HAVE_NEW_UBLK_INTF), 1)
@@ -69,6 +70,7 @@ override CXXFLAGS := -O2 -std=c++11 -Wall -Wextra -Wshadow -Wno-sign-compare \
 		     -Werror $(CXXFLAGS) $(CONFIG_DEFS)
 URING_FLAGS :=  -D_GNU_SOURCE
 URING_LIBS := -lpthread -luring
+THREAD_LIBS := -lpthread
 LDFLAGS ?=
 
 all: $(TARGETS)
@@ -89,6 +91,9 @@ $(CXX_TARGETS): %: %.cpp
 $(SYZKALLER_TARGETS): %: %.c
 	$(CC) $(CFLAGS) -Wno-unused-but-set-variable $(LDFLAGS) -o $@ $^
 
+$(C_THREAD_TARGETS): %: %.c
+	$(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(THREAD_LIBS)
+
 $(C_URING_TARGETS): %: %.c
 	$(CC) $(CFLAGS) $(LDFLAGS) $(URING_FLAGS) -o $@ $^ $(URING_LIBS)
 
diff --git a/src/dio-fallback-race.c b/src/dio-fallback-race.c
new file mode 100644
index 0000000..e5221c5
--- /dev/null
+++ b/src/dio-fallback-race.c
@@ -0,0 +1,229 @@
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
+		return NULL;
+	}
+	memset(good, 'A', GOOD);
+
+	iov[0].iov_base = good;
+	iov[0].iov_len = GOOD;
+	iov[1].iov_base = badseg;
+	iov[1].iov_len = BAD;
+
+	while (!stop) {
+		if (pwritev(fd, iov, 2, off) < 0) {
+			perror("pwritev");
+			failed = 1;
+			break;
+		}
+		off = (off + GOOD) % RANGE;
+	}
+
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
+		return NULL;
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
+		return EXIT_FAILURE;
+	}
+
+	badseg = mmap(NULL, BAD, PROT_NONE, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	if (badseg == MAP_FAILED) {
+		perror("mmap");
+		return EXIT_FAILURE;
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
+	return failed ? EXIT_FAILURE : EXIT_SUCCESS;
+}
diff --git a/tests/block/049 b/tests/block/049
new file mode 100755
index 0000000..aa5622a
--- /dev/null
+++ b/tests/block/049
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
diff --git a/tests/block/049.out b/tests/block/049.out
new file mode 100644
index 0000000..c88edfe
--- /dev/null
+++ b/tests/block/049.out
@@ -0,0 +1,2 @@
+Running block/049
+Test complete

-- 
2.39.5

