Return-Path: <SRS0=ZVtD=YS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 372D2C47E49
	for <linux-block@archiver.kernel.org>; Fri, 25 Oct 2019 17:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D818821872
	for <linux-block@archiver.kernel.org>; Fri, 25 Oct 2019 17:23:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="j6NErqkm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409927AbfJYRXD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Oct 2019 13:23:03 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:36544 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409406AbfJYRXB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Oct 2019 13:23:01 -0400
Received: by mail-io1-f67.google.com with SMTP id c16so3293957ioc.3
        for <linux-block@vger.kernel.org>; Fri, 25 Oct 2019 10:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qsu9l1jk9ZnGlLo7rzMmJGTlKmxiXmN/NEwuN66kALo=;
        b=j6NErqkmU9TsN/Pif0ZzftycWHVO7TTdoz6b4y06k9qYRIdv9ZejgRyZ5zMba84e+r
         cY4GEUEsOF97fgXzjGFoj7ZYlLfckQyhz3Iz4WXBgZR9geFCaWNfH9nWGOU9k56ihF32
         AaEmXkM4piJEjxeffZ8r6Na8ZNahWtnT3ena/U7hjuZBzXBDcHO6mFKpBmh5fA/iZgPR
         +P61g5cOS2pTeRv+jzFLFPdcAf/yLKrTwen47hX/vJIlJzyxWs9lqKu2QctWt/WjitKk
         6gjZYNieA7pMHkreTpFqLWkZH8oE5GaWdbfvqPgVPqMav86VWSYrMRKYPPvFQRUn2B2z
         bjDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qsu9l1jk9ZnGlLo7rzMmJGTlKmxiXmN/NEwuN66kALo=;
        b=Mx5VPf1P68/JG980tSVrdggNLE22qS/P82mkfolBxY7+isz/73iQoAV9q0v3psHClZ
         lRbhwvNQUbu1AsrgnKytuKlzuRpCf4OkVvtuw8USmU+19kgQYxuMXSKqtNK27C30Qaqj
         jEg4JUWQOkL8vLw/Rt0W7sv/E/lWOFHkqEAeFwEnAmgRUjlGur4AI4WhQmGqYovDP1m3
         KOq3qkYWVVRRq8RtnbsCYMsBpy3DzzN3bvSUqrHcpgE89ItcETQB58jjM3cGtHFkqppH
         az41QHMIqiqRT53OEcxR/793ks7PYqOMyIt2uL5bHqxTTC4R1L0TFF0yFUeluObrUkTp
         dmcQ==
X-Gm-Message-State: APjAAAX+a0dX91LzMQACAYL7fdyfgS5YuKneByxzlONVk/4NpyaAiJFt
        eN1BEUDp7MK65cHRA2yLo0TsbAn9Nn+1Ig==
X-Google-Smtp-Source: APXvYqwFLPBioadcCKq0687F5Fg36tekBvJBvh9447/dKvvlboMJYv1zDrJTaRLMnDJyyyIw4VNVcQ==
X-Received: by 2002:a6b:7410:: with SMTP id s16mr4537019iog.35.1572024178251;
        Fri, 25 Oct 2019 10:22:58 -0700 (PDT)
Received: from x1.thefacebook.com ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id l21sm324082iok.87.2019.10.25.10.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 10:22:57 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     peterz@infradead.org, mingo@kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/2] io_uring: replace workqueue usage with io-wq
Date:   Fri, 25 Oct 2019 11:22:51 -0600
Message-Id: <20191025172251.12830-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191025172251.12830-1-axboe@kernel.dk>
References: <20191025172251.12830-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Drop various work-arounds we have for workqueues:

- We no longer need the async_list for tracking sequential IO.

- We don't have to maintain our own mm tracking/setting.

- We don't need a separate workqueue for buffered writes. This didn't
  even work that well to begin with, as it was suboptimal for multiple
  buffered writers on multiple files.

- We can properly cancel pending interruptible work. This fixes
  deadlocks with particularly socket IO, where we cannot cancel them
  when the io_uring is closed. Hence the ring will wait forever for
  these requests to complete, which may never happen. This is different
  from disk IO where we know requests will complete in a finite amount
  of time.

- Due to being able to cancel work interruptible work that is already
  running, we can implement file table support for work. We need that
  for supporting system calls that add to a process file table.

- It gets us one step closer to adding async support for any system
  call.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io_uring.c                   | 414 ++++++++------------------------
 include/trace/events/io_uring.h |  12 +-
 init/Kconfig                    |   1 +
 3 files changed, 104 insertions(+), 323 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 90d9b4886e42..13c1ebf96626 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -56,7 +56,6 @@
 #include <linux/mmu_context.h>
 #include <linux/percpu.h>
 #include <linux/slab.h>
-#include <linux/workqueue.h>
 #include <linux/kthread.h>
 #include <linux/blkdev.h>
 #include <linux/bvec.h>
@@ -77,6 +76,7 @@
 #include <uapi/linux/io_uring.h>
 
 #include "internal.h"
+#include "io-wq.h"
 
 #define IORING_MAX_ENTRIES	32768
 #define IORING_MAX_CQ_ENTRIES	(2 * IORING_MAX_ENTRIES)
@@ -165,16 +165,6 @@ struct io_mapped_ubuf {
 	unsigned int	nr_bvecs;
 };
 
-struct async_list {
-	spinlock_t		lock;
-	atomic_t		cnt;
-	struct list_head	list;
-
-	struct file		*file;
-	off_t			io_start;
-	size_t			io_len;
-};
-
 struct io_ring_ctx {
 	struct {
 		struct percpu_ref	refs;
@@ -209,7 +199,7 @@ struct io_ring_ctx {
 	} ____cacheline_aligned_in_smp;
 
 	/* IO offload */
-	struct workqueue_struct	*sqo_wq[2];
+	struct io_wq		*io_wq;
 	struct task_struct	*sqo_thread;	/* if using sq thread polling */
 	struct mm_struct	*sqo_mm;
 	wait_queue_head_t	sqo_wait;
@@ -262,8 +252,6 @@ struct io_ring_ctx {
 		struct list_head	cancel_list;
 	} ____cacheline_aligned_in_smp;
 
-	struct async_list	pending_async[2];
-
 #if defined(CONFIG_UNIX)
 	struct socket		*ring_sock;
 #endif
@@ -334,7 +322,7 @@ struct io_kiocb {
 	u32			result;
 	u32			sequence;
 
-	struct work_struct	work;
+	struct io_wq_work	work;
 };
 
 #define IO_PLUG_THRESHOLD		2
@@ -360,7 +348,7 @@ struct io_submit_state {
 	unsigned int		ios_left;
 };
 
-static void io_sq_wq_submit_work(struct work_struct *work);
+static void io_wq_submit_work(struct io_wq_work **workptr);
 static void io_cqring_fill_event(struct io_ring_ctx *ctx, u64 ki_user_data,
 				 long res);
 static void __io_free_req(struct io_kiocb *req);
@@ -392,7 +380,6 @@ static void io_ring_ctx_ref_free(struct percpu_ref *ref)
 static struct io_ring_ctx *io_ring_ctx_alloc(struct io_uring_params *p)
 {
 	struct io_ring_ctx *ctx;
-	int i;
 
 	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
 	if (!ctx)
@@ -410,11 +397,6 @@ static struct io_ring_ctx *io_ring_ctx_alloc(struct io_uring_params *p)
 	init_completion(&ctx->sqo_thread_started);
 	mutex_init(&ctx->uring_lock);
 	init_waitqueue_head(&ctx->wait);
-	for (i = 0; i < ARRAY_SIZE(ctx->pending_async); i++) {
-		spin_lock_init(&ctx->pending_async[i].lock);
-		INIT_LIST_HEAD(&ctx->pending_async[i].list);
-		atomic_set(&ctx->pending_async[i].cnt, 0);
-	}
 	spin_lock_init(&ctx->completion_lock);
 	INIT_LIST_HEAD(&ctx->poll_list);
 	INIT_LIST_HEAD(&ctx->cancel_list);
@@ -480,22 +462,45 @@ static void __io_commit_cqring(struct io_ring_ctx *ctx)
 	}
 }
 
-static inline void io_queue_async_work(struct io_ring_ctx *ctx,
-				       struct io_kiocb *req)
+static inline bool io_sqe_needs_user(const struct io_uring_sqe *sqe)
 {
-	int rw = 0;
+	u8 opcode = READ_ONCE(sqe->opcode);
+
+	return !(opcode == IORING_OP_READ_FIXED ||
+		 opcode == IORING_OP_WRITE_FIXED);
+}
+
+static inline bool io_prep_async_work(struct io_kiocb *req)
+{
+	bool do_hashed = false;
 
 	if (req->submit.sqe) {
 		switch (req->submit.sqe->opcode) {
 		case IORING_OP_WRITEV:
 		case IORING_OP_WRITE_FIXED:
-			rw = !(req->rw.ki_flags & IOCB_DIRECT);
+			do_hashed = true;
 			break;
 		}
+		if (io_sqe_needs_user(req->submit.sqe))
+			req->work.flags |= IO_WQ_WORK_NEEDS_USER;
 	}
 
-	trace_io_uring_queue_async_work(ctx, rw, req, &req->work, req->flags);
-	queue_work(ctx->sqo_wq[rw], &req->work);
+	return do_hashed;
+}
+
+static inline void io_queue_async_work(struct io_ring_ctx *ctx,
+				       struct io_kiocb *req)
+{
+	bool do_hashed = io_prep_async_work(req);
+
+	trace_io_uring_queue_async_work(ctx, do_hashed, req, &req->work,
+					req->flags);
+	if (!do_hashed) {
+		io_wq_enqueue(ctx->io_wq, &req->work);
+	} else {
+		io_wq_enqueue_hashed(ctx->io_wq, &req->work,
+					file_inode(req->file));
+	}
 }
 
 static void io_kill_timeout(struct io_kiocb *req)
@@ -648,6 +653,7 @@ static struct io_kiocb *io_get_req(struct io_ring_ctx *ctx,
 	/* one is dropped after submission, the other at completion */
 	refcount_set(&req->refs, 2);
 	req->result = 0;
+	INIT_IO_WORK(&req->work, io_wq_submit_work);
 	return req;
 out:
 	percpu_ref_put(&ctx->refs);
@@ -694,12 +700,10 @@ static void io_req_link_next(struct io_kiocb *req, struct io_kiocb **nxtptr)
 		 * If we're in async work, we can continue processing the chain
 		 * in this context instead of having to queue up new async work.
 		 */
-		if (nxtptr && current_work()) {
+		if (nxtptr && current_work())
 			*nxtptr = nxt;
-		} else {
-			INIT_WORK(&nxt->work, io_sq_wq_submit_work);
+		else
 			io_queue_async_work(req->ctx, nxt);
-		}
 	}
 }
 
@@ -758,12 +762,10 @@ static void io_put_req(struct io_kiocb *req, struct io_kiocb **nxtptr)
 
 	nxt = io_put_req_find_next(req);
 	if (nxt) {
-		if (nxtptr) {
+		if (nxtptr)
 			*nxtptr = nxt;
-		} else {
-			INIT_WORK(&nxt->work, io_sq_wq_submit_work);
+		else
 			io_queue_async_work(nxt->ctx, nxt);
-		}
 	}
 }
 
@@ -1325,65 +1327,6 @@ static ssize_t io_import_iovec(struct io_ring_ctx *ctx, int rw,
 	return import_iovec(rw, buf, sqe_len, UIO_FASTIOV, iovec, iter);
 }
 
-static inline bool io_should_merge(struct async_list *al, struct kiocb *kiocb)
-{
-	if (al->file == kiocb->ki_filp) {
-		off_t start, end;
-
-		/*
-		 * Allow merging if we're anywhere in the range of the same
-		 * page. Generally this happens for sub-page reads or writes,
-		 * and it's beneficial to allow the first worker to bring the
-		 * page in and the piggy backed work can then work on the
-		 * cached page.
-		 */
-		start = al->io_start & PAGE_MASK;
-		end = (al->io_start + al->io_len + PAGE_SIZE - 1) & PAGE_MASK;
-		if (kiocb->ki_pos >= start && kiocb->ki_pos <= end)
-			return true;
-	}
-
-	al->file = NULL;
-	return false;
-}
-
-/*
- * Make a note of the last file/offset/direction we punted to async
- * context. We'll use this information to see if we can piggy back a
- * sequential request onto the previous one, if it's still hasn't been
- * completed by the async worker.
- */
-static void io_async_list_note(int rw, struct io_kiocb *req, size_t len)
-{
-	struct async_list *async_list = &req->ctx->pending_async[rw];
-	struct kiocb *kiocb = &req->rw;
-	struct file *filp = kiocb->ki_filp;
-
-	if (io_should_merge(async_list, kiocb)) {
-		unsigned long max_bytes;
-
-		/* Use 8x RA size as a decent limiter for both reads/writes */
-		max_bytes = filp->f_ra.ra_pages << (PAGE_SHIFT + 3);
-		if (!max_bytes)
-			max_bytes = VM_READAHEAD_PAGES << (PAGE_SHIFT + 3);
-
-		/* If max len are exceeded, reset the state */
-		if (async_list->io_len + len <= max_bytes) {
-			req->flags |= REQ_F_SEQ_PREV;
-			async_list->io_len += len;
-		} else {
-			async_list->file = NULL;
-		}
-	}
-
-	/* New file? Reset state. */
-	if (async_list->file != filp) {
-		async_list->io_start = kiocb->ki_pos;
-		async_list->io_len = len;
-		async_list->file = filp;
-	}
-}
-
 /*
  * For files that don't have ->read_iter() and ->write_iter(), handle them
  * by looping over ->read() or ->write() manually.
@@ -1478,13 +1421,10 @@ static int io_read(struct io_kiocb *req, const struct sqe_submit *s,
 		    ret2 > 0 && ret2 < read_size)
 			ret2 = -EAGAIN;
 		/* Catch -EAGAIN return for forced non-blocking submission */
-		if (!force_nonblock || ret2 != -EAGAIN) {
+		if (!force_nonblock || ret2 != -EAGAIN)
 			kiocb_done(kiocb, ret2, nxt, s->in_async);
-		} else {
-			if (!s->in_async)
-				io_async_list_note(READ, req, iov_count);
+		else
 			ret = -EAGAIN;
-		}
 	}
 	kfree(iovec);
 	return ret;
@@ -1518,11 +1458,8 @@ static int io_write(struct io_kiocb *req, const struct sqe_submit *s,
 	iov_count = iov_iter_count(&iter);
 
 	ret = -EAGAIN;
-	if (force_nonblock && !(kiocb->ki_flags & IOCB_DIRECT)) {
-		if (!s->in_async)
-			io_async_list_note(WRITE, req, iov_count);
+	if (force_nonblock && !(kiocb->ki_flags & IOCB_DIRECT))
 		goto out_free;
-	}
 
 	ret = rw_verify_area(WRITE, file, &kiocb->ki_pos, iov_count);
 	if (!ret) {
@@ -1547,13 +1484,10 @@ static int io_write(struct io_kiocb *req, const struct sqe_submit *s,
 			ret2 = call_write_iter(file, kiocb, &iter);
 		else
 			ret2 = loop_rw_iter(WRITE, file, kiocb, &iter);
-		if (!force_nonblock || ret2 != -EAGAIN) {
+		if (!force_nonblock || ret2 != -EAGAIN)
 			kiocb_done(kiocb, ret2, nxt, s->in_async);
-		} else {
-			if (!s->in_async)
-				io_async_list_note(WRITE, req, iov_count);
+		else
 			ret = -EAGAIN;
-		}
 	}
 out_free:
 	kfree(iovec);
@@ -1795,8 +1729,9 @@ static void io_poll_complete(struct io_ring_ctx *ctx, struct io_kiocb *req,
 	io_commit_cqring(ctx);
 }
 
-static void io_poll_complete_work(struct work_struct *work)
+static void io_poll_complete_work(struct io_wq_work **workptr)
 {
+	struct io_wq_work *work = *workptr;
 	struct io_kiocb *req = container_of(work, struct io_kiocb, work);
 	struct io_poll_iocb *poll = &req->poll;
 	struct poll_table_struct pt = { ._key = poll->events };
@@ -1895,7 +1830,7 @@ static int io_poll_add(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 		return -EBADF;
 
 	req->submit.sqe = NULL;
-	INIT_WORK(&req->work, io_poll_complete_work);
+	INIT_IO_WORK(&req->work, io_poll_complete_work);
 	events = READ_ONCE(sqe->poll_events);
 	poll->events = demangle_poll(events) | EPOLLERR | EPOLLHUP;
 
@@ -2153,7 +2088,6 @@ static int io_req_defer(struct io_ring_ctx *ctx, struct io_kiocb *req,
 	memcpy(sqe_copy, sqe, sizeof(*sqe_copy));
 	req->submit.sqe = sqe_copy;
 
-	INIT_WORK(&req->work, io_sq_wq_submit_work);
 	trace_io_uring_defer(ctx, req, false);
 	list_add_tail(&req->list, &ctx->defer_list);
 	spin_unlock_irq(&ctx->completion_lock);
@@ -2239,186 +2173,54 @@ static int __io_submit_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
 	return 0;
 }
 
-static struct async_list *io_async_list_from_sqe(struct io_ring_ctx *ctx,
-						 const struct io_uring_sqe *sqe)
-{
-	switch (sqe->opcode) {
-	case IORING_OP_READV:
-	case IORING_OP_READ_FIXED:
-		return &ctx->pending_async[READ];
-	case IORING_OP_WRITEV:
-	case IORING_OP_WRITE_FIXED:
-		return &ctx->pending_async[WRITE];
-	default:
-		return NULL;
-	}
-}
-
-static inline bool io_sqe_needs_user(const struct io_uring_sqe *sqe)
-{
-	u8 opcode = READ_ONCE(sqe->opcode);
-
-	return !(opcode == IORING_OP_READ_FIXED ||
-		 opcode == IORING_OP_WRITE_FIXED);
-}
-
-static void io_sq_wq_submit_work(struct work_struct *work)
+static void io_wq_submit_work(struct io_wq_work **workptr)
 {
+	struct io_wq_work *work = *workptr;
 	struct io_kiocb *req = container_of(work, struct io_kiocb, work);
 	struct io_ring_ctx *ctx = req->ctx;
-	struct mm_struct *cur_mm = NULL;
-	struct async_list *async_list;
-	LIST_HEAD(req_list);
-	mm_segment_t old_fs;
-	int ret;
+	struct sqe_submit *s = &req->submit;
+	const struct io_uring_sqe *sqe = s->sqe;
+	struct io_kiocb *nxt = NULL;
+	int ret = 0;
 
-	async_list = io_async_list_from_sqe(ctx, req->submit.sqe);
-restart:
-	do {
-		struct sqe_submit *s = &req->submit;
-		const struct io_uring_sqe *sqe = s->sqe;
-		unsigned int flags = req->flags;
-		struct io_kiocb *nxt = NULL;
+	/* Ensure we clear previously set non-block flag */
+	req->rw.ki_flags &= ~IOCB_NOWAIT;
 
-		/* Ensure we clear previously set non-block flag */
-		req->rw.ki_flags &= ~IOCB_NOWAIT;
+	if (work->flags & IO_WQ_WORK_CANCEL)
+		ret = -ECANCELED;
 
-		ret = 0;
-		if (io_sqe_needs_user(sqe) && !cur_mm) {
-			if (!mmget_not_zero(ctx->sqo_mm)) {
-				ret = -EFAULT;
-			} else {
-				cur_mm = ctx->sqo_mm;
-				use_mm(cur_mm);
-				old_fs = get_fs();
-				set_fs(USER_DS);
-			}
-		}
+	if (!ret) {
+		s->has_user = (work->flags & IO_WQ_WORK_HAS_MM) != 0;
+		s->in_async = true;
+		do {
+			ret = __io_submit_sqe(ctx, req, s, &nxt, false);
+			/*
+			 * We can get EAGAIN for polled IO even though we're
+			 * forcing a sync submission from here, since we can't
+			 * wait for request slots on the block side.
+			 */
+			if (ret != -EAGAIN)
+				break;
+			cond_resched();
+		} while (1);
+	}
 
-		if (!ret) {
-			s->has_user = cur_mm != NULL;
-			s->in_async = true;
-			do {
-				ret = __io_submit_sqe(ctx, req, s, &nxt, false);
-				/*
-				 * We can get EAGAIN for polled IO even though
-				 * we're forcing a sync submission from here,
-				 * since we can't wait for request slots on the
-				 * block side.
-				 */
-				if (ret != -EAGAIN)
-					break;
-				cond_resched();
-			} while (1);
-		}
+	/* drop submission reference */
+	io_put_req(req, NULL);
 
-		/* drop submission reference */
+	if (ret) {
+		io_cqring_add_event(ctx, sqe->user_data, ret);
 		io_put_req(req, NULL);
-
-		if (ret) {
-			io_cqring_add_event(ctx, sqe->user_data, ret);
-			io_put_req(req, NULL);
-		}
-
-		/* async context always use a copy of the sqe */
-		kfree(sqe);
-
-		/* if a dependent link is ready, do that as the next one */
-		if (!ret && nxt) {
-			req = nxt;
-			continue;
-		}
-
-		/* req from defer and link list needn't decrease async cnt */
-		if (flags & (REQ_F_IO_DRAINED | REQ_F_LINK_DONE))
-			goto out;
-
-		if (!async_list)
-			break;
-		if (!list_empty(&req_list)) {
-			req = list_first_entry(&req_list, struct io_kiocb,
-						list);
-			list_del(&req->list);
-			continue;
-		}
-		if (list_empty(&async_list->list))
-			break;
-
-		req = NULL;
-		spin_lock(&async_list->lock);
-		if (list_empty(&async_list->list)) {
-			spin_unlock(&async_list->lock);
-			break;
-		}
-		list_splice_init(&async_list->list, &req_list);
-		spin_unlock(&async_list->lock);
-
-		req = list_first_entry(&req_list, struct io_kiocb, list);
-		list_del(&req->list);
-	} while (req);
-
-	/*
-	 * Rare case of racing with a submitter. If we find the count has
-	 * dropped to zero AND we have pending work items, then restart
-	 * the processing. This is a tiny race window.
-	 */
-	if (async_list) {
-		ret = atomic_dec_return(&async_list->cnt);
-		while (!ret && !list_empty(&async_list->list)) {
-			spin_lock(&async_list->lock);
-			atomic_inc(&async_list->cnt);
-			list_splice_init(&async_list->list, &req_list);
-			spin_unlock(&async_list->lock);
-
-			if (!list_empty(&req_list)) {
-				req = list_first_entry(&req_list,
-							struct io_kiocb, list);
-				list_del(&req->list);
-				goto restart;
-			}
-			ret = atomic_dec_return(&async_list->cnt);
-		}
-	}
-
-out:
-	if (cur_mm) {
-		set_fs(old_fs);
-		unuse_mm(cur_mm);
-		mmput(cur_mm);
 	}
-}
-
-/*
- * See if we can piggy back onto previously submitted work, that is still
- * running. We currently only allow this if the new request is sequential
- * to the previous one we punted.
- */
-static bool io_add_to_prev_work(struct async_list *list, struct io_kiocb *req)
-{
-	bool ret;
 
-	if (!list)
-		return false;
-	if (!(req->flags & REQ_F_SEQ_PREV))
-		return false;
-	if (!atomic_read(&list->cnt))
-		return false;
+	/* async context always use a copy of the sqe */
+	kfree(sqe);
 
-	ret = true;
-	spin_lock(&list->lock);
-	list_add_tail(&req->list, &list->list);
-	/*
-	 * Ensure we see a simultaneous modification from io_sq_wq_submit_work()
-	 */
-	smp_mb();
-	if (!atomic_read(&list->cnt)) {
-		list_del_init(&req->list);
-		ret = false;
+	/* if a dependent link is ready, pass it back */
+	if (!ret && nxt) {
+		io_prep_async_work(nxt);
+		*workptr = &nxt->work;
 	}
-	spin_unlock(&list->lock);
-
-	trace_io_uring_add_to_prev(req, ret);
-	return ret;
 }
 
 static bool io_op_needs_file(const struct io_uring_sqe *sqe)
@@ -2492,17 +2294,9 @@ static int __io_queue_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
 
 		sqe_copy = kmemdup(s->sqe, sizeof(*sqe_copy), GFP_KERNEL);
 		if (sqe_copy) {
-			struct async_list *list;
-
 			s->sqe = sqe_copy;
 			memcpy(&req->submit, s, sizeof(*s));
-			list = io_async_list_from_sqe(ctx, s->sqe);
-			if (!io_add_to_prev_work(list, req)) {
-				if (list)
-					atomic_inc(&list->cnt);
-				INIT_WORK(&req->work, io_sq_wq_submit_work);
-				io_queue_async_work(ctx, req);
-			}
+			io_queue_async_work(ctx, req);
 
 			/*
 			 * Queued up for async execution, worker will release
@@ -3120,15 +2914,11 @@ static void io_sq_thread_stop(struct io_ring_ctx *ctx)
 
 static void io_finish_async(struct io_ring_ctx *ctx)
 {
-	int i;
-
 	io_sq_thread_stop(ctx);
 
-	for (i = 0; i < ARRAY_SIZE(ctx->sqo_wq); i++) {
-		if (ctx->sqo_wq[i]) {
-			destroy_workqueue(ctx->sqo_wq[i]);
-			ctx->sqo_wq[i] = NULL;
-		}
+	if (ctx->io_wq) {
+		io_wq_destroy(ctx->io_wq);
+		ctx->io_wq = NULL;
 	}
 }
 
@@ -3136,11 +2926,9 @@ static void io_finish_async(struct io_ring_ctx *ctx)
 static void io_destruct_skb(struct sk_buff *skb)
 {
 	struct io_ring_ctx *ctx = skb->sk->sk_user_data;
-	int i;
 
-	for (i = 0; i < ARRAY_SIZE(ctx->sqo_wq); i++)
-		if (ctx->sqo_wq[i])
-			flush_workqueue(ctx->sqo_wq[i]);
+	if (ctx->io_wq)
+		io_wq_flush(ctx->io_wq);
 
 	unix_destruct_scm(skb);
 }
@@ -3484,6 +3272,7 @@ static int io_sqe_files_update(struct io_ring_ctx *ctx, void __user *arg,
 static int io_sq_offload_start(struct io_ring_ctx *ctx,
 			       struct io_uring_params *p)
 {
+	unsigned concurrency;
 	int ret;
 
 	init_waitqueue_head(&ctx->sqo_wait);
@@ -3527,25 +3316,10 @@ static int io_sq_offload_start(struct io_ring_ctx *ctx,
 		goto err;
 	}
 
-	/* Do QD, or 2 * CPUS, whatever is smallest */
-	ctx->sqo_wq[0] = alloc_workqueue("io_ring-wq",
-			WQ_UNBOUND | WQ_FREEZABLE,
-			min(ctx->sq_entries - 1, 2 * num_online_cpus()));
-	if (!ctx->sqo_wq[0]) {
-		ret = -ENOMEM;
-		goto err;
-	}
-
-	/*
-	 * This is for buffered writes, where we want to limit the parallelism
-	 * due to file locking in file systems. As "normal" buffered writes
-	 * should parellelize on writeout quite nicely, limit us to having 2
-	 * pending. This avoids massive contention on the inode when doing
-	 * buffered async writes.
-	 */
-	ctx->sqo_wq[1] = alloc_workqueue("io_ring-write-wq",
-						WQ_UNBOUND | WQ_FREEZABLE, 2);
-	if (!ctx->sqo_wq[1]) {
+	/* Do QD, or 4 * CPUS, whatever is smallest */
+	concurrency = min(ctx->sq_entries, 4 * num_online_cpus());
+	ctx->io_wq = io_wq_create(concurrency, ctx->sqo_mm);
+	if (!ctx->io_wq) {
 		ret = -ENOMEM;
 		goto err;
 	}
@@ -3930,6 +3704,10 @@ static void io_ring_ctx_wait_and_kill(struct io_ring_ctx *ctx)
 
 	io_kill_timeouts(ctx);
 	io_poll_remove_all(ctx);
+
+	if (ctx->io_wq)
+		io_wq_cancel_all(ctx->io_wq);
+
 	io_iopoll_reap_events(ctx);
 	wait_for_completion(&ctx->ctx_done);
 	io_ring_ctx_free(ctx);
diff --git a/include/trace/events/io_uring.h b/include/trace/events/io_uring.h
index c5a905fbf1da..b85255121b98 100644
--- a/include/trace/events/io_uring.h
+++ b/include/trace/events/io_uring.h
@@ -7,6 +7,8 @@
 
 #include <linux/tracepoint.h>
 
+struct io_wq_work;
+
 /**
  * io_uring_create - called after a new io_uring context was prepared
  *
@@ -126,15 +128,15 @@ TRACE_EVENT(io_uring_file_get,
  * io_uring_queue_async_work - called before submitting a new async work
  *
  * @ctx:	pointer to a ring context structure
- * @rw:		type of workqueue, normal or buffered writes
+ * @hashed:	type of workqueue, hashed or normal
  * @req:	pointer to a submitted request
- * @work:	pointer to a submitted work_struct
+ * @work:	pointer to a submitted io_wq_work
  *
  * Allows to trace asynchronous work submission.
  */
 TRACE_EVENT(io_uring_queue_async_work,
 
-	TP_PROTO(void *ctx, int rw, void * req, struct work_struct *work,
+	TP_PROTO(void *ctx, int rw, void * req, struct io_wq_work *work,
 			 unsigned int flags),
 
 	TP_ARGS(ctx, rw, req, work, flags),
@@ -143,7 +145,7 @@ TRACE_EVENT(io_uring_queue_async_work,
 		__field(  void *,				ctx		)
 		__field(  int,					rw		)
 		__field(  void *,				req		)
-		__field(  struct work_struct *,	work	)
+		__field(  struct io_wq_work *,		work	)
 		__field(  unsigned int,			flags	)
 	),
 
@@ -157,7 +159,7 @@ TRACE_EVENT(io_uring_queue_async_work,
 
 	TP_printk("ring %p, request %p, flags %d, %s queue, work %p",
 			  __entry->ctx, __entry->req, __entry->flags,
-			  __entry->rw ? "buffered" : "normal", __entry->work)
+			  __entry->rw ? "hashed" : "normal", __entry->work)
 );
 
 /**
diff --git a/init/Kconfig b/init/Kconfig
index b4daad2bac23..4d8d145c41d2 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1548,6 +1548,7 @@ config AIO
 config IO_URING
 	bool "Enable IO uring support" if EXPERT
 	select ANON_INODES
+	select IO_WQ
 	default y
 	help
 	  This option enables support for the io_uring interface, enabling
-- 
2.17.1

