Return-Path: <SRS0=IV7O=OQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_MED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 694EBC64EB1
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 22:21:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C1F12083D
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 22:21:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="ynuxm8Pw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C1F12083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726084AbeLGWVO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Dec 2018 17:21:14 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40214 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbeLGWVO (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Dec 2018 17:21:14 -0500
Received: by mail-pl1-f194.google.com with SMTP id u18so2424634plq.7
        for <linux-block@vger.kernel.org>; Fri, 07 Dec 2018 14:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+ZiQL0vyYjDxbHqXAWxOWqZqWxNuKSk469GJ26BVEiQ=;
        b=ynuxm8PwdnLoS39tJjZdUcyQ4olEalH4Dtf8f789LQ3uI3DTGFdtkGk59pS1gx+V1G
         6oP0AaeTLeoQgg1LCpFy/lkR59rSadjd7/wOc7ojwD4EukjspPV8Br6ctvkXcKpIuY8J
         HKiqPaDTIsQYP4VfhFar7Tq1IOgKx1rug5qJlcDtTQcX4LtKZkBAIJhuy+kG8wEqqRqv
         d1KCV/xpnojTUWEzJZFy3p6iLyHssEYARflCNWZ1/9JZQYuKjmIEKRjqVlAIwPeYCUnH
         UM9VbPhkO6EslAreeqOZUitKN0/p0ra20iBi2TyZ4j8/l8UCt+nNZxFMIG23gWYAaoqT
         183A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+ZiQL0vyYjDxbHqXAWxOWqZqWxNuKSk469GJ26BVEiQ=;
        b=sn54iNaaTJkBY9GArJAyNsaUCSdZ97HtRdrLZxjQ47vmpUbsOvNihOLlH2lyX+Q560
         LLSneVea3bTJWm6WQUDedeR6/U5GwQ5/gcfYGE+NbrPThAIBGre4MX3ThyMGMMeaLB0D
         PPRmVsfrXs26BD+xF8l54JvKkNXigZegnwXFkimBZm+XTuVrZauZ/LdL9l6/BRmUBVjH
         nHVJpV2dr77MTz8jHRolH3ZeNquIAsty7BbzHKXovKBYkYzrPtv8aZ+9E4VNhkqBQwZz
         l5/rO5s2Vzcl97j6EFAxC1SfRIBLlmLRZoNwtx8HGqA4t0cgu+13QxwXUqW+iCbLTPlx
         HbKw==
X-Gm-Message-State: AA+aEWbOSo1oUU3Qxlb2FYXP3NCCp+07cG2nVHSOa5p+391mkXVnJWtW
        qeDweSJZpNSfLaJsthnmQPvaBQ/KxaU=
X-Google-Smtp-Source: AFSGD/VqgpiCSRbLwWk7pB+jKO1YaVdQ6Xfn7pOLpZDHGJgV4BVAhg8bjNRI7FaAMathomPLEDPkmQ==
X-Received: by 2002:a17:902:28e9:: with SMTP id f96mr3818695plb.169.1544221272486;
        Fri, 07 Dec 2018 14:21:12 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id e9sm5282511pff.5.2018.12.07.14.21.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 14:21:11 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org
Cc:     hch@lst.de, jmoyer@redhat.com, clm@fb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 26/26] aio: add support for submission/completion rings
Date:   Fri,  7 Dec 2018 15:20:16 -0700
Message-Id: <20181207222016.29387-27-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181207222016.29387-1-axboe@kernel.dk>
References: <20181207222016.29387-1-axboe@kernel.dk>
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

Sample application: http://brick.kernel.dk/snaps/aio-ring.c

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 arch/x86/entry/syscalls/syscall_64.tbl |   1 +
 fs/aio.c                               | 435 +++++++++++++++++++++++--
 include/linux/syscalls.h               |   4 +-
 include/uapi/linux/aio_abi.h           |  26 ++
 kernel/sys_ni.c                        |   1 +
 5 files changed, 433 insertions(+), 34 deletions(-)

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
index de48faeab0fd..b00c9fb9fa35 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -142,6 +142,11 @@ struct kioctx {
 
 	struct aio_mapped_range	iocb_range;
 
+	/* if used, completion and submission rings */
+	struct aio_mapped_range	sq_ring;
+	struct aio_mapped_range	cq_ring;
+	int			cq_ring_overflow;
+
 	struct rcu_work		free_rwork;	/* see free_ioctx() */
 
 	/*
@@ -297,6 +302,8 @@ static const struct address_space_operations aio_ctx_aops;
 
 static const unsigned int iocb_page_shift =
 				ilog2(PAGE_SIZE / sizeof(struct iocb));
+static const unsigned int event_page_shift =
+				ilog2(PAGE_SIZE / sizeof(struct io_event));
 
 /*
  * We rely on block level unplugs to flush pending requests, if we schedule
@@ -307,6 +314,7 @@ static const bool aio_use_state_req_list = true;
 static const bool aio_use_state_req_list = false;
 #endif
 
+static void aio_scqring_unmap(struct kioctx *);
 static void aio_useriocb_unmap(struct kioctx *);
 static void aio_iopoll_reap_events(struct kioctx *);
 static void aio_iocb_buffer_unmap(struct kioctx *);
@@ -539,6 +547,12 @@ static const struct address_space_operations aio_ctx_aops = {
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
@@ -553,7 +567,7 @@ static int aio_setup_ring(struct kioctx *ctx, unsigned int nr_events)
 	 * IO polling doesn't require any io event entries
 	 */
 	size = sizeof(struct aio_ring);
-	if (!(ctx->flags & IOCTX_FLAG_IOPOLL)) {
+	if (aio_ctx_old_ring(ctx)) {
 		nr_events += 2;	/* 1 is required, 2 for good luck */
 		size += sizeof(struct io_event) * nr_events;
 	}
@@ -640,6 +654,17 @@ static int aio_setup_ring(struct kioctx *ctx, unsigned int nr_events)
 	return 0;
 }
 
+/*
+ * Don't support cancel on anything that isn't regular aio
+ */
+static bool aio_ctx_supports_cancel(struct kioctx *ctx)
+{
+	int noflags = IOCTX_FLAG_USERIOCB | IOCTX_FLAG_IOPOLL |
+		      IOCTX_FLAG_SCQRING;
+
+	return (ctx->flags & noflags) == 0;
+}
+
 #define AIO_EVENTS_PER_PAGE	(PAGE_SIZE / sizeof(struct io_event))
 #define AIO_EVENTS_FIRST_PAGE	((PAGE_SIZE - sizeof(struct aio_ring)) / sizeof(struct io_event))
 #define AIO_EVENTS_OFFSET	(AIO_EVENTS_PER_PAGE - AIO_EVENTS_FIRST_PAGE)
@@ -650,6 +675,8 @@ void kiocb_set_cancel_fn(struct kiocb *iocb, kiocb_cancel_fn *cancel)
 	struct kioctx *ctx = req->ki_ctx;
 	unsigned long flags;
 
+	if (WARN_ON_ONCE(!aio_ctx_supports_cancel(ctx)))
+		return;
 	if (WARN_ON_ONCE(!list_empty(&req->ki_list)))
 		return;
 
@@ -673,6 +700,7 @@ static void free_ioctx(struct work_struct *work)
 
 	aio_iocb_buffer_unmap(ctx);
 	aio_useriocb_unmap(ctx);
+	aio_scqring_unmap(ctx);
 	aio_free_ring(ctx);
 	free_percpu(ctx->cpu);
 	percpu_ref_exit(&ctx->reqs);
@@ -1218,6 +1246,47 @@ static void aio_fill_event(struct io_event *ev, struct aio_kiocb *iocb,
 	ev->res2 = res2;
 }
 
+static struct io_event *__aio_get_cqring_ev(struct aio_io_event_ring *ring,
+					    struct aio_mapped_range *range,
+					    unsigned *next_tail)
+{
+	struct io_event *ev;
+	unsigned tail;
+
+	smp_rmb();
+	tail = READ_ONCE(ring->tail);
+	*next_tail = tail + 1;
+	if (*next_tail == ring->nr_events)
+		*next_tail = 0;
+	if (*next_tail == READ_ONCE(ring->head))
+		return NULL;
+
+	/* io_event array starts offset one into the mapped range */
+	tail++;
+	ev = page_address(range->pages[tail >> event_page_shift]);
+	tail &= ((1 << event_page_shift) - 1);
+	return ev + tail;
+}
+
+static void aio_commit_cqring(struct kioctx *ctx, unsigned next_tail)
+{
+	struct aio_io_event_ring *ring;
+
+	ring = page_address(ctx->cq_ring.pages[0]);
+	if (next_tail != ring->tail) {
+		ring->tail = next_tail;
+		smp_wmb();
+	}
+}
+
+static struct io_event *aio_peek_cqring(struct kioctx *ctx, unsigned *ntail)
+{
+	struct aio_io_event_ring *ring;
+
+	ring = page_address(ctx->cq_ring.pages[0]);
+	return __aio_get_cqring_ev(ring, &ctx->cq_ring, ntail);
+}
+
 static void aio_ring_complete(struct kioctx *ctx, struct aio_kiocb *iocb,
 			      long res, long res2)
 {
@@ -1279,7 +1348,36 @@ static void aio_complete(struct aio_kiocb *iocb, long res, long res2)
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
@@ -1291,14 +1389,6 @@ static void aio_complete(struct aio_kiocb *iocb, long res, long res2)
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
@@ -1421,6 +1511,9 @@ static long aio_iopoll_reap(struct kioctx *ctx, struct io_event __user *evs,
 		return 0;
 
 	list_for_each_entry_safe(iocb, n, &ctx->poll_completing, ki_list) {
+		struct io_event *ev = NULL;
+		unsigned int next_tail;
+
 		if (*nr_events == max)
 			break;
 		if (!test_bit(IOCB_POLL_COMPLETED, &iocb->ki_flags))
@@ -1428,6 +1521,14 @@ static long aio_iopoll_reap(struct kioctx *ctx, struct io_event __user *evs,
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
 
@@ -1446,8 +1547,11 @@ static long aio_iopoll_reap(struct kioctx *ctx, struct io_event __user *evs,
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
@@ -1628,15 +1732,42 @@ static long read_events(struct kioctx *ctx, long min_nr, long nr,
 	return ret;
 }
 
-static struct iocb *aio_iocb_from_index(struct kioctx *ctx, int index)
+static struct iocb *__aio_sqring_from_index(struct aio_iocb_ring *ring,
+					    struct aio_mapped_range *range,
+					    int index)
 {
 	struct iocb *iocb;
 
-	iocb = page_address(ctx->iocb_range.pages[index >> iocb_page_shift]);
+	/* iocb array starts offset one into the mapped range */
+	index++;
+	iocb = page_address(range->pages[index >> iocb_page_shift]);
 	index &= ((1 << iocb_page_shift) - 1);
 	return iocb + index;
 }
 
+static struct iocb *aio_sqring_from_index(struct kioctx *ctx, int index)
+{
+	struct aio_iocb_ring *ring;
+
+	ring = page_address(ctx->sq_ring.pages[0]);
+	return __aio_sqring_from_index(ring, &ctx->sq_ring, index);
+}
+
+static struct iocb *aio_iocb_from_index(struct kioctx *ctx, int index)
+{
+	struct iocb *iocb;
+
+	if (ctx->flags & IOCTX_FLAG_SCQRING) {
+		iocb = aio_sqring_from_index(ctx, index);
+	} else {
+		iocb = page_address(ctx->iocb_range.pages[index >> iocb_page_shift]);
+		index &= ((1 << iocb_page_shift) - 1);
+		iocb += index;
+	}
+
+	return iocb;
+}
+
 static void aio_unmap_range(struct aio_mapped_range *range)
 {
 	int i;
@@ -1692,6 +1823,52 @@ static int aio_useriocb_map(struct kioctx *ctx, struct iocb __user *iocbs)
 	return aio_map_range(&ctx->iocb_range, iocbs, size, 0);
 }
 
+static void aio_scqring_unmap(struct kioctx *ctx)
+{
+	aio_unmap_range(&ctx->sq_ring);
+	aio_unmap_range(&ctx->cq_ring);
+}
+
+static int aio_scqring_map(struct kioctx *ctx,
+			   struct aio_iocb_ring __user *sq_ring,
+			   struct aio_io_event_ring __user *cq_ring)
+{
+	struct aio_iocb_ring *ksq_ring;
+	struct aio_io_event_ring *kcq_ring;
+	int ret, sq_ring_size, cq_ring_size;
+	size_t size;
+
+	/*
+	 * The CQ ring size is QD + 1, so we don't have to track full condition
+	 * for head == tail. The SQ ring we make twice that in size, to make
+	 * room for having more inflight than the QD.
+	 */
+	sq_ring_size = ctx->max_reqs;
+	cq_ring_size = 2 * ctx->max_reqs;
+
+	size = sq_ring_size * sizeof(struct iocb);
+	ret = aio_map_range(&ctx->sq_ring, sq_ring,
+			    sq_ring_size * sizeof(struct iocb), 0);
+	if (ret)
+		return ret;
+
+	ret = aio_map_range(&ctx->cq_ring, cq_ring,
+			    cq_ring_size * sizeof(struct io_event), FOLL_WRITE);
+	if (ret) {
+		aio_unmap_range(&ctx->sq_ring);
+		return ret;
+	}
+
+	ksq_ring = page_address(ctx->sq_ring.pages[0]);
+	ksq_ring->nr_events = sq_ring_size;
+	ksq_ring->head = ksq_ring->tail = 0;
+
+	kcq_ring = page_address(ctx->cq_ring.pages[0]);
+	kcq_ring->nr_events = cq_ring_size;
+	kcq_ring->head = kcq_ring->tail = 0;
+	return 0;
+}
+
 static void aio_iocb_buffer_unmap(struct kioctx *ctx)
 {
 	int i, j;
@@ -1808,18 +1985,18 @@ static int aio_iocb_buffer_map(struct kioctx *ctx)
 	return ret;
 }
 
-SYSCALL_DEFINE6(io_setup2, u32, nr_events, u32, flags, struct iocb __user *,
-		iocbs, void __user *, user1, void __user *, user2,
+SYSCALL_DEFINE6(io_setup2, u32, nr_events, u32, flags,
+		struct iocb __user *, iocbs,
+		struct aio_iocb_ring __user *, sq_ring,
+		struct aio_io_event_ring __user *, cq_ring,
 		aio_context_t __user *, ctxp)
 {
 	struct kioctx *ioctx;
 	unsigned long ctx;
 	long ret;
 
-	if (user1 || user2)
-		return -EINVAL;
 	if (flags & ~(IOCTX_FLAG_USERIOCB | IOCTX_FLAG_IOPOLL |
-		      IOCTX_FLAG_FIXEDBUFS))
+		      IOCTX_FLAG_FIXEDBUFS | IOCTX_FLAG_SCQRING))
 		return -EINVAL;
 
 	ret = get_user(ctx, ctxp);
@@ -1832,18 +2009,26 @@ SYSCALL_DEFINE6(io_setup2, u32, nr_events, u32, flags, struct iocb __user *,
 		goto out;
 
 	if (flags & IOCTX_FLAG_USERIOCB) {
+		ret = -EINVAL;
+		if (flags & IOCTX_FLAG_SCQRING)
+			goto err;
+
 		ret = aio_useriocb_map(ioctx, iocbs);
 		if (ret)
 			goto err;
-		if (flags & IOCTX_FLAG_FIXEDBUFS) {
-			ret = aio_iocb_buffer_map(ioctx);
-			if (ret)
-				goto err;
-		}
-	} else if (flags & IOCTX_FLAG_FIXEDBUFS) {
-		/* can only support fixed bufs with user mapped iocbs */
+	}
+	if (flags & IOCTX_FLAG_SCQRING) {
+		ret = aio_scqring_map(ioctx, sq_ring, cq_ring);
+		if (ret)
+			goto err;
+	}
+	if (flags & IOCTX_FLAG_FIXEDBUFS) {
 		ret = -EINVAL;
-		goto err;
+		if (!(flags & (IOCTX_FLAG_USERIOCB | IOCTX_FLAG_SCQRING)))
+			goto err;
+		ret = aio_iocb_buffer_map(ioctx);
+		if (ret)
+			goto err;
 	}
 
 	ret = put_user(ioctx->user_id, ctxp);
@@ -2545,8 +2730,7 @@ static int __io_submit_one(struct kioctx *ctx, const struct iocb *iocb,
 		return -EINVAL;
 	}
 
-	/* Poll IO doesn't need ring reservations */
-	if (!(ctx->flags & IOCTX_FLAG_IOPOLL) && !get_reqs_available(ctx))
+	if (aio_ctx_old_ring(ctx) && !get_reqs_available(ctx))
 		return -EAGAIN;
 
 	ret = -EAGAIN;
@@ -2570,7 +2754,7 @@ static int __io_submit_one(struct kioctx *ctx, const struct iocb *iocb,
 	}
 
 	/* Don't support cancel on user mapped iocbs or polled context */
-	if (!(ctx->flags & (IOCTX_FLAG_USERIOCB | IOCTX_FLAG_IOPOLL))) {
+	if (aio_ctx_supports_cancel(ctx)) {
 		ret = put_user(KIOCB_KEY, &user_iocb->aio_key);
 		if (unlikely(ret)) {
 			pr_debug("EFAULT: aio_key\n");
@@ -2636,7 +2820,7 @@ static int __io_submit_one(struct kioctx *ctx, const struct iocb *iocb,
 		eventfd_ctx_put(req->ki_eventfd);
 	iocb_put(req);
 out_put_reqs_available:
-	if (!(ctx->flags & IOCTX_FLAG_IOPOLL))
+	if (aio_ctx_old_ring(ctx))
 		put_reqs_available(ctx, 1);
 	return ret;
 }
@@ -2709,6 +2893,184 @@ static void aio_submit_state_start(struct aio_submit_state *state,
 #endif
 }
 
+static struct iocb *__aio_get_sqring(struct aio_iocb_ring *ring,
+				     struct aio_mapped_range *range,
+				     unsigned *next_head)
+{
+	unsigned head;
+
+	smp_rmb();
+	head = READ_ONCE(ring->head);
+	if (head == READ_ONCE(ring->tail))
+		return NULL;
+
+	*next_head = head + 1;
+	if (*next_head == ring->nr_events)
+		*next_head = 0;
+
+	return __aio_sqring_from_index(ring, range, head);
+}
+
+static void aio_commit_sqring(struct kioctx *ctx, unsigned next_head)
+{
+	struct aio_iocb_ring *ring;
+
+	ring = page_address(ctx->sq_ring.pages[0]);
+	if (ring->head != next_head) {
+		ring->head = next_head;
+		smp_wmb();
+	}
+}
+
+static const struct iocb *aio_peek_sqring(struct kioctx *ctx, unsigned *nhead)
+{
+	struct aio_iocb_ring *ring;
+
+	ring = page_address(ctx->sq_ring.pages[0]);
+	return __aio_get_sqring(ring, &ctx->sq_ring, nhead);
+}
+
+static int aio_ring_submit(struct kioctx *ctx, unsigned int to_submit)
+{
+	bool kaddr = (ctx->flags & IOCTX_FLAG_FIXEDBUFS) != 0;
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
+		ret = __io_submit_one(ctx, iocb, NULL, NULL, false, kaddr);
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
+	struct aio_io_event_ring *ring;
+	DEFINE_WAIT(wait);
+	int ret = 0;
+
+	ring = page_address(ctx->cq_ring.pages[0]);
+	smp_rmb();
+	if (ring->head != ring->tail)
+		return 0;
+
+	do {
+		prepare_to_wait(&ctx->wait, &wait, TASK_INTERRUPTIBLE);
+
+		ret = 0;
+		smp_rmb();
+		if (ring->head != ring->tail)
+			break;
+		if (!min_events)
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
+SYSCALL_DEFINE4(io_ring_enter, aio_context_t, ctx_id, u32, to_submit,
+		u32, min_complete, u32, flags)
+{
+	struct kioctx *ctx;
+	long ret;
+
+	BUILD_BUG_ON(sizeof(struct aio_iocb_ring) != sizeof(struct iocb));
+	BUILD_BUG_ON(sizeof(struct aio_io_event_ring) !=
+			sizeof(struct io_event));
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
+		goto err;
+	}
+
+	ret = -EINVAL;
+	if (unlikely(atomic_read(&ctx->dead)))
+		goto err;
+
+	if (ctx->flags & IOCTX_FLAG_SCQRING)
+		ret = __io_ring_enter(ctx, to_submit, min_complete, flags);
+
+	mutex_unlock(&ctx->getevents_lock);
+err:
+	percpu_ref_put(&ctx->users);
+	return ret;
+}
+
 /* sys_io_submit:
  *	Queue the nr iocbs pointed to by iocbpp for processing.  Returns
  *	the number of iocbs queued.  May return -EINVAL if the aio_context
@@ -2738,6 +3100,10 @@ SYSCALL_DEFINE3(io_submit, aio_context_t, ctx_id, long, nr,
 		return -EINVAL;
 	}
 
+	/* SCQRING must use io_ring_enter() */
+	if (ctx->flags & IOCTX_FLAG_SCQRING)
+		return -EINVAL;
+
 	if (nr > ctx->nr_events)
 		nr = ctx->nr_events;
 
@@ -2854,7 +3220,7 @@ SYSCALL_DEFINE3(io_cancel, aio_context_t, ctx_id, struct iocb __user *, iocb,
 	if (unlikely(!ctx))
 		return -EINVAL;
 
-	if (ctx->flags & (IOCTX_FLAG_USERIOCB | IOCTX_FLAG_IOPOLL))
+	if (!aio_ctx_supports_cancel(ctx))
 		goto err;
 
 	spin_lock_irq(&ctx->ctx_lock);
@@ -2889,7 +3255,10 @@ static long do_io_getevents(aio_context_t ctx_id,
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
index a20a663d583f..576725d00020 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -288,8 +288,10 @@ static inline void addr_limit_user_check(void)
 #ifndef CONFIG_ARCH_HAS_SYSCALL_WRAPPER
 asmlinkage long sys_io_setup(unsigned nr_reqs, aio_context_t __user *ctx);
 asmlinkage long sys_io_setup2(unsigned, unsigned, struct iocb __user *,
-				void __user *, void __user *,
+				struct aio_iocb_ring __user *,
+				struct aio_io_event_ring __user *,
 				aio_context_t __user *);
+asmlinkage long sys_io_ring_enter(aio_context_t, unsigned, unsigned, unsigned);
 asmlinkage long sys_io_destroy(aio_context_t ctx);
 asmlinkage long sys_io_submit(aio_context_t, long,
 			struct iocb __user * __user *);
diff --git a/include/uapi/linux/aio_abi.h b/include/uapi/linux/aio_abi.h
index 05d72cf86bd3..9fb7d0ec868f 100644
--- a/include/uapi/linux/aio_abi.h
+++ b/include/uapi/linux/aio_abi.h
@@ -111,6 +111,32 @@ struct iocb {
 #define IOCTX_FLAG_USERIOCB	(1 << 0)	/* iocbs are user mapped */
 #define IOCTX_FLAG_IOPOLL	(1 << 1)	/* io_context is polled */
 #define IOCTX_FLAG_FIXEDBUFS	(1 << 2)	/* IO buffers are fixed */
+#define IOCTX_FLAG_SCQRING	(1 << 3)	/* Use SQ/CQ rings */
+
+struct aio_iocb_ring {
+	union {
+		struct {
+			u32 head, tail;
+			u32 nr_events;
+		};
+		struct iocb pad_iocb;
+	};
+	struct iocb iocbs[0];
+};
+
+struct aio_io_event_ring {
+	union {
+		struct {
+			u32 head, tail;
+			u32 nr_events;
+		};
+		struct io_event pad_event;
+	};
+	struct io_event events[0];
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

