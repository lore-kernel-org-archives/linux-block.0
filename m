Return-Path: <SRS0=MdGt=N4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BB08C43441
	for <linux-block@archiver.kernel.org>; Sat, 17 Nov 2018 23:53:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 156412080D
	for <linux-block@archiver.kernel.org>; Sat, 17 Nov 2018 23:53:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="oI4U8jTv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 156412080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbeKRKL5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 18 Nov 2018 05:11:57 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44293 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727016AbeKRKL4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 18 Nov 2018 05:11:56 -0500
Received: by mail-pg1-f193.google.com with SMTP id t13so3530035pgr.11
        for <linux-block@vger.kernel.org>; Sat, 17 Nov 2018 15:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mTSJ2QFc8hL9o2kJItLB24Z5pFY4xQb9PSb0QZqz8EQ=;
        b=oI4U8jTv/nvrR+UlMPOAwc60GGaDIV2qwP0jbf1ZBTpFR1JLNeF+ufpG3St1om++VK
         66BPHpEhpY0jmS8Hv3GYxzMSSG5IySFxnP68feWjoVY+o50BjCvMJUH82sgpD9ka+4bL
         fm5rYr8U7kPBtLyxk9QIVeMQGTdPk3ohv8+o8Bir8An0Zbgd7b5QHT4Q22JHW8hrZELi
         tvr/8x8DOYWsaS/ms5fS7fDQTWelG7zVGpNOIxN22ZggTLsscpnED0eI+iEVhMu42SeZ
         JKcRG6BUfGR/SkIEJOYldgb2109Pbkua8/xUfM9kUaCld4Fgnm6Or2hNCEx4kQQG+VxB
         ncEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mTSJ2QFc8hL9o2kJItLB24Z5pFY4xQb9PSb0QZqz8EQ=;
        b=XlApZfgI431iQuvVWe0TVLxGhV5v92F6OHxNrhZxvIK2RjAbDD3IrTXrNUMtjl4h7n
         P9gJCUHOJ9mO7P5PO41pJ+S8ZGPUdz497epI+QYE/Iz06Ap03EIa28rcryEuXO0h+cPt
         Iv7Qtib4na/Qe3LaYZB2Qzj5fofp/ZprowWB3g9QVyL0tjjqaVUrLjBauEzXoOx2mNjb
         qrEWSZjToTEjN5NQ1KSMebe/fB2aNPqXfMdnzBj9V9byiTMS6hJ6Ip7hVe9Mft57BlC4
         Sdean00ZJg11/nY6FAbW0gYyQxC/ePYEmVJFQVBZzybX/uzXBzIP8vG24pjZu4ZWCJWG
         UKog==
X-Gm-Message-State: AGRZ1gL5Znj21L+YqzKJPRylThMEb4c00t7rVT0ZVYcNvAS0O0+j5oI4
        ro0zH2OXYJWl0hYfcW2sSxBJMdBK++0=
X-Google-Smtp-Source: AJdET5cfoBPizUYBLd3elkfGd4ecENArs61FHFi1LkELoJIWY/x2jW7FLr6+Z17JiUJn1f3pzH+FJg==
X-Received: by 2002:a63:e711:: with SMTP id b17mr14612126pgi.363.1542498810386;
        Sat, 17 Nov 2018 15:53:30 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id m1sm15812345pgn.9.2018.11.17.15.53.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Nov 2018 15:53:29 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4/5] aio: support for IO polling
Date:   Sat, 17 Nov 2018 16:53:16 -0700
Message-Id: <20181117235317.7366-5-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181117235317.7366-1-axboe@kernel.dk>
References: <20181117235317.7366-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add polled variants of PREAD/PREADV and PWRITE/PWRITEV. These act
like their non-polled counterparts, except we expect to poll for
completion of them. The polling happens at io_getevent() time, and
works just like non-polled IO.

Polled IO doesn't support the user mapped completion ring. Events
must be reaped through the io_getevents() system call. For non-irq
driven poll devices, there's no way to support completion reaping
from userspace by just looking at the ring. The application itself
is the one that pulls completion entries.

It's illegal to mix polled and non-polled IO on the same ioctx.
This is because we need to know at io_getevents() time if we have
any non-polled IOs pending. For polled IO, we can never sleep in
the read_events() path, since polled IO may not trigger async
completions through an IRQ. In lieu of having some way of marking
an ioctx as strictly polled or non-polled, we track this state
and return -EINVAL if the application mixes the two types.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/aio.c                     | 490 ++++++++++++++++++++++++++++++++---
 include/uapi/linux/aio_abi.h |   2 +
 2 files changed, 463 insertions(+), 29 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 3d9bc81cf500..500da3ffc376 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -86,6 +86,11 @@ struct ctx_rq_wait {
 	atomic_t count;
 };
 
+enum {
+	CTX_TYPE_NORMAL = 0,
+	CTX_TYPE_POLLED,
+};
+
 struct kioctx {
 	struct percpu_ref	users;
 	atomic_t		dead;
@@ -96,6 +101,12 @@ struct kioctx {
 
 	struct __percpu kioctx_cpu *cpu;
 
+	/*
+	 * CTX_TYPE_ bits set. Used to not mix and match polled and
+	 * normal IO.
+	 */
+	unsigned long		io_type;
+
 	/*
 	 * For percpu reqs_available, number of slots we move to/from global
 	 * counter at a time:
@@ -138,6 +149,12 @@ struct kioctx {
 		atomic_t	reqs_available;
 	} ____cacheline_aligned_in_smp;
 
+	struct {
+		spinlock_t poll_lock;
+		struct list_head poll_pending;
+		struct list_head poll_done;
+	} ____cacheline_aligned_in_smp;
+
 	struct {
 		spinlock_t	ctx_lock;
 		struct list_head active_reqs;	/* used for cancellation */
@@ -191,6 +208,9 @@ struct aio_kiocb {
 
 	struct list_head	ki_list;	/* the aio core uses this
 						 * for cancellation */
+
+	struct list_head	ki_poll_list;
+
 	refcount_t		ki_refcnt;
 
 	/*
@@ -198,6 +218,12 @@ struct aio_kiocb {
 	 * this is the underlying eventfd context to deliver events to.
 	 */
 	struct eventfd_ctx	*ki_eventfd;
+
+	/*
+	 * For polled IO, stash completion info here
+	 */
+	long			ki_poll_res;
+	long			ki_poll_res2;
 };
 
 /*------ sysctl variables----*/
@@ -214,6 +240,8 @@ static struct vfsmount *aio_mnt;
 static const struct file_operations aio_ring_fops;
 static const struct address_space_operations aio_ctx_aops;
 
+static void aio_reap_polled_events(struct kioctx *);
+
 static struct file *aio_private_file(struct kioctx *ctx, loff_t nr_pages)
 {
 	struct file *file;
@@ -732,6 +760,10 @@ static struct kioctx *ioctx_alloc(unsigned nr_events)
 
 	INIT_LIST_HEAD(&ctx->active_reqs);
 
+	spin_lock_init(&ctx->poll_lock);
+	INIT_LIST_HEAD(&ctx->poll_pending);
+	INIT_LIST_HEAD(&ctx->poll_done);
+
 	if (percpu_ref_init(&ctx->users, free_ioctx_users, 0, GFP_KERNEL))
 		goto err;
 
@@ -814,6 +846,8 @@ static int kill_ioctx(struct mm_struct *mm, struct kioctx *ctx,
 	RCU_INIT_POINTER(table->table[ctx->id], NULL);
 	spin_unlock(&mm->ioctx_lock);
 
+	aio_reap_polled_events(ctx);
+
 	/* free_ioctx_reqs() will do the necessary RCU synchronization */
 	wake_up_all(&ctx->wait);
 
@@ -997,11 +1031,11 @@ static void user_refill_reqs_available(struct kioctx *ctx)
  *	Allocate a slot for an aio request.
  * Returns NULL if no requests are free.
  */
-static inline struct aio_kiocb *aio_get_req(struct kioctx *ctx)
+static inline struct aio_kiocb *aio_get_req(struct kioctx *ctx, bool needs_ring)
 {
 	struct aio_kiocb *req;
 
-	if (!get_reqs_available(ctx)) {
+	if (needs_ring && !get_reqs_available(ctx)) {
 		user_refill_reqs_available(ctx);
 		if (!get_reqs_available(ctx))
 			return NULL;
@@ -1013,11 +1047,13 @@ static inline struct aio_kiocb *aio_get_req(struct kioctx *ctx)
 
 	percpu_ref_get(&ctx->reqs);
 	INIT_LIST_HEAD(&req->ki_list);
+	INIT_LIST_HEAD(&req->ki_poll_list);
 	refcount_set(&req->ki_refcnt, 0);
 	req->ki_ctx = ctx;
 	return req;
 out_put:
-	put_reqs_available(ctx, 1);
+	if (needs_ring)
+		put_reqs_available(ctx, 1);
 	return NULL;
 }
 
@@ -1057,6 +1093,14 @@ static inline void iocb_put(struct aio_kiocb *iocb)
 	}
 }
 
+static void iocb_put_many(struct kioctx *ctx, void  **iocbs, int nr)
+{
+	if (nr) {
+		kmem_cache_free_bulk(kiocb_cachep, nr, iocbs);
+		percpu_ref_put_many(&ctx->reqs, nr);
+	}
+}
+
 /* aio_complete
  *	Called when the io request on the given iocb is complete.
  */
@@ -1240,6 +1284,299 @@ static bool aio_read_events(struct kioctx *ctx, long min_nr, long nr,
 	return ret < 0 || *i >= min_nr;
 }
 
+struct aio_iopoll_data {
+	unsigned int blk_qc;
+	struct block_device *bdev;
+};
+
+static int aio_io_poll(struct aio_iopoll_data *pd, bool wait)
+{
+#ifdef CONFIG_BLOCK
+	/*
+	 * Should only happen if someone sets ->ki_blk_qc at random,
+	 * not being a blockdev target. We'll just ignore it, the IO
+	 * will complete normally without being polled.
+	 */
+	if (pd->bdev)
+		return blk_poll(bdev_get_queue(pd->bdev), pd->blk_qc, wait);
+#endif
+
+	return 0;
+}
+
+static struct block_device *aio_bdev_host(struct kiocb *req)
+{
+	struct inode *inode = req->ki_filp->f_mapping->host;
+
+	if (S_ISBLK(inode->i_mode))
+		return I_BDEV(inode);
+
+	return NULL;
+}
+
+#define AIO_POLL_STACK	8
+
+struct aio_poll_data {
+	struct io_event __user *evs;
+	int off;
+	long max;
+	void *iocbs[AIO_POLL_STACK];
+	int to_free;
+};
+
+/*
+ * Process the done_list of iocbs, copy to user space, and free them.
+ * Migh return with data->iocbs holding entries, in which case
+ * data->to_free is non-zero and the caller should free them.
+ */
+static long aio_poll_reap(struct kioctx *ctx, struct aio_poll_data *data)
+	__releases(&ctx->poll_lock)
+	__acquires(&ctx->poll_lock)
+{
+	struct aio_kiocb *iocb;
+	int ret, nr = 0;
+
+restart:
+	while (!list_empty(&ctx->poll_done)) {
+		struct io_event __user *uev;
+		struct io_event ev;
+
+		if (data->to_free == ARRAY_SIZE(data->iocbs)) {
+			iocb_put_many(ctx, data->iocbs, data->to_free);
+			data->to_free = 0;
+		}
+
+		iocb = list_first_entry(&ctx->poll_done, struct aio_kiocb,
+						ki_poll_list);
+		list_del(&iocb->ki_poll_list);
+
+		data->iocbs[data->to_free++] = iocb;
+		if (!data->evs) {
+			nr++;
+			continue;
+		}
+
+		ev.obj = (u64)(unsigned long)iocb->ki_user_iocb;
+		ev.data = iocb->ki_user_data;
+		ev.res = iocb->ki_poll_res;
+		ev.res2 = iocb->ki_poll_res2;
+
+		uev = data->evs + nr + data->off;
+		if (!__copy_to_user_inatomic(uev, &ev, sizeof(*uev))) {
+			nr++;
+			if (nr + data->off < data->max)
+				continue;
+			break;
+		}
+
+		/*
+		 * Unexpected slow path, drop lock and attempt copy. If this
+		 * also fails, we're done. If it worked, we got another event
+		 * and we restart the list check since we dropped the lock.
+		 */
+		spin_unlock_irq(&ctx->poll_lock);
+		ret = copy_to_user(uev, &ev, sizeof(*uev));
+		spin_lock_irq(&ctx->poll_lock);
+		if (!ret) {
+			nr++;
+			if (nr + data->off < data->max)
+				goto restart;
+
+			break;
+		}
+
+		if (!nr)
+			nr = -EFAULT;
+		break;
+	}
+
+	return nr;
+}
+
+/*
+ * Reap done events, if any
+ */
+static long aio_poll_find(struct kioctx *ctx, struct io_event __user *evs,
+			  int off, long max)
+{
+	struct aio_poll_data data = {
+		.evs		= evs,
+		.off		= off,
+		.max		= max,
+		.to_free	= 0
+	};
+	int ret;
+
+	if (list_empty_careful(&ctx->poll_done))
+		return 0;
+
+	spin_lock_irq(&ctx->poll_lock);
+	ret = aio_poll_reap(ctx, &data);
+	spin_unlock_irq(&ctx->poll_lock);
+
+	if (data.to_free)
+		iocb_put_many(ctx, data.iocbs, data.to_free);
+
+	return ret;
+}
+
+static void aio_poll_for_events(struct kioctx *ctx, struct aio_iopoll_data *pd,
+				unsigned int nr_pd, int off, long min, long max)
+{
+	int i, polled = 0;
+
+	/*
+	 * Poll for needed events with wait == true, anything
+	 * after that we just check if we have more, up to max.
+	 */
+	for (i = 0; i < nr_pd; i++) {
+		bool wait = polled + off >= min;
+
+		polled += aio_io_poll(&pd[i], wait);
+		if (polled + off >= max)
+			break;
+
+		/*
+		 * If we have entries waiting to be reaped, stop polling
+		 */
+		if (!list_empty_careful(&ctx->poll_done))
+			break;
+	}
+}
+
+static int __aio_check_polled(struct kioctx *ctx, struct io_event __user *event,
+			      int off, unsigned int *entries, long min, long max)
+{
+	struct aio_iopoll_data pd[AIO_POLL_STACK];
+	struct aio_kiocb *iocb;
+	unsigned int nr_pd;
+	int ret, pre = 0;
+
+	if (list_empty_careful(&ctx->poll_pending))
+		goto out;
+
+	spin_lock_irq(&ctx->poll_lock);
+
+	/*
+	 * Check if we already have done events that satisfy what we need
+	 */
+	while (!list_empty(&ctx->poll_done)) {
+		struct aio_poll_data data = {
+			.evs = event,
+			.off = off,
+			.max = max,
+			.to_free = 0
+		};
+
+		ret = aio_poll_reap(ctx, &data);
+		if (!ret)
+			break;
+		else if (ret < 0 || ret + off >= min) {
+			spin_unlock_irq(&ctx->poll_lock);
+
+			if (data.to_free)
+				iocb_put_many(ctx, data.iocbs, data.to_free);
+
+			return ret;
+		}
+
+		if (data.to_free)
+			iocb_put_many(ctx, data.iocbs, data.to_free);
+
+		pre = ret;
+		off += ret;
+	}
+
+	/*
+	 * Find up to 'max_nr' worth of events to poll for, including the
+	 * events we already successfully polled
+	 */
+	nr_pd = 0;
+	list_for_each_entry(iocb, &ctx->poll_pending, ki_poll_list) {
+		struct kiocb *kiocb = &iocb->rw;
+		blk_qc_t qc;
+
+		/*
+		 * Not submitted yet, don't poll for it
+		 */
+		qc = READ_ONCE(kiocb->ki_blk_qc);
+		if (qc == BLK_QC_T_NONE)
+			continue;
+
+		pd[nr_pd].blk_qc = qc;
+		pd[nr_pd].bdev = aio_bdev_host(kiocb);
+
+		++nr_pd;
+		if (nr_pd == ARRAY_SIZE(pd) || nr_pd + off >= max)
+			break;
+	}
+	spin_unlock_irq(&ctx->poll_lock);
+
+	if (nr_pd) {
+		*entries = nr_pd;
+		aio_poll_for_events(ctx, pd, nr_pd, off, min, max);
+	}
+
+out:
+	ret = aio_poll_find(ctx, event, off, max);
+	if (ret >= 0)
+		return pre + ret;
+	else if (pre)
+		return pre;
+
+	return ret;
+}
+
+/*
+ * We can't just wait for polled events to come to us, we have to actively
+ * find and complete them.
+ */
+static void aio_reap_polled_events(struct kioctx *ctx)
+{
+	unsigned int loop, found;
+
+	if (!test_bit(CTX_TYPE_POLLED, &ctx->io_type))
+		return;
+
+	spin_lock_irq(&ctx->poll_lock);
+	while (!list_empty(&ctx->poll_pending) || !list_empty(&ctx->poll_done)) {
+		loop = 0;
+		spin_unlock_irq(&ctx->poll_lock);
+		found = __aio_check_polled(ctx, NULL, 0, &loop, 1, UINT_MAX);
+		spin_lock_irq(&ctx->poll_lock);
+	}
+	spin_unlock_irq(&ctx->poll_lock);
+}
+
+static int aio_check_polled(struct kioctx *ctx, long min_nr, long nr,
+			    struct io_event __user *event)
+{
+	unsigned int found;
+	int this, ret = 0;
+
+	if (!access_ok(VERIFY_WRITE, event, nr * sizeof(*event)))
+		return -EFAULT;
+
+	do {
+		int tmin;
+
+		if (ret && need_resched())
+			break;
+
+		found = 0;
+		tmin = ret >= min_nr ? 0 : min_nr - ret;
+		this = __aio_check_polled(ctx, event, ret, &found, tmin, nr);
+		if (this < 0) {
+			if (!ret)
+				ret = this;
+			break;
+		}
+		ret += this;
+	} while (found && ret < min_nr);
+
+	return ret;
+}
+
 static long read_events(struct kioctx *ctx, long min_nr, long nr,
 			struct io_event __user *event,
 			ktime_t until)
@@ -1391,13 +1728,8 @@ static void aio_remove_iocb(struct aio_kiocb *iocb)
 	spin_unlock_irqrestore(&ctx->ctx_lock, flags);
 }
 
-static void aio_complete_rw(struct kiocb *kiocb, long res, long res2)
+static void kiocb_end_write(struct kiocb *kiocb)
 {
-	struct aio_kiocb *iocb = container_of(kiocb, struct aio_kiocb, rw);
-
-	if (!list_empty_careful(&iocb->ki_list))
-		aio_remove_iocb(iocb);
-
 	if (kiocb->ki_flags & IOCB_WRITE) {
 		struct inode *inode = file_inode(kiocb->ki_filp);
 
@@ -1409,21 +1741,66 @@ static void aio_complete_rw(struct kiocb *kiocb, long res, long res2)
 			__sb_writers_acquired(inode->i_sb, SB_FREEZE_WRITE);
 		file_end_write(kiocb->ki_filp);
 	}
+}
+
+static void aio_complete_rw(struct kiocb *kiocb, long res, long res2)
+{
+	struct aio_kiocb *iocb = container_of(kiocb, struct aio_kiocb, rw);
+
+	if (!list_empty_careful(&iocb->ki_list))
+		aio_remove_iocb(iocb);
+
+	kiocb_end_write(kiocb);
 
 	fput(kiocb->ki_filp);
 	aio_complete(iocb, res, res2);
 }
 
-static int aio_prep_rw(struct kiocb *req, struct iocb *iocb)
+static void aio_complete_rw_poll(struct kiocb *kiocb, long res, long res2)
+{
+	struct aio_kiocb *iocb = container_of(kiocb, struct aio_kiocb, rw);
+	struct kioctx *ctx = iocb->ki_ctx;
+	struct file *filp = kiocb->ki_filp;
+	unsigned long flags;
+
+	kiocb_end_write(kiocb);
+
+	iocb->ki_poll_res = res;
+	iocb->ki_poll_res2 = res2;
+
+	spin_lock_irqsave(&ctx->poll_lock, flags);
+	list_move_tail(&iocb->ki_poll_list, &ctx->poll_done);
+	spin_unlock_irqrestore(&ctx->poll_lock, flags);
+
+	fput(filp);
+}
+
+static int aio_prep_rw(struct aio_kiocb *kiocb, struct iocb *iocb)
 {
+	struct kiocb *req = &kiocb->rw;
 	int ret;
 
 	req->ki_filp = fget(iocb->aio_fildes);
 	if (unlikely(!req->ki_filp))
 		return -EBADF;
-	req->ki_complete = aio_complete_rw;
-	req->ki_pos = iocb->aio_offset;
+
 	req->ki_flags = iocb_flags(req->ki_filp);
+
+	if (iocb->aio_flags & IOCB_FLAG_HIPRI) {
+		struct kioctx *ctx = kiocb->ki_ctx;
+
+		req->ki_flags |= IOCB_HIPRI;
+		req->ki_blk_qc = BLK_QC_T_NONE;
+		req->ki_complete = aio_complete_rw_poll;
+
+		spin_lock_irq(&ctx->poll_lock);
+		list_add_tail(&kiocb->ki_poll_list, &ctx->poll_pending);
+		spin_unlock_irq(&ctx->poll_lock);
+	} else {
+		req->ki_complete = aio_complete_rw;
+	}
+
+	req->ki_pos = iocb->aio_offset;
 	if (iocb->aio_flags & IOCB_FLAG_RESFD)
 		req->ki_flags |= IOCB_EVENTFD;
 	req->ki_hint = ki_hint_validate(file_write_hint(req->ki_filp));
@@ -1489,15 +1866,16 @@ static inline void aio_rw_done(struct kiocb *req, ssize_t ret)
 	}
 }
 
-static ssize_t aio_read(struct kiocb *req, struct iocb *iocb, bool vectored,
-		bool compat)
+static ssize_t aio_read(struct aio_kiocb *kiocb, struct iocb *iocb,
+			bool vectored, bool compat)
 {
 	struct iovec inline_vecs[UIO_FASTIOV], *iovec = inline_vecs;
+	struct kiocb *req = &kiocb->rw;
 	struct iov_iter iter;
 	struct file *file;
 	ssize_t ret;
 
-	ret = aio_prep_rw(req, iocb);
+	ret = aio_prep_rw(kiocb, iocb);
 	if (ret)
 		return ret;
 	file = req->ki_filp;
@@ -1522,15 +1900,16 @@ static ssize_t aio_read(struct kiocb *req, struct iocb *iocb, bool vectored,
 	return ret;
 }
 
-static ssize_t aio_write(struct kiocb *req, struct iocb *iocb, bool vectored,
-		bool compat)
+static ssize_t aio_write(struct aio_kiocb *kiocb, struct iocb *iocb,
+			 bool vectored, bool compat)
 {
 	struct iovec inline_vecs[UIO_FASTIOV], *iovec = inline_vecs;
+	struct kiocb *req = &kiocb->rw;
 	struct iov_iter iter;
 	struct file *file;
 	ssize_t ret;
 
-	ret = aio_prep_rw(req, iocb);
+	ret = aio_prep_rw(kiocb, iocb);
 	if (ret)
 		return ret;
 	file = req->ki_filp;
@@ -1774,11 +2153,30 @@ static ssize_t aio_poll(struct aio_kiocb *aiocb, struct iocb *iocb)
 	return 0;
 }
 
+/*
+ * We can't mix and match polled and non-polled IO on the same ctx. If this
+ * ctx is already of the appropriate type, we're good. If not and none is
+ * set, mark us that type and return success. If a type is set and it
+ * differs from the new IO, return -EINVAL.
+ */
+static int aio_test_and_mark_type(struct kioctx *ctx, int ctx_type)
+{
+	if (test_bit(ctx_type, &ctx->io_type)) {
+		return 0;
+	} else if (!ctx->io_type) {
+		set_bit(ctx_type, &ctx->io_type);
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
 static int io_submit_one(struct kioctx *ctx, struct iocb __user *user_iocb,
 			 bool compat)
 {
 	struct aio_kiocb *req;
 	struct iocb iocb;
+	int ctx_type;
 	ssize_t ret;
 
 	if (unlikely(copy_from_user(&iocb, user_iocb, sizeof(iocb))))
@@ -1800,7 +2198,15 @@ static int io_submit_one(struct kioctx *ctx, struct iocb __user *user_iocb,
 		return -EINVAL;
 	}
 
-	req = aio_get_req(ctx);
+	if (iocb.aio_flags & IOCB_FLAG_HIPRI)
+		ctx_type = CTX_TYPE_POLLED;
+	else
+		ctx_type = CTX_TYPE_NORMAL;
+
+	/*
+	 * Polled IO doesn't need ring reservations
+	 */
+	req = aio_get_req(ctx, ctx_type == CTX_TYPE_NORMAL);
 	if (unlikely(!req))
 		return -EAGAIN;
 
@@ -1830,24 +2236,45 @@ static int io_submit_one(struct kioctx *ctx, struct iocb __user *user_iocb,
 
 	switch (iocb.aio_lio_opcode) {
 	case IOCB_CMD_PREAD:
-		ret = aio_read(&req->rw, &iocb, false, compat);
+		ret = aio_test_and_mark_type(ctx, ctx_type);
+		if (ret)
+			break;
+		ret = aio_read(req, &iocb, false, compat);
 		break;
 	case IOCB_CMD_PWRITE:
-		ret = aio_write(&req->rw, &iocb, false, compat);
+		ret = aio_test_and_mark_type(ctx, ctx_type);
+		if (ret)
+			break;
+		ret = aio_write(req, &iocb, false, compat);
 		break;
 	case IOCB_CMD_PREADV:
-		ret = aio_read(&req->rw, &iocb, true, compat);
+		ret = aio_test_and_mark_type(ctx, ctx_type);
+		if (ret)
+			break;
+		ret = aio_read(req, &iocb, true, compat);
 		break;
 	case IOCB_CMD_PWRITEV:
-		ret = aio_write(&req->rw, &iocb, true, compat);
+		ret = aio_test_and_mark_type(ctx, ctx_type);
+		if (ret)
+			break;
+		ret = aio_write(req, &iocb, true, compat);
 		break;
 	case IOCB_CMD_FSYNC:
+		ret = aio_test_and_mark_type(ctx, false);
+		if (ret)
+			break;
 		ret = aio_fsync(&req->fsync, &iocb, false);
 		break;
 	case IOCB_CMD_FDSYNC:
+		ret = aio_test_and_mark_type(ctx, false);
+		if (ret)
+			break;
 		ret = aio_fsync(&req->fsync, &iocb, true);
 		break;
 	case IOCB_CMD_POLL:
+		ret = aio_test_and_mark_type(ctx, false);
+		if (ret)
+			break;
 		ret = aio_poll(req, &iocb);
 		break;
 	default:
@@ -1861,11 +2288,12 @@ static int io_submit_one(struct kioctx *ctx, struct iocb __user *user_iocb,
 	 * arranged for that to be done asynchronously.  Anything non-zero
 	 * means that we need to destroy req ourselves.
 	 */
-	if (ret)
-		goto out_put_req;
-	return 0;
+	if (!ret)
+		return 0;
+
 out_put_req:
-	put_reqs_available(ctx, 1);
+	if (ctx_type == CTX_TYPE_NORMAL)
+		put_reqs_available(ctx, 1);
 	percpu_ref_put(&ctx->reqs);
 	if (req->ki_eventfd)
 		eventfd_ctx_put(req->ki_eventfd);
@@ -2043,8 +2471,12 @@ static long do_io_getevents(aio_context_t ctx_id,
 	long ret = -EINVAL;
 
 	if (likely(ioctx)) {
-		if (likely(min_nr <= nr && min_nr >= 0))
-			ret = read_events(ioctx, min_nr, nr, events, until);
+		if (likely(min_nr <= nr && min_nr >= 0)) {
+			if (test_bit(CTX_TYPE_POLLED, &ioctx->io_type))
+				ret = aio_check_polled(ioctx, min_nr, nr, events);
+			else
+				ret = read_events(ioctx, min_nr, nr, events, until);
+		}
 		percpu_ref_put(&ioctx->users);
 	}
 
diff --git a/include/uapi/linux/aio_abi.h b/include/uapi/linux/aio_abi.h
index ce43d340f010..bfa553a2324b 100644
--- a/include/uapi/linux/aio_abi.h
+++ b/include/uapi/linux/aio_abi.h
@@ -50,9 +50,11 @@ enum {
  *
  * IOCB_FLAG_RESFD - Set if the "aio_resfd" member of the "struct iocb"
  *                   is valid.
+ * IOCB_FLAG_HIPRI - Use IO completion polling
  */
 #define IOCB_FLAG_RESFD		(1 << 0)
 #define IOCB_FLAG_IOPRIO	(1 << 1)
+#define IOCB_FLAG_HIPRI		(1 << 2)
 
 /* read() from /dev/aio returns these structures. */
 struct io_event {
-- 
2.17.1

