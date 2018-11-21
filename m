Return-Path: <SRS0=SuLc=OA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE38C43441
	for <linux-block@archiver.kernel.org>; Wed, 21 Nov 2018 11:12:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B1222147D
	for <linux-block@archiver.kernel.org>; Wed, 21 Nov 2018 11:12:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=scylladb-com.20150623.gappssmtp.com header.i=@scylladb-com.20150623.gappssmtp.com header.b="Yo3KFUcZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B1222147D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=scylladb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728460AbeKUVqk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Nov 2018 16:46:40 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36448 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728114AbeKUVqk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Nov 2018 16:46:40 -0500
Received: by mail-wr1-f65.google.com with SMTP id t3so5239559wrr.3
        for <linux-block@vger.kernel.org>; Wed, 21 Nov 2018 03:12:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=scylladb-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:date:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=d1T5ir42u1PnaI6OqgQiTf153PEVzIfIhrA1FMNXXzg=;
        b=Yo3KFUcZwZZA7Ifx1vZnHf+hMI6xq6cVKfWCMMIzju8jFDBtjNTt303D0Uz7Wh9Eyo
         ZA3weerdik3bg+2+xgKBSI3FWV9qW58NPACRNauVuMSPJeTj0bvs5MnCd4+nfZzA3jlO
         jn18TMJ3dDstub5II+7kGRy8HqdBcgSM71FPekdUIiOSd0CBFIaA41r+sM24JnGkqjfc
         iKa/4v2ioKMXEy1OE7NwdjYSiI+OGQXZyD2UBAmRr5J8E6iVhsiGFCeJBGuv4HdcOG7P
         mrlybHIPw21ChWrIJmj7N1Wgxw1RGRYM5HAy/xIeQPusC8ZdnSEB5f9vfRsVBh2+issN
         P4hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d1T5ir42u1PnaI6OqgQiTf153PEVzIfIhrA1FMNXXzg=;
        b=kCemkmKjnGv4OfEargtwSrd+lGqe8k6ltWs3Ne9mOxwwz3qFcXw/isOCk/HJlXV7H1
         qW8UEA+fhw2PHYyzMnSIiZwF/qAqI3b3xnt827nnwN3mPHxcXCCje7IFFbP/AMM8vQdl
         yrxZ3IzbTcKKkovVZY0RVc921Ng/3Ye217WsFtWwtw4SuelX6X6hii78+KYMtbocSeIT
         PRdKx3OkUcy6b6clQF6TIb4H+HNHPr08Qxq0Ot5/l7U0T7J2DZ1OaDWm32rxbQ6QHa4Z
         YjwU8D1s0Kx0B5wJ3UGAea6rtWsr07T2hwwLv8cY5nSlizLenhZdjhpDTIXAla9ooOBA
         yS+w==
X-Gm-Message-State: AA+aEWZ1Vir5qxd6+4DZgpdjFbPDv2hwANR3wAcX5v5k7Wg2Y2qmFqKA
        nQjt1Bpx9LrWeDDiApoa288Llg==
X-Google-Smtp-Source: AFSGD/Xo26oJfUMoO+tz0sX3Cjvo27wjDK3cEZJ0HW00uJmpNQlo9xDeGClF+bmzZ7VlVAwLbrTt8w==
X-Received: by 2002:adf:be8d:: with SMTP id i13mr5478584wrh.235.1542798758762;
        Wed, 21 Nov 2018 03:12:38 -0800 (PST)
Received: from bhalevy-lt (system.cloudius-systems.com. [199.203.229.89])
        by smtp.gmail.com with ESMTPSA id a12sm30483035wro.18.2018.11.21.03.12.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Nov 2018 03:12:38 -0800 (PST)
Message-ID: <c3066246445a9f303d3d46f6a3274944093e78e8.camel@scylladb.com>
Subject: Re: [PATCH 8/8] aio: support for IO polling
From:   Benny Halevy <bhalevy@scylladb.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-aio@kvack.org, linux-fsdevel@vger.kernel.org
Date:   Wed, 21 Nov 2018 13:12:36 +0200
In-Reply-To: <20181120171953.1258-9-axboe@kernel.dk>
References: <20181120171953.1258-1-axboe@kernel.dk>
         <20181120171953.1258-9-axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 2018-11-20 at 10:19 -0700, Jens Axboe wrote:
> Add polled variants of PREAD/PREADV and PWRITE/PWRITEV. These act
> like their non-polled counterparts, except we expect to poll for
> completion of them. The polling happens at io_getevent() time, and
> works just like non-polled IO.
> 
> To setup an io_context for polled IO, the application must call
> io_setup2() with IOCTX_FLAG_IOPOLL as one of the flags. It is illegal
> to mix and match polled and non-polled IO on an io_context.
> 
> Polled IO doesn't support the user mapped completion ring. Events
> must be reaped through the io_getevents() system call. For non-irq
> driven poll devices, there's no way to support completion reaping
> from userspace by just looking at the ring. The application itself
> is the one that pulls completion entries.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>  fs/aio.c                     | 377 ++++++++++++++++++++++++++++++-----
>  include/uapi/linux/aio_abi.h |   4 +
>  2 files changed, 336 insertions(+), 45 deletions(-)
> 
> diff --git a/fs/aio.c b/fs/aio.c
> index 8bbb0b77d9c4..ea93847d25d1 100644
> --- a/fs/aio.c
> +++ b/fs/aio.c
> @@ -94,6 +94,8 @@ struct kioctx {
>  
>  	unsigned long		user_id;
>  
> +	unsigned int		flags;
> +
>  	struct __percpu kioctx_cpu *cpu;
>  
>  	/*
> @@ -138,6 +140,19 @@ struct kioctx {
>  		atomic_t	reqs_available;
>  	} ____cacheline_aligned_in_smp;
>  
> +	/* iopoll submission state */
> +	struct {
> +		spinlock_t poll_lock;
> +		struct list_head poll_submitted;
> +	} ____cacheline_aligned_in_smp;
> +
> +	/* iopoll completion state */
> +	struct {
> +		struct list_head poll_completing;
> +		unsigned long getevents_busy;
> +		atomic_t poll_completed;
> +	} ____cacheline_aligned_in_smp;
> +
>  	struct {
>  		spinlock_t	ctx_lock;
>  		struct list_head active_reqs;	/* used for cancellation */
> @@ -191,13 +206,24 @@ struct aio_kiocb {
>  
>  	struct list_head	ki_list;	/* the aio core uses this
>  						 * for cancellation */
> +
> +	unsigned long		ki_flags;
> +#define IOCB_POLL_COMPLETED	0
> +
>  	refcount_t		ki_refcnt;
>  
> -	/*
> -	 * If the aio_resfd field of the userspace iocb is not zero,
> -	 * this is the underlying eventfd context to deliver events to.
> -	 */
> -	struct eventfd_ctx	*ki_eventfd;
> +	union {
> +		/*
> +		 * If the aio_resfd field of the userspace iocb is not zero,
> +		 * this is the underlying eventfd context to deliver events to.
> +		 */
> +		struct eventfd_ctx	*ki_eventfd;
> +
> +		/*
> +		 * For polled IO, stash completion info here
> +		 */
> +		struct io_event		ki_ev;
> +	};
>  };
>  
>  /*------ sysctl variables----*/
> @@ -214,6 +240,8 @@ static struct vfsmount *aio_mnt;
>  static const struct file_operations aio_ring_fops;
>  static const struct address_space_operations aio_ctx_aops;
>  
> +static void aio_iopoll_reap_events(struct kioctx *);
> +
>  static struct file *aio_private_file(struct kioctx *ctx, loff_t nr_pages)
>  {
>  	struct file *file;
> @@ -451,11 +479,15 @@ static int aio_setup_ring(struct kioctx *ctx, unsigned int nr_events)
>  	int i;
>  	struct file *file;
>  
> -	/* Compensate for the ring buffer's head/tail overlap entry */
> -	nr_events += 2;	/* 1 is required, 2 for good luck */
> -
> +	/*
> +	 * Compensate for the ring buffer's head/tail overlap entry.
> +	 * IO polling doesn't require any io event entries
> +	 */
>  	size = sizeof(struct aio_ring);
> -	size += sizeof(struct io_event) * nr_events;
> +	if (!(ctx->flags & IOCTX_FLAG_IOPOLL)) {
> +		nr_events += 2;	/* 1 is required, 2 for good luck */
> +		size += sizeof(struct io_event) * nr_events;
> +	}
>  
>  	nr_pages = PFN_UP(size);
>  	if (nr_pages < 0)
> @@ -720,6 +752,7 @@ static struct kioctx *ioctx_alloc(unsigned nr_events, unsigned int flags)
>  	if (!ctx)
>  		return ERR_PTR(-ENOMEM);
>  
> +	ctx->flags = flags;
>  	ctx->max_reqs = max_reqs;
>  
>  	spin_lock_init(&ctx->ctx_lock);
> @@ -732,6 +765,11 @@ static struct kioctx *ioctx_alloc(unsigned nr_events, unsigned int flags)
>  
>  	INIT_LIST_HEAD(&ctx->active_reqs);
>  
> +	spin_lock_init(&ctx->poll_lock);
> +	INIT_LIST_HEAD(&ctx->poll_submitted);
> +	INIT_LIST_HEAD(&ctx->poll_completing);
> +	atomic_set(&ctx->poll_completed, 0);
> +
>  	if (percpu_ref_init(&ctx->users, free_ioctx_users, 0, GFP_KERNEL))
>  		goto err;
>  
> @@ -814,6 +852,8 @@ static int kill_ioctx(struct mm_struct *mm, struct kioctx *ctx,
>  	RCU_INIT_POINTER(table->table[ctx->id], NULL);
>  	spin_unlock(&mm->ioctx_lock);
>  
> +	aio_iopoll_reap_events(ctx);
> +
>  	/* free_ioctx_reqs() will do the necessary RCU synchronization */
>  	wake_up_all(&ctx->wait);
>  
> @@ -1056,6 +1096,24 @@ static inline void iocb_put(struct aio_kiocb *iocb)
>  	}
>  }
>  
> +static void iocb_put_many(struct kioctx *ctx, void **iocbs, int *nr)
> +{
> +	if (nr) {
> +		kmem_cache_free_bulk(kiocb_cachep, *nr, iocbs);
> +		percpu_ref_put_many(&ctx->reqs, *nr);
> +		*nr = 0;
> +	}
> +}
> +
> +static void aio_fill_event(struct io_event *ev, struct aio_kiocb *iocb,
> +			   long res, long res2)
> +{
> +	ev->obj = (u64)(unsigned long)iocb->ki_user_iocb;
> +	ev->data = iocb->ki_user_data;
> +	ev->res = res;
> +	ev->res2 = res2;
> +}
> +
>  /* aio_complete
>   *	Called when the io request on the given iocb is complete.
>   */
> @@ -1083,10 +1141,7 @@ static void aio_complete(struct aio_kiocb *iocb, long res, long res2)
>  	ev_page = kmap_atomic(ctx->ring_pages[pos / AIO_EVENTS_PER_PAGE]);
>  	event = ev_page + pos % AIO_EVENTS_PER_PAGE;
>  
> -	event->obj = (u64)(unsigned long)iocb->ki_user_iocb;
> -	event->data = iocb->ki_user_data;
> -	event->res = res;
> -	event->res2 = res2;
> +	aio_fill_event(event, iocb, res, res2);
>  
>  	kunmap_atomic(ev_page);
>  	flush_dcache_page(ctx->ring_pages[pos / AIO_EVENTS_PER_PAGE]);
> @@ -1239,6 +1294,165 @@ static bool aio_read_events(struct kioctx *ctx, long min_nr, long nr,
>  	return ret < 0 || *i >= min_nr;
>  }
>  
> +#define AIO_POLL_STACK	8
> +
> +/*
> + * Process completed iocb iopoll entries, copying the result to userspace.
> + */
> +static long aio_iopoll_reap(struct kioctx *ctx, struct io_event __user *evs,
> +			    unsigned int *nr_events, long max)
> +{
> +	void *iocbs[AIO_POLL_STACK];
> +	struct aio_kiocb *iocb, *n;
> +	int to_free = 0, ret = 0;

To be on the safe side, how about checking that if (evs)
*nr_events < max, otherwise, return -EINVAL?

> +
> +	list_for_each_entry_safe(iocb, n, &ctx->poll_completing, ki_list) {
> +		if (!test_bit(IOCB_POLL_COMPLETED, &iocb->ki_flags))
> +			continue;
> +		if (to_free == AIO_POLL_STACK)
> +			iocb_put_many(ctx, iocbs, &to_free);
> +
> +		list_del(&iocb->ki_list);
> +		iocbs[to_free++] = iocb;
> +
> +		fput(iocb->rw.ki_filp);
> +
> +		if (!evs) {
> +			(*nr_events)++;
> +			continue;
> +		}
> +
> +		if (copy_to_user(evs + *nr_events, &iocb->ki_ev,
> +		    sizeof(iocb->ki_ev))) {
> +			ret = -EFAULT;
> +			break;
> +		}
> +		if (++(*nr_events) == max)
> +			break;
> +	}
> +
> +	if (to_free)
> +		iocb_put_many(ctx, iocbs, &to_free);
> +
> +	return ret;
> +}
> +
> +static int __aio_iopoll_check(struct kioctx *ctx, struct io_event __user *event,
> +			      unsigned int *nr_events, long min, long max)
> +{
> +	struct aio_kiocb *iocb;
> +	unsigned int poll_completed;
> +	int to_poll, polled, ret;
> +
> +	/*
> +	 * Check if we already have done events that satisfy what we need
> +	 */
> +	if (!list_empty(&ctx->poll_completing)) {
> +		ret = aio_iopoll_reap(ctx, event, nr_events, max);
> +		if (ret < 0)
> +			return ret;
> +		if (*nr_events >= min)
> +			return 0;
> +	}
> +
> +	/*
> +	 * Take in a new working set from the submitted list if possible.
> +	 */
> +	if (!list_empty_careful(&ctx->poll_submitted)) {
> +		spin_lock(&ctx->poll_lock);
> +		list_splice_init(&ctx->poll_submitted, &ctx->poll_completing);
> +		spin_unlock(&ctx->poll_lock);
> +	}
> +
> +	if (list_empty(&ctx->poll_completing))
> +		return 0;

Could be somewhat optimized like this:

	if (list_empty_careful(&ctx->poll_submitted))
		return 0;

	spin_lock(&ctx->poll_lock);
	list_splice_init(&ctx->poll_submitted, &ctx->poll_completing);
	spin_unlock(&ctx->poll_lock);
	if (list_empty(&ctx->poll_completing))
		return 0;

Or, possibly...
	if (list_empty_careful(&ctx->poll_submitted) ||
	    ({
		spin_lock(&ctx->poll_lock);
		list_splice_init(&ctx->poll_submitted, &ctx->poll_completing);
		spin_unlock(&ctx->poll_lock);
		list_empty(&ctx->poll_completing);
	    }))
		return 0;

> +
> +	/*
> +	 * Check again now that we have a new batch.
> +	 */
> +	ret = aio_iopoll_reap(ctx, event, nr_events, max);
> +	if (ret < 0)
> +		return ret;
> +	if (*nr_events >= min)
> +		return 0;
> +
> +	/*
> +	 * Find up to 'max_nr' worth of events to poll for, including the

What's max_nr? You mean 'max'?

> +	 * events we already successfully polled
> +	 */
> +	polled = to_poll = 0;
> +	poll_completed = atomic_read(&ctx->poll_completed);
> +	list_for_each_entry(iocb, &ctx->poll_completing, ki_list) {
> +		/*
> +		 * Poll for needed events with wait == true, anything after
> +		 * that we just check if we have more, up to max.
> +		 */
> +		bool wait = polled + *nr_events >= min;
> +		struct kiocb *kiocb = &iocb->rw;
> +
> +		if (test_bit(IOCB_POLL_COMPLETED, &iocb->ki_flags))
> +			break;
> +		if (++to_poll + *nr_events >= max)
> +			break;
> +
> +		polled += kiocb->ki_filp->f_op->iopoll(kiocb, wait);

Could iopoll return a negative value? (Currently not in this patchset,
but would it be possible in the future?)

> +		if (polled + *nr_events >= max)
> +			break;
> +		if (poll_completed != atomic_read(&ctx->poll_completed))
> +			break;
> +	}
> +
> +	ret = aio_iopoll_reap(ctx, event, nr_events, max);
> +	if (ret < 0)
> +		return ret;
> +	if (*nr_events >= min)
> +		return 0;
> +	return to_poll;

What does the returned value mean?
If the intention is only to return a value greater than zero,
how about just returning to_poll > 0?

> +}
> +
> +/*
> + * We can't just wait for polled events to come to us, we have to actively
> + * find and complete them.
> + */
> +static void aio_iopoll_reap_events(struct kioctx *ctx)
> +{
> +	if (!(ctx->flags & IOCTX_FLAG_IOPOLL))
> +		return;
> +
> +	while (!list_empty_careful(&ctx->poll_submitted) ||
> +	       !list_empty(&ctx->poll_completing)) {
> +		unsigned int nr_events = 0;
> +
> +		__aio_iopoll_check(ctx, NULL, &nr_events, 1, UINT_MAX);

BUG_ON(__aoi_iopoll_check() < 0) ?

> +	}
> +}
> +
> +static int aio_iopoll_check(struct kioctx *ctx, long min_nr, long nr,
> +			    struct io_event __user *event)
> +{
> +	unsigned int nr_events = 0;
> +	int ret = 0;
> +
> +	/* * Only allow one thread polling at a time */

nit: extra '* '

> +	if (test_and_set_bit(0, &ctx->getevents_busy))
> +		return -EBUSY;
> +
> +	while (!nr_events || !need_resched()) {
> +		int tmin = 0;
> +
> +		if (nr_events < min_nr)
> +			tmin = min_nr - nr_events;
> +
> +		ret = __aio_iopoll_check(ctx, event, &nr_events, tmin, nr);
> +		if (ret <= 0)
> +			break;
> +		ret = 0;
> +	}
> +
> +	clear_bit(0, &ctx->getevents_busy);
> +	return nr_events ? nr_events : ret;
> +}
> +
>  static long read_events(struct kioctx *ctx, long min_nr, long nr,
>  			struct io_event __user *event,
>  			ktime_t until)
> @@ -1287,7 +1501,7 @@ SYSCALL_DEFINE3(io_setup2, u32, nr_events, u32, flags,
>  	unsigned long ctx;
>  	long ret;
>  
> -	if (flags)
> +	if (flags & ~IOCTX_FLAG_IOPOLL)
>  		return -EINVAL;
>  
>  	ret = get_user(ctx, ctxp);
> @@ -1411,13 +1625,8 @@ static void aio_remove_iocb(struct aio_kiocb *iocb)
>  	spin_unlock_irqrestore(&ctx->ctx_lock, flags);
>  }
>  
> -static void aio_complete_rw(struct kiocb *kiocb, long res, long res2)
> +static void kiocb_end_write(struct kiocb *kiocb)
>  {
> -	struct aio_kiocb *iocb = container_of(kiocb, struct aio_kiocb, rw);
> -
> -	if (!list_empty_careful(&iocb->ki_list))
> -		aio_remove_iocb(iocb);
> -
>  	if (kiocb->ki_flags & IOCB_WRITE) {
>  		struct inode *inode = file_inode(kiocb->ki_filp);
>  
> @@ -1429,19 +1638,42 @@ static void aio_complete_rw(struct kiocb *kiocb, long res, long res2)
>  			__sb_writers_acquired(inode->i_sb, SB_FREEZE_WRITE);
>  		file_end_write(kiocb->ki_filp);
>  	}
> +}
> +
> +static void aio_complete_rw(struct kiocb *kiocb, long res, long res2)
> +{
> +	struct aio_kiocb *iocb = container_of(kiocb, struct aio_kiocb, rw);
> +
> +	if (!list_empty_careful(&iocb->ki_list))
> +		aio_remove_iocb(iocb);
> +
> +	kiocb_end_write(kiocb);
>  
>  	fput(kiocb->ki_filp);
>  	aio_complete(iocb, res, res2);
>  }
>  
> -static int aio_prep_rw(struct kiocb *req, struct iocb *iocb)
> +static void aio_complete_rw_poll(struct kiocb *kiocb, long res, long res2)
>  {
> +	struct aio_kiocb *iocb = container_of(kiocb, struct aio_kiocb, rw);
> +	struct kioctx *ctx = iocb->ki_ctx;
> +
> +	kiocb_end_write(kiocb);
> +
> +	aio_fill_event(&iocb->ki_ev, iocb, res, res2);
> +	set_bit(IOCB_POLL_COMPLETED, &iocb->ki_flags);
> +	atomic_inc(&ctx->poll_completed);
> +}
> +
> +static int aio_prep_rw(struct aio_kiocb *kiocb, struct iocb *iocb)
> +{
> +	struct kioctx *ctx = kiocb->ki_ctx;
> +	struct kiocb *req = &kiocb->rw;
>  	int ret;
>  
>  	req->ki_filp = fget(iocb->aio_fildes);
>  	if (unlikely(!req->ki_filp))
>  		return -EBADF;
> -	req->ki_complete = aio_complete_rw;
>  	req->ki_pos = iocb->aio_offset;
>  	req->ki_flags = iocb_flags(req->ki_filp);
>  	if (iocb->aio_flags & IOCB_FLAG_RESFD)
> @@ -1456,8 +1688,7 @@ static int aio_prep_rw(struct kiocb *req, struct iocb *iocb)
>  		ret = ioprio_check_cap(iocb->aio_reqprio);
>  		if (ret) {
>  			pr_debug("aio ioprio check cap error: %d\n", ret);
> -			fput(req->ki_filp);
> -			return ret;
> +			goto out_fput;
>  		}
>  
>  		req->ki_ioprio = iocb->aio_reqprio;
> @@ -1466,7 +1697,41 @@ static int aio_prep_rw(struct kiocb *req, struct iocb *iocb)
>  
>  	ret = kiocb_set_rw_flags(req, iocb->aio_rw_flags);
>  	if (unlikely(ret))
> -		fput(req->ki_filp);
> +		goto out_fput;
> +
> +	if (iocb->aio_flags & IOCB_FLAG_HIPRI) {
> +		/* shares space in the union, and is rather pointless.. */
> +		ret = -EINVAL;
> +		if (iocb->aio_flags & IOCB_FLAG_RESFD)
> +			goto out_fput;
> +
> +		/* can't submit polled IO to a non-polled ctx */
> +		if (!(ctx->flags & IOCTX_FLAG_IOPOLL))
> +			goto out_fput;
> +
> +		ret = -EOPNOTSUPP;
> +		if (!(req->ki_flags & IOCB_DIRECT) ||
> +		    !req->ki_filp->f_op->iopoll)
> +			goto out_fput;
> +
> +		req->ki_flags |= IOCB_HIPRI;
> +		req->ki_complete = aio_complete_rw_poll;
> +
> +		spin_lock(&ctx->poll_lock);
> +		list_add_tail(&kiocb->ki_list, &ctx->poll_submitted);
> +		spin_unlock(&ctx->poll_lock);
> +	} else {
> +		/* can't submit non-polled IO to a polled ctx */
> +		ret = -EINVAL;
> +		if (ctx->flags & IOCTX_FLAG_IOPOLL)
> +			goto out_fput;
> +
> +		req->ki_complete = aio_complete_rw;
> +	}
> +
> +	return 0;
> +out_fput:
> +	fput(req->ki_filp);
>  	return ret;
>  }
>  
> @@ -1509,15 +1774,16 @@ static inline void aio_rw_done(struct kiocb *req, ssize_t ret)
>  	}
>  }
>  
> -static ssize_t aio_read(struct kiocb *req, struct iocb *iocb, bool vectored,
> -		bool compat)
> +static ssize_t aio_read(struct aio_kiocb *kiocb, struct iocb *iocb,
> +			bool vectored, bool compat)
>  {
>  	struct iovec inline_vecs[UIO_FASTIOV], *iovec = inline_vecs;
> +	struct kiocb *req = &kiocb->rw;
>  	struct iov_iter iter;
>  	struct file *file;
>  	ssize_t ret;
>  
> -	ret = aio_prep_rw(req, iocb);
> +	ret = aio_prep_rw(kiocb, iocb);
>  	if (ret)
>  		return ret;
>  	file = req->ki_filp;
> @@ -1542,15 +1808,16 @@ static ssize_t aio_read(struct kiocb *req, struct iocb *iocb, bool vectored,
>  	return ret;
>  }
>  
> -static ssize_t aio_write(struct kiocb *req, struct iocb *iocb, bool vectored,
> -		bool compat)
> +static ssize_t aio_write(struct aio_kiocb *kiocb, struct iocb *iocb,
> +			 bool vectored, bool compat)
>  {
>  	struct iovec inline_vecs[UIO_FASTIOV], *iovec = inline_vecs;
> +	struct kiocb *req = &kiocb->rw;
>  	struct iov_iter iter;
>  	struct file *file;
>  	ssize_t ret;
>  
> -	ret = aio_prep_rw(req, iocb);
> +	ret = aio_prep_rw(kiocb, iocb);
>  	if (ret)
>  		return ret;
>  	file = req->ki_filp;
> @@ -1820,7 +2087,8 @@ static int io_submit_one(struct kioctx *ctx, struct iocb __user *user_iocb,
>  		return -EINVAL;
>  	}
>  
> -	if (!get_reqs_available(ctx))
> +	/* Poll IO doesn't need ring reservations */
> +	if (!(ctx->flags & IOCTX_FLAG_IOPOLL) && !get_reqs_available(ctx))
>  		return -EAGAIN;
>  
>  	ret = -EAGAIN;
> @@ -1843,35 +2111,45 @@ static int io_submit_one(struct kioctx *ctx, struct iocb __user *user_iocb,
>  		}
>  	}
>  
> -	ret = put_user(KIOCB_KEY, &user_iocb->aio_key);
> -	if (unlikely(ret)) {
> -		pr_debug("EFAULT: aio_key\n");
> -		goto out_put_req;
> +	/* polled IO isn't cancelable, don't bother copying the key */
> +	if (!(ctx->flags & IOCTX_FLAG_IOPOLL)) {
> +		ret = put_user(KIOCB_KEY, &user_iocb->aio_key);
> +		if (unlikely(ret)) {
> +			pr_debug("EFAULT: aio_key\n");
> +			goto out_put_req;
> +		}
>  	}
>  
>  	req->ki_user_iocb = user_iocb;
>  	req->ki_user_data = iocb.aio_data;
>  
> +	ret = -EINVAL;
>  	switch (iocb.aio_lio_opcode) {
>  	case IOCB_CMD_PREAD:
> -		ret = aio_read(&req->rw, &iocb, false, compat);
> +		ret = aio_read(req, &iocb, false, compat);
>  		break;
>  	case IOCB_CMD_PWRITE:
> -		ret = aio_write(&req->rw, &iocb, false, compat);
> +		ret = aio_write(req, &iocb, false, compat);
>  		break;
>  	case IOCB_CMD_PREADV:
> -		ret = aio_read(&req->rw, &iocb, true, compat);
> +		ret = aio_read(req, &iocb, true, compat);
>  		break;
>  	case IOCB_CMD_PWRITEV:
> -		ret = aio_write(&req->rw, &iocb, true, compat);
> +		ret = aio_write(req, &iocb, true, compat);
>  		break;
>  	case IOCB_CMD_FSYNC:
> +		if (ctx->flags & IOCTX_FLAG_IOPOLL)
> +			break;
>  		ret = aio_fsync(&req->fsync, &iocb, false);
>  		break;
>  	case IOCB_CMD_FDSYNC:
> +		if (ctx->flags & IOCTX_FLAG_IOPOLL)
> +			break;
>  		ret = aio_fsync(&req->fsync, &iocb, true);
>  		break;
>  	case IOCB_CMD_POLL:
> +		if (ctx->flags & IOCTX_FLAG_IOPOLL)
> +			break;
>  		ret = aio_poll(req, &iocb);
>  		break;
>  	default:
> @@ -1894,7 +2172,8 @@ static int io_submit_one(struct kioctx *ctx, struct iocb __user *user_iocb,
>  		eventfd_ctx_put(req->ki_eventfd);
>  	kmem_cache_free(kiocb_cachep, req);
>  out_put_reqs_available:
> -	put_reqs_available(ctx, 1);
> +	if (!(ctx->flags & IOCTX_FLAG_IOPOLL))
> +		put_reqs_available(ctx, 1);
>  	return ret;
>  }
>  
> @@ -1930,7 +2209,9 @@ SYSCALL_DEFINE3(io_submit, aio_context_t, ctx_id, long, nr,
>  	if (nr > ctx->nr_events)
>  		nr = ctx->nr_events;
>  
> -	blk_start_plug(&plug);
> +	if (!(ctx->flags & IOCTX_FLAG_IOPOLL))
> +		blk_start_plug(&plug);
> +
>  	for (i = 0; i < nr; i++) {
>  		struct iocb __user *user_iocb;
>  
> @@ -1943,7 +2224,9 @@ SYSCALL_DEFINE3(io_submit, aio_context_t, ctx_id, long, nr,
>  		if (ret)
>  			break;
>  	}
> -	blk_finish_plug(&plug);
> +
> +	if (!(ctx->flags & IOCTX_FLAG_IOPOLL))
> +		blk_finish_plug(&plug);
>  
>  	percpu_ref_put(&ctx->users);
>  	return i ? i : ret;
> @@ -2068,8 +2351,12 @@ static long do_io_getevents(aio_context_t ctx_id,
>  	long ret = -EINVAL;
>  
>  	if (likely(ioctx)) {
> -		if (likely(min_nr <= nr && min_nr >= 0))
> -			ret = read_events(ioctx, min_nr, nr, events, until);
> +		if (likely(min_nr <= nr && min_nr >= 0)) {
> +			if (ioctx->flags & IOCTX_FLAG_IOPOLL)
> +				ret = aio_iopoll_check(ioctx, min_nr, nr, events);
> +			else
> +				ret = read_events(ioctx, min_nr, nr, events, until);
> +		}
>  		percpu_ref_put(&ioctx->users);
>  	}
>  
> diff --git a/include/uapi/linux/aio_abi.h b/include/uapi/linux/aio_abi.h
> index 8387e0af0f76..3b98b5fbacde 100644
> --- a/include/uapi/linux/aio_abi.h
> +++ b/include/uapi/linux/aio_abi.h
> @@ -52,9 +52,11 @@ enum {
>   *                   is valid.
>   * IOCB_FLAG_IOPRIO - Set if the "aio_reqprio" member of the "struct iocb"
>   *                    is valid.
> + * IOCB_FLAG_HIPRI - Use IO completion polling
>   */
>  #define IOCB_FLAG_RESFD		(1 << 0)
>  #define IOCB_FLAG_IOPRIO	(1 << 1)
> +#define IOCB_FLAG_HIPRI		(1 << 2)
>  
>  /* read() from /dev/aio returns these structures. */
>  struct io_event {
> @@ -106,6 +108,8 @@ struct iocb {
>  	__u32	aio_resfd;
>  }; /* 64 bytes */
>  
> +#define IOCTX_FLAG_IOPOLL	(1 << 0)
> +
>  #undef IFBIG
>  #undef IFLITTLE
>  

