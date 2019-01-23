Return-Path: <SRS0=btbQ=P7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6B14C282C0
	for <linux-block@archiver.kernel.org>; Wed, 23 Jan 2019 15:36:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F16821855
	for <linux-block@archiver.kernel.org>; Wed, 23 Jan 2019 15:36:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="fRFLJQGZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725862AbfAWPgE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Jan 2019 10:36:04 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46943 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbfAWPgE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Jan 2019 10:36:04 -0500
Received: by mail-pg1-f193.google.com with SMTP id w7so1213939pgp.13
        for <linux-block@vger.kernel.org>; Wed, 23 Jan 2019 07:36:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mVIV2pvMVaNgGtQXETepKMTEDba95Rm66v7u8ssrxWw=;
        b=fRFLJQGZfw9brmJvqi/mRc3wBuziehltRMLRqRPDkhP9kG8Aj/74kYKAndcOMG6MTT
         1GYTIw3NFKOGIfo+vlXIWukOJk1fU+xEwvUrC4K1DEjs17q5dtbjIK5sG+uFYBuBzgLw
         xM90KG4aFmO9Dh2gFG7hZMsaGtgkPTL1yVVMX6Ph0KJHXwIQ3G8q8YZwRdvrmtXPygCM
         tRhboTI1pw6XNupGzvTbXoFXDnrPOlaX7YGxbN2IyXP/lH7CoGVpcNCLts3FSX8VqFpx
         sgUSxxBU29yNB6xBM37Im8xkaNihG15ZfugN4+DgLguvedGJdHNt1wQLS8UNvdLDYlvH
         CCkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mVIV2pvMVaNgGtQXETepKMTEDba95Rm66v7u8ssrxWw=;
        b=Su1Dzyudar0qR2/9fa7fhhLVK89MyRStL1tLiiAEWlQvwFzbXWgaBOlAVqBcbfg8OD
         5Ck0tHd5gAHefv2YFS51Dql2dJhjiIgfbftGcFGtBhuJmPpzfQExVSG8nT8zZyR1ExtK
         1L12//Sb1NOparttwu63ONo5WGGeaxo2rYX8KWsqbZUlB5oH505jeXpxxCudUNWiHmIF
         lIl3OARKKPS+oHwcdj7IDQrXGl9JV0KdGDteWMm779HbCvcD2haY6d38XHHmcnPQObfQ
         o1RDyjSx4Avjs3fuDdhcWzk1yg3I+/L9knhLQnjg5jd+iB0LbFsFpUSFCh2USZ67TEr+
         PTWQ==
X-Gm-Message-State: AJcUukfR/q+1Gmnzmd3SYF/zVNNDYDhs5+uQyrbEPE0LwVoUVJtq9o67
        kTweG6+eT9pHtrC6qcX9oI6kcA==
X-Google-Smtp-Source: ALg8bN6S6CXt1sDiWbhQ1qlnViIMcd8Hvy/WcGa/h3sWP++u1r22m1B6Rqa348SC6641qBCNGuZPtQ==
X-Received: by 2002:a63:83:: with SMTP id 125mr2285785pga.343.1548257763265;
        Wed, 23 Jan 2019 07:36:03 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id u8sm30731715pfl.16.2019.01.23.07.36.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jan 2019 07:36:02 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 09/13] io_uring: add submission polling
Date:   Wed, 23 Jan 2019 08:35:22 -0700
Message-Id: <20190123153536.7081-12-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190123153536.7081-1-axboe@kernel.dk>
References: <20190123153536.7081-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This enables an application to do IO, without ever entering the kernel.
By using the SQ ring to fill in new sqes and watching for completions
on the CQ ring, we can submit and reap IOs without doing a single system
call. The kernel side thread will poll for new submissions, and in case
of HIPRI/polled IO, it'll also poll for completions.

Proof of concept. If the thread has been idle for 1 second, it will set
sq_ring->flags |= IORING_SQ_NEED_WAKEUP. The application will have to
call io_uring_enter() to start things back up again. If IO is kept busy,
that will never be needed. Basically an application that has this
feature enabled will guard it's io_uring_enter(2) call with:

read_barrier();
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
 fs/io_uring.c                 | 219 +++++++++++++++++++++++++++++++++-
 include/uapi/linux/io_uring.h |  10 +-
 2 files changed, 222 insertions(+), 7 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 86add82e1008..2deda7b1b3dd 100644
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
@@ -87,8 +88,10 @@ struct io_ring_ctx {
 
 	/* IO offload */
 	struct workqueue_struct	*sqo_wq;
+	struct task_struct	*sqo_thread;	/* if using sq thread polling */
 	struct mm_struct	*sqo_mm;
 	struct files_struct	*sqo_files;
+	wait_queue_head_t	sqo_wait;
 
 	struct {
 		/* CQ ring */
@@ -264,6 +267,9 @@ static void __io_cqring_add_event(struct io_ring_ctx *ctx, u64 ki_user_data,
 
 	if (waitqueue_active(&ctx->wait))
 		wake_up(&ctx->wait);
+	if ((ctx->flags & IORING_SETUP_SQPOLL) &&
+	    waitqueue_active(&ctx->sqo_wait))
+		wake_up(&ctx->sqo_wait);
 }
 
 static void io_cqring_add_event(struct io_ring_ctx *ctx, u64 ki_user_data,
@@ -1106,6 +1112,168 @@ static bool io_get_sqring(struct io_ring_ctx *ctx, struct sqe_submit *s)
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
+	old_files = current->files;
+	current->files = ctx->sqo_files;
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
+			unsigned int nr_events = 0;
+
+			/*
+			 * Normal IO, just pretend everything completed.
+			 * We don't have to poll completions for that.
+			 */
+			if (ctx->flags & IORING_SETUP_IOPOLL) {
+				/*
+				 * App should not use IORING_ENTER_GETEVENTS
+				 * with thread polling, but if it does, then
+				 * ensure we are mutually exclusive.
+				 */
+				if (mutex_trylock(&ctx->uring_lock)) {
+					io_iopoll_check(ctx, &nr_events, 0);
+					mutex_unlock(&ctx->uring_lock);
+				}
+			} else {
+				nr_events = inflight;
+			}
+
+			inflight -= nr_events;
+			if (!inflight)
+				timeout = jiffies + HZ;
+		}
+
+		if (!io_get_sqring(ctx, &sqes[0])) {
+			/*
+			 * We're polling, let us spin for a second without
+			 * work before going to sleep.
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
+	current->files = old_files;
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
@@ -1179,9 +1347,14 @@ static int __io_uring_enter(struct io_ring_ctx *ctx, unsigned to_submit,
 	int ret = 0;
 
 	if (to_submit) {
-		ret = io_ring_submit(ctx, to_submit);
-		if (ret < 0)
-			return ret;
+		if (ctx->flags & IORING_SETUP_SQPOLL) {
+			wake_up(&ctx->sqo_wait);
+			ret = to_submit;
+		} else {
+			ret = io_ring_submit(ctx, to_submit);
+			if (ret < 0)
+				return ret;
+		}
 	}
 	if (flags & IORING_ENTER_GETEVENTS) {
 		unsigned nr_events = 0;
@@ -1254,10 +1427,12 @@ static int io_sqe_files_register(struct io_ring_ctx *ctx, void __user *arg,
 	return ret;
 }
 
-static int io_sq_offload_start(struct io_ring_ctx *ctx)
+static int io_sq_offload_start(struct io_ring_ctx *ctx,
+			       struct io_uring_params *p)
 {
 	int ret;
 
+	init_waitqueue_head(&ctx->sqo_wait);
 	ctx->sqo_mm = current->mm;
 
 	/*
@@ -1270,6 +1445,27 @@ static int io_sq_offload_start(struct io_ring_ctx *ctx)
 	if (!ctx->sqo_files)
 		goto err;
 
+	if (ctx->flags & IORING_SETUP_SQPOLL) {
+		if (p->flags & IORING_SETUP_SQ_AFF) {
+			ctx->sqo_thread = kthread_create_on_cpu(io_sq_thread,
+							ctx, p->sq_thread_cpu,
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
@@ -1280,6 +1476,11 @@ static int io_sq_offload_start(struct io_ring_ctx *ctx)
 
 	return 0;
 err:
+	if (ctx->sqo_thread) {
+		kthread_park(ctx->sqo_thread);
+		kthread_stop(ctx->sqo_thread);
+		ctx->sqo_thread = NULL;
+	}
 	if (ctx->sqo_files)
 		ctx->sqo_files = NULL;
 	ctx->sqo_mm = NULL;
@@ -1288,6 +1489,11 @@ static int io_sq_offload_start(struct io_ring_ctx *ctx)
 
 static void io_sq_offload_stop(struct io_ring_ctx *ctx)
 {
+	if (ctx->sqo_thread) {
+		kthread_park(ctx->sqo_thread);
+		kthread_stop(ctx->sqo_thread);
+		ctx->sqo_thread = NULL;
+	}
 	if (ctx->sqo_wq) {
 		destroy_workqueue(ctx->sqo_wq);
 		ctx->sqo_wq = NULL;
@@ -1780,7 +1986,7 @@ static int io_uring_create(unsigned entries, struct io_uring_params *p,
 	if (ret)
 		goto err;
 
-	ret = io_sq_offload_start(ctx);
+	ret = io_sq_offload_start(ctx, p);
 	if (ret)
 		goto err;
 
@@ -1815,7 +2021,8 @@ static long io_uring_setup(u32 entries, struct io_uring_params __user *params,
 			return -EINVAL;
 	}
 
-	if (p.flags & ~IORING_SETUP_IOPOLL)
+	if (p.flags & ~(IORING_SETUP_IOPOLL | IORING_SETUP_SQPOLL |
+			IORING_SETUP_SQ_AFF))
 		return -EINVAL;
 
 	ret = io_uring_create(entries, &p, compat);
diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index 8323320077ec..37c7402be9ca 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -44,6 +44,8 @@ struct io_uring_sqe {
  * io_uring_setup() flags
  */
 #define IORING_SETUP_IOPOLL	(1 << 0)	/* io_context is polled */
+#define IORING_SETUP_SQPOLL	(1 << 1)	/* SQ poll thread */
+#define IORING_SETUP_SQ_AFF	(1 << 2)	/* sq_thread_cpu is valid */
 
 #define IORING_OP_NOP		0
 #define IORING_OP_READV		1
@@ -87,6 +89,11 @@ struct io_sqring_offsets {
 	__u32 resv[3];
 };
 
+/*
+ * sq_ring->flags
+ */
+#define IORING_SQ_NEED_WAKEUP	(1 << 0) /* needs io_uring_enter wakeup */
+
 struct io_cqring_offsets {
 	__u32 head;
 	__u32 tail;
@@ -109,7 +116,8 @@ struct io_uring_params {
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

