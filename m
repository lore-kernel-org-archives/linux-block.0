Return-Path: <SRS0=tPwK=PU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0977FC43387
	for <linux-block@archiver.kernel.org>; Sat, 12 Jan 2019 21:30:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C20152086C
	for <linux-block@archiver.kernel.org>; Sat, 12 Jan 2019 21:30:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="o0IumRvR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbfALVae (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 12 Jan 2019 16:30:34 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37782 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbfALVad (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 12 Jan 2019 16:30:33 -0500
Received: by mail-pl1-f196.google.com with SMTP id b5so8362996plr.4
        for <linux-block@vger.kernel.org>; Sat, 12 Jan 2019 13:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=suY6akPkbncRRmcEMg8/yONRomoiitvfJhvarjmZOzU=;
        b=o0IumRvRYcZupfNJA6cU4IAP1rFzhqp3rbEmHyvXute8R4XPmVjHXB95cPiBxxe+BL
         i9yGVW5qnGKUvRbP+7Co6DCLioLUllEfV51aA27YyqGKsw59h3WYpSftWFi3YBI2hv8d
         pC3ZTJ3og+AnASQBm6JWv5qA7SvC/YZd+f1paKe93MamKfrqfQikHzTt8unVUz9ceqZk
         4xENOwQ2p53Vg5R89yf0uR5evh2KkMpSv/Yp4KEdZ8FBvv9iLLvyQ1JmUIwp9Xb4LMTu
         26rF2XXBfngWsyU5cEfBicB5yishWDTCHwgGJcr9TbXYR5yewEE2aZw9BqJHCMKnmDKT
         f13A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=suY6akPkbncRRmcEMg8/yONRomoiitvfJhvarjmZOzU=;
        b=H7oPden654ZoimsmnFUfwUBnjIhkHR0DrMUAWZ56YYqkus1tIN77FzHUJd+YYPHxlr
         GxQ4gAgmFddxF/hoScd3LBah8gKQMbIhwTRvLmHVQkHBMVngoIBpk9xbRWNw7YXMIl6c
         7DcMssOeSSladChBDkLjFYYYsH5ftS3he+cbJfg2++mGXPGOvJUbPZVuWWGK/U9sKxTP
         UfCwD9/2agAm3HYx0kHsZ3KZiH2iWVi1DBbD8CE+PL07lh6pRhWqUXKazdkJAte85V1i
         eETCOMSiYVceMLfuDiauG/RS8oxRfK/5e+9zMUkSwPiNqRoiaHfLswB0g4wb8qlIHz5d
         S0ew==
X-Gm-Message-State: AJcUukeNniB4mzQdXMRGVK4+Lk9wWs55ZQ9UkPuYiwXVGbPcAQzl4E4Q
        YWNTqOk7U/9KDzRqevgXKpwa/w==
X-Google-Smtp-Source: ALg8bN73huroCOgB1SFZYcJ3fobrBnrNWa22LTnqIww41zRRpjzjUzg7SiY2/t+KoDC7aZVsvii/LQ==
X-Received: by 2002:a17:902:5a5:: with SMTP id f34mr19996393plf.161.1547328632960;
        Sat, 12 Jan 2019 13:30:32 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id y6sm151629818pfd.104.2019.01.12.13.30.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Jan 2019 13:30:32 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org, linux-arch@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 07/16] io_uring: support for IO polling
Date:   Sat, 12 Jan 2019 14:30:02 -0700
Message-Id: <20190112213011.1439-8-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190112213011.1439-1-axboe@kernel.dk>
References: <20190112213011.1439-1-axboe@kernel.dk>
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
 fs/io_uring.c                 | 306 ++++++++++++++++++++++++++++++++--
 include/uapi/linux/io_uring.h |   5 +
 2 files changed, 297 insertions(+), 14 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index c51d429faef1..eb6550f135e3 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -55,6 +55,11 @@ struct io_cq_ring {
 	struct io_uring_cqe	cqes[];
 };
 
+struct list_multi {
+	struct list_head list;
+	unsigned multi;
+};
+
 struct io_ring_ctx {
 	struct percpu_ref	refs;
 
@@ -79,13 +84,17 @@ struct io_ring_ctx {
 
 	struct completion	ctx_done;
 
+	/* iopoll submission state */
 	struct {
-		struct mutex		uring_lock;
-		wait_queue_head_t	wait;
+		spinlock_t		poll_lock;
+		struct list_multi	poll_submitted;
 	} ____cacheline_aligned_in_smp;
 
 	struct {
+		struct list_multi	poll_completing;
 		spinlock_t		completion_lock;
+		struct mutex		uring_lock;
+		wait_queue_head_t	wait;
 	} ____cacheline_aligned_in_smp;
 };
 
@@ -109,10 +118,13 @@ struct io_kiocb {
 	struct list_head	ki_list;
 	unsigned long		ki_flags;
 #define REQ_F_FORCE_NONBLOCK	1	/* inline submission attempt */
+#define REQ_F_IOPOLL_COMPLETED	2	/* polled IO has completed */
+#define REQ_F_IOPOLL_EAGAIN	4	/* submission got EAGAIN */
 	u64			ki_user_data;
 };
 
 #define IO_PLUG_THRESHOLD		2
+#define IO_IOPOLL_BATCH			8
 
 static struct kmem_cache *req_cachep;
 
@@ -144,6 +156,9 @@ static struct io_ring_ctx *io_ring_ctx_alloc(struct io_uring_params *p)
 
 	spin_lock_init(&ctx->completion_lock);
 	init_waitqueue_head(&ctx->wait);
+	spin_lock_init(&ctx->poll_lock);
+	INIT_LIST_HEAD(&ctx->poll_submitted.list);
+	INIT_LIST_HEAD(&ctx->poll_completing.list);
 	mutex_init(&ctx->uring_lock);
 
 	return ctx;
@@ -195,12 +210,209 @@ static void io_ring_drop_ctx_refs(struct io_ring_ctx *ctx, unsigned refs)
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
 	io_ring_drop_ctx_refs(req->ki_ctx, 1);
 }
 
+static void io_multi_list_splice(struct list_multi *src, struct list_multi *dst)
+{
+	list_splice_tail_init(&src->list, &dst->list);
+	dst->multi |= src->multi;
+}
+
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
+		list_req = list_first_entry(&list->list, struct io_kiocb,
+						ki_list);
+		if (list_req->rw.ki_filp != req->rw.ki_filp)
+			list->multi = 1;
+	}
+
+	/*
+	 * For fast devices, IO may have already completed. If it has, add
+	 * it to the front so we find it first. We can't add to the poll_done
+	 * list as that's unlocked from the completion side.
+	 */
+	if (req->ki_flags & REQ_F_IOPOLL_COMPLETED)
+		list_add(&req->ki_list, &list->list);
+	else
+		list_add_tail(&req->ki_list, &list->list);
+}
+
+/*
+ * Find and free completed poll iocbs
+ */
+static void io_iopoll_reap(struct io_ring_ctx *ctx, unsigned int *nr_events)
+{
+	void *reqs[IO_IOPOLL_BATCH];
+	struct io_kiocb *req, *n;
+	int to_free = 0;
+
+	list_for_each_entry_safe(req, n, &ctx->poll_completing.list, ki_list) {
+		if (!(req->ki_flags & REQ_F_IOPOLL_COMPLETED))
+			continue;
+		if (to_free == ARRAY_SIZE(reqs))
+			io_free_req_many(ctx, reqs, &to_free);
+
+		list_del(&req->ki_list);
+		reqs[to_free++] = req;
+
+		fput(req->rw.ki_filp);
+		(*nr_events)++;
+	}
+
+	if (to_free)
+		io_free_req_many(ctx, reqs, &to_free);
+}
+
+static int io_do_iopoll(struct io_ring_ctx *ctx, unsigned int *nr_events,
+			long min)
+{
+	int polled, found, ret;
+	struct io_kiocb *req;
+	bool spin;
+
+	/*
+	 * Only spin for completions if we don't have multiple devices hanging
+	 * off our complete list, and we're under the requested amount.
+	 */
+	spin = !ctx->poll_completing.multi && (*nr_events < min);
+
+	polled = found = 0;
+	list_for_each_entry(req, &ctx->poll_completing.list, ki_list) {
+		struct kiocb *kiocb = &req->rw;
+
+		if (req->ki_flags & REQ_F_IOPOLL_COMPLETED) {
+			/* force caller reap */
+			found = 0;
+			break;
+		}
+
+		found++;
+		ret = kiocb->ki_filp->f_op->iopoll(kiocb, spin);
+		if (ret < 0)
+			return ret;
+
+		polled += ret;
+		if (polled && spin)
+			spin = false;
+	}
+
+	return found;
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
+	int found;
+
+	/*
+	 * Check if we already have done events that satisfy what we need
+	 */
+	if (!list_empty(&ctx->poll_completing.list)) {
+		io_iopoll_reap(ctx, nr_events);
+		if (min && *nr_events >= min)
+			return 0;
+	}
+
+	/*
+	 * Take in a new working set from the submitted list, if possible.
+	 */
+	if (!list_empty_careful(&ctx->poll_submitted.list)) {
+		spin_lock(&ctx->poll_lock);
+		io_multi_list_splice(&ctx->poll_submitted,
+					&ctx->poll_completing);
+		spin_unlock(&ctx->poll_lock);
+	}
+
+	if (list_empty(&ctx->poll_completing.list))
+		return 0;
+
+	/*
+	 * Check again now that we have a new batch.
+	 */
+	io_iopoll_reap(ctx, nr_events);
+	if (min && *nr_events >= min)
+		return 0;
+
+	do {
+		found = io_do_iopoll(ctx, nr_events, min);
+		if (found <= 0)
+			break;
+	} while (ctx->poll_completing.multi && (min && *nr_events >= min));
+
+	io_iopoll_reap(ctx, nr_events);
+	if (*nr_events >= min)
+		return 0;
+
+	return found;
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
+	while (!list_empty_careful(&ctx->poll_submitted.list) ||
+	       !list_empty(&ctx->poll_completing.list)) {
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
@@ -216,18 +428,16 @@ static void kiocb_end_write(struct kiocb *kiocb)
 	}
 }
 
-static void io_cqring_fill_event(struct io_ring_ctx *ctx, u64 ki_user_data,
-				 long res, unsigned ev_flags)
+static void __io_cqring_fill_event(struct io_ring_ctx *ctx, u64 ki_user_data,
+				   long res, unsigned ev_flags)
 {
 	struct io_uring_cqe *cqe;
-	unsigned long flags;
 
 	/*
 	 * If we can't get a cq entry, userspace overflowed the
 	 * submission (by quite a lot). Increment the overflow count in
 	 * the ring.
 	 */
-	spin_lock_irqsave(&ctx->completion_lock, flags);
 	cqe = io_peek_cqring(ctx);
 	if (cqe) {
 		cqe->user_data = ki_user_data;
@@ -237,6 +447,15 @@ static void io_cqring_fill_event(struct io_ring_ctx *ctx, u64 ki_user_data,
 		io_inc_cqring(ctx);
 	} else
 		ctx->cq_ring->overflow++;
+}
+
+static void io_cqring_fill_event(struct io_ring_ctx *ctx, u64 ki_user_data,
+				 long res, unsigned ev_flags)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&ctx->completion_lock, flags);
+	__io_cqring_fill_event(ctx, ki_user_data, res, ev_flags);
 	spin_unlock_irqrestore(&ctx->completion_lock, flags);
 }
 
@@ -260,9 +479,41 @@ static void io_complete_scqring_rw(struct kiocb *kiocb, long res, long res2)
 	io_free_req(req);
 }
 
+static void io_complete_scqring_iopoll(struct kiocb *kiocb, long res, long res2)
+{
+	struct io_kiocb *req = container_of(kiocb, struct io_kiocb, rw);
+
+	kiocb_end_write(kiocb);
+
+	if (unlikely(res == -EAGAIN)) {
+		req->ki_flags |= REQ_F_IOPOLL_EAGAIN;
+	} else {
+		struct io_ring_ctx *ctx = req->ki_ctx;
+
+		__io_cqring_fill_event(ctx, req->ki_user_data, res, 0);
+		req->ki_flags |= REQ_F_IOPOLL_COMPLETED;
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
+	struct io_ring_ctx *ctx = req->ki_ctx;
+
+	spin_lock(&ctx->poll_lock);
+	io_multi_list_add(req, &ctx->poll_submitted);
+	spin_unlock(&ctx->poll_lock);
+}
+
 static int io_prep_rw(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 		      bool force_nonblock)
 {
+	struct io_ring_ctx *ctx = req->ki_ctx;
 	struct kiocb *kiocb = &req->rw;
 	int ret;
 
@@ -288,12 +539,21 @@ static int io_prep_rw(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 		kiocb->ki_flags |= IOCB_NOWAIT;
 		req->ki_flags |= REQ_F_FORCE_NONBLOCK;
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
 
-	kiocb->ki_complete = io_complete_scqring_rw;
+		kiocb->ki_flags |= IOCB_HIPRI;
+		kiocb->ki_complete = io_complete_scqring_iopoll;
+	} else {
+		if (kiocb->ki_flags & IOCB_HIPRI) {
+			ret = -EINVAL;
+			goto out_fput;
+		}
+		kiocb->ki_complete = io_complete_scqring_rw;
+	}
 	return 0;
 out_fput:
 	fput(kiocb->ki_filp);
@@ -431,6 +691,8 @@ static int io_fsync(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 	if (force_nonblock)
 		return -EAGAIN;
 
+	if (unlikely(req->ki_ctx->flags & IORING_SETUP_IOPOLL))
+		return -EINVAL;
 	if (unlikely(sqe->addr))
 		return -EINVAL;
 	if (unlikely(sqe->fsync_flags & ~IORING_FSYNC_DATASYNC))
@@ -479,7 +741,16 @@ static int __io_submit_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
 		break;
 	}
 
-	return ret;
+	if (ret)
+		return ret;
+
+	if (ctx->flags & IORING_SETUP_IOPOLL) {
+		if (req->ki_flags & REQ_F_IOPOLL_EAGAIN)
+			return -EAGAIN;
+		io_iopoll_req_issued(req);
+	}
+
+	return 0;
 }
 
 static void io_sq_wq_submit_work(struct work_struct *work)
@@ -649,12 +920,17 @@ static int __io_uring_enter(struct io_ring_ctx *ctx, unsigned to_submit,
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
@@ -722,6 +998,7 @@ static void io_free_scq_urings(struct io_ring_ctx *ctx)
 static void io_ring_ctx_free(struct io_ring_ctx *ctx)
 {
 	io_sq_offload_stop(ctx);
+	io_iopoll_reap_events(ctx);
 	io_free_scq_urings(ctx);
 	percpu_ref_exit(&ctx->refs);
 	kfree(ctx);
@@ -730,6 +1007,7 @@ static void io_ring_ctx_free(struct io_ring_ctx *ctx)
 static void io_ring_ctx_wait_and_kill(struct io_ring_ctx *ctx)
 {
 	percpu_ref_kill(&ctx->refs);
+	io_iopoll_reap_events(ctx);
 	wait_for_completion(&ctx->ctx_done);
 	io_ring_ctx_free(ctx);
 }
@@ -937,7 +1215,7 @@ SYSCALL_DEFINE2(io_uring_setup, u32, entries,
 			return -EINVAL;
 	}
 
-	if (p.flags)
+	if (p.flags & ~IORING_SETUP_IOPOLL)
 		return -EINVAL;
 
 	ret = io_uring_create(entries, &p);
diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index 72e8f5f13f3b..506498cc913e 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -33,6 +33,11 @@ struct io_uring_sqe {
 	__u64	user_data;	/* data to be passed back at completion time */
 };
 
+/*
+ * io_uring_setup() flags
+ */
+#define IORING_SETUP_IOPOLL	(1 << 0)	/* io_context is polled */
+
 #define IORING_OP_READV		1
 #define IORING_OP_WRITEV	2
 #define IORING_OP_FSYNC		3
-- 
2.17.1

