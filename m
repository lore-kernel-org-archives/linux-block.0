Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA49282F1
	for <linux-block@vger.kernel.org>; Fri, 18 Jul 2025 02:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752804116; cv=none; b=r/eSAB9Rd+L9rns23AHZD1cBJHyYGswIDTDQZcktdr3U4K/bRFU6Cj9Fl5PqvYsNXIG//B+kR+01b0t3jIUhaLEzv/Kc3Xi7dBtptnxwtCbiNXKZVoujp3RLmFn1iOET9bgpJgXKE9cVKb3R+5jIEF/2whbzeCKUGOwb32/8SBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752804116; c=relaxed/simple;
	bh=OkRLJ60mGaiCAuqlJqdMdDk5d27sSmKBLuAdhj4B5wE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kkz/0Bd9dVYQtY6ULm3J9pZUkQtWL3z3vulY96vyKXDQrVvUNBUhgCHm8BNvbavdgCIjUhgA0a/TjVQENWIyqlqTs7Lel7FVeGRdZStG+nxdIFTydcBssYzBY/DATwKa6AaZEWCmGKpApx2vn6rVEgP5dMAPenMDlRJugY1659o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KizXnwBC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KizXnwBC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752804113;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B8rhhwsWezTZddWzu6snEokRLPcA/Uc/eMRnCdEvnII=;
	b=KizXnwBCONgpzAERjAhjoiq1U8e6mPVpI9cAUjTBZzVZJJtjpv9GGfYES6fVgNzlbuDbqW
	PVC5UghZ4ezjzd66PAyx/zkpC+eqLxaYdVkiCa1NsgVQaGSeuDQZq8wO10BKgaixC+Y0aa
	+eMwWzZDV7zXYE/JpHzsHfTth9VtAkY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-607-YY-ijczRNOSCwG8g9n505A-1; Thu,
 17 Jul 2025 22:01:49 -0400
X-MC-Unique: YY-ijczRNOSCwG8g9n505A-1
X-Mimecast-MFC-AGG-ID: YY-ijczRNOSCwG8g9n505A_1752804108
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2C53F195608C;
	Fri, 18 Jul 2025 02:01:47 +0000 (UTC)
Received: from fedora (unknown [10.72.116.95])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6BA1F1956089;
	Fri, 18 Jul 2025 02:01:40 +0000 (UTC)
Date: Fri, 18 Jul 2025 10:01:35 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-block@vger.kernel.org, yi.zhang@redhat.com, hch@lst.de,
	yukuai1@huaweicloud.com, axboe@kernel.dk,
	shinichiro.kawasaki@wdc.com, yukuai3@huawei.com, gjoyce@ibm.com
Subject: Re: [PATCH] block: restore two stage elevator switch while running
 nr_hw_queue update
Message-ID: <aHmq_8uMsdq49iZT@fedora>
References: <20250717141155.473362-1-nilay@linux.ibm.com>
 <aHkMaZnEVEEQc5TL@fedora>
 <2d4dc1c3-2911-469a-95b6-6b482377a375@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2d4dc1c3-2911-469a-95b6-6b482377a375@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On Fri, Jul 18, 2025 at 12:13:25AM +0530, Nilay Shroff wrote:
> 
> 
> On 7/17/25 8:14 PM, Ming Lei wrote:
> 
> >> +static int blk_mq_elv_switch_none(struct request_queue *q,
> >> +		struct xarray *elv_tbl)
> >> +{
> >> +	int ret = 0;
> >> +
> >> +	lockdep_assert_held_write(&q->tag_set->update_nr_hwq_lock);
> >> +
> >> +	/*
> >> +	 * Accessing q->elevator without holding q->elevator_lock is safe here
> >> +	 * because we're called from nr_hw_queue update which is protected by
> >> +	 * set->update_nr_hwq_lock in the writer context. So, scheduler update/
> >> +	 * switch code (which acquires the same lock in the reader context)
> >> +	 * can't run concurrently.
> >> +	 */
> >> +	if (q->elevator) {
> >> +		char *elevator_name = (char *)q->elevator->type->elevator_name;
> >> +
> >> +		ret = xa_insert(elv_tbl, q->id, elevator_name, GFP_KERNEL);
> > 
> > This way isn't memory safe, because elevator module can be reloaded
> > during updating nr_hw_queues. One solution is to build a string<->int mapping
> > table, and store the (int) index of elevator type to xarray.
> > 
> Yes good point! How about avoiding this issue by using __elevator_get() and
> elevator_put()? We can take module reference while switching elevator to 'none'
> and then put the module reference while we switch back elevator.

Yeah, that is another way.

> 
> >> -void elv_update_nr_hw_queues(struct request_queue *q)
> >> -{
> >> -	struct elv_change_ctx ctx = {};
> >> -	int ret = -ENODEV;
> >> -
> >> -	WARN_ON_ONCE(q->mq_freeze_depth == 0);
> >> -
> >> -	mutex_lock(&q->elevator_lock);
> >> -	if (q->elevator && !blk_queue_dying(q) && blk_queue_registered(q)) {
> >> -		ctx.name = q->elevator->type->elevator_name;
> >> -
> >> -		/* force to reattach elevator after nr_hw_queue is updated */
> >> -		ret = elevator_switch(q, &ctx);
> >> -	}
> >> -	mutex_unlock(&q->elevator_lock);
> >> -	blk_mq_unfreeze_queue_nomemrestore(q);
> >> -	if (!ret)
> >> -		WARN_ON_ONCE(elevator_change_done(q, &ctx));
> >> -}
> >> -
> >>  /*
> >>   * Use the default elevator settings. If the chosen elevator initialization
> >>   * fails, fall back to the "none" elevator (no elevator).
> >> diff --git a/block/elevator.h b/block/elevator.h
> >> index a07ce773a38f..440b6e766848 100644
> >> --- a/block/elevator.h
> >> +++ b/block/elevator.h
> >> @@ -85,6 +85,17 @@ struct elevator_type
> >>  	struct list_head list;
> >>  };
> >>  
> >> +/* Holding context data for changing elevator */
> >> +struct elv_change_ctx {
> >> +	const char *name;
> >> +	bool no_uevent;
> >> +
> >> +	/* for unregistering old elevator */
> >> +	struct elevator_queue *old;
> >> +	/* for registering new elevator */
> >> +	struct elevator_queue *new;
> >> +};
> >> +
> > 
> > You may avoid the big chunk of code move for both `elv_change_ctx` and 
> > `elv_update_nr_hw_queues()`, not sure why you did that in a bug fix patch.
> > 
> This is because I’ve reintroduced the blk_mq_elv_switch_none and 
> blk_mq_elv_switch_back functions. I replaced elv_update_nr_hw_queues with
> blk_mq_elv_switch_back(), which was the approach used prior to commit 
> 596dce110b7d ("block: simplify elevator reattachment for updating nr_hw_queues").
> 
> Both blk_mq_elv_switch_none and blk_mq_elv_switch_back are defined in blk-mq.c
> and use the elevator APIs for switching elevators. These APIs — namely 
> elevator_switch and elevator_change_done — rely on the elv_change_ctx structure.
> As a result, I had to move some code around to ensure elv_change_ctx is accessible
> from within blk-mq.c.
> 
> While it would be possible to avoid this code movement by continuing to use 
> elv_update_nr_hw_queues, I felt it was cleaner to restore the two-stage elevator
> switch more fully by reintroducing the blk_mq_elv_switch_none and blk_mq_elv_switch_back 
> APIs, which were used prior to the simplification in the aforementioned commit.
> 
> Do you see any concerns with this code movement? Or is such restructuring generally
> avoided in a bug fix patch?

You still can add blk_mq_elv_switch_none() and blk_mq_elv_switch_back(),
meantime call elv_update_nr_hw_queues() from blk_mq_elv_switch_back() by
passing elevator type name.

If one bug fix is simpler, it may become easier to review & merge in -rc or
backport.


Thanks,
Ming

