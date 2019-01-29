Return-Path: <SRS0=rnrW=QF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09019C169C4
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 19:27:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C68B82175B
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 19:27:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="O43RYSnZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729260AbfA2T1f (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Jan 2019 14:27:35 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:37707 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729264AbfA2T1f (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Jan 2019 14:27:35 -0500
Received: by mail-io1-f66.google.com with SMTP id g8so17299613iok.4
        for <linux-block@vger.kernel.org>; Tue, 29 Jan 2019 11:27:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nbJLU5CBwv0VdQUgO/vxeIw6wUAkQE3ZqJ0t/vWMr7c=;
        b=O43RYSnZsbF/GL5qdaVESEBg9VgZ7FUFzA1ILOTEVXU7uvtdOUGcAxWqon8U63epgr
         VanHNKuuMVz2DsjAcAZ/n6rqaZfSJdVGrI+C0cl7qA6L5xoCyL1P/xj6T2EkvUDgpj+a
         8pipMPChkeHYMfuG/VcSfai55vbpycgna4ZN5mjBI22BVZLg8ByE/FbY4XDE90nOQ+EO
         OeBNWhWw65qJnGV1268JFgXo4yJwid/je8n8UMFTDk9qFtlBk1y88XKTWVcChD56WB0W
         HeHiSqCL0lESVkwXfnQGvyiHjjCWceIZaMNfEr1RZZM5wBwWWGFUnhg5vXtfGC1ItCwU
         RCOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nbJLU5CBwv0VdQUgO/vxeIw6wUAkQE3ZqJ0t/vWMr7c=;
        b=QCsHtUPky6YKqYF4TiPo7jM9XODyPd5iVQ4FmhmjWN1YcHBYK3X9LGiTp1YTS1L6xa
         9KZsZVlsH4eiQiiiSGChtsz8Q0GS/j59B9RyVuL4LUqNWZA6blIZk5RiRuoSIFBfHRSF
         Lao8x5zFc7OANIsLeFBmFyEkeN+U44Hz9oRi4yy6h3v3j1rNIXctmbf1zPe8Aes/lQz4
         f5JrOgsxj5sjs809TFmFHvZeLS+bLQrNXDVG20bB7OHgzS06F1J7W1k7FMWrzi208/aO
         1qioFy73hv15bGumEkXuVKwiGhrpvPRQo6PyfUtxI8AOuw9+/K6bn+SjjLyUWNj/0sb7
         cLcw==
X-Gm-Message-State: AJcUukfp0aIh0UN28E7UP/UFUFWjpYDjhghqm79UKYbA7+ABq395+njS
        opVFtgBl6EFS1bZe6Mm96TIWCQ==
X-Google-Smtp-Source: ALg8bN5pOI+jU9qPw/mI+Mtbua7GPXIriRvNB8k7cX3bvyob4ECJZrWPXRpj5ylMrC4GZFypyQLxZg==
X-Received: by 2002:a6b:da10:: with SMTP id x16mr15604551iob.101.1548790053212;
        Tue, 29 Jan 2019 11:27:33 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id y3sm15223203iol.55.2019.01.29.11.27.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 11:27:32 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        linux-api@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com, jannh@google.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 14/18] io_uring: add submission polling
Date:   Tue, 29 Jan 2019 12:26:58 -0700
Message-Id: <20190129192702.3605-15-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190129192702.3605-1-axboe@kernel.dk>
References: <20190129192702.3605-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This enables an application to do IO, without ever entering the kernel.
By using the SQ ring to fill in new sqes and watching for completions
on the CQ ring, we can submit and reap IOs without doing a single system
call. The kernel side thread will poll for new submissions, and in case
of HIPRI/polled IO, it'll also poll for completions.

By default, we allow 1 second of active spinning. This can by changed
by passing in a different grace period at io_uring_register(2) time.
If the thread exceeds this idle time without having any work to do, it
will set:

sq_ring->flags |= IORING_SQ_NEED_WAKEUP.

The application will have to call io_uring_enter() to start things back
up again. If IO is kept busy, that will never be needed. Basically an
application that has this feature enabled will guard it's
io_uring_enter(2) call with:

read_barrier();
if (*sq_ring->flags & IORING_SQ_NEED_WAKEUP)
	io_uring_enter(fd, 0, 0, IORING_ENTER_SQ_WAKEUP);

instead of calling it unconditionally.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io_uring.c                 | 243 +++++++++++++++++++++++++++++++++-
 include/uapi/linux/io_uring.h |  12 +-
 2 files changed, 247 insertions(+), 8 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 13c3f8212815..328fb35b4df7 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -24,6 +24,7 @@
 #include <linux/percpu.h>
 #include <linux/slab.h>
 #include <linux/workqueue.h>
+#include <linux/kthread.h>
 #include <linux/blkdev.h>
 #include <linux/bvec.h>
 #include <linux/anon_inodes.h>
@@ -81,14 +82,16 @@ struct io_ring_ctx {
 		unsigned		cached_sq_head;
 		unsigned		sq_entries;
 		unsigned		sq_mask;
-		unsigned		sq_thread_cpu;
+		unsigned		sq_thread_idle;
 		struct io_uring_sqe	*sq_sqes;
 	} ____cacheline_aligned_in_smp;
 
 	/* IO offload */
 	struct workqueue_struct	*sqo_wq;
+	struct task_struct	*sqo_thread;	/* if using sq thread polling */
 	struct mm_struct	*sqo_mm;
 	struct files_struct	*sqo_files;
+	wait_queue_head_t	sqo_wait;
 
 	struct {
 		/* CQ ring */
@@ -271,6 +274,8 @@ static void io_cqring_add_event(struct io_ring_ctx *ctx, u64 ki_user_data,
 
 	if (waitqueue_active(&ctx->wait))
 		wake_up(&ctx->wait);
+	if (waitqueue_active(&ctx->sqo_wait))
+		wake_up(&ctx->sqo_wait);
 }
 
 static void io_ring_drop_ctx_refs(struct io_ring_ctx *ctx, unsigned refs)
@@ -1144,6 +1149,173 @@ static bool io_get_sqring(struct io_ring_ctx *ctx, struct sqe_submit *s)
 	return false;
 }
 
+static int io_submit_sqes(struct io_ring_ctx *ctx, struct sqe_submit *sqes,
+			  unsigned int nr, bool mm_fault)
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
+			ret = io_submit_sqe(ctx, &sqes[i], statep);
+		if (!ret) {
+			submitted++;
+			continue;
+		}
+
+		io_cqring_add_event(ctx, sqes[i].sqe->user_data, ret, 0);
+	}
+
+	if (statep)
+		io_submit_state_end(&state);
+
+	return submitted;
+}
+
+static int io_sq_thread(void *data)
+{
+	struct sqe_submit sqes[IO_IOPOLL_BATCH];
+	struct io_ring_ctx *ctx = data;
+	struct mm_struct *cur_mm = NULL;
+	struct files_struct *old_files;
+	mm_segment_t old_fs;
+	DEFINE_WAIT(wait);
+	unsigned inflight;
+	unsigned long timeout;
+
+	task_lock(current);
+	old_files = current->files;
+	current->files = ctx->sqo_files;
+	task_unlock(current);
+
+	old_fs = get_fs();
+	set_fs(USER_DS);
+
+	timeout = inflight = 0;
+	while (!kthread_should_stop()) {
+		bool all_fixed, mm_fault = false;
+		int i;
+
+		if (inflight) {
+			unsigned nr_events = 0;
+
+			if (ctx->flags & IORING_SETUP_IOPOLL) {
+				/*
+				 * We disallow the app entering submit/complete
+				 * with polling, so no need to lock the ring.
+				 */
+				io_iopoll_check(ctx, &nr_events, 0);
+			} else {
+				/*
+				 * Normal IO, just pretend everything completed.
+				 * We don't have to poll completions for that.
+				 */
+				nr_events = inflight;
+			}
+
+			inflight -= nr_events;
+			if (!inflight)
+				timeout = jiffies + ctx->sq_thread_idle;
+		}
+
+		if (!io_get_sqring(ctx, &sqes[0])) {
+			/*
+			 * We're polling. If we're within the defined idle
+			 * period, then let us spin without work before going
+			 * to sleep.
+			 */
+			if (inflight || !time_after(jiffies, timeout)) {
+				cpu_relax();
+				continue;
+			}
+
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
+			prepare_to_wait(&ctx->sqo_wait, &wait,
+						TASK_INTERRUPTIBLE);
+
+			/* Tell userspace we may need a wakeup call */
+			ctx->sq_ring->flags |= IORING_SQ_NEED_WAKEUP;
+			smp_wmb();
+
+			if (!io_get_sqring(ctx, &sqes[0])) {
+				if (kthread_should_park())
+					kthread_parkme();
+				if (kthread_should_stop()) {
+					finish_wait(&ctx->sqo_wait, &wait);
+					break;
+				}
+				if (signal_pending(current))
+					flush_signals(current);
+				schedule();
+				finish_wait(&ctx->sqo_wait, &wait);
+
+				ctx->sq_ring->flags &= ~IORING_SQ_NEED_WAKEUP;
+				smp_wmb();
+				continue;
+			}
+			finish_wait(&ctx->sqo_wait, &wait);
+
+			ctx->sq_ring->flags &= ~IORING_SQ_NEED_WAKEUP;
+			smp_wmb();
+		}
+
+		i = 0;
+		all_fixed = true;
+		do {
+			if (all_fixed && io_sqe_needs_user(sqes[i].sqe))
+				all_fixed = false;
+
+			i++;
+			if (i == ARRAY_SIZE(sqes))
+				break;
+		} while (io_get_sqring(ctx, &sqes[i]));
+
+		io_commit_sqring(ctx);
+
+		/* Unless all new commands are FIXED regions, grab mm */
+		if (!all_fixed && !cur_mm) {
+			mm_fault = !mmget_not_zero(ctx->sqo_mm);
+			if (!mm_fault) {
+				use_mm(ctx->sqo_mm);
+				cur_mm = ctx->sqo_mm;
+			}
+		}
+
+		inflight += io_submit_sqes(ctx, sqes, i, mm_fault);
+	}
+
+	io_iopoll_reap_events(ctx);
+
+	task_lock(current);
+	current->files = old_files;
+	task_unlock(current);
+
+	set_fs(old_fs);
+	if (cur_mm) {
+		unuse_mm(cur_mm);
+		mmput(cur_mm);
+	}
+	return 0;
+}
+
 static int io_ring_submit(struct io_ring_ctx *ctx, unsigned int to_submit)
 {
 	struct io_submit_state state, *statep = NULL;
@@ -1229,6 +1401,17 @@ static int __io_uring_enter(struct io_ring_ctx *ctx, unsigned to_submit,
 {
 	int submitted, ret;
 
+	/*
+	 * For SQ polling, the thread will do all submissions and completions.
+	 * Just return the requested submit count, and wake the thread if
+	 * we were asked to.
+	 */
+	if (ctx->flags & IORING_SETUP_SQPOLL) {
+		if (flags & IORING_ENTER_SQ_WAKEUP)
+			wake_up(&ctx->sqo_wait);
+		return to_submit;
+	}
+
 	submitted = ret = 0;
 	if (to_submit) {
 		to_submit = min(to_submit, ctx->sq_entries);
@@ -1310,10 +1493,12 @@ static int io_sqe_files_register(struct io_ring_ctx *ctx, void __user *arg,
 	return ret;
 }
 
-static int io_sq_offload_start(struct io_ring_ctx *ctx)
+static int io_sq_offload_start(struct io_ring_ctx *ctx,
+			       struct io_uring_params *p)
 {
 	int ret;
 
+	init_waitqueue_head(&ctx->sqo_wait);
 	mmgrab(current->mm);
 	ctx->sqo_mm = current->mm;
 
@@ -1322,6 +1507,38 @@ static int io_sq_offload_start(struct io_ring_ctx *ctx)
 	if (!ctx->sqo_files)
 		goto err;
 
+	ctx->sq_thread_idle = msecs_to_jiffies(p->sq_thread_idle);
+	if (!ctx->sq_thread_idle)
+		ctx->sq_thread_idle = HZ;
+
+	ret = -EINVAL;
+	if (!cpu_possible(p->sq_thread_cpu))
+		goto err;
+
+	if (ctx->flags & IORING_SETUP_SQPOLL) {
+		if (p->flags & IORING_SETUP_SQ_AFF) {
+			int cpu;
+
+			cpu = array_index_nospec(p->sq_thread_cpu, NR_CPUS);
+			ctx->sqo_thread = kthread_create_on_cpu(io_sq_thread,
+							ctx, cpu,
+							"io_uring-sq");
+		} else {
+			ctx->sqo_thread = kthread_create(io_sq_thread, ctx,
+							"io_uring-sq");
+		}
+		if (IS_ERR(ctx->sqo_thread)) {
+			ret = PTR_ERR(ctx->sqo_thread);
+			ctx->sqo_thread = NULL;
+			goto err;
+		}
+		wake_up_process(ctx->sqo_thread);
+	} else if (p->flags & IORING_SETUP_SQ_AFF) {
+		/* Can't have SQ_AFF without SQPOLL */
+		ret = -EINVAL;
+		goto err;
+	}
+
 	/* Do QD, or 2 * CPUS, whatever is smallest */
 	ctx->sqo_wq = alloc_workqueue("io_ring-wq", WQ_UNBOUND | WQ_FREEZABLE,
 			min(ctx->sq_entries - 1, 2 * num_online_cpus()));
@@ -1332,6 +1549,11 @@ static int io_sq_offload_start(struct io_ring_ctx *ctx)
 
 	return 0;
 err:
+	if (ctx->sqo_thread) {
+		kthread_park(ctx->sqo_thread);
+		kthread_stop(ctx->sqo_thread);
+		ctx->sqo_thread = NULL;
+	}
 	if (ctx->sqo_files) {
 		put_files_struct(ctx->sqo_files);
 		ctx->sqo_files = NULL;
@@ -1593,11 +1815,16 @@ static int io_sqe_buffer_register(struct io_ring_ctx *ctx, void __user *arg,
 
 static void io_ring_ctx_free(struct io_ring_ctx *ctx)
 {
+	if (ctx->sqo_thread) {
+		kthread_park(ctx->sqo_thread);
+		kthread_stop(ctx->sqo_thread);
+	}
 	destroy_workqueue(ctx->sqo_wq);
 	mmdrop(ctx->sqo_mm);
 	put_files_struct(ctx->sqo_files);
 
-	io_iopoll_reap_events(ctx);
+	if (!(ctx->flags & IORING_SETUP_SQPOLL))
+		io_iopoll_reap_events(ctx);
 	io_sqe_buffer_unregister(ctx);
 	io_sqe_files_unregister(ctx);
 
@@ -1638,7 +1865,8 @@ static void io_ring_ctx_wait_and_kill(struct io_ring_ctx *ctx)
 	percpu_ref_kill(&ctx->refs);
 	mutex_unlock(&ctx->uring_lock);
 
-	io_iopoll_reap_events(ctx);
+	if (!(ctx->flags & IORING_SETUP_SQPOLL))
+		io_iopoll_reap_events(ctx);
 	wait_for_completion(&ctx->ctx_done);
 	io_ring_ctx_free(ctx);
 }
@@ -1691,7 +1919,7 @@ SYSCALL_DEFINE6(io_uring_enter, unsigned int, fd, u32, to_submit,
 	long ret = -EBADF;
 	struct fd f;
 
-	if (flags & ~IORING_ENTER_GETEVENTS)
+	if (flags & ~(IORING_ENTER_GETEVENTS | IORING_ENTER_SQ_WAKEUP))
 		return -EINVAL;
 
 	f = fdget(fd);
@@ -1811,7 +2039,7 @@ static int io_uring_create(unsigned entries, struct io_uring_params *p)
 	if (ret)
 		goto err;
 
-	ret = io_sq_offload_start(ctx);
+	ret = io_sq_offload_start(ctx, p);
 	if (ret)
 		goto err;
 
@@ -1860,7 +2088,8 @@ static long io_uring_setup(u32 entries, struct io_uring_params __user *params)
 			return -EINVAL;
 	}
 
-	if (p.flags & ~IORING_SETUP_IOPOLL)
+	if (p.flags & ~(IORING_SETUP_IOPOLL | IORING_SETUP_SQPOLL |
+			IORING_SETUP_SQ_AFF))
 		return -EINVAL;
 
 	ret = io_uring_create(entries, &p);
diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index 3e79feb34a9c..0d85da31e260 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -42,6 +42,8 @@ struct io_uring_sqe {
  * io_uring_setup() flags
  */
 #define IORING_SETUP_IOPOLL	(1U << 0)	/* io_context is polled */
+#define IORING_SETUP_SQPOLL	(1U << 1)	/* SQ poll thread */
+#define IORING_SETUP_SQ_AFF	(1U << 2)	/* sq_thread_cpu is valid */
 
 #define IORING_OP_NOP		0
 #define IORING_OP_READV		1
@@ -85,6 +87,11 @@ struct io_sqring_offsets {
 	__u32 resv[3];
 };
 
+/*
+ * sq_ring->flags
+ */
+#define IORING_SQ_NEED_WAKEUP	(1U << 0) /* needs io_uring_enter wakeup */
+
 struct io_cqring_offsets {
 	__u32 head;
 	__u32 tail;
@@ -99,6 +106,7 @@ struct io_cqring_offsets {
  * io_uring_enter(2) flags
  */
 #define IORING_ENTER_GETEVENTS	(1U << 0)
+#define IORING_ENTER_SQ_WAKEUP	(1U << 1)
 
 /*
  * Passed in for io_uring_setup(2). Copied back with updated info on success
@@ -107,7 +115,9 @@ struct io_uring_params {
 	__u32 sq_entries;
 	__u32 cq_entries;
 	__u32 flags;
-	__u32 resv[7];
+	__u32 sq_thread_cpu;
+	__u32 sq_thread_idle;
+	__u32 resv[5];
 	struct io_sqring_offsets sq_off;
 	struct io_cqring_offsets cq_off;
 };
-- 
2.17.1

