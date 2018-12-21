Return-Path: <SRS0=3SAf=O6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED7B7C43387
	for <linux-block@archiver.kernel.org>; Fri, 21 Dec 2018 19:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BDA721929
	for <linux-block@archiver.kernel.org>; Fri, 21 Dec 2018 19:23:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="a6q/676U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391694AbeLUTXX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Dec 2018 14:23:23 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:40827 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391693AbeLUTXN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Dec 2018 14:23:13 -0500
Received: by mail-it1-f193.google.com with SMTP id h193so8017492ita.5
        for <linux-block@vger.kernel.org>; Fri, 21 Dec 2018 11:23:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=b2wSIAbErE1DD//PnXxUbCFtU6QwyM+Ul4E2BB+mQY8=;
        b=a6q/676UB8BoSqLAgPHF7JSbka1a94hGLVF16OZF4/ZwqlF4m9ObhAp86eNK4V88QG
         vYlEwjRn2WXAjvq1evdiZZIKVyjGAEWXXzRaZQHgYgdxXmUbm5/1dnF4IyNk47MIoaco
         rs8MqaAan8OyVOaod8mSc8PiM5X7W2mmNXoEqi/qtkIC9NOqO7/iFRaP6SJiwbf40USS
         2F7xY+Hx5h7UroO6Yh8vYlyzkLsMgnNC2xhn4dznuvL0TvEJuzpBGIlbtW1cGHBJboYS
         7D9NBPiIe7Z9tmuFizBbHZXEjpBjBgtW2QJ9JwV1NiJIDsuYpzT5Sw1+fd/knH+KUBKl
         j+iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=b2wSIAbErE1DD//PnXxUbCFtU6QwyM+Ul4E2BB+mQY8=;
        b=FMe8d18cR2HQBvUVtL6Bn5zkpoTPEx8/Zyu1hzK8z55Zy7dWXQvUij6pP71H9cMoqG
         vB9S/3UGfcCEzextlmgN0P5Hl/giaxWSSRbVqqC+Px/nBvJST0SJinnrAsHAV7ZEA88L
         o2njhGXXJSyQpBLUUeNHPDY4VHYsZ8FmrSx4uxJKSGc0uK3Lf0De5PzznYS5Dp+LSjo8
         9QhTVE21nDVPpCegKCZE93QD8z1vhoSM8mghPE9qVdoSyWmsMbPPPX9kcuSvH1PC/vfw
         YBWz7yODhBAQNyHX5WWUs/Tj4SQzDEvtIpfX39eXZJURHxUQoKbIn1Myjvbu7lFzKV2I
         J8Vg==
X-Gm-Message-State: AA+aEWZuhL5vs7ZJbUSP2oT4EzANIB0C1ZDu0dhmYkPBhV05Mg4ZBCJ6
        qKRNW6F5IR99Eu5z/sCbIJ0/dw==
X-Google-Smtp-Source: AFSGD/VC6D2zOOy244jP8ZUz/SszTIXcTcTv+oTN2EZG+pAHl4B+KTGifnJGA7vjSnlysO57PLedyg==
X-Received: by 2002:a24:a04:: with SMTP id 4mr2804842itw.122.1545420192297;
        Fri, 21 Dec 2018 11:23:12 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id t1sm12456290iol.85.2018.12.21.11.23.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Dec 2018 11:23:11 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org
Cc:     hch@lst.de, viro@zeniv.linux.org.uk, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 20/22] aio: enable polling for IOCTX_FLAG_SQTHREAD
Date:   Fri, 21 Dec 2018 12:22:34 -0700
Message-Id: <20181221192236.12866-21-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181221192236.12866-1-axboe@kernel.dk>
References: <20181221192236.12866-1-axboe@kernel.dk>
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
workqueue. This is just like buffered aio off the io_ring_enter(2)
system call.

Proof of concept. If the thread has been idle for 1 second, it will set
sq_ring->kflags |= IORING_SQ_NEED_WAKEUP. The application will have to
call io_ring_enter() to start things back up again. If IO is kept busy,
that will never be needed. Basically an application that has this
feature enabled will guard it's io_ring_enter(2) call with:

barrier();
if (ring->kflags & IORING_SQ_NEED_WAKEUP)
	io_ring_enter(ctx, to_submit, 0, IORING_SUBMIT);

instead of calling it unconditionally.

Improvements:

1) Maybe have smarter backoff. Busy loop for X time, then go to
   monitor/mwait, finally the schedule we have now after an idle
   second. Might not be worth the complexity.

2) Probably want the application to pass in the appropriate grace
   period, not hard code it at 1 second.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/aio.c                     | 141 ++++++++++++++++++++++++++++-------
 include/uapi/linux/aio_abi.h |   4 +
 2 files changed, 116 insertions(+), 29 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index cd4a61642b46..8894c9299b39 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -120,6 +120,7 @@ struct aio_mapped_ubuf {
 
 struct aio_sq_offload {
 	struct task_struct *thread;	/* if using a thread */
+	bool thread_poll;
 	struct workqueue_struct *wq;	/* wq offload */
 	struct mm_struct *mm;
 	struct files_struct *files;
@@ -340,6 +341,7 @@ static void aio_iocb_buffer_unmap(struct kioctx *);
 static void aio_scqring_unmap(struct kioctx *);
 static void aio_iopoll_reap_events(struct kioctx *);
 static const struct iocb *aio_iocb_from_index(struct kioctx *ctx, unsigned idx);
+static void aio_sq_wq_submit_work(struct work_struct *work);
 
 static struct file *aio_private_file(struct kioctx *ctx, loff_t nr_pages)
 {
@@ -1773,6 +1775,9 @@ static int aio_sq_thread_start(struct kioctx *ctx)
 	if (!aso->files)
 		goto err;
 
+	if (ctx->flags & IOCTX_FLAG_SQPOLL)
+		aso->thread_poll = true;
+
 	if (ctx->flags & IOCTX_FLAG_SQTHREAD) {
 		char name[32];
 
@@ -1786,7 +1791,8 @@ static int aio_sq_thread_start(struct kioctx *ctx)
 			goto err;
 		}
 		wake_up_process(aso->thread);
-	} else if (ctx->flags & IOCTX_FLAG_SQWQ) {
+	}
+	if (ctx->flags & IOCTX_FLAG_SQWQ) {
 		int concurrency;
 
 		/* Do QD, or 2 * CPUS, whatever is smallest */
@@ -1862,7 +1868,8 @@ static void aio_scqring_unmap(struct kioctx *ctx)
 		kthread_park(aso->thread);
 		kthread_stop(aso->thread);
 		aso->thread = NULL;
-	} else if (aso->wq) {
+	}
+	if (aso->wq) {
 		destroy_workqueue(aso->wq);
 		aso->wq = NULL;
 	}
@@ -2080,7 +2087,7 @@ SYSCALL_DEFINE5(io_setup2, u32, nr_events, u32, flags,
 
 	if (flags & ~(IOCTX_FLAG_IOPOLL | IOCTX_FLAG_SCQRING |
 		      IOCTX_FLAG_FIXEDBUFS | IOCTX_FLAG_SQTHREAD |
-		      IOCTX_FLAG_SQWQ))
+		      IOCTX_FLAG_SQWQ | IOCTX_FLAG_SQPOLL))
 		return -EINVAL;
 
 	ret = get_user(ctx, ctxp);
@@ -3153,28 +3160,69 @@ struct iocb_submit {
 	unsigned int index;
 };
 
+struct aio_io_work {
+	struct work_struct work;
+	struct kioctx *ctx;
+	struct iocb iocb;
+	unsigned iocb_index;
+};
+
+static int aio_queue_async_work(struct kioctx *ctx, struct iocb_submit *is)
+{
+	struct aio_io_work *work;
+
+	work = kmalloc(sizeof(*work), GFP_KERNEL);
+	if (work) {
+		memcpy(&work->iocb, is->iocb, sizeof(*is->iocb));
+		work->iocb_index = is->index;
+		INIT_WORK(&work->work, aio_sq_wq_submit_work);
+		work->ctx = ctx;
+		queue_work(ctx->sq_offload.wq, &work->work);
+		return 0;
+	}
+
+	return -ENOMEM;
+}
+
 static int aio_submit_iocbs(struct kioctx *ctx, struct iocb_submit *iocbs,
 			    unsigned int nr, struct mm_struct *cur_mm,
 			    bool mm_fault)
 {
 	struct aio_submit_state state, *statep = NULL;
 	int ret, i, submitted = 0;
+	bool force_nonblock;
 
 	if (nr > AIO_PLUG_THRESHOLD) {
 		aio_submit_state_start(&state, ctx, nr);
 		statep = &state;
 	}
 
+	/*
+	 * Having both a thread and a workqueue only makes sense for buffered
+	 * IO, where we can't submit in an async fashion. Use the NOWAIT
+	 * trick from the SQ thread, and punt to the workqueue if we can't
+	 * satisfy this iocb without blocking. This is only necessary
+	 * for buffered IO with sqthread polled submission.
+	 */
+	force_nonblock = (ctx->flags & IOCTX_FLAG_SQWQ) != 0;
+
 	for (i = 0; i < nr; i++) {
-		if (unlikely(mm_fault))
+		if (unlikely(mm_fault)) {
 			ret = -EFAULT;
-		else
+		} else {
 			ret = __io_submit_one(ctx, iocbs[i].iocb,
 						iocbs[i].index, statep, false,
-						!cur_mm, false);
-		if (!ret) {
-			submitted++;
-			continue;
+						!cur_mm, force_nonblock);
+			/* nogo, submit to workqueue */
+			if (force_nonblock &&
+			    (ret == -EAGAIN || ctx->submit_eagain)) {
+				ctx->submit_eagain = 0;
+				ret = aio_queue_async_work(ctx, &iocbs[i]);
+			}
+			if (!ret) {
+				submitted++;
+				continue;
+			}
 		}
 
 		aio_fill_cq_error(ctx, iocbs[i].iocb, ret);
@@ -3187,17 +3235,23 @@ static int aio_submit_iocbs(struct kioctx *ctx, struct iocb_submit *iocbs,
 }
 
 /*
- * sq thread only supports O_DIRECT or FIXEDBUFS IO
+ * SQ thread is woken if the app asked for offloaded submission. This can
+ * be either O_DIRECT, in which case we do submissions directly, or it can
+ * be buffered IO, in which case we do them inline if we can do so without
+ * blocking. If we can't, then we punt to a workqueue.
  */
 static int aio_sq_thread(void *data)
 {
 	struct iocb_submit iocbs[AIO_IOPOLL_BATCH];
 	struct kioctx *ctx = data;
+	struct aio_sq_ring *ring = ctx->sq_ring.ring;
 	struct aio_sq_offload *aso = &ctx->sq_offload;
 	struct mm_struct *cur_mm = NULL;
 	struct files_struct *old_files;
 	mm_segment_t old_fs;
 	DEFINE_WAIT(wait);
+	unsigned inflight;
+	unsigned long timeout;
 
 	old_files = current->files;
 	current->files = aso->files;
@@ -3205,15 +3259,50 @@ static int aio_sq_thread(void *data)
 	old_fs = get_fs();
 	set_fs(USER_DS);
 
+	timeout = inflight = 0;
 	while (!kthread_should_stop()) {
 		const struct iocb *iocb;
 		bool mm_fault = false;
 		unsigned nhead, index;
 		int i;
 
+		if (aso->thread_poll && inflight) {
+			unsigned int nr_events = 0;
+
+			/*
+			 * Buffered IO, just pretend everything completed.
+			 * We don't have to poll completions for that.
+			 */
+			if (ctx->flags & IOCTX_FLAG_IOPOLL)
+				__aio_iopoll_check(ctx, NULL, &nr_events, 0, -1U);
+			else
+				nr_events = inflight;
+
+			inflight -= nr_events;
+			if (!inflight)
+				timeout = jiffies + HZ;
+		}
+
 		iocb = aio_peek_sqring(ctx, &index, &nhead);
 		if (!iocb) {
+			/*
+			 * If we're polling, let us spin for a second without
+			 * work before going to sleep.
+			 */
+			if (aso->thread_poll) {
+				if (inflight || !time_after(jiffies, timeout)) {
+					cpu_relax();
+					continue;
+				}
+			}
 			prepare_to_wait(&aso->wait, &wait, TASK_INTERRUPTIBLE);
+
+			/* Tell userspace we may need a wakeup call */
+			if (aso->thread_poll) {
+				ring->kflags |= IORING_SQ_NEED_WAKEUP;
+				smp_wmb();
+			}
+
 			iocb = aio_peek_sqring(ctx, &index, &nhead);
 			if (!iocb) {
 				/*
@@ -3235,6 +3324,9 @@ static int aio_sq_thread(void *data)
 				if (signal_pending(current))
 					flush_signals(current);
 				schedule();
+
+				if (aso->thread_poll)
+					ring->kflags &= ~IORING_SQ_NEED_WAKEUP;
 			}
 			finish_wait(&aso->wait, &wait);
 			if (!iocb)
@@ -3260,7 +3352,7 @@ static int aio_sq_thread(void *data)
 			aio_commit_sqring(ctx, nhead);
 		} while ((iocb = aio_peek_sqring(ctx, &index, &nhead)) != NULL);
 
-		aio_submit_iocbs(ctx, iocbs, i, cur_mm, mm_fault);
+		inflight += aio_submit_iocbs(ctx, iocbs, i, cur_mm, mm_fault);
 	}
 	current->files = old_files;
 	set_fs(old_fs);
@@ -3271,13 +3363,6 @@ static int aio_sq_thread(void *data)
 	return 0;
 }
 
-struct aio_io_work {
-	struct work_struct work;
-	struct kioctx *ctx;
-	struct iocb iocb;
-	unsigned iocb_index;
-};
-
 static void aio_sq_wq_submit_work(struct work_struct *work)
 {
 	struct aio_io_work *aiw = container_of(work, struct aio_io_work, work);
@@ -3347,7 +3432,6 @@ static bool aio_sq_try_inline(struct kioctx *ctx, const struct iocb *iocb,
 
 static int aio_sq_wq_submit(struct kioctx *ctx, unsigned int to_submit)
 {
-	struct aio_io_work *work;
 	const struct iocb *iocb;
 	unsigned nhead, index;
 	int ret, queued;
@@ -3356,18 +3440,17 @@ static int aio_sq_wq_submit(struct kioctx *ctx, unsigned int to_submit)
 	while ((iocb = aio_peek_sqring(ctx, &index, &nhead)) != NULL) {
 		ret = aio_sq_try_inline(ctx, iocb, index);
 		if (!ret) {
-			work = kmalloc(sizeof(*work), GFP_KERNEL);
-			if (!work) {
-				ret = -ENOMEM;
+			struct iocb_submit is = {
+				.iocb = iocb,
+				.index = index
+			};
+
+			ret = aio_queue_async_work(ctx, &is);
+			if (ret)
 				break;
-			}
-			memcpy(&work->iocb, iocb, sizeof(*iocb));
-			aio_commit_sqring(ctx, nhead);
-			work->iocb_index = index;
-			INIT_WORK(&work->work, aio_sq_wq_submit_work);
-			work->ctx = ctx;
-			queue_work(ctx->sq_offload.wq, &work->work);
 		}
+
+		aio_commit_sqring(ctx, nhead);
 		queued++;
 		if (queued == to_submit)
 			break;
diff --git a/include/uapi/linux/aio_abi.h b/include/uapi/linux/aio_abi.h
index b09b1976e038..26173de01fee 100644
--- a/include/uapi/linux/aio_abi.h
+++ b/include/uapi/linux/aio_abi.h
@@ -113,6 +113,9 @@ struct iocb {
 #define IOCTX_FLAG_FIXEDBUFS	(1 << 2)	/* IO buffers are fixed */
 #define IOCTX_FLAG_SQTHREAD	(1 << 3)	/* Use SQ thread */
 #define IOCTX_FLAG_SQWQ		(1 << 4)	/* Use SQ workqueue */
+#define IOCTX_FLAG_SQPOLL	(1 << 5)	/* SQ thread polls */
+
+#define IORING_SQ_NEED_WAKEUP	(1 << 0)	/* needs io_ring_enter wakeup */
 
 struct aio_sq_ring {
 	union {
@@ -121,6 +124,7 @@ struct aio_sq_ring {
 			u32 tail;	/* app producer tail */
 			u32 nr_events;	/* max events in ring */
 			u16 sq_thread_cpu;
+			u16 kflags;	/* kernel info to app */
 			u64 iocbs;	/* setup pointer to app iocbs */
 		};
 		u32 pad[16];
-- 
2.17.1

