Return-Path: <SRS0=rtTj=QG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 361F7C282D8
	for <linux-block@archiver.kernel.org>; Wed, 30 Jan 2019 23:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE16621473
	for <linux-block@archiver.kernel.org>; Wed, 30 Jan 2019 23:50:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="kKlvFLrU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbfA3Xuw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Jan 2019 18:50:52 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:54054 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbfA3Xuw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Jan 2019 18:50:52 -0500
Received: by mail-it1-f196.google.com with SMTP id g85so1141102ita.3
        for <linux-block@vger.kernel.org>; Wed, 30 Jan 2019 15:50:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pQqRexzt1nQZ1gbhvzB8JGTvoo4GskQHr/fUhKQ9/G8=;
        b=kKlvFLrUTJVsl6jQJCKxxfb0YJw6Qx7Vx2e34b8v1fR9r3pgO2a5Op0MZMtAaSFzYg
         4k9iO1QsednNJ2PV/j98P9u4GeDaUarNV4sLe0Yfqpsw4Wgef3nt7VlEZqCcUiKI1Dwo
         8ORXwUfh6Lx9uQonfkXeyP8gh/rFOubxgSi7tIBO2/75gbiZadVk57Y4y7OH4ep3g7O6
         ySWI4w9DpbbVSb0BvxNe0tT0MazgUV83JlSuQ4/EWmVlk38S2jtrM/JuowpB2ZTiF4JN
         gq8G9JwX0wwoSbsxmEsyhUYQ0VdNvNV9Iw38Jb7bT9pwKYBwbq7exay7LXi3Xe9WeqpF
         Htmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pQqRexzt1nQZ1gbhvzB8JGTvoo4GskQHr/fUhKQ9/G8=;
        b=HtsYO4kkbgIuKOBSsQPsYfZwnFuyWKPpVZfXUEONeDYdLmRcUSI9/TWky2bSTA98rV
         EZ2tSwCJWAPqaCETA3pesdt4MB6QHkBK/vt36q4ljaGxghjWsxP8I9CbGTzg8031xqk0
         GpFq8IYwUUt/ES13DBn1uo8lvYFpKn7zRdF80DhZ8GO2kthEXXYAj+MoBgS/a5VRr7xk
         RJBLBjlVpoTjnz6oiDfMta/vEX7OK5bSY3Mt3iuywk9WVIYHqS303RBqViwBsOrvFvRe
         uTV8KHvxarXhc1cQ/+GMInSIOazQPgKtP7e7OkBf/qBoJ/ZAbq1fAQ534iy6tuNtAgfu
         5FFQ==
X-Gm-Message-State: AJcUukcPP0uVnJl6yHUGnJp0d7WvlgTOnhuJsZq5rfNstMUdv2Nr6OmR
        CLMu3tiwb7XD+uetPD6VyQthb5AimQw=
X-Google-Smtp-Source: AHgI3IaYto9amhvZrvMLQd+j2K2jb45tcESrym1Vz1lqHgmn2S0YWuoDf3Fma49+lovreU3CxDGTYw==
X-Received: by 2002:a24:7596:: with SMTP id y144mr18239659itc.68.1548885356679;
        Wed, 30 Jan 2019 13:55:56 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id 189sm1805081itw.33.2019.01.30.13.55.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 13:55:55 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        linux-api@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com, jannh@google.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 07/18] io_uring: support for IO polling
Date:   Wed, 30 Jan 2019 14:55:29 -0700
Message-Id: <20190130215540.20871-8-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190130215540.20871-1-axboe@kernel.dk>
References: <20190130215540.20871-1-axboe@kernel.dk>
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
 fs/io_uring.c                 | 261 ++++++++++++++++++++++++++++++++--
 include/uapi/linux/io_uring.h |   5 +
 2 files changed, 257 insertions(+), 9 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index bcd3a7c72142..90a745c34e8b 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -102,6 +102,14 @@ struct io_ring_ctx {
 
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
 };
 
@@ -120,12 +128,15 @@ struct io_kiocb {
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
 
@@ -157,6 +168,7 @@ static struct io_ring_ctx *io_ring_ctx_alloc(struct io_uring_params *p)
 	mutex_init(&ctx->uring_lock);
 	init_waitqueue_head(&ctx->wait);
 	spin_lock_init(&ctx->completion_lock);
+	INIT_LIST_HEAD(&ctx->poll_list);
 	return ctx;
 }
 
@@ -251,12 +263,153 @@ static struct io_kiocb *io_get_req(struct io_ring_ctx *ctx)
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
+	} while (!*nr_events || !need_resched());
+
+	return ret;
+}
+
 static void kiocb_end_write(struct kiocb *kiocb)
 {
 	if (kiocb->ki_flags & IOCB_WRITE) {
@@ -283,9 +436,57 @@ static void io_complete_rw(struct kiocb *kiocb, long res, long res2)
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
 static int io_prep_rw(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 		      bool force_nonblock)
 {
+	struct io_ring_ctx *ctx = req->ctx;
 	struct kiocb *kiocb = &req->rw;
 	unsigned ioprio;
 	int fd, ret;
@@ -315,12 +516,22 @@ static int io_prep_rw(struct io_kiocb *req, const struct io_uring_sqe *sqe,
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
@@ -473,6 +684,9 @@ static int io_nop(struct io_kiocb *req, u64 user_data)
 {
 	struct io_ring_ctx *ctx = req->ctx;
 
+	if (unlikely(ctx->flags & IORING_SETUP_IOPOLL))
+		return -EINVAL;
+
 	io_cqring_add_event(ctx, user_data, 0, 0);
 	io_free_req(req);
 	return 0;
@@ -493,6 +707,8 @@ static int io_fsync(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 	if (force_nonblock)
 		return -EAGAIN;
 
+	if (unlikely(req->ctx->flags & IORING_SETUP_IOPOLL))
+		return -EINVAL;
 	if (unlikely(sqe->addr || sqe->ioprio))
 		return -EINVAL;
 
@@ -543,7 +759,16 @@ static int __io_submit_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
 		break;
 	}
 
-	return ret;
+	if (ret)
+		return ret;
+
+	if (ctx->flags & IORING_SETUP_IOPOLL) {
+		if (req->error == -EAGAIN)
+			return -EAGAIN;
+		io_iopoll_req_issued(req);
+	}
+
+	return 0;
 }
 
 static void io_sq_wq_submit_work(struct work_struct *work)
@@ -572,7 +797,17 @@ static void io_sq_wq_submit_work(struct work_struct *work)
 	use_mm(ctx->sqo_mm);
 	set_fs(USER_DS);
 
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
@@ -767,6 +1002,8 @@ static int __io_uring_enter(struct io_ring_ctx *ctx, unsigned to_submit,
 			return submitted;
 	}
 	if (flags & IORING_ENTER_GETEVENTS) {
+		unsigned nr_events = 0;
+
 		/*
 		 * The application could have included the 'to_submit' count
 		 * in how many events it wanted to wait for. If we failed to
@@ -776,7 +1013,10 @@ static int __io_uring_enter(struct io_ring_ctx *ctx, unsigned to_submit,
 		if (submitted < to_submit)
 			min_complete = min_t(unsigned, submitted, min_complete);
 
-		ret = io_cqring_wait(ctx, min_complete, sig, sigsz);
+		if (ctx->flags & IORING_SETUP_IOPOLL)
+			ret = io_iopoll_check(ctx, &nr_events, min_complete);
+		else
+			ret = io_cqring_wait(ctx, min_complete, sig, sigsz);
 	}
 
 	return submitted ? submitted : ret;
@@ -877,6 +1117,8 @@ static void io_ring_ctx_free(struct io_ring_ctx *ctx)
 	mmdrop(ctx->sqo_mm);
 	put_files_struct(ctx->sqo_files);
 
+	io_iopoll_reap_events(ctx);
+
 	io_mem_free(ctx->sq_ring);
 	io_mem_free(ctx->sq_sqes);
 	io_mem_free(ctx->cq_ring);
@@ -914,6 +1156,7 @@ static void io_ring_ctx_wait_and_kill(struct io_ring_ctx *ctx)
 	percpu_ref_kill(&ctx->refs);
 	mutex_unlock(&ctx->uring_lock);
 
+	io_iopoll_reap_events(ctx);
 	wait_for_completion(&ctx->ctx_done);
 	io_ring_ctx_free(ctx);
 }
@@ -1135,7 +1378,7 @@ static long io_uring_setup(u32 entries, struct io_uring_params __user *params)
 			return -EINVAL;
 	}
 
-	if (p.flags)
+	if (p.flags & ~IORING_SETUP_IOPOLL)
 		return -EINVAL;
 
 	ret = io_uring_create(entries, &p);
diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index 0fca46f8fc37..4952fc921866 100644
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

