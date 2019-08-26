Return-Path: <SRS0=sRwj=WW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5DC9C3A59F
	for <linux-block@archiver.kernel.org>; Mon, 26 Aug 2019 18:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42CFD2184D
	for <linux-block@archiver.kernel.org>; Mon, 26 Aug 2019 18:34:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=venev.name header.i=@venev.name header.b="scwqo7y2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728007AbfHZSeU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Aug 2019 14:34:20 -0400
Received: from mtel-bg02.venev.name ([77.70.28.44]:59268 "EHLO
        mtel-bg02.venev.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727687AbfHZSeU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Aug 2019 14:34:20 -0400
X-Greylist: delayed 4210 seconds by postgrey-1.27 at vger.kernel.org; Mon, 26 Aug 2019 14:34:19 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=venev.name;
         s=default; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=JLZtGOI4kuN3EfSv7NPr3vdniLMpEp2v04udZ0mBkq0=; b=scwqo7y2+RPFWAQas8Q+xMTWGj
        dGJZjzkWiyRezO7jHd4B7P0fEIK5bdHuyhiHIZc6QUnWq41SeLhdBDSs7rYT2kzS/HelxYdERDQOZ
        lC1wJcx5Wg5WSpPlLMMwM5JIpONupRjZ/gT846p1kG0nXTTm3XlfOe8x37Eo8mNjj2+/vw3VRhqhg
        zucUihoCv5nqrU2/s57aEtZ8jqegUrFpT1M8oBzh7hDMM7UBVmanohqkfpsUrBSD9QurPK6PER89W
        NlJQmjDHOiGxo0yoVSsRZ6BuDYGP0LBhm1h0Ymu4XPrkhS/HDX+Ufw8z8kUC6u9yPj4DFPeShAbZH
        Jh2wGJGFtmQl3b0WsQ8Vfaq6G92lYnQY9jsLjXMmPsb5F+ALrWPl0rscxNgWKgbTA5TmVf2upxVPQ
        xIuG8rDH4t8WgpHWD4fFdofM8p3tL78QCFoYHGf71T0d3C+qeuz0nOr48nOM3k4cM5lK16I8QNUTR
        kGFbATP+QO3b2xlxLfOhKU0yV8R9LOP2Ojx/d7zztCRo8SgJdl/9T6/OCIoAFKTz1C/hAud468AsR
        Lwm/qrZxLfGCLonXSEl0qV07VkYaXswQbnLq332oC0dZzBXEO/l0AMuc2tdBjysjbod8r+yJCdRV3
        UV8Ckc/HIgb8goIsqDIWlaHXHk/2velr1kK4OUdqo=;
Received: from mtel-bg02.venev.name
        by mtel-bg02.venev.name with local
        (envelope-from <hristo@venev.name>)
        id 1i2Iiq-0002Bg-8U; Mon, 26 Aug 2019 17:24:04 +0000
From:   Hristo Venev <hristo@venev.name>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Hristo Venev <hristo@venev.name>
Subject: [PATCH] io_uring: allocate the two rings together
Date:   Mon, 26 Aug 2019 17:23:46 +0000
Message-Id: <20190826172346.8341-1-hristo@venev.name>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Both the sq and the cq rings have sizes just over a power of two, and
the sq ring is significantly smaller. By bundling them in a single
alllocation, we get the sq ring for free.

This also means that IORING_OFF_SQ_RING and IORING_OFF_CQ_RING now mean
the same thing. If we indicate this to userspace, we can save a mmap
call.

Signed-off-by: Hristo Venev <hristo@venev.name>
---
 fs/io_uring.c | 255 +++++++++++++++++++++++++-------------------------
 1 file changed, 128 insertions(+), 127 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index cfb48bd088e1..1b28b4f2989f 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -84,27 +84,29 @@ struct io_uring {
 };
 
 /*
- * This data is shared with the application through the mmap at offset
- * IORING_OFF_SQ_RING.
+ * This data is shared with the application through the mmap at offsets
+ * IORING_OFF_SQ_RING and IORING_OFF_CQ_RING.
  *
  * The offsets to the member fields are published through struct
  * io_sqring_offsets when calling io_uring_setup.
  */
-struct io_sq_ring {
+struct io_rings {
 	/*
 	 * Head and tail offsets into the ring; the offsets need to be
 	 * masked to get valid indices.
 	 *
-	 * The kernel controls head and the application controls tail.
+	 * The kernel controls head of the sq ring and the tail of the cq ring,
+	 * and the application controls tail of the sq ring and the head of the
+	 * cq ring.
 	 */
-	struct io_uring		r;
+	struct io_uring		sq, cq;
 	/*
-	 * Bitmask to apply to head and tail offsets (constant, equals
+	 * Bitmasks to apply to head and tail offsets (constant, equals
 	 * ring_entries - 1)
 	 */
-	u32			ring_mask;
-	/* Ring size (constant, power of 2) */
-	u32			ring_entries;
+	u32			sq_ring_mask, cq_ring_mask;
+	/* Ring sizes (constant, power of 2) */
+	u32			sq_ring_entries, cq_ring_entries;
 	/*
 	 * Number of invalid entries dropped by the kernel due to
 	 * invalid index stored in array
@@ -117,7 +119,7 @@ struct io_sq_ring {
 	 * counter includes all submissions that were dropped reaching
 	 * the new SQ head (and possibly more).
 	 */
-	u32			dropped;
+	u32			sq_dropped;
 	/*
 	 * Runtime flags
 	 *
@@ -127,43 +129,7 @@ struct io_sq_ring {
 	 * The application needs a full memory barrier before checking
 	 * for IORING_SQ_NEED_WAKEUP after updating the sq tail.
 	 */
-	u32			flags;
-	/*
-	 * Ring buffer of indices into array of io_uring_sqe, which is
-	 * mmapped by the application using the IORING_OFF_SQES offset.
-	 *
-	 * This indirection could e.g. be used to assign fixed
-	 * io_uring_sqe entries to operations and only submit them to
-	 * the queue when needed.
-	 *
-	 * The kernel modifies neither the indices array nor the entries
-	 * array.
-	 */
-	u32			array[];
-};
-
-/*
- * This data is shared with the application through the mmap at offset
- * IORING_OFF_CQ_RING.
- *
- * The offsets to the member fields are published through struct
- * io_cqring_offsets when calling io_uring_setup.
- */
-struct io_cq_ring {
-	/*
-	 * Head and tail offsets into the ring; the offsets need to be
-	 * masked to get valid indices.
-	 *
-	 * The application controls head and the kernel tail.
-	 */
-	struct io_uring		r;
-	/*
-	 * Bitmask to apply to head and tail offsets (constant, equals
-	 * ring_entries - 1)
-	 */
-	u32			ring_mask;
-	/* Ring size (constant, power of 2) */
-	u32			ring_entries;
+	u32			sq_flags;
 	/*
 	 * Number of completion events lost because the queue was full;
 	 * this should be avoided by the application by making sure
@@ -177,7 +143,7 @@ struct io_cq_ring {
 	 * As completion events come in out of order this counter is not
 	 * ordered with any other data.
 	 */
-	u32			overflow;
+	u32			cq_overflow;
 	/*
 	 * Ring buffer of completion events.
 	 *
@@ -185,7 +151,7 @@ struct io_cq_ring {
 	 * produced, so the application is allowed to modify pending
 	 * entries.
 	 */
-	struct io_uring_cqe	cqes[];
+	struct io_uring_cqe	cqes[] ____cacheline_aligned_in_smp;
 };
 
 struct io_mapped_ubuf {
@@ -215,8 +181,18 @@ struct io_ring_ctx {
 		bool			compat;
 		bool			account_mem;
 
-		/* SQ ring */
-		struct io_sq_ring	*sq_ring;
+		/*
+		 * Ring buffer of indices into array of io_uring_sqe, which is
+		 * mmapped by the application using the IORING_OFF_SQES offset.
+		 *
+		 * This indirection could e.g. be used to assign fixed
+		 * io_uring_sqe entries to operations and only submit them to
+		 * the queue when needed.
+		 *
+		 * The kernel modifies neither the indices array nor the entries
+		 * array.
+		 */
+		u32			*sq_array;
 		unsigned		cached_sq_head;
 		unsigned		sq_entries;
 		unsigned		sq_mask;
@@ -234,8 +210,6 @@ struct io_ring_ctx {
 	struct completion	sqo_thread_started;
 
 	struct {
-		/* CQ ring */
-		struct io_cq_ring	*cq_ring;
 		unsigned		cached_cq_tail;
 		unsigned		cq_entries;
 		unsigned		cq_mask;
@@ -244,6 +218,8 @@ struct io_ring_ctx {
 		struct eventfd_ctx	*cq_ev_fd;
 	} ____cacheline_aligned_in_smp;
 
+	struct io_rings	*rings;
+
 	/*
 	 * If used, fixed file set. Writers must ensure that ->refs is dead,
 	 * readers must ensure that ->refs is alive as long as the file* is
@@ -430,7 +406,7 @@ static inline bool io_sequence_defer(struct io_ring_ctx *ctx,
 	if ((req->flags & (REQ_F_IO_DRAIN|REQ_F_IO_DRAINED)) != REQ_F_IO_DRAIN)
 		return false;
 
-	return req->sequence != ctx->cached_cq_tail + ctx->sq_ring->dropped;
+	return req->sequence != ctx->cached_cq_tail + ctx->rings->sq_dropped;
 }
 
 static struct io_kiocb *io_get_deferred_req(struct io_ring_ctx *ctx)
@@ -451,11 +427,11 @@ static struct io_kiocb *io_get_deferred_req(struct io_ring_ctx *ctx)
 
 static void __io_commit_cqring(struct io_ring_ctx *ctx)
 {
-	struct io_cq_ring *ring = ctx->cq_ring;
+	struct io_rings *rings = ctx->rings;
 
-	if (ctx->cached_cq_tail != READ_ONCE(ring->r.tail)) {
+	if (ctx->cached_cq_tail != READ_ONCE(rings->cq.tail)) {
 		/* order cqe stores with ring update */
-		smp_store_release(&ring->r.tail, ctx->cached_cq_tail);
+		smp_store_release(&rings->cq.tail, ctx->cached_cq_tail);
 
 		if (wq_has_sleeper(&ctx->cq_wait)) {
 			wake_up_interruptible(&ctx->cq_wait);
@@ -478,7 +454,7 @@ static void io_commit_cqring(struct io_ring_ctx *ctx)
 
 static struct io_uring_cqe *io_get_cqring(struct io_ring_ctx *ctx)
 {
-	struct io_cq_ring *ring = ctx->cq_ring;
+	struct io_rings *rings = ctx->rings;
 	unsigned tail;
 
 	tail = ctx->cached_cq_tail;
@@ -487,11 +463,11 @@ static struct io_uring_cqe *io_get_cqring(struct io_ring_ctx *ctx)
 	 * control dependency is enough as we're using WRITE_ONCE to
 	 * fill the cq entry
 	 */
-	if (tail - READ_ONCE(ring->r.head) == ring->ring_entries)
+	if (tail - READ_ONCE(rings->cq.head) == rings->cq_ring_entries)
 		return NULL;
 
 	ctx->cached_cq_tail++;
-	return &ring->cqes[tail & ctx->cq_mask];
+	return &rings->cqes[tail & ctx->cq_mask];
 }
 
 static void io_cqring_fill_event(struct io_ring_ctx *ctx, u64 ki_user_data,
@@ -510,9 +486,9 @@ static void io_cqring_fill_event(struct io_ring_ctx *ctx, u64 ki_user_data,
 		WRITE_ONCE(cqe->res, res);
 		WRITE_ONCE(cqe->flags, 0);
 	} else {
-		unsigned overflow = READ_ONCE(ctx->cq_ring->overflow);
+		unsigned overflow = READ_ONCE(ctx->rings->cq_overflow);
 
-		WRITE_ONCE(ctx->cq_ring->overflow, overflow + 1);
+		WRITE_ONCE(ctx->rings->cq_overflow, overflow + 1);
 	}
 }
 
@@ -679,11 +655,11 @@ static void io_put_req(struct io_kiocb *req)
 		io_free_req(req);
 }
 
-static unsigned io_cqring_events(struct io_cq_ring *ring)
+static unsigned io_cqring_events(struct io_rings *rings)
 {
 	/* See comment at the top of this file */
 	smp_rmb();
-	return READ_ONCE(ring->r.tail) - READ_ONCE(ring->r.head);
+	return READ_ONCE(rings->cq.tail) - READ_ONCE(rings->cq.head);
 }
 
 /*
@@ -836,7 +812,7 @@ static int io_iopoll_check(struct io_ring_ctx *ctx, unsigned *nr_events,
 		 * If we do, we can potentially be spinning for commands that
 		 * already triggered a CQE (eg in error).
 		 */
-		if (io_cqring_events(ctx->cq_ring))
+		if (io_cqring_events(ctx->rings))
 			break;
 
 		/*
@@ -2205,15 +2181,15 @@ static void io_submit_state_start(struct io_submit_state *state,
 
 static void io_commit_sqring(struct io_ring_ctx *ctx)
 {
-	struct io_sq_ring *ring = ctx->sq_ring;
+	struct io_rings *rings = ctx->rings;
 
-	if (ctx->cached_sq_head != READ_ONCE(ring->r.head)) {
+	if (ctx->cached_sq_head != READ_ONCE(rings->sq.head)) {
 		/*
 		 * Ensure any loads from the SQEs are done at this point,
 		 * since once we write the new head, the application could
 		 * write new data to them.
 		 */
-		smp_store_release(&ring->r.head, ctx->cached_sq_head);
+		smp_store_release(&rings->sq.head, ctx->cached_sq_head);
 	}
 }
 
@@ -2227,7 +2203,8 @@ static void io_commit_sqring(struct io_ring_ctx *ctx)
  */
 static bool io_get_sqring(struct io_ring_ctx *ctx, struct sqe_submit *s)
 {
-	struct io_sq_ring *ring = ctx->sq_ring;
+	struct io_rings *rings = ctx->rings;
+	u32 *sq_array = ctx->sq_array;
 	unsigned head;
 
 	/*
@@ -2240,10 +2217,10 @@ static bool io_get_sqring(struct io_ring_ctx *ctx, struct sqe_submit *s)
 	 */
 	head = ctx->cached_sq_head;
 	/* make sure SQ entry isn't read before tail */
-	if (head == smp_load_acquire(&ring->r.tail))
+	if (head == smp_load_acquire(&rings->sq.tail))
 		return false;
 
-	head = READ_ONCE(ring->array[head & ctx->sq_mask]);
+	head = READ_ONCE(sq_array[head & ctx->sq_mask]);
 	if (head < ctx->sq_entries) {
 		s->index = head;
 		s->sqe = &ctx->sq_sqes[head];
@@ -2253,7 +2230,7 @@ static bool io_get_sqring(struct io_ring_ctx *ctx, struct sqe_submit *s)
 
 	/* drop invalid entries */
 	ctx->cached_sq_head++;
-	ring->dropped++;
+	rings->sq_dropped++;
 	return false;
 }
 
@@ -2366,7 +2343,7 @@ static int io_sq_thread(void *data)
 						TASK_INTERRUPTIBLE);
 
 			/* Tell userspace we may need a wakeup call */
-			ctx->sq_ring->flags |= IORING_SQ_NEED_WAKEUP;
+			ctx->rings->sq_flags |= IORING_SQ_NEED_WAKEUP;
 			/* make sure to read SQ tail after writing flags */
 			smp_mb();
 
@@ -2380,12 +2357,12 @@ static int io_sq_thread(void *data)
 				schedule();
 				finish_wait(&ctx->sqo_wait, &wait);
 
-				ctx->sq_ring->flags &= ~IORING_SQ_NEED_WAKEUP;
+				ctx->rings->sq_flags &= ~IORING_SQ_NEED_WAKEUP;
 				continue;
 			}
 			finish_wait(&ctx->sqo_wait, &wait);
 
-			ctx->sq_ring->flags &= ~IORING_SQ_NEED_WAKEUP;
+			ctx->rings->sq_flags &= ~IORING_SQ_NEED_WAKEUP;
 		}
 
 		i = 0;
@@ -2477,10 +2454,10 @@ static int io_ring_submit(struct io_ring_ctx *ctx, unsigned int to_submit)
 static int io_cqring_wait(struct io_ring_ctx *ctx, int min_events,
 			  const sigset_t __user *sig, size_t sigsz)
 {
-	struct io_cq_ring *ring = ctx->cq_ring;
+	struct io_rings *rings = ctx->rings;
 	int ret;
 
-	if (io_cqring_events(ring) >= min_events)
+	if (io_cqring_events(rings) >= min_events)
 		return 0;
 
 	if (sig) {
@@ -2496,12 +2473,12 @@ static int io_cqring_wait(struct io_ring_ctx *ctx, int min_events,
 			return ret;
 	}
 
-	ret = wait_event_interruptible(ctx->wait, io_cqring_events(ring) >= min_events);
+	ret = wait_event_interruptible(ctx->wait, io_cqring_events(rings) >= min_events);
 	restore_saved_sigmask_unless(ret == -ERESTARTSYS);
 	if (ret == -ERESTARTSYS)
 		ret = -EINTR;
 
-	return READ_ONCE(ring->r.head) == READ_ONCE(ring->r.tail) ? ret : 0;
+	return READ_ONCE(rings->cq.head) == READ_ONCE(rings->cq.tail) ? ret : 0;
 }
 
 static void __io_sqe_files_unregister(struct io_ring_ctx *ctx)
@@ -2821,17 +2798,45 @@ static void *io_mem_alloc(size_t size)
 	return (void *) __get_free_pages(gfp_flags, get_order(size));
 }
 
+static unsigned long rings_size(unsigned sq_entries, unsigned cq_entries,
+				size_t *sq_offset)
+{
+	struct io_rings *rings;
+	size_t off, sq_array_size;
+
+	off = struct_size(rings, cqes, cq_entries);
+	if (off == SIZE_MAX)
+		return SIZE_MAX;
+
+#ifdef CONFIG_SMP
+	off = ALIGN(off, SMP_CACHE_BYTES);
+	if (off == 0)
+		return SIZE_MAX;
+#endif
+
+	sq_array_size = array_size(sizeof(u32), sq_entries);
+	if (sq_array_size == SIZE_MAX)
+		return SIZE_MAX;
+
+	if (check_add_overflow(off, sq_array_size, &off))
+		return SIZE_MAX;
+
+	if (sq_offset)
+		*sq_offset = off;
+
+	return off;
+}
+
 static unsigned long ring_pages(unsigned sq_entries, unsigned cq_entries)
 {
-	struct io_sq_ring *sq_ring;
-	struct io_cq_ring *cq_ring;
-	size_t bytes;
+	size_t pages;
 
-	bytes = struct_size(sq_ring, array, sq_entries);
-	bytes += array_size(sizeof(struct io_uring_sqe), sq_entries);
-	bytes += struct_size(cq_ring, cqes, cq_entries);
+	pages = (size_t)1 << get_order(
+		rings_size(sq_entries, cq_entries, NULL));
+	pages += (size_t)1 << get_order(
+		array_size(sizeof(struct io_uring_sqe), sq_entries));
 
-	return (bytes + PAGE_SIZE - 1) / PAGE_SIZE;
+	return pages;
 }
 
 static int io_sqe_buffer_unregister(struct io_ring_ctx *ctx)
@@ -3078,9 +3083,8 @@ static void io_ring_ctx_free(struct io_ring_ctx *ctx)
 	}
 #endif
 
-	io_mem_free(ctx->sq_ring);
+	io_mem_free(ctx->rings);
 	io_mem_free(ctx->sq_sqes);
-	io_mem_free(ctx->cq_ring);
 
 	percpu_ref_exit(&ctx->refs);
 	if (ctx->account_mem)
@@ -3101,10 +3105,10 @@ static __poll_t io_uring_poll(struct file *file, poll_table *wait)
 	 * io_commit_cqring
 	 */
 	smp_rmb();
-	if (READ_ONCE(ctx->sq_ring->r.tail) - ctx->cached_sq_head !=
-	    ctx->sq_ring->ring_entries)
+	if (READ_ONCE(ctx->rings->sq.tail) - ctx->cached_sq_head !=
+	    ctx->rings->sq_ring_entries)
 		mask |= EPOLLOUT | EPOLLWRNORM;
-	if (READ_ONCE(ctx->cq_ring->r.head) != ctx->cached_cq_tail)
+	if (READ_ONCE(ctx->rings->sq.head) != ctx->cached_cq_tail)
 		mask |= EPOLLIN | EPOLLRDNORM;
 
 	return mask;
@@ -3149,14 +3153,12 @@ static int io_uring_mmap(struct file *file, struct vm_area_struct *vma)
 
 	switch (offset) {
 	case IORING_OFF_SQ_RING:
-		ptr = ctx->sq_ring;
+	case IORING_OFF_CQ_RING:
+		ptr = ctx->rings;
 		break;
 	case IORING_OFF_SQES:
 		ptr = ctx->sq_sqes;
 		break;
-	case IORING_OFF_CQ_RING:
-		ptr = ctx->cq_ring;
-		break;
 	default:
 		return -EINVAL;
 	}
@@ -3243,19 +3245,27 @@ static const struct file_operations io_uring_fops = {
 static int io_allocate_scq_urings(struct io_ring_ctx *ctx,
 				  struct io_uring_params *p)
 {
-	struct io_sq_ring *sq_ring;
-	struct io_cq_ring *cq_ring;
-	size_t size;
+	struct io_rings *rings;
+	size_t size, sq_array_offset;
 
-	sq_ring = io_mem_alloc(struct_size(sq_ring, array, p->sq_entries));
-	if (!sq_ring)
+	size = rings_size(p->sq_entries, p->cq_entries, &sq_array_offset);
+	if (size == SIZE_MAX)
+		return -EOVERFLOW;
+
+	rings = io_mem_alloc(size);
+	if (!rings)
 		return -ENOMEM;
 
-	ctx->sq_ring = sq_ring;
-	sq_ring->ring_mask = p->sq_entries - 1;
-	sq_ring->ring_entries = p->sq_entries;
-	ctx->sq_mask = sq_ring->ring_mask;
-	ctx->sq_entries = sq_ring->ring_entries;
+	ctx->rings = rings;
+	ctx->sq_array = (u32 *)((char *)rings + sq_array_offset);
+	rings->sq_ring_mask = p->sq_entries - 1;
+	rings->cq_ring_mask = p->cq_entries - 1;
+	rings->sq_ring_entries = p->sq_entries;
+	rings->cq_ring_entries = p->cq_entries;
+	ctx->sq_mask = rings->sq_ring_mask;
+	ctx->cq_mask = rings->cq_ring_mask;
+	ctx->sq_entries = rings->sq_ring_entries;
+	ctx->cq_entries = rings->cq_ring_entries;
 
 	size = array_size(sizeof(struct io_uring_sqe), p->sq_entries);
 	if (size == SIZE_MAX)
@@ -3265,15 +3275,6 @@ static int io_allocate_scq_urings(struct io_ring_ctx *ctx,
 	if (!ctx->sq_sqes)
 		return -ENOMEM;
 
-	cq_ring = io_mem_alloc(struct_size(cq_ring, cqes, p->cq_entries));
-	if (!cq_ring)
-		return -ENOMEM;
-
-	ctx->cq_ring = cq_ring;
-	cq_ring->ring_mask = p->cq_entries - 1;
-	cq_ring->ring_entries = p->cq_entries;
-	ctx->cq_mask = cq_ring->ring_mask;
-	ctx->cq_entries = cq_ring->ring_entries;
 	return 0;
 }
 
@@ -3377,21 +3378,21 @@ static int io_uring_create(unsigned entries, struct io_uring_params *p)
 		goto err;
 
 	memset(&p->sq_off, 0, sizeof(p->sq_off));
-	p->sq_off.head = offsetof(struct io_sq_ring, r.head);
-	p->sq_off.tail = offsetof(struct io_sq_ring, r.tail);
-	p->sq_off.ring_mask = offsetof(struct io_sq_ring, ring_mask);
-	p->sq_off.ring_entries = offsetof(struct io_sq_ring, ring_entries);
-	p->sq_off.flags = offsetof(struct io_sq_ring, flags);
-	p->sq_off.dropped = offsetof(struct io_sq_ring, dropped);
-	p->sq_off.array = offsetof(struct io_sq_ring, array);
+	p->sq_off.head = offsetof(struct io_rings, sq.head);
+	p->sq_off.tail = offsetof(struct io_rings, sq.tail);
+	p->sq_off.ring_mask = offsetof(struct io_rings, sq_ring_mask);
+	p->sq_off.ring_entries = offsetof(struct io_rings, sq_ring_entries);
+	p->sq_off.flags = offsetof(struct io_rings, sq_flags);
+	p->sq_off.dropped = offsetof(struct io_rings, sq_dropped);
+	p->sq_off.array = (char *)ctx->sq_array - (char *)ctx->rings;
 
 	memset(&p->cq_off, 0, sizeof(p->cq_off));
-	p->cq_off.head = offsetof(struct io_cq_ring, r.head);
-	p->cq_off.tail = offsetof(struct io_cq_ring, r.tail);
-	p->cq_off.ring_mask = offsetof(struct io_cq_ring, ring_mask);
-	p->cq_off.ring_entries = offsetof(struct io_cq_ring, ring_entries);
-	p->cq_off.overflow = offsetof(struct io_cq_ring, overflow);
-	p->cq_off.cqes = offsetof(struct io_cq_ring, cqes);
+	p->cq_off.head = offsetof(struct io_rings, cq.head);
+	p->cq_off.tail = offsetof(struct io_rings, cq.tail);
+	p->cq_off.ring_mask = offsetof(struct io_rings, cq_ring_mask);
+	p->cq_off.ring_entries = offsetof(struct io_rings, cq_ring_entries);
+	p->cq_off.overflow = offsetof(struct io_rings, cq_overflow);
+	p->cq_off.cqes = offsetof(struct io_rings, cqes);
 	return ret;
 err:
 	io_ring_ctx_wait_and_kill(ctx);
-- 
2.21.0

