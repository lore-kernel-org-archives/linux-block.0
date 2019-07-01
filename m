Return-Path: <SRS0=9MH5=U6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F35EC5B578
	for <linux-block@archiver.kernel.org>; Mon,  1 Jul 2019 21:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66B3420B7C
	for <linux-block@archiver.kernel.org>; Mon,  1 Jul 2019 21:42:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbfGAVmo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Jul 2019 17:42:44 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46023 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbfGAVmn (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 Jul 2019 17:42:43 -0400
Received: by mail-pl1-f196.google.com with SMTP id bi6so7979960plb.12
        for <linux-block@vger.kernel.org>; Mon, 01 Jul 2019 14:42:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b3ZDwGNNUyAt/wePYqXv8ih6xvURHdB2pGgEkvT3Dy0=;
        b=dX6fDitXZWUyeDWP+lMcqaLkoeZClvLyqX6mdvbFA1RVOjjvrslzH6lDf3tCyWr7BA
         iE7aTSPgNEuxxj+/pYYErsYo4A56fFJ6FDXICWpXP+0ZUAfz5jJuF9zSe4Dmt+haSqKV
         l+Etzz/Zlr1qdFsdtQ6T0yCCgTWZwa/JJB12UqHyi8LGfAlXEkgEUY1+MqspQxbEusZT
         Hxl9FfE7U5KiyqKZrOMKGFJK7aDWaUPPbshAkv5fyNlAKBfyO/Fq/5fmtJdNdlsgqR/U
         6K9u+2PG8dug3/W4N2hRMIwDY2r5L0k5KJah2tM99VN65e3JYxMtuJY1xWd58qmocEuC
         k46g==
X-Gm-Message-State: APjAAAWv6zxUu7Og5K/XePYsi5pFvz+HhMPhunTX6ja9SdzU1Rs/+2gB
        LXy+DYOgXx4vLFgVSnx4PdY=
X-Google-Smtp-Source: APXvYqwvOf2G8tAKv64ZJG2q6jhMWlKXq4nKWahtm2srRYjddBc0bvxwddYyj7z/x++0PolM6vCHSg==
X-Received: by 2002:a17:902:42a5:: with SMTP id h34mr32389639pld.16.1562017362923;
        Mon, 01 Jul 2019 14:42:42 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id c83sm15892282pfb.111.2019.07.01.14.42.41
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 01 Jul 2019 14:42:41 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Roman Penyaev <rpenyaev@suse.de>
Subject: [PATCH liburing 2/2] Fix the use of memory barriers
Date:   Mon,  1 Jul 2019 14:42:32 -0700
Message-Id: <20190701214232.29338-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
In-Reply-To: <20190701214232.29338-1-bvanassche@acm.org>
References: <20190701214232.29338-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Introduce the smp_load_acquire() and smp_store_release() macros. Fix
synchronization in io_uring_cq_advance() and __io_uring_get_cqe().
Remove a superfluous local variable, if-test and write barrier from
__io_uring_submit(). Remove a superfluous barrier from
test/io_uring_enter.c.

Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Roman Penyaev <rpenyaev@suse.de>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 man/io_uring_setup.2  |  6 ++-
 src/barrier.h         | 87 +++++++++++++++++++++++++++++++++++++++++--
 src/liburing.h        | 15 +++-----
 src/queue.c           | 30 ++++-----------
 test/io_uring_enter.c |  8 ++--
 5 files changed, 107 insertions(+), 39 deletions(-)

diff --git a/man/io_uring_setup.2 b/man/io_uring_setup.2
index ebaee2d43f35..9ab01434c18d 100644
--- a/man/io_uring_setup.2
+++ b/man/io_uring_setup.2
@@ -97,7 +97,11 @@ call with the following code sequence:
 
 .in +4n
 .EX
-read_barrier();
+/*
+ * Ensure that the wakeup flag is read after the tail pointer has been
+ * written.
+ */
+smp_mb();
 if (*sq_ring->flags & IORING_SQ_NEED_WAKEUP)
     io_uring_enter(fd, 0, 0, IORING_ENTER_SQ_WAKEUP);
 .EE
diff --git a/src/barrier.h b/src/barrier.h
index ef00f6722ba9..e1a407fccde2 100644
--- a/src/barrier.h
+++ b/src/barrier.h
@@ -1,16 +1,95 @@
 #ifndef LIBURING_BARRIER_H
 #define LIBURING_BARRIER_H
 
+/*
+From the kernel documentation file refcount-vs-atomic.rst:
+
+A RELEASE memory ordering guarantees that all prior loads and
+stores (all po-earlier instructions) on the same CPU are completed
+before the operation. It also guarantees that all po-earlier
+stores on the same CPU and all propagated stores from other CPUs
+must propagate to all other CPUs before the release operation
+(A-cumulative property). This is implemented using
+:c:func:`smp_store_release`.
+
+An ACQUIRE memory ordering guarantees that all post loads and
+stores (all po-later instructions) on the same CPU are
+completed after the acquire operation. It also guarantees that all
+po-later stores on the same CPU must propagate to all other CPUs
+after the acquire operation executes. This is implemented using
+:c:func:`smp_acquire__after_ctrl_dep`.
+*/
+
+/* From tools/include/linux/compiler.h */
+/* Optimization barrier */
+/* The "volatile" is due to gcc bugs */
+#define barrier() __asm__ __volatile__("": : :"memory")
+
+/* From tools/virtio/linux/compiler.h */
+#define WRITE_ONCE(var, val) \
+	(*((volatile typeof(val) *)(&(var))) = (val))
+#define READ_ONCE(var) (*((volatile typeof(var) *)(&(var))))
+
+
 #if defined(__x86_64) || defined(__i386__)
-#define read_barrier()	__asm__ __volatile__("":::"memory")
-#define write_barrier()	__asm__ __volatile__("":::"memory")
+/* From tools/arch/x86/include/asm/barrier.h */
+#if defined(__i386__)
+/*
+ * Some non-Intel clones support out of order store. wmb() ceases to be a
+ * nop for these.
+ */
+#define mb()	asm volatile("lock; addl $0,0(%%esp)" ::: "memory")
+#define rmb()	asm volatile("lock; addl $0,0(%%esp)" ::: "memory")
+#define wmb()	asm volatile("lock; addl $0,0(%%esp)" ::: "memory")
+#elif defined(__x86_64__)
+#define mb()	asm volatile("mfence" ::: "memory")
+#define rmb()	asm volatile("lfence" ::: "memory")
+#define wmb()	asm volatile("sfence" ::: "memory")
+#define smp_rmb() barrier()
+#define smp_wmb() barrier()
+#define smp_mb()  asm volatile("lock; addl $0,-132(%%rsp)" ::: "memory", "cc")
+#endif
+
+#if defined(__x86_64__)
+#define smp_store_release(p, v)			\
+do {						\
+	barrier();				\
+	WRITE_ONCE(*(p), (v));			\
+} while (0)
+
+#define smp_load_acquire(p)			\
+({						\
+	typeof(*p) ___p1 = READ_ONCE(*(p));	\
+	barrier();				\
+	___p1;					\
+})
+#endif /* defined(__x86_64__) */
 #else
 /*
  * Add arch appropriate definitions. Be safe and use full barriers for
  * archs we don't have support for.
  */
-#define read_barrier()	__sync_synchronize()
-#define write_barrier()	__sync_synchronize()
+#define smp_rmb()	__sync_synchronize()
+#define smp_wmb()	__sync_synchronize()
+#endif
+
+/* From tools/include/asm/barrier.h */
+
+#ifndef smp_store_release
+# define smp_store_release(p, v)		\
+do {						\
+	smp_mb();				\
+	WRITE_ONCE(*p, v);			\
+} while (0)
+#endif
+
+#ifndef smp_load_acquire
+# define smp_load_acquire(p)			\
+({						\
+	typeof(*p) ___p1 = READ_ONCE(*p);	\
+	smp_mb();				\
+	___p1;					\
+})
 #endif
 
 #endif
diff --git a/src/liburing.h b/src/liburing.h
index d3fcd1524540..a350a013ef8a 100644
--- a/src/liburing.h
+++ b/src/liburing.h
@@ -88,11 +88,10 @@ extern int io_uring_register_eventfd(struct io_uring *ring, int fd);
 extern int io_uring_unregister_eventfd(struct io_uring *ring);
 
 #define io_uring_for_each_cqe(ring, head, cqe)					\
+	/* smp_load_acquire() enforces the order of tail and CQE reads. */	\
 	for (head = *(ring)->cq.khead;						\
-	     /* See read_barrier() explanation in __io_uring_get_cqe() */	\
-	     ({read_barrier();							\
-	       cqe = (head != *(ring)->cq.ktail ?				\
-		&(ring)->cq.cqes[head & (*(ring)->cq.kring_mask)] : NULL);});	\
+	     (cqe = (head != smp_load_acquire((ring)->cq.ktail) ?		\
+		&(ring)->cq.cqes[head & (*(ring)->cq.kring_mask)] : NULL));	\
 	     head++)								\
 
 
@@ -105,13 +104,11 @@ static inline void io_uring_cq_advance(struct io_uring *ring,
 	if (nr) {
 		struct io_uring_cq *cq = &ring->cq;
 
-		(*cq->khead) += nr;
-
 		/*
-		 * Ensure that the kernel sees our new head, the kernel has
-		 * the matching read barrier.
+		 * Ensure that the kernel only sees the new value of the head
+		 * index after the CQEs have been read.
 		 */
-		write_barrier();
+		smp_store_release(cq->khead, *cq->khead + nr);
 	}
 }
 
diff --git a/src/queue.c b/src/queue.c
index bec363fc0ebf..72b22935c2ef 100644
--- a/src/queue.c
+++ b/src/queue.c
@@ -77,7 +77,7 @@ static int __io_uring_submit(struct io_uring *ring, unsigned wait_nr)
 {
 	struct io_uring_sq *sq = &ring->sq;
 	const unsigned mask = *sq->kring_mask;
-	unsigned ktail, ktail_next, submitted, to_submit;
+	unsigned ktail, submitted, to_submit;
 	unsigned flags;
 	int ret;
 
@@ -88,15 +88,11 @@ static int __io_uring_submit(struct io_uring *ring, unsigned wait_nr)
 	 * Fill in sqes that we have queued up, adding them to the kernel ring
 	 */
 	submitted = 0;
-	ktail = ktail_next = *sq->ktail;
+	ktail = *sq->ktail;
 	to_submit = sq->sqe_tail - sq->sqe_head;
 	while (to_submit--) {
-		ktail_next++;
-		read_barrier();
-
 		sq->array[ktail & mask] = sq->sqe_head & mask;
-		ktail = ktail_next;
-
+		ktail++;
 		sq->sqe_head++;
 		submitted++;
 	}
@@ -104,21 +100,11 @@ static int __io_uring_submit(struct io_uring *ring, unsigned wait_nr)
 	if (!submitted)
 		return 0;
 
-	if (*sq->ktail != ktail) {
-		/*
-		 * First write barrier ensures that the SQE stores are updated
-		 * with the tail update. This is needed so that the kernel
-		 * will never see a tail update without the preceeding sQE
-		 * stores being done.
-		 */
-		write_barrier();
-		*sq->ktail = ktail;
-		/*
-		 * The kernel has the matching read barrier for reading the
-		 * SQ tail.
-		 */
-		write_barrier();
-	}
+	/*
+	 * Ensure that the kernel sees the SQE updates before it sees the tail
+	 * update.
+	 */
+	smp_store_release(sq->ktail, ktail);
 
 	flags = 0;
 	if (wait_nr || sq_ring_needs_enter(ring, &flags)) {
diff --git a/test/io_uring_enter.c b/test/io_uring_enter.c
index d6e407e621ff..b25afd5790f3 100644
--- a/test/io_uring_enter.c
+++ b/test/io_uring_enter.c
@@ -262,9 +262,11 @@ main(int argc, char **argv)
 	ktail = *sq->ktail;
 	sq->array[ktail & mask] = index;
 	++ktail;
-	write_barrier();
-	*sq->ktail = ktail;
-	write_barrier();
+	/*
+	 * Ensure that the kernel sees the SQE update before it sees the tail
+	 * update.
+	 */
+	smp_store_release(sq->ktail, ktail);
 
 	ret = io_uring_enter(ring.ring_fd, 1, 0, 0, NULL);
 	/* now check to see if our sqe was dropped */
-- 
2.22.0.410.gd8fdbe21b5-goog

