Return-Path: <SRS0=8pZC=OW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_MIXED_ES,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C39C65BAE
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 17:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3E8520879
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 17:57:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="gAvGyp8+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3E8520879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729740AbeLMR5c (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Dec 2018 12:57:32 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:38337 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729731AbeLMR5c (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Dec 2018 12:57:32 -0500
Received: by mail-it1-f195.google.com with SMTP id h65so5188577ith.3
        for <linux-block@vger.kernel.org>; Thu, 13 Dec 2018 09:57:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ocF80/S/hvZ1Z6Xh69qWhSFivRYok4YbmAlvmzrC55A=;
        b=gAvGyp8+DO1W/pzVQnWCDhF3NQVyCulRgZXGRNpReyxj7E+IHZ4h5x/T5Tf7rJC68W
         3aQTBAyIEq7cBlER5qS6gXM31DMDB3Rawp2NACgw0KmUgHcHHoqd008BNtMT+263SA5Q
         mWV/sa/Lbi5DbZfJeRFXTK57laMAkOM1uR4a2W9pzdD9jacJsNHaudimzOkKZjFqyTnR
         bIH7mBZOxyRRPkwmTQNpqHs6bRC3Wqjvfmd3r5KZz8frew74ddncgTbzyOatHhJQmOIi
         QZv3kWUBKV+vHu77nCzRuQxy+szAGjlQKJRO69IpC2/Pz8VskZ9aKrZ0QvdkONuR1PAQ
         1+jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ocF80/S/hvZ1Z6Xh69qWhSFivRYok4YbmAlvmzrC55A=;
        b=LMPv+S3L5Ei4lWUYixiRYSfR2d6FeENB3Ll7HuAGu+pLJyqydVoz7fjOvAVO+KKl9o
         kDPHxAYjxAPSl1HQ/fM6izsqmsAuVyhz93Q9Ehf+MV70f+3FlkBBLigDa+/H6a+flOSl
         xblnaIxJWul+5e+Rr0nQmGpqnwtcmAg4tNtVjbEURI/9CbrZMBl+QEG3JVaQtMrcF7bo
         BxN1z5ItSqQNJycECfHRmv0L8Gl4Joe8Ce9d3sfIRqCDC2DT/sSOQDcWbg6lTyYjcFG3
         WS27/FhbtlTsyKapF4XxxExoxutKts7LPYX0o1iQnq2M75f5Xst5oyFfG2e6U1hbDIbZ
         ffuQ==
X-Gm-Message-State: AA+aEWYTzbLzdbcJnB5Dot/1JxvJ3FyyGSGUNZCQ3uGP46y+KnSKQvmi
        LIFNXiBEzYXIRJZVgNbtfR5MeN+NCDGBuw==
X-Google-Smtp-Source: AFSGD/Wm6QE+Yf/HOv+p9JZaEg4jOAiIUcqQvLtbGNXl2auVeWY+EnWoAY/1/kJR+U6R/HzUtKw+dA==
X-Received: by 2002:a05:660c:b12:: with SMTP id f18mr302701itk.118.1544723849754;
        Thu, 13 Dec 2018 09:57:29 -0800 (PST)
Received: from x1.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id k6sm1022261ios.69.2018.12.13.09.57.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Dec 2018 09:57:28 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org
Cc:     hch@lst.de, jmoyer@redhat.com, clm@fb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 21/26] aio: add support for submission/completion rings
Date:   Thu, 13 Dec 2018 10:56:40 -0700
Message-Id: <20181213175645.22181-22-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181213175645.22181-1-axboe@kernel.dk>
References: <20181213175645.22181-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Experimental support for submitting and completing IO through rings
shared between the application and kernel.

The submission rings are struct iocb, like we would submit through
io_submit(), and the completion rings are struct io_event, like we
would pass in (and copy back) from io_getevents().

A new system call is added for this, io_ring_enter(). This system
call submits IO that is queued in the SQ ring, and/or completes IO
and stores the results in the CQ ring.

This could be augmented with a kernel thread that does the submission
and polling, then the application would never have to enter the
kernel to do IO.

Sample application: http://git.kernel.dk/cgit/fio/plain/t/aio-ring.c

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 arch/x86/entry/syscalls/syscall_64.tbl |   1 +
 fs/aio.c                               | 484 +++++++++++++++++++++++--
 include/linux/syscalls.h               |   4 +-
 include/uapi/linux/aio_abi.h           |  29 ++
 kernel/sys_ni.c                        |   1 +
 5 files changed, 493 insertions(+), 26 deletions(-)

diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index 67c357225fb0..55a26700a637 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -344,6 +344,7 @@
 333	common	io_pgetevents		__x64_sys_io_pgetevents
 334	common	rseq			__x64_sys_rseq
 335	common	io_setup2		__x64_sys_io_setup2
+336	common	io_ring_enter		__x64_sys_io_ring_enter
 
 #
 # x32-specific system call numbers start at 512 to avoid cache impact
diff --git a/fs/aio.c b/fs/aio.c
index fda9b1c53f3d..a5ec349670bc 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -92,6 +92,18 @@ struct ctx_rq_wait {
 	atomic_t count;
 };
 
+struct aio_mapped_range {
+	struct page **pages;
+	long nr_pages;
+};
+
+struct aio_iocb_ring {
+	struct aio_mapped_range ring_range;	/* maps user SQ ring */
+	struct aio_sq_ring *ring;
+
+	struct aio_mapped_range iocb_range;	/* maps user iocbs */
+};
+
 struct kioctx {
 	struct percpu_ref	users;
 	atomic_t		dead;
@@ -127,6 +139,11 @@ struct kioctx {
 	struct page		**ring_pages;
 	long			nr_pages;
 
+	/* if used, completion and submission rings */
+	struct aio_iocb_ring	sq_ring;
+	struct aio_mapped_range cq_ring;
+	int			cq_ring_overflow;
+
 	struct rcu_work		free_rwork;	/* see free_ioctx() */
 
 	/*
@@ -280,6 +297,13 @@ static struct vfsmount *aio_mnt;
 static const struct file_operations aio_ring_fops;
 static const struct address_space_operations aio_ctx_aops;
 
+static const unsigned int array_page_shift =
+				ilog2(PAGE_SIZE / sizeof(u32));
+static const unsigned int iocb_page_shift =
+				ilog2(PAGE_SIZE / sizeof(struct iocb));
+static const unsigned int event_page_shift =
+				ilog2(PAGE_SIZE / sizeof(struct io_event));
+
 /*
  * We rely on block level unplugs to flush pending requests, if we schedule
  */
@@ -289,6 +313,7 @@ static const bool aio_use_state_req_list = true;
 static const bool aio_use_state_req_list = false;
 #endif
 
+static void aio_scqring_unmap(struct kioctx *);
 static void aio_iopoll_reap_events(struct kioctx *);
 
 static struct file *aio_private_file(struct kioctx *ctx, loff_t nr_pages)
@@ -519,6 +544,12 @@ static const struct address_space_operations aio_ctx_aops = {
 #endif
 };
 
+/* Polled IO or SQ/CQ rings don't use the old ring */
+static bool aio_ctx_old_ring(struct kioctx *ctx)
+{
+	return !(ctx->flags & (IOCTX_FLAG_IOPOLL | IOCTX_FLAG_SCQRING));
+}
+
 static int aio_setup_ring(struct kioctx *ctx, unsigned int nr_events)
 {
 	struct aio_ring *ring;
@@ -533,7 +564,7 @@ static int aio_setup_ring(struct kioctx *ctx, unsigned int nr_events)
 	 * IO polling doesn't require any io event entries
 	 */
 	size = sizeof(struct aio_ring);
-	if (!(ctx->flags & IOCTX_FLAG_IOPOLL)) {
+	if (aio_ctx_old_ring(ctx)) {
 		nr_events += 2;	/* 1 is required, 2 for good luck */
 		size += sizeof(struct io_event) * nr_events;
 	}
@@ -625,7 +656,7 @@ static int aio_setup_ring(struct kioctx *ctx, unsigned int nr_events)
  */
 static bool aio_ctx_supports_cancel(struct kioctx *ctx)
 {
-	return (ctx->flags & IOCTX_FLAG_IOPOLL) == 0;
+	return (ctx->flags & (IOCTX_FLAG_IOPOLL | IOCTX_FLAG_SCQRING)) == 0;
 }
 
 #define AIO_EVENTS_PER_PAGE	(PAGE_SIZE / sizeof(struct io_event))
@@ -661,6 +692,7 @@ static void free_ioctx(struct work_struct *work)
 					  free_rwork);
 	pr_debug("freeing %p\n", ctx);
 
+	aio_scqring_unmap(ctx);
 	aio_free_ring(ctx);
 	free_percpu(ctx->cpu);
 	percpu_ref_exit(&ctx->reqs);
@@ -1205,6 +1237,39 @@ static void aio_fill_event(struct io_event *ev, struct aio_kiocb *iocb,
 	ev->res2 = res2;
 }
 
+static void aio_commit_cqring(struct kioctx *ctx, unsigned next_tail)
+{
+	struct aio_cq_ring *ring = page_address(ctx->cq_ring.pages[0]);
+
+	if (next_tail != ring->tail) {
+		ring->tail = next_tail;
+		smp_wmb();
+	}
+}
+
+static struct io_event *aio_peek_cqring(struct kioctx *ctx, unsigned *ntail)
+{
+	struct aio_cq_ring *ring;
+	struct io_event *ev;
+	unsigned tail;
+
+	ring = page_address(ctx->cq_ring.pages[0]);
+
+	smp_rmb();
+	tail = READ_ONCE(ring->tail);
+	*ntail = tail + 1;
+	if (*ntail == ring->nr_events)
+		*ntail = 0;
+	if (*ntail == READ_ONCE(ring->head))
+		return NULL;
+
+	/* io_event array starts offset one into the mapped range */
+	tail++;
+	ev = page_address(ctx->cq_ring.pages[tail >> event_page_shift]);
+	tail &= ((1 << event_page_shift) - 1);
+	return ev + tail;
+}
+
 static void aio_ring_complete(struct kioctx *ctx, struct aio_kiocb *iocb,
 			      long res, long res2)
 {
@@ -1266,7 +1331,36 @@ static void aio_complete(struct aio_kiocb *iocb, long res, long res2)
 {
 	struct kioctx *ctx = iocb->ki_ctx;
 
-	aio_ring_complete(ctx, iocb, res, res2);
+	if (ctx->flags & IOCTX_FLAG_SCQRING) {
+		unsigned long flags;
+		struct io_event *ev;
+		unsigned int tail;
+
+		/*
+		 * If we can't get a cq entry, userspace overflowed the
+		 * submission (by quite a lot). Flag it as an overflow
+		 * condition, and next io_ring_enter(2) call will return
+		 * -EOVERFLOW.
+		 */
+		spin_lock_irqsave(&ctx->completion_lock, flags);
+		ev = aio_peek_cqring(ctx, &tail);
+		if (ev) {
+			aio_fill_event(ev, iocb, res, res2);
+			aio_commit_cqring(ctx, tail);
+		} else
+			ctx->cq_ring_overflow = 1;
+		spin_unlock_irqrestore(&ctx->completion_lock, flags);
+	} else {
+		aio_ring_complete(ctx, iocb, res, res2);
+
+		/*
+		 * We have to order our ring_info tail store above and test
+		 * of the wait list below outside the wait lock.  This is
+		 * like in wake_up_bit() where clearing a bit has to be
+		 * ordered with the unlocked test.
+		 */
+		smp_mb();
+	}
 
 	/*
 	 * Check if the user asked us to deliver the result through an
@@ -1278,14 +1372,6 @@ static void aio_complete(struct aio_kiocb *iocb, long res, long res2)
 		eventfd_ctx_put(iocb->ki_eventfd);
 	}
 
-	/*
-	 * We have to order our ring_info tail store above and test
-	 * of the wait list below outside the wait lock.  This is
-	 * like in wake_up_bit() where clearing a bit has to be
-	 * ordered with the unlocked test.
-	 */
-	smp_mb();
-
 	if (waitqueue_active(&ctx->wait))
 		wake_up(&ctx->wait);
 	iocb_put(iocb);
@@ -1408,6 +1494,9 @@ static long aio_iopoll_reap(struct kioctx *ctx, struct io_event __user *evs,
 		return 0;
 
 	list_for_each_entry_safe(iocb, n, &ctx->poll_completing, ki_list) {
+		struct io_event *ev = NULL;
+		unsigned int next_tail;
+
 		if (*nr_events == max)
 			break;
 		if (!test_bit(KIOCB_F_POLL_COMPLETED, &iocb->ki_flags))
@@ -1415,6 +1504,14 @@ static long aio_iopoll_reap(struct kioctx *ctx, struct io_event __user *evs,
 		if (to_free == AIO_IOPOLL_BATCH)
 			iocb_put_many(ctx, iocbs, &to_free);
 
+		/* Will only happen if the application over-commits */
+		ret = -EAGAIN;
+		if (ctx->flags & IOCTX_FLAG_SCQRING) {
+			ev = aio_peek_cqring(ctx, &next_tail);
+			if (!ev)
+				break;
+		}
+
 		list_del(&iocb->ki_list);
 		iocbs[to_free++] = iocb;
 
@@ -1433,8 +1530,11 @@ static long aio_iopoll_reap(struct kioctx *ctx, struct io_event __user *evs,
 			file_count = 1;
 		}
 
-		if (evs && copy_to_user(evs + *nr_events, &iocb->ki_ev,
-		    sizeof(iocb->ki_ev))) {
+		if (ev) {
+			memcpy(ev, &iocb->ki_ev, sizeof(*ev));
+			aio_commit_cqring(ctx, next_tail);
+		} else if (evs && copy_to_user(evs + *nr_events, &iocb->ki_ev,
+				sizeof(iocb->ki_ev))) {
 			ret = -EFAULT;
 			break;
 		}
@@ -1615,24 +1715,139 @@ static long read_events(struct kioctx *ctx, long min_nr, long nr,
 	return ret;
 }
 
+static void aio_unmap_range(struct aio_mapped_range *range)
+{
+	int i;
+
+	if (!range->nr_pages)
+		return;
+
+	for (i = 0; i < range->nr_pages; i++)
+		put_page(range->pages[i]);
+
+	kfree(range->pages);
+	range->pages = NULL;
+	range->nr_pages = 0;
+}
+
+static int aio_map_range(struct aio_mapped_range *range, void __user *uaddr,
+			 size_t size, int gup_flags)
+{
+	int nr_pages, ret;
+
+	if ((unsigned long) uaddr & ~PAGE_MASK)
+		return -EINVAL;
+
+	nr_pages = (size + PAGE_SIZE - 1) >> PAGE_SHIFT;
+
+	range->pages = kzalloc(nr_pages * sizeof(struct page *), GFP_KERNEL);
+	if (!range->pages)
+		return -ENOMEM;
+
+	down_write(&current->mm->mmap_sem);
+	ret = get_user_pages((unsigned long) uaddr, nr_pages, gup_flags,
+				range->pages, NULL);
+	up_write(&current->mm->mmap_sem);
+
+	if (ret < nr_pages) {
+		kfree(range->pages);
+		return -ENOMEM;
+	}
+
+	range->nr_pages = nr_pages;
+	return 0;
+}
+
+static void aio_scqring_unmap(struct kioctx *ctx)
+{
+	aio_unmap_range(&ctx->sq_ring.ring_range);
+	aio_unmap_range(&ctx->sq_ring.iocb_range);
+	aio_unmap_range(&ctx->cq_ring);
+}
+
+static int aio_scqring_map(struct kioctx *ctx,
+			   struct aio_sq_ring __user *sq_ring,
+			   struct aio_cq_ring __user *cq_ring)
+{
+	int ret, sq_ring_size, cq_ring_size;
+	struct aio_cq_ring *kcq_ring;
+	void __user *uptr;
+	size_t size;
+
+	/* Two is the minimum size we can support. */
+	if (ctx->max_reqs < 2)
+		return -EINVAL;
+
+	/*
+	 * The CQ ring size is QD + 1, so we don't have to track full condition
+	 * for head == tail. The SQ ring we make twice that in size, to make
+	 * room for having more inflight than the QD.
+	 */
+	sq_ring_size = ctx->max_reqs;
+	cq_ring_size = 2 * ctx->max_reqs;
+
+	/* Map SQ ring and iocbs */
+	size = sizeof(struct aio_sq_ring) + sq_ring_size * sizeof(u32);
+	ret = aio_map_range(&ctx->sq_ring.ring_range, sq_ring, size, FOLL_WRITE);
+	if (ret)
+		return ret;
+
+	ctx->sq_ring.ring = page_address(ctx->sq_ring.ring_range.pages[0]);
+	if (ctx->sq_ring.ring->nr_events < sq_ring_size) {
+		ret = -EFAULT;
+		goto err;
+	}
+	ctx->sq_ring.ring->nr_events = sq_ring_size;
+	ctx->sq_ring.ring->head = ctx->sq_ring.ring->tail = 0;
+
+	size = sizeof(struct iocb) * sq_ring_size;
+	uptr = (void __user *) (unsigned long) ctx->sq_ring.ring->iocbs;
+	ret = aio_map_range(&ctx->sq_ring.iocb_range, uptr, size, 0);
+	if (ret)
+		goto err;
+
+	/* Map CQ ring and io_events */
+	size = sizeof(struct aio_cq_ring) +
+			cq_ring_size * sizeof(struct io_event);
+	ret = aio_map_range(&ctx->cq_ring, cq_ring, size, FOLL_WRITE);
+	if (ret)
+		goto err;
+
+	kcq_ring = page_address(ctx->cq_ring.pages[0]);
+	if (kcq_ring->nr_events < cq_ring_size) {
+		ret = -EFAULT;
+		goto err;
+	}
+	kcq_ring->nr_events = cq_ring_size;
+	kcq_ring->head = kcq_ring->tail = 0;
+
+err:
+	if (ret) {
+		aio_unmap_range(&ctx->sq_ring.ring_range);
+		aio_unmap_range(&ctx->sq_ring.iocb_range);
+		aio_unmap_range(&ctx->cq_ring);
+	}
+	return ret;
+}
+
 /* sys_io_setup2:
  *	Like sys_io_setup(), except that it takes a set of flags
  *	(IOCTX_FLAG_*), and some pointers to user structures:
  *
- *	*user1 - reserved for future use
+ *	*sq_ring - pointer to the userspace SQ ring, if used.
  *
- *	*user2 - reserved for future use.
+ *	*cq_ring - pointer to the userspace CQ ring, if used.
  */
-SYSCALL_DEFINE5(io_setup2, u32, nr_events, u32, flags, void __user *, user1,
-		void __user *, user2, aio_context_t __user *, ctxp)
+SYSCALL_DEFINE5(io_setup2, u32, nr_events, u32, flags,
+		struct aio_sq_ring __user *, sq_ring,
+		struct aio_cq_ring __user *, cq_ring,
+		aio_context_t __user *, ctxp)
 {
 	struct kioctx *ioctx;
 	unsigned long ctx;
 	long ret;
 
-	if (user1 || user2)
-		return -EINVAL;
-	if (flags & ~IOCTX_FLAG_IOPOLL)
+	if (flags & ~(IOCTX_FLAG_IOPOLL | IOCTX_FLAG_SCQRING))
 		return -EINVAL;
 
 	ret = get_user(ctx, ctxp);
@@ -1644,9 +1859,17 @@ SYSCALL_DEFINE5(io_setup2, u32, nr_events, u32, flags, void __user *, user1,
 	if (IS_ERR(ioctx))
 		goto out;
 
+	if (flags & IOCTX_FLAG_SCQRING) {
+		ret = aio_scqring_map(ioctx, sq_ring, cq_ring);
+		if (ret)
+			goto err;
+	}
+
 	ret = put_user(ioctx->user_id, ctxp);
-	if (ret)
+	if (ret) {
+err:
 		kill_ioctx(current->mm, ioctx, NULL);
+	}
 	percpu_ref_put(&ioctx->users);
 out:
 	return ret;
@@ -2323,8 +2546,7 @@ static int __io_submit_one(struct kioctx *ctx, const struct iocb *iocb,
 		return -EINVAL;
 	}
 
-	/* Poll IO doesn't need ring reservations */
-	if (!(ctx->flags & IOCTX_FLAG_IOPOLL) && !get_reqs_available(ctx))
+	if (aio_ctx_old_ring(ctx) && !get_reqs_available(ctx))
 		return -EAGAIN;
 
 	ret = -EAGAIN;
@@ -2413,7 +2635,7 @@ static int __io_submit_one(struct kioctx *ctx, const struct iocb *iocb,
 		eventfd_ctx_put(req->ki_eventfd);
 	iocb_put(req);
 out_put_reqs_available:
-	if (!(ctx->flags & IOCTX_FLAG_IOPOLL))
+	if (aio_ctx_old_ring(ctx))
 		put_reqs_available(ctx, 1);
 	return ret;
 }
@@ -2473,6 +2695,211 @@ static void aio_submit_state_start(struct aio_submit_state *state,
 #endif
 }
 
+static const struct iocb *aio_iocb_from_index(struct kioctx *ctx, unsigned idx)
+{
+	struct aio_mapped_range *range = &ctx->sq_ring.iocb_range;
+	const struct iocb *iocb;
+
+	iocb = page_address(range->pages[idx >> iocb_page_shift]);
+	idx &= ((1 << iocb_page_shift) - 1);
+	return iocb + idx;
+}
+
+static void aio_commit_sqring(struct kioctx *ctx, unsigned next_head)
+{
+	struct aio_sq_ring *ring = ctx->sq_ring.ring;
+
+	if (ring->head != next_head) {
+		ring->head = next_head;
+		smp_wmb();
+	}
+}
+
+static const struct iocb *aio_peek_sqring(struct kioctx *ctx, unsigned *nhead)
+{
+	struct aio_mapped_range *range = &ctx->sq_ring.ring_range;
+	struct aio_sq_ring *ring = ctx->sq_ring.ring;
+	unsigned head, index;
+	u32 *array;
+
+	smp_rmb();
+	head = READ_ONCE(ring->head);
+	if (head == READ_ONCE(ring->tail))
+		return NULL;
+
+	*nhead = head + 1;
+	if (*nhead == ring->nr_events)
+		*nhead = 0;
+
+	/*
+	 * No guarantee the array is in the first page, so we can't just
+	 * index ring->array. Find the map and offset from the head.
+	 */
+	head += offsetof(struct aio_sq_ring, array) >> 2;
+	array = page_address(range->pages[head >> array_page_shift]);
+	head &= ((1 << array_page_shift) - 1);
+	index = array[head];
+
+	if (index < ring->nr_events)
+		return aio_iocb_from_index(ctx, index);
+
+	/* drop invalid entries */
+	aio_commit_sqring(ctx, *nhead);
+	return NULL;
+}
+
+static int aio_ring_submit(struct kioctx *ctx, unsigned int to_submit)
+{
+	struct aio_submit_state state, *statep = NULL;
+	int i, ret = 0, submit = 0;
+
+	if (to_submit > AIO_PLUG_THRESHOLD) {
+		aio_submit_state_start(&state, ctx, to_submit);
+		statep = &state;
+	}
+
+	for (i = 0; i < to_submit; i++) {
+		const struct iocb *iocb;
+		unsigned int next_head;
+
+		iocb = aio_peek_sqring(ctx, &next_head);
+		if (!iocb)
+			break;
+
+		ret = __io_submit_one(ctx, iocb, NULL, statep, false);
+		if (ret)
+			break;
+
+		submit++;
+		aio_commit_sqring(ctx, next_head);
+	}
+
+	if (statep)
+		aio_submit_state_end(statep);
+
+	return submit ? submit : ret;
+}
+
+/*
+ * Wait until events become available, if we don't already have some. The
+ * application must reap them itself, as they reside on the shared cq ring.
+ */
+static int aio_cqring_wait(struct kioctx *ctx, int min_events)
+{
+	struct aio_cq_ring *ring = page_address(ctx->cq_ring.pages[0]);
+	DEFINE_WAIT(wait);
+	int ret = 0;
+
+	smp_rmb();
+	if (ring->head != ring->tail)
+		return 0;
+	if (!min_events)
+		return 0;
+
+	do {
+		prepare_to_wait(&ctx->wait, &wait, TASK_INTERRUPTIBLE);
+
+		ret = 0;
+		smp_rmb();
+		if (ring->head != ring->tail)
+			break;
+
+		schedule();
+
+		ret = -EINVAL;
+		if (atomic_read(&ctx->dead))
+			break;
+		ret = -EINTR;
+		if (signal_pending(current))
+			break;
+	} while (1);
+
+	finish_wait(&ctx->wait, &wait);
+	return ret;
+}
+
+static int __io_ring_enter(struct kioctx *ctx, unsigned int to_submit,
+			   unsigned int min_complete, unsigned int flags)
+{
+	int ret = 0;
+
+	if (flags & IORING_FLAG_SUBMIT) {
+		ret = aio_ring_submit(ctx, to_submit);
+		if (ret < 0)
+			return ret;
+	}
+	if (flags & IORING_FLAG_GETEVENTS) {
+		unsigned int nr_events = 0;
+		int get_ret;
+
+		if (!ret && to_submit)
+			min_complete = 0;
+
+		if (ctx->flags & IOCTX_FLAG_IOPOLL)
+			get_ret = __aio_iopoll_check(ctx, NULL, &nr_events,
+							min_complete, -1U);
+		else
+			get_ret = aio_cqring_wait(ctx, min_complete);
+
+		if (get_ret < 0 && !ret)
+			ret = get_ret;
+	}
+
+	return ret;
+}
+
+/* sys_io_ring_enter:
+ *	Alternative way to both submit and complete IO, instead of using
+ *	io_submit(2) and io_getevents(2). Requires the use of the SQ/CQ
+ *	ring interface, hence the io_context must be setup with
+ *	io_setup2() and IOCTX_FLAG_SCQRING must be specified (and the
+ *	sq_ring/cq_ring passed in).
+ *
+ *	Returns the number of IOs submitted, if IORING_FLAG_SUBMIT
+ *	is used, otherwise returns 0 for IORING_FLAG_GETEVENTS success,
+ *	but not the number of events, as those will have to be found
+ *	by the application by reading the CQ ring anyway.
+ *
+ *	Apart from that, the error returns are much like io_submit()
+ *	and io_getevents(), since a lot of the same error conditions
+ *	are shared.
+ */
+SYSCALL_DEFINE4(io_ring_enter, aio_context_t, ctx_id, u32, to_submit,
+		u32, min_complete, u32, flags)
+{
+	struct kioctx *ctx;
+	long ret;
+
+	ctx = lookup_ioctx(ctx_id);
+	if (!ctx) {
+		pr_debug("EINVAL: invalid context id\n");
+		return -EINVAL;
+	}
+
+	ret = -EBUSY;
+	if (!mutex_trylock(&ctx->getevents_lock))
+		goto err;
+
+	ret = -EOVERFLOW;
+	if (ctx->cq_ring_overflow) {
+		ctx->cq_ring_overflow = 0;
+		goto err_unlock;
+	}
+
+	ret = -EINVAL;
+	if (unlikely(atomic_read(&ctx->dead)))
+		goto err_unlock;
+
+	if (ctx->flags & IOCTX_FLAG_SCQRING)
+		ret = __io_ring_enter(ctx, to_submit, min_complete, flags);
+
+err_unlock:
+	mutex_unlock(&ctx->getevents_lock);
+err:
+	percpu_ref_put(&ctx->users);
+	return ret;
+}
+
 /* sys_io_submit:
  *	Queue the nr iocbs pointed to by iocbpp for processing.  Returns
  *	the number of iocbs queued.  May return -EINVAL if the aio_context
@@ -2502,6 +2929,10 @@ SYSCALL_DEFINE3(io_submit, aio_context_t, ctx_id, long, nr,
 		return -EINVAL;
 	}
 
+	/* SCQRING must use io_ring_enter() */
+	if (ctx->flags & IOCTX_FLAG_SCQRING)
+		return -EINVAL;
+
 	if (nr > ctx->nr_events)
 		nr = ctx->nr_events;
 
@@ -2653,7 +3084,10 @@ static long do_io_getevents(aio_context_t ctx_id,
 	long ret = -EINVAL;
 
 	if (likely(ioctx)) {
-		if (likely(min_nr <= nr && min_nr >= 0)) {
+		/* SCQRING must use io_ring_enter() */
+		if (ioctx->flags & IOCTX_FLAG_SCQRING)
+			ret = -EINVAL;
+		else if (min_nr <= nr && min_nr >= 0) {
 			if (ioctx->flags & IOCTX_FLAG_IOPOLL)
 				ret = aio_iopoll_check(ioctx, min_nr, nr, events);
 			else
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 67b7f03aa9fc..e7bd364410c3 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -287,8 +287,10 @@ static inline void addr_limit_user_check(void)
  */
 #ifndef CONFIG_ARCH_HAS_SYSCALL_WRAPPER
 asmlinkage long sys_io_setup(unsigned nr_reqs, aio_context_t __user *ctx);
-asmlinkage long sys_io_setup2(unsigned, unsigned, void __user *, void __user *,
+asmlinkage long sys_io_setup2(unsigned, unsigned, struct aio_cq_ring __user *,
+				struct aio_sq_ring __user *,
 				aio_context_t __user *);
+asmlinkage long sys_io_ring_enter(aio_context_t, unsigned, unsigned, unsigned);
 asmlinkage long sys_io_destroy(aio_context_t ctx);
 asmlinkage long sys_io_submit(aio_context_t, long,
 			struct iocb __user * __user *);
diff --git a/include/uapi/linux/aio_abi.h b/include/uapi/linux/aio_abi.h
index a6829bae9ada..5d3ada40ce15 100644
--- a/include/uapi/linux/aio_abi.h
+++ b/include/uapi/linux/aio_abi.h
@@ -109,6 +109,35 @@ struct iocb {
 }; /* 64 bytes */
 
 #define IOCTX_FLAG_IOPOLL	(1 << 0)	/* io_context is polled */
+#define IOCTX_FLAG_SCQRING	(1 << 1)	/* Use SQ/CQ rings */
+
+struct aio_sq_ring {
+	union {
+		struct {
+			u32 head;	/* kernel consumer head */
+			u32 tail;	/* app producer tail */
+			u32 nr_events;	/* max events in ring */
+			u64 iocbs;	/* setup pointer to app iocbs */
+		};
+		u32 pad[16];
+	};
+	u32 array[0];			/* actual ring, index to iocbs */
+};
+
+struct aio_cq_ring {
+	union {
+		struct {
+			u32 head;	/* app consumer head */
+			u32 tail;	/* kernel producer tail */
+			u32 nr_events;	/* max events in ring */
+		};
+		struct io_event pad;
+	};
+	struct io_event events[0];	/* ring, array of io_events */
+};
+
+#define IORING_FLAG_SUBMIT	(1 << 0)
+#define IORING_FLAG_GETEVENTS	(1 << 1)
 
 #undef IFBIG
 #undef IFLITTLE
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index 17c8b4393669..a32b7ea93838 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -38,6 +38,7 @@ asmlinkage long sys_ni_syscall(void)
 
 COND_SYSCALL(io_setup);
 COND_SYSCALL(io_setup2);
+COND_SYSCALL(io_ring_enter);
 COND_SYSCALL_COMPAT(io_setup);
 COND_SYSCALL(io_destroy);
 COND_SYSCALL(io_submit);
-- 
2.17.1

