Return-Path: <SRS0=+5f8=OJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ACC5C04EB8
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 16:57:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8D412145D
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 16:57:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="w4eaNS/C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8D412145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbeLAEHO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Nov 2018 23:07:14 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:40646 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727592AbeLAEHO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Nov 2018 23:07:14 -0500
Received: by mail-it1-f196.google.com with SMTP id h193so10216773ita.5
        for <linux-block@vger.kernel.org>; Fri, 30 Nov 2018 08:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sQLMf2lCjXlFfggxx2kifv1G3GLA0iPim2lyNjDBjHI=;
        b=w4eaNS/CIgCC+HE0z4k10W1lLwAry1H1WqPFbXS0WS6aNggXrLqmK4OjU+adAX/Brk
         /YccX3wiifAdeaRmH388EXo16M8KIWl8Psv6IrGc0RHJd6dsw88CDls+RFIS9V/AgAIB
         HVe3PYq/AzgRd3Y5Hp0D5uobcxIjeYnoqdxjAZeyhjueaUFzDfmHqJzh4MJlGoY9Ob0h
         Ah2nbUK5KJK/t9W4WdI7uKEm3iQWZFKSHohfb7XplzuI3vixgMKQgm96XbAuwS6iMC+l
         aE0bYY/ACYtW2mf4zKh23F6bxappW4NfVPh+Oq1VD2mShffrNGs1cxgzswXe+MHi0Fca
         xYVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sQLMf2lCjXlFfggxx2kifv1G3GLA0iPim2lyNjDBjHI=;
        b=CNUiMDOblld9EUo74GpovDVWK4UBe9faRDvlJY8r4ShlyIjjJwK7dn/rgHubXAVohF
         sVhz9SZNqwcM+zTn6A+xXsttsj2kbtUyOlDEAKAap/LfytgfjdUaGgZFIFSlSM0w8MwL
         FB0lH2bk1xoDmKdF8M9zPCLPw9NkcAaVjSyjnzUMQgTg+lxNQ4bfvKjqetEiEGFFCQzI
         w6ZQxWUYuFYmwcgLD2KmUZ9ZF0Mc8x9gQjQHhNNsKV8FGQBvy+QR7HlEvae6VIbCGs5Z
         z7sNZ987JFm//BATO++/pi+GaWXYbCgm4swdWsN9cyEyvF9PBvCHI3QuR3dPCfDKYxKg
         nr+g==
X-Gm-Message-State: AA+aEWZ+odSE6gJW1YCF3KkGAgZH4o8D8AvJ3YFYFE+YttD3oJ1BUJq0
        OYLWriF5BUHTSr0ZmVT9BsbcQBEVUts=
X-Google-Smtp-Source: AFSGD/VvKwEwa+TBFAQzvIZ4gqvBNtjpve/2djpwLo+PxUqXG9REa4I6GPkFzxEnofm5cxHUoG4FCA==
X-Received: by 2002:a02:9549:: with SMTP id y67mr5840339jah.4.1543597037056;
        Fri, 30 Nov 2018 08:57:17 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id j133sm2979447itj.16.2018.11.30.08.57.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 08:57:16 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org
Cc:     hch@lst.de, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 17/27] aio: support for IO polling
Date:   Fri, 30 Nov 2018 09:56:36 -0700
Message-Id: <20181130165646.27341-18-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181130165646.27341-1-axboe@kernel.dk>
References: <20181130165646.27341-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add polled variants of PREAD/PREADV and PWRITE/PWRITEV. These act
like their non-polled counterparts, except we expect to poll for
completion of them. The polling happens at io_getevent() time, and
works just like non-polled IO.

To setup an io_context for polled IO, the application must call
io_setup2() with IOCTX_FLAG_IOPOLL as one of the flags. It is illegal
to mix and match polled and non-polled IO on an io_context.

Polled IO doesn't support the user mapped completion ring. Events
must be reaped through the io_getevents() system call. For non-irq
driven poll devices, there's no way to support completion reaping
from userspace by just looking at the ring. The application itself
is the one that pulls completion entries.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/aio.c                     | 381 +++++++++++++++++++++++++++++++----
 include/uapi/linux/aio_abi.h |   3 +
 2 files changed, 348 insertions(+), 36 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 380e6fe8c429..f7a49abc7694 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -143,6 +143,18 @@ struct kioctx {
 		atomic_t	reqs_available;
 	} ____cacheline_aligned_in_smp;
 
+	/* iopoll submission state */
+	struct {
+		spinlock_t poll_lock;
+		struct list_head poll_submitted;
+	} ____cacheline_aligned_in_smp;
+
+	/* iopoll completion state */
+	struct {
+		struct list_head poll_completing;
+		struct mutex getevents_lock;
+	} ____cacheline_aligned_in_smp;
+
 	struct {
 		spinlock_t	ctx_lock;
 		struct list_head active_reqs;	/* used for cancellation */
@@ -195,14 +207,27 @@ struct aio_kiocb {
 	__u64			ki_user_data;	/* user's data for completion */
 
 	struct list_head	ki_list;	/* the aio core uses this
-						 * for cancellation */
+						 * for cancellation, or for
+						 * polled IO */
+
+	unsigned long		ki_flags;
+#define IOCB_POLL_COMPLETED	0
+#define IOCB_POLL_BUSY		1
+
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
+
+		/*
+		 * For polled IO, stash completion info here
+		 */
+		struct io_event		ki_ev;
+	};
 };
 
 /*------ sysctl variables----*/
@@ -223,6 +248,7 @@ static const unsigned int iocb_page_shift =
 				ilog2(PAGE_SIZE / sizeof(struct iocb));
 
 static void aio_useriocb_free(struct kioctx *);
+static void aio_iopoll_reap_events(struct kioctx *);
 
 static struct file *aio_private_file(struct kioctx *ctx, loff_t nr_pages)
 {
@@ -461,11 +487,15 @@ static int aio_setup_ring(struct kioctx *ctx, unsigned int nr_events)
 	int i;
 	struct file *file;
 
-	/* Compensate for the ring buffer's head/tail overlap entry */
-	nr_events += 2;	/* 1 is required, 2 for good luck */
-
+	/*
+	 * Compensate for the ring buffer's head/tail overlap entry.
+	 * IO polling doesn't require any io event entries
+	 */
 	size = sizeof(struct aio_ring);
-	size += sizeof(struct io_event) * nr_events;
+	if (!(ctx->flags & IOCTX_FLAG_IOPOLL)) {
+		nr_events += 2;	/* 1 is required, 2 for good luck */
+		size += sizeof(struct io_event) * nr_events;
+	}
 
 	nr_pages = PFN_UP(size);
 	if (nr_pages < 0)
@@ -747,6 +777,11 @@ static struct kioctx *io_setup_flags(unsigned long ctxid,
 
 	INIT_LIST_HEAD(&ctx->active_reqs);
 
+	spin_lock_init(&ctx->poll_lock);
+	INIT_LIST_HEAD(&ctx->poll_submitted);
+	INIT_LIST_HEAD(&ctx->poll_completing);
+	mutex_init(&ctx->getevents_lock);
+
 	if (percpu_ref_init(&ctx->users, free_ioctx_users, 0, GFP_KERNEL))
 		goto err;
 
@@ -818,11 +853,15 @@ static int kill_ioctx(struct mm_struct *mm, struct kioctx *ctx,
 {
 	struct kioctx_table *table;
 
+	mutex_lock(&ctx->getevents_lock);
 	spin_lock(&mm->ioctx_lock);
 	if (atomic_xchg(&ctx->dead, 1)) {
 		spin_unlock(&mm->ioctx_lock);
+		mutex_unlock(&ctx->getevents_lock);
 		return -EINVAL;
 	}
+	aio_iopoll_reap_events(ctx);
+	mutex_unlock(&ctx->getevents_lock);
 
 	table = rcu_dereference_raw(mm->ioctx_table);
 	WARN_ON(ctx != rcu_access_pointer(table->table[ctx->id]));
@@ -1029,6 +1068,7 @@ static inline struct aio_kiocb *aio_get_req(struct kioctx *ctx)
 		percpu_ref_get(&ctx->reqs);
 		req->ki_ctx = ctx;
 		INIT_LIST_HEAD(&req->ki_list);
+		req->ki_flags = 0;
 		refcount_set(&req->ki_refcnt, 0);
 		req->ki_eventfd = NULL;
 	}
@@ -1072,6 +1112,15 @@ static inline void iocb_put(struct aio_kiocb *iocb)
 	}
 }
 
+static void iocb_put_many(struct kioctx *ctx, void **iocbs, int *nr)
+{
+	if (*nr) {
+		percpu_ref_put_many(&ctx->reqs, *nr);
+		kmem_cache_free_bulk(kiocb_cachep, *nr, iocbs);
+		*nr = 0;
+	}
+}
+
 static void aio_fill_event(struct io_event *ev, struct aio_kiocb *iocb,
 			   long res, long res2)
 {
@@ -1261,6 +1310,170 @@ static bool aio_read_events(struct kioctx *ctx, long min_nr, long nr,
 	return ret < 0 || *i >= min_nr;
 }
 
+#define AIO_IOPOLL_BATCH	8
+
+/*
+ * Process completed iocb iopoll entries, copying the result to userspace.
+ */
+static long aio_iopoll_reap(struct kioctx *ctx, struct io_event __user *evs,
+			    unsigned int *nr_events, long max)
+{
+	void *iocbs[AIO_IOPOLL_BATCH];
+	struct aio_kiocb *iocb, *n;
+	int to_free = 0, ret = 0;
+
+	/* Shouldn't happen... */
+	if (*nr_events >= max)
+		return 0;
+
+	list_for_each_entry_safe(iocb, n, &ctx->poll_completing, ki_list) {
+		if (*nr_events == max)
+			break;
+		if (!test_bit(IOCB_POLL_COMPLETED, &iocb->ki_flags))
+			continue;
+		if (to_free == AIO_IOPOLL_BATCH)
+			iocb_put_many(ctx, iocbs, &to_free);
+
+		list_del(&iocb->ki_list);
+		iocbs[to_free++] = iocb;
+
+		fput(iocb->rw.ki_filp);
+
+		if (evs && copy_to_user(evs + *nr_events, &iocb->ki_ev,
+		    sizeof(iocb->ki_ev))) {
+			ret = -EFAULT;
+			break;
+		}
+		(*nr_events)++;
+	}
+
+	if (to_free)
+		iocb_put_many(ctx, iocbs, &to_free);
+
+	return ret;
+}
+
+static int __aio_iopoll_check(struct kioctx *ctx, struct io_event __user *event,
+			      unsigned int *nr_events, long min, long max)
+{
+	struct aio_kiocb *iocb;
+	int to_poll, polled, ret;
+
+	/*
+	 * Check if we already have done events that satisfy what we need
+	 */
+	if (!list_empty(&ctx->poll_completing)) {
+		ret = aio_iopoll_reap(ctx, event, nr_events, max);
+		if (ret < 0)
+			return ret;
+		if (*nr_events >= min)
+			return 0;
+	}
+
+	/*
+	 * Take in a new working set from the submitted list, if possible.
+	 */
+	if (!list_empty_careful(&ctx->poll_submitted)) {
+		spin_lock(&ctx->poll_lock);
+		list_splice_init(&ctx->poll_submitted, &ctx->poll_completing);
+		spin_unlock(&ctx->poll_lock);
+	}
+
+	if (list_empty(&ctx->poll_completing))
+		return 0;
+
+	/*
+	 * Check again now that we have a new batch.
+	 */
+	ret = aio_iopoll_reap(ctx, event, nr_events, max);
+	if (ret < 0)
+		return ret;
+	if (*nr_events >= min)
+		return 0;
+
+	/*
+	 * Find up to 'max' worth of events to poll for, including the
+	 * events we already successfully polled
+	 */
+	polled = to_poll = 0;
+	list_for_each_entry(iocb, &ctx->poll_completing, ki_list) {
+		/*
+		 * Poll for needed events with spin == true, anything after
+		 * that we just check if we have more, up to max.
+		 */
+		bool spin = polled + *nr_events >= min;
+		struct kiocb *kiocb = &iocb->rw;
+
+		if (test_bit(IOCB_POLL_COMPLETED, &iocb->ki_flags))
+			break;
+		if (++to_poll + *nr_events > max)
+			break;
+
+		ret = kiocb->ki_filp->f_op->iopoll(kiocb, spin);
+		if (ret < 0)
+			return ret;
+
+		polled += ret;
+		if (polled + *nr_events >= max)
+			break;
+	}
+
+	ret = aio_iopoll_reap(ctx, event, nr_events, max);
+	if (ret < 0)
+		return ret;
+	if (*nr_events >= min)
+		return 0;
+	return to_poll;
+}
+
+/*
+ * We can't just wait for polled events to come to us, we have to actively
+ * find and complete them.
+ */
+static void aio_iopoll_reap_events(struct kioctx *ctx)
+{
+	if (!(ctx->flags & IOCTX_FLAG_IOPOLL))
+		return;
+
+	while (!list_empty_careful(&ctx->poll_submitted) ||
+	       !list_empty(&ctx->poll_completing)) {
+		unsigned int nr_events = 0;
+
+		__aio_iopoll_check(ctx, NULL, &nr_events, 1, UINT_MAX);
+	}
+}
+
+static int aio_iopoll_check(struct kioctx *ctx, long min_nr, long nr,
+			    struct io_event __user *event)
+{
+	unsigned int nr_events = 0;
+	int ret = 0;
+
+	/* Only allow one thread polling at a time */
+	if (!mutex_trylock(&ctx->getevents_lock))
+		return -EBUSY;
+	if (unlikely(atomic_read(&ctx->dead))) {
+		ret = -EINVAL;
+		goto err;
+	}
+
+	while (!nr_events || !need_resched()) {
+		int tmin = 0;
+
+		if (nr_events < min_nr)
+			tmin = min_nr - nr_events;
+
+		ret = __aio_iopoll_check(ctx, event, &nr_events, tmin, nr);
+		if (ret <= 0)
+			break;
+		ret = 0;
+	}
+
+err:
+	mutex_unlock(&ctx->getevents_lock);
+	return nr_events ? nr_events : ret;
+}
+
 static long read_events(struct kioctx *ctx, long min_nr, long nr,
 			struct io_event __user *event,
 			ktime_t until)
@@ -1352,7 +1565,7 @@ SYSCALL_DEFINE4(io_setup2, u32, nr_events, u32, flags, struct iocb * __user,
 	unsigned long ctx;
 	long ret;
 
-	if (flags & ~IOCTX_FLAG_USERIOCB)
+	if (flags & ~(IOCTX_FLAG_USERIOCB | IOCTX_FLAG_IOPOLL))
 		return -EINVAL;
 
 	ret = get_user(ctx, ctxp);
@@ -1485,13 +1698,8 @@ static void aio_remove_iocb(struct aio_kiocb *iocb)
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
 
@@ -1503,19 +1711,48 @@ static void aio_complete_rw(struct kiocb *kiocb, long res, long res2)
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
 
-static int aio_prep_rw(struct kiocb *req, const struct iocb *iocb)
+static void aio_complete_rw_poll(struct kiocb *kiocb, long res, long res2)
 {
+	struct aio_kiocb *iocb = container_of(kiocb, struct aio_kiocb, rw);
+
+	kiocb_end_write(kiocb);
+
+	/*
+	 * Handle EAGAIN from resource limits with polled IO inline, don't
+	 * pass the event back to userspace.
+	 */
+	if (unlikely(res == -EAGAIN))
+		set_bit(IOCB_POLL_BUSY, &iocb->ki_flags);
+	else {
+		aio_fill_event(&iocb->ki_ev, iocb, res, res2);
+		set_bit(IOCB_POLL_COMPLETED, &iocb->ki_flags);
+	}
+}
+
+static int aio_prep_rw(struct aio_kiocb *kiocb, const struct iocb *iocb)
+{
+	struct kioctx *ctx = kiocb->ki_ctx;
+	struct kiocb *req = &kiocb->rw;
 	int ret;
 
 	req->ki_filp = fget(iocb->aio_fildes);
 	if (unlikely(!req->ki_filp))
 		return -EBADF;
-	req->ki_complete = aio_complete_rw;
 	req->ki_pos = iocb->aio_offset;
 	req->ki_flags = iocb_flags(req->ki_filp);
 	if (iocb->aio_flags & IOCB_FLAG_RESFD)
@@ -1541,9 +1778,35 @@ static int aio_prep_rw(struct kiocb *req, const struct iocb *iocb)
 	if (unlikely(ret))
 		goto out_fput;
 
-	req->ki_flags &= ~IOCB_HIPRI; /* no one is going to poll for this I/O */
-	return 0;
+	if (iocb->aio_flags & IOCB_FLAG_HIPRI) {
+		/* shares space in the union, and is rather pointless.. */
+		ret = -EINVAL;
+		if (iocb->aio_flags & IOCB_FLAG_RESFD)
+			goto out_fput;
+
+		/* can't submit polled IO to a non-polled ctx */
+		if (!(ctx->flags & IOCTX_FLAG_IOPOLL))
+			goto out_fput;
+
+		ret = -EOPNOTSUPP;
+		if (!(req->ki_flags & IOCB_DIRECT) ||
+		    !req->ki_filp->f_op->iopoll)
+			goto out_fput;
+
+		req->ki_flags |= IOCB_HIPRI;
+		req->ki_complete = aio_complete_rw_poll;
+	} else {
+		/* can't submit non-polled IO to a polled ctx */
+		ret = -EINVAL;
+		if (ctx->flags & IOCTX_FLAG_IOPOLL)
+			goto out_fput;
+
+		/* no one is going to poll for this I/O */
+		req->ki_flags &= ~IOCB_HIPRI;
+		req->ki_complete = aio_complete_rw;
+	}
 
+	return 0;
 out_fput:
 	fput(req->ki_filp);
 	return ret;
@@ -1588,15 +1851,40 @@ static inline void aio_rw_done(struct kiocb *req, ssize_t ret)
 	}
 }
 
-static ssize_t aio_read(struct kiocb *req, const struct iocb *iocb,
+/*
+ * After the iocb has been issued, it's safe to be found on the poll list.
+ * Adding the kiocb to the list AFTER submission ensures that we don't
+ * find it from a io_getevents() thread before the issuer is done accessing
+ * the kiocb cookie.
+ */
+static void aio_iopoll_iocb_issued(struct aio_kiocb *kiocb)
+{
+	/*
+	 * For fast devices, IO may have already completed. If it has, add
+	 * it to the front so we find it first. We can't add to the poll_done
+	 * list as that's unlocked from the completion side.
+	 */
+	const int front_add = test_bit(IOCB_POLL_COMPLETED, &kiocb->ki_flags);
+	struct kioctx *ctx = kiocb->ki_ctx;
+
+	spin_lock(&ctx->poll_lock);
+	if (front_add)
+		list_add(&kiocb->ki_list, &ctx->poll_submitted);
+	else
+		list_add_tail(&kiocb->ki_list, &ctx->poll_submitted);
+	spin_unlock(&ctx->poll_lock);
+}
+
+static ssize_t aio_read(struct aio_kiocb *kiocb, const struct iocb *iocb,
 			bool vectored, bool compat)
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
@@ -1621,15 +1909,16 @@ static ssize_t aio_read(struct kiocb *req, const struct iocb *iocb,
 	return ret;
 }
 
-static ssize_t aio_write(struct kiocb *req, const struct iocb *iocb,
+static ssize_t aio_write(struct aio_kiocb *kiocb, const struct iocb *iocb,
 			 bool vectored, bool compat)
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
@@ -1900,7 +2189,8 @@ static int __io_submit_one(struct kioctx *ctx, const struct iocb *iocb,
 		return -EINVAL;
 	}
 
-	if (!get_reqs_available(ctx))
+	/* Poll IO doesn't need ring reservations */
+	if (!(ctx->flags & IOCTX_FLAG_IOPOLL) && !get_reqs_available(ctx))
 		return -EAGAIN;
 
 	ret = -EAGAIN;
@@ -1923,8 +2213,8 @@ static int __io_submit_one(struct kioctx *ctx, const struct iocb *iocb,
 		}
 	}
 
-	/* Don't support cancel on user mapped iocbs */
-	if (!(ctx->flags & IOCTX_FLAG_USERIOCB)) {
+	/* Don't support cancel on user mapped iocbs or polled context */
+	if (!(ctx->flags & (IOCTX_FLAG_USERIOCB | IOCTX_FLAG_IOPOLL))) {
 		ret = put_user(KIOCB_KEY, &user_iocb->aio_key);
 		if (unlikely(ret)) {
 			pr_debug("EFAULT: aio_key\n");
@@ -1935,26 +2225,33 @@ static int __io_submit_one(struct kioctx *ctx, const struct iocb *iocb,
 	req->ki_user_iocb = user_iocb;
 	req->ki_user_data = iocb->aio_data;
 
+	ret = -EINVAL;
 	switch (iocb->aio_lio_opcode) {
 	case IOCB_CMD_PREAD:
-		ret = aio_read(&req->rw, iocb, false, compat);
+		ret = aio_read(req, iocb, false, compat);
 		break;
 	case IOCB_CMD_PWRITE:
-		ret = aio_write(&req->rw, iocb, false, compat);
+		ret = aio_write(req, iocb, false, compat);
 		break;
 	case IOCB_CMD_PREADV:
-		ret = aio_read(&req->rw, iocb, true, compat);
+		ret = aio_read(req, iocb, true, compat);
 		break;
 	case IOCB_CMD_PWRITEV:
-		ret = aio_write(&req->rw, iocb, true, compat);
+		ret = aio_write(req, iocb, true, compat);
 		break;
 	case IOCB_CMD_FSYNC:
+		if (ctx->flags & IOCTX_FLAG_IOPOLL)
+			break;
 		ret = aio_fsync(&req->fsync, iocb, false);
 		break;
 	case IOCB_CMD_FDSYNC:
+		if (ctx->flags & IOCTX_FLAG_IOPOLL)
+			break;
 		ret = aio_fsync(&req->fsync, iocb, true);
 		break;
 	case IOCB_CMD_POLL:
+		if (ctx->flags & IOCTX_FLAG_IOPOLL)
+			break;
 		ret = aio_poll(req, iocb);
 		break;
 	default:
@@ -1970,13 +2267,21 @@ static int __io_submit_one(struct kioctx *ctx, const struct iocb *iocb,
 	 */
 	if (ret)
 		goto out_put_req;
+	if (ctx->flags & IOCTX_FLAG_IOPOLL) {
+		if (test_bit(IOCB_POLL_BUSY, &req->ki_flags)) {
+			ret = -EAGAIN;
+			goto out_put_req;
+		}
+		aio_iopoll_iocb_issued(req);
+	}
 	return 0;
 out_put_req:
 	if (req->ki_eventfd)
 		eventfd_ctx_put(req->ki_eventfd);
 	iocb_put(req);
 out_put_reqs_available:
-	put_reqs_available(ctx, 1);
+	if (!(ctx->flags & IOCTX_FLAG_IOPOLL))
+		put_reqs_available(ctx, 1);
 	return ret;
 }
 
@@ -2148,7 +2453,7 @@ SYSCALL_DEFINE3(io_cancel, aio_context_t, ctx_id, struct iocb __user *, iocb,
 	if (unlikely(!ctx))
 		return -EINVAL;
 
-	if (ctx->flags & IOCTX_FLAG_USERIOCB)
+	if (ctx->flags & (IOCTX_FLAG_USERIOCB | IOCTX_FLAG_IOPOLL))
 		goto err;
 
 	spin_lock_irq(&ctx->ctx_lock);
@@ -2183,8 +2488,12 @@ static long do_io_getevents(aio_context_t ctx_id,
 	long ret = -EINVAL;
 
 	if (likely(ioctx)) {
-		if (likely(min_nr <= nr && min_nr >= 0))
-			ret = read_events(ioctx, min_nr, nr, events, until);
+		if (likely(min_nr <= nr && min_nr >= 0)) {
+			if (ioctx->flags & IOCTX_FLAG_IOPOLL)
+				ret = aio_iopoll_check(ioctx, min_nr, nr, events);
+			else
+				ret = read_events(ioctx, min_nr, nr, events, until);
+		}
 		percpu_ref_put(&ioctx->users);
 	}
 
diff --git a/include/uapi/linux/aio_abi.h b/include/uapi/linux/aio_abi.h
index 814e6606c413..ea0b9a19f4df 100644
--- a/include/uapi/linux/aio_abi.h
+++ b/include/uapi/linux/aio_abi.h
@@ -52,9 +52,11 @@ enum {
  *                   is valid.
  * IOCB_FLAG_IOPRIO - Set if the "aio_reqprio" member of the "struct iocb"
  *                    is valid.
+ * IOCB_FLAG_HIPRI - Use IO completion polling
  */
 #define IOCB_FLAG_RESFD		(1 << 0)
 #define IOCB_FLAG_IOPRIO	(1 << 1)
+#define IOCB_FLAG_HIPRI		(1 << 2)
 
 /* read() from /dev/aio returns these structures. */
 struct io_event {
@@ -107,6 +109,7 @@ struct iocb {
 }; /* 64 bytes */
 
 #define IOCTX_FLAG_USERIOCB	(1 << 0)	/* iocbs are user mapped */
+#define IOCTX_FLAG_IOPOLL	(1 << 1)	/* io_context is polled */
 
 #undef IFBIG
 #undef IFLITTLE
-- 
2.17.1

