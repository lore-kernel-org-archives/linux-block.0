Return-Path: <SRS0=tdSH=PS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C8EC43444
	for <linux-block@archiver.kernel.org>; Thu, 10 Jan 2019 02:44:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3DF921738
	for <linux-block@archiver.kernel.org>; Thu, 10 Jan 2019 02:44:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="f21rJ7K1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbfAJCoq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Jan 2019 21:44:46 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45722 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727142AbfAJCoo (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Jan 2019 21:44:44 -0500
Received: by mail-pf1-f194.google.com with SMTP id g62so4583915pfd.12
        for <linux-block@vger.kernel.org>; Wed, 09 Jan 2019 18:44:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/dpaO2R3HJe56fTX4cXfsKpL2XQCbaiSgmrj4ZFB8cQ=;
        b=f21rJ7K13uzes1BFhnk47YebtdIOwYKg2Sdu+X8/DTAiExPuGzVcieogR/NdvuoWKy
         Jdv/KLdrQqafjN+tsyT1Uma+84aSkFtfkeAiiXyOCNDqkXw1HALXweokFvxASb3UgH4l
         OxqRFQJ3fIdemMNZQtJRyjQPibYefW+42pQFUKQLlunBefsn6LKscqIzsznhAZbAm/+k
         95/1eZunmfmxL9fe3I7rFpKwjnNliBKv4dD0ZjbuS7QfdXwlSvv9TEQ2pnbnCKRHTeRT
         vmXoglO5ss8xntcEJiVgPejffO1J1QyW2qFb+UN/nFE+rOrJZiOMB7XGaf6sjxIPGyuy
         GFlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/dpaO2R3HJe56fTX4cXfsKpL2XQCbaiSgmrj4ZFB8cQ=;
        b=BWZhDIu2blV1IDdEruBYuiG3DGZXAHH9T8Z9OG+8KV7VcB5GymQ0rqZtRWj1dqC6aX
         vyJy5xdCX4wWlIhGCOuoQ8s0p/bZfJrH0ue9tUOl+zbvWKcEwo8+Dws+gk6wdTrWc2+w
         c+rnp5htEnDTRF6TVLnkv+2fkEy2pWcnZipBaTLv5GhknaSfwGqWfsNyVTJo/YrNJk/7
         TLnecUSsGRZxfLWqAtB05t7rkZvwk4wHEJ+zqAI4/Qc9kqw52uEwN+6hWa6wHCFnJerx
         c/gdSMolvhbXjBIS/HOJuBny0toAfIPg5RpY9Re2WiqZViy22K97Ll3ptTWy0W+GrVfs
         Op4w==
X-Gm-Message-State: AJcUukf17ZinunNGYFOer8HiiGlXucenxbNzQSbpke7utFWQ/i8/YQxz
        A+FQBPQeSkLzi25v2NM/lkaFDw==
X-Google-Smtp-Source: ALg8bN4NGJEb7HmA7JDInRbQG5ByDzYoEihNPJAx940wQNfH4CGeX0FER879eO2KIVLoXWjFl1g2og==
X-Received: by 2002:a63:e247:: with SMTP id y7mr5297429pgj.84.1547088283321;
        Wed, 09 Jan 2019 18:44:43 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id v15sm105799631pfn.94.2019.01.09.18.44.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jan 2019 18:44:42 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org, linux-arch@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 13/15] io_uring: support kernel side submission
Date:   Wed,  9 Jan 2019 19:44:02 -0700
Message-Id: <20190110024404.25372-14-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190110024404.25372-1-axboe@kernel.dk>
References: <20190110024404.25372-1-axboe@kernel.dk>
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
 fs/io_uring.c                 | 378 ++++++++++++++++++++++++++++++++--
 include/uapi/linux/io_uring.h |   5 +-
 2 files changed, 369 insertions(+), 14 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 7ab20258e39b..da46872ecd67 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -15,6 +15,7 @@
 #include <linux/sched/signal.h>
 #include <linux/fs.h>
 #include <linux/file.h>
+#include <linux/fdtable.h>
 #include <linux/mm.h>
 #include <linux/mman.h>
 #include <linux/mmu_context.h>
@@ -25,6 +26,8 @@
 #include <linux/anon_inodes.h>
 #include <linux/sizes.h>
 #include <linux/nospec.h>
+#include <linux/kthread.h>
+#include <linux/sched/mm.h>
 
 #include <linux/uaccess.h>
 #include <linux/nospec.h>
@@ -62,6 +65,14 @@ struct io_mapped_ubuf {
 	unsigned int	nr_bvecs;
 };
 
+struct io_sq_offload {
+	struct task_struct	*thread;	/* if using a thread */
+	struct workqueue_struct	*wq;		/* wq offload */
+	struct mm_struct	*mm;
+	struct files_struct	*files;
+	wait_queue_head_t	wait;
+};
+
 struct io_ring_ctx {
 	struct percpu_ref	refs;
 
@@ -71,6 +82,7 @@ struct io_ring_ctx {
 	struct io_sq_ring	*sq_ring;
 	unsigned		sq_entries;
 	unsigned		sq_mask;
+	unsigned		sq_thread_cpu;
 	struct io_uring_sqe	*sq_sqes;
 
 	/* CQ ring */
@@ -81,6 +93,9 @@ struct io_ring_ctx {
 	/* if used, fixed mapped user buffers */
 	struct io_mapped_ubuf	*user_bufs;
 
+	/* sq ring submitter thread, if used */
+	struct io_sq_offload	sq_offload;
+
 	struct completion	ctx_done;
 
 	/* iopoll submission state */
@@ -115,6 +130,7 @@ struct io_kiocb {
 	unsigned long		ki_flags;
 #define KIOCB_F_IOPOLL_COMPLETED	0	/* polled IO has completed */
 #define KIOCB_F_IOPOLL_EAGAIN		1	/* submission got EAGAIN */
+#define KIOCB_F_FORCE_NONBLOCK		2	/* inline submission attempt */
 };
 
 #define IO_PLUG_THRESHOLD		2
@@ -125,6 +141,12 @@ struct sqe_submit {
 	unsigned index;
 };
 
+struct io_work {
+	struct work_struct work;
+	struct io_ring_ctx *ctx;
+	struct sqe_submit submit;
+};
+
 struct io_submit_state {
 	struct io_ring_ctx *ctx;
 
@@ -471,6 +493,20 @@ static void io_cqring_fill_event(struct io_ring_ctx *ctx, unsigned ki_index,
 	spin_unlock_irqrestore(&ctx->completion_lock, flags);
 }
 
+static void io_fill_cq_error(struct io_ring_ctx *ctx, struct sqe_submit *s,
+			     long error)
+{
+	io_cqring_fill_event(ctx, s->index, error, 0);
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
@@ -543,7 +579,7 @@ static struct file *io_file_get(struct io_submit_state *state, int fd)
 }
 
 static int io_prep_rw(struct io_kiocb *kiocb, const struct io_uring_sqe *sqe,
-		      struct io_submit_state *state)
+		      struct io_submit_state *state, bool force_nonblock)
 {
 	struct io_ring_ctx *ctx = kiocb->ki_ctx;
 	struct kiocb *req = &kiocb->rw;
@@ -567,6 +603,10 @@ static int io_prep_rw(struct io_kiocb *kiocb, const struct io_uring_sqe *sqe,
 	ret = kiocb_set_rw_flags(req, sqe->rw_flags);
 	if (unlikely(ret))
 		goto out_fput;
+	if (force_nonblock) {
+		req->ki_flags |= IOCB_NOWAIT;
+		set_bit(KIOCB_F_FORCE_NONBLOCK, &kiocb->ki_flags);
+	}
 
 	if (ctx->flags & IORING_SETUP_IOPOLL) {
 		ret = -EOPNOTSUPP;
@@ -701,7 +741,7 @@ static int io_import_fixed(int rw, struct io_kiocb *kiocb,
 }
 
 static ssize_t io_read(struct io_kiocb *kiocb, const struct io_uring_sqe *sqe,
-		       struct io_submit_state *state)
+		       struct io_submit_state *state, bool nonblock)
 {
 	struct iovec inline_vecs[UIO_FASTIOV], *iovec = inline_vecs;
 	struct kiocb *req = &kiocb->rw;
@@ -709,7 +749,7 @@ static ssize_t io_read(struct io_kiocb *kiocb, const struct io_uring_sqe *sqe,
 	struct file *file;
 	ssize_t ret;
 
-	ret = io_prep_rw(kiocb, sqe, state);
+	ret = io_prep_rw(kiocb, sqe, state, nonblock);
 	if (ret)
 		return ret;
 	file = req->ki_filp;
@@ -734,8 +774,18 @@ static ssize_t io_read(struct io_kiocb *kiocb, const struct io_uring_sqe *sqe,
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
@@ -752,7 +802,7 @@ static ssize_t io_write(struct io_kiocb *kiocb, const struct io_uring_sqe *sqe,
 	struct file *file;
 	ssize_t ret;
 
-	ret = io_prep_rw(kiocb, sqe, state);
+	ret = io_prep_rw(kiocb, sqe, state, false);
 	if (ret)
 		return ret;
 	file = req->ki_filp;
@@ -837,7 +887,7 @@ static int io_fsync(struct io_kiocb *kiocb, const struct io_uring_sqe *sqe,
 }
 
 static int io_submit_sqe(struct io_ring_ctx *ctx, struct sqe_submit *s,
-			 struct io_submit_state *state)
+			 struct io_submit_state *state, bool force_nonblock)
 {
 	const struct io_uring_sqe *sqe = s->sqe;
 	struct io_kiocb *req;
@@ -860,7 +910,7 @@ static int io_submit_sqe(struct io_ring_ctx *ctx, struct sqe_submit *s,
 	switch (sqe->opcode) {
 	case IORING_OP_READV:
 	case IORING_OP_READ_FIXED:
-		ret = io_read(req, sqe, state);
+		ret = io_read(req, sqe, state, force_nonblock);
 		break;
 	case IORING_OP_WRITEV:
 	case IORING_OP_WRITE_FIXED:
@@ -988,7 +1038,7 @@ static int io_ring_submit(struct io_ring_ctx *ctx, unsigned int to_submit)
 		if (!io_peek_sqring(ctx, &s))
 			break;
 
-		ret = io_submit_sqe(ctx, &s, statep);
+		ret = io_submit_sqe(ctx, &s, statep, false);
 		if (ret)
 			break;
 
@@ -1037,15 +1087,237 @@ static int io_cqring_wait(struct io_ring_ctx *ctx, int min_events)
 	return ring->r.head == ring->r.tail ? ret : 0;
 }
 
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
+	ret = io_submit_sqe(ctx, &iw->submit, NULL, false);
+
+	set_fs(old_fs);
+	if (sqo->mm) {
+		unuse_mm(sqo->mm);
+		mmput(sqo->mm);
+	}
+
+err:
+	if (ret)
+		io_fill_cq_error(ctx, &iw->submit, ret);
+	current->files = old_files;
+	kfree(iw);
+}
+
+static int io_queue_async_work(struct io_ring_ctx *ctx, struct sqe_submit *s)
+{
+	struct io_work *work;
+
+	work = kmalloc(sizeof(*work), GFP_KERNEL);
+	if (!work)
+		return -ENOMEM;
+
+	memcpy(&work->submit, s, sizeof(*s));
+	INIT_WORK(&work->work, io_sq_wq_submit_work);
+	work->ctx = ctx;
+	queue_work(ctx->sq_offload.wq, &work->work);
+	return 0;
+}
+
+static int io_submit_sqes(struct io_ring_ctx *ctx, struct sqe_submit *sqes,
+			  unsigned int nr, struct mm_struct *cur_mm,
+			  bool mm_fault)
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
+			ret = io_submit_sqe(ctx, &sqes[i], statep, false);
+		if (!ret) {
+			submitted++;
+			continue;
+		}
+
+		io_fill_cq_error(ctx, &sqes[i], ret);
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
+	struct sqe_submit sqes[IO_IOPOLL_BATCH];
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
+		bool mm_fault = false;
+		int i;
+
+		if (!io_peek_sqring(ctx, &sqes[0])) {
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
+			if (!io_peek_sqring(ctx, &sqes[0])) {
+				if (kthread_should_park())
+					kthread_parkme();
+				if (kthread_should_stop()) {
+					finish_wait(&sqo->wait, &wait);
+					break;
+				}
+				if (signal_pending(current))
+					flush_signals(current);
+				schedule();
+				finish_wait(&sqo->wait, &wait);
+				continue;
+			}
+			finish_wait(&sqo->wait, &wait);
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
+			if (i == ARRAY_SIZE(sqes))
+				break;
+			i++;
+			io_inc_sqring(ctx);
+		} while (io_peek_sqring(ctx, &sqes[i]));
+
+		io_submit_sqes(ctx, sqes, i, cur_mm, mm_fault);
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
+/*
+ * If this is a read, try a cached inline read first. If the IO is in the
+ * page cache, we can satisfy it without blocking and without having to
+ * punt to a threaded execution. This is much faster, particularly for
+ * lower queue depth IO, and it's always a lot more efficient.
+ */
+static bool io_sq_try_inline(struct io_ring_ctx *ctx, struct sqe_submit *s)
+{
+	int ret;
+
+	if (s->sqe->opcode != IORING_OP_READV &&
+	    s->sqe->opcode != IORING_OP_READ_FIXED)
+		return false;
+
+	ret = io_submit_sqe(ctx, s, NULL, true);
+
+	/*
+	 * If we get -EAGAIN, return false to submit out-of-line. Any other
+	 * result and we're done, caller will fill in CQ ring event.
+	 */
+	return ret != -EAGAIN;
+}
+
+static int io_sq_wq_submit(struct io_ring_ctx *ctx, unsigned int to_submit)
+{
+	struct sqe_submit s;
+	int ret, queued;
+
+	ret = queued = 0;
+	while (io_peek_sqring(ctx, &s)) {
+		ret = io_sq_try_inline(ctx, &s);
+		if (!ret) {
+			ret = io_queue_async_work(ctx, &s);
+			if (ret)
+				break;
+		}
+		io_inc_sqring(ctx);
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
+		 * 2) We have an sq wq, queue a work item for each sqe
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
@@ -1187,6 +1459,77 @@ static int io_sqe_buffer_map(struct io_ring_ctx *ctx,
 	return ret;
 }
 
+static int io_sq_thread(void *);
+
+static int io_sq_thread_start(struct io_ring_ctx *ctx)
+{
+	struct io_sq_offload *sqo = &ctx->sq_offload;
+	int ret;
+
+	memset(sqo, 0, sizeof(*sqo));
+	init_waitqueue_head(&sqo->wait);
+
+	if (!ctx->user_bufs)
+		sqo->mm = current->mm;
+
+	/*
+	 * This is safe since 'current' has the fd installed, and if that
+	 * gets closed on exit, then fops->release() is invoked which
+	 * waits for the sq thread and sq workqueue to flush and exit
+	 * before exiting.
+	 */
+	ret = -EBADF;
+	sqo->files = current->files;
+	if (!sqo->files)
+		goto err;
+
+	if (ctx->flags & IORING_SETUP_SQTHREAD) {
+		sqo->thread = kthread_create_on_cpu(io_sq_thread, ctx,
+							ctx->sq_thread_cpu,
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
+		concurrency = min(ctx->sq_entries - 1, 2 * num_online_cpus());
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
+	if (sqo->files)
+		sqo->files = NULL;
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
+}
+
 static void io_free_scq_urings(struct io_ring_ctx *ctx)
 {
 	if (ctx->sq_ring) {
@@ -1205,6 +1548,7 @@ static void io_free_scq_urings(struct io_ring_ctx *ctx)
 
 static void io_ring_ctx_free(struct io_ring_ctx *ctx)
 {
+	io_sq_thread_stop(ctx);
 	io_iopoll_reap_events(ctx);
 	io_free_scq_urings(ctx);
 	io_sqe_buffer_unmap(ctx);
@@ -1394,6 +1738,13 @@ static int io_uring_create(unsigned entries, struct io_uring_params *p,
 		if (ret)
 			goto err;
 	}
+	if (p->flags & (IORING_SETUP_SQTHREAD | IORING_SETUP_SQWQ)) {
+		ctx->sq_thread_cpu = p->sq_thread_cpu;
+
+		ret = io_sq_thread_start(ctx);
+		if (ret)
+			goto err;
+	}
 
 	ret = anon_inode_getfd("[io_uring]", &io_scqring_fops, ctx,
 				O_RDWR | O_CLOEXEC);
@@ -1426,7 +1777,8 @@ SYSCALL_DEFINE3(io_uring_setup, u32, entries, struct iovec __user *, iovecs,
 			return -EINVAL;
 	}
 
-	if (p.flags & ~IORING_SETUP_IOPOLL)
+	if (p.flags & ~(IORING_SETUP_IOPOLL | IORING_SETUP_SQTHREAD |
+			IORING_SETUP_SQWQ))
 		return -EINVAL;
 
 	ret = io_uring_create(entries, &p, iovecs);
diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index 80d1a8224b9c..79004940f7da 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -35,6 +35,8 @@ struct io_uring_sqe {
  * io_uring_setup() flags
  */
 #define IORING_SETUP_IOPOLL	(1 << 0)	/* io_context is polled */
+#define	IORING_SETUP_SQTHREAD	(1 << 1)	/* Use SQ thread */
+#define IORING_SETUP_SQWQ	(1 << 2)	/* Use SQ workqueue */
 
 #define IORING_OP_READV		1
 #define IORING_OP_WRITEV	2
@@ -95,7 +97,8 @@ struct io_uring_params {
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

