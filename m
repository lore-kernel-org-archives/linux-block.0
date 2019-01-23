Return-Path: <SRS0=btbQ=P7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D855EC282C6
	for <linux-block@archiver.kernel.org>; Wed, 23 Jan 2019 15:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DF562184C
	for <linux-block@archiver.kernel.org>; Wed, 23 Jan 2019 15:35:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="luW5tSvW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726213AbfAWPf6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Jan 2019 10:35:58 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40509 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbfAWPf6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Jan 2019 10:35:58 -0500
Received: by mail-pl1-f194.google.com with SMTP id u18so1348359plq.7
        for <linux-block@vger.kernel.org>; Wed, 23 Jan 2019 07:35:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eod5zCEzPPNEGa+h06A/Kgb+INA8Fvoj0A2jR7aXqU0=;
        b=luW5tSvWNVOGYtyc9+gYcNe9dUw89iov8S4sNCtwtafREW/4ZUtaJ/aLZXUGy+7OGy
         fe7aP8x8h22T2+xuK9jMsC0iUTm8TkEQrv+lyiHKwe8/RiHtDMoMyuLYPv3wCn+3FWCY
         LZSngSFnn2WuB+3R3xVJQ4micNrlnpYr6/QWsonDHPHEcl8Llg3DskvtrVSEgljFOy55
         Tx3Ba0iGtjRDtz5GNUInILR7fyHZQZfgoyqzbBX4S8excEj15jAk4SFLT7LFWq4/DNbH
         HXaM+VLrI/R2Kf3uPmv9EjRNC1XkgIxrH7IPF4XDmInqt9t+2BLpSfoSTAUkgf0ZkEve
         OlaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eod5zCEzPPNEGa+h06A/Kgb+INA8Fvoj0A2jR7aXqU0=;
        b=LJ8loM+6+Jvu4gVmj1k1ZQwIzEilpYiW4w8+XBj8CHUgO9DB0gXP2MeZES/LqCGK5q
         QGLxbXnqgLF7575drQDvXMMFZf4ifUATHeJFYSQYwa7qt2uCJg3e046Fwjd/cMoqCLf9
         kK3g1nS69DgwhUUAgGxhBPvN38/S1YBkPvl1GzeQA316iUtVDcNAwqZKUr2GrqsGXc+r
         VuXuhSONNGxiHw3W6toh4ZUYtpFipZoj1YIwmLcleP++cxOpHaIQxVnWIej2LY3Gyji6
         ukRA+QdS31vr79gp6gVpFSsocx5MOKZGRqTEaX34XLTPxH5wCeIQvI2puX1FPeQvs2/W
         nIzQ==
X-Gm-Message-State: AJcUukcP8vsGJR4N8faotzw7hrZ+FkZwlwfbUnoyMYQPUZLJIE9ts5E+
        KFIWYe4TQ5MzbZivM9uO3DELnw==
X-Google-Smtp-Source: ALg8bN6cIfE0smDAxCkYKyfX3KGj6ZKRhnQbLfqzqbVNsabRAxPRKDdbOHIhhFtcKee5QQRs94qT7Q==
X-Received: by 2002:a17:902:4a0c:: with SMTP id w12mr2671482pld.8.1548257757559;
        Wed, 23 Jan 2019 07:35:57 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id u8sm30731715pfl.16.2019.01.23.07.35.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jan 2019 07:35:56 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 07/18] io_uring: support for IO polling
Date:   Wed, 23 Jan 2019 08:35:19 -0700
Message-Id: <20190123153536.7081-9-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190123153536.7081-1-axboe@kernel.dk>
References: <20190123153536.7081-1-axboe@kernel.dk>
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
 fs/io_uring.c                 | 263 ++++++++++++++++++++++++++++++++--
 include/uapi/linux/io_uring.h |   5 +
 2 files changed, 257 insertions(+), 11 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 35d25b49ad94..f17c2dc73e40 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -101,6 +101,8 @@ struct io_ring_ctx {
 
 	struct {
 		spinlock_t		completion_lock;
+		unsigned		poll_multi_file;
+		struct list_head	poll_list;
 	} ____cacheline_aligned_in_smp;
 };
 
@@ -119,12 +121,16 @@ struct io_kiocb {
 	struct list_head	list;
 	unsigned int		flags;
 #define REQ_F_FORCE_NONBLOCK	1	/* inline submission attempt */
+#define REQ_F_IOPOLL_COMPLETED	2	/* polled IO has completed */
+#define REQ_F_IOPOLL_EAGAIN	4	/* submission got EAGAIN */
 	u64			user_data;
+	u64			res;
 
 	struct work_struct	work;
 };
 
 #define IO_PLUG_THRESHOLD		2
+#define IO_IOPOLL_BATCH			8
 
 static struct kmem_cache *req_cachep;
 
@@ -156,6 +162,7 @@ static struct io_ring_ctx *io_ring_ctx_alloc(struct io_uring_params *p)
 	mutex_init(&ctx->uring_lock);
 	init_waitqueue_head(&ctx->wait);
 	spin_lock_init(&ctx->completion_lock);
+	INIT_LIST_HEAD(&ctx->poll_list);
 	return ctx;
 }
 
@@ -191,8 +198,8 @@ static struct io_uring_cqe *io_get_cqring(struct io_ring_ctx *ctx)
 	return &ring->cqes[tail & ctx->cq_mask];
 }
 
-static void __io_cqring_add_event(struct io_ring_ctx *ctx, u64 ki_user_data,
-				  long res, unsigned ev_flags)
+static void io_cqring_fill_event(struct io_ring_ctx *ctx, u64 ki_user_data,
+				 long res, unsigned ev_flags)
 {
 	struct io_uring_cqe *cqe;
 
@@ -206,9 +213,15 @@ static void __io_cqring_add_event(struct io_ring_ctx *ctx, u64 ki_user_data,
 		cqe->user_data = ki_user_data;
 		cqe->res = res;
 		cqe->flags = ev_flags;
-		io_commit_cqring(ctx);
 	} else
 		ctx->cq_ring->overflow++;
+}
+
+static void __io_cqring_add_event(struct io_ring_ctx *ctx, u64 ki_user_data,
+				  long res, unsigned ev_flags)
+{
+	io_cqring_fill_event(ctx, ki_user_data, res, ev_flags);
+	io_commit_cqring(ctx);
 
 	if (waitqueue_active(&ctx->wait))
 		wake_up(&ctx->wait);
@@ -250,12 +263,158 @@ static struct io_kiocb *io_get_req(struct io_ring_ctx *ctx)
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
+		io_cqring_fill_event(ctx, req->user_data, req->res, 0);
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
+	if (to_free)
+		io_free_req_many(ctx, reqs, &to_free);
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
+	spin = !ctx->poll_multi_file && (*nr_events < min);
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
+	int ret;
+
+	do {
+		if (list_empty(&ctx->poll_list))
+			return 0;
+
+		ret = io_do_iopoll(ctx, nr_events, min);
+		if (ret < 0)
+			break;
+	} while (min && *nr_events < min);
+
+	if (ret < 0)
+		return ret;
+
+	return *nr_events < min;
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
+	while (!*nr_events || !need_resched()) {
+		int tmin = 0;
+
+		if (*nr_events < min)
+			tmin = min - *nr_events;
+
+		ret = io_iopoll_getevents(ctx, nr_events, tmin);
+		if (ret <= 0)
+			break;
+		ret = 0;
+	}
+
+	return ret;
+}
+
 static void kiocb_end_write(struct kiocb *kiocb)
 {
 	if (kiocb->ki_flags & IOCB_WRITE) {
@@ -282,9 +441,60 @@ static void io_complete_rw(struct kiocb *kiocb, long res, long res2)
 	io_free_req(req);
 }
 
+static void io_complete_rw_iopoll(struct kiocb *kiocb, long res, long res2)
+{
+	struct io_kiocb *req = container_of(kiocb, struct io_kiocb, rw);
+
+	kiocb_end_write(kiocb);
+
+	if (unlikely(res == -EAGAIN)) {
+		req->flags |= REQ_F_IOPOLL_EAGAIN;
+	} else {
+		req->flags |= REQ_F_IOPOLL_COMPLETED;
+		req->res = res;
+	}
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
+		ctx->poll_multi_file = 0;
+	} else if (!ctx->poll_multi_file) {
+		struct io_kiocb *list_req;
+
+		list_req = list_first_entry(&ctx->poll_list, struct io_kiocb,
+						list);
+		if (list_req->rw.ki_filp != req->rw.ki_filp)
+			ctx->poll_multi_file = 1;
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
 	int ret;
 
@@ -310,12 +520,21 @@ static int io_prep_rw(struct io_kiocb *req, const struct io_uring_sqe *sqe,
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
@@ -462,6 +681,9 @@ static int io_nop(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 {
 	struct io_ring_ctx *ctx = req->ctx;
 
+	if (unlikely(ctx->flags & IORING_SETUP_IOPOLL))
+		return -EINVAL;
+
 	__io_cqring_add_event(ctx, sqe->user_data, 0, 0);
 	io_free_req(req);
 	return 0;
@@ -479,6 +701,8 @@ static int io_fsync(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 	if (force_nonblock)
 		return -EAGAIN;
 
+	if (unlikely(req->ctx->flags & IORING_SETUP_IOPOLL))
+		return -EINVAL;
 	if (unlikely(sqe->addr || sqe->ioprio))
 		return -EINVAL;
 	if (unlikely(sqe->fsync_flags & ~IORING_FSYNC_DATASYNC))
@@ -526,7 +750,16 @@ static int __io_submit_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
 		break;
 	}
 
-	return ret;
+	if (ret)
+		return ret;
+
+	if (ctx->flags & IORING_SETUP_IOPOLL) {
+		if (req->flags & REQ_F_IOPOLL_EAGAIN)
+			return -EAGAIN;
+		io_iopoll_req_issued(req);
+	}
+
+	return 0;
 }
 
 static void io_sq_wq_submit_work(struct work_struct *work)
@@ -712,12 +945,18 @@ static int __io_uring_enter(struct io_ring_ctx *ctx, unsigned to_submit,
 			return ret;
 	}
 	if (flags & IORING_ENTER_GETEVENTS) {
+		unsigned nr_events = 0;
 		int get_ret;
 
 		if (!ret && to_submit)
 			min_complete = 0;
 
-		get_ret = io_cqring_wait(ctx, min_complete);
+		if (ctx->flags & IORING_SETUP_IOPOLL)
+			get_ret = io_iopoll_check(ctx, &nr_events,
+							min_complete);
+		else
+			get_ret = io_cqring_wait(ctx, min_complete);
+
 		if (get_ret < 0 && !ret)
 			ret = get_ret;
 	}
@@ -826,6 +1065,7 @@ static void io_free_scq_urings(struct io_ring_ctx *ctx)
 static void io_ring_ctx_free(struct io_ring_ctx *ctx)
 {
 	io_sq_offload_stop(ctx);
+	io_iopoll_reap_events(ctx);
 	io_free_scq_urings(ctx);
 	percpu_ref_exit(&ctx->refs);
 	io_unaccount_mem(ctx, ring_pages(ctx->sq_entries, ctx->cq_entries));
@@ -860,6 +1100,7 @@ static void io_ring_ctx_wait_and_kill(struct io_ring_ctx *ctx)
 	percpu_ref_kill(&ctx->refs);
 	mutex_unlock(&ctx->uring_lock);
 
+	io_iopoll_reap_events(ctx);
 	wait_for_completion(&ctx->ctx_done);
 	io_ring_ctx_free(ctx);
 }
@@ -1090,7 +1331,7 @@ static long io_uring_setup(u32 entries, struct io_uring_params __user *params,
 			return -EINVAL;
 	}
 
-	if (p.flags)
+	if (p.flags & ~IORING_SETUP_IOPOLL)
 		return -EINVAL;
 
 	ret = io_uring_create(entries, &p, compat);
diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index ca503ded73e3..4fc5fbd07688 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -32,6 +32,11 @@ struct io_uring_sqe {
 	__u64	__pad2[3];
 };
 
+/*
+ * io_uring_setup() flags
+ */
+#define IORING_SETUP_IOPOLL	(1 << 0)	/* io_context is polled */
+
 #define IORING_OP_NOP		0
 #define IORING_OP_READV		1
 #define IORING_OP_WRITEV	2
-- 
2.17.1

