Return-Path: <SRS0=9MH5=U6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E2D1C0650E
	for <linux-block@archiver.kernel.org>; Mon,  1 Jul 2019 15:41:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00B9420B7C
	for <linux-block@archiver.kernel.org>; Mon,  1 Jul 2019 15:41:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727511AbfGAPly (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Jul 2019 11:41:54 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46110 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727279AbfGAPly (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 Jul 2019 11:41:54 -0400
Received: by mail-pl1-f193.google.com with SMTP id e5so7529004pls.13
        for <linux-block@vger.kernel.org>; Mon, 01 Jul 2019 08:41:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lKJRwTOmRtqiB32mnxV3ABnx+PZWGgut2AX/QL8fMFU=;
        b=WSfbjYSy2JtI4xkyiLjfh0mrmxHcDpieQGlET3tpQmD8SySEUpfsHdaL4B64nLew2+
         olOX7eJcOpQcB4LAEL9oKsJJ6aNS/GtzTUoa3X2PqgTt6aGM3CuCJs8rQDlFy1QqoHYe
         RTuXcvhNVcxKBcpY/+QQ6kMnO8XReQ8mWA/eFcZb96jjQKgFzCAJO3d+pZKmSR6QStXf
         NGpBCP9IwhOVymrnJDeQBWgYo9Z7M3bpCl1px8bKMS1HxPgPuJe9/TNrItYhnkaaWxrv
         DW+jCcqEszyvTQIpiUHDrmwhL8rrQfms3mUa4+GqQ5dWEXsAVDF4ao7B9vBUjg0hSGEt
         XMPA==
X-Gm-Message-State: APjAAAXk9o7XKdJ52iex1zYR4dFEJMM05nMFUhYoGidORrqPd1q/xMMb
        /9Sch45hOzoFniMN27eqDJQ=
X-Google-Smtp-Source: APXvYqxIZ6Z8NAzhfxVXo9EUgfQ+J5LZ6diEzFO9OaGfhY+WhAxW7A4Ryj0va7y8qD8OgZbKMIP+9A==
X-Received: by 2002:a17:902:205:: with SMTP id 5mr27764500plc.165.1561995712983;
        Mon, 01 Jul 2019 08:41:52 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id t2sm8865502pgo.61.2019.07.01.08.41.51
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 01 Jul 2019 08:41:51 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH] tools/io_uring: Use <asm/barrier.h> instead of tools/io_uring/barrier.h
Date:   Mon,  1 Jul 2019 08:41:45 -0700
Message-Id: <20190701154145.202722-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch avoids that multiple definitions of barrier primitives occur in
the tools directory. This patch does not change the behavior of the code on
x86 since on x86 smp_rmb() and smp_wmb() are defined as follows in
tools/arch/x86/include/asm/barrier.h:

 #define barrier() __asm__ __volatile__("": : :"memory")
 #define smp_rmb() barrier()
 #define smp_wmb() barrier()

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 tools/io_uring/barrier.h        | 16 ----------------
 tools/io_uring/io_uring-bench.c | 12 ++++++------
 tools/io_uring/liburing.h       |  4 ++--
 tools/io_uring/queue.c          | 14 +++++++-------
 4 files changed, 15 insertions(+), 31 deletions(-)
 delete mode 100644 tools/io_uring/barrier.h

diff --git a/tools/io_uring/barrier.h b/tools/io_uring/barrier.h
deleted file mode 100644
index ef00f6722ba9..000000000000
--- a/tools/io_uring/barrier.h
+++ /dev/null
@@ -1,16 +0,0 @@
-#ifndef LIBURING_BARRIER_H
-#define LIBURING_BARRIER_H
-
-#if defined(__x86_64) || defined(__i386__)
-#define read_barrier()	__asm__ __volatile__("":::"memory")
-#define write_barrier()	__asm__ __volatile__("":::"memory")
-#else
-/*
- * Add arch appropriate definitions. Be safe and use full barriers for
- * archs we don't have support for.
- */
-#define read_barrier()	__sync_synchronize()
-#define write_barrier()	__sync_synchronize()
-#endif
-
-#endif
diff --git a/tools/io_uring/io_uring-bench.c b/tools/io_uring/io_uring-bench.c
index 0f257139b003..3ce715247c5e 100644
--- a/tools/io_uring/io_uring-bench.c
+++ b/tools/io_uring/io_uring-bench.c
@@ -28,9 +28,9 @@
 #include <string.h>
 #include <pthread.h>
 #include <sched.h>
+#include <asm/barrier.h>
 
 #include "liburing.h"
-#include "barrier.h"
 
 #define min(a, b)		((a < b) ? (a) : (b))
 
@@ -199,7 +199,7 @@ static int prep_more_ios(struct submitter *s, unsigned max_ios)
 	next_tail = tail = *ring->tail;
 	do {
 		next_tail++;
-		read_barrier();
+		smp_rmb();
 		if (next_tail == *ring->head)
 			break;
 
@@ -212,9 +212,9 @@ static int prep_more_ios(struct submitter *s, unsigned max_ios)
 
 	if (*ring->tail != tail) {
 		/* order tail store with writes to sqes above */
-		write_barrier();
+		smp_wmb();
 		*ring->tail = tail;
-		write_barrier();
+		smp_wmb();
 	}
 	return prepped;
 }
@@ -251,7 +251,7 @@ static int reap_events(struct submitter *s)
 	do {
 		struct file *f;
 
-		read_barrier();
+		smp_rmb();
 		if (head == *ring->tail)
 			break;
 		cqe = &ring->cqes[head & cq_ring_mask];
@@ -271,7 +271,7 @@ static int reap_events(struct submitter *s)
 
 	s->inflight -= reaped;
 	*ring->head = head;
-	write_barrier();
+	smp_wmb();
 	return reaped;
 }
 
diff --git a/tools/io_uring/liburing.h b/tools/io_uring/liburing.h
index 5f305c86b892..3670a08101c7 100644
--- a/tools/io_uring/liburing.h
+++ b/tools/io_uring/liburing.h
@@ -10,7 +10,7 @@ extern "C" {
 #include <string.h>
 #include "../../include/uapi/linux/io_uring.h"
 #include <inttypes.h>
-#include "barrier.h"
+#include <asm/barrier.h>
 
 /*
  * Library interface to io_uring
@@ -87,7 +87,7 @@ static inline void io_uring_cqe_seen(struct io_uring *ring,
 		 * Ensure that the kernel sees our new head, the kernel has
 		 * the matching read barrier.
 		 */
-		write_barrier();
+		smp_wmb();
 	}
 }
 
diff --git a/tools/io_uring/queue.c b/tools/io_uring/queue.c
index 321819c132c7..aadf4d926c8e 100644
--- a/tools/io_uring/queue.c
+++ b/tools/io_uring/queue.c
@@ -4,9 +4,9 @@
 #include <unistd.h>
 #include <errno.h>
 #include <string.h>
+#include <asm/barrier.h>
 
 #include "liburing.h"
-#include "barrier.h"
 
 static int __io_uring_get_cqe(struct io_uring *ring,
 			      struct io_uring_cqe **cqe_ptr, int wait)
@@ -20,13 +20,13 @@ static int __io_uring_get_cqe(struct io_uring *ring,
 	head = *cq->khead;
 	do {
 		/*
-		 * It's necessary to use a read_barrier() before reading
+		 * It's necessary to use a smp_rmb() before reading
 		 * the CQ tail, since the kernel updates it locklessly. The
 		 * kernel has the matching store barrier for the update. The
 		 * kernel also ensures that previous stores to CQEs are ordered
 		 * with the tail update.
 		 */
-		read_barrier();
+		smp_rmb();
 		if (head != *cq->ktail) {
 			*cqe_ptr = &cq->cqes[head & mask];
 			break;
@@ -77,7 +77,7 @@ int io_uring_submit(struct io_uring *ring)
 	 * read barrier here to match the kernels store barrier when updating
 	 * the SQ head.
 	 */
-	read_barrier();
+	smp_rmb();
 	if (*sq->khead != *sq->ktail) {
 		submitted = *sq->kring_entries;
 		goto submit;
@@ -94,7 +94,7 @@ int io_uring_submit(struct io_uring *ring)
 	to_submit = sq->sqe_tail - sq->sqe_head;
 	while (to_submit--) {
 		ktail_next++;
-		read_barrier();
+		smp_rmb();
 
 		sq->array[ktail & mask] = sq->sqe_head & mask;
 		ktail = ktail_next;
@@ -113,13 +113,13 @@ int io_uring_submit(struct io_uring *ring)
 		 * will never see a tail update without the preceeding sQE
 		 * stores being done.
 		 */
-		write_barrier();
+		smp_wmb();
 		*sq->ktail = ktail;
 		/*
 		 * The kernel has the matching read barrier for reading the
 		 * SQ tail.
 		 */
-		write_barrier();
+		smp_wmb();
 	}
 
 submit:
-- 
2.22.0.410.gd8fdbe21b5-goog

