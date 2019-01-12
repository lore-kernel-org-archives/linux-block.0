Return-Path: <SRS0=tPwK=PU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 507ECC43612
	for <linux-block@archiver.kernel.org>; Sat, 12 Jan 2019 21:30:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14C072084C
	for <linux-block@archiver.kernel.org>; Sat, 12 Jan 2019 21:30:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="W//oERYA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbfALVar (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 12 Jan 2019 16:30:47 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40629 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726673AbfALVar (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 12 Jan 2019 16:30:47 -0500
Received: by mail-pg1-f195.google.com with SMTP id z10so7796146pgp.7
        for <linux-block@vger.kernel.org>; Sat, 12 Jan 2019 13:30:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8vV4hdIAmsQBc8lORxnHOFoG7gVrwDswoWOOwJ1uzl8=;
        b=W//oERYASV2gKGngSjzaCFxeXtO6bzuNmTpz30DHSbOlEIEl5ZgO+fV9vbWq0ebKlX
         GHXFxixaz4FXQ50Qo6nWjylHaBPJ9LMoWonYq12Kd1qPmOqnKGr+sDczN1SM56f3QlMg
         9yvTCZtCs4G4uW/Kvu3KvKv9r/2W5Xeunc4E6hhTaa3hEPZeXAUHkuf3lRDsIr1w9n2h
         YwUbmlbIha5jT1Vn1Ow3bgll6Fu/xDR21cV30aNKnahFhOfYF/KpgmXy0DBQK2dXnVyT
         3KTLqiFlyaGuG9vk9Q/qCe4xqDbNz+9Vw3LtQVed7dHasg6poWeaIOpVrlcElwPD0G+y
         10SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8vV4hdIAmsQBc8lORxnHOFoG7gVrwDswoWOOwJ1uzl8=;
        b=KS+WGtT1dl1Q+VknkwOXvDiCKeNwNzRBsVYLcUlFAJ7+FZicelLFBrwsPQhevgJKQs
         /ur8APh5BTeO+vTO0ASkxjk4PWDrKrld5Frv9rY7Si4/Gf+vatJaG7u9/nEhbSXCvgzZ
         oUoOMFpWGi9iLaz4osXLQoraulZMXQTTl3SnK5B82vr+faCcvf/WdvB9WN1QYBcKvLTw
         QzXnFeUk/j26OimLjhbi9Eo09Fps5Gw+CpVszE+bcqk4Wo70BbrV/QZ+LCNTmHo0atVO
         AAfL+mNP/JOQPpy54m6OdqUuDuG2XZ39rRT3Sekwo8bxmQjPlUAkjV+5TdIq49TmNz7l
         n02g==
X-Gm-Message-State: AJcUukcI6JJA2B/CCwtD06mmGqZkY32b59K9GxEvqz0HgZb8gOp8Rlio
        QH3/O6SMwpgLp1krXgUeRm8muw==
X-Google-Smtp-Source: ALg8bN7sJayQSiMCKY8csJqQNzzC++YKFFchwj8Ro8cc99AGb+YY+OPyrRQQsevDXsRmUVH58kd8mg==
X-Received: by 2002:a63:2643:: with SMTP id m64mr17626724pgm.35.1547328645930;
        Sat, 12 Jan 2019 13:30:45 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id y6sm151629818pfd.104.2019.01.12.13.30.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Jan 2019 13:30:45 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org, linux-arch@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 14/16] io_uring: add submission polling
Date:   Sat, 12 Jan 2019 14:30:09 -0700
Message-Id: <20190112213011.1439-15-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190112213011.1439-1-axboe@kernel.dk>
References: <20190112213011.1439-1-axboe@kernel.dk>
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
 fs/io_uring.c                 | 215 +++++++++++++++++++++++++++++++++-
 include/uapi/linux/io_uring.h |  10 +-
 2 files changed, 218 insertions(+), 7 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 64e590175641..6f446d13b3d4 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -22,6 +22,7 @@
 #include <linux/percpu.h>
 #include <linux/slab.h>
 #include <linux/workqueue.h>
+#include <linux/kthread.h>
 #include <linux/blkdev.h>
 #include <linux/bvec.h>
 #include <linux/anon_inodes.h>
@@ -89,8 +90,10 @@ struct io_ring_ctx {
 
 	/* IO offload */
 	struct workqueue_struct	*sqo_wq;
+	struct task_struct	*sqo_thread;	/* if using sq thread polling */
 	struct mm_struct	*sqo_mm;
 	struct files_struct	*sqo_files;
+	wait_queue_head_t	sqo_wait;
 
 	/* if used, fixed mapped user buffers */
 	struct io_mapped_ubuf	*user_bufs;
@@ -1131,6 +1134,167 @@ static bool io_peek_sqring(struct io_ring_ctx *ctx, struct sqe_submit *s)
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
+		io_fill_cq_error(ctx, &sqes[i], ret);
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
+		if (!io_peek_sqring(ctx, &sqes[0])) {
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
+			if (!io_peek_sqring(ctx, &sqes[0])) {
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
+			if (sqes[i].sqe->opcode != IORING_OP_READ_FIXED &&
+			    sqes[i].sqe->opcode != IORING_OP_WRITE_FIXED)
+				all_fixed = false;
+			if (i + 1 == ARRAY_SIZE(sqes))
+				break;
+			i++;
+			io_inc_sqring(ctx);
+		} while (io_peek_sqring(ctx, &sqes[i]));
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
@@ -1202,9 +1366,14 @@ static int __io_uring_enter(struct io_ring_ctx *ctx, unsigned to_submit,
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
@@ -1225,10 +1394,12 @@ static int __io_uring_enter(struct io_ring_ctx *ctx, unsigned to_submit,
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
@@ -1242,6 +1413,27 @@ static int io_sq_offload_start(struct io_ring_ctx *ctx)
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
@@ -1252,6 +1444,11 @@ static int io_sq_offload_start(struct io_ring_ctx *ctx)
 
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
@@ -1260,6 +1457,11 @@ static int io_sq_offload_start(struct io_ring_ctx *ctx)
 
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
@@ -1594,7 +1796,7 @@ static int io_uring_create(unsigned entries, struct io_uring_params *p)
 	if (ret)
 		goto err;
 
-	ret = io_sq_offload_start(ctx);
+	ret = io_sq_offload_start(ctx, p);
 	if (ret)
 		goto err;
 
@@ -1629,7 +1831,8 @@ SYSCALL_DEFINE2(io_uring_setup, u32, entries,
 			return -EINVAL;
 	}
 
-	if (p.flags & ~IORING_SETUP_IOPOLL)
+	if (p.flags & ~(IORING_SETUP_IOPOLL | IORING_SETUP_SQPOLL |
+			IORING_SETUP_SQ_AFF))
 		return -EINVAL;
 
 	ret = io_uring_create(entries, &p);
diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index e1eeb3fc7443..7f9be0bd84ed 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -39,6 +39,8 @@ struct io_uring_sqe {
  * io_uring_setup() flags
  */
 #define IORING_SETUP_IOPOLL	(1 << 0)	/* io_context is polled */
+#define IORING_SETUP_SQPOLL	(1 << 1)	/* SQ poll thread */
+#define IORING_SETUP_SQ_AFF	(1 << 2)	/* sq_thread_cpu is valid */
 
 #define IORING_OP_READV		1
 #define IORING_OP_WRITEV	2
@@ -81,6 +83,11 @@ struct io_sqring_offsets {
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
@@ -103,7 +110,8 @@ struct io_uring_params {
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

