Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BBD86323
	for <linux-block@vger.kernel.org>; Thu, 14 Aug 2025 13:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755178720; cv=none; b=MQ7KKsuZucMmnKJ2rWCYDxPWQgtPPzXQ/CNtj342rxJCeRvzj5FmiYpwur0B1IB8+2JcmDcE5XZaclDom9ogcefB+D1RYEFhMJRv/e2HUR9dnCyZ/+zTmum37DPCzOSkO/GHdMQKggrNOITSqP14ZwNwS+KScFY06A58atY5RJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755178720; c=relaxed/simple;
	bh=p9g1131VXexIIyxjsgk76/3GkCI0cbgdW0lFC4wE0MU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AV44mQgJ7K8yC7TdsfVBvEydLYuwG3PdUK1vwtVbocWcPGfO8bn0ArWy+QBZylpwpqCYUIOeiLies+2DN2hJeOgr7ie/xSNRFwqturxza1pLzUw0S92OG4K3wrolzhESQFDCEr7iAGVpu5NbWyG0vCa/dFGR7DByV5N0jWapjc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gwTGRPKJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gwTGRPKJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755178714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4rEz+kekImj12W1Yu+kxqAwAoeY2vd4qzq3KW4fH02Y=;
	b=gwTGRPKJo0LfYa8eLnNzmZHhAvYLmGlzK9WfXf5vW95bs8zJSwG52KfooTLFA0qwihO72S
	TZ47bP885YvS1+d5bFFaxxKdnnWCLQAzNWrkwj17uTHe7mbT6WY+irHwUNH2NQnL3vFPE1
	aUPa1Sfs1tA0V5dpE0+jwYgPTBsBdKs=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-612-ruOEdCfnNSKiFV7PYvq5WA-1; Thu,
 14 Aug 2025 09:38:31 -0400
X-MC-Unique: ruOEdCfnNSKiFV7PYvq5WA-1
X-Mimecast-MFC-AGG-ID: ruOEdCfnNSKiFV7PYvq5WA_1755178710
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A98EC1956096;
	Thu, 14 Aug 2025 13:38:29 +0000 (UTC)
Received: from fedora (unknown [10.72.116.148])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4A18B1800447;
	Thu, 14 Aug 2025 13:38:22 +0000 (UTC)
Date: Thu, 14 Aug 2025 21:38:17 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-block@vger.kernel.org, axboe@kernel.dk, yukuai1@huaweicloud.com,
	hch@lst.de, shinichiro.kawasaki@wdc.com, kch@nvidia.com,
	gjoyce@ibm.com
Subject: Re: [PATCHv3 3/3] block: avoid cpu_hotplug_lock depedency on
 freeze_lock
Message-ID: <aJ3myQW2A8HtteBC@fedora>
References: <20250814082612.500845-1-nilay@linux.ibm.com>
 <20250814082612.500845-4-nilay@linux.ibm.com>
 <aJ3aR2JodRrAqVcO@fedora>
 <e125025b-d576-4919-b00e-5d9b640bed77@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e125025b-d576-4919-b00e-5d9b640bed77@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Thu, Aug 14, 2025 at 06:27:08PM +0530, Nilay Shroff wrote:
> 
> 
> On 8/14/25 6:14 PM, Ming Lei wrote:
> > On Thu, Aug 14, 2025 at 01:54:59PM +0530, Nilay Shroff wrote:
> >> A recent lockdep[1] splat observed while running blktest block/005
> >> reveals a potential deadlock caused by the cpu_hotplug_lock dependency
> >> on ->freeze_lock. This dependency was introduced by commit 033b667a823e
> >> ("block: blk-rq-qos: guard rq-qos helpers by static key").
> >>
> >> That change added a static key to avoid fetching q->rq_qos when
> >> neither blk-wbt nor blk-iolatency is configured. The static key
> >> dynamically patches kernel text to a NOP when disabled, eliminating
> >> overhead of fetching q->rq_qos in the I/O hot path. However, enabling
> >> a static key at runtime requires acquiring both cpu_hotplug_lock and
> >> jump_label_mutex. When this happens after the queue has already been
> >> frozen (i.e., while holding ->freeze_lock), it creates a locking
> >> dependency from cpu_hotplug_lock to ->freeze_lock, which leads to a
> >> potential deadlock reported by lockdep [1].
> >>
> >> To resolve this, replace the static key mechanism with q->queue_flags:
> >> QUEUE_FLAG_QOS_ENABLED. This flag is evaluated in the fast path before
> >> accessing q->rq_qos. If the flag is set, we proceed to fetch q->rq_qos;
> >> otherwise, the access is skipped.
> >>
> >> Since q->queue_flags is commonly accessed in IO hotpath and resides in
> >> the first cacheline of struct request_queue, checking it imposes minimal
> >> overhead while eliminating the deadlock risk.
> >>
> >> This change avoids the lockdep splat without introducing performance
> >> regressions.
> >>
> >> [1] https://lore.kernel.org/linux-block/4fdm37so3o4xricdgfosgmohn63aa7wj3ua4e5vpihoamwg3ui@fq42f5q5t5ic/
> >>
> >> Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> >> Closes: https://lore.kernel.org/linux-block/4fdm37so3o4xricdgfosgmohn63aa7wj3ua4e5vpihoamwg3ui@fq42f5q5t5ic/
> >> Fixes: 033b667a823e ("block: blk-rq-qos: guard rq-qos helpers by static key")
> >> Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> >> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> >> ---
> >>  block/blk-mq-debugfs.c |  1 +
> >>  block/blk-rq-qos.c     |  9 ++++---
> >>  block/blk-rq-qos.h     | 54 ++++++++++++++++++++++++------------------
> >>  include/linux/blkdev.h |  1 +
> >>  4 files changed, 37 insertions(+), 28 deletions(-)
> >>
> >> diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
> >> index 7ed3e71f2fc0..32c65efdda46 100644
> >> --- a/block/blk-mq-debugfs.c
> >> +++ b/block/blk-mq-debugfs.c
> >> @@ -95,6 +95,7 @@ static const char *const blk_queue_flag_name[] = {
> >>  	QUEUE_FLAG_NAME(SQ_SCHED),
> >>  	QUEUE_FLAG_NAME(DISABLE_WBT_DEF),
> >>  	QUEUE_FLAG_NAME(NO_ELV_SWITCH),
> >> +	QUEUE_FLAG_NAME(QOS_ENABLED),
> >>  };
> >>  #undef QUEUE_FLAG_NAME
> >>  
> >> diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
> >> index b1e24bb85ad2..654478dfbc20 100644
> >> --- a/block/blk-rq-qos.c
> >> +++ b/block/blk-rq-qos.c
> >> @@ -2,8 +2,6 @@
> >>  
> >>  #include "blk-rq-qos.h"
> >>  
> >> -__read_mostly DEFINE_STATIC_KEY_FALSE(block_rq_qos);
> >> -
> >>  /*
> >>   * Increment 'v', if 'v' is below 'below'. Returns true if we succeeded,
> >>   * false if 'v' + 1 would be bigger than 'below'.
> >> @@ -319,8 +317,8 @@ void rq_qos_exit(struct request_queue *q)
> >>  		struct rq_qos *rqos = q->rq_qos;
> >>  		q->rq_qos = rqos->next;
> >>  		rqos->ops->exit(rqos);
> >> -		static_branch_dec(&block_rq_qos);
> >>  	}
> >> +	blk_queue_flag_clear(QUEUE_FLAG_QOS_ENABLED, q);
> >>  	mutex_unlock(&q->rq_qos_mutex);
> >>  }
> >>  
> >> @@ -346,7 +344,7 @@ int rq_qos_add(struct rq_qos *rqos, struct gendisk *disk, enum rq_qos_id id,
> >>  		goto ebusy;
> >>  	rqos->next = q->rq_qos;
> >>  	q->rq_qos = rqos;
> >> -	static_branch_inc(&block_rq_qos);
> >> +	blk_queue_flag_set(QUEUE_FLAG_QOS_ENABLED, q);
> > 
> > One stupid question: can we simply move static_branch_inc(&block_rq_qos)
> > out of queue freeze in rq_qos_add()?
> > 
> > What matters is just the 1st static_branch_inc() which switches the counter
> > from 0 to 1, when blk_mq_freeze_queue() guarantees that all in-progress code
> > paths observe q->rq_qos as NULL. That means static_branch_inc(&block_rq_qos)
> > needn't queue freeze protection.
> > 
> I thought about it earlier but that won't work because we have 
> code paths freezing queue before it reaches upto rq_qos_add(),
> For instance:
> 
> We have following code paths from where we invoke
> rq_qos_add() APIs with queue already frozen:
> 
> ioc_qos_write()
>  -> blkg_conf_open_bdev_frozen() => freezes queue
>  -> blk_iocost_init()
>    -> rq_qos_add()
> 
> queue_wb_lat_store()  => freezes queue
>  -> wbt_init()
>   -> rq_qos_add() 

The above two shouldn't be hard to solve, such as, add helper
rq_qos_prep_add() for increasing the static branch counter.

> 
> And yes we do have code path leading to rq_qos_exit() 
> which freezes queue first:
> 
> __del_gendisk()  => freezes queue 
>   -> rq_qos_exit()   
> 
> And similarly for rq_qos_delete():
> ioc_qos_write()
>  -> blkg_conf_open_bdev_frozen() => freezes queue
>  -> blk_iocost_init()
>   -> rq_qos_del() 
> 
> So even if we move static_branch_inc() out of freeze queue 
> in rq_qos_add(), it'd still cause the observed lockdep 
> splat.

rqos won't be called into for passthrough request, so rq_qos_exit()
may be moved to end of __del_gendisk(), when the freeze lock map
is released.


Thanks,
Ming

