Return-Path: <SRS0=iXKq=N6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69621C43441
	for <linux-block@archiver.kernel.org>; Mon, 19 Nov 2018 13:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1226920851
	for <linux-block@archiver.kernel.org>; Mon, 19 Nov 2018 13:32:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nJz9Apse"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1226920851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbeKSX4d (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Nov 2018 18:56:33 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:52598 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbeKSX4d (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Nov 2018 18:56:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=iU/Dx6aXOGmzu8M8h/p+v/Azh1gBELls0ntdebBWswc=; b=nJz9ApsePW4FkgxJ5uDsvFnbje
        +Vix6huP1XB1HnAt+P9v3V4CuUujOGN2HX9lyD8dI8lp4KsZLnPueEjhJ3TQkDizz1RmXS1jmoT8K
        xBej5Ak2io9kslLxDU/Yv0CTIqI5/LADCspWIJTCY/Lku+fm2SBew4b9U1tngSNDMvd1GMU4xYgkK
        +UwHinZVOuwpTn3+p+8Y6y3HQmDPfqBKs7G/pZD1Apq+y3dm4wqeXlfvFeEv6z1GtpvFX9zWiA0tN
        6xkcCk+NVT2Paq32slNJVXvDHO4Vu77taWxxQahaP/plVYhhy08mBjXlc1C24rFD0qsNED6ESraTy
        pSLxfA4Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gOjfa-0007bl-TG; Mon, 19 Nov 2018 13:32:54 +0000
Date:   Mon, 19 Nov 2018 05:32:54 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 4/5] aio: support for IO polling
Message-ID: <20181119133254.GA32705@infradead.org>
References: <20181117235317.7366-1-axboe@kernel.dk>
 <20181117235317.7366-5-axboe@kernel.dk>
 <20181119081119.GJ9622@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181119081119.GJ9622@infradead.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


I just saw the patch that avoids the irq disabling show up in your
tree this morning.  I think we can do even better by using slightly
lazy lists that are not updated from ->ki_complete context.

Please take a look at the patch below - this replaces patch 3 from
my previous mail, that is it is on top of what you send to the list
plus my first two patches.

Completely untested again of course..

---
From cf9fd90d13a025d53b26ba54202c2898ba4bf0ef Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Sun, 18 Nov 2018 17:17:55 +0100
Subject: change aio poll list management
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Have a submitted list, which the iocb is added on on submission,
and batch removed from in __aio_check_polled.  The actual I/O
completion only ever marks the iocb completed using a bit flag.

The completion code then walks the list completely lock free
after a quick splice under the irq-disable less lock because we
prevent multiple contexts from polling at the same time.

Also move the actual blk_poll call into a filesystem method,
which makes the aio code better abstracted out, allows checking
if a given file actually supports it, and last but not least
adds support for filesystems with multіple block devices.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/aio.c              | 328 +++++++++++++++++-------------------------
 fs/block_dev.c        |  20 ++-
 fs/direct-io.c        |   4 +-
 fs/iomap.c            |  53 ++++---
 fs/xfs/xfs_file.c     |   1 +
 include/linux/fs.h    |   2 +-
 include/linux/iomap.h |   1 +
 7 files changed, 186 insertions(+), 223 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index d9198f99ed97..8fa106db9b64 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -89,6 +89,9 @@ struct ctx_rq_wait {
 enum {
 	CTX_TYPE_NORMAL = 0,
 	CTX_TYPE_POLLED,
+
+	/* currently undergoing a polling io_getevents */
+	CTX_TYPE_POLLING,
 };
 
 struct kioctx {
@@ -151,8 +154,7 @@ struct kioctx {
 
 	struct {
 		spinlock_t poll_lock;
-		struct list_head poll_pending;
-		struct list_head poll_done;
+		struct list_head poll_submitted;
 	} ____cacheline_aligned_in_smp;
 
 	struct {
@@ -175,6 +177,9 @@ struct kioctx {
 	struct file		*aio_ring_file;
 
 	unsigned		id;
+
+	struct list_head poll_completing;
+	atomic_t poll_completed;
 };
 
 struct fsync_iocb {
@@ -209,21 +214,27 @@ struct aio_kiocb {
 	struct list_head	ki_list;	/* the aio core uses this
 						 * for cancellation */
 
+	unsigned long		ki_flags;
+#define IOCB_POLL_COMPLETED	0
 	struct list_head	ki_poll_list;
 
 	refcount_t		ki_refcnt;
 
-	/*
-	 * If the aio_resfd field of the userspace iocb is not zero,
-	 * this is the underlying eventfd context to deliver events to.
-	 */
-	struct eventfd_ctx	*ki_eventfd;
+	union {
+		/*
+		 * If the aio_resfd field of the userspace iocb is not zero,
+		 * this is the underlying eventfd context to deliver events to.
+		 */
+		struct eventfd_ctx	*ki_eventfd;
 
-	/*
-	 * For polled IO, stash completion info here
-	 */
-	long			ki_poll_res;
-	long			ki_poll_res2;
+		/*
+		 * For polled IO, stash completion info here
+		 */
+		struct {
+			long			res;
+			long			res2;
+		} ki_iopoll;
+	};
 };
 
 /*------ sysctl variables----*/
@@ -761,8 +772,9 @@ static struct kioctx *ioctx_alloc(unsigned nr_events)
 	INIT_LIST_HEAD(&ctx->active_reqs);
 
 	spin_lock_init(&ctx->poll_lock);
-	INIT_LIST_HEAD(&ctx->poll_pending);
-	INIT_LIST_HEAD(&ctx->poll_done);
+	INIT_LIST_HEAD(&ctx->poll_submitted);
+	INIT_LIST_HEAD(&ctx->poll_completing);
+	atomic_set(&ctx->poll_completed, 0);
 
 	if (percpu_ref_init(&ctx->users, free_ioctx_users, 0, GFP_KERNEL))
 		goto err;
@@ -1282,38 +1294,6 @@ static bool aio_read_events(struct kioctx *ctx, long min_nr, long nr,
 	return ret < 0 || *i >= min_nr;
 }
 
-struct aio_iopoll_data {
-	unsigned int blk_qc;
-	struct block_device *bdev;
-};
-
-static int aio_io_poll(struct aio_iopoll_data *pd, bool wait)
-{
-#ifdef CONFIG_BLOCK
-	/*
-	 * Should only happen if someone sets ->ki_blk_qc at random,
-	 * not being a blockdev target. We'll just ignore it, the IO
-	 * will complete normally without being polled.
-	 */
-	if (pd->bdev)
-		return blk_poll(bdev_get_queue(pd->bdev), pd->blk_qc, wait);
-#endif
-
-	return 0;
-}
-
-static struct block_device *aio_bdev_host(struct kiocb *req)
-{
-	struct inode *inode = req->ki_filp->f_mapping->host;
-
-	if (S_ISBLK(inode->i_mode))
-		return I_BDEV(inode);
-	else if (inode->i_sb && inode->i_sb->s_bdev)
-		return inode->i_sb->s_bdev;
-
-	return NULL;
-}
-
 #define AIO_POLL_STACK	8
 
 /*
@@ -1322,157 +1302,119 @@ static struct block_device *aio_bdev_host(struct kiocb *req)
  * the caller should free them.
  */
 static long aio_poll_reap(struct kioctx *ctx, struct io_event __user *evs,
-		int off, long max, void **iocbs, int *to_free)
-	__releases(&ctx->poll_lock)
-	__acquires(&ctx->poll_lock)
+		unsigned int *nr_events, long max)
 {
-	struct aio_kiocb *iocb;
-	int ret, nr = 0;
+	void *iocbs[AIO_POLL_STACK];
+	struct aio_kiocb *iocb, *n;
+	int to_free = 0, ret = 0;
 
-	while ((iocb = list_first_entry_or_null(&ctx->poll_done,
-			struct aio_kiocb, ki_poll_list))) {
-		struct io_event __user *uev;
+	list_for_each_entry_safe(iocb, n, &ctx->poll_completing, ki_poll_list) {
 		struct io_event ev;
 
-		if (*to_free == AIO_POLL_STACK) {
-			iocb_put_many(ctx, iocbs, *to_free);
-			*to_free = 0;
+		if (!test_bit(IOCB_POLL_COMPLETED, &iocb->ki_flags))
+			continue;
+
+		if (to_free == AIO_POLL_STACK) {
+			iocb_put_many(ctx, iocbs, to_free);
+			to_free = 0;
 		}
 
 		list_del(&iocb->ki_poll_list);
-		iocbs[*to_free++] = iocb;
+		iocbs[to_free++] = iocb;
 
 		if (!evs) {
-			nr++;
+			(*nr_events)++;
 			continue;
 		}
 
 		ev.obj = (u64)(unsigned long)iocb->ki_user_iocb;
 		ev.data = iocb->ki_user_data;
-		ev.res = iocb->ki_poll_res;
-		ev.res2 = iocb->ki_poll_res2;
-
-		uev = evs + nr + off;
-		if (unlikely(__copy_to_user_inatomic(uev, &ev, sizeof(*uev)))) {
-			/*
-			 * Unexpected slow path, drop lock and attempt copy
-			 * again.  If this also fails we are done.
-			 */
-			spin_unlock_irq(&ctx->poll_lock);
-			ret = copy_to_user(uev, &ev, sizeof(*uev));
-			spin_lock_irq(&ctx->poll_lock);
-			if (ret)
-				return nr ? nr : -EFAULT;
+		ev.res = iocb->ki_iopoll.res;
+		ev.res2 = iocb->ki_iopoll.res2;
+		if (copy_to_user(evs + *nr_events, &ev, sizeof(ev))) {
+			ret = -EFAULT;
+			break;
 		}
 
-		if (++nr + off == max)
+		if (++(*nr_events) == max)
 			break;
 	}
 
-	return nr;
-}
-
-static void aio_poll_for_events(struct kioctx *ctx, struct aio_iopoll_data *pd,
-				unsigned int nr_pd, int off, long min, long max)
-{
-	int i, polled = 0;
-
-	/*
-	 * Poll for needed events with wait == true, anything
-	 * after that we just check if we have more, up to max.
-	 */
-	for (i = 0; i < nr_pd; i++) {
-		bool wait = polled + off >= min;
-
-		polled += aio_io_poll(&pd[i], wait);
-		if (polled + off >= max)
-			break;
-
-		/*
-		 * If we have entries waiting to be reaped, stop polling
-		 */
-		if (!list_empty_careful(&ctx->poll_done))
-			break;
-	}
+	if (to_free)
+		iocb_put_many(ctx, iocbs, to_free);
+	return ret;
 }
 
 static int __aio_check_polled(struct kioctx *ctx, struct io_event __user *event,
-			      int off, unsigned int *entries, long min, long max)
+			      unsigned int *nr_events, long min, long max)
 {
-	struct aio_iopoll_data pd[AIO_POLL_STACK];
-	void *iocbs[AIO_POLL_STACK];
-	int to_free = 0;
 	struct aio_kiocb *iocb;
-	unsigned int nr_pd;
-	int ret, found = 0;
-
-	if (list_empty_careful(&ctx->poll_pending))
-		goto out;
+	unsigned int poll_completed;
+	int to_poll = 0, polled = 0, ret;
 
 	/*
 	 * Check if we already have done events that satisfy what we need
 	 */
-	spin_lock_irq(&ctx->poll_lock);
-	while ((ret = aio_poll_reap(ctx, event, off, max, iocbs, &to_free))) {
-		if (ret < 0 || ret + off >= min) {
-			spin_unlock_irq(&ctx->poll_lock);
-			if (to_free)
-				iocb_put_many(ctx, iocbs, to_free);
+	if (!list_empty(&ctx->poll_completing)) {
+		ret = aio_poll_reap(ctx, event, nr_events, max);
+		if (ret < 0)
 			return ret;
-		}
+		if (*nr_events >= min)
+			return 0;
+	}
 
-		if (to_free) {
-			iocb_put_many(ctx, iocbs, to_free);
-			to_free = 0;
-		}
-		found += ret;
-		off += ret;
+	/*
+	 * Take in a new working set from the submitted list if possible.
+	 */
+	if (!list_empty_careful(&ctx->poll_submitted)) {
+		spin_lock(&ctx->poll_lock);
+		list_splice_init(&ctx->poll_submitted, &ctx->poll_completing);
+		spin_unlock(&ctx->poll_lock);
 	}
 
+	if (list_empty(&ctx->poll_completing))
+		return 0;
+
+	/*
+	 * Check again now that we have a new batch.
+	 */
+	ret = aio_poll_reap(ctx, event, nr_events, max);
+	if (ret < 0)
+		return ret;
+	if (*nr_events >= min)
+		return 0;
+
 	/*
 	 * Find up to 'max_nr' worth of events to poll for, including the
 	 * events we already successfully polled
 	 */
-	nr_pd = 0;
-	list_for_each_entry(iocb, &ctx->poll_pending, ki_poll_list) {
-		struct kiocb *kiocb = &iocb->rw;
-		blk_qc_t qc;
-
+	poll_completed = atomic_read(&ctx->poll_completed);
+	list_for_each_entry(iocb, &ctx->poll_completing, ki_poll_list) {
 		/*
-		 * Not submitted yet, don't poll for it
+		 * Poll for needed events with wait == true, anything after
+		 * that we just check if we have more, up to max.
 		 */
-		qc = READ_ONCE(kiocb->ki_blk_qc);
-		if (qc == BLK_QC_T_NONE)
-			continue;
+		bool wait = polled + *nr_events >= min;
 
-		pd[nr_pd].blk_qc = qc;
-		pd[nr_pd].bdev = aio_bdev_host(kiocb);
-
-		++nr_pd;
-		if (nr_pd == ARRAY_SIZE(pd) || nr_pd + off >= max)
+		if (test_bit(IOCB_POLL_COMPLETED, &iocb->ki_flags))
 			break;
-	}
-	spin_unlock_irq(&ctx->poll_lock);
 
-	if (nr_pd) {
-		*entries = nr_pd;
-		aio_poll_for_events(ctx, pd, nr_pd, off, min, max);
-	}
+		if (++to_poll + *nr_events >= max)
+			break;
 
-out:
-	if (!list_empty_careful(&ctx->poll_done)) {
-		spin_lock_irq(&ctx->poll_lock);
-		ret = aio_poll_reap(ctx, event, off, max, iocbs, &to_free);
-		spin_unlock_irq(&ctx->poll_lock);
-	
-		if (to_free)
-			iocb_put_many(ctx, iocbs, to_free);
-		if (ret < 0)
-			return ret;
-		found += ret;
+		polled += iocb->rw.ki_filp->f_op->iopoll(&iocb->rw, wait);
+		if (polled + *nr_events >= max)
+			break;
+		if (poll_completed != atomic_read(&ctx->poll_completed))
+			break;
 	}
 
-	return found;
+	ret = aio_poll_reap(ctx, event, nr_events, max);
+	if (ret < 0)
+		return ret;
+	if (*nr_events >= min)
+		return 0;
+	return to_poll;
 }
 
 /*
@@ -1481,48 +1423,41 @@ static int __aio_check_polled(struct kioctx *ctx, struct io_event __user *event,
  */
 static void aio_reap_polled_events(struct kioctx *ctx)
 {
-	unsigned int loop, found;
-
 	if (!test_bit(CTX_TYPE_POLLED, &ctx->io_type))
 		return;
 
-	spin_lock_irq(&ctx->poll_lock);
-	while (!list_empty(&ctx->poll_pending) || !list_empty(&ctx->poll_done)) {
-		loop = 0;
-		spin_unlock_irq(&ctx->poll_lock);
-		found = __aio_check_polled(ctx, NULL, 0, &loop, 1, UINT_MAX);
-		spin_lock_irq(&ctx->poll_lock);
+	while (!list_empty_careful(&ctx->poll_submitted) ||
+	       !list_empty(&ctx->poll_completing)) {
+		unsigned int nr_events = 0;
+
+		__aio_check_polled(ctx, NULL, &nr_events, 1, UINT_MAX);
 	}
-	spin_unlock_irq(&ctx->poll_lock);
 }
 
 static int aio_check_polled(struct kioctx *ctx, long min_nr, long nr,
 			    struct io_event __user *event)
 {
-	unsigned int found;
-	int this, ret = 0;
+	unsigned int nr_events = 0;
+	int ret = 0;
 
-	if (!access_ok(VERIFY_WRITE, event, nr * sizeof(*event)))
-		return -EFAULT;
+	/* We can only allow a single thread to poll a context at a time */
+	if (test_and_set_bit(CTX_TYPE_POLLING, &ctx->io_type))
+		return -EBUSY;
 
-	do {
-		int tmin;
+	while (!nr_events || !need_resched()) {
+		int tmin = 0;
 
-		if (ret && need_resched())
-			break;
+		if (nr_events < min_nr)
+			tmin = min_nr - nr_events;
 
-		found = 0;
-		tmin = ret >= min_nr ? 0 : min_nr - ret;
-		this = __aio_check_polled(ctx, event, ret, &found, tmin, nr);
-		if (this < 0) {
-			if (!ret)
-				ret = this;
+		ret = __aio_check_polled(ctx, event, &nr_events, tmin, nr);
+		if (ret <= 0)
 			break;
-		}
-		ret += this;
-	} while (found && ret < min_nr);
+		ret = 0;
+	}
 
-	return ret;
+	clear_bit(CTX_TYPE_POLLING, &ctx->io_type);
+	return nr_events ? nr_events : ret;
 }
 
 static long read_events(struct kioctx *ctx, long min_nr, long nr,
@@ -1707,19 +1642,15 @@ static void aio_complete_rw(struct kiocb *kiocb, long res, long res2)
 static void aio_complete_rw_poll(struct kiocb *kiocb, long res, long res2)
 {
 	struct aio_kiocb *iocb = container_of(kiocb, struct aio_kiocb, rw);
-	struct kioctx *ctx = iocb->ki_ctx;
 	struct file *filp = kiocb->ki_filp;
-	unsigned long flags;
 
 	kiocb_end_write(kiocb);
 
-	iocb->ki_poll_res = res;
-	iocb->ki_poll_res2 = res2;
-
-	spin_lock_irqsave(&ctx->poll_lock, flags);
-	list_move_tail(&iocb->ki_poll_list, &ctx->poll_done);
-	spin_unlock_irqrestore(&ctx->poll_lock, flags);
+	iocb->ki_iopoll.res = res;
+	iocb->ki_iopoll.res2 = res2;
 
+	set_bit(IOCB_POLL_COMPLETED, &iocb->ki_flags);
+	atomic_inc(&iocb->ki_ctx->poll_completed);
 	fput(filp);
 }
 
@@ -1737,14 +1668,19 @@ static int aio_prep_rw(struct aio_kiocb *kiocb, struct iocb *iocb)
 	if (iocb->aio_flags & IOCB_FLAG_HIPRI) {
 		struct kioctx *ctx = kiocb->ki_ctx;
 
+		ret = -EOPNOTSUPP;
+		if (!(req->ki_flags & IOCB_DIRECT) ||
+		    !req->ki_filp->f_op->iopoll)
+			goto out_fput;
+
 		req->ki_flags |= IOCB_HIPRI;
-		req->ki_blk_qc = BLK_QC_T_NONE;
 		req->ki_complete = aio_complete_rw_poll;
 
-		spin_lock_irq(&ctx->poll_lock);
-		list_add_tail(&kiocb->ki_poll_list, &ctx->poll_pending);
-		spin_unlock_irq(&ctx->poll_lock);
+		spin_lock(&ctx->poll_lock);
+		list_add_tail(&kiocb->ki_poll_list, &ctx->poll_submitted);
+		spin_unlock(&ctx->poll_lock);
 	} else {
+		req->ki_flags &= ~IOCB_HIPRI;
 		req->ki_complete = aio_complete_rw;
 	}
 
@@ -1761,8 +1697,7 @@ static int aio_prep_rw(struct aio_kiocb *kiocb, struct iocb *iocb)
 		ret = ioprio_check_cap(iocb->aio_reqprio);
 		if (ret) {
 			pr_debug("aio ioprio check cap error: %d\n", ret);
-			fput(req->ki_filp);
-			return ret;
+			goto out_fput;
 		}
 
 		req->ki_ioprio = iocb->aio_reqprio;
@@ -1771,7 +1706,10 @@ static int aio_prep_rw(struct aio_kiocb *kiocb, struct iocb *iocb)
 
 	ret = kiocb_set_rw_flags(req, iocb->aio_rw_flags);
 	if (unlikely(ret))
-		fput(req->ki_filp);
+		goto out_fput;
+	return 0;
+out_fput:
+	fput(req->ki_filp);
 	return ret;
 }
 
diff --git a/fs/block_dev.c b/fs/block_dev.c
index 8a2fed18e3fc..8ba58e280ac6 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -236,7 +236,6 @@ __blkdev_direct_IO_simple(struct kiocb *iocb, struct iov_iter *iter,
 		bio.bi_opf |= REQ_HIPRI;
 
 	qc = submit_bio(&bio);
-	WRITE_ONCE(iocb->ki_blk_qc, qc);
 	for (;;) {
 		__set_current_state(TASK_UNINTERRUPTIBLE);
 
@@ -274,6 +273,7 @@ struct blkdev_dio {
 	};
 	size_t			size;
 	atomic_t		ref;
+	blk_qc_t		qc;
 	bool			multi_bio : 1;
 	bool			should_dirty : 1;
 	bool			is_sync : 1;
@@ -282,6 +282,14 @@ struct blkdev_dio {
 
 static struct bio_set blkdev_dio_pool;
 
+static bool blkdev_iopoll(struct kiocb *kiocb, bool wait)
+{
+	struct blkdev_dio *dio = kiocb->private;
+	struct block_device *bdev = I_BDEV(kiocb->ki_filp->f_mapping->host);
+
+	return blk_poll(bdev_get_queue(bdev), READ_ONCE(dio->qc), wait);
+}
+
 static void blkdev_bio_end_io(struct bio *bio)
 {
 	struct blkdev_dio *dio = bio->bi_private;
@@ -336,7 +344,6 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
 	bool is_poll = (iocb->ki_flags & IOCB_HIPRI) != 0;
 	bool is_read = (iov_iter_rw(iter) == READ), is_sync;
 	loff_t pos = iocb->ki_pos;
-	blk_qc_t qc = BLK_QC_T_NONE;
 	int ret = 0;
 
 	if ((pos | iov_iter_alignment(iter)) &
@@ -356,6 +363,9 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
 	dio->size = 0;
 	dio->multi_bio = false;
 	dio->should_dirty = is_read && iter_is_iovec(iter);
+	dio->qc = BLK_QC_T_NONE;
+
+	iocb->private = dio;
 
 	/*
 	 * Don't plug for HIPRI/polled IO, as those should go straight
@@ -396,8 +406,7 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
 			if (iocb->ki_flags & IOCB_HIPRI)
 				bio->bi_opf |= REQ_HIPRI;
 
-			qc = submit_bio(bio);
-			WRITE_ONCE(iocb->ki_blk_qc, qc);
+			WRITE_ONCE(dio->qc, submit_bio(bio));
 			break;
 		}
 
@@ -425,7 +434,7 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
 			break;
 
 		if (!(iocb->ki_flags & IOCB_HIPRI) ||
-		    !blk_poll(bdev_get_queue(bdev), qc, true))
+		    !blk_poll(bdev_get_queue(bdev), dio->qc, true))
 			io_schedule();
 	}
 	__set_current_state(TASK_RUNNING);
@@ -2063,6 +2072,7 @@ const struct file_operations def_blk_fops = {
 	.llseek		= block_llseek,
 	.read_iter	= blkdev_read_iter,
 	.write_iter	= blkdev_write_iter,
+	.iopoll		= blkdev_iopoll,
 	.mmap		= generic_file_mmap,
 	.fsync		= blkdev_fsync,
 	.unlocked_ioctl	= block_ioctl,
diff --git a/fs/direct-io.c b/fs/direct-io.c
index 34de494e9061..a5a4e5a1423e 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -477,10 +477,8 @@ static inline void dio_bio_submit(struct dio *dio, struct dio_submit *sdio)
 	if (sdio->submit_io) {
 		sdio->submit_io(bio, dio->inode, sdio->logical_offset_in_bio);
 		dio->bio_cookie = BLK_QC_T_NONE;
-	} else {
+	} else
 		dio->bio_cookie = submit_bio(bio);
-		WRITE_ONCE(dio->iocb->ki_blk_qc, dio->bio_cookie);
-	}
 
 	sdio->bio = NULL;
 	sdio->boundary = 0;
diff --git a/fs/iomap.c b/fs/iomap.c
index 4cf412b6230a..e5cd9dbe78a8 100644
--- a/fs/iomap.c
+++ b/fs/iomap.c
@@ -1419,14 +1419,14 @@ struct iomap_dio {
 	unsigned		flags;
 	int			error;
 	bool			wait_for_completion;
+	blk_qc_t		cookie;
+	struct request_queue	*last_queue;
 
 	union {
 		/* used during submission and for synchronous completion: */
 		struct {
 			struct iov_iter		*iter;
 			struct task_struct	*waiter;
-			struct request_queue	*last_queue;
-			blk_qc_t		cookie;
 		} submit;
 
 		/* used for aio completion: */
@@ -1436,6 +1436,30 @@ struct iomap_dio {
 	};
 };
 
+bool iomap_dio_iopoll(struct kiocb *kiocb, bool wait)
+{
+	struct iomap_dio *dio = kiocb->private;
+	struct request_queue *q = READ_ONCE(dio->last_queue);
+
+	if (!q)
+		return false;
+	return blk_poll(q, READ_ONCE(dio->cookie), wait);
+}
+EXPORT_SYMBOL_GPL(iomap_dio_iopoll);
+
+static void iomap_dio_submit_bio(struct iomap_dio *dio, struct iomap *iomap,
+		struct bio *bio)
+{
+	atomic_inc(&dio->ref);
+
+	/*
+	 * iomap_dio_iopoll can race with us.  A non-zero last_queue marks that
+	 * we are ready to poll.
+	 */
+	WRITE_ONCE(dio->cookie, submit_bio(bio));
+	WRITE_ONCE(dio->last_queue, bdev_get_queue(iomap->bdev));
+}
+
 static ssize_t iomap_dio_complete(struct iomap_dio *dio)
 {
 	struct kiocb *iocb = dio->iocb;
@@ -1548,14 +1572,13 @@ static void iomap_dio_bio_end_io(struct bio *bio)
 	}
 }
 
-static blk_qc_t
+static void
 iomap_dio_zero(struct iomap_dio *dio, struct iomap *iomap, loff_t pos,
 		unsigned len)
 {
 	struct page *page = ZERO_PAGE(0);
 	int flags = REQ_SYNC | REQ_IDLE;
 	struct bio *bio;
-	blk_qc_t qc;
 
 	bio = bio_alloc(GFP_KERNEL, 1);
 	bio_set_dev(bio, iomap->bdev);
@@ -1569,11 +1592,7 @@ iomap_dio_zero(struct iomap_dio *dio, struct iomap *iomap, loff_t pos,
 	get_page(page);
 	__bio_add_page(bio, page, len, 0);
 	bio_set_op_attrs(bio, REQ_OP_WRITE, flags);
-
-	atomic_inc(&dio->ref);
-	qc = submit_bio(bio);
-	WRITE_ONCE(dio->iocb->ki_blk_qc, qc);
-	return qc;
+	iomap_dio_submit_bio(dio, iomap, bio);
 }
 
 static loff_t
@@ -1679,11 +1698,7 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
 		copied += n;
 
 		nr_pages = iov_iter_npages(&iter, BIO_MAX_PAGES);
-
-		atomic_inc(&dio->ref);
-
-		dio->submit.last_queue = bdev_get_queue(iomap->bdev);
-		dio->iocb->ki_blk_qc = dio->submit.cookie = submit_bio(bio);
+		iomap_dio_submit_bio(dio, iomap, bio);
 	} while (nr_pages);
 
 	if (need_zeroout) {
@@ -1785,6 +1800,7 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 	dio = kmalloc(sizeof(*dio), GFP_KERNEL);
 	if (!dio)
 		return -ENOMEM;
+	iocb->private = dio;
 
 	dio->iocb = iocb;
 	atomic_set(&dio->ref, 1);
@@ -1794,11 +1810,11 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 	dio->error = 0;
 	dio->flags = 0;
 	dio->wait_for_completion = is_sync_kiocb(iocb);
+	dio->cookie = BLK_QC_T_NONE;
+	dio->last_queue = NULL;
 
 	dio->submit.iter = iter;
 	dio->submit.waiter = current;
-	dio->submit.cookie = BLK_QC_T_NONE;
-	dio->submit.last_queue = NULL;
 
 	if (iov_iter_rw(iter) == READ) {
 		if (pos >= dio->i_size)
@@ -1897,9 +1913,8 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 				break;
 
 			if (!(iocb->ki_flags & IOCB_HIPRI) ||
-			    !dio->submit.last_queue ||
-			    !blk_poll(dio->submit.last_queue,
-					 dio->submit.cookie, true))
+			    !dio->last_queue ||
+			    !blk_poll(dio->last_queue, dio->cookie, true))
 				io_schedule();
 		}
 		__set_current_state(TASK_RUNNING);
diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 53c9ab8fb777..603e705781a4 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -1203,6 +1203,7 @@ const struct file_operations xfs_file_operations = {
 	.write_iter	= xfs_file_write_iter,
 	.splice_read	= generic_file_splice_read,
 	.splice_write	= iter_file_splice_write,
+	.iopoll		= iomap_dio_iopoll,
 	.unlocked_ioctl	= xfs_file_ioctl,
 #ifdef CONFIG_COMPAT
 	.compat_ioctl	= xfs_file_compat_ioctl,
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 032761d9b218..1d46a10aef6c 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -310,7 +310,6 @@ struct kiocb {
 	int			ki_flags;
 	u16			ki_hint;
 	u16			ki_ioprio; /* See linux/ioprio.h */
-	u32			ki_blk_qc;
 } __randomize_layout;
 
 static inline bool is_sync_kiocb(struct kiocb *kiocb)
@@ -1782,6 +1781,7 @@ struct file_operations {
 	ssize_t (*write) (struct file *, const char __user *, size_t, loff_t *);
 	ssize_t (*read_iter) (struct kiocb *, struct iov_iter *);
 	ssize_t (*write_iter) (struct kiocb *, struct iov_iter *);
+	bool (*iopoll)(struct kiocb *kiocb, bool wait);
 	int (*iterate) (struct file *, struct dir_context *);
 	int (*iterate_shared) (struct file *, struct dir_context *);
 	__poll_t (*poll) (struct file *, struct poll_table_struct *);
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 9a4258154b25..2cbe87ad1878 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -162,6 +162,7 @@ typedef int (iomap_dio_end_io_t)(struct kiocb *iocb, ssize_t ret,
 		unsigned flags);
 ssize_t iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 		const struct iomap_ops *ops, iomap_dio_end_io_t end_io);
+bool iomap_dio_iopoll(struct kiocb *kiocb, bool wait);
 
 #ifdef CONFIG_SWAP
 struct file;
-- 
2.19.1

