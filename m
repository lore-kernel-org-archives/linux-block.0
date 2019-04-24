Return-Path: <SRS0=lHMQ=S2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97A38C10F11
	for <linux-block@archiver.kernel.org>; Wed, 24 Apr 2019 21:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6888520811
	for <linux-block@archiver.kernel.org>; Wed, 24 Apr 2019 21:54:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=stbuehler.de header.i=@stbuehler.de header.b="LWLW1GsS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731953AbfDXVy1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Apr 2019 17:54:27 -0400
Received: from mail.stbuehler.de ([5.9.32.208]:41004 "EHLO mail.stbuehler.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731710AbfDXVy0 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Apr 2019 17:54:26 -0400
Received: from chromobil.fritz.box (unknown [IPv6:2a02:8070:a29c:5000:823f:5dff:fe0f:b5b6])
        by mail.stbuehler.de (Postfix) with ESMTPSA id 9F51DC0041E;
        Wed, 24 Apr 2019 21:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=stbuehler.de;
        s=stbuehler1; t=1556142862;
        bh=kCfNBKyYk3clXKQnMRuUz6yHPdy3Pcy8s5rGgvHyb94=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=LWLW1GsSusvNWcSBzpPHG7HFByjcI+Q7RMllcYqWzPXQ7JwmZkAXPsJeKqsAxL20Q
         h2CUOzSrV414aJZmGZ2ySLx8rMXKj1VW3opss6L/tGUyTr2yVxEJwy29cORrGJJrZY
         BR75+hq/tWs1ZJoey3Keo++w0IHzDy8JVdWS9pI8=
From:   =?UTF-8?q?Stefan=20B=C3=BChler?= <source@stbuehler.de>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH barrier cleanup v1 1/7] io_uring: fix notes on barriers
Date:   Wed, 24 Apr 2019 23:54:16 +0200
Message-Id: <20190424215422.7404-1-source@stbuehler.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <54496e17-97de-9f9a-9972-c448226bb768@stbuehler.de>
References: <54496e17-97de-9f9a-9972-c448226bb768@stbuehler.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The application reading the CQ ring needs a barrier to pair with the
smp_store_release in io_commit_cqring, not the barrier after it.

Also a write barrier *after* writing something (but not *before*
writing anything interesting) doesn't order anything, so an smp_wmb()
after writing SQ tail is not needed.

Additionally consider reading SQ head and writing CQ tail in the notes.

Also add some clarifications how the various other fields in the ring
buffers are used.

Signed-off-by: Stefan Bühler <source@stbuehler.de>
---
 fs/io_uring.c | 119 ++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 110 insertions(+), 9 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 0e9fb2cb1984..7025e9830abe 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -4,15 +4,28 @@
  * supporting fast/efficient IO.
  *
  * A note on the read/write ordering memory barriers that are matched between
- * the application and kernel side. When the application reads the CQ ring
- * tail, it must use an appropriate smp_rmb() to order with the smp_wmb()
- * the kernel uses after writing the tail. Failure to do so could cause a
- * delay in when the application notices that completion events available.
- * This isn't a fatal condition. Likewise, the application must use an
- * appropriate smp_wmb() both before writing the SQ tail, and after writing
- * the SQ tail. The first one orders the sqe writes with the tail write, and
- * the latter is paired with the smp_rmb() the kernel will issue before
- * reading the SQ tail on submission.
+ * the application and kernel side.
+ *
+ * After the application reads the CQ ring tail, it must use an
+ * appropriate smp_rmb() to pair with the smp_wmb() the kernel uses
+ * before writing the tail (using smp_load_acquire to read the tail will
+ * do). It also needs a smp_mb() before updating CQ head (ordering the
+ * entry load(s) with the head store), pairing with an implicit barrier
+ * through a control-dependency in io_get_cqring (smp_store_release to
+ * store head will do). Failure to do so could lead to reading invalid
+ * CQ entries.
+ *
+ * Likewise, the application must use an appropriate smp_wmb() before
+ * writing the SQ tail (ordering SQ entry stores with the tail store),
+ * which pairs with smp_load_acquire in io_get_sqring (smp_store_release
+ * to store the tail will do). And it needs a barrier ordering the SQ
+ * head load before writing new SQ entries (smp_load_acquire to read
+ * head will do).
+ *
+ * When using the SQ poll thread (IORING_SETUP_SQPOLL), the application
+ * needs to check the SQ flags for IORING_SQ_NEED_WAKEUP *after*
+ * updating the SQ tail; a full memory barrier smp_mb() is needed
+ * between.
  *
  * Also see the examples in the liburing library:
  *
@@ -70,20 +83,108 @@ struct io_uring {
 	u32 tail ____cacheline_aligned_in_smp;
 };
 
+/*
+ * This data is shared with the application through the mmap at offset
+ * IORING_OFF_SQ_RING.
+ *
+ * The offsets to the member fields are published through struct
+ * io_sqring_offsets when calling io_uring_setup.
+ */
 struct io_sq_ring {
+	/*
+	 * Head and tail offsets into the ring; the offsets need to be
+	 * masked to get valid indices.
+	 *
+	 * The kernel controls head and the application controls tail.
+	 */
 	struct io_uring		r;
+	/*
+	 * Bitmask to apply to head and tail offsets (constant, equals
+	 * ring_entries - 1)
+	 */
 	u32			ring_mask;
+	/* Ring size (constant, power of 2) */
 	u32			ring_entries;
+	/*
+	 * Number of invalid entries dropped by the kernel due to
+	 * invalid index stored in array
+	 *
+	 * Written by the kernel, shouldn't be modified by the
+	 * application (i.e. get number of "new events" by comparing to
+	 * cached value).
+	 *
+	 * After a new SQ head value was read by the application this
+	 * counter includes all submissions that were dropped reaching
+	 * the new SQ head (and possibly more).
+	 */
 	u32			dropped;
+	/*
+	 * Runtime flags
+	 *
+	 * Written by the kernel, shouldn't be modified by the
+	 * application.
+	 *
+	 * The application needs a full memory barrier before checking
+	 * for IORING_SQ_NEED_WAKEUP after updating the sq tail.
+	 */
 	u32			flags;
+	/*
+	 * Ring buffer of indices into array of io_uring_sqe, which is
+	 * mmapped by the application using the IORING_OFF_SQES offset.
+	 *
+	 * This indirection could e.g. be used to assign fixed
+	 * io_uring_sqe entries to operations and only submit them to
+	 * the queue when needed.
+	 *
+	 * The kernel modifies neither the indices array nor the entries
+	 * array.
+	 */
 	u32			array[];
 };
 
+/*
+ * This data is shared with the application through the mmap at offset
+ * IORING_OFF_CQ_RING.
+ *
+ * The offsets to the member fields are published through struct
+ * io_cqring_offsets when calling io_uring_setup.
+ */
 struct io_cq_ring {
+	/*
+	 * Head and tail offsets into the ring; the offsets need to be
+	 * masked to get valid indices.
+	 *
+	 * The application controls head and the kernel tail.
+	 */
 	struct io_uring		r;
+	/*
+	 * Bitmask to apply to head and tail offsets (constant, equals
+	 * ring_entries - 1)
+	 */
 	u32			ring_mask;
+	/* Ring size (constant, power of 2) */
 	u32			ring_entries;
+	/*
+	 * Number of completion events lost because the queue was full;
+	 * this should be avoided by the application by making sure
+	 * there are not more requests pending thatn there is space in
+	 * the completion queue.
+	 *
+	 * Written by the kernel, shouldn't be modified by the
+	 * application (i.e. get number of "new events" by comparing to
+	 * cached value).
+	 *
+	 * As completion events come in out of order this counter is not
+	 * ordered with any other data.
+	 */
 	u32			overflow;
+	/*
+	 * Ring buffer of completion events.
+	 *
+	 * The kernel writes completion events fresh every time they are
+	 * produced, so the application is allowed to modify pending
+	 * entries.
+	 */
 	struct io_uring_cqe	cqes[];
 };
 
-- 
2.20.1

