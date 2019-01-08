Return-Path: <SRS0=D8nw=PQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD7D9C43387
	for <linux-block@archiver.kernel.org>; Tue,  8 Jan 2019 16:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98FA720827
	for <linux-block@archiver.kernel.org>; Tue,  8 Jan 2019 16:57:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="YDm3zG15"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729280AbfAHQ50 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Jan 2019 11:57:26 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:39396 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729179AbfAHQ5U (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Jan 2019 11:57:20 -0500
Received: by mail-io1-f67.google.com with SMTP id k7so3661404iob.6
        for <linux-block@vger.kernel.org>; Tue, 08 Jan 2019 08:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3RCWV6AgIU8uOx1gA8S68fITvQ9DAWXUgA5iZexF/As=;
        b=YDm3zG15dDqoiyqTpSzI3QGTguyQNo/jM2PyvqzQbTXBD2XhvGxF3pU+RJs+lEVvXi
         8XEb1ocIr8LCgiltwUv3cPaIDerfWD2t8D+4MWIv+w3MN5CF6QKq74WiHP/Y5UykZDfL
         U3SySAPuDCP4kagpdC3YYOx8RWrrhd5H0IxzxISEn8Pge2c8nd5X7ENCbgZwtOso9aYS
         u+D9IDxRrPVkYF+A7zGY2oxZeRkRb7p6aAqeuznLSUklwY7VCvP6SAeDzw0pD/BLEfgt
         vGY3PxttoCYKnFd++N/DxLZ8f26+tyEKxMT7Xv6QtadcR9sMEpcy3k0eTHdqfKbK6loa
         A3Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3RCWV6AgIU8uOx1gA8S68fITvQ9DAWXUgA5iZexF/As=;
        b=Xxw0nuyGPq0JtZ2p7BUpfS7z4C3JM6U2HK+4/LTI6tS7DeXUKV8E41B+QOjXEnRkVZ
         ppHOCPCtjPhm7aoemmHP49I+7YO2oazB4Ovkkq9zRiOECg4L3rOWUJ1vLsUgtFi9PuIP
         JN6jw4d8tgX3ZZjAPYV51xPJRvyY0dC55r97F5mCx9zE6kZJgjTaYScohmWYB4Z2jZd2
         nR6tWIzbIt189+3QWZIqBKbibN4wjG4qyd56lPqvv2bGLXzvPVFYSbogGRJLJFEQQi2v
         amWxUk7SqqQ33uyzd7zFxJ3rhHtVanBGRRyn/ylT0uFsstkGZGhL9q4DIO5ge7wMA+b2
         m01g==
X-Gm-Message-State: AJcUuke953dCPgT3lR67Qx6uJKKJCqQI1VSm8CYz8WenPOBbiate/EMv
        oasgeGeC4vM8OB6boiIg+VBZyw==
X-Google-Smtp-Source: ALg8bN4MVNEPw0SoJ6+AbUCji6I4UCu7uAmFJcQjcYgPD4q9hVYJLPJ54oa+AWEMfYf7yQC0d+2Wmg==
X-Received: by 2002:a6b:d803:: with SMTP id y3mr1633035iob.247.1546966639650;
        Tue, 08 Jan 2019 08:57:19 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id m10sm17563442ioq.25.2019.01.08.08.57.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 08:57:18 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org, linux-arch@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 15/16] io_uring: add submission polling
Date:   Tue,  8 Jan 2019 09:56:44 -0700
Message-Id: <20190108165645.19311-16-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190108165645.19311-1-axboe@kernel.dk>
References: <20190108165645.19311-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This enables an application to do IO, without ever entering the kernel.
By using the SQ ring to fill in new events and watching for completions
on the CQ ring, we can submit and reap IOs without doing a single system
call. The kernel side thread will poll for new submissions, and in case
of HIPRI/polled IO, it'll also poll for completions.

For O_DIRECT, we can do this with just SQTHREAD being enabled. For
buffered aio, we need the workqueue as well. If we can satisfy the
buffered inline from the SQTHREAD, we do that. If not, we punt to the
workqueue. This is just like buffered aio off the io_uring_enter(2)
system call.

Proof of concept. If the thread has been idle for 1 second, it will set
sq_ring->flags |= IORING_SQ_NEED_WAKEUP. The application will have to
call io_uring_enter() to start things back up again. If IO is kept busy,
that will never be needed. Basically an application that has this
feature enabled will guard it's io_uring_enter(2) call with:

barrier();
if (*sq_ring->flags & IORING_SQ_NEED_WAKEUP)
	io_uring_enter(fd, to_submit, 0, 0);

instead of calling it unconditionally.

Improvements:

1) Maybe have smarter backoff. Busy loop for X time, then go to
   monitor/mwait, finally the schedule we have now after an idle
   second. Might not be worth the complexity.

2) Probably want the application to pass in the appropriate grace
   period, not hard code it at 1 second.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io_uring.c                 | 135 ++++++++++++++++++++++++++++------
 include/uapi/linux/io_uring.h |   3 +
 2 files changed, 115 insertions(+), 23 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index e6a808a89b78..6c10841e4342 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -80,7 +80,8 @@ struct io_mapped_ubuf {
 
 struct io_sq_offload {
 	struct task_struct	*thread;	/* if using a thread */
-	struct workqueue_struct	*wq;	/* wq offload */
+	bool			thread_poll;
+	struct workqueue_struct	*wq;		/* wq offload */
 	struct mm_struct	*mm;
 	struct files_struct	*files;
 	wait_queue_head_t	wait;
@@ -198,6 +199,7 @@ static const struct file_operations io_scqring_fops;
 
 static void io_ring_ctx_free(struct work_struct *work);
 static void io_ring_ctx_ref_free(struct percpu_ref *ref);
+static void io_sq_wq_submit_work(struct work_struct *work);
 
 static struct io_ring_ctx *io_ring_ctx_alloc(struct io_uring_params *p)
 {
@@ -1098,27 +1100,59 @@ static int io_cqring_wait(struct io_ring_ctx *ctx, int min_events)
 	return ring->r.head == ring->r.tail ? ret : 0;
 }
 
+static int io_queue_async_work(struct io_ring_ctx *ctx, struct iocb_submit *is)
+{
+	struct io_work *work;
+
+	work = kmalloc(sizeof(*work), GFP_KERNEL);
+	if (work) {
+		memcpy(&work->iocb, is->iocb, sizeof(*is->iocb));
+		work->iocb_index = is->index;
+		INIT_WORK(&work->work, io_sq_wq_submit_work);
+		work->ctx = ctx;
+		queue_work(ctx->sq_offload.wq, &work->work);
+		return 0;
+	}
+
+	return -ENOMEM;
+}
+
 static int io_submit_iocbs(struct io_ring_ctx *ctx, struct iocb_submit *iocbs,
 			   unsigned int nr, struct mm_struct *cur_mm,
 			   bool mm_fault)
 {
 	struct io_submit_state state, *statep = NULL;
 	int ret, i, submitted = 0;
+	bool force_nonblock;
 
 	if (nr > IO_PLUG_THRESHOLD) {
 		io_submit_state_start(&state, ctx, nr);
 		statep = &state;
 	}
 
+	/*
+	 * Having both a thread and a workqueue only makes sense for buffered
+	 * IO, where we can't submit in an async fashion. Use the NOWAIT
+	 * trick from the SQ thread, and punt to the workqueue if we can't
+	 * satisfy this iocb without blocking. This is only necessary
+	 * for buffered IO with sqthread polled submission.
+	 */
+	force_nonblock = (ctx->flags & IORING_SETUP_SQWQ) != 0;
+
 	for (i = 0; i < nr; i++) {
-		if (unlikely(mm_fault))
+		if (unlikely(mm_fault)) {
 			ret = -EFAULT;
-		else
+		} else {
 			ret = __io_submit_one(ctx, iocbs[i].iocb,
-						iocbs[i].index, statep, false);
-		if (!ret) {
-			submitted++;
-			continue;
+						iocbs[i].index, statep,
+						force_nonblock);
+			/* nogo, submit to workqueue */
+			if (force_nonblock && ret == -EAGAIN)
+				ret = io_queue_async_work(ctx, &iocbs[i]);
+			if (!ret) {
+				submitted++;
+				continue;
+			}
 		}
 
 		io_fill_cq_error(ctx, iocbs[i].index, ret);
@@ -1131,7 +1165,10 @@ static int io_submit_iocbs(struct io_ring_ctx *ctx, struct iocb_submit *iocbs,
 }
 
 /*
- * sq thread only supports O_DIRECT or FIXEDBUFS IO
+ * SQ thread is woken if the app asked for offloaded submission. This can
+ * be either O_DIRECT, in which case we do submissions directly, or it can
+ * be buffered IO, in which case we do them inline if we can do so without
+ * blocking. If we can't, then we punt to a workqueue.
  */
 static int io_sq_thread(void *data)
 {
@@ -1142,6 +1179,8 @@ static int io_sq_thread(void *data)
 	struct files_struct *old_files;
 	mm_segment_t old_fs;
 	DEFINE_WAIT(wait);
+	unsigned inflight;
+	unsigned long timeout;
 
 	old_files = current->files;
 	current->files = sqo->files;
@@ -1149,14 +1188,43 @@ static int io_sq_thread(void *data)
 	old_fs = get_fs();
 	set_fs(USER_DS);
 
+	timeout = inflight = 0;
 	while (!kthread_should_stop()) {
 		const struct io_uring_iocb *iocb;
 		bool mm_fault = false;
 		unsigned iocb_index;
 		int i;
 
+		if (sqo->thread_poll && inflight) {
+			unsigned int nr_events = 0;
+
+			/*
+			 * Normal IO, just pretend everything completed.
+			 * We don't have to poll completions for that.
+			 */
+			if (ctx->flags & IORING_SETUP_IOPOLL)
+				io_iopoll_check(ctx, &nr_events, 0);
+			else
+				nr_events = inflight;
+
+			inflight -= nr_events;
+			if (!inflight)
+				timeout = jiffies + HZ;
+		}
+
 		iocb = io_peek_sqring(ctx, &iocb_index);
 		if (!iocb) {
+			/*
+			 * If we're polling, let us spin for a second without
+			 * work before going to sleep.
+			 */
+			if (sqo->thread_poll) {
+				if (inflight || !time_after(jiffies, timeout)) {
+					cpu_relax();
+					continue;
+				}
+			}
+
 			/*
 			 * Drop cur_mm before scheduling, we can't hold it for
 			 * long periods (or over schedule()). Do this before
@@ -1170,6 +1238,16 @@ static int io_sq_thread(void *data)
 			}
 
 			prepare_to_wait(&sqo->wait, &wait, TASK_INTERRUPTIBLE);
+
+			/* Tell userspace we may need a wakeup call */
+			if (sqo->thread_poll) {
+				struct io_sq_ring *ring;
+
+				ring = ctx->sq_ring.ring;
+				ring->flags |= IORING_SQ_NEED_WAKEUP;
+				smp_wmb();
+			}
+
 			iocb = io_peek_sqring(ctx, &iocb_index);
 			if (!iocb) {
 				if (kthread_should_park())
@@ -1181,6 +1259,13 @@ static int io_sq_thread(void *data)
 				if (signal_pending(current))
 					flush_signals(current);
 				schedule();
+
+				if (sqo->thread_poll) {
+					struct io_sq_ring *ring;
+
+					ring = ctx->sq_ring.ring;
+					ring->flags &= ~IORING_SQ_NEED_WAKEUP;
+				}
 			}
 			finish_wait(&sqo->wait, &wait);
 			if (!iocb)
@@ -1206,7 +1291,7 @@ static int io_sq_thread(void *data)
 			io_inc_sqring(ctx);
 		} while ((iocb = io_peek_sqring(ctx, &iocb_index)) != NULL);
 
-		io_submit_iocbs(ctx, iocbs, i, cur_mm, mm_fault);
+		inflight += io_submit_iocbs(ctx, iocbs, i, cur_mm, mm_fault);
 	}
 	current->files = old_files;
 	set_fs(old_fs);
@@ -1281,7 +1366,6 @@ static bool io_sq_try_inline(struct io_ring_ctx *ctx,
 static int io_sq_wq_submit(struct io_ring_ctx *ctx, unsigned int to_submit)
 {
 	const struct io_uring_iocb *iocb;
-	struct io_work *work;
 	unsigned iocb_index;
 	int ret, queued;
 
@@ -1289,18 +1373,17 @@ static int io_sq_wq_submit(struct io_ring_ctx *ctx, unsigned int to_submit)
 	while ((iocb = io_peek_sqring(ctx, &iocb_index)) != NULL) {
 		ret = io_sq_try_inline(ctx, iocb, iocb_index);
 		if (!ret) {
-			work = kmalloc(sizeof(*work), GFP_KERNEL);
-			if (!work) {
-				ret = -ENOMEM;
+			struct iocb_submit is = {
+				.iocb = iocb,
+				.index = iocb_index
+			};
+
+			ret = io_queue_async_work(ctx, &is);
+			if (ret)
 				break;
-			}
-			memcpy(&work->iocb, iocb, sizeof(*iocb));
-			io_inc_sqring(ctx);
-			work->iocb_index = iocb_index;
-			INIT_WORK(&work->work, io_sq_wq_submit_work);
-			work->ctx = ctx;
-			queue_work(ctx->sq_offload.wq, &work->work);
 		}
+
+		io_inc_sqring(ctx);
 		queued++;
 		if (queued == to_submit)
 			break;
@@ -1491,6 +1574,9 @@ static int io_sq_thread_start(struct io_ring_ctx *ctx)
 	if (!sqo->files)
 		goto err;
 
+	if (ctx->flags & IORING_SETUP_SQPOLL)
+		sqo->thread_poll = true;
+
 	if (ctx->flags & IORING_SETUP_SQTHREAD) {
 		sqo->thread = kthread_create_on_cpu(io_sq_thread, ctx,
 							ring->sq_thread_cpu,
@@ -1501,7 +1587,8 @@ static int io_sq_thread_start(struct io_ring_ctx *ctx)
 			goto err;
 		}
 		wake_up_process(sqo->thread);
-	} else if (ctx->flags & IORING_SETUP_SQWQ) {
+	}
+	if (ctx->flags & IORING_SETUP_SQWQ) {
 		int concurrency;
 
 		/* Do QD, or 2 * CPUS, whatever is smallest */
@@ -1534,7 +1621,8 @@ static void io_sq_thread_stop(struct io_ring_ctx *ctx)
 		kthread_park(sqo->thread);
 		kthread_stop(sqo->thread);
 		sqo->thread = NULL;
-	} else if (sqo->wq) {
+	}
+	if (sqo->wq) {
 		destroy_workqueue(sqo->wq);
 		sqo->wq = NULL;
 	}
@@ -1792,7 +1880,8 @@ SYSCALL_DEFINE3(io_uring_setup, u32, entries, struct iovec __user *, iovecs,
 	}
 
 	if (p.flags & ~(IORING_SETUP_IOPOLL | IORING_SETUP_FIXEDBUFS |
-			IORING_SETUP_SQTHREAD | IORING_SETUP_SQWQ))
+			IORING_SETUP_SQTHREAD | IORING_SETUP_SQWQ |
+			IORING_SETUP_SQPOLL))
 		return -EINVAL;
 
 	ret = io_uring_create(entries, &p, iovecs);
diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index 4f0a8ce49f9a..bd665d38dd97 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -38,6 +38,7 @@ struct io_uring_iocb {
 #define IORING_SETUP_FIXEDBUFS	(1 << 1)	/* IO buffers are fixed */
 #define IORING_SETUP_SQTHREAD	(1 << 2)	/* Use SQ thread */
 #define IORING_SETUP_SQWQ	(1 << 3)	/* Use SQ workqueue */
+#define IORING_SETUP_SQPOLL	(1 << 4)	/* SQ thread polls */
 
 #define IORING_OP_READ		1
 #define IORING_OP_WRITE		2
@@ -76,6 +77,8 @@ struct io_sqring_offsets {
 	__u32 resv[3];
 };
 
+#define IORING_SQ_NEED_WAKEUP	(1 << 0) /* needs io_uring_enter wakeup */
+
 struct io_cqring_offsets {
 	__u32 head;
 	__u32 tail;
-- 
2.17.1

