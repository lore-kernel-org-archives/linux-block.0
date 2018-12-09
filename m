Return-Path: <SRS0=93Gy=OS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FE59C07E85
	for <linux-block@archiver.kernel.org>; Sun,  9 Dec 2018 10:02:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27DF920831
	for <linux-block@archiver.kernel.org>; Sun,  9 Dec 2018 10:02:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=scylladb-com.20150623.gappssmtp.com header.i=@scylladb-com.20150623.gappssmtp.com header.b="igsrcmBV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27DF920831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=scylladb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726122AbeLIKCJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 9 Dec 2018 05:02:09 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53391 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726113AbeLIKCJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 9 Dec 2018 05:02:09 -0500
Received: by mail-wm1-f66.google.com with SMTP id y1so8067339wmi.3
        for <linux-block@vger.kernel.org>; Sun, 09 Dec 2018 02:02:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=scylladb-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=Ot7i9KDwZCiI3I5tDZ/fTXjLUCp/vTB/1ZrtQamcFoA=;
        b=igsrcmBVzy4k023pktyfN632obuRNbQ9PhGYn0ji0ajrWG/WiOkHRFFEVePF4Xc9Q9
         J4jx+nJx2Memw8RpWbxx+xJEh8NZ/PuGEvNABnn5vwMH3BasMM8q80CLYEjk/kaAMTNZ
         vkIQ+86b5S2xOtCMergrsRChpG4fhGs3/ekxdV+AytSNC1vGkJGElwot6OJEWVxx6zdA
         xQuk09nl5gDXP/pQSdlR4FWzm3aPOqGv2LFf5ZoNmIp98UtmeD3iGFwJI2EldZ6oD5KB
         Pth+bydmMIsvWh2XITuPnHPxGEUV3knimYTXZk3FeMKTuWcZShcViu7hWVq4DgGJ5PrL
         i1NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=Ot7i9KDwZCiI3I5tDZ/fTXjLUCp/vTB/1ZrtQamcFoA=;
        b=delWU+Ji2M52ErNSjvzX4aXg+yp4Xw2iSpGpnDAByt1DbknHOFm3dSxCjtmuVX1c4X
         Dfq79VnSzLrqdORbY0t22uL+kp6GRAVjesxjhxL0H7dH5FamZD+zEZRNgYQ33Ws0iz4Y
         qePPgk03BPz3MQslPGG1pWuupHUbZE/CTyjWS0jUJh4v56vr4EQGv3xkMfeBJWOWSBbM
         HNQDyBIwHNWlitdqdfrI5x9Uu54mKjKNDD3Wec+Hvi4dVXSiA6hKxCxALOGPeRzZhCWO
         HC4bKYxTulTKIKaBgIKYvvxtA2Dzun8D3HnptIkOtVQS4hFpZOJmwMDStjwptC8/8Ldm
         bYwQ==
X-Gm-Message-State: AA+aEWaA4BU7wC5xtCd6Yc+RVqcXJzNEUe0i70oS05gBI5KGAaSR9eHG
        DOrDiGAkOMWy9zHoZ+J8buYtIw==
X-Google-Smtp-Source: AFSGD/XIdVsCHLn9bvgi1RmGg0pRd6jcrOLzyPyv4HrlXIVF0wLRDp3oarl5Mlse04+wfsYN+CzkuA==
X-Received: by 2002:a1c:5585:: with SMTP id j127-v6mr6658736wmb.127.1544349726159;
        Sun, 09 Dec 2018 02:02:06 -0800 (PST)
Received: from bhalevy-lt (system.cloudius-systems.com. [199.203.229.89])
        by smtp.gmail.com with ESMTPSA id h16sm24349560wrb.62.2018.12.09.02.02.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 09 Dec 2018 02:02:05 -0800 (PST)
Message-ID: <e0494161918d30787fbc759f9d2b77953249ab8b.camel@scylladb.com>
Subject: Re: [PATCH 15/26] aio: support for IO polling
From:   Benny Halevy <bhalevy@scylladb.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-aio@kvack.org
Cc:     hch@lst.de, jmoyer@redhat.com, clm@fb.com
Date:   Sun, 09 Dec 2018 12:02:03 +0200
In-Reply-To: <20181207222016.29387-16-axboe@kernel.dk>
References: <20181207222016.29387-1-axboe@kernel.dk>
         <20181207222016.29387-16-axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.2 (3.30.2-2.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 2018-12-07 at 15:20 -0700, Jens Axboe wrote:
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
>  fs/aio.c                     | 396 +++++++++++++++++++++++++++++++----
>  include/uapi/linux/aio_abi.h |   3 +
>  2 files changed, 363 insertions(+), 36 deletions(-)
> 
> diff --git a/fs/aio.c b/fs/aio.c
> index bb6f07ca6940..cc8763b395c1 100644
> --- a/fs/aio.c
> +++ b/fs/aio.c
> @@ -153,6 +153,18 @@ struct kioctx {
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
> +		struct mutex getevents_lock;
> +	} ____cacheline_aligned_in_smp;
> +
>  	struct {
>  		spinlock_t	ctx_lock;
>  		struct list_head active_reqs;	/* used for cancellation */
> @@ -205,14 +217,27 @@ struct aio_kiocb {
>  	__u64			ki_user_data;	/* user's data for completion */
>  
>  	struct list_head	ki_list;	/* the aio core uses this
> -						 * for cancellation */
> +						 * for cancellation, or for
> +						 * polled IO */
> +
> +	unsigned long		ki_flags;
> +#define IOCB_POLL_COMPLETED	0	/* polled IO has completed */
> +#define IOCB_POLL_EAGAIN	1	/* polled submission got EAGAIN */
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
> @@ -233,6 +258,7 @@ static const unsigned int iocb_page_shift =
>  				ilog2(PAGE_SIZE / sizeof(struct iocb));
>  
>  static void aio_useriocb_unmap(struct kioctx *);
> +static void aio_iopoll_reap_events(struct kioctx *);
>  
>  static struct file *aio_private_file(struct kioctx *ctx, loff_t nr_pages)
>  {
> @@ -471,11 +497,15 @@ static int aio_setup_ring(struct kioctx *ctx, unsigned int nr_events)
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
> @@ -758,6 +788,11 @@ static struct kioctx *io_setup_flags(unsigned long ctxid,
>  
>  	INIT_LIST_HEAD(&ctx->active_reqs);
>  
> +	spin_lock_init(&ctx->poll_lock);
> +	INIT_LIST_HEAD(&ctx->poll_submitted);
> +	INIT_LIST_HEAD(&ctx->poll_completing);
> +	mutex_init(&ctx->getevents_lock);
> +
>  	if (percpu_ref_init(&ctx->users, free_ioctx_users, 0, GFP_KERNEL))
>  		goto err;
>  
> @@ -829,11 +864,15 @@ static int kill_ioctx(struct mm_struct *mm, struct kioctx *ctx,
>  {
>  	struct kioctx_table *table;
>  
> +	mutex_lock(&ctx->getevents_lock);
>  	spin_lock(&mm->ioctx_lock);
>  	if (atomic_xchg(&ctx->dead, 1)) {
>  		spin_unlock(&mm->ioctx_lock);
> +		mutex_unlock(&ctx->getevents_lock);
>  		return -EINVAL;
>  	}
> +	aio_iopoll_reap_events(ctx);
> +	mutex_unlock(&ctx->getevents_lock);
>  
>  	table = rcu_dereference_raw(mm->ioctx_table);
>  	WARN_ON(ctx != rcu_access_pointer(table->table[ctx->id]));
> @@ -1042,6 +1081,7 @@ static inline struct aio_kiocb *aio_get_req(struct kioctx *ctx)
>  	percpu_ref_get(&ctx->reqs);
>  	req->ki_ctx = ctx;
>  	INIT_LIST_HEAD(&req->ki_list);
> +	req->ki_flags = 0;
>  	refcount_set(&req->ki_refcnt, 0);
>  	req->ki_eventfd = NULL;
>  	return req;
> @@ -1083,6 +1123,15 @@ static inline void iocb_put(struct aio_kiocb *iocb)
>  	}
>  }
>  
> +static void iocb_put_many(struct kioctx *ctx, void **iocbs, int *nr)
> +{
> +	if (*nr) {
> +		percpu_ref_put_many(&ctx->reqs, *nr);
> +		kmem_cache_free_bulk(kiocb_cachep, *nr, iocbs);
> +		*nr = 0;
> +	}
> +}
> +
>  static void aio_fill_event(struct io_event *ev, struct aio_kiocb *iocb,
>  			   long res, long res2)
>  {
> @@ -1272,6 +1321,185 @@ static bool aio_read_events(struct kioctx *ctx, long min_nr, long nr,
>  	return ret < 0 || *i >= min_nr;
>  }
>  
> +#define AIO_IOPOLL_BATCH	8
> +
> +/*
> + * Process completed iocb iopoll entries, copying the result to userspace.
> + */
> +static long aio_iopoll_reap(struct kioctx *ctx, struct io_event __user *evs,
> +			    unsigned int *nr_events, long max)
> +{
> +	void *iocbs[AIO_IOPOLL_BATCH];
> +	struct aio_kiocb *iocb, *n;
> +	int to_free = 0, ret = 0;
> +
> +	/* Shouldn't happen... */
> +	if (*nr_events >= max)
> +		return 0;
> +
> +	list_for_each_entry_safe(iocb, n, &ctx->poll_completing, ki_list) {
> +		if (*nr_events == max)
> +			break;
> +		if (!test_bit(IOCB_POLL_COMPLETED, &iocb->ki_flags))
> +			continue;
> +		if (to_free == AIO_IOPOLL_BATCH)
> +			iocb_put_many(ctx, iocbs, &to_free);
> +
> +		list_del(&iocb->ki_list);
> +		iocbs[to_free++] = iocb;
> +
> +		fput(iocb->rw.ki_filp);
> +
> +		if (evs && copy_to_user(evs + *nr_events, &iocb->ki_ev,
> +		    sizeof(iocb->ki_ev))) {
> +			ret = -EFAULT;
> +			break;
> +		}
> +		(*nr_events)++;
> +	}
> +
> +	if (to_free)
> +		iocb_put_many(ctx, iocbs, &to_free);
> +
> +	return ret;
> +}
> +
> +/*
> + * Poll for a mininum of 'min' events, and a maximum of 'max'. Note that if
> + * min == 0 we consider that a non-spinning poll check - we'll still enter
> + * the driver poll loop, but only as a non-spinning completion check.
> + */
> +static int aio_iopoll_getevents(struct kioctx *ctx,
> +				struct io_event __user *event,
> +				unsigned int *nr_events, long min, long max)
> +{
> +	struct aio_kiocb *iocb;
> +	int to_poll, polled, ret;
> +
> +	/*
> +	 * Check if we already have done events that satisfy what we need
> +	 */
> +	if (!list_empty(&ctx->poll_completing)) {
> +		ret = aio_iopoll_reap(ctx, event, nr_events, max);
> +		if (ret < 0)
> +			return ret;
> +		if ((min && *nr_events >= min) || *nr_events >= max)
> +			return 0;
> +	}
> +
> +	/*
> +	 * Take in a new working set from the submitted list, if possible.
> +	 */
> +	if (!list_empty_careful(&ctx->poll_submitted)) {
> +		spin_lock(&ctx->poll_lock);
> +		list_splice_init(&ctx->poll_submitted, &ctx->poll_completing);
> +		spin_unlock(&ctx->poll_lock);
> +	}
> +
> +	if (list_empty(&ctx->poll_completing))
> +		return 0;
> +
> +	/*
> +	 * Check again now that we have a new batch.
> +	 */
> +	ret = aio_iopoll_reap(ctx, event, nr_events, max);
> +	if (ret < 0)
> +		return ret;
> +	if ((min && *nr_events >= min) || *nr_events >= max)
> +		return 0;
> +
> +	/*
> +	 * Find up to 'max' worth of events to poll for, including the
> +	 * events we already successfully polled
> +	 */
> +	polled = to_poll = 0;
> +	list_for_each_entry(iocb, &ctx->poll_completing, ki_list) {
> +		/*
> +		 * Poll for needed events with spin == true, anything after
> +		 * that we just check if we have more, up to max.
> +		 */
> +		bool spin = !polled || *nr_events < min;
> +		struct kiocb *kiocb = &iocb->rw;
> +
> +		if (test_bit(IOCB_POLL_COMPLETED, &iocb->ki_flags))
> +			break;
> +		if (++to_poll + *nr_events > max)
> +			break;
> +
> +		ret = kiocb->ki_filp->f_op->iopoll(kiocb, spin);
> +		if (ret < 0)
> +			return ret;
> +
> +		polled += ret;
> +		if (polled + *nr_events >= max)
> +			break;
> +	}
> +
> +	ret = aio_iopoll_reap(ctx, event, nr_events, max);
> +	if (ret < 0)
> +		return ret;
> +	if (*nr_events >= min)
> +		return 0;
> +	return to_poll;
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
> +		aio_iopoll_getevents(ctx, NULL, &nr_events, 1, UINT_MAX);
> +	}
> +}
> +
> +static int __aio_iopoll_check(struct kioctx *ctx, struct io_event __user *event,
> +			      unsigned int *nr_events, long min_nr, long max_nr)
> +{
> +	int ret = 0;
> +
> +	while (!*nr_events || !need_resched()) {

Hmm, it doesn't make sense to spin in this loop
if the user got _all_ the events he requested, even
if !need_resched().  How about:

	while (!*nr_events || (!need_resched() && *nr_events < max_nr)) {

> +		int tmin = 0;
> +
> +		if (*nr_events < min_nr)
> +			tmin = min_nr - *nr_events;
> +
> +		ret = aio_iopoll_getevents(ctx, event, nr_events, tmin, max_nr);
> +		if (ret <= 0)
> +			break;
> +		ret = 0;
> +	}
> +
> +	return ret;
> +}
> +
> +static int aio_iopoll_check(struct kioctx *ctx, long min_nr, long nr,
> +			    struct io_event __user *event)
> +{
> +	unsigned int nr_events = 0;
> +	int ret;
> +
> +	/* Only allow one thread polling at a time */
> +	if (!mutex_trylock(&ctx->getevents_lock))
> +		return -EBUSY;
> +	if (unlikely(atomic_read(&ctx->dead))) {
> +		ret = -EINVAL;
> +		goto err;
> +	}
> +
> +	ret = __aio_iopoll_check(ctx, event, &nr_events, min_nr, nr);
> +err:
> +	mutex_unlock(&ctx->getevents_lock);
> +	return nr_events ? nr_events : ret;
> +}
> +
>  static long read_events(struct kioctx *ctx, long min_nr, long nr,
>  			struct io_event __user *event,
>  			ktime_t until)
> @@ -1375,7 +1603,7 @@ SYSCALL_DEFINE6(io_setup2, u32, nr_events, u32, flags, struct iocb __user *,
>  
>  	if (user1 || user2)
>  		return -EINVAL;
> -	if (flags & ~IOCTX_FLAG_USERIOCB)
> +	if (flags & ~(IOCTX_FLAG_USERIOCB | IOCTX_FLAG_IOPOLL))
>  		return -EINVAL;
>  
>  	ret = get_user(ctx, ctxp);
> @@ -1509,13 +1737,8 @@ static void aio_remove_iocb(struct aio_kiocb *iocb)
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
> @@ -1527,19 +1750,48 @@ static void aio_complete_rw(struct kiocb *kiocb, long res, long res2)
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
> -static int aio_prep_rw(struct kiocb *req, const struct iocb *iocb)
> +static void aio_complete_rw_poll(struct kiocb *kiocb, long res, long res2)
>  {
> +	struct aio_kiocb *iocb = container_of(kiocb, struct aio_kiocb, rw);
> +
> +	kiocb_end_write(kiocb);
> +
> +	/*
> +	 * Handle EAGAIN from resource limits with polled IO inline, don't
> +	 * pass the event back to userspace.
> +	 */
> +	if (unlikely(res == -EAGAIN))
> +		set_bit(IOCB_POLL_EAGAIN, &iocb->ki_flags);
> +	else {
> +		aio_fill_event(&iocb->ki_ev, iocb, res, res2);
> +		set_bit(IOCB_POLL_COMPLETED, &iocb->ki_flags);
> +	}
> +}
> +
> +static int aio_prep_rw(struct aio_kiocb *kiocb, const struct iocb *iocb)
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
> @@ -1565,9 +1817,35 @@ static int aio_prep_rw(struct kiocb *req, const struct iocb *iocb)
>  	if (unlikely(ret))
>  		goto out_fput;
>  
> -	req->ki_flags &= ~IOCB_HIPRI; /* no one is going to poll for this I/O */
> -	return 0;
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
> +	} else {
> +		/* can't submit non-polled IO to a polled ctx */
> +		ret = -EINVAL;
> +		if (ctx->flags & IOCTX_FLAG_IOPOLL)
> +			goto out_fput;
>  
> +		/* no one is going to poll for this I/O */
> +		req->ki_flags &= ~IOCB_HIPRI;
> +		req->ki_complete = aio_complete_rw;
> +	}
> +
> +	return 0;
>  out_fput:
>  	fput(req->ki_filp);
>  	return ret;
> @@ -1612,15 +1890,40 @@ static inline void aio_rw_done(struct kiocb *req, ssize_t ret)
>  	}
>  }
>  
> -static ssize_t aio_read(struct kiocb *req, const struct iocb *iocb,
> +/*
> + * After the iocb has been issued, it's safe to be found on the poll list.
> + * Adding the kiocb to the list AFTER submission ensures that we don't
> + * find it from a io_getevents() thread before the issuer is done accessing
> + * the kiocb cookie.
> + */
> +static void aio_iopoll_iocb_issued(struct aio_kiocb *kiocb)
> +{
> +	/*
> +	 * For fast devices, IO may have already completed. If it has, add
> +	 * it to the front so we find it first. We can't add to the poll_done
> +	 * list as that's unlocked from the completion side.
> +	 */
> +	const int front_add = test_bit(IOCB_POLL_COMPLETED, &kiocb->ki_flags);
> +	struct kioctx *ctx = kiocb->ki_ctx;
> +
> +	spin_lock(&ctx->poll_lock);
> +	if (front_add)
> +		list_add(&kiocb->ki_list, &ctx->poll_submitted);
> +	else
> +		list_add_tail(&kiocb->ki_list, &ctx->poll_submitted);
> +	spin_unlock(&ctx->poll_lock);
> +}
> +
> +static ssize_t aio_read(struct aio_kiocb *kiocb, const struct iocb *iocb,
>  			bool vectored, bool compat)
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
> @@ -1645,15 +1948,16 @@ static ssize_t aio_read(struct kiocb *req, const struct iocb *iocb,
>  	return ret;
>  }
>  
> -static ssize_t aio_write(struct kiocb *req, const struct iocb *iocb,
> +static ssize_t aio_write(struct aio_kiocb *kiocb, const struct iocb *iocb,
>  			 bool vectored, bool compat)
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
> @@ -1924,7 +2228,8 @@ static int __io_submit_one(struct kioctx *ctx, const struct iocb *iocb,
>  		return -EINVAL;
>  	}
>  
> -	if (!get_reqs_available(ctx))
> +	/* Poll IO doesn't need ring reservations */
> +	if (!(ctx->flags & IOCTX_FLAG_IOPOLL) && !get_reqs_available(ctx))
>  		return -EAGAIN;
>  
>  	ret = -EAGAIN;
> @@ -1947,8 +2252,8 @@ static int __io_submit_one(struct kioctx *ctx, const struct iocb *iocb,
>  		}
>  	}
>  
> -	/* Don't support cancel on user mapped iocbs */
> -	if (!(ctx->flags & IOCTX_FLAG_USERIOCB)) {
> +	/* Don't support cancel on user mapped iocbs or polled context */
> +	if (!(ctx->flags & (IOCTX_FLAG_USERIOCB | IOCTX_FLAG_IOPOLL))) {
>  		ret = put_user(KIOCB_KEY, &user_iocb->aio_key);
>  		if (unlikely(ret)) {
>  			pr_debug("EFAULT: aio_key\n");
> @@ -1959,26 +2264,33 @@ static int __io_submit_one(struct kioctx *ctx, const struct iocb *iocb,
>  	req->ki_user_iocb = user_iocb;
>  	req->ki_user_data = iocb->aio_data;
>  
> +	ret = -EINVAL;
>  	switch (iocb->aio_lio_opcode) {
>  	case IOCB_CMD_PREAD:
> -		ret = aio_read(&req->rw, iocb, false, compat);
> +		ret = aio_read(req, iocb, false, compat);
>  		break;
>  	case IOCB_CMD_PWRITE:
> -		ret = aio_write(&req->rw, iocb, false, compat);
> +		ret = aio_write(req, iocb, false, compat);
>  		break;
>  	case IOCB_CMD_PREADV:
> -		ret = aio_read(&req->rw, iocb, true, compat);
> +		ret = aio_read(req, iocb, true, compat);
>  		break;
>  	case IOCB_CMD_PWRITEV:
> -		ret = aio_write(&req->rw, iocb, true, compat);
> +		ret = aio_write(req, iocb, true, compat);
>  		break;
>  	case IOCB_CMD_FSYNC:
> +		if (ctx->flags & IOCTX_FLAG_IOPOLL)
> +			break;
>  		ret = aio_fsync(&req->fsync, iocb, false);
>  		break;
>  	case IOCB_CMD_FDSYNC:
> +		if (ctx->flags & IOCTX_FLAG_IOPOLL)
> +			break;
>  		ret = aio_fsync(&req->fsync, iocb, true);
>  		break;
>  	case IOCB_CMD_POLL:
> +		if (ctx->flags & IOCTX_FLAG_IOPOLL)
> +			break;
>  		ret = aio_poll(req, iocb);
>  		break;
>  	default:
> @@ -1994,13 +2306,21 @@ static int __io_submit_one(struct kioctx *ctx, const struct iocb *iocb,
>  	 */
>  	if (ret)
>  		goto out_put_req;
> +	if (ctx->flags & IOCTX_FLAG_IOPOLL) {
> +		if (test_bit(IOCB_POLL_EAGAIN, &req->ki_flags)) {
> +			ret = -EAGAIN;
> +			goto out_put_req;
> +		}
> +		aio_iopoll_iocb_issued(req);
> +	}
>  	return 0;
>  out_put_req:
>  	if (req->ki_eventfd)
>  		eventfd_ctx_put(req->ki_eventfd);
>  	iocb_put(req);
>  out_put_reqs_available:
> -	put_reqs_available(ctx, 1);
> +	if (!(ctx->flags & IOCTX_FLAG_IOPOLL))
> +		put_reqs_available(ctx, 1);
>  	return ret;
>  }
>  
> @@ -2166,7 +2486,7 @@ SYSCALL_DEFINE3(io_cancel, aio_context_t, ctx_id, struct iocb __user *, iocb,
>  	if (unlikely(!ctx))
>  		return -EINVAL;
>  
> -	if (ctx->flags & IOCTX_FLAG_USERIOCB)
> +	if (ctx->flags & (IOCTX_FLAG_USERIOCB | IOCTX_FLAG_IOPOLL))
>  		goto err;
>  
>  	spin_lock_irq(&ctx->ctx_lock);
> @@ -2201,8 +2521,12 @@ static long do_io_getevents(aio_context_t ctx_id,
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
> index 814e6606c413..ea0b9a19f4df 100644
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
> @@ -107,6 +109,7 @@ struct iocb {
>  }; /* 64 bytes */
>  
>  #define IOCTX_FLAG_USERIOCB	(1 << 0)	/* iocbs are user mapped */
> +#define IOCTX_FLAG_IOPOLL	(1 << 1)	/* io_context is polled */
>  
>  #undef IFBIG
>  #undef IFLITTLE

