Return-Path: <SRS0=ptgV=OU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D2AC5CFFE
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 00:16:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEE5C2087F
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 00:16:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="hi9l4jod"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEE5C2087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbeLKAQz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Dec 2018 19:16:55 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34952 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729563AbeLKAQu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Dec 2018 19:16:50 -0500
Received: by mail-pl1-f193.google.com with SMTP id p8so6039295plo.2
        for <linux-block@vger.kernel.org>; Mon, 10 Dec 2018 16:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tBHP5sOR5DXH98m2JOmIkXehq+FLfo5iFcQI16RcgNI=;
        b=hi9l4joddTD20tjRlCCyJDrOxXPKVR9z3dB+a7O5HT3pz9oecQm8rjZGQnYvFhwJSy
         qRYGWORzXw4hqmnslpRQjq03VPILMCxZ5XI0/DuvPewOoLfpgWmFG+pzFAWypgH98R6e
         YBZWhBiLsixtZHe/TL9bulnxCX8L3U+ljZSyoSnBdWCxfLVbOTi8DwDkdaBy6AN/N7sX
         6oyXh+woZVw2ys+Lal2YRjbc1O/FMZzuN0eOdj2SlbG+cKAzUXiA7ZRWRylJfjre6iJr
         hKu5/tGp2Dwvf8AAKRy8S2dGOMCQzxu01Idx3IQFd1h2IMSWc3jKq5MvrR2QqUzBy8rw
         jwkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tBHP5sOR5DXH98m2JOmIkXehq+FLfo5iFcQI16RcgNI=;
        b=RDtDWYluzbf3u/D5f3ZVhc2fCBp4IDMKvXlHawpK4hB2iHjg77e7jpRNtvjftCQ83q
         AMYHO+aZJsQ6PNVdLm+OhCM8GPW6SzgPRy2Arc2fzwDj32jjl1P6DDkUKGE7lt6sCRCS
         GHgfRnE7aZ4F17eFQtmfMHkoh1hOX4TAmBSq5jhHvZ5kSygWS0xFEn9WzORCFqaAMa/f
         SKIlqkwmfivSJGC+JrzTs9uzhgQnkQQpCweIcw4WasIVMGh1q597W3Eiw0Xe0IqsBoza
         zCHGq8Qh40e+Y5rvAGFTsi5k0CXyM085mWP8ltmhBoiaqXW4AilOczxlQ3PsoPw7+7BO
         1OZw==
X-Gm-Message-State: AA+aEWZMdayh+vx2iYT72gKqyovEOpMKY0O1uXC9p18qW1uIzQwuL/Qj
        yloH73ke+Vs/nBY6mCztM7qQsmH5Unw2DQ==
X-Google-Smtp-Source: AFSGD/Usl3o1ju/19az+RqVnY6CPMKSJ7Zdw1P/3uKdUqlxPO4mjR+TOV4FSb+kmntyNThlB+koddg==
X-Received: by 2002:a17:902:d911:: with SMTP id c17mr9951260plz.151.1544487409276;
        Mon, 10 Dec 2018 16:16:49 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id u8sm16872856pfl.16.2018.12.10.16.16.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 16:16:48 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org
Cc:     hch@lst.de, jmoyer@redhat.com, clm@fb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 27/27] aio: support kernel side submission for aio with SCQRING
Date:   Mon, 10 Dec 2018 17:15:49 -0700
Message-Id: <20181211001549.30085-28-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181211001549.30085-1-axboe@kernel.dk>
References: <20181211001549.30085-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add support for backing the io_context with either a thread, or a
workqueue and letting those handle the submission for us. This can
be used to reduce overhead for submission, or to always make submission
async. The latter is particularly useful for buffered aio, which is
now fully async with this feature.

For polled IO, we could have the kernel side thread hammer on the SQ
ring and submit when it finds IO. This would mean that an application
would NEVER have to enter the kernel to do IO! Didn't add this yet,
but it would be trivial to add.

If an application sets IOCTX_FLAG_SCQTHREAD, the io_context gets a
single thread backing. If used with buffered IO, this will limit
the device queue depth to 1, but it will be async, IOs will simply
be serialized.

Or an application can set IOCTX_FLAG_SQWQ, in which case the io_context
gets a work queue backing. The concurrency level is the mininum of
twice the available CPUs, or the queue depth specific for the context.
For this mode, we attempt to do buffered reads inline, in case they are
cached. So we should only punt to a workqueue, if we would have to block
to get our data.

Tested with polling, no polling, fixedbufs, no fixedbufs, buffered,
O_DIRECT.

See the sample application for how to use it:

http://git.kernel.dk/cgit/fio/plain/t/aio-ring.c

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/aio.c                     | 416 ++++++++++++++++++++++++++++++++---
 include/uapi/linux/aio_abi.h |   3 +
 2 files changed, 389 insertions(+), 30 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index f4f39a7f8f94..44284b1f4ec9 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -25,6 +25,7 @@
 #include <linux/sched/signal.h>
 #include <linux/fs.h>
 #include <linux/file.h>
+#include <linux/fdtable.h>
 #include <linux/mm.h>
 #include <linux/mman.h>
 #include <linux/mmu_context.h>
@@ -43,6 +44,7 @@
 #include <linux/percpu-refcount.h>
 #include <linux/mount.h>
 #include <linux/sizes.h>
+#include <linux/sched/mm.h>
 
 #include <asm/kmap_types.h>
 #include <linux/uaccess.h>
@@ -103,6 +105,14 @@ struct aio_mapped_ubuf {
 	unsigned int nr_bvecs;
 };
 
+struct aio_sq_offload {
+	struct task_struct *thread;	/* if using a thread */
+	struct workqueue_struct *wq;	/* wq offload */
+	struct mm_struct *mm;
+	struct files_struct *files;
+	wait_queue_head_t wait;
+};
+
 struct kioctx {
 	struct percpu_ref	users;
 	atomic_t		dead;
@@ -146,6 +156,10 @@ struct kioctx {
 	struct aio_mapped_range	sq_ring;
 	struct aio_mapped_range	cq_ring;
 	int			cq_ring_overflow;
+	int			submit_eagain;
+
+	/* sq ring submitter thread, if used */
+	struct aio_sq_offload	sq_offload;
 
 	struct rcu_work		free_rwork;	/* see free_ioctx() */
 
@@ -236,6 +250,7 @@ struct aio_kiocb {
 	unsigned long		ki_flags;
 #define KIOCB_F_POLL_COMPLETED	0	/* polled IO has completed */
 #define KIOCB_F_POLL_EAGAIN	1	/* polled submission got EAGAIN */
+#define KIOCB_F_FORCE_NONBLOCK	2	/* inline submission attempt */
 
 	refcount_t		ki_refcnt;
 
@@ -1354,19 +1369,31 @@ static void aio_complete(struct aio_kiocb *iocb, long res, long res2)
 		unsigned int tail;
 
 		/*
-		 * If we can't get a cq entry, userspace overflowed the
-		 * submission (by quite a lot). Flag it as an overflow
-		 * condition, and next io_ring_enter(2) call will return
-		 * -EOVERFLOW.
+		 * Catch EAGAIN early if we've forced a nonblock attempt, as
+		 * we don't want to pass that back down to userspace through
+		 * the CQ ring. Just mark the ctx as such, so the caller will
+		 * see it and punt to workqueue. This is just for buffered
+		 * aio reads.
 		 */
-		spin_lock_irqsave(&ctx->completion_lock, flags);
-		ev = aio_peek_cqring(ctx, &tail);
-		if (ev) {
-			aio_fill_event(ev, iocb, res, res2);
-			aio_commit_cqring(ctx, tail);
-		} else
-			ctx->cq_ring_overflow = 1;
-		spin_unlock_irqrestore(&ctx->completion_lock, flags);
+		if (res == -EAGAIN &&
+		    test_bit(KIOCB_F_FORCE_NONBLOCK, &iocb->ki_flags)) {
+			ctx->submit_eagain = 1;
+		} else {
+			/*
+			 * If we can't get a cq entry, userspace overflowed the
+			 * submission (by quite a lot). Flag it as an overflow
+			 * condition, and next io_ring_enter(2) call will return
+			 * -EOVERFLOW.
+			 */
+			spin_lock_irqsave(&ctx->completion_lock, flags);
+			ev = aio_peek_cqring(ctx, &tail);
+			if (ev) {
+				aio_fill_event(ev, iocb, res, res2);
+				aio_commit_cqring(ctx, tail);
+			} else
+				ctx->cq_ring_overflow = 1;
+			spin_unlock_irqrestore(&ctx->completion_lock, flags);
+		}
 	} else {
 		aio_ring_complete(ctx, iocb, res, res2);
 
@@ -1768,6 +1795,63 @@ static struct iocb *aio_iocb_from_index(struct kioctx *ctx, int index)
 	return iocb;
 }
 
+static int aio_sq_thread(void *);
+
+static int aio_sq_thread_start(struct kioctx *ctx, struct aio_iocb_ring *ring)
+{
+	struct aio_sq_offload *aso = &ctx->sq_offload;
+	int ret;
+
+	memset(aso, 0, sizeof(*aso));
+	init_waitqueue_head(&aso->wait);
+
+	if (!(ctx->flags & IOCTX_FLAG_FIXEDBUFS))
+		aso->mm = current->mm;
+
+	ret = -EBADF;
+	aso->files = get_files_struct(current);
+	if (!aso->files)
+		goto err;
+
+	if (ctx->flags & IOCTX_FLAG_SQTHREAD) {
+		char name[32];
+
+		snprintf(name, sizeof(name), "aio-sq-%lu/%d", ctx->user_id,
+					ring->sq_thread_cpu);
+		aso->thread = kthread_create_on_cpu(aio_sq_thread, ctx,
+						ring->sq_thread_cpu, name);
+		if (IS_ERR(aso->thread)) {
+			ret = PTR_ERR(aso->thread);
+			aso->thread = NULL;
+			goto err;
+		}
+		wake_up_process(aso->thread);
+	} else if (ctx->flags & IOCTX_FLAG_SQWQ) {
+		int concurrency;
+
+		/* Do QD, or 2 * CPUS, whatever is smallest */
+		concurrency = min(ring->nr_events - 1, 2 * num_online_cpus());
+		aso->wq = alloc_workqueue("aio-sq-%lu",
+						WQ_UNBOUND | WQ_FREEZABLE | WQ_SYSFS,
+						concurrency,
+						ctx->user_id);
+		if (!aso->wq) {
+			ret = -ENOMEM;
+			goto err;
+		}
+	}
+
+	return 0;
+err:
+	if (aso->files) {
+		put_files_struct(aso->files);
+		aso->files = NULL;
+	}
+	if (aso->mm)
+		aso->mm = NULL;
+	return ret;
+}
+
 static void aio_unmap_range(struct aio_mapped_range *range)
 {
 	int i;
@@ -1825,6 +1909,19 @@ static int aio_useriocb_map(struct kioctx *ctx, struct iocb __user *iocbs)
 
 static void aio_scqring_unmap(struct kioctx *ctx)
 {
+	struct aio_sq_offload *aso = &ctx->sq_offload;
+
+	if (aso->thread) {
+		kthread_stop(aso->thread);
+		aso->thread = NULL;
+	} else if (aso->wq) {
+		destroy_workqueue(aso->wq);
+		aso->wq = NULL;
+	}
+	if (aso->files) {
+		put_files_struct(aso->files);
+		aso->files = NULL;
+	}
 	aio_unmap_range(&ctx->sq_ring);
 	aio_unmap_range(&ctx->cq_ring);
 }
@@ -1854,10 +1951,8 @@ static int aio_scqring_map(struct kioctx *ctx,
 
 	ret = aio_map_range(&ctx->cq_ring, cq_ring,
 			    cq_ring_size * sizeof(struct io_event), FOLL_WRITE);
-	if (ret) {
-		aio_unmap_range(&ctx->sq_ring);
-		return ret;
-	}
+	if (ret)
+		goto err;
 
 	ksq_ring = page_address(ctx->sq_ring.pages[0]);
 	ksq_ring->nr_events = sq_ring_size;
@@ -1866,7 +1961,16 @@ static int aio_scqring_map(struct kioctx *ctx,
 	kcq_ring = page_address(ctx->cq_ring.pages[0]);
 	kcq_ring->nr_events = cq_ring_size;
 	kcq_ring->head = kcq_ring->tail = 0;
-	return 0;
+
+	if (ctx->flags & (IOCTX_FLAG_SQTHREAD | IOCTX_FLAG_SQWQ))
+		ret = aio_sq_thread_start(ctx, ksq_ring);
+
+err:
+	if (ret) {
+		aio_unmap_range(&ctx->sq_ring);
+		aio_unmap_range(&ctx->cq_ring);
+	}
+	return ret;
 }
 
 static void aio_iocb_buffer_unmap(struct kioctx *ctx)
@@ -2007,7 +2111,8 @@ SYSCALL_DEFINE6(io_setup2, u32, nr_events, u32, flags,
 	long ret;
 
 	if (flags & ~(IOCTX_FLAG_USERIOCB | IOCTX_FLAG_IOPOLL |
-		      IOCTX_FLAG_FIXEDBUFS | IOCTX_FLAG_SCQRING))
+		      IOCTX_FLAG_FIXEDBUFS | IOCTX_FLAG_SCQRING |
+		      IOCTX_FLAG_SQTHREAD | IOCTX_FLAG_SQWQ))
 		return -EINVAL;
 
 	ret = get_user(ctx, ctxp);
@@ -2249,7 +2354,7 @@ static struct file *aio_file_get(struct aio_submit_state *state, int fd)
 }
 
 static int aio_prep_rw(struct aio_kiocb *kiocb, const struct iocb *iocb,
-		       struct aio_submit_state *state)
+		       struct aio_submit_state *state, bool force_nonblock)
 {
 	struct kioctx *ctx = kiocb->ki_ctx;
 	struct kiocb *req = &kiocb->rw;
@@ -2282,6 +2387,10 @@ static int aio_prep_rw(struct aio_kiocb *kiocb, const struct iocb *iocb,
 	ret = kiocb_set_rw_flags(req, iocb->aio_rw_flags);
 	if (unlikely(ret))
 		goto out_fput;
+	if (force_nonblock) {
+		req->ki_flags |= IOCB_NOWAIT;
+		set_bit(KIOCB_F_FORCE_NONBLOCK, &kiocb->ki_flags);
+	}
 
 	if (iocb->aio_flags & IOCB_FLAG_HIPRI) {
 		/* shares space in the union, and is rather pointless.. */
@@ -2422,7 +2531,7 @@ static void aio_iopoll_iocb_issued(struct aio_submit_state *state,
 
 static ssize_t aio_read(struct aio_kiocb *kiocb, const struct iocb *iocb,
 			struct aio_submit_state *state, bool vectored,
-			bool compat, bool kaddr)
+			bool compat, bool kaddr, bool force_nonblock)
 {
 	struct iovec inline_vecs[UIO_FASTIOV], *iovec = inline_vecs;
 	struct kiocb *req = &kiocb->rw;
@@ -2430,7 +2539,7 @@ static ssize_t aio_read(struct aio_kiocb *kiocb, const struct iocb *iocb,
 	struct file *file;
 	ssize_t ret;
 
-	ret = aio_prep_rw(kiocb, iocb, state);
+	ret = aio_prep_rw(kiocb, iocb, state, force_nonblock);
 	if (ret)
 		return ret;
 	file = req->ki_filp;
@@ -2467,7 +2576,7 @@ static ssize_t aio_write(struct aio_kiocb *kiocb, const struct iocb *iocb,
 	struct file *file;
 	ssize_t ret;
 
-	ret = aio_prep_rw(kiocb, iocb, state);
+	ret = aio_prep_rw(kiocb, iocb, state, false);
 	if (ret)
 		return ret;
 	file = req->ki_filp;
@@ -2720,7 +2829,7 @@ static ssize_t aio_poll(struct aio_kiocb *aiocb, const struct iocb *iocb)
 static int __io_submit_one(struct kioctx *ctx, const struct iocb *iocb,
 			   struct iocb __user *user_iocb,
 			   struct aio_submit_state *state, bool compat,
-			   bool kaddr)
+			   bool kaddr, bool force_nonblock)
 {
 	struct aio_kiocb *req;
 	ssize_t ret;
@@ -2779,13 +2888,15 @@ static int __io_submit_one(struct kioctx *ctx, const struct iocb *iocb,
 	ret = -EINVAL;
 	switch (iocb->aio_lio_opcode) {
 	case IOCB_CMD_PREAD:
-		ret = aio_read(req, iocb, state, false, compat, kaddr);
+		ret = aio_read(req, iocb, state, false, compat, kaddr,
+				force_nonblock);
 		break;
 	case IOCB_CMD_PWRITE:
 		ret = aio_write(req, iocb, state, false, compat, kaddr);
 		break;
 	case IOCB_CMD_PREADV:
-		ret = aio_read(req, iocb, state, true, compat, kaddr);
+		ret = aio_read(req, iocb, state, true, compat, kaddr,
+				force_nonblock);
 		break;
 	case IOCB_CMD_PWRITEV:
 		ret = aio_write(req, iocb, state, true, compat, kaddr);
@@ -2857,7 +2968,8 @@ static int io_submit_one(struct kioctx *ctx, struct iocb __user *user_iocb,
 		iocbp = &iocb;
 	}
 
-	return __io_submit_one(ctx, iocbp, user_iocb, state, compat, kaddr);
+	return __io_submit_one(ctx, iocbp, user_iocb, state, compat, kaddr,
+				false);
 }
 
 #ifdef CONFIG_BLOCK
@@ -2960,7 +3072,8 @@ static int aio_ring_submit(struct kioctx *ctx, unsigned int to_submit)
 		if (!iocb)
 			break;
 
-		ret = __io_submit_one(ctx, iocb, NULL, NULL, false, kaddr);
+		ret = __io_submit_one(ctx, iocb, NULL, NULL, false, kaddr,
+					false);
 		if (ret)
 			break;
 
@@ -3013,15 +3126,258 @@ static int aio_cqring_wait(struct kioctx *ctx, int min_events)
 	return ret;
 }
 
+static void aio_fill_cq_error(struct kioctx *ctx, const struct iocb *iocb,
+			      long ret)
+{
+	struct io_event *ev;
+	unsigned tail;
+
+	/*
+	 * Only really need the lock for non-polled IO, but this is an error
+	 * so not worth checking. Just lock it so we know kernel access to
+	 * the CQ ring is serialized.
+	 */
+	spin_lock_irq(&ctx->completion_lock);
+	ev = aio_peek_cqring(ctx, &tail);
+	ev->obj = iocb->aio_data;
+	ev->data = 0;
+	ev->res = ret;
+	ev->res2 = 0;
+	aio_commit_cqring(ctx, tail);
+	spin_unlock_irq(&ctx->completion_lock);
+
+	/*
+	 * for thread offload, app could already be sleeping in io_ring_enter()
+	 * before we get to flag the error. wake them up, if needed.
+	 */
+	if (ctx->flags & (IOCTX_FLAG_SQTHREAD | IOCTX_FLAG_SQWQ))
+		if (waitqueue_active(&ctx->wait))
+			wake_up(&ctx->wait);
+}
+
+struct aio_io_work {
+	struct work_struct work;
+	struct kioctx *ctx;
+	struct iocb iocb;
+};
+
+/*
+ * sq thread only supports O_DIRECT or FIXEDBUFS IO
+ */
+static int aio_sq_thread(void *data)
+{
+	const struct iocb *iocbs[AIO_IOPOLL_BATCH];
+	struct aio_submit_state state;
+	struct kioctx *ctx = data;
+	struct aio_sq_offload *aso = &ctx->sq_offload;
+	struct mm_struct *cur_mm = NULL;
+	struct files_struct *old_files;
+	mm_segment_t old_fs;
+	DEFINE_WAIT(wait);
+
+	old_files = current->files;
+	current->files = aso->files;
+
+	old_fs = get_fs();
+	set_fs(USER_DS);
+
+	while (!kthread_should_stop()) {
+		struct aio_submit_state *statep = NULL;
+		const struct iocb *iocb;
+		bool mm_fault = false;
+		unsigned int nhead;
+		int ret, i, j;
+
+		iocb = aio_peek_sqring(ctx, &nhead);
+		if (!iocb) {
+			prepare_to_wait(&aso->wait, &wait, TASK_INTERRUPTIBLE);
+			iocb = aio_peek_sqring(ctx, &nhead);
+			if (!iocb) {
+				/*
+				 * Drop cur_mm before scheduler. We can't hold
+				 * it for long periods, and it would also
+				 * introduce a deadlock with kill_ioctx().
+				 */
+				if (cur_mm) {
+					unuse_mm(cur_mm);
+					mmput(cur_mm);
+					cur_mm = NULL;
+				}
+				schedule();
+			}
+			finish_wait(&aso->wait, &wait);
+			if (!iocb)
+				continue;
+		}
+
+		/* If ->mm is set, we're not doing FIXEDBUFS */
+		if (aso->mm) {
+			mm_fault = !mmget_not_zero(aso->mm);
+			if (!mm_fault) {
+				use_mm(aso->mm);
+				cur_mm = aso->mm;
+			}
+		}
+
+		i = 0;
+		do {
+			if (i == ARRAY_SIZE(iocbs))
+				break;
+			iocbs[i++] = iocb;
+			aio_commit_sqring(ctx, nhead);
+		} while ((iocb = aio_peek_sqring(ctx, &nhead)) != NULL);
+
+		if (i > AIO_PLUG_THRESHOLD) {
+			aio_submit_state_start(&state, ctx, i);
+			statep = &state;
+		}
+
+		for (j = 0; j < i; j++) {
+			if (unlikely(mm_fault))
+				ret = -EFAULT;
+			else
+				ret = __io_submit_one(ctx, iocbs[j], NULL, NULL,
+							false, !cur_mm, false);
+			if (!ret)
+				continue;
+
+			aio_fill_cq_error(ctx, iocbs[j], ret);
+		}
+
+		if (statep)
+			aio_submit_state_end(&state);
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
+static void aio_sq_wq_submit_work(struct work_struct *work)
+{
+	struct aio_io_work *aiw = container_of(work, struct aio_io_work, work);
+	struct kioctx *ctx = aiw->ctx;
+	struct aio_sq_offload *aso = &ctx->sq_offload;
+	mm_segment_t old_fs = get_fs();
+	struct files_struct *old_files;
+	int ret;
+
+	old_files = current->files;
+	current->files = aso->files;
+
+	if (aso->mm) {
+		if (!mmget_not_zero(aso->mm)) {
+			ret = -EFAULT;
+			goto err;
+		}
+		use_mm(aso->mm);
+	}
+
+	set_fs(USER_DS);
+
+	ret = __io_submit_one(ctx, &aiw->iocb, NULL, NULL, false, !aso->mm,
+				false);
+
+	set_fs(old_fs);
+	if (aso->mm) {
+		unuse_mm(aso->mm);
+		mmput(aso->mm);
+	}
+
+err:
+	if (ret)
+		aio_fill_cq_error(ctx, &aiw->iocb, ret);
+	current->files = old_files;
+	kfree(aiw);
+}
+
+/*
+ * If this is a read, try a cached inline read first. If the IO is in the
+ * page cache, we can satisfy it without blocking and without having to
+ * punt to a threaded execution. This is much faster, particularly for
+ * lower queue depth IO, and it's always a lot more efficient.
+ */
+static int aio_sq_try_inline(struct kioctx *ctx, struct aio_io_work *aiw)
+{
+	struct aio_sq_offload *aso = &ctx->sq_offload;
+	int ret;
+
+	if (aiw->iocb.aio_lio_opcode != IOCB_CMD_PREAD &&
+	    aiw->iocb.aio_lio_opcode != IOCB_CMD_PREADV)
+		return -EAGAIN;
+
+	ret = __io_submit_one(ctx, &aiw->iocb, NULL, NULL, false, !aso->mm,
+				true);
+
+	if (ret == -EAGAIN || ctx->submit_eagain) {
+		ctx->submit_eagain = 0;
+		return -EAGAIN;
+	}
+
+	/*
+	 * We're done - even if this was an error, return 0. The error will
+	 * be in the CQ ring for the application.
+	 */
+	kfree(aiw);
+	return 0;
+}
+
+static int aio_sq_wq_submit(struct kioctx *ctx, unsigned int to_submit)
+{
+	struct aio_io_work *work;
+	const struct iocb *iocb;
+	unsigned nhead;
+	int ret, queued;
+
+	ret = queued = 0;
+	while ((iocb = aio_peek_sqring(ctx, &nhead)) != NULL) {
+		work = kmalloc(sizeof(*work), GFP_KERNEL);
+		if (!work) {
+			ret = -ENOMEM;
+			break;
+		}
+		memcpy(&work->iocb, iocb, sizeof(*iocb));
+		aio_commit_sqring(ctx, nhead);
+		ret = aio_sq_try_inline(ctx, work);
+		if (ret == -EAGAIN) {
+			INIT_WORK(&work->work, aio_sq_wq_submit_work);
+			work->ctx = ctx;
+			queue_work(ctx->sq_offload.wq, &work->work);
+			ret = 0;
+		}
+		queued++;
+		if (queued == to_submit)
+			break;
+	}
+
+	return queued ? queued : ret;
+}
+
 static int __io_ring_enter(struct kioctx *ctx, unsigned int to_submit,
 			   unsigned int min_complete, unsigned int flags)
 {
 	int ret = 0;
 
 	if (flags & IORING_FLAG_SUBMIT) {
-		ret = aio_ring_submit(ctx, to_submit);
-		if (ret < 0)
-			return ret;
+		/*
+		 * Three options here:
+		 * 1) We have an sq thread, just wake it up to do submissions
+		 * 2) We have an sq wq, queue a work item for each iocb
+		 * 3) Submit directly
+		 */
+		if (to_submit && (ctx->flags & IOCTX_FLAG_SQTHREAD)) {
+			wake_up(&ctx->sq_offload.wait);
+			ret = to_submit;
+		} else if (to_submit && (ctx->flags & IOCTX_FLAG_SQWQ)) {
+			ret = aio_sq_wq_submit(ctx, to_submit);
+		} else {
+			ret = aio_ring_submit(ctx, to_submit);
+			if (ret < 0)
+				return ret;
+		}
 	}
 	if (flags & IORING_FLAG_GETEVENTS) {
 		unsigned int nr_events = 0;
diff --git a/include/uapi/linux/aio_abi.h b/include/uapi/linux/aio_abi.h
index 9fb7d0ec868f..500b37feeaa8 100644
--- a/include/uapi/linux/aio_abi.h
+++ b/include/uapi/linux/aio_abi.h
@@ -112,12 +112,15 @@ struct iocb {
 #define IOCTX_FLAG_IOPOLL	(1 << 1)	/* io_context is polled */
 #define IOCTX_FLAG_FIXEDBUFS	(1 << 2)	/* IO buffers are fixed */
 #define IOCTX_FLAG_SCQRING	(1 << 3)	/* Use SQ/CQ rings */
+#define IOCTX_FLAG_SQTHREAD	(1 << 4)	/* Use SQ thread */
+#define IOCTX_FLAG_SQWQ		(1 << 5)	/* Use SQ workqueue */
 
 struct aio_iocb_ring {
 	union {
 		struct {
 			u32 head, tail;
 			u32 nr_events;
+			u32 sq_thread_cpu;
 		};
 		struct iocb pad_iocb;
 	};
-- 
2.17.1

