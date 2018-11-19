Return-Path: <SRS0=iXKq=N6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4C03C43441
	for <linux-block@archiver.kernel.org>; Mon, 19 Nov 2018 08:11:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 814DA2087A
	for <linux-block@archiver.kernel.org>; Mon, 19 Nov 2018 08:11:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cCPDK+fA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 814DA2087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbeKSSeL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Nov 2018 13:34:11 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:38794 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726590AbeKSSeL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Nov 2018 13:34:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=dp58FyWd+kfeK2k+QbMXuaDSEHRnqmmyDOoUWK1NZyI=; b=cCPDK+fAVrAMIxISOWQSoDI/C
        WPVLCSYOzF1tkHHKJnGG68gOg4QWHGeJDADhblxmPg158PY1enC172ETV8NoVFhKN3Uyk3F2TRupG
        w7KQ5uak4R6tnSNRq/Wi/fXoDiDGruXwNe6ste0YBHFzlbSF4wrV37rNIUwoBL7ln5R8F7SZxJbBg
        Sj30il3MltMrBk0r6WmOxTcs/N4gvY+qGck3dQ4fLtDWc26oT3pe5DElJKznzgmDvJyIEQUYs5yct
        pEQ8Mz0e6NYfCq61VTyjhAlnXeCgr9rR9Iddy/zMVfGcPn8d4MnaOD1jq8y8DxJ7I5bhAstnls5ns
        SDcrorzDg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gOeeN-0000F9-Eu; Mon, 19 Nov 2018 08:11:19 +0000
Date:   Mon, 19 Nov 2018 00:11:19 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 4/5] aio: support for IO polling
Message-ID: <20181119081119.GJ9622@infradead.org>
References: <20181117235317.7366-1-axboe@kernel.dk>
 <20181117235317.7366-5-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="wRRV7LY7NUeQGEoC"
Content-Disposition: inline
In-Reply-To: <20181117235317.7366-5-axboe@kernel.dk>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I like this idea, but there are a couple issues here.

First the flag per command really doesn't work - we need a creation
time flag.  Unfortunately the existing io_setup system call doesn't
take flags, so we'll need to add a new one.

Second we need a check that the polling mode is actually supported
for a given file descriptor.

Third this hardcodes block device knowlege into the block layer. We
really need move it into a method.   See my third attached patch
for an (untested) idea how to make that work.  The first two are
just cleanups.

Fourth we already have aio ->poll support.  So this needs a different
naming scheme, e.g. *iopoll*.


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="0001-aio-split-get_reqs_available-from-aio_get_req.patch"

From 8b0d8f2e723bcf52d010c46130eb759770a0dc11 Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Mon, 19 Nov 2018 08:13:19 +0100
Subject: aio: split get_reqs_available from aio_get_req

This makes the polled case nice to handle, and matches the put side.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/aio.c | 41 ++++++++++++++++++++++-------------------
 1 file changed, 22 insertions(+), 19 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index e02085fe10d7..348f04129035 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -935,7 +935,7 @@ static void put_reqs_available(struct kioctx *ctx, unsigned nr)
 	local_irq_restore(flags);
 }
 
-static bool get_reqs_available(struct kioctx *ctx)
+static bool __get_reqs_available(struct kioctx *ctx)
 {
 	struct kioctx_cpu *kcpu;
 	bool ret = false;
@@ -1027,23 +1027,25 @@ static void user_refill_reqs_available(struct kioctx *ctx)
 	spin_unlock_irq(&ctx->completion_lock);
 }
 
+static bool get_reqs_available(struct kioctx *ctx)
+{
+	if (__get_reqs_available(ctx))
+		return true;
+	user_refill_reqs_available(ctx);
+	return __get_reqs_available(ctx);
+}
+
 /* aio_get_req
  *	Allocate a slot for an aio request.
  * Returns NULL if no requests are free.
  */
-static inline struct aio_kiocb *aio_get_req(struct kioctx *ctx, bool needs_ring)
+static inline struct aio_kiocb *aio_get_req(struct kioctx *ctx)
 {
 	struct aio_kiocb *req;
 
-	if (needs_ring && !get_reqs_available(ctx)) {
-		user_refill_reqs_available(ctx);
-		if (!get_reqs_available(ctx))
-			return NULL;
-	}
-
 	req = kmem_cache_alloc(kiocb_cachep, GFP_KERNEL|__GFP_ZERO);
 	if (unlikely(!req))
-		goto out_put;
+		return NULL;
 
 	percpu_ref_get(&ctx->reqs);
 	INIT_LIST_HEAD(&req->ki_list);
@@ -1051,10 +1053,6 @@ static inline struct aio_kiocb *aio_get_req(struct kioctx *ctx, bool needs_ring)
 	refcount_set(&req->ki_refcnt, 0);
 	req->ki_ctx = ctx;
 	return req;
-out_put:
-	if (needs_ring)
-		put_reqs_available(ctx, 1);
-	return NULL;
 }
 
 static struct kioctx *lookup_ioctx(unsigned long ctx_id)
@@ -2200,17 +2198,21 @@ static int io_submit_one(struct kioctx *ctx, struct iocb __user *user_iocb,
 		return -EINVAL;
 	}
 
-	if (iocb.aio_flags & IOCB_FLAG_HIPRI)
+	if (iocb.aio_flags & IOCB_FLAG_HIPRI) {
 		ctx_type = CTX_TYPE_POLLED;
-	else
+	} else {
 		ctx_type = CTX_TYPE_NORMAL;
+		if (!get_reqs_available(ctx))
+			return -EAGAIN;
+	}
 
 	/*
 	 * Polled IO doesn't need ring reservations
 	 */
-	req = aio_get_req(ctx, ctx_type == CTX_TYPE_NORMAL);
+	ret = -EAGAIN;
+	req = aio_get_req(ctx);
 	if (unlikely(!req))
-		return -EAGAIN;
+		goto out_put_reqs_available;
 
 	if (iocb.aio_flags & IOCB_FLAG_RESFD) {
 		/*
@@ -2294,12 +2296,13 @@ static int io_submit_one(struct kioctx *ctx, struct iocb __user *user_iocb,
 		return 0;
 
 out_put_req:
-	if (ctx_type == CTX_TYPE_NORMAL)
-		put_reqs_available(ctx, 1);
 	percpu_ref_put(&ctx->reqs);
 	if (req->ki_eventfd)
 		eventfd_ctx_put(req->ki_eventfd);
 	kmem_cache_free(kiocb_cachep, req);
+out_put_reqs_available:
+	if (ctx_type == CTX_TYPE_NORMAL)
+		put_reqs_available(ctx, 1);
 	return ret;
 }
 
-- 
2.19.1


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="0002-cleanup-the-aio_poll_reap-related-flow.patch"

From a42c0af6c96b47d9b915e4efdaa0211e9b6b5253 Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Sun, 18 Nov 2018 16:24:22 +0100
Subject: cleanup the aio_poll_reap related flow

Should not change behavior except for fixing a bug where the number
of returned iocbs was incorrectly overwritten when we actually loop
on poll_done for the first call.

I don't really understand why we loop there but not the second time
we call it.  Nor do I really understand the nested loop in the callers
of __aio_check_polled, but that is for another time..
---
 fs/aio.c | 152 ++++++++++++++++++-------------------------------------
 1 file changed, 50 insertions(+), 102 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 348f04129035..d9198f99ed97 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1091,7 +1091,7 @@ static inline void iocb_put(struct aio_kiocb *iocb)
 	}
 }
 
-static void iocb_put_many(struct kioctx *ctx, void  **iocbs, int nr)
+static void iocb_put_many(struct kioctx *ctx, void **iocbs, int nr)
 {
 	if (nr) {
 		kmem_cache_free_bulk(kiocb_cachep, nr, iocbs);
@@ -1316,42 +1316,33 @@ static struct block_device *aio_bdev_host(struct kiocb *req)
 
 #define AIO_POLL_STACK	8
 
-struct aio_poll_data {
-	struct io_event __user *evs;
-	int off;
-	long max;
-	void *iocbs[AIO_POLL_STACK];
-	int to_free;
-};
-
 /*
- * Process the done_list of iocbs, copy to user space, and free them.
- * Migh return with data->iocbs holding entries, in which case
- * data->to_free is non-zero and the caller should free them.
+ * Process the done_list of iocbs, copy to user space, and free them.  Might
+ * return with iocbs holding entries, in which case *to_free is non-zero and
+ * the caller should free them.
  */
-static long aio_poll_reap(struct kioctx *ctx, struct aio_poll_data *data)
+static long aio_poll_reap(struct kioctx *ctx, struct io_event __user *evs,
+		int off, long max, void **iocbs, int *to_free)
 	__releases(&ctx->poll_lock)
 	__acquires(&ctx->poll_lock)
 {
 	struct aio_kiocb *iocb;
 	int ret, nr = 0;
 
-restart:
-	while (!list_empty(&ctx->poll_done)) {
+	while ((iocb = list_first_entry_or_null(&ctx->poll_done,
+			struct aio_kiocb, ki_poll_list))) {
 		struct io_event __user *uev;
 		struct io_event ev;
 
-		if (data->to_free == ARRAY_SIZE(data->iocbs)) {
-			iocb_put_many(ctx, data->iocbs, data->to_free);
-			data->to_free = 0;
+		if (*to_free == AIO_POLL_STACK) {
+			iocb_put_many(ctx, iocbs, *to_free);
+			*to_free = 0;
 		}
 
-		iocb = list_first_entry(&ctx->poll_done, struct aio_kiocb,
-						ki_poll_list);
 		list_del(&iocb->ki_poll_list);
+		iocbs[*to_free++] = iocb;
 
-		data->iocbs[data->to_free++] = iocb;
-		if (!data->evs) {
+		if (!evs) {
 			nr++;
 			continue;
 		}
@@ -1361,65 +1352,26 @@ static long aio_poll_reap(struct kioctx *ctx, struct aio_poll_data *data)
 		ev.res = iocb->ki_poll_res;
 		ev.res2 = iocb->ki_poll_res2;
 
-		uev = data->evs + nr + data->off;
-		if (!__copy_to_user_inatomic(uev, &ev, sizeof(*uev))) {
-			nr++;
-			if (nr + data->off < data->max)
-				continue;
-			break;
+		uev = evs + nr + off;
+		if (unlikely(__copy_to_user_inatomic(uev, &ev, sizeof(*uev)))) {
+			/*
+			 * Unexpected slow path, drop lock and attempt copy
+			 * again.  If this also fails we are done.
+			 */
+			spin_unlock_irq(&ctx->poll_lock);
+			ret = copy_to_user(uev, &ev, sizeof(*uev));
+			spin_lock_irq(&ctx->poll_lock);
+			if (ret)
+				return nr ? nr : -EFAULT;
 		}
 
-		/*
-		 * Unexpected slow path, drop lock and attempt copy. If this
-		 * also fails, we're done. If it worked, we got another event
-		 * and we restart the list check since we dropped the lock.
-		 */
-		spin_unlock_irq(&ctx->poll_lock);
-		ret = copy_to_user(uev, &ev, sizeof(*uev));
-		spin_lock_irq(&ctx->poll_lock);
-		if (!ret) {
-			nr++;
-			if (nr + data->off < data->max)
-				goto restart;
-
+		if (++nr + off == max)
 			break;
-		}
-
-		if (!nr)
-			nr = -EFAULT;
-		break;
 	}
 
 	return nr;
 }
 
-/*
- * Reap done events, if any
- */
-static long aio_poll_find(struct kioctx *ctx, struct io_event __user *evs,
-			  int off, long max)
-{
-	struct aio_poll_data data = {
-		.evs		= evs,
-		.off		= off,
-		.max		= max,
-		.to_free	= 0
-	};
-	int ret;
-
-	if (list_empty_careful(&ctx->poll_done))
-		return 0;
-
-	spin_lock_irq(&ctx->poll_lock);
-	ret = aio_poll_reap(ctx, &data);
-	spin_unlock_irq(&ctx->poll_lock);
-
-	if (data.to_free)
-		iocb_put_many(ctx, data.iocbs, data.to_free);
-
-	return ret;
-}
-
 static void aio_poll_for_events(struct kioctx *ctx, struct aio_iopoll_data *pd,
 				unsigned int nr_pd, int off, long min, long max)
 {
@@ -1448,42 +1400,32 @@ static int __aio_check_polled(struct kioctx *ctx, struct io_event __user *event,
 			      int off, unsigned int *entries, long min, long max)
 {
 	struct aio_iopoll_data pd[AIO_POLL_STACK];
+	void *iocbs[AIO_POLL_STACK];
+	int to_free = 0;
 	struct aio_kiocb *iocb;
 	unsigned int nr_pd;
-	int ret, pre = 0;
+	int ret, found = 0;
 
 	if (list_empty_careful(&ctx->poll_pending))
 		goto out;
 
-	spin_lock_irq(&ctx->poll_lock);
-
 	/*
 	 * Check if we already have done events that satisfy what we need
 	 */
-	while (!list_empty(&ctx->poll_done)) {
-		struct aio_poll_data data = {
-			.evs = event,
-			.off = off,
-			.max = max,
-			.to_free = 0
-		};
-
-		ret = aio_poll_reap(ctx, &data);
-		if (!ret)
-			break;
-		else if (ret < 0 || ret + off >= min) {
+	spin_lock_irq(&ctx->poll_lock);
+	while ((ret = aio_poll_reap(ctx, event, off, max, iocbs, &to_free))) {
+		if (ret < 0 || ret + off >= min) {
 			spin_unlock_irq(&ctx->poll_lock);
-
-			if (data.to_free)
-				iocb_put_many(ctx, data.iocbs, data.to_free);
-
+			if (to_free)
+				iocb_put_many(ctx, iocbs, to_free);
 			return ret;
 		}
 
-		if (data.to_free)
-			iocb_put_many(ctx, data.iocbs, data.to_free);
-
-		pre = ret;
+		if (to_free) {
+			iocb_put_many(ctx, iocbs, to_free);
+			to_free = 0;
+		}
+		found += ret;
 		off += ret;
 	}
 
@@ -1518,13 +1460,19 @@ static int __aio_check_polled(struct kioctx *ctx, struct io_event __user *event,
 	}
 
 out:
-	ret = aio_poll_find(ctx, event, off, max);
-	if (ret >= 0)
-		return pre + ret;
-	else if (pre)
-		return pre;
+	if (!list_empty_careful(&ctx->poll_done)) {
+		spin_lock_irq(&ctx->poll_lock);
+		ret = aio_poll_reap(ctx, event, off, max, iocbs, &to_free);
+		spin_unlock_irq(&ctx->poll_lock);
+	
+		if (to_free)
+			iocb_put_many(ctx, iocbs, to_free);
+		if (ret < 0)
+			return ret;
+		found += ret;
+	}
 
-	return ret;
+	return found;
 }
 
 /*
-- 
2.19.1


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="0003-use-array-of-iocbs.patch"

From f44b92fc87f2f83946af12db9faea5916016a486 Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Sun, 18 Nov 2018 17:17:55 +0100
Subject: use array of iocbs

XXX: will need some protection against concurrent reaps
---
 fs/aio.c              | 121 +++++++++++++-----------------------------
 fs/block_dev.c        |  20 +++++--
 fs/direct-io.c        |   4 +-
 fs/iomap.c            |  53 +++++++++++-------
 fs/xfs/xfs_file.c     |   1 +
 include/linux/fs.h    |   2 +-
 include/linux/iomap.h |   1 +
 7 files changed, 90 insertions(+), 112 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index d9198f99ed97..cb2fead2ab7c 100644
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
@@ -1282,38 +1285,6 @@ static bool aio_read_events(struct kioctx *ctx, long min_nr, long nr,
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
@@ -1372,39 +1343,12 @@ static long aio_poll_reap(struct kioctx *ctx, struct io_event __user *evs,
 	return nr;
 }
 
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
-}
-
 static int __aio_check_polled(struct kioctx *ctx, struct io_event __user *event,
-			      int off, unsigned int *entries, long min, long max)
+			      int off, unsigned int *to_poll, long min, long max)
 {
-	struct aio_iopoll_data pd[AIO_POLL_STACK];
 	void *iocbs[AIO_POLL_STACK];
-	int to_free = 0;
 	struct aio_kiocb *iocb;
-	unsigned int nr_pd;
-	int ret, found = 0;
+	int to_free = 0, found = 0, polled = 0, ret, i;
 
 	if (list_empty_careful(&ctx->poll_pending))
 		goto out;
@@ -1433,30 +1377,27 @@ static int __aio_check_polled(struct kioctx *ctx, struct io_event __user *event,
 	 * Find up to 'max_nr' worth of events to poll for, including the
 	 * events we already successfully polled
 	 */
-	nr_pd = 0;
 	list_for_each_entry(iocb, &ctx->poll_pending, ki_poll_list) {
-		struct kiocb *kiocb = &iocb->rw;
-		blk_qc_t qc;
-
-		/*
-		 * Not submitted yet, don't poll for it
-		 */
-		qc = READ_ONCE(kiocb->ki_blk_qc);
-		if (qc == BLK_QC_T_NONE)
-			continue;
-
-		pd[nr_pd].blk_qc = qc;
-		pd[nr_pd].bdev = aio_bdev_host(kiocb);
-
-		++nr_pd;
-		if (nr_pd == ARRAY_SIZE(pd) || nr_pd + off >= max)
+		iocbs[*to_poll] = iocb;
+		(*to_poll)++;
+		if (*to_poll == AIO_POLL_STACK || *to_poll + off >= max)
 			break;
 	}
 	spin_unlock_irq(&ctx->poll_lock);
 
-	if (nr_pd) {
-		*entries = nr_pd;
-		aio_poll_for_events(ctx, pd, nr_pd, off, min, max);
+	/*
+	 * Poll for needed events with wait == true, anything after that we just
+	 * check if we have more, up to max.
+	 *
+	 * If we have entries waiting to be reaped, stop polling
+	 */
+	for (i = 0; i < *to_poll; i++) {
+		bool wait = polled + off >= min;
+
+		iocb = iocbs[*to_poll];
+		polled += iocb->rw.ki_filp->f_op->iopoll(&iocb->rw, wait);
+		if (polled + off >= max || !list_empty_careful(&ctx->poll_done))
+			break;
 	}
 
 out:
@@ -1502,6 +1443,10 @@ static int aio_check_polled(struct kioctx *ctx, long min_nr, long nr,
 	unsigned int found;
 	int this, ret = 0;
 
+	/* We can only allow a single thread to poll a context at a time */
+	if (test_and_set_bit(CTX_TYPE_POLLING, &ctx->io_type))
+		return -EBUSY;
+
 	if (!access_ok(VERIFY_WRITE, event, nr * sizeof(*event)))
 		return -EFAULT;
 
@@ -1522,6 +1467,7 @@ static int aio_check_polled(struct kioctx *ctx, long min_nr, long nr,
 		ret += this;
 	} while (found && ret < min_nr);
 
+	clear_bit(CTX_TYPE_POLLING, &ctx->io_type);
 	return ret;
 }
 
@@ -1737,14 +1683,19 @@ static int aio_prep_rw(struct aio_kiocb *kiocb, struct iocb *iocb)
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
 
 		spin_lock_irq(&ctx->poll_lock);
 		list_add_tail(&kiocb->ki_poll_list, &ctx->poll_pending);
 		spin_unlock_irq(&ctx->poll_lock);
 	} else {
+		req->ki_flags &= ~IOCB_HIPRI;
 		req->ki_complete = aio_complete_rw;
 	}
 
@@ -1761,8 +1712,7 @@ static int aio_prep_rw(struct aio_kiocb *kiocb, struct iocb *iocb)
 		ret = ioprio_check_cap(iocb->aio_reqprio);
 		if (ret) {
 			pr_debug("aio ioprio check cap error: %d\n", ret);
-			fput(req->ki_filp);
-			return ret;
+			goto out_fput;
 		}
 
 		req->ki_ioprio = iocb->aio_reqprio;
@@ -1771,7 +1721,10 @@ static int aio_prep_rw(struct aio_kiocb *kiocb, struct iocb *iocb)
 
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


--wRRV7LY7NUeQGEoC--
