Return-Path: <SRS0=D8nw=PQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52242C43387
	for <linux-block@archiver.kernel.org>; Tue,  8 Jan 2019 16:57:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DB3C20827
	for <linux-block@archiver.kernel.org>; Tue,  8 Jan 2019 16:57:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="0NBi+zSZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729266AbfAHQ53 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Jan 2019 11:57:29 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:39518 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729219AbfAHQ5T (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Jan 2019 11:57:19 -0500
Received: by mail-it1-f193.google.com with SMTP id a6so6928935itl.4
        for <linux-block@vger.kernel.org>; Tue, 08 Jan 2019 08:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=E2mGG9suMfo/Hq4h2cKt3Xi1WwCcA6HNLu1UqmDgo9E=;
        b=0NBi+zSZrr4AtC02HIMvETmd3B9eT50AkMf2/tgfrBY2d3Osm1Wxh/ovFbCW6ps1K/
         fQSOP8HxmXiA/NXQuHEOJbUiqtsS5pWxyFc2U79TPZcLyDjQvw1IvMZp/4EosY5iJxVc
         rDI8oUzQFtjFz3EhlgCtw2hF7oXqY9M+84gLof3Kk6FXjTW0j2KI3w6bHWjnVFlUx2mj
         lmSFO3ZPdGjsQ6XUiKtVFOvcCmEyPk+5oheSQBMWS2/p/osGXRFbgEYeTIvGhG+0Z7Wx
         zR2+G2RmePOXDcd23NAUHY4VTxDtm5Hz4JJw4Q0X0acPHMMS9OPvYQVw++t4g64gdh+h
         H0mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=E2mGG9suMfo/Hq4h2cKt3Xi1WwCcA6HNLu1UqmDgo9E=;
        b=oxmkyJKH/5zZxabMm0qC+K/a84BNOsJ83O/tYbkYAuDVt/MtCizjgoQrrnPamSQYJR
         c5TWIkrFGLTdDean8axm3vNm6xp9jrQBpxvRBtDkzfG6QrtHFOJu4BkilQNfQFzw/yew
         ED1gVRtLL1MdAFCU81MOwPA7EgkDKgc0X1/V0jFd/0B6B5hXbouDvByiWheWfkNr2fSx
         q4QyJrlbFLplxARHarsJ4cK9QH+JT7KYQ/UoAk+Y9Lr1ItH7Cg0Kk/3465IZ882PJ1F+
         ToDJP+f3t+ZyzRFnq3NZEWtF3AGU3IBZnW/WkL3n/NZtiFsh2Agx/kX1OG9Gm5nPcMav
         Gcmg==
X-Gm-Message-State: AJcUukebKCwAbFMBz9J8pa1hwZfAMtgRbUG3IkZ49Q3Mhcg4azk9PvZ3
        xSrxJ+KMA8dPR4tWCwdIvywgqOKCNyYTIw==
X-Google-Smtp-Source: ALg8bN7/F+Pd7Z24tGmLzvYkmukkDHM4hQlCThm5kX8/sQSG6X06MhDWsMLAnjpc/d/V8w0bbxnlzg==
X-Received: by 2002:a24:b951:: with SMTP id k17mr1656856iti.147.1546966637974;
        Tue, 08 Jan 2019 08:57:17 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id m10sm17563442ioq.25.2019.01.08.08.57.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 08:57:16 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org, linux-arch@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 14/16] io_uring: support kernel side submission
Date:   Tue,  8 Jan 2019 09:56:43 -0700
Message-Id: <20190108165645.19311-15-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190108165645.19311-1-axboe@kernel.dk>
References: <20190108165645.19311-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add support for backing the io_uring fd with either a thread, or a
workqueue and letting those handle the submission for us. This can
be used to reduce overhead for submission, or to always make submission
async. The latter is particularly useful for buffered aio, which is
now fully async with this feature.

For polled IO, we could have the kernel side thread hammer on the SQ
ring and submit when it finds IO. This would mean that an application
would NEVER have to enter the kernel to do IO! Didn't add this yet,
but it would be trivial to add.

If an application sets IORING_SETUP_SCQTHREAD, the io_uring gets a
single thread backing. If used with buffered IO, this will limit the
device queue depth to 1, but it will be async, IOs will simply be
serialized.

Or an application can set IORING_SETUP_SQWQ, in which case the urings
get a work queue backing. The concurrency level is the mininum of twice
the available CPUs, or the queue depth specific for the context. For
this mode, we attempt to do buffered reads inline, in case they are
cached. So we should only punt to a workqueue, if we would have to block
to get our data.

Tested with polling, no polling, fixedbufs, no fixedbufs, buffered,
O_DIRECT.

See this sample application for how to use it:

http://git.kernel.dk/cgit/fio/plain/t/io_uring.c

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io_uring.c                 | 405 ++++++++++++++++++++++++++++++++--
 include/uapi/linux/io_uring.h |   5 +-
 2 files changed, 387 insertions(+), 23 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 92129f867824..e6a808a89b78 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -14,6 +14,7 @@
 #include <linux/sched/signal.h>
 #include <linux/fs.h>
 #include <linux/file.h>
+#include <linux/fdtable.h>
 #include <linux/mm.h>
 #include <linux/mman.h>
 #include <linux/mmu_context.h>
@@ -24,6 +25,8 @@
 #include <linux/anon_inodes.h>
 #include <linux/sizes.h>
 #include <linux/nospec.h>
+#include <linux/kthread.h>
+#include <linux/sched/mm.h>
 
 #include <linux/uaccess.h>
 #include <linux/nospec.h>
@@ -58,6 +61,7 @@ struct io_iocb_ring {
 	struct			io_sq_ring *ring;
 	unsigned		entries;
 	unsigned		ring_mask;
+	unsigned		sq_thread_cpu;
 	struct io_uring_iocb	*iocbs;
 };
 
@@ -74,6 +78,14 @@ struct io_mapped_ubuf {
 	unsigned int	nr_bvecs;
 };
 
+struct io_sq_offload {
+	struct task_struct	*thread;	/* if using a thread */
+	struct workqueue_struct	*wq;	/* wq offload */
+	struct mm_struct	*mm;
+	struct files_struct	*files;
+	wait_queue_head_t	wait;
+};
+
 struct io_ring_ctx {
 	struct percpu_ref	refs;
 
@@ -88,6 +100,9 @@ struct io_ring_ctx {
 
 	struct work_struct	work;
 
+	/* sq ring submitter thread, if used */
+	struct io_sq_offload	sq_offload;
+
 	/* iopoll submission state */
 	struct {
 		spinlock_t poll_lock;
@@ -127,6 +142,7 @@ struct io_kiocb {
 	unsigned long		ki_flags;
 #define KIOCB_F_IOPOLL_COMPLETED	0	/* polled IO has completed */
 #define KIOCB_F_IOPOLL_EAGAIN		1	/* submission got EAGAIN */
+#define KIOCB_F_FORCE_NONBLOCK		2	/* inline submission attempt */
 };
 
 #define IO_PLUG_THRESHOLD		2
@@ -164,6 +180,18 @@ struct io_submit_state {
 	unsigned int ios_left;
 };
 
+struct iocb_submit {
+	const struct io_uring_iocb *iocb;
+	unsigned int index;
+};
+
+struct io_work {
+	struct work_struct work;
+	struct io_ring_ctx *ctx;
+	struct io_uring_iocb iocb;
+	unsigned iocb_index;
+};
+
 static struct kmem_cache *kiocb_cachep, *ioctx_cachep;
 
 static const struct file_operations io_scqring_fops;
@@ -442,18 +470,17 @@ static void kiocb_end_write(struct kiocb *kiocb)
 	}
 }
 
-static void io_fill_event(struct io_uring_event *ev, struct io_kiocb *kiocb,
+static void io_fill_event(struct io_uring_event *ev, unsigned ki_index,
 			  long res, unsigned flags)
 {
-	ev->index = kiocb->ki_index;
+	ev->index = ki_index;
 	ev->res = res;
 	ev->flags = flags;
 }
 
-static void io_cqring_fill_event(struct io_kiocb *iocb, long res,
-				 unsigned ev_flags)
+static void io_cqring_fill_event(struct io_ring_ctx *ctx, unsigned ki_index,
+				 long res, unsigned ev_flags)
 {
-	struct io_ring_ctx *ctx = iocb->ki_ctx;
 	struct io_uring_event *ev;
 	unsigned long flags;
 
@@ -465,7 +492,7 @@ static void io_cqring_fill_event(struct io_kiocb *iocb, long res,
 	spin_lock_irqsave(&ctx->completion_lock, flags);
 	ev = io_peek_cqring(ctx);
 	if (ev) {
-		io_fill_event(ev, iocb, res, ev_flags);
+		io_fill_event(ev, ki_index, res, ev_flags);
 		io_inc_cqring(ctx);
 	} else
 		ctx->cq_ring.ring->overflow++;
@@ -474,10 +501,24 @@ static void io_cqring_fill_event(struct io_kiocb *iocb, long res,
 
 static void io_complete_scqring(struct io_kiocb *iocb, long res, unsigned flags)
 {
-	io_cqring_fill_event(iocb, res, flags);
+	io_cqring_fill_event(iocb->ki_ctx, iocb->ki_index, res, flags);
 	io_complete_iocb(iocb->ki_ctx, iocb);
 }
 
+static void io_fill_cq_error(struct io_ring_ctx *ctx, unsigned ki_index,
+			     long error)
+{
+	io_cqring_fill_event(ctx, ki_index, error, 0);
+
+	/*
+	 * for thread offload, app could already be sleeping in io_ring_enter()
+	 * before we get to flag the error. wake them up, if needed.
+	 */
+	if (ctx->flags & (IORING_SETUP_SQTHREAD | IORING_SETUP_SQWQ))
+		if (waitqueue_active(&ctx->wait))
+			wake_up(&ctx->wait);
+}
+
 static void io_complete_scqring_rw(struct kiocb *kiocb, long res, long res2)
 {
 	struct io_kiocb *iocb = container_of(kiocb, struct io_kiocb, rw);
@@ -485,6 +526,7 @@ static void io_complete_scqring_rw(struct kiocb *kiocb, long res, long res2)
 	kiocb_end_write(kiocb);
 
 	fput(kiocb->ki_filp);
+
 	io_complete_scqring(iocb, res, 0);
 }
 
@@ -497,7 +539,7 @@ static void io_complete_scqring_iopoll(struct kiocb *kiocb, long res, long res2)
 	if (unlikely(res == -EAGAIN)) {
 		set_bit(KIOCB_F_IOPOLL_EAGAIN, &iocb->ki_flags);
 	} else {
-		io_cqring_fill_event(iocb, res, 0);
+		io_cqring_fill_event(iocb->ki_ctx, iocb->ki_index, res, 0);
 		set_bit(KIOCB_F_IOPOLL_COMPLETED, &iocb->ki_flags);
 	}
 }
@@ -549,7 +591,7 @@ static struct file *io_file_get(struct io_submit_state *state, int fd)
 }
 
 static int io_prep_rw(struct io_kiocb *kiocb, const struct io_uring_iocb *iocb,
-		      struct io_submit_state *state)
+		      struct io_submit_state *state, bool force_nonblock)
 {
 	struct io_ring_ctx *ctx = kiocb->ki_ctx;
 	struct kiocb *req = &kiocb->rw;
@@ -573,6 +615,10 @@ static int io_prep_rw(struct io_kiocb *kiocb, const struct io_uring_iocb *iocb,
 	ret = kiocb_set_rw_flags(req, iocb->rw_flags);
 	if (unlikely(ret))
 		goto out_fput;
+	if (force_nonblock) {
+		req->ki_flags |= IOCB_NOWAIT;
+		set_bit(KIOCB_F_FORCE_NONBLOCK, &kiocb->ki_flags);
+	}
 
 	if (ctx->flags & IORING_SETUP_IOPOLL) {
 		ret = -EOPNOTSUPP;
@@ -716,7 +762,7 @@ static void io_iopoll_iocb_issued(struct io_submit_state *state,
 }
 
 static ssize_t io_read(struct io_kiocb *kiocb, const struct io_uring_iocb *iocb,
-		       struct io_submit_state *state, bool kaddr)
+		       struct io_submit_state *state, bool kaddr, bool nonblock)
 {
 	struct iovec inline_vecs[UIO_FASTIOV], *iovec = inline_vecs;
 	struct kiocb *req = &kiocb->rw;
@@ -724,7 +770,7 @@ static ssize_t io_read(struct io_kiocb *kiocb, const struct io_uring_iocb *iocb,
 	struct file *file;
 	ssize_t ret;
 
-	ret = io_prep_rw(kiocb, iocb, state);
+	ret = io_prep_rw(kiocb, iocb, state, nonblock);
 	if (ret)
 		return ret;
 	file = req->ki_filp;
@@ -741,8 +787,18 @@ static ssize_t io_read(struct io_kiocb *kiocb, const struct io_uring_iocb *iocb,
 		goto out_fput;
 
 	ret = rw_verify_area(READ, file, &req->ki_pos, iov_iter_count(&iter));
-	if (!ret)
-		io_rw_done(req, call_read_iter(file, req, &iter));
+	if (!ret) {
+		ssize_t ret2;
+
+		/*
+		 * Catch -EAGAIN return for forced non-blocking submission
+		 */
+		ret2 = call_read_iter(file, req, &iter);
+		if (!nonblock || ret2 != -EAGAIN)
+			io_rw_done(req, ret2);
+		else
+			ret = -EAGAIN;
+	}
 	kfree(iovec);
 out_fput:
 	if (unlikely(ret))
@@ -760,7 +816,7 @@ static ssize_t io_write(struct io_kiocb *kiocb,
 	struct file *file;
 	ssize_t ret;
 
-	ret = io_prep_rw(kiocb, iocb, state);
+	ret = io_prep_rw(kiocb, iocb, state, false);
 	if (ret)
 		return ret;
 	file = req->ki_filp;
@@ -833,7 +889,7 @@ static int io_fsync(struct fsync_iocb *req, const struct io_uring_iocb *iocb,
 static int __io_submit_one(struct io_ring_ctx *ctx,
 			   const struct io_uring_iocb *iocb,
 			   unsigned long ki_index,
-			   struct io_submit_state *state)
+			   struct io_submit_state *state, bool force_nonblock)
 {
 	struct io_kiocb *req;
 	ssize_t ret;
@@ -854,10 +910,10 @@ static int __io_submit_one(struct io_ring_ctx *ctx,
 	ret = -EINVAL;
 	switch (iocb->opcode) {
 	case IORING_OP_READ:
-		ret = io_read(req, iocb, state, false);
+		ret = io_read(req, iocb, state, false, force_nonblock);
 		break;
 	case IORING_OP_READ_FIXED:
-		ret = io_read(req, iocb, state, true);
+		ret = io_read(req, iocb, state, true, force_nonblock);
 		break;
 	case IORING_OP_WRITE:
 		ret = io_write(req, iocb, state, false);
@@ -993,7 +1049,7 @@ static int io_ring_submit(struct io_ring_ctx *ctx, unsigned int to_submit)
 		if (!iocb)
 			break;
 
-		ret = __io_submit_one(ctx, iocb, iocb_index, statep);
+		ret = __io_submit_one(ctx, iocb, iocb_index, statep, false);
 		if (ret)
 			break;
 
@@ -1042,15 +1098,239 @@ static int io_cqring_wait(struct io_ring_ctx *ctx, int min_events)
 	return ring->r.head == ring->r.tail ? ret : 0;
 }
 
+static int io_submit_iocbs(struct io_ring_ctx *ctx, struct iocb_submit *iocbs,
+			   unsigned int nr, struct mm_struct *cur_mm,
+			   bool mm_fault)
+{
+	struct io_submit_state state, *statep = NULL;
+	int ret, i, submitted = 0;
+
+	if (nr > IO_PLUG_THRESHOLD) {
+		io_submit_state_start(&state, ctx, nr);
+		statep = &state;
+	}
+
+	for (i = 0; i < nr; i++) {
+		if (unlikely(mm_fault))
+			ret = -EFAULT;
+		else
+			ret = __io_submit_one(ctx, iocbs[i].iocb,
+						iocbs[i].index, statep, false);
+		if (!ret) {
+			submitted++;
+			continue;
+		}
+
+		io_fill_cq_error(ctx, iocbs[i].index, ret);
+	}
+
+	if (statep)
+		io_submit_state_end(&state);
+
+	return submitted;
+}
+
+/*
+ * sq thread only supports O_DIRECT or FIXEDBUFS IO
+ */
+static int io_sq_thread(void *data)
+{
+	struct iocb_submit iocbs[IO_IOPOLL_BATCH];
+	struct io_ring_ctx *ctx = data;
+	struct io_sq_offload *sqo = &ctx->sq_offload;
+	struct mm_struct *cur_mm = NULL;
+	struct files_struct *old_files;
+	mm_segment_t old_fs;
+	DEFINE_WAIT(wait);
+
+	old_files = current->files;
+	current->files = sqo->files;
+
+	old_fs = get_fs();
+	set_fs(USER_DS);
+
+	while (!kthread_should_stop()) {
+		const struct io_uring_iocb *iocb;
+		bool mm_fault = false;
+		unsigned iocb_index;
+		int i;
+
+		iocb = io_peek_sqring(ctx, &iocb_index);
+		if (!iocb) {
+			/*
+			 * Drop cur_mm before scheduling, we can't hold it for
+			 * long periods (or over schedule()). Do this before
+			 * adding ourselves to the waitqueue, as the unuse/drop
+			 * may sleep.
+			 */
+			if (cur_mm) {
+				unuse_mm(cur_mm);
+				mmput(cur_mm);
+				cur_mm = NULL;
+			}
+
+			prepare_to_wait(&sqo->wait, &wait, TASK_INTERRUPTIBLE);
+			iocb = io_peek_sqring(ctx, &iocb_index);
+			if (!iocb) {
+				if (kthread_should_park())
+					kthread_parkme();
+				if (kthread_should_stop()) {
+					finish_wait(&sqo->wait, &wait);
+					break;
+				}
+				if (signal_pending(current))
+					flush_signals(current);
+				schedule();
+			}
+			finish_wait(&sqo->wait, &wait);
+			if (!iocb)
+				continue;
+		}
+
+		/* If ->mm is set, we're not doing FIXEDBUFS */
+		if (sqo->mm && !cur_mm) {
+			mm_fault = !mmget_not_zero(sqo->mm);
+			if (!mm_fault) {
+				use_mm(sqo->mm);
+				cur_mm = sqo->mm;
+			}
+		}
+
+		i = 0;
+		do {
+			if (i == ARRAY_SIZE(iocbs))
+				break;
+			iocbs[i].iocb = iocb;
+			iocbs[i].index = iocb_index;
+			++i;
+			io_inc_sqring(ctx);
+		} while ((iocb = io_peek_sqring(ctx, &iocb_index)) != NULL);
+
+		io_submit_iocbs(ctx, iocbs, i, cur_mm, mm_fault);
+	}
+	current->files = old_files;
+	set_fs(old_fs);
+	if (cur_mm) {
+		unuse_mm(cur_mm);
+		mmput(cur_mm);
+	}
+	return 0;
+}
+
+static void io_sq_wq_submit_work(struct work_struct *work)
+{
+	struct io_work *iw = container_of(work, struct io_work, work);
+	struct io_ring_ctx *ctx = iw->ctx;
+	struct io_sq_offload *sqo = &ctx->sq_offload;
+	mm_segment_t old_fs = get_fs();
+	struct files_struct *old_files;
+	int ret;
+
+	old_files = current->files;
+	current->files = sqo->files;
+
+	if (sqo->mm) {
+		if (!mmget_not_zero(sqo->mm)) {
+			ret = -EFAULT;
+			goto err;
+		}
+		use_mm(sqo->mm);
+	}
+
+	set_fs(USER_DS);
+
+	ret = __io_submit_one(ctx, &iw->iocb, iw->iocb_index, NULL, false);
+
+	set_fs(old_fs);
+	if (sqo->mm) {
+		unuse_mm(sqo->mm);
+		mmput(sqo->mm);
+	}
+
+err:
+	if (ret)
+		io_fill_cq_error(ctx, iw->iocb_index, ret);
+	current->files = old_files;
+	kfree(iw);
+}
+
+/*
+ * If this is a read, try a cached inline read first. If the IO is in the
+ * page cache, we can satisfy it without blocking and without having to
+ * punt to a threaded execution. This is much faster, particularly for
+ * lower queue depth IO, and it's always a lot more efficient.
+ */
+static bool io_sq_try_inline(struct io_ring_ctx *ctx,
+			     const struct io_uring_iocb *iocb, unsigned index)
+{
+	int ret;
+
+	if (iocb->opcode != IORING_OP_READ &&
+	    iocb->opcode != IORING_OP_READ_FIXED)
+		return false;
+
+	ret = __io_submit_one(ctx, iocb, index, NULL, true);
+
+	/*
+	 * If we get -EAGAIN, return false to submit out-of-line. Any other
+	 * result and we're done, call will fill in CQ ring event.
+	 */
+	return ret != -EAGAIN;
+}
+
+static int io_sq_wq_submit(struct io_ring_ctx *ctx, unsigned int to_submit)
+{
+	const struct io_uring_iocb *iocb;
+	struct io_work *work;
+	unsigned iocb_index;
+	int ret, queued;
+
+	ret = queued = 0;
+	while ((iocb = io_peek_sqring(ctx, &iocb_index)) != NULL) {
+		ret = io_sq_try_inline(ctx, iocb, iocb_index);
+		if (!ret) {
+			work = kmalloc(sizeof(*work), GFP_KERNEL);
+			if (!work) {
+				ret = -ENOMEM;
+				break;
+			}
+			memcpy(&work->iocb, iocb, sizeof(*iocb));
+			io_inc_sqring(ctx);
+			work->iocb_index = iocb_index;
+			INIT_WORK(&work->work, io_sq_wq_submit_work);
+			work->ctx = ctx;
+			queue_work(ctx->sq_offload.wq, &work->work);
+		}
+		queued++;
+		if (queued == to_submit)
+			break;
+	}
+
+	return queued ? queued : ret;
+}
+
 static int __io_uring_enter(struct io_ring_ctx *ctx, unsigned to_submit,
 			    unsigned min_complete, unsigned flags)
 {
 	int ret = 0;
 
 	if (to_submit) {
-		ret = io_ring_submit(ctx, to_submit);
-		if (ret < 0)
-			return ret;
+		/*
+		 * Three options here:
+		 * 1) We have an sq thread, just wake it up to do submissions
+		 * 2) We have an sq wq, queue a work item for each iocb
+		 * 3) Submit directly
+		 */
+		if (ctx->flags & IORING_SETUP_SQTHREAD) {
+			wake_up(&ctx->sq_offload.wait);
+			ret = to_submit;
+		} else if (ctx->flags & IORING_SETUP_SQWQ) {
+			ret = io_sq_wq_submit(ctx, to_submit);
+		} else {
+			ret = io_ring_submit(ctx, to_submit);
+			if (ret < 0)
+				return ret;
+		}
 	}
 	if (flags & IORING_ENTER_GETEVENTS) {
 		unsigned nr_events = 0;
@@ -1192,6 +1472,78 @@ static int io_iocb_buffer_map(struct io_ring_ctx *ctx,
 	return ret;
 }
 
+static int io_sq_thread(void *);
+
+static int io_sq_thread_start(struct io_ring_ctx *ctx)
+{
+	struct io_sq_offload *sqo = &ctx->sq_offload;
+	struct io_iocb_ring *ring = &ctx->sq_ring;
+	int ret;
+
+	memset(sqo, 0, sizeof(*sqo));
+	init_waitqueue_head(&sqo->wait);
+
+	if (!(ctx->flags & IORING_SETUP_FIXEDBUFS))
+		sqo->mm = current->mm;
+
+	ret = -EBADF;
+	sqo->files = get_files_struct(current);
+	if (!sqo->files)
+		goto err;
+
+	if (ctx->flags & IORING_SETUP_SQTHREAD) {
+		sqo->thread = kthread_create_on_cpu(io_sq_thread, ctx,
+							ring->sq_thread_cpu,
+							"io_uring-sq");
+		if (IS_ERR(sqo->thread)) {
+			ret = PTR_ERR(sqo->thread);
+			sqo->thread = NULL;
+			goto err;
+		}
+		wake_up_process(sqo->thread);
+	} else if (ctx->flags & IORING_SETUP_SQWQ) {
+		int concurrency;
+
+		/* Do QD, or 2 * CPUS, whatever is smallest */
+		concurrency = min(ring->entries - 1, 2 * num_online_cpus());
+		sqo->wq = alloc_workqueue("io_ring-wq",
+						WQ_UNBOUND | WQ_FREEZABLE,
+						concurrency);
+		if (!sqo->wq) {
+			ret = -ENOMEM;
+			goto err;
+		}
+	}
+
+	return 0;
+err:
+	if (sqo->files) {
+		put_files_struct(sqo->files);
+		sqo->files = NULL;
+	}
+	if (sqo->mm)
+		sqo->mm = NULL;
+	return ret;
+}
+
+static void io_sq_thread_stop(struct io_ring_ctx *ctx)
+{
+	struct io_sq_offload *sqo = &ctx->sq_offload;
+
+	if (sqo->thread) {
+		kthread_park(sqo->thread);
+		kthread_stop(sqo->thread);
+		sqo->thread = NULL;
+	} else if (sqo->wq) {
+		destroy_workqueue(sqo->wq);
+		sqo->wq = NULL;
+	}
+	if (sqo->files) {
+		put_files_struct(sqo->files);
+		sqo->files = NULL;
+	}
+}
+
 static void io_free_scq_urings(struct io_ring_ctx *ctx)
 {
 	if (ctx->sq_ring.ring) {
@@ -1212,6 +1564,7 @@ static void io_ring_ctx_free(struct work_struct *work)
 {
 	struct io_ring_ctx *ctx = container_of(work, struct io_ring_ctx, work);
 
+	io_sq_thread_stop(ctx);
 	io_iopoll_reap_events(ctx);
 	io_free_scq_urings(ctx);
 	io_iocb_buffer_unmap(ctx);
@@ -1398,6 +1751,13 @@ static int io_uring_create(unsigned entries, struct io_uring_params *p,
 		if (ret)
 			goto err;
 	}
+	if (p->flags & (IORING_SETUP_SQTHREAD | IORING_SETUP_SQWQ)) {
+		ctx->sq_ring.sq_thread_cpu = p->sq_thread_cpu;
+
+		ret = io_sq_thread_start(ctx);
+		if (ret)
+			goto err;
+	}
 
 	ret = anon_inode_getfd("[io_uring]", &io_scqring_fops, ctx,
 				O_RDWR | O_CLOEXEC);
@@ -1431,7 +1791,8 @@ SYSCALL_DEFINE3(io_uring_setup, u32, entries, struct iovec __user *, iovecs,
 			return -EINVAL;
 	}
 
-	if (p.flags & ~(IORING_SETUP_IOPOLL | IORING_SETUP_FIXEDBUFS))
+	if (p.flags & ~(IORING_SETUP_IOPOLL | IORING_SETUP_FIXEDBUFS |
+			IORING_SETUP_SQTHREAD | IORING_SETUP_SQWQ))
 		return -EINVAL;
 
 	ret = io_uring_create(entries, &p, iovecs);
diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index 925fd6ca3f38..4f0a8ce49f9a 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -36,6 +36,8 @@ struct io_uring_iocb {
  */
 #define IORING_SETUP_IOPOLL	(1 << 0)	/* io_context is polled */
 #define IORING_SETUP_FIXEDBUFS	(1 << 1)	/* IO buffers are fixed */
+#define IORING_SETUP_SQTHREAD	(1 << 2)	/* Use SQ thread */
+#define IORING_SETUP_SQWQ	(1 << 3)	/* Use SQ workqueue */
 
 #define IORING_OP_READ		1
 #define IORING_OP_WRITE		2
@@ -96,7 +98,8 @@ struct io_uring_params {
 	__u32 sq_entries;
 	__u32 cq_entries;
 	__u32 flags;
-	__u16 resv[10];
+	__u16 sq_thread_cpu;
+	__u16 resv[9];
 	struct io_sqring_offsets sq_off;
 	struct io_cqring_offsets cq_off;
 };
-- 
2.17.1

