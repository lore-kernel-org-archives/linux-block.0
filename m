Return-Path: <SRS0=Do5T=QQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D16B4C282C4
	for <linux-block@archiver.kernel.org>; Sat,  9 Feb 2019 21:14:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B87821939
	for <linux-block@archiver.kernel.org>; Sat,  9 Feb 2019 21:14:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="CkrSwDMy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbfBIVOX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 9 Feb 2019 16:14:23 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34532 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727123AbfBIVOW (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 9 Feb 2019 16:14:22 -0500
Received: by mail-pl1-f194.google.com with SMTP id w4so3376358plz.1
        for <linux-block@vger.kernel.org>; Sat, 09 Feb 2019 13:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VDBdZjz/8YzKelrXZFLMYhJG39cmeuAQ4nBA3uUW4+k=;
        b=CkrSwDMyR1nwApqBIx6O3OcrlBqmEOoQuW/Cx5HBrv9D972WDhxumpYb0GngLF4YPh
         8QjOAfWnzaKAzl7/jnBWxUrSD4q3hN0E1fQWURqR4rsOTnsgHgvEtT48drBFovsE49ht
         j1vzuyYlFMAzJ1mRWVU6+FG97nx7bNpRcmNVrsHJfQOA0soe/Om2rJ0zGwPM4Vmw4JLx
         oRxIEj0xkc5AXFdPEHc4MEsQ/sFFLGPCFB85fEEKKGhrr+xRodmyoYxs1E+OW8WUZBFb
         v7rqNdpCNWRIvgA9viu5hmosjIXu/gH2Ywf98PbCNSE19r86qkNQls79E/lsfERXtAy8
         hKMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VDBdZjz/8YzKelrXZFLMYhJG39cmeuAQ4nBA3uUW4+k=;
        b=TOSida9ShyNu2LG4KhqCofcdo6RXLePIkxgIpUhii3Z6XC+LZyQzj7iXjlIrTA9P2s
         Ia0IRK4W25y4dC/hUfv5yk/S4mCXF2WOwpTyL/SIognzVL1LuhPTNHcOXJzh6Hl48B4m
         qQ/xOq2xLxcRB72E9g6Dv/zGvLjZUtT97WLOS+Kb3rP4zdRivodukAZHxddCZfekWiWu
         6mNy+X/vBwFE4Qqfqp+zzYIYXai02x5+8/HiX0bly+DLD/3U1TY+y4XoOe+b8Yvku5Xi
         h9yrCduYqX9GK9tkgnyLGYH60krEEwcm3ohqHfqPIoyC0MK0NSPweJB1H9CqbOflWa4Y
         //mQ==
X-Gm-Message-State: AHQUAubKMmzZZQPWIHY6CjzW1IL4L3feCAB4w4KsaSVP9A9JpTJj2aN6
        LuW5apaOGIsHxySgW6IKV1wLBMCQHZxD4w==
X-Google-Smtp-Source: AHgI3IZ8/8R7kQhR82ksnwqcLjpvaxe2vjkx4ddtIJx8sNBs7kIMtzcuxJTLMnZMAjiJ+6z9DhweiQ==
X-Received: by 2002:a17:902:887:: with SMTP id 7mr29793617pll.164.1549746861754;
        Sat, 09 Feb 2019 13:14:21 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id a17sm7004942pgm.26.2019.02.09.13.14.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Feb 2019 13:14:20 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        linux-api@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com, jannh@google.com,
        viro@ZenIV.linux.org.uk, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 15/19] io_uring: add submission polling
Date:   Sat,  9 Feb 2019 14:13:42 -0700
Message-Id: <20190209211346.26060-16-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190209211346.26060-1-axboe@kernel.dk>
References: <20190209211346.26060-1-axboe@kernel.dk>
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

It's mandatory to use fixed files with this feature. Failure to do so
will result in the application getting an -EBADF CQ entry when
submitting IO.

Reviewed-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io_uring.c                 | 249 +++++++++++++++++++++++++++++++++-
 include/uapi/linux/io_uring.h |  12 +-
 2 files changed, 253 insertions(+), 8 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index c40a7ed2edd5..cd7ff2643292 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -24,6 +24,7 @@
 #include <linux/percpu.h>
 #include <linux/slab.h>
 #include <linux/workqueue.h>
+#include <linux/kthread.h>
 #include <linux/blkdev.h>
 #include <linux/bvec.h>
 #include <linux/net.h>
@@ -88,12 +89,16 @@ struct io_ring_ctx {
 		unsigned		cached_sq_head;
 		unsigned		sq_entries;
 		unsigned		sq_mask;
+		unsigned		sq_thread_idle;
 		struct io_uring_sqe	*sq_sqes;
 	} ____cacheline_aligned_in_smp;
 
 	/* IO offload */
 	struct workqueue_struct	*sqo_wq;
+	struct task_struct	*sqo_thread;	/* if using sq thread polling */
 	struct mm_struct	*sqo_mm;
+	wait_queue_head_t	sqo_wait;
+	unsigned		sqo_stop;
 
 	struct {
 		/* CQ ring */
@@ -148,6 +153,7 @@ struct sqe_submit {
 	unsigned short			index;
 	bool				has_user;
 	bool				needs_lock;
+	bool				needs_fixed_file;
 };
 
 struct io_kiocb {
@@ -303,6 +309,8 @@ static void io_cqring_add_event(struct io_ring_ctx *ctx, u64 ki_user_data,
 
 	if (waitqueue_active(&ctx->wait))
 		wake_up(&ctx->wait);
+	if (waitqueue_active(&ctx->sqo_wait))
+		wake_up(&ctx->sqo_wait);
 }
 
 static void io_ring_drop_ctx_refs(struct io_ring_ctx *ctx, unsigned refs)
@@ -656,9 +664,10 @@ static bool io_file_supports_async(struct file *file)
 	return false;
 }
 
-static int io_prep_rw(struct io_kiocb *req, const struct io_uring_sqe *sqe,
+static int io_prep_rw(struct io_kiocb *req, const struct sqe_submit *s,
 		      bool force_nonblock, struct io_submit_state *state)
 {
+	const struct io_uring_sqe *sqe = s->sqe;
 	struct io_ring_ctx *ctx = req->ctx;
 	struct kiocb *kiocb = &req->rw;
 	unsigned ioprio, flags;
@@ -678,6 +687,8 @@ static int io_prep_rw(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 		kiocb->ki_filp = ctx->user_files[fd];
 		req->flags |= REQ_F_FIXED_FILE;
 	} else {
+		if (s->needs_fixed_file)
+			return -EBADF;
 		kiocb->ki_filp = io_file_get(state, fd);
 		if (unlikely(!kiocb->ki_filp))
 			return -EBADF;
@@ -839,7 +850,7 @@ static ssize_t io_read(struct io_kiocb *req, const struct sqe_submit *s,
 	struct file *file;
 	ssize_t ret;
 
-	ret = io_prep_rw(req, s->sqe, force_nonblock, state);
+	ret = io_prep_rw(req, s, force_nonblock, state);
 	if (ret)
 		return ret;
 	file = kiocb->ki_filp;
@@ -883,7 +894,7 @@ static ssize_t io_write(struct io_kiocb *req, const struct sqe_submit *s,
 	struct file *file;
 	ssize_t ret;
 
-	ret = io_prep_rw(req, s->sqe, force_nonblock, state);
+	ret = io_prep_rw(req, s, force_nonblock, state);
 	if (ret)
 		return ret;
 	/* Hold on to the file for -EAGAIN */
@@ -1102,6 +1113,7 @@ static void io_sq_wq_submit_work(struct work_struct *work)
 	user_data = READ_ONCE(s->sqe->user_data);
 	s->needs_lock = true;
 	s->has_user = false;
+	s->needs_fixed_file = false;
 
 	/*
 	 * If we're doing IO to fixed buffers, we don't need to get/set
@@ -1256,6 +1268,170 @@ static bool io_get_sqring(struct io_ring_ctx *ctx, struct sqe_submit *s)
 	return false;
 }
 
+static int io_submit_sqes(struct io_ring_ctx *ctx, struct sqe_submit *sqes,
+			  unsigned int nr, bool has_user, bool mm_fault)
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
+		if (unlikely(mm_fault)) {
+			ret = -EFAULT;
+		} else {
+			sqes[i].has_user = has_user;
+			sqes[i].needs_lock = true;
+			sqes[i].needs_fixed_file = true;
+			ret = io_submit_sqe(ctx, &sqes[i], statep);
+		}
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
+	mm_segment_t old_fs;
+	DEFINE_WAIT(wait);
+	unsigned inflight;
+	unsigned long timeout;
+
+	old_fs = get_fs();
+	set_fs(USER_DS);
+
+	timeout = inflight = 0;
+	while (!kthread_should_stop() && !ctx->sqo_stop) {
+		bool all_fixed, mm_fault = false;
+		int i;
+
+		if (inflight) {
+			unsigned nr_events = 0;
+
+			if (ctx->flags & IORING_SETUP_IOPOLL) {
+				/*
+				 * We disallow the app entering submit/complete
+				 * with polling, but we still need to lock the
+				 * ring to prevent racing with polled issue
+				 * that got punted to a workqueue.
+				 */
+				mutex_lock(&ctx->uring_lock);
+				io_iopoll_check(ctx, &nr_events, 0);
+				mutex_unlock(&ctx->uring_lock);
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
+		inflight += io_submit_sqes(ctx, sqes, i, cur_mm != NULL,
+						mm_fault);
+	}
+
+	io_iopoll_reap_events(ctx);
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
@@ -1274,6 +1450,7 @@ static int io_ring_submit(struct io_ring_ctx *ctx, unsigned int to_submit)
 
 		s.has_user = true;
 		s.needs_lock = false;
+		s.needs_fixed_file = false;
 
 		ret = io_submit_sqe(ctx, &s, statep);
 		if (ret) {
@@ -1486,13 +1663,47 @@ static int io_sqe_files_register(struct io_ring_ctx *ctx, void __user *arg,
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
@@ -1503,6 +1714,12 @@ static int io_sq_offload_start(struct io_ring_ctx *ctx)
 
 	return 0;
 err:
+	if (ctx->sqo_thread) {
+		ctx->sqo_stop = 1;
+		mb();
+		kthread_stop(ctx->sqo_thread);
+		ctx->sqo_thread = NULL;
+	}
 	mmdrop(ctx->sqo_mm);
 	ctx->sqo_mm = NULL;
 	return ret;
@@ -1750,6 +1967,11 @@ static int io_sqe_buffer_register(struct io_ring_ctx *ctx, void __user *arg,
 
 static void io_ring_ctx_free(struct io_ring_ctx *ctx)
 {
+	if (ctx->sqo_thread) {
+		ctx->sqo_stop = 1;
+		mb();
+		kthread_stop(ctx->sqo_thread);
+	}
 	if (ctx->sqo_wq)
 		destroy_workqueue(ctx->sqo_wq);
 	if (ctx->sqo_mm)
@@ -1858,7 +2080,7 @@ SYSCALL_DEFINE6(io_uring_enter, unsigned int, fd, u32, to_submit,
 	int submitted = 0;
 	struct fd f;
 
-	if (flags & ~IORING_ENTER_GETEVENTS)
+	if (flags & ~(IORING_ENTER_GETEVENTS | IORING_ENTER_SQ_WAKEUP))
 		return -EINVAL;
 
 	f = fdget(fd);
@@ -1874,6 +2096,18 @@ SYSCALL_DEFINE6(io_uring_enter, unsigned int, fd, u32, to_submit,
 	if (!percpu_ref_tryget(&ctx->refs))
 		goto out_fput;
 
+	/*
+	 * For SQ polling, the thread will do all submissions and completions.
+	 * Just return the requested submit count, and wake the thread if
+	 * we were asked to.
+	 */
+	if (ctx->flags & IORING_SETUP_SQPOLL) {
+		if (flags & IORING_ENTER_SQ_WAKEUP)
+			wake_up(&ctx->sqo_wait);
+		submitted = to_submit;
+		goto out_ctx;
+	}
+
 	if (to_submit) {
 		to_submit = min(to_submit, ctx->sq_entries);
 
@@ -2045,7 +2279,7 @@ static int io_uring_create(unsigned entries, struct io_uring_params *p)
 	if (ret)
 		goto err;
 
-	ret = io_sq_offload_start(ctx);
+	ret = io_sq_offload_start(ctx, p);
 	if (ret)
 		goto err;
 
@@ -2093,7 +2327,8 @@ static long io_uring_setup(u32 entries, struct io_uring_params __user *params)
 			return -EINVAL;
 	}
 
-	if (p.flags & ~IORING_SETUP_IOPOLL)
+	if (p.flags & ~(IORING_SETUP_IOPOLL | IORING_SETUP_SQPOLL |
+			IORING_SETUP_SQ_AFF))
 		return -EINVAL;
 
 	ret = io_uring_create(entries, &p);
diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index 6257478d55e9..0ec74bab8dbe 100644
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
@@ -86,6 +88,11 @@ struct io_sqring_offsets {
 	__u64 resv2;
 };
 
+/*
+ * sq_ring->flags
+ */
+#define IORING_SQ_NEED_WAKEUP	(1U << 0) /* needs io_uring_enter wakeup */
+
 struct io_cqring_offsets {
 	__u32 head;
 	__u32 tail;
@@ -100,6 +107,7 @@ struct io_cqring_offsets {
  * io_uring_enter(2) flags
  */
 #define IORING_ENTER_GETEVENTS	(1U << 0)
+#define IORING_ENTER_SQ_WAKEUP	(1U << 1)
 
 /*
  * Passed in for io_uring_setup(2). Copied back with updated info on success
@@ -108,7 +116,9 @@ struct io_uring_params {
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

