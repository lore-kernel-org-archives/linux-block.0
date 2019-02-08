Return-Path: <SRS0=HTWS=QP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 622FCC169C4
	for <linux-block@archiver.kernel.org>; Fri,  8 Feb 2019 17:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2882E2146E
	for <linux-block@archiver.kernel.org>; Fri,  8 Feb 2019 17:38:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="qLzo/Mxo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727981AbfBHRit (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Feb 2019 12:38:49 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:51471 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727984AbfBHRfL (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 Feb 2019 12:35:11 -0500
Received: by mail-it1-f196.google.com with SMTP id y184so4391087itc.1
        for <linux-block@vger.kernel.org>; Fri, 08 Feb 2019 09:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WBT4JgpGRwBbcyes8JBlFLUWj99egfcHX3jU2fE1fq8=;
        b=qLzo/Mxop2vNZwU/6sd010JtsbQHogtOjnRkoi3+yYZQkrYpSpqK5KemW15+57eMHf
         5QNvYFksF+/ZYdGgLhAA8VxJ+YKjfwWfQLu70CtCjOlAGjgif02FWO3PQxydgSvATIpU
         yCpykfyzhOqtPUnQe72M7OJiOE22jNLW6bFf75arzoOW8n4Oqjf/C4U1mA1vewjmtXyO
         wyiM7yR9BL9kDlUmQHaXlB/gxXTfpkFBMurzmMb2XPTiq4qfZU378ACMm2fRnXSKIpRm
         pMjJrfWZjged31ymhlwfUJMOPwyF3qoKFWiIEMvH+AIgIY3TeMgADvP3bMfR29YmCK1V
         Cd9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WBT4JgpGRwBbcyes8JBlFLUWj99egfcHX3jU2fE1fq8=;
        b=U1KF+ut8jcyUpoD0FUoBudbfssaS8Tuobg6YiF/gAcUsxAbn27XUDNfs61NKbbd+jT
         nCHlOAs6r33fueh65hN65mnaC9sOZXy6oZpay1WbK2o/eICQxz7aLQL2Ka4PrBzm0DEz
         052lrmdRi0Nqoulfw+4qe/3U9NGckjoA3oVsMDpBTr15PzW9mc+Pzc09mCcSiQHOI2Rq
         ny7tT2Md4E+goE8kKGddAi9cdZd3vx9OG6hQl4Pkh03zDB2x50JGTMDivIGDo2e/6qS0
         UAgqqGY1YMKX7j2p3eMFRQflyQaJv83/korXZgrgdFFlSlva5ubEV8a4h+kLjRD4aZH5
         dUmg==
X-Gm-Message-State: AHQUAuarZcwZBALg+DgNDxt5TBRCdFu8K1c5JOnRnlsFr5PM2+8KxB8V
        9TAU15WRJQEUooiu+v31gOD2+w==
X-Google-Smtp-Source: AHgI3IYhO3hSiF+576PZAAYIjD4XRiO6G8A6408l5qBDShB1iZyiDQ7wwZcOsBA2jFV9J4YRgDs3VQ==
X-Received: by 2002:a24:760b:: with SMTP id z11mr9576583itb.105.1549647310297;
        Fri, 08 Feb 2019 09:35:10 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id f142sm1522627itc.15.2019.02.08.09.35.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 09:35:09 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        linux-api@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com, jannh@google.com,
        viro@ZenIV.linux.org.uk, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 18/19] io_uring: allow workqueue item to handle multiple buffered requests
Date:   Fri,  8 Feb 2019 10:34:22 -0700
Message-Id: <20190208173423.27014-19-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190208173423.27014-1-axboe@kernel.dk>
References: <20190208173423.27014-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Right now we punt any buffered request that ends up triggering an
-EAGAIN to an async workqueue. This works fine in terms of providing
async execution of them, but it also can create quite a lot of work
queue items. For sequentially buffered IO, it's advantageous to
serialize the issue of them. For reads, the first one will trigger a
read-ahead, and subsequent request merely end up waiting on later pages
to complete. For writes, devices usually respond better to streamed
sequential writes.

Add state to track the last buffered request we punted to a work queue,
and if the next one is sequential to the previous, attempt to get the
previous work item to handle it. We limit the number of sequential
add-ons to the a multiple (8) of the max read-ahead size of the file.
This should be a good number for both reads and wries, as it defines the
max IO size the device can do directly.

This drastically cuts down on the number of context switches we need to
handle buffered sequential IO, and a basic test case of copying a big
file with io_uring sees a 5x speedup.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io_uring.c | 267 ++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 216 insertions(+), 51 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index c014dbc29c77..175dac00eb47 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -74,6 +74,16 @@ struct io_mapped_ubuf {
 	unsigned int	nr_bvecs;
 };
 
+struct async_list {
+	spinlock_t		lock;
+	atomic_t		cnt;
+	struct list_head	list;
+
+	struct file		*file;
+	off_t			io_end;
+	size_t			io_pages;
+};
+
 struct io_ring_ctx {
 	struct {
 		struct percpu_ref	refs;
@@ -143,6 +153,8 @@ struct io_ring_ctx {
 		struct list_head	cancel_list;
 	} ____cacheline_aligned_in_smp;
 
+	struct async_list	pending_async[2];
+
 #if defined(CONFIG_UNIX)
 	struct socket		*ring_sock;
 #endif
@@ -180,6 +192,7 @@ struct io_kiocb {
 #define REQ_F_FORCE_NONBLOCK	1	/* inline submission attempt */
 #define REQ_F_IOPOLL_COMPLETED	2	/* polled IO has completed */
 #define REQ_F_FIXED_FILE	4	/* ctx owns file */
+#define REQ_F_SEQ_PREV		8	/* sequential with previous */
 	u64			user_data;
 	u64			error;
 
@@ -236,6 +249,7 @@ static void io_ring_ctx_ref_free(struct percpu_ref *ref)
 static struct io_ring_ctx *io_ring_ctx_alloc(struct io_uring_params *p)
 {
 	struct io_ring_ctx *ctx;
+	int i;
 
 	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
 	if (!ctx)
@@ -251,6 +265,11 @@ static struct io_ring_ctx *io_ring_ctx_alloc(struct io_uring_params *p)
 	init_completion(&ctx->ctx_done);
 	mutex_init(&ctx->uring_lock);
 	init_waitqueue_head(&ctx->wait);
+	for (i = 0; i < ARRAY_SIZE(ctx->pending_async); i++) {
+		spin_lock_init(&ctx->pending_async[i].lock);
+		INIT_LIST_HEAD(&ctx->pending_async[i].list);
+		atomic_set(&ctx->pending_async[i].cnt, 0);
+	}
 	spin_lock_init(&ctx->completion_lock);
 	INIT_LIST_HEAD(&ctx->poll_list);
 	INIT_LIST_HEAD(&ctx->cancel_list);
@@ -847,6 +866,39 @@ static int io_import_iovec(struct io_ring_ctx *ctx, int rw,
 	return import_iovec(rw, buf, sqe_len, UIO_FASTIOV, iovec, iter);
 }
 
+static void io_async_list_note(int rw, struct io_kiocb *req, size_t len)
+{
+	struct async_list *async_list = &req->ctx->pending_async[rw];
+	struct kiocb *kiocb = &req->rw;
+	struct file *filp = kiocb->ki_filp;
+	off_t io_end = kiocb->ki_pos + len;
+
+	if (filp == async_list->file && kiocb->ki_pos == async_list->io_end) {
+		unsigned long max_pages;
+
+		/* Use 8x RA size as a decent limiter for both reads/writes */
+		max_pages = filp->f_ra.ra_pages;
+		if (!max_pages)
+			max_pages = VM_MAX_READAHEAD >> (PAGE_SHIFT - 10);
+		max_pages *= 8;
+
+		len >>= PAGE_SHIFT;
+		if (async_list->io_pages + len <= max_pages) {
+			req->flags |= REQ_F_SEQ_PREV;
+			async_list->io_pages += len;
+		} else {
+			io_end = 0;
+			async_list->io_pages = 0;
+		}
+	}
+
+	if (async_list->file != filp) {
+		async_list->io_pages = 0;
+		async_list->file = filp;
+	}
+	async_list->io_end = io_end;
+}
+
 static ssize_t io_read(struct io_kiocb *req, const struct sqe_submit *s,
 		       bool force_nonblock, struct io_submit_state *state)
 {
@@ -854,6 +906,7 @@ static ssize_t io_read(struct io_kiocb *req, const struct sqe_submit *s,
 	struct kiocb *kiocb = &req->rw;
 	struct iov_iter iter;
 	struct file *file;
+	size_t iov_count;
 	ssize_t ret;
 
 	ret = io_prep_rw(req, s, force_nonblock, state);
@@ -872,16 +925,24 @@ static ssize_t io_read(struct io_kiocb *req, const struct sqe_submit *s,
 	if (ret)
 		goto out_fput;
 
-	ret = rw_verify_area(READ, file, &kiocb->ki_pos, iov_iter_count(&iter));
+	iov_count = iov_iter_count(&iter);
+	ret = rw_verify_area(READ, file, &kiocb->ki_pos, iov_count);
 	if (!ret) {
 		ssize_t ret2;
 
 		/* Catch -EAGAIN return for forced non-blocking submission */
 		ret2 = call_read_iter(file, kiocb, &iter);
-		if (!force_nonblock || ret2 != -EAGAIN)
+		if (!force_nonblock || ret2 != -EAGAIN) {
 			io_rw_done(kiocb, ret2);
-		else
+		} else {
+			/*
+			 * If ->needs_lock is true, we're already in async
+			 * context.
+			 */
+			if (!s->needs_lock)
+				io_async_list_note(READ, req, iov_count);
 			ret = -EAGAIN;
+		}
 	}
 	kfree(iovec);
 out_fput:
@@ -898,14 +959,12 @@ static ssize_t io_write(struct io_kiocb *req, const struct sqe_submit *s,
 	struct kiocb *kiocb = &req->rw;
 	struct iov_iter iter;
 	struct file *file;
+	size_t iov_count;
 	ssize_t ret;
 
 	ret = io_prep_rw(req, s, force_nonblock, state);
 	if (ret)
 		return ret;
-	/* Hold on to the file for -EAGAIN */
-	if (force_nonblock && !(kiocb->ki_flags & IOCB_DIRECT))
-		return -EAGAIN;
 
 	ret = -EBADF;
 	file = kiocb->ki_filp;
@@ -919,8 +978,17 @@ static ssize_t io_write(struct io_kiocb *req, const struct sqe_submit *s,
 	if (ret)
 		goto out_fput;
 
-	ret = rw_verify_area(WRITE, file, &kiocb->ki_pos,
-				iov_iter_count(&iter));
+	iov_count = iov_iter_count(&iter);
+
+	ret = -EAGAIN;
+	if (force_nonblock && !(kiocb->ki_flags & IOCB_DIRECT)) {
+		/* If ->needs_lock is true, we're already in async context. */
+		if (!s->needs_lock)
+			io_async_list_note(WRITE, req, iov_count);
+		goto out_free;
+	}
+
+	ret = rw_verify_area(WRITE, file, &kiocb->ki_pos, iov_count);
 	if (!ret) {
 		/*
 		 * Open-code file_start_write here to grab freeze protection,
@@ -938,9 +1006,11 @@ static ssize_t io_write(struct io_kiocb *req, const struct sqe_submit *s,
 		kiocb->ki_flags |= IOCB_WRITE;
 		io_rw_done(kiocb, call_write_iter(file, kiocb, &iter));
 	}
+out_free:
 	kfree(iovec);
 out_fput:
-	if (unlikely(ret))
+	/* Hold on to the file for -EAGAIN */
+	if (unlikely(ret && ret != -EAGAIN))
 		io_fput(req);
 	return ret;
 }
@@ -1309,6 +1379,21 @@ static int __io_submit_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
 	return 0;
 }
 
+static struct async_list *io_async_list_from_sqe(struct io_ring_ctx *ctx,
+						 const struct io_uring_sqe *sqe)
+{
+	switch (sqe->opcode) {
+	case IORING_OP_READV:
+	case IORING_OP_READ_FIXED:
+		return &ctx->pending_async[READ];
+	case IORING_OP_WRITEV:
+	case IORING_OP_WRITE_FIXED:
+		return &ctx->pending_async[WRITE];
+	default:
+		return NULL;
+	}
+}
+
 static inline bool io_sqe_needs_user(const struct io_uring_sqe *sqe)
 {
 	u8 opcode = READ_ONCE(sqe->opcode);
@@ -1320,60 +1405,133 @@ static inline bool io_sqe_needs_user(const struct io_uring_sqe *sqe)
 static void io_sq_wq_submit_work(struct work_struct *work)
 {
 	struct io_kiocb *req = container_of(work, struct io_kiocb, work);
-	struct sqe_submit *s = &req->submit;
 	struct io_ring_ctx *ctx = req->ctx;
+	struct mm_struct *cur_mm = NULL;
+	struct async_list *async_list;
+	LIST_HEAD(req_list);
 	mm_segment_t old_fs;
-	bool needs_user;
-	u64 user_data;
 	int ret;
 
-	 /* Ensure we clear previously set forced non-block flag */
-	req->flags &= ~REQ_F_FORCE_NONBLOCK;
-	req->rw.ki_flags &= ~IOCB_NOWAIT;
+	async_list = io_async_list_from_sqe(ctx, req->submit.sqe);
+restart:
+	do {
+		struct sqe_submit *s = &req->submit;
+		u64 user_data = READ_ONCE(s->sqe->user_data);
+
+		/* Ensure we clear previously set forced non-block flag */
+		req->flags &= ~REQ_F_FORCE_NONBLOCK;
+		req->rw.ki_flags &= ~IOCB_NOWAIT;
 
-	user_data = READ_ONCE(s->sqe->user_data);
-	s->needs_lock = true;
-	s->has_user = false;
-	s->needs_fixed_file = false;
+		ret = 0;
+		if (io_sqe_needs_user(s->sqe) && !cur_mm) {
+			if (!mmget_not_zero(ctx->sqo_mm)) {
+				ret = -EFAULT;
+			} else {
+				cur_mm = ctx->sqo_mm;
+				use_mm(ctx->sqo_mm);
+				old_fs = get_fs();
+				set_fs(USER_DS);
+			}
+		}
+
+		if (!ret) {
+			s->has_user = cur_mm != NULL;
+			s->needs_lock = true;
+			s->needs_fixed_file = false;
+			do {
+				ret = __io_submit_sqe(ctx, req, s, false, NULL);
+				/*
+				 * We can get EAGAIN for polled IO even though
+				 * we're forcing a sync submission from here,
+				 * since we can't wait for request slots on the
+				 * block side.
+				 */
+				if (ret != -EAGAIN)
+					break;
+				cond_resched();
+			} while (1);
+		}
+		if (ret) {
+			io_cqring_add_event(ctx, user_data, ret, 0);
+			io_free_req(req);
+		}
+		if (!async_list)
+			break;
+		if (!list_empty(&req_list)) {
+			req = list_first_entry(&req_list, struct io_kiocb,
+						list);
+			list_del(&req->list);
+			continue;
+		}
+		if (list_empty(&async_list->list))
+			break;
+
+		req = NULL;
+		spin_lock(&async_list->lock);
+		if (list_empty(&async_list->list)) {
+			spin_unlock(&async_list->lock);
+			break;
+		}
+		list_splice_init(&async_list->list, &req_list);
+		spin_unlock(&async_list->lock);
+
+		req = list_first_entry(&req_list, struct io_kiocb, list);
+		list_del(&req->list);
+	} while (req);
 
 	/*
-	 * If we're doing IO to fixed buffers, we don't need to get/set
-	 * user context
+	 * Rare case of racing with a submitter. If we find the count has
+	 * dropped to zero AND we have pending work items, then restart
+	 * the processing. This is a tiny race window.
 	 */
-	needs_user = io_sqe_needs_user(s->sqe);
-	if (needs_user) {
-		if (!mmget_not_zero(ctx->sqo_mm)) {
-			ret = -EFAULT;
-			goto err;
+	ret = atomic_dec_return(&async_list->cnt);
+	while (!ret && !list_empty(&async_list->list)) {
+		spin_lock(&async_list->lock);
+		atomic_inc(&async_list->cnt);
+		list_splice_init(&async_list->list, &req_list);
+		spin_unlock(&async_list->lock);
+
+		if (!list_empty(&req_list)) {
+			req = list_first_entry(&req_list, struct io_kiocb,
+						list);
+			list_del(&req->list);
+			goto restart;
 		}
-		use_mm(ctx->sqo_mm);
-		old_fs = get_fs();
-		set_fs(USER_DS);
-		s->has_user = true;
+		ret = atomic_dec_return(&async_list->cnt);
 	}
 
-	do {
-		ret = __io_submit_sqe(ctx, req, s, false, NULL);
-		/*
-		 * We can get EAGAIN for polled IO even though we're forcing
-		 * a sync submission from here, since we can't wait for
-		 * request slots on the block side.
-		 */
-		if (ret != -EAGAIN)
-			break;
-		cond_resched();
-	} while (1);
-
-	if (needs_user) {
+	if (cur_mm) {
 		set_fs(old_fs);
-		unuse_mm(ctx->sqo_mm);
-		mmput(ctx->sqo_mm);
+		unuse_mm(cur_mm);
+		mmput(cur_mm);
 	}
-err:
-	if (ret) {
-		io_cqring_add_event(ctx, user_data, ret, 0);
-		io_free_req(req);
+}
+
+/*
+ * See if we can piggy back onto previously submitted work, that is still
+ * running. We currently only allow this if the new request is sequential
+ * to the previous one we punted.
+ */
+static bool io_add_to_prev_work(struct async_list *list, struct io_kiocb *req)
+{
+	bool ret = false;
+
+	if (!list)
+		return false;
+	if (!(req->flags & REQ_F_SEQ_PREV))
+		return false;
+	if (!atomic_read(&list->cnt))
+		return false;
+
+	ret = true;
+	spin_lock(&list->lock);
+	list_add_tail(&req->list, &list->list);
+	if (!atomic_read(&list->cnt)) {
+		list_del_init(&req->list);
+		ret = false;
 	}
+	spin_unlock(&list->lock);
+	return ret;
 }
 
 static int io_submit_sqe(struct io_ring_ctx *ctx, const struct sqe_submit *s,
@@ -1394,9 +1552,16 @@ static int io_submit_sqe(struct io_ring_ctx *ctx, const struct sqe_submit *s,
 
 	ret = __io_submit_sqe(ctx, req, s, true, state);
 	if (ret == -EAGAIN) {
+		struct async_list *list;
+
+		list = io_async_list_from_sqe(ctx, s->sqe);
 		memcpy(&req->submit, s, sizeof(*s));
-		INIT_WORK(&req->work, io_sq_wq_submit_work);
-		queue_work(ctx->sqo_wq, &req->work);
+		if (!io_add_to_prev_work(list, req)) {
+			if (list)
+				atomic_inc(&list->cnt);
+			INIT_WORK(&req->work, io_sq_wq_submit_work);
+			queue_work(ctx->sqo_wq, &req->work);
+		}
 		ret = 0;
 	}
 	if (ret)
-- 
2.17.1

