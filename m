Return-Path: <SRS0=gCKl=PX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBBCEC43444
	for <linux-block@archiver.kernel.org>; Tue, 15 Jan 2019 02:55:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 821412070B
	for <linux-block@archiver.kernel.org>; Tue, 15 Jan 2019 02:55:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Pat1aqq5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbfAOCzx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Jan 2019 21:55:53 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45194 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727955AbfAOCzx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Jan 2019 21:55:53 -0500
Received: by mail-pg1-f195.google.com with SMTP id y4so542403pgc.12
        for <linux-block@vger.kernel.org>; Mon, 14 Jan 2019 18:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zqZA4RydglhldAjWStsEMz1n78APxN6RdXRm1rTZKHQ=;
        b=Pat1aqq5WUj9A7yjikw1Nbaevg4WS9gXPPMOhgJqEP7c2u8L0Uq/RBsJtY8E+huDDb
         2tAkxW5LSESn2Mrsiw8Ph1BaZixJxWVIXa9zdB+SeUxvLh0ELN4UoMpjJxQIhSW5k1Li
         KvXRfjNoATjGbpPiUEjBRaoX0IunW+jp+1SpT7+K5BpDITXOEaSHa2Qv1JaMqwpDmUY5
         o3UwG7L1Vu10jcLSXVOCaB1A5yDfx0sPQT3uUQyBb61BodoV7h0uGbXUvFBq4ltZkCx0
         ItU2pOHqqMu13ncQXtPYd7utufiVoBsnaK/UoVkuvkH37JSRtsVc1p3RCcLI6sa6RbFO
         Oorg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zqZA4RydglhldAjWStsEMz1n78APxN6RdXRm1rTZKHQ=;
        b=X3c7PV0kxHs1bd4Gpqq+MbWqIOQYJTt4MUg6sqWzpCg6PusG9XRBrxVqxVBVdVEK/t
         9rIVyam4RVHCPnGpkedxrMFKGeltA0cO8SuYHxUk5NstQmE8xCJ9/NwOJjHfXLvAKZuy
         92Mc3JqSppY49pe96mM3OO+QB+o61U3BIQUF007rE9mVO3leK0C2f8OHRvkzTl4wA9Bt
         /xhIobxReIxPLBRBsnfwyr29emxxII4H6s6ibsLYQi3SR2QD4Mnw+Togduo6zmfh6+9z
         Bdwv/I0OyBlcYclhyVoNy67wPg7fknzROWAxSo+EXo9U1KDt/Yv2uwND1TF3iwcQGI5p
         xtDQ==
X-Gm-Message-State: AJcUukd19rwhylvNSsSJRHjIiCAy04DMC5WNbVaZAQx8KqU4xhh4USNv
        ErvTXJWvwPFlac+SsahNO4bisQ==
X-Google-Smtp-Source: ALg8bN42EnnwIhTt37fYszHXG7opwv2tVe3uo8ufs2GRIr8gvOotKpmwiVmlZy0DJfEjP2/TaFaDRg==
X-Received: by 2002:a63:20e:: with SMTP id 14mr1667217pgc.161.1547520951793;
        Mon, 14 Jan 2019 18:55:51 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id c23sm2415544pfi.83.2019.01.14.18.55.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Jan 2019 18:55:50 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org, linux-arch@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 07/16] io_uring: support for IO polling
Date:   Mon, 14 Jan 2019 19:55:22 -0700
Message-Id: <20190115025531.13985-8-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190115025531.13985-1-axboe@kernel.dk>
References: <20190115025531.13985-1-axboe@kernel.dk>
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
 fs/io_uring.c                 | 253 ++++++++++++++++++++++++++++++++--
 include/uapi/linux/io_uring.h |   5 +
 2 files changed, 250 insertions(+), 8 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 7d74463217a6..fb1b04ccc12a 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -56,6 +56,11 @@ struct io_cq_ring {
 	struct io_uring_cqe	cqes[];
 };
 
+struct list_multi {
+	struct list_head list;
+	unsigned multi;
+};
+
 struct io_ring_ctx {
 	struct percpu_ref	refs;
 
@@ -88,6 +93,7 @@ struct io_ring_ctx {
 
 	struct {
 		spinlock_t		completion_lock;
+		struct list_multi	poll_list;
 	} ____cacheline_aligned_in_smp;
 };
 
@@ -111,10 +117,14 @@ struct io_kiocb {
 	struct list_head	list;
 	unsigned long		flags;
 #define REQ_F_FORCE_NONBLOCK	1	/* inline submission attempt */
+#define REQ_F_IOPOLL_COMPLETED	2	/* polled IO has completed */
+#define REQ_F_IOPOLL_EAGAIN	4	/* submission got EAGAIN */
 	u64			user_data;
+	u64			res;
 };
 
 #define IO_PLUG_THRESHOLD		2
+#define IO_IOPOLL_BATCH			8
 
 static struct kmem_cache *req_cachep;
 
@@ -144,6 +154,7 @@ static struct io_ring_ctx *io_ring_ctx_alloc(struct io_uring_params *p)
 	init_completion(&ctx->ctx_done);
 	spin_lock_init(&ctx->completion_lock);
 	init_waitqueue_head(&ctx->wait);
+	INIT_LIST_HEAD(&ctx->poll_list.list);
 	mutex_init(&ctx->uring_lock);
 	return ctx;
 }
@@ -234,12 +245,180 @@ static void io_ring_drop_ctx_refs(struct io_ring_ctx *ctx, unsigned refs)
 		wake_up(&ctx->wait);
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
 	kmem_cache_free(req_cachep, req);
 	io_ring_drop_ctx_refs(req->ctx, 1);
 }
 
+/*
+ * Track whether we have multiple files in our lists. This will impact how
+ * we do polling eventually, not spinning if we're on potentially on different
+ * devices.
+ */
+static void io_multi_list_add(struct io_kiocb *req, struct list_multi *list)
+{
+	if (list_empty(&list->list)) {
+		list->multi = 0;
+	} else if (!list->multi) {
+		struct io_kiocb *list_req;
+
+		list_req = list_first_entry(&list->list, struct io_kiocb, list);
+		if (list_req->rw.ki_filp != req->rw.ki_filp)
+			list->multi = 1;
+	}
+
+	/*
+	 * For fast devices, IO may have already completed. If it has, add
+	 * it to the front so we find it first. We can't add to the poll_done
+	 * list as that's unlocked from the completion side.
+	 */
+	if (req->flags & REQ_F_IOPOLL_COMPLETED)
+		list_add(&req->list, &list->list);
+	else
+		list_add_tail(&req->list, &list->list);
+}
+
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
+		__io_cqring_fill_event(ctx, req->user_data, req->res, 0);
+
+		reqs[to_free++] = req;
+		(*nr_events)++;
+
+		fput(req->rw.ki_filp);
+		if (to_free == ARRAY_SIZE(reqs))
+			io_free_req_many(ctx, reqs, &to_free);
+	}
+
+	if (to_free)
+		io_free_req_many(ctx, reqs, &to_free);
+}
+
+static int io_do_iopoll(struct io_ring_ctx *ctx, unsigned int *nr_events,
+			long min)
+{
+	struct io_kiocb *req, *tmp;
+	int polled, found, ret;
+	LIST_HEAD(done);
+	bool spin;
+
+	/*
+	 * Only spin for completions if we don't have multiple devices hanging
+	 * off our complete list, and we're under the requested amount.
+	 */
+	spin = !ctx->poll_list.multi && (*nr_events < min);
+
+	ret = polled = found = 0;
+	list_for_each_entry_safe(req, tmp, &ctx->poll_list.list, list) {
+		struct kiocb *kiocb = &req->rw;
+
+		if (req->flags & REQ_F_IOPOLL_COMPLETED) {
+			list_move_tail(&req->list, &done);
+			spin = false;
+			continue;
+		}
+
+		ret = kiocb->ki_filp->f_op->iopoll(kiocb, spin);
+		if (ret < 0)
+			break;
+
+		polled += ret;
+		if (polled && spin)
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
+ * Poll for a mininum of 'min' events, and a maximum of 'max'. Note that if
+ * min == 0 we consider that a non-spinning poll check - we'll still enter
+ * the driver poll loop, but only as a non-spinning completion check.
+ */
+static int io_iopoll_getevents(struct io_ring_ctx *ctx, unsigned int *nr_events,
+				long min)
+{
+	int ret;
+
+	do {
+		if (list_empty(&ctx->poll_list.list))
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
+	while (!list_empty(&ctx->poll_list.list)) {
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
@@ -266,9 +445,37 @@ static void io_complete_rw(struct kiocb *kiocb, long res, long res2)
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
+ * find it from a io_getevents() thread before the issuer is done accessing
+ * the kiocb cookie.
+ */
+static void io_iopoll_req_issued(struct io_kiocb *req)
+{
+	struct io_ring_ctx *ctx = req->ctx;
+
+	io_multi_list_add(req, &ctx->poll_list);
+}
+
 static int io_prep_rw(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 		      bool force_nonblock)
 {
+	struct io_ring_ctx *ctx = req->ctx;
 	struct kiocb *kiocb = &req->rw;
 	int ret;
 
@@ -294,12 +501,21 @@ static int io_prep_rw(struct io_kiocb *req, const struct io_uring_sqe *sqe,
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
@@ -444,6 +660,9 @@ static int io_nop(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 {
 	struct io_ring_ctx *ctx = req->ctx;
 
+	if (unlikely(ctx->flags & IORING_SETUP_IOPOLL))
+		return -EINVAL;
+
 	__io_cqring_fill_event(ctx, sqe->user_data, 0, 0);
 	io_free_req(req);
 	return 0;
@@ -461,6 +680,8 @@ static int io_fsync(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 	if (force_nonblock)
 		return -EAGAIN;
 
+	if (unlikely(req->ctx->flags & IORING_SETUP_IOPOLL))
+		return -EINVAL;
 	if (unlikely(sqe->addr))
 		return -EINVAL;
 	if (unlikely(sqe->fsync_flags & ~IORING_FSYNC_DATASYNC))
@@ -512,7 +733,16 @@ static int __io_submit_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
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
@@ -682,12 +912,17 @@ static int __io_uring_enter(struct io_ring_ctx *ctx, unsigned to_submit,
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
 		if (get_ret < 0 && !ret)
 			ret = get_ret;
 	}
@@ -755,6 +990,7 @@ static void io_free_scq_urings(struct io_ring_ctx *ctx)
 static void io_ring_ctx_free(struct io_ring_ctx *ctx)
 {
 	io_sq_offload_stop(ctx);
+	io_iopoll_reap_events(ctx);
 	io_free_scq_urings(ctx);
 	percpu_ref_exit(&ctx->refs);
 	kfree(ctx);
@@ -766,6 +1002,7 @@ static void io_ring_ctx_wait_and_kill(struct io_ring_ctx *ctx)
 	percpu_ref_kill(&ctx->refs);
 	mutex_unlock(&ctx->uring_lock);
 
+	io_iopoll_reap_events(ctx);
 	wait_for_completion(&ctx->ctx_done);
 	io_ring_ctx_free(ctx);
 }
@@ -975,7 +1212,7 @@ static long io_uring_setup(u32 entries, struct io_uring_params __user *params,
 			return -EINVAL;
 	}
 
-	if (p.flags)
+	if (p.flags & ~IORING_SETUP_IOPOLL)
 		return -EINVAL;
 
 	ret = io_uring_create(entries, &p, compat);
diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index ac49bd179ed9..d31ae2f767d1 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -33,6 +33,11 @@ struct io_uring_sqe {
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

