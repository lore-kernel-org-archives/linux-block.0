Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704641C7018
	for <linux-block@vger.kernel.org>; Thu,  6 Feb 2025 14:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738850835; cv=none; b=EK+IithAto083GWa4DoPJm6bWMASstlgznxGDi8yJDfTSBwZgssap8Qt2pdwfF8swDKvQe0B4eYSZjKbVZVg8Jy35jvET85p7gElH7S+czbLXG5CfsmieNnr70yNnmOC+/YDVWzhnHfYVlpeR9Htp3lgByj2N2+j47eubT+jZ6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738850835; c=relaxed/simple;
	bh=3bWDb/ul51DFVHvqp3KYkGGNcDFBGLiBW0Yn51ihUTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eK/eBwRWMVKlfHXMs2JsWcPXF1rF/m/YMjdUOrgzFkrdWqDwXcfyKKS47CWNtYc9ZwgqDjNTkZxtjN11c5IkChUbVreFI9+7qIWGHsx1GcD3HIEVEWYygTdtppTn4qMXdzIOGklRmtUTW1kCIalpSS8eBBBw0xnrCn8+7txBUpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 409C168D0D; Thu,  6 Feb 2025 15:07:08 +0100 (CET)
Date: Thu, 6 Feb 2025 15:07:08 +0100
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
	ming.lei@redhat.com, dlemoal@kernel.org, axboe@kernel.dk,
	gjoyce@ibm.com
Subject: Re: [PATCH 2/2] block: avoid acquiring q->sysfs_lock while
 accessing sysfs attributes
Message-ID: <20250206140707.GA2141@lst.de>
References: <20250205144506.663819-1-nilay@linux.ibm.com> <20250205144506.663819-3-nilay@linux.ibm.com> <20250205155330.GA14133@lst.de> <f933e87a-6014-434a-8258-d871c77ca14c@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f933e87a-6014-434a-8258-d871c77ca14c@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Feb 06, 2025 at 07:24:02PM +0530, Nilay Shroff wrote:
> Yes that's possible and so I audited all sysfs attributes which are 
> currently protected using q->sysfs_lock and I found some interesting
> facts. Please find below:
> 
> 1. io_poll:
>    Write to this attribute is ignored. So, we don't need q->sysfs_lock.
> 
> 2. io_poll_delay:
>    Write to this attribute is NOP, so we don't need q->sysfs_lock.

Yes, those are easy.

> 3. io_timeout:
>    Write to this attribute updates q->rq_timeout and read of this attribute
>    returns the value stored in q->rq_timeout Moreover, the q->rq_timeout is
>    set only once when we init the queue (under blk_mq_init_allocated_queue())
>    even before disk is added. So that means that we may not need to protect
>    it with q->sysfs_lock.

Are we sure blk_queue_rq_timeout is never called from anything but
probe?  Either way given that this is a limit that isn't directly
corelated with anything else simply using WRITE_ONCE/READ_ONCE might
be enough.

> 
> 4. nomerges:
>    Write to this attribute file updates two q->flags : QUEUE_FLAG_NOMERGES 
>    and QUEUE_FLAG_NOXMERGES. These flags are accessed during bio-merge which
>    anyways doesn't run with q->sysfs_lock held. Moreover, the q->flags are 
>    updated/accessed with bitops which are atomic. So, I believe, protecting
>    it with q->sysfs_lock is not necessary.

Yes.

> 5. nr_requests:
>    Write to this attribute updates the tag sets and this could potentially
>    race with __blk_mq_update_nr_hw_queues(). So I think we should really 
>    protect it with q->tag_set->tag_list_lock instead of q->sysfs_lock.

Yeah.

> 6. read_ahead_kb:
>    Write to this attribute file updates disk->bdi->ra_pages. The disk->bdi->
>    ra_pages is also updated under queue_limits_commit_update() which runs 
>    holding q->limits_lock; so I think this attribute file should be protected
>    with q->limits_lock and protecting it with q->sysfs_lock is not necessary. 
>    Maybe we should move it under the same sets of attribute files which today
>    runs with q->limits_lock held.

Yes, limits_lock sounds sensible here.

> 7. rq_affinity:
>    Write to this attribute file makes atomic updates to q->flags: QUEUE_FLAG_SAME_COMP
>    and QUEUE_FLAG_SAME_FORCE. These flags are also accessed from blk_mq_complete_need_ipi()
>    using test_bit macro. As read/write to q->flags uses bitops which are atomic, 
>    protecting it with q->stsys_lock is not necessary.

Agreed.  Although updating both flags isn't atomic that should be
harmless in this case (but could use a comment about that).

> 8. scheduler:
>    Write to this attribute actually updates q->elevator and the elevator change/switch 
>    code expects that the q->sysfs_lock is held while we update the iosched to protect 
>    against the simultaneous __blk_mq_update_nr_hw_queues update. So yes, this field needs 
>    q->sysfs_lock protection.
> 
>    However if we're thinking of protecting sched change/update using q->tag_sets->
>    tag_list_lock (as discussed in another thread), then we may use q->tag_set->
>    tag_list_lock instead of q->sysfs_lock here while reading/writing to this attribute
>    file.

Yes.

> 9. wbt_lat_usec:
>    Write to this attribute file updates the various wbt limits and state. This may race 
>    with blk_mq_exit_sched() or blk_register_queue(). The wbt updates through the 
>    blk_mq_exit_sched() and blk_register_queue() is currently protected with q->sysfs_lock
>    and so yes, we need to protect this attribute with q->sysfs_lock.
> 
>    However, as mentioned above, if we're thinking of protecting elevator change/update
>    using q->sets->tag_list_lock then we may use q->tag_set->tag_list_lock intstead of
>    q->sysfs_lock while reading/writing to this attribute file.

Yes.

> The rest of attributes seems don't require protection from q->sysfs_lock or any other lock and 
> those could be well protected with the sysfs/kernfs internal lock.

So I think the first step here is to remove the locking from
queue_attr_store/queue_attr_show and move it into the attributes that
still need it in some form, followed by replacing it with the more
suitable locks as defined above.  And maybe with a little bit more
work we can remove sysfs_lock entirely eventually.
