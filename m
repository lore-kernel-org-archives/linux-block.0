Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59AE7227B9F
	for <linux-block@vger.kernel.org>; Fri, 15 Aug 2025 13:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755264277; cv=none; b=dEgii0coZ3IYqvCZPGU3Ke7NHTipphpU4GQmUl30CLykNElsln1CE6JgdHtfdcBBeWy7fEHYIoo8r5tCXFJFDVX84agzBvKHdCulqPcJrPE8dcPPrX+yLtwpLWFdAFKTQAshWt6jUg8zSsFX2xM5pN0QpEdrJbMBz4kCY467U4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755264277; c=relaxed/simple;
	bh=TToi++8Lh6KFS3ngDiuKMqbD/sMVLYzDdnMoSwUlLKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qHIiWubIdkN9/9UmrE+dmDZW/woigsysPULV/pk//3WwJKqDsAsTz7f294z8sUfE3MmIaCZL7IjxIRxD1D63mMCE4n2+ZPlarHbFnHpLvFOAaE4l/n17wiLmr+/4WdWhaYOG55lxLPyYNT4C7iD+vg/PUlI9dLmod2bfooYtSFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PyJr6oNt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PyJr6oNt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755264274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6Rvt5WwluQ6mzSr1t1jhxCXpV8cZWswqUWnonfOp5pU=;
	b=PyJr6oNtTVeZomjyIXTe+0uIraVJbqeCAV57wRu2ZIh8r6SGccrMhvVt7DBpGFC1sxDTJY
	BOQgxgA4Ugg1jfWCHEWvY4EaVZIov4x1hsn7RyHLRS1RbuXvv23hhaKJcoNfg04Q7G60h4
	31zZHQ80Sje017Q1M9UDa+9d12DOsrQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-629-erpXHPdWMGW9ubhMwLTwRQ-1; Fri,
 15 Aug 2025 09:24:32 -0400
X-MC-Unique: erpXHPdWMGW9ubhMwLTwRQ-1
X-Mimecast-MFC-AGG-ID: erpXHPdWMGW9ubhMwLTwRQ_1755264270
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4FC941955D61;
	Fri, 15 Aug 2025 13:24:30 +0000 (UTC)
Received: from fedora (unknown [10.72.116.16])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 36175180029E;
	Fri, 15 Aug 2025 13:24:18 +0000 (UTC)
Date: Fri, 15 Aug 2025 21:24:10 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-block@vger.kernel.org, axboe@kernel.dk, yukuai1@huaweicloud.com,
	hch@lst.de, shinichiro.kawasaki@wdc.com, kch@nvidia.com,
	gjoyce@ibm.com
Subject: Re: [PATCHv3 3/3] block: avoid cpu_hotplug_lock depedency on
 freeze_lock
Message-ID: <aJ80-lNF-ilorQq8@fedora>
References: <20250814082612.500845-1-nilay@linux.ibm.com>
 <20250814082612.500845-4-nilay@linux.ibm.com>
 <aJ3aR2JodRrAqVcO@fedora>
 <e125025b-d576-4919-b00e-5d9b640bed77@linux.ibm.com>
 <aJ3myQW2A8HtteBC@fedora>
 <e33e97f7-0c12-4f70-81d0-4fea05557579@linux.ibm.com>
 <aJ57lZLhktXxaBoh@fedora>
 <16975629-4988-4841-86bb-d4f3f40cc849@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <16975629-4988-4841-86bb-d4f3f40cc849@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Fri, Aug 15, 2025 at 03:13:19PM +0530, Nilay Shroff wrote:
> 
> 
> On 8/15/25 5:43 AM, Ming Lei wrote:
> > On Thu, Aug 14, 2025 at 08:01:11PM +0530, Nilay Shroff wrote:
> >>
> >>
> >> On 8/14/25 7:08 PM, Ming Lei wrote:
> >>> On Thu, Aug 14, 2025 at 06:27:08PM +0530, Nilay Shroff wrote:
> >>>>
> >>>>
> >>>> On 8/14/25 6:14 PM, Ming Lei wrote:
> >>>>> On Thu, Aug 14, 2025 at 01:54:59PM +0530, Nilay Shroff wrote:
> >>>>>> A recent lockdep[1] splat observed while running blktest block/005
> >>>>>> reveals a potential deadlock caused by the cpu_hotplug_lock dependency
> >>>>>> on ->freeze_lock. This dependency was introduced by commit 033b667a823e
> >>>>>> ("block: blk-rq-qos: guard rq-qos helpers by static key").
> >>>>>>
> >>>>>> That change added a static key to avoid fetching q->rq_qos when
> >>>>>> neither blk-wbt nor blk-iolatency is configured. The static key
> >>>>>> dynamically patches kernel text to a NOP when disabled, eliminating
> >>>>>> overhead of fetching q->rq_qos in the I/O hot path. However, enabling
> >>>>>> a static key at runtime requires acquiring both cpu_hotplug_lock and
> >>>>>> jump_label_mutex. When this happens after the queue has already been
> >>>>>> frozen (i.e., while holding ->freeze_lock), it creates a locking
> >>>>>> dependency from cpu_hotplug_lock to ->freeze_lock, which leads to a
> >>>>>> potential deadlock reported by lockdep [1].
> >>>>>>
> >>>>>> To resolve this, replace the static key mechanism with q->queue_flags:
> >>>>>> QUEUE_FLAG_QOS_ENABLED. This flag is evaluated in the fast path before
> >>>>>> accessing q->rq_qos. If the flag is set, we proceed to fetch q->rq_qos;
> >>>>>> otherwise, the access is skipped.
> >>>>>>
> >>>>>> Since q->queue_flags is commonly accessed in IO hotpath and resides in
> >>>>>> the first cacheline of struct request_queue, checking it imposes minimal
> >>>>>> overhead while eliminating the deadlock risk.
> >>>>>>
> >>>>>> This change avoids the lockdep splat without introducing performance
> >>>>>> regressions.
> >>>>>>
> >>>>>> [1] https://lore.kernel.org/linux-block/4fdm37so3o4xricdgfosgmohn63aa7wj3ua4e5vpihoamwg3ui@fq42f5q5t5ic/
> >>>>>>
> >>>>>> Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> >>>>>> Closes: https://lore.kernel.org/linux-block/4fdm37so3o4xricdgfosgmohn63aa7wj3ua4e5vpihoamwg3ui@fq42f5q5t5ic/
> >>>>>> Fixes: 033b667a823e ("block: blk-rq-qos: guard rq-qos helpers by static key")
> >>>>>> Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> >>>>>> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> >>>>>> ---
> >>>>>>  block/blk-mq-debugfs.c |  1 +
> >>>>>>  block/blk-rq-qos.c     |  9 ++++---
> >>>>>>  block/blk-rq-qos.h     | 54 ++++++++++++++++++++++++------------------
> >>>>>>  include/linux/blkdev.h |  1 +
> >>>>>>  4 files changed, 37 insertions(+), 28 deletions(-)
> >>>>>>
> >>>>>> diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
> >>>>>> index 7ed3e71f2fc0..32c65efdda46 100644
> >>>>>> --- a/block/blk-mq-debugfs.c
> >>>>>> +++ b/block/blk-mq-debugfs.c
> >>>>>> @@ -95,6 +95,7 @@ static const char *const blk_queue_flag_name[] = {
> >>>>>>  	QUEUE_FLAG_NAME(SQ_SCHED),
> >>>>>>  	QUEUE_FLAG_NAME(DISABLE_WBT_DEF),
> >>>>>>  	QUEUE_FLAG_NAME(NO_ELV_SWITCH),
> >>>>>> +	QUEUE_FLAG_NAME(QOS_ENABLED),
> >>>>>>  };
> >>>>>>  #undef QUEUE_FLAG_NAME
> >>>>>>  
> >>>>>> diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
> >>>>>> index b1e24bb85ad2..654478dfbc20 100644
> >>>>>> --- a/block/blk-rq-qos.c
> >>>>>> +++ b/block/blk-rq-qos.c
> >>>>>> @@ -2,8 +2,6 @@
> >>>>>>  
> >>>>>>  #include "blk-rq-qos.h"
> >>>>>>  
> >>>>>> -__read_mostly DEFINE_STATIC_KEY_FALSE(block_rq_qos);
> >>>>>> -
> >>>>>>  /*
> >>>>>>   * Increment 'v', if 'v' is below 'below'. Returns true if we succeeded,
> >>>>>>   * false if 'v' + 1 would be bigger than 'below'.
> >>>>>> @@ -319,8 +317,8 @@ void rq_qos_exit(struct request_queue *q)
> >>>>>>  		struct rq_qos *rqos = q->rq_qos;
> >>>>>>  		q->rq_qos = rqos->next;
> >>>>>>  		rqos->ops->exit(rqos);
> >>>>>> -		static_branch_dec(&block_rq_qos);
> >>>>>>  	}
> >>>>>> +	blk_queue_flag_clear(QUEUE_FLAG_QOS_ENABLED, q);
> >>>>>>  	mutex_unlock(&q->rq_qos_mutex);
> >>>>>>  }
> >>>>>>  
> >>>>>> @@ -346,7 +344,7 @@ int rq_qos_add(struct rq_qos *rqos, struct gendisk *disk, enum rq_qos_id id,
> >>>>>>  		goto ebusy;
> >>>>>>  	rqos->next = q->rq_qos;
> >>>>>>  	q->rq_qos = rqos;
> >>>>>> -	static_branch_inc(&block_rq_qos);
> >>>>>> +	blk_queue_flag_set(QUEUE_FLAG_QOS_ENABLED, q);
> >>>>>
> >>>>> One stupid question: can we simply move static_branch_inc(&block_rq_qos)
> >>>>> out of queue freeze in rq_qos_add()?
> >>>>>
> >>>>> What matters is just the 1st static_branch_inc() which switches the counter
> >>>>> from 0 to 1, when blk_mq_freeze_queue() guarantees that all in-progress code
> >>>>> paths observe q->rq_qos as NULL. That means static_branch_inc(&block_rq_qos)
> >>>>> needn't queue freeze protection.
> >>>>>
> >>>> I thought about it earlier but that won't work because we have 
> >>>> code paths freezing queue before it reaches upto rq_qos_add(),
> >>>> For instance:
> >>>>
> >>>> We have following code paths from where we invoke
> >>>> rq_qos_add() APIs with queue already frozen:
> >>>>
> >>>> ioc_qos_write()
> >>>>  -> blkg_conf_open_bdev_frozen() => freezes queue
> >>>>  -> blk_iocost_init()
> >>>>    -> rq_qos_add()
> >>>>
> >>>> queue_wb_lat_store()  => freezes queue
> >>>>  -> wbt_init()
> >>>>   -> rq_qos_add() 
> >>>
> >>> The above two shouldn't be hard to solve, such as, add helper
> >>> rq_qos_prep_add() for increasing the static branch counter.
> >>>
> >> Yes but then it means that IOs which would be in flight 
> >> would take a hit in hotpath: In hotpath those IOs
> >> would evaluate static key branch to true and then fetch 
> >> q->rq_qos (which probably would not be in the first
> >> cacheline). So are we okay to take hat hit in IO 
> >> hotpath?
> > 
> > But it is that in-tree code is doing, isn't it?
> > 
> > `static branch` is only evaluated iff at least one rqos is added.
> > 
> In the current in-tree implementation, the static branch is evaluated
> only if at least one rq_qos is added.
> 
> Per you suggested change, we would increment the static branch key before
> freezing the queue (and before attaching the QoS policy to the request queue).
> This means that any I/O already in flight would see the static branch key
> as enabled and would proceed to fetch q->rq_qos, even though q->rq_qos would
> still be NULL at that point since the QoS policy hasn’t yet been attached.
> This results in a performance penalty due to the additional q->rq_qos fetch.
> 
> In contrast, the current tree avoids this penalty. The existing sequence is:
> - Freeze the queue.
> - Attach the QoS policy to the queue (q->rq_qos becomes non-NULL).
> - Increment the static branch key.
> - Unfreeze the queue.
> 
> With this ordering, if the hotpath finds the static branch key enabled, it is
> guaranteed that q->rq_qos is non-NULL. Thus, we either:
> - Skip evaluating the static branch key (and q->rq_qos) entirely, or
> - If the static branch key is enabled, also have a valid q->rq_qos.
> 
> In summary, it appears that your proposed ordering introduces a window where the
> static branch key is enabled but q->rq_qos is still NULL, incurring unnecessary
> fetch overhead in the I/O hotpath.

Yes, but the window is pretty small, so the extra overhead isn't something
matters. More importantly it shows correct static_branch_*() usage, which is
supposed to be called safely without subsystem lock.


Thanks,
Ming

