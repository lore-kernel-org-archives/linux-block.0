Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E9E381C4
	for <linux-block@vger.kernel.org>; Wed, 11 Sep 2024 03:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726026916; cv=none; b=eI6gi35faB+Iax6z7F3RizF0kBmhT2tcyZm+rG2rwO7WZ6t2H6ATj9yRio0H8Y1QfFyvmCvS0Q2BpFiksRMHClCCrIG0uk5tBHFxpzkknFj9RYbThCML9uljtpgf0V4+lVNX+etKak+whqJXw5HgtwNKKl5pPsHBdA8xGLlcKg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726026916; c=relaxed/simple;
	bh=7hMw8q41kNngI7AZddTmC/6t4LsDhd8WjIkN4t9t288=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H6DzjsxtmbyPKA57WPoLhdr6ZDOQgrNSFIId2oU+yF7Z+Cpa0wudfsBuF/hbYKcMv5a2axpcT57wwMmecU+TSMB7rKzJBt+35uBNrScvzRmIRExhEtRYqt9ZAKYpsVYiQVz/1wkgvUN3kW65mdbloj5k8To4hbQt+EGiwdHCs9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z1aMS5yV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z1aMS5yV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726026913;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=It6abFxBNWhDBQLymN29uykKczwvr33yf0+dc6bMMgs=;
	b=Z1aMS5yVHv+rX6YRuvuQgY1E0oTUuwIEwWJLehiFNXKs08KddnjsI6G6mVftAC2U3XJi3B
	/WRWHlitBTUcaWW31j0AqYnumK/9qBsyPGCpBq5mmPXukPSCvwICt+PSERrhYdIt3JOgjx
	vjWG0UpfVCeiaGO7/hr7LjbRdcrdL0k=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-100-5O2AMrhUNXCXg5c7RLd3WA-1; Tue,
 10 Sep 2024 23:55:10 -0400
X-MC-Unique: 5O2AMrhUNXCXg5c7RLd3WA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4096D197702F;
	Wed, 11 Sep 2024 03:55:01 +0000 (UTC)
Received: from fedora (unknown [10.72.116.76])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F333F195394F;
	Wed, 11 Sep 2024 03:54:54 +0000 (UTC)
Date: Wed, 11 Sep 2024 11:54:49 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Muchun Song <songmuchun@bytedance.com>, yukuai1@huaweicloud.com,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	muchun.song@linux.dev, stable@vger.kernel.org, ming.lei@redhat.com
Subject: Re: [PATCH v2 2/3] block: fix ordering between checking
 QUEUE_FLAG_QUIESCED and adding requests
Message-ID: <ZuEUiScRwuXgIrC0@fedora>
References: <20240903081653.65613-1-songmuchun@bytedance.com>
 <20240903081653.65613-3-songmuchun@bytedance.com>
 <91ce06c7-6965-4d1d-8ed4-d0a6f01acecf@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91ce06c7-6965-4d1d-8ed4-d0a6f01acecf@kernel.dk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Tue, Sep 10, 2024 at 07:22:16AM -0600, Jens Axboe wrote:
> On 9/3/24 2:16 AM, Muchun Song wrote:
> > Supposing the following scenario.
> > 
> > CPU0                                        CPU1
> > 
> > blk_mq_insert_request()         1) store    blk_mq_unquiesce_queue()
> > blk_mq_run_hw_queue()                       blk_queue_flag_clear(QUEUE_FLAG_QUIESCED)       3) store
> >     if (blk_queue_quiesced())   2) load         blk_mq_run_hw_queues()
> >         return                                      blk_mq_run_hw_queue()
> >     blk_mq_sched_dispatch_requests()                    if (!blk_mq_hctx_has_pending())     4) load
> >                                                            return
> > 
> > The full memory barrier should be inserted between 1) and 2), as well as
> > between 3) and 4) to make sure that either CPU0 sees QUEUE_FLAG_QUIESCED is
> > cleared or CPU1 sees dispatch list or setting of bitmap of software queue.
> > Otherwise, either CPU will not re-run the hardware queue causing starvation.
> > 
> > So the first solution is to 1) add a pair of memory barrier to fix the
> > problem, another solution is to 2) use hctx->queue->queue_lock to synchronize
> > QUEUE_FLAG_QUIESCED. Here, we chose 2) to fix it since memory barrier is not
> > easy to be maintained.
> 
> Same comment here, 72-74 chars wide please.
> 
> > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > index b2d0f22de0c7f..ac39f2a346a52 100644
> > --- a/block/blk-mq.c
> > +++ b/block/blk-mq.c
> > @@ -2202,6 +2202,24 @@ void blk_mq_delay_run_hw_queue(struct blk_mq_hw_ctx *hctx, unsigned long msecs)
> >  }
> >  EXPORT_SYMBOL(blk_mq_delay_run_hw_queue);
> >  
> > +static inline bool blk_mq_hw_queue_need_run(struct blk_mq_hw_ctx *hctx)
> > +{
> > +	bool need_run;
> > +
> > +	/*
> > +	 * When queue is quiesced, we may be switching io scheduler, or
> > +	 * updating nr_hw_queues, or other things, and we can't run queue
> > +	 * any more, even blk_mq_hctx_has_pending() can't be called safely.
> > +	 *
> > +	 * And queue will be rerun in blk_mq_unquiesce_queue() if it is
> > +	 * quiesced.
> > +	 */
> > +	__blk_mq_run_dispatch_ops(hctx->queue, false,
> > +				  need_run = !blk_queue_quiesced(hctx->queue) &&
> > +					      blk_mq_hctx_has_pending(hctx));
> > +	return need_run;
> > +}
> 
> This __blk_mq_run_dispatch_ops() is also way too wide, why didn't you
> just break it like where you copied it from?
> 
> > +
> >  /**
> >   * blk_mq_run_hw_queue - Start to run a hardware queue.
> >   * @hctx: Pointer to the hardware queue to run.
> > @@ -2222,20 +2240,23 @@ void blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async)
> >  
> >  	might_sleep_if(!async && hctx->flags & BLK_MQ_F_BLOCKING);
> >  
> > -	/*
> > -	 * When queue is quiesced, we may be switching io scheduler, or
> > -	 * updating nr_hw_queues, or other things, and we can't run queue
> > -	 * any more, even __blk_mq_hctx_has_pending() can't be called safely.
> > -	 *
> > -	 * And queue will be rerun in blk_mq_unquiesce_queue() if it is
> > -	 * quiesced.
> > -	 */
> > -	__blk_mq_run_dispatch_ops(hctx->queue, false,
> > -		need_run = !blk_queue_quiesced(hctx->queue) &&
> > -		blk_mq_hctx_has_pending(hctx));
> > +	need_run = blk_mq_hw_queue_need_run(hctx);
> > +	if (!need_run) {
> > +		unsigned long flags;
> >  
> > -	if (!need_run)
> > -		return;
> > +		/*
> > +		 * synchronize with blk_mq_unquiesce_queue(), becuase we check
> > +		 * if hw queue is quiesced locklessly above, we need the use
> > +		 * ->queue_lock to make sure we see the up-to-date status to
> > +		 * not miss rerunning the hw queue.
> > +		 */
> > +		spin_lock_irqsave(&hctx->queue->queue_lock, flags);
> > +		need_run = blk_mq_hw_queue_need_run(hctx);
> > +		spin_unlock_irqrestore(&hctx->queue->queue_lock, flags);
> > +
> > +		if (!need_run)
> > +			return;
> > +	}
> 
> Is this not solvable on the unquiesce side instead? It's rather a shame
> to add overhead to the fast path to avoid a race with something that's
> super unlikely, like quisce.

Yeah, it can be solved by adding synchronize_rcu()/srcu() in unquiesce
side, but SCSI may call it in non-sleepable context via scsi_internal_device_unblock_nowait().


Thanks,
Ming

