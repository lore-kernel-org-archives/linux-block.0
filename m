Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8F2208D7
	for <linux-block@vger.kernel.org>; Sat,  7 Sep 2024 11:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725706971; cv=none; b=Sh288J6goINjqggEiPq+BC/Q/Ru5rsAS4CRBbXnkRF7Gwlc1eEd/RVyy0cycNP6jAwNBmNyVXtCt67pGJdPwetr5vxWdJva5vrhUvJihl77YIEqUhsfUQQVR0DKqFmMf4MHbd7NAlYev2PEQ3Kz9orjYUccP+gYWYHuJjpElSEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725706971; c=relaxed/simple;
	bh=KFrYcXwdMKSHys7NmU5zbbt82NsAKT7f528DCt1hKlY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XHSneMZb9dX0U+LkOexNT80DYxVR4CSZWaVD+GwzyrSAUvLILPkH1fnZND1GU3gC5l8rniwx3uLENLVOSFG5tnxi0ECoeXtv208OlkDOcyZhMzC9JCyMnFGe0aTJKnk9aSOYfkRontlu5MV42uE5qlAdhGewq+MjuTNRVF/MGZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YcR3tj8y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YcR3tj8y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725706968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fdjenmwlbd/SiJ+UYByHXwHyXyL93NBVTPtcwfBhHug=;
	b=YcR3tj8ynctA2ZpVKZlAdYv+HELUrjjI02Mlr/+8arfj4ECzBKr7BB5gOkFIcDNklWrhZ9
	lr81ppuUYcQr8b9+DHs7GtvY6A8YG6QIJoTr3e8qchpObg6+uCXw2iIclpdlVQQ7ucCMwM
	8wrBmVaB3VVMd+b6AkhV5kQaAu+i7Ds=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-148-2N7lgqb-Pryjgf79_0LgLQ-1; Sat,
 07 Sep 2024 07:02:45 -0400
X-MC-Unique: 2N7lgqb-Pryjgf79_0LgLQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B53DF1955BC1;
	Sat,  7 Sep 2024 11:02:43 +0000 (UTC)
Received: from fedora (unknown [10.72.116.7])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 68CF11956054;
	Sat,  7 Sep 2024 11:02:35 +0000 (UTC)
Date: Sat, 7 Sep 2024 19:02:30 +0800
From: Ming Lei <ming.lei@redhat.com>
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, Jeff Moyer <jmoyer@redhat.com>,
	Jiri Jaburek <jjaburek@redhat.com>, Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>,
	Hannes Reinecke <hare@suse.de>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH] block: elevator: avoid to load iosched module from this
 disk
Message-ID: <ZtwyxukuaXAscXsz@fedora>
References: <20240907014331.176152-1-ming.lei@redhat.com>
 <20240907073522.GW1450@redhat.com>
 <ZtwHwTh6FYn+WnGD@fedora>
 <4d7280eb-7f26-4652-a1d4-4f82c4d99a4c@kernel.org>
 <ZtwhfCtDpTrBUFY+@fedora>
 <20240907100213.GY1450@redhat.com>
 <Ztwl2RvR0DGbNuex@fedora>
 <20240907103632.GZ1450@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240907103632.GZ1450@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Sat, Sep 07, 2024 at 11:36:32AM +0100, Richard W.M. Jones wrote:
> On Sat, Sep 07, 2024 at 06:07:21PM +0800, Ming Lei wrote:
> > On Sat, Sep 07, 2024 at 11:02:13AM +0100, Richard W.M. Jones wrote:
> > > On Sat, Sep 07, 2024 at 05:48:44PM +0800, Ming Lei wrote:
> > > > On Sat, Sep 07, 2024 at 06:04:59PM +0900, Damien Le Moal wrote:
> > > > > On 9/7/24 16:58, Ming Lei wrote:
> > > > > > On Sat, Sep 07, 2024 at 08:35:22AM +0100, Richard W.M. Jones wrote:
> > > > > >> On Sat, Sep 07, 2024 at 09:43:31AM +0800, Ming Lei wrote:
> > > > > >>> When switching io scheduler via sysfs, 'request_module' may be called
> > > > > >>> if the specified scheduler doesn't exist.
> > > > > >>>
> > > > > >>> This was has deadlock risk because the module may be stored on FS behind
> > > > > >>> our disk since request queue is frozen before switching its elevator.
> > > > > >>>
> > > > > >>> Fix it by returning -EDEADLK in case that the disk is claimed, which
> > > > > >>> can be thought as one signal that the disk is mounted.
> > > > > >>>
> > > > > >>> Some distributions(Fedora) simulates the original kernel command line of
> > > > > >>> 'elevator=foo' via 'echo foo > /sys/block/$DISK/queue/scheduler', and boot
> > > > > >>> hang is triggered.
> > > > > >>>
> > > > > >>> Cc: Richard Jones <rjones@redhat.com>
> > > > > >>> Cc: Jeff Moyer <jmoyer@redhat.com>
> > > > > >>> Cc: Jiri Jaburek <jjaburek@redhat.com>
> > > > > >>> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > > > > >>
> > > > > >> I'd suggest also:
> > > > > >>
> > > > > >> Bug: https://bugzilla.kernel.org/show_bug.cgi?id=219166
> > > > > >> Reported-by: Richard W.M. Jones <rjones@redhat.com>
> > > > > >> Reported-by: Jiri Jaburek <jjaburek@redhat.com>
> > > > > >> Tested-by: Richard W.M. Jones <rjones@redhat.com>
> > > > > >>
> > > > > >> So I have tested this patch and it does fix the issue, at the possible
> > > > > >> cost that now setting the scheduler can fail:
> > > > > >>
> > > > > >>   + for f in /sys/block/{h,s,ub,v}d*/queue/scheduler
> > > > > >>   + echo noop
> > > > > >>   /init: line 109: echo: write error: Resource deadlock avoided
> > > > > >>
> > > > > >> (I know I'm setting it to an impossible value here, but this could
> > > > > >> also happen when setting it to a valid one.)
> > > > > > 
> > > > > > Actually in most of dist, io-schedulers are built-in, so request_module
> > > > > > is just a nop, but meta IO must be started.
> > > > > > 
> > > > > >>
> > > > > >> Since almost no one checks the result of 'echo foo > /sys/...'  that
> > > > > >> would probably mean that sometimes a desired setting is silently not
> > > > > >> set.
> > > > > > 
> > > > > > As I mentioned, io-schedulers are built-in for most of dist, so
> > > > > > request_module isn't called in case of one valid io-sched.
> > > > > > 
> > > > > >>
> > > > > >> Also I bisected this bug yesterday and found it was caused by (or,
> > > > > >> more likely, exposed by):
> > > > > >>
> > > > > >>   commit af2814149883e2c1851866ea2afcd8eadc040f79
> > > > > >>   Author: Christoph Hellwig <hch@lst.de>
> > > > > >>   Date:   Mon Jun 17 08:04:38 2024 +0200
> > > > > >>
> > > > > >>     block: freeze the queue in queue_attr_store
> > > > > >>     
> > > > > >>     queue_attr_store updates attributes used to control generating I/O, and
> > > > > >>     can cause malformed bios if changed with I/O in flight.  Freeze the queue
> > > > > >>     in common code instead of adding it to almost every attribute.
> > > > > >>
> > > > > >> Reverting this commit on top of git head also fixes the problem.
> > > > > >>
> > > > > >> Why did this commit expose the problem?
> > > > > > 
> > > > > > That is really the 1st bad commit which moves queue freezing before
> > > > > > calling request_module(), originally we won't freeze queue until
> > > > > > we have to do it.
> > > > > > 
> > > > > > Another candidate fix is to revert it, or at least not do it
> > > > > > for storing elevator attribute.
> > > > > 
> > > > > I do not think that reverting is acceptable. Rather, a proper fix would simply
> > > > 
> > > > Right, I remember that the freezing starts to cover update of
> > > > max_sectors_kb.
> > > > 
> > > > > be to do the request_module() before freezing the queue.
> > > > > Something like below should work (totally untested and that may be overkill).
> > > > > 
> > > > > diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> > > > > index 60116d13cb80..aef87f6b4a8a 100644
> > > > > --- a/block/blk-sysfs.c
> > > > > +++ b/block/blk-sysfs.c
> > > > > @@ -23,6 +23,7 @@
> > > > >  struct queue_sysfs_entry {
> > > > >         struct attribute attr;
> > > > >         ssize_t (*show)(struct gendisk *disk, char *page);
> > > > > +       int (*pre_store)(struct gendisk *disk, const char *page, size_t count);
> > > > 
> > > > It seems over-kill to add one new callback, and another way is just to
> > > > not freeze queue for storing elevator.
> > > > 
> > > > But if other attribute update needs to not freeze queue, 'pre_store'
> > > > looks one reasonable solution.
> > > > 
> > > > diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> > > > index 60116d13cb80..c418edf66f0c 100644
> > > > --- a/block/blk-sysfs.c
> > > > +++ b/block/blk-sysfs.c
> > > > @@ -666,15 +666,24 @@ queue_attr_store(struct kobject *kobj, struct attribute *attr,
> > > >  	struct gendisk *disk = container_of(kobj, struct gendisk, queue_kobj);
> > > >  	struct request_queue *q = disk->queue;
> > > >  	ssize_t res;
> > > > +	bool need_freeze;
> > > >  
> > > >  	if (!entry->store)
> > > >  		return -EIO;
> > > >  
> > > > -	blk_mq_freeze_queue(q);
> > > > +	/*
> > > > +	 * storing scheduler freezes queue in its way, especially
> > > > +	 * loading scheduler module can't be done when queue is frozen
> > > > +	 */
> > > > +	need_freeze = (entry->store == elv_iosched_store);
> > > > +
> > > > +	if (need_freeze)
> > > > +		blk_mq_freeze_queue(q);
> > > >  	mutex_lock(&q->sysfs_lock);
> > > >  	res = entry->store(disk, page, length);
> > > >  	mutex_unlock(&q->sysfs_lock);
> > > > -	blk_mq_unfreeze_queue(q);
> > > > +	if (need_freeze)
> > > > +		blk_mq_unfreeze_queue(q);
> > > >  	return res;
> > > >  }
> > > >  
> > > 
> > > Unfortunately this doesn't fix the problem for me.  The test still
> > > hangs occasionally in the same way as before.
> > 
> > 'need_freeze' needs to be flipped by:
> > 
> > 	need_freeze = (entry->store != elv_iosched_store);
> 
> I'm still running the test (takes 5,000 boot iterations before I can
> be "sure"), but so far it seems flipping this test fixes the bug.

BTW, the issue can be reproduced 100% by:

echo "deadlock" > /sys/block/$ROOT_DISK/queue/scheduler

> 
> This seems like the neatest (or shortest) fix so far, but doesn't it
> "mix up layers" by checking elv_iosched_store?

It is just one exception for 'scheduler' sysfs attribute wrt. freezing
queue for storing, and the check can be done via the attribute
name("scheduler") too.


Thanks, 
Ming

