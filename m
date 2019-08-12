Return-Path: <SRS0=3NZC=WI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39F28C433FF
	for <linux-block@archiver.kernel.org>; Mon, 12 Aug 2019 12:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11D49216F4
	for <linux-block@archiver.kernel.org>; Mon, 12 Aug 2019 12:39:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbfHLMjm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 12 Aug 2019 08:39:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51864 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726496AbfHLMjm (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Aug 2019 08:39:42 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 08AFB309B68B;
        Mon, 12 Aug 2019 12:39:42 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.43.2.1])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 97CE017245;
        Mon, 12 Aug 2019 12:39:38 +0000 (UTC)
From:   Julia Suvorova <jusual@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Stefan Hajnoczi <stefanha@gmail.com>,
        Aarushi Mehta <mehta.aaru20@gmail.com>,
        Julia Suvorova <jusual@redhat.com>
Subject: [PATCH] liburing/barrier.h: Add prefix io_uring to barriers
Date:   Mon, 12 Aug 2019 14:39:33 +0200
Message-Id: <20190812123933.24814-1-jusual@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Mon, 12 Aug 2019 12:39:42 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The names of the barriers conflict with the namespaces of other projects
when trying to directly include liburing.h. Avoid using popular global
names.

Signed-off-by: Julia Suvorova <jusual@redhat.com>
---
 src/include/liburing.h         |  9 +++++---
 src/include/liburing/barrier.h | 42 ++++++++++++++++++----------------
 src/queue.c                    |  2 +-
 test/io_uring_enter.c          |  2 +-
 4 files changed, 30 insertions(+), 25 deletions(-)

diff --git a/src/include/liburing.h b/src/include/liburing.h
index fb78cd3..7d7c9df 100644
--- a/src/include/liburing.h
+++ b/src/include/liburing.h
@@ -88,9 +88,12 @@ extern int io_uring_register_eventfd(struct io_uring *ring, int fd);
 extern int io_uring_unregister_eventfd(struct io_uring *ring);
 
 #define io_uring_for_each_cqe(ring, head, cqe)					\
-	/* smp_load_acquire() enforces the order of tail and CQE reads. */	\
+	/*									\
+	 * io_uring_smp_load_acquire() enforces the order of tail		\
+	 * and CQE reads.							\
+	 */									\
 	for (head = *(ring)->cq.khead;						\
-	     (cqe = (head != smp_load_acquire((ring)->cq.ktail) ?		\
+	     (cqe = (head != io_uring_smp_load_acquire((ring)->cq.ktail) ?	\
 		&(ring)->cq.cqes[head & (*(ring)->cq.kring_mask)] : NULL));	\
 	     head++)								\
 
@@ -108,7 +111,7 @@ static inline void io_uring_cq_advance(struct io_uring *ring,
 		 * Ensure that the kernel only sees the new value of the head
 		 * index after the CQEs have been read.
 		 */
-		smp_store_release(cq->khead, *cq->khead + nr);
+		io_uring_smp_store_release(cq->khead, *cq->khead + nr);
 	}
 }
 
diff --git a/src/include/liburing/barrier.h b/src/include/liburing/barrier.h
index 98be9e5..4f3d1d7 100644
--- a/src/include/liburing/barrier.h
+++ b/src/include/liburing/barrier.h
@@ -23,7 +23,7 @@ after the acquire operation executes. This is implemented using
 /* From tools/include/linux/compiler.h */
 /* Optimization barrier */
 /* The "volatile" is due to gcc bugs */
-#define barrier() __asm__ __volatile__("": : :"memory")
+#define io_uring_barrier()	__asm__ __volatile__("": : :"memory")
 
 /* From tools/virtio/linux/compiler.h */
 #define WRITE_ONCE(var, val) \
@@ -33,27 +33,29 @@ after the acquire operation executes. This is implemented using
 
 #if defined(__x86_64__) || defined(__i386__)
 /* Adapted from arch/x86/include/asm/barrier.h */
-#define mb()	asm volatile("mfence" ::: "memory")
-#define rmb()	asm volatile("lfence" ::: "memory")
-#define wmb()	asm volatile("sfence" ::: "memory")
-#define smp_rmb() barrier()
-#define smp_wmb() barrier()
+#define io_uring_mb()		asm volatile("mfence" ::: "memory")
+#define io_uring_rmb()		asm volatile("lfence" ::: "memory")
+#define io_uring_wmb()		asm volatile("sfence" ::: "memory")
+#define io_uring_smp_rmb()	io_uring_barrier()
+#define io_uring_smp_wmb()	io_uring_barrier()
 #if defined(__i386__)
-#define smp_mb()  asm volatile("lock; addl $0,0(%%esp)" ::: "memory", "cc")
+#define io_uring_smp_mb()	asm volatile("lock; addl $0,0(%%esp)" \
+					     ::: "memory", "cc")
 #else
-#define smp_mb()  asm volatile("lock; addl $0,-132(%%rsp)" ::: "memory", "cc")
+#define io_uring_smp_mb()	asm volatile("lock; addl $0,-132(%%rsp)" \
+					     ::: "memory", "cc")
 #endif
 
-#define smp_store_release(p, v)			\
+#define io_uring_smp_store_release(p, v)	\
 do {						\
-	barrier();				\
+	io_uring_barrier();			\
 	WRITE_ONCE(*(p), (v));			\
 } while (0)
 
-#define smp_load_acquire(p)			\
+#define io_uring_smp_load_acquire(p)		\
 ({						\
 	__typeof(*p) ___p1 = READ_ONCE(*(p));	\
-	barrier();				\
+	io_uring_barrier();			\
 	___p1;					\
 })
 #else /* defined(__x86_64__) || defined(__i386__) */
@@ -61,25 +63,25 @@ do {						\
  * Add arch appropriate definitions. Be safe and use full barriers for
  * archs we don't have support for.
  */
-#define smp_rmb()	__sync_synchronize()
-#define smp_wmb()	__sync_synchronize()
+#define io_uring_smp_rmb()	__sync_synchronize()
+#define io_uring_smp_wmb()	__sync_synchronize()
 #endif /* defined(__x86_64__) || defined(__i386__) */
 
 /* From tools/include/asm/barrier.h */
 
-#ifndef smp_store_release
-# define smp_store_release(p, v)		\
+#ifndef io_uring_smp_store_release
+# define io_uring_smp_store_release(p, v)	\
 do {						\
-	smp_mb();				\
+	io_uring_smp_mb();			\
 	WRITE_ONCE(*p, v);			\
 } while (0)
 #endif
 
-#ifndef smp_load_acquire
-# define smp_load_acquire(p)			\
+#ifndef io_uring_smp_load_acquire
+# define io_uring_smp_load_acquire(p)		\
 ({						\
 	__typeof(*p) ___p1 = READ_ONCE(*p);	\
-	smp_mb();				\
+	io_uring_smp_mb();			\
 	___p1;					\
 })
 #endif
diff --git a/src/queue.c b/src/queue.c
index 74a077f..007733c 100644
--- a/src/queue.c
+++ b/src/queue.c
@@ -104,7 +104,7 @@ static int __io_uring_submit(struct io_uring *ring, unsigned wait_nr)
 	 * Ensure that the kernel sees the SQE updates before it sees the tail
 	 * update.
 	 */
-	smp_store_release(sq->ktail, ktail);
+	io_uring_smp_store_release(sq->ktail, ktail);
 
 	flags = 0;
 	if (wait_nr || sq_ring_needs_enter(ring, &flags)) {
diff --git a/test/io_uring_enter.c b/test/io_uring_enter.c
index c2030c1..8190178 100644
--- a/test/io_uring_enter.c
+++ b/test/io_uring_enter.c
@@ -266,7 +266,7 @@ main(int argc, char **argv)
 	 * Ensure that the kernel sees the SQE update before it sees the tail
 	 * update.
 	 */
-	smp_store_release(sq->ktail, ktail);
+	io_uring_smp_store_release(sq->ktail, ktail);
 
 	ret = io_uring_enter(ring.ring_fd, 1, 0, 0, NULL);
 	/* now check to see if our sqe was dropped */
-- 
2.21.0

