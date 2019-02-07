Return-Path: <SRS0=wMCK=QO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF9FFC282C2
	for <linux-block@archiver.kernel.org>; Thu,  7 Feb 2019 19:56:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 730132173B
	for <linux-block@archiver.kernel.org>; Thu,  7 Feb 2019 19:56:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="0uNM9OPe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbfBGT4N (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 Feb 2019 14:56:13 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:51609 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727306AbfBGT4N (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 7 Feb 2019 14:56:13 -0500
Received: by mail-it1-f193.google.com with SMTP id w18so2986388ite.1
        for <linux-block@vger.kernel.org>; Thu, 07 Feb 2019 11:56:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8JrQk65lhYU7TrSIPIuwZloPq7Q0wEDQpEA/8gVhMrM=;
        b=0uNM9OPerN0JfjgzuZ4dF+ZgVhiOI2jiwA+9T/Esi6nw8xigRMWgDSivcM/ere9BaG
         cubtm6NqP1AaCPgkguWmcEYOqD3+X7Vqw3jpDAVppMkZpqTGe2V3dXW/PUjeU3bhIqdg
         B/NNRZ57esvTgdcp7ZiK5oV+0lZOVxYflPnA9vLm/1IZK8YGTe4jgMaCQWNuVEuVCjRd
         +v7M6ukDFCFb39MU6e5mlrF9OZWeTwxOT020orCUD9p2z+UeNNC8nh2Oz3YoPl+p16tR
         5LnW7i+JjIcnTL7IpDRDM8YUBRIU0P4EUBOciKv+MTYFLyVXJrflMtS0C4TOCar/8YGs
         xzwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8JrQk65lhYU7TrSIPIuwZloPq7Q0wEDQpEA/8gVhMrM=;
        b=TPPhXcN1X9sStkQF3qEPJXUyPTU4SZjjXXAtsMa7GqT/+yT2gO0iq7/SGjhvLBJHUW
         /U+kOO90siDJGRgFAIW60jY9lc6uHBHExgaPBqJXweinSHXEdbxhrqTcLRG393u1uf2b
         /JK6oDL7t0UmAzhfQ/dnhcBM0ktyzlDO4vp+ibvliSnqqSzY4gMdXmJlGVykTmm2Ocj+
         PyOwJAxgixm9v7vyStO6emRjgtDfDRS9UQAsMB30BZDyl7paKbSD3Neps/wj1dQ/CJ/D
         Kk7qlgvRVcQVDx5nrNHVxpq+t/DkPy+l9TW0o6cfgk8Ou8jHeVJfgLTVA6+LvXMwlK5j
         +b5A==
X-Gm-Message-State: AHQUAuYtuEFgIWFyfzu3DCsYHdrAe2b1VRY81ogAC027epzK+kkjRzP/
        ir3EarMz/cZo+5OxeGxYC/K4qg==
X-Google-Smtp-Source: AHgI3IayyPvZD5NTY0PvsdyWfpPqhRX25ACHhzQAVJoRdP8vCA89lT3X8Tz/SCosCihVPbvGM4a6Iw==
X-Received: by 2002:a02:c605:: with SMTP id i5mr5316109jan.9.1549569372080;
        Thu, 07 Feb 2019 11:56:12 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id y26sm5092782iob.16.2019.02.07.11.56.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Feb 2019 11:56:11 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        linux-api@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com, jannh@google.com,
        viro@ZenIV.linux.org.uk, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 07/18] io_uring: support for IO polling
Date:   Thu,  7 Feb 2019 12:55:41 -0700
Message-Id: <20190207195552.22770-8-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190207195552.22770-1-axboe@kernel.dk>
References: <20190207195552.22770-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add support for a polled io_uring context. When a read or write is
submitted to a polled context, the application must poll for completions
on the CQ ring through io_uring_enter(2). Polled IO may not generate
IRQ completions, hence they need to be actively found by the application
itself.

To use polling, io_uring_setup() must be used with the
IORING_SETUP_IOPOLL flag being set. It is illegal to mix and match
polled and non-polled IO on an io_uring.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io_uring.c                 | 274 ++++++++++++++++++++++++++++++++--
 include/uapi/linux/io_uring.h |   5 +
 2 files changed, 270 insertions(+), 9 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index e92ae7abffce..5e83391dc538 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -103,6 +103,14 @@ struct io_ring_ctx {
 
 	struct {
 		spinlock_t		completion_lock;
+		bool			poll_multi_file;
+		/*
+		 * ->poll_list is protected by the ctx->uring_lock for
+		 * io_uring instances that don't use IORING_SETUP_SQPOLL.
+		 * For SQPOLL, only the single threaded io_sq_thread() will
+		 * manipulate the list, hence no extra locking is needed there.
+		 */
+		struct list_head	poll_list;
 	} ____cacheline_aligned_in_smp;
 
 #if defined(CONFIG_NET)
@@ -114,6 +122,7 @@ struct sqe_submit {
 	const struct io_uring_sqe	*sqe;
 	unsigned short			index;
 	bool				has_user;
+	bool				needs_lock;
 };
 
 struct io_kiocb {
@@ -125,12 +134,15 @@ struct io_kiocb {
 	struct list_head	list;
 	unsigned int		flags;
 #define REQ_F_FORCE_NONBLOCK	1	/* inline submission attempt */
+#define REQ_F_IOPOLL_COMPLETED	2	/* polled IO has completed */
 	u64			user_data;
+	u64			error;
 
 	struct work_struct	work;
 };
 
 #define IO_PLUG_THRESHOLD		2
+#define IO_IOPOLL_BATCH			8
 
 static struct kmem_cache *req_cachep;
 
@@ -174,6 +186,7 @@ static struct io_ring_ctx *io_ring_ctx_alloc(struct io_uring_params *p)
 	mutex_init(&ctx->uring_lock);
 	init_waitqueue_head(&ctx->wait);
 	spin_lock_init(&ctx->completion_lock);
+	INIT_LIST_HEAD(&ctx->poll_list);
 	return ctx;
 }
 
@@ -268,12 +281,153 @@ static struct io_kiocb *io_get_req(struct io_ring_ctx *ctx)
 	return NULL;
 }
 
+static void io_free_req_many(struct io_ring_ctx *ctx, void **reqs, int *nr)
+{
+	if (*nr) {
+		kmem_cache_free_bulk(req_cachep, *nr, reqs);
+		io_ring_drop_ctx_refs(ctx, *nr);
+		*nr = 0;
+	}
+}
+
 static void io_free_req(struct io_kiocb *req)
 {
 	io_ring_drop_ctx_refs(req->ctx, 1);
 	kmem_cache_free(req_cachep, req);
 }
 
+/*
+ * Find and free completed poll iocbs
+ */
+static void io_iopoll_complete(struct io_ring_ctx *ctx, unsigned int *nr_events,
+			       struct list_head *done)
+{
+	void *reqs[IO_IOPOLL_BATCH];
+	struct io_kiocb *req;
+	int to_free = 0;
+
+	while (!list_empty(done)) {
+		req = list_first_entry(done, struct io_kiocb, list);
+		list_del(&req->list);
+
+		io_cqring_fill_event(ctx, req->user_data, req->error, 0);
+
+		reqs[to_free++] = req;
+		(*nr_events)++;
+
+		fput(req->rw.ki_filp);
+		if (to_free == ARRAY_SIZE(reqs))
+			io_free_req_many(ctx, reqs, &to_free);
+	}
+	io_commit_cqring(ctx);
+
+	io_free_req_many(ctx, reqs, &to_free);
+}
+
+static int io_do_iopoll(struct io_ring_ctx *ctx, unsigned int *nr_events,
+			long min)
+{
+	struct io_kiocb *req, *tmp;
+	LIST_HEAD(done);
+	bool spin;
+	int ret;
+
+	/*
+	 * Only spin for completions if we don't have multiple devices hanging
+	 * off our complete list, and we're under the requested amount.
+	 */
+	spin = !ctx->poll_multi_file && *nr_events < min;
+
+	ret = 0;
+	list_for_each_entry_safe(req, tmp, &ctx->poll_list, list) {
+		struct kiocb *kiocb = &req->rw;
+
+		/*
+		 * Move completed entries to our local list. If we find a
+		 * request that requires polling, break out and complete
+		 * the done list first, if we have entries there.
+		 */
+		if (req->flags & REQ_F_IOPOLL_COMPLETED) {
+			list_move_tail(&req->list, &done);
+			continue;
+		}
+		if (!list_empty(&done))
+			break;
+
+		ret = kiocb->ki_filp->f_op->iopoll(kiocb, spin);
+		if (ret < 0)
+			break;
+
+		if (ret && spin)
+			spin = false;
+		ret = 0;
+	}
+
+	if (!list_empty(&done))
+		io_iopoll_complete(ctx, nr_events, &done);
+
+	return ret;
+}
+
+/*
+ * Poll for a mininum of 'min' events. Note that if min == 0 we consider that a
+ * non-spinning poll check - we'll still enter the driver poll loop, but only
+ * as a non-spinning completion check.
+ */
+static int io_iopoll_getevents(struct io_ring_ctx *ctx, unsigned int *nr_events,
+				long min)
+{
+	while (!list_empty(&ctx->poll_list)) {
+		int ret;
+
+		ret = io_do_iopoll(ctx, nr_events, min);
+		if (ret < 0)
+			return ret;
+		if (!min || *nr_events >= min)
+			return 0;
+	}
+
+	return 1;
+}
+
+/*
+ * We can't just wait for polled events to come to us, we have to actively
+ * find and complete them.
+ */
+static void io_iopoll_reap_events(struct io_ring_ctx *ctx)
+{
+	if (!(ctx->flags & IORING_SETUP_IOPOLL))
+		return;
+
+	mutex_lock(&ctx->uring_lock);
+	while (!list_empty(&ctx->poll_list)) {
+		unsigned int nr_events = 0;
+
+		io_iopoll_getevents(ctx, &nr_events, 1);
+	}
+	mutex_unlock(&ctx->uring_lock);
+}
+
+static int io_iopoll_check(struct io_ring_ctx *ctx, unsigned *nr_events,
+			   long min)
+{
+	int ret = 0;
+
+	do {
+		int tmin = 0;
+
+		if (*nr_events < min)
+			tmin = min - *nr_events;
+
+		ret = io_iopoll_getevents(ctx, nr_events, tmin);
+		if (ret <= 0)
+			break;
+		ret = 0;
+	} while (min && !*nr_events && !need_resched());
+
+	return ret;
+}
+
 static void kiocb_end_write(struct kiocb *kiocb)
 {
 	if (kiocb->ki_flags & IOCB_WRITE) {
@@ -300,6 +454,53 @@ static void io_complete_rw(struct kiocb *kiocb, long res, long res2)
 	io_free_req(req);
 }
 
+static void io_complete_rw_iopoll(struct kiocb *kiocb, long res, long res2)
+{
+	struct io_kiocb *req = container_of(kiocb, struct io_kiocb, rw);
+
+	kiocb_end_write(kiocb);
+
+	req->error = res;
+	if (res != -EAGAIN)
+		req->flags |= REQ_F_IOPOLL_COMPLETED;
+}
+
+/*
+ * After the iocb has been issued, it's safe to be found on the poll list.
+ * Adding the kiocb to the list AFTER submission ensures that we don't
+ * find it from a io_iopoll_getevents() thread before the issuer is done
+ * accessing the kiocb cookie.
+ */
+static void io_iopoll_req_issued(struct io_kiocb *req)
+{
+	struct io_ring_ctx *ctx = req->ctx;
+
+	/*
+	 * Track whether we have multiple files in our lists. This will impact
+	 * how we do polling eventually, not spinning if we're on potentially
+	 * different devices.
+	 */
+	if (list_empty(&ctx->poll_list)) {
+		ctx->poll_multi_file = false;
+	} else if (!ctx->poll_multi_file) {
+		struct io_kiocb *list_req;
+
+		list_req = list_first_entry(&ctx->poll_list, struct io_kiocb,
+						list);
+		if (list_req->rw.ki_filp != req->rw.ki_filp)
+			ctx->poll_multi_file = true;
+	}
+
+	/*
+	 * For fast devices, IO may have already completed. If it has, add
+	 * it to the front so we find it first.
+	 */
+	if (req->flags & REQ_F_IOPOLL_COMPLETED)
+		list_add(&req->list, &ctx->poll_list);
+	else
+		list_add_tail(&req->list, &ctx->poll_list);
+}
+
 /*
  * If we tracked the file through the SCM inflight mechanism, we could support
  * any file. For now, just ensure that anything potentially problematic is done
@@ -320,6 +521,7 @@ static bool io_file_supports_async(struct file *file)
 static int io_prep_rw(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 		      bool force_nonblock)
 {
+	struct io_ring_ctx *ctx = req->ctx;
 	struct kiocb *kiocb = &req->rw;
 	unsigned ioprio;
 	int fd, ret;
@@ -355,12 +557,22 @@ static int io_prep_rw(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 		kiocb->ki_flags |= IOCB_NOWAIT;
 		req->flags |= REQ_F_FORCE_NONBLOCK;
 	}
-	if (kiocb->ki_flags & IOCB_HIPRI) {
-		ret = -EINVAL;
-		goto out_fput;
-	}
+	if (ctx->flags & IORING_SETUP_IOPOLL) {
+		ret = -EOPNOTSUPP;
+		if (!(kiocb->ki_flags & IOCB_DIRECT) ||
+		    !kiocb->ki_filp->f_op->iopoll)
+			goto out_fput;
 
-	kiocb->ki_complete = io_complete_rw;
+		req->error = 0;
+		kiocb->ki_flags |= IOCB_HIPRI;
+		kiocb->ki_complete = io_complete_rw_iopoll;
+	} else {
+		if (kiocb->ki_flags & IOCB_HIPRI) {
+			ret = -EINVAL;
+			goto out_fput;
+		}
+		kiocb->ki_complete = io_complete_rw;
+	}
 	return 0;
 out_fput:
 	fput(kiocb->ki_filp);
@@ -513,6 +725,9 @@ static int io_nop(struct io_kiocb *req, u64 user_data)
 {
 	struct io_ring_ctx *ctx = req->ctx;
 
+	if (unlikely(ctx->flags & IORING_SETUP_IOPOLL))
+		return -EINVAL;
+
 	io_cqring_add_event(ctx, user_data, 0, 0);
 	io_free_req(req);
 	return 0;
@@ -533,6 +748,8 @@ static int io_fsync(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 	if (force_nonblock)
 		return -EAGAIN;
 
+	if (unlikely(req->ctx->flags & IORING_SETUP_IOPOLL))
+		return -EINVAL;
 	if (unlikely(sqe->addr || sqe->ioprio))
 		return -EINVAL;
 
@@ -583,7 +800,22 @@ static int __io_submit_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
 		break;
 	}
 
-	return ret;
+	if (ret)
+		return ret;
+
+	if (ctx->flags & IORING_SETUP_IOPOLL) {
+		if (req->error == -EAGAIN)
+			return -EAGAIN;
+
+		/* workqueue context doesn't hold uring_lock, grab it now */
+		if (s->needs_lock)
+			mutex_lock(&ctx->uring_lock);
+		io_iopoll_req_issued(req);
+		if (s->needs_lock)
+			mutex_unlock(&ctx->uring_lock);
+	}
+
+	return 0;
 }
 
 static void io_sq_wq_submit_work(struct work_struct *work)
@@ -607,8 +839,19 @@ static void io_sq_wq_submit_work(struct work_struct *work)
 	use_mm(ctx->sqo_mm);
 	set_fs(USER_DS);
 	s->has_user = true;
+	s->needs_lock = true;
 
-	ret = __io_submit_sqe(ctx, req, s, false);
+	do {
+		ret = __io_submit_sqe(ctx, req, s, false);
+		/*
+		 * We can get EAGAIN for polled IO even though we're forcing
+		 * a sync submission from here, since we can't wait for
+		 * request slots on the block side.
+		 */
+		if (ret != -EAGAIN)
+			break;
+		cond_resched();
+	} while (1);
 
 	set_fs(old_fs);
 	unuse_mm(ctx->sqo_mm);
@@ -723,6 +966,8 @@ static int io_ring_submit(struct io_ring_ctx *ctx, unsigned int to_submit)
 			break;
 
 		s.has_user = true;
+		s.needs_lock = false;
+
 		ret = io_submit_sqe(ctx, &s);
 		if (ret) {
 			io_drop_sqring(ctx);
@@ -876,6 +1121,8 @@ static void io_ring_ctx_free(struct io_ring_ctx *ctx)
 		sock_release(ctx->ring_sock);
 #endif
 
+	io_iopoll_reap_events(ctx);
+
 	io_mem_free(ctx->sq_ring);
 	io_mem_free(ctx->sq_sqes);
 	io_mem_free(ctx->cq_ring);
@@ -915,6 +1162,7 @@ static void io_ring_ctx_wait_and_kill(struct io_ring_ctx *ctx)
 	percpu_ref_kill(&ctx->refs);
 	mutex_unlock(&ctx->uring_lock);
 
+	io_iopoll_reap_events(ctx);
 	wait_for_completion(&ctx->ctx_done);
 	io_ring_ctx_free(ctx);
 }
@@ -995,6 +1243,8 @@ SYSCALL_DEFINE6(io_uring_enter, unsigned int, fd, u32, to_submit,
 			goto out_ctx;
 	}
 	if (flags & IORING_ENTER_GETEVENTS) {
+		unsigned nr_events = 0;
+
 		/*
 		 * The application could have included the 'to_submit' count
 		 * in how many events it wanted to wait for. If we failed to
@@ -1004,7 +1254,13 @@ SYSCALL_DEFINE6(io_uring_enter, unsigned int, fd, u32, to_submit,
 		if (submitted < to_submit)
 			min_complete = min_t(unsigned, submitted, min_complete);
 
-		ret = io_cqring_wait(ctx, min_complete, sig, sigsz);
+		if (ctx->flags & IORING_SETUP_IOPOLL) {
+			mutex_lock(&ctx->uring_lock);
+			ret = io_iopoll_check(ctx, &nr_events, min_complete);
+			mutex_unlock(&ctx->uring_lock);
+		} else {
+			ret = io_cqring_wait(ctx, min_complete, sig, sigsz);
+		}
 	}
 
 out_ctx:
@@ -1187,7 +1443,7 @@ static long io_uring_setup(u32 entries, struct io_uring_params __user *params)
 			return -EINVAL;
 	}
 
-	if (p.flags)
+	if (p.flags & ~IORING_SETUP_IOPOLL)
 		return -EINVAL;
 
 	ret = io_uring_create(entries, &p);
diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index 4589d56d0b68..5c457ea396e6 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -30,6 +30,11 @@ struct io_uring_sqe {
 	__u64	__pad2[3];
 };
 
+/*
+ * io_uring_setup() flags
+ */
+#define IORING_SETUP_IOPOLL	(1U << 0)	/* io_context is polled */
+
 #define IORING_OP_NOP		0
 #define IORING_OP_READV		1
 #define IORING_OP_WRITEV	2
-- 
2.17.1

