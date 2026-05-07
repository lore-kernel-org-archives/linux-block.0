Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45AE03264E7;
	Thu,  7 May 2026 22:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778194614; cv=none; b=K6Njfk0gwiMGFYMYhRZFVNu0I2zC8cX417g7YDaCoCZPMFJ/bCCVajkp9m1h0HDgtCGWvUiwQi2S9mCn+iRFyxPc6v3mDqMLV/LEsk6m8Cb44ScKTdJ7L26wH2UXPPDHaclBJocFmwhO+VpYJBPuk8ey/TRfYHy+qxrVamMiLPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778194614; c=relaxed/simple;
	bh=TnN/p2pnrI8ykyd5PWac+TWYJgt6p+yj+9CxJJm8xoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AUunA1C5T9/entVqQRsRkOeuLUC3T4A9i7b3qhl4NgwlrS7mX+dV+Wvb69Ujeou3x5Z+gZ9h3LeYH0cTFH1mB47CBrVDUqcGCQYSjm0tPva5WbRfO0gz5yEJJUYd8v2kucIacrSD95J1fDqqlgFPLwWUbgvOyhOcuZ3+xVi92wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KWRvLF1M; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KWRvLF1M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7A56C2BCB2;
	Thu,  7 May 2026 22:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778194613;
	bh=TnN/p2pnrI8ykyd5PWac+TWYJgt6p+yj+9CxJJm8xoI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KWRvLF1MJF6ryQ4WTtpODsGPa/oRYen6vVh3cq/6vRARvX2mqP90ztD1CfqrRlZne
	 rJsBKjryno7yUmISyiEX90zqib23YRw0NQHsMRYmXDdcRDtDIj0PvyNePSSPtIpIOE
	 c8bV/56SrC0AnOVyC8rn/iOa5Xe0YT/quqGa9OX0uc7oOymX763n1Og7QZ+co3Ym1L
	 AecDHYC0rzKzY4Av4eiY5fBpnA8gWCNRphuMPxRAYz8xp9A7gufP9+G5qkhnQWSus4
	 fijp19qtlK04RK4ulfJK76kWAYt6c5Ba7f7D7cjJdc/o6BfTHylCW22VZbwVUYSMHE
	 ow38pnkX7sJJQ==
Date: Thu, 7 May 2026 15:56:52 -0700
From: Minchan Kim <minchan@kernel.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Richard Chang <richardycc@google.com>, Jens Axboe <axboe@kernel.dk>,
	Andrew Morton <akpm@linux-foundation.org>, bgeffon@google.com,
	liumartin@google.com, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] zram: fix use-after-free in zram_writeback_endio
Message-ID: <af0YtJOLGvO-LJow@google.com>
References: <20260504123230.3833765-1-richardycc@google.com>
 <afoc5qLvK2PDQKb-@google.com>
 <afw2919RiZje9xzq@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afw2919RiZje9xzq@google.com>

On Thu, May 07, 2026 at 06:40:37PM +0900, Sergey Senozhatsky wrote:
> On (26/05/05 09:37), Minchan Kim wrote:
> > > @@ -966,9 +966,8 @@ static void zram_writeback_endio(struct bio *bio)
> > >
> > >  	spin_lock_irqsave(&wb_ctl->done_lock, flags);
> > >  	list_add(&req->entry, &wb_ctl->done_reqs);
> > > -	spin_unlock_irqrestore(&wb_ctl->done_lock, flags);
> > > -
> > >  	wake_up(&wb_ctl->done_wait);
> > > +	spin_unlock_irqrestore(&wb_ctl->done_lock, flags);
> > >  }
> > >
> >
> > I agree this will fix the issue, but using a lock to extend the lifetime of
> > an object to avoid a UAF is not a good pattern. Object lifetime shared between
> > process and interrupt contexts should be managed explicitly using refcount.
> 
> ->num_inflight is a ref-counter, basically.  The problem is that
> completion is a two-step process, only one part of each is synchronized
> with the writeback context.  I honestly don't want to have two ref-counts:
> one for requests pending zram completion and one for active endio contexts.
> Maybe we can repurpose num_inflight instead.

If it can make the code much clearer and simpler, I have no objection.

> 
> > Furthermore, keeping wake_up() outside the critical section minimizes
> > interrupt-disabled latency
> 
> So I considered that, but isn't endio already called from IRQ context?
> Just asking.  We wakeup only one waiter (writeback task), so it's not
> that bad CPU-cycles wise.  Do you think it's really a concern?

I don't think it will have any measurable impact; I was just pointing out
a theoretical one.

> 
> wake_up() under spin-lock solves the problem of a unsynchronized
> two-stages endio process.
> 
> > and avoids nesting spinlocks (done_lock -> done_wait.lock), reducing
> > the risk of future lockdep issues, just in case.
> 
> I considered lockdep as well but ruled it out as impossible scenario,
> nesting here is strictly uni-directional, we never call into zram from
> the scheduler.  Just saying.

Sure. I just prefer to avoid adding more lock dependencies without a strong
justification, to prevent potential locking issues in the future.

> 
> > It definitely will add more overhead for the submission/completion paths to deal
> > with the refcount, but I think we should go that way at the cost of runtime.
> 
> Dunno, something like below maybe?
> 
> ---
>  drivers/block/zram/zram_drv.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> index ce2e1c79fc75..27fe50d666d7 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -967,7 +967,7 @@ static int zram_writeback_complete(struct zram *zram, struct zram_wb_req *req)
>  static void zram_writeback_endio(struct bio *bio)
>  {
>  	struct zram_wb_req *req = container_of(bio, struct zram_wb_req, bio);
> -	struct zram_wb_ctl *wb_ctl = bio->bi_private;
> +	struct zram_wb_ctl *wb_ctl = READ_ONCE(bio->bi_private);
>  	unsigned long flags;
>  
>  	spin_lock_irqsave(&wb_ctl->done_lock, flags);
> @@ -975,6 +975,7 @@ static void zram_writeback_endio(struct bio *bio)
>  	spin_unlock_irqrestore(&wb_ctl->done_lock, flags);
>  
>  	wake_up(&wb_ctl->done_wait);
> +	atomic_dec(&wb_ctl->num_inflight);
>  }
>  
>  static void zram_submit_wb_request(struct zram *zram,
> @@ -998,7 +999,7 @@ static int zram_complete_done_reqs(struct zram *zram,
>  	unsigned long flags;
>  	int ret = 0, err;
>  
> -	while (atomic_read(&wb_ctl->num_inflight) > 0) {
> +	for (;;) {
>  		spin_lock_irqsave(&wb_ctl->done_lock, flags);
>  		req = list_first_entry_or_null(&wb_ctl->done_reqs,
>  					       struct zram_wb_req, entry);
> @@ -1006,7 +1007,6 @@ static int zram_complete_done_reqs(struct zram *zram,
>  			list_del(&req->entry);
>  		spin_unlock_irqrestore(&wb_ctl->done_lock, flags);
>  
> -		/* ->num_inflight > 0 doesn't mean we have done requests */
>  		if (!req)
>  			break;
>  
> @@ -1014,7 +1014,6 @@ static int zram_complete_done_reqs(struct zram *zram,
>  		if (err)
>  			ret = err;
>  
> -		atomic_dec(&wb_ctl->num_inflight);
>  		release_pp_slot(zram, req->pps);
>  		req->pps = NULL;
>  
> @@ -1129,8 +1128,11 @@ static int zram_writeback_slots(struct zram *zram,
>  	if (req)
>  		release_wb_req(req);
>  
> -	while (atomic_read(&wb_ctl->num_inflight) > 0) {
> -		wait_event(wb_ctl->done_wait, !list_empty(&wb_ctl->done_reqs));
> +	while (atomic_read(&wb_ctl->num_inflight) ||
> +	       !list_empty(&wb_ctl->done_reqs)) {
> +		wait_event_timeout(wb_ctl->done_wait,
> +				   !list_empty(&wb_ctl->done_reqs),
> +				   HZ);
>  		err = zram_complete_done_reqs(zram, wb_ctl);
>  		if (err)
>  			ret = err;

I understand why you used a timeout here, but I still don't think it's a good
idea since the user could wait for up to a second unnecessarily during the
race.

What I prefer is simple and explicit lifetime management for wb_ctl using
refcount. It directly addresses the core issue (UAF of wb_ctl) in a standard,
robust way without needing workarounds like timeouts. The runtime overhead
of kref will be negligible.

Something like this:

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index a324ede6206d..28ab4a24e77f 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -33,6 +33,7 @@
 #include <linux/cpuhotplug.h>
 #include <linux/part_stat.h>
 #include <linux/kernel_read_file.h>
+#include <linux/kref.h>
 
 #include "zram_drv.h"
 
@@ -504,6 +505,7 @@ struct zram_wb_ctl {
 	wait_queue_head_t done_wait;
 	spinlock_t done_lock;
 	atomic_t num_inflight;
+	struct kref kref;
 };
 
 struct zram_wb_req {
@@ -829,11 +831,8 @@ static void release_wb_req(struct zram_wb_req *req)
 	kfree(req);
 }
 
-static void release_wb_ctl(struct zram_wb_ctl *wb_ctl)
+static void __release_wb_ctl(struct zram_wb_ctl *wb_ctl)
 {
-	if (!wb_ctl)
-		return;
-
 	/* We should never have inflight requests at this point */
 	WARN_ON(atomic_read(&wb_ctl->num_inflight));
 	WARN_ON(!list_empty(&wb_ctl->done_reqs));
@@ -850,6 +849,18 @@ static void release_wb_ctl(struct zram_wb_ctl *wb_ctl)
 	kfree(wb_ctl);
 }
 
+static void release_wb_ctl_kref(struct kref *kref)
+{
+	struct zram_wb_ctl *wb_ctl = container_of(kref, struct zram_wb_ctl, kref);
+
+	__release_wb_ctl(wb_ctl);
+}
+
+static void release_wb_ctl(struct zram_wb_ctl *wb_ctl)
+{
+	kref_put(&wb_ctl->kref, release_wb_ctl_kref);
+}
+
 static struct zram_wb_ctl *init_wb_ctl(struct zram *zram)
 {
 	struct zram_wb_ctl *wb_ctl;
@@ -864,6 +875,7 @@ static struct zram_wb_ctl *init_wb_ctl(struct zram *zram)
 	atomic_set(&wb_ctl->num_inflight, 0);
 	init_waitqueue_head(&wb_ctl->done_wait);
 	spin_lock_init(&wb_ctl->done_lock);
+	kref_init(&wb_ctl->kref);
 
 	for (i = 0; i < zram->wb_batch_size; i++) {
 		struct zram_wb_req *req;
@@ -985,6 +997,7 @@ static void zram_writeback_endio(struct bio *bio)
 	spin_unlock_irqrestore(&wb_ctl->done_lock, flags);
 
 	wake_up(&wb_ctl->done_wait);
+	kref_put(&wb_ctl->kref, release_wb_ctl_kref);
 }
 
 static void zram_submit_wb_request(struct zram *zram,
@@ -996,6 +1009,7 @@ static void zram_submit_wb_request(struct zram *zram,
 	 * so that we don't over-submit.
 	 */
 	zram_account_writeback_submit(zram);
+	kref_get(&wb_ctl->kref);
 	atomic_inc(&wb_ctl->num_inflight);
 	req->bio.bi_private = wb_ctl;
 	submit_bio(&req->bio);
@@ -1276,8 +1290,8 @@ static ssize_t writeback_store(struct device *dev,
 
 	wb_ctl = init_wb_ctl(zram);
 	if (!wb_ctl) {
-		ret = -ENOMEM;
-		goto out;
+		release_pp_ctl(zram, pp_ctl);
+		return -ENOMEM;
 	}
 
 	args = skip_spaces(buf);

