Return-Path: <SRS0=6fCZ=WQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4701FC3A589
	for <linux-block@archiver.kernel.org>; Tue, 20 Aug 2019 17:30:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 168482064A
	for <linux-block@archiver.kernel.org>; Tue, 20 Aug 2019 17:30:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728360AbfHTRaI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Aug 2019 13:30:08 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42314 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728344AbfHTRaI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Aug 2019 13:30:08 -0400
Received: by mail-pf1-f193.google.com with SMTP id i30so3786697pfk.9
        for <linux-block@vger.kernel.org>; Tue, 20 Aug 2019 10:30:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7gkzIethfV4pTtnfoFbUEMkdY76k8eMD748TLVQjTpI=;
        b=PqorhRoj+9UQC+mGHbNj/6JQuhIgY61s5AfZL3gs/zdB6cNxU7P4E4JoLmnyCaDVNT
         O2et3dDebtedZ1cUpksSI+WKN3iA6VFyCuamldFjVbX1AvoDvJqPmN3P9xHhXBL7UUFY
         migwm2PDRQu9OeffkSf4iVpjBzuEpYzA6RoXHD9NW8mnW1QufntbWG+/Er5z5CpgwLUO
         tLIoaSfT++Cf+cSYAI/yetGQ9h7lvon0KkIL/8Tel5vgV7dMQr5guU06qJOIHPAl06c6
         r24cgB8ZOyaDhgVshd+9tszJAwkqlH1W+jNDGOAcET38ExddZhRR6bM0YPvWj8oZeB9B
         7kYw==
X-Gm-Message-State: APjAAAUAkViqJ37Vt2mRIdb74jl4YH2uWoVAn3dDnRIcomKwlG3GPx9Y
        geXvLHpLIoo7iin/lw7Q81nYg9iQ
X-Google-Smtp-Source: APXvYqxvCMAWxKVHyL6NV7hjIdD9YLMDlPWdNPp54gDat+NTeBumBmxqGZ+wBXzllWsywRyymewyWA==
X-Received: by 2002:a63:2264:: with SMTP id t36mr24618183pgm.87.1566322207007;
        Tue, 20 Aug 2019 10:30:07 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id e3sm469013pjr.9.2019.08.20.10.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 10:30:04 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Roman Penyaev <rpenyaev@suse.de>,
        Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH] tools/io_uring: Fix memory ordering
Date:   Tue, 20 Aug 2019 10:29:58 -0700
Message-Id: <20190820172958.92837-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Order head and tail stores properly against CQE / SQE memory accesses.
Use <asm/barrier.h> instead of the io_uring "barrier.h" header file.

Cc: Roman Penyaev <rpenyaev@suse.de>
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 tools/io_uring/Makefile         |  2 +-
 tools/io_uring/barrier.h        | 16 ---------------
 tools/io_uring/io_uring-bench.c | 20 +++++++++---------
 tools/io_uring/liburing.h       |  9 ++++-----
 tools/io_uring/queue.c          | 36 +++++++++++----------------------
 5 files changed, 26 insertions(+), 57 deletions(-)
 delete mode 100644 tools/io_uring/barrier.h

diff --git a/tools/io_uring/Makefile b/tools/io_uring/Makefile
index 00f146c54c53..bbec91c6274c 100644
--- a/tools/io_uring/Makefile
+++ b/tools/io_uring/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 # Makefile for io_uring test tools
-CFLAGS += -Wall -Wextra -g -D_GNU_SOURCE
+CFLAGS += -Wall -Wextra -g -D_GNU_SOURCE -I../include
 LDLIBS += -lpthread
 
 all: io_uring-cp io_uring-bench
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
index 0f257139b003..29971a2a1c74 100644
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
 
@@ -199,8 +199,7 @@ static int prep_more_ios(struct submitter *s, unsigned max_ios)
 	next_tail = tail = *ring->tail;
 	do {
 		next_tail++;
-		read_barrier();
-		if (next_tail == *ring->head)
+		if (next_tail == smp_load_acquire(ring->head))
 			break;
 
 		index = tail & sq_ring_mask;
@@ -211,10 +210,11 @@ static int prep_more_ios(struct submitter *s, unsigned max_ios)
 	} while (prepped < max_ios);
 
 	if (*ring->tail != tail) {
-		/* order tail store with writes to sqes above */
-		write_barrier();
-		*ring->tail = tail;
-		write_barrier();
+		/*
+		 * Ensure that the kernel sees the SQE updates before it sees
+		 * the tail update.
+		 */
+		smp_store_release(ring->tail, tail);
 	}
 	return prepped;
 }
@@ -251,8 +251,7 @@ static int reap_events(struct submitter *s)
 	do {
 		struct file *f;
 
-		read_barrier();
-		if (head == *ring->tail)
+		if (head == smp_load_acquire(ring->tail))
 			break;
 		cqe = &ring->cqes[head & cq_ring_mask];
 		if (!do_nop) {
@@ -270,8 +269,7 @@ static int reap_events(struct submitter *s)
 	} while (1);
 
 	s->inflight -= reaped;
-	*ring->head = head;
-	write_barrier();
+	smp_store_release(ring->head, head);
 	return reaped;
 }
 
diff --git a/tools/io_uring/liburing.h b/tools/io_uring/liburing.h
index 5f305c86b892..15b29bfac811 100644
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
@@ -82,12 +82,11 @@ static inline void io_uring_cqe_seen(struct io_uring *ring,
 	if (cqe) {
 		struct io_uring_cq *cq = &ring->cq;
 
-		(*cq->khead)++;
 		/*
-		 * Ensure that the kernel sees our new head, the kernel has
-		 * the matching read barrier.
+		 * Ensure that the kernel only sees the new value of the head
+		 * index after the CQEs have been read.
 		 */
-		write_barrier();
+		smp_store_release(cq->khead, *cq->khead + 1);
 	}
 }
 
diff --git a/tools/io_uring/queue.c b/tools/io_uring/queue.c
index 321819c132c7..ada05bc74361 100644
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
@@ -20,14 +20,12 @@ static int __io_uring_get_cqe(struct io_uring *ring,
 	head = *cq->khead;
 	do {
 		/*
-		 * It's necessary to use a read_barrier() before reading
-		 * the CQ tail, since the kernel updates it locklessly. The
-		 * kernel has the matching store barrier for the update. The
-		 * kernel also ensures that previous stores to CQEs are ordered
+		 * It's necessary to use smp_load_acquire() to read the CQ
+		 * tail. The kernel uses smp_store_release() for updating the
+		 * CQ tail to ensure that previous stores to CQEs are ordered
 		 * with the tail update.
 		 */
-		read_barrier();
-		if (head != *cq->ktail) {
+		if (head != smp_load_acquire(cq->ktail)) {
 			*cqe_ptr = &cq->cqes[head & mask];
 			break;
 		}
@@ -73,12 +71,11 @@ int io_uring_submit(struct io_uring *ring)
 	int ret;
 
 	/*
-	 * If we have pending IO in the kring, submit it first. We need a
-	 * read barrier here to match the kernels store barrier when updating
-	 * the SQ head.
+	 * If we have pending IO in the kring, submit it first. We need
+	 * smp_load_acquire() here to match the kernels smp_store_release()
+	 * when updating the SQ head.
 	 */
-	read_barrier();
-	if (*sq->khead != *sq->ktail) {
+	if (smp_load_acquire(sq->khead) != *sq->ktail) {
 		submitted = *sq->kring_entries;
 		goto submit;
 	}
@@ -94,7 +91,6 @@ int io_uring_submit(struct io_uring *ring)
 	to_submit = sq->sqe_tail - sq->sqe_head;
 	while (to_submit--) {
 		ktail_next++;
-		read_barrier();
 
 		sq->array[ktail & mask] = sq->sqe_head & mask;
 		ktail = ktail_next;
@@ -108,18 +104,10 @@ int io_uring_submit(struct io_uring *ring)
 
 	if (*sq->ktail != ktail) {
 		/*
-		 * First write barrier ensures that the SQE stores are updated
-		 * with the tail update. This is needed so that the kernel
-		 * will never see a tail update without the preceeding sQE
-		 * stores being done.
+		 * Use smp_store_release() so that the kernel will never see a
+		 * tail update without the preceding sQE stores being done.
 		 */
-		write_barrier();
-		*sq->ktail = ktail;
-		/*
-		 * The kernel has the matching read barrier for reading the
-		 * SQ tail.
-		 */
-		write_barrier();
+		smp_store_release(sq->ktail, ktail);
 	}
 
 submit:
-- 
2.23.0.rc1.153.gdeed80330f-goog

