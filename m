Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0EF01DAC50
	for <linux-block@vger.kernel.org>; Wed,  4 Sep 2024 13:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725455091; cv=none; b=FjmhpW251c7WK46z9NNpD/AzTOl3CP4T7LFRhyjKrRJIkcFludrcTFJmkd5rAwNe9wnICsSMcVHhOEBzS2m2Y0+csgKld0PX3T5cXdYt9lmnnTnE5Etki7tn4g4ja4aoU6SXpZInTqOjxybPUuzW3VRZtYDST/JPMkBmQSku/r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725455091; c=relaxed/simple;
	bh=7ak4XrEdnlRi2v/8yamUtfMc99iT2J630o3+jOFReH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jMW7i7Y5hov8u93nrNJgCXwabWep8l47rChyL49wBfxfmBGUKTurR3COGDHlIO6hfqoSyNlb+HLYCbNyjsj7ULNvsjjlFi+wtY5Ni5vBFs0DvnqryiZyU+q2sUk/viuOZ0Po4w4tBIDAgDBycW0d+TjdXETI2PS/g/KgboKu08E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dC5IJhq4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dC5IJhq4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725455088;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zSmRkKcwStoVZz4ycbGuELyN9bbatZOLmay6g4DKLKw=;
	b=dC5IJhq4cjJCHK6PB7kAQevW2LmSrrBifgXZQwQMABdRiO6qFgYcTq9BEURxFiPmZd5Dgj
	8cclZkOjT+XZ152VoxMVqZcKoRglVNnUzk6uvGCtqiEzAlXkevRAhx5+XYwCfCtKXrRZH/
	I9oOfEhqCDymxMkIw6Ew9q6K3KZ97es=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-158-8quKOHEAMIa7bzdo6jPLpQ-1; Wed,
 04 Sep 2024 09:04:43 -0400
X-MC-Unique: 8quKOHEAMIa7bzdo6jPLpQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D4ACF19560AE;
	Wed,  4 Sep 2024 13:04:41 +0000 (UTC)
Received: from fedora (unknown [10.72.116.59])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 95DF3195605A;
	Wed,  4 Sep 2024 13:04:36 +0000 (UTC)
Date: Wed, 4 Sep 2024 21:04:30 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Muchun Song <songmuchun@bytedance.com>
Cc: axboe@kernel.dk, yukuai1@huaweicloud.com, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, muchun.song@linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 3/3] block: fix ordering between checking
 BLK_MQ_S_STOPPED and adding requests
Message-ID: <Ztha3hb962mok1wf@fedora>
References: <20240903081653.65613-1-songmuchun@bytedance.com>
 <20240903081653.65613-4-songmuchun@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903081653.65613-4-songmuchun@bytedance.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Tue, Sep 03, 2024 at 04:16:53PM +0800, Muchun Song wrote:
> Supposing first scenario with a virtio_blk driver.
> 
> CPU0                                                                CPU1
> 
> blk_mq_try_issue_directly()
>     __blk_mq_issue_directly()
>         q->mq_ops->queue_rq()
>             virtio_queue_rq()
>                 blk_mq_stop_hw_queue()
>                                                                     virtblk_done()
>     blk_mq_request_bypass_insert()                                      blk_mq_start_stopped_hw_queues()
>         /* Add IO request to dispatch list */   1) store                    blk_mq_start_stopped_hw_queue()
>                                                                                 clear_bit(BLK_MQ_S_STOPPED)                 3) store
>     blk_mq_run_hw_queue()                                                       blk_mq_run_hw_queue()
>         if (!blk_mq_hctx_has_pending())                                             if (!blk_mq_hctx_has_pending())         4) load
>             return                                                                      return
>         blk_mq_sched_dispatch_requests()                                            blk_mq_sched_dispatch_requests()
>             if (blk_mq_hctx_stopped())          2) load                                 if (blk_mq_hctx_stopped())
>                 return                                                                      return
>             __blk_mq_sched_dispatch_requests()                                          __blk_mq_sched_dispatch_requests()
> 
> Supposing another scenario.
> 
> CPU0                                                                CPU1
> 
> blk_mq_requeue_work()
>     /* Add IO request to dispatch list */       1) store            virtblk_done()
>     blk_mq_run_hw_queues()/blk_mq_delay_run_hw_queues()                 blk_mq_start_stopped_hw_queues()
>         if (blk_mq_hctx_stopped())              2) load                     blk_mq_start_stopped_hw_queue()
>             continue                                                            clear_bit(BLK_MQ_S_STOPPED)                 3) store
>         blk_mq_run_hw_queue()/blk_mq_delay_run_hw_queue()                       blk_mq_run_hw_queue()
>                                                                                     if (!blk_mq_hctx_has_pending())         4) load
>                                                                                         return
>                                                                                     blk_mq_sched_dispatch_requests()
> 
> Both scenarios are similar, the full memory barrier should be inserted between
> 1) and 2), as well as between 3) and 4) to make sure that either CPU0 sees
> BLK_MQ_S_STOPPED is cleared or CPU1 sees dispatch list. Otherwise, either CPU
> will not rerun the hardware queue causing starvation of the request.
> 
> The easy way to fix it is to add the essential full memory barrier into helper
> of blk_mq_hctx_stopped(). In order to not affect the fast path (hardware queue
> is not stopped most of the time), we only insert the barrier into the slow path.
> Actually, only slow path needs to care about missing of dispatching the request
> to the low-level device driver.
> 
> Fixes: 320ae51feed5c ("blk-mq: new multi-queue block IO queueing mechanism")
> Cc: stable@vger.kernel.org
> Cc: Muchun Song <muchun.song@linux.dev>
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Looks fine,

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming

