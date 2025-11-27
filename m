Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5E81391
	for <linux-block@vger.kernel.org>; Thu, 27 Nov 2025 03:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764214748; cv=none; b=cOmA69LWF/tMQeKqyZwVUvJA1gEljOPaU8UjGy9mE6jST3Od1D5ztQtNEuqzGTdgTOyuVZ8xu2Mr0HsjnwH/xrXRxzQZONem5KvlJNOjMa//qbKQVAluFpyebKWNDdUSb7hI/DHfJg+a7VdjnGZUPh/oLe3TM/AfBA91suWcARI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764214748; c=relaxed/simple;
	bh=eHQt834EcXueCpRGobT6T7I3NvmnSRof71KEUCnCOCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qguco/itcdvd/XGj+gYDSXf0/zE9+x0hQGy4B7+UN1FsCQdJS1BcFGc2VlVHS02xv2610USbjj8zmOIrFG8VtauRws3ljqPDb75wGS8SnM4gADD0a6g35+oxKJIo8ywL5MpNIlHYF9bzI4W8BAJ2j6fn9CXfF51X9dBK9Ghz9Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U4WQ//7R; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U4WQ//7R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764214745;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/9L1qO8MD90JrD9vkJjos8NuzgRrFLCkNjjnz8Oz3Uo=;
	b=U4WQ//7RO9xfJ/9QHDUjbdLPvXkLrKgTi15PEO/t658nlSAZvG2MEoDd1AbeRDUtZ4i6PW
	URiiLPJo6EvEj3G0C34QO0gPE4gyXNWLhvMIfeNakRur3uvoxVhsBs8Vm8FgUV9cHmD6h0
	ZR0LcWQmCF+3KI285E1LyhMQu5T1/kk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-513-VZyeE1ylMM2i4Uv8DljK1A-1; Wed,
 26 Nov 2025 22:38:59 -0500
X-MC-Unique: VZyeE1ylMM2i4Uv8DljK1A-1
X-Mimecast-MFC-AGG-ID: VZyeE1ylMM2i4Uv8DljK1A_1764214738
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 55B901956096;
	Thu, 27 Nov 2025 03:38:58 +0000 (UTC)
Received: from fedora (unknown [10.72.116.210])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1206F30044DB;
	Thu, 27 Nov 2025 03:38:52 +0000 (UTC)
Date: Thu, 27 Nov 2025 11:38:47 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Fengnan Chang <fengnanchang@gmail.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, hare@suse.de, hch@lst.de,
	yukuai3@huawei.com, Fengnan Chang <changfengnan@bytedance.com>
Subject: Re: [PATCH v2 2/2] blk-mq: fix potential uaf for 'queue_hw_ctx'
Message-ID: <aSfHx9AS4jEFkqTW@fedora>
References: <20251127013908.66118-1-fengnanchang@gmail.com>
 <20251127013908.66118-3-fengnanchang@gmail.com>
 <aSfGggOS8o_nOQPI@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aSfGggOS8o_nOQPI@fedora>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Thu, Nov 27, 2025 at 11:33:22AM +0800, Ming Lei wrote:
> On Thu, Nov 27, 2025 at 09:39:08AM +0800, Fengnan Chang wrote:
> > From: Fengnan Chang <changfengnan@bytedance.com>
> > 
> > This is just apply Kuai's patch in [1] with mirror changes.
> > 
> > blk_mq_realloc_hw_ctxs() will free the 'queue_hw_ctx'(e.g. undate
> > submit_queues through configfs for null_blk), while it might still be
> > used from other context(e.g. switch elevator to none):
> > 
> > t1					t2
> > elevator_switch
> >  blk_mq_unquiesce_queue
> >   blk_mq_run_hw_queues
> >    queue_for_each_hw_ctx
> >     // assembly code for hctx = (q)->queue_hw_ctx[i]
> >     mov    0x48(%rbp),%rdx -> read old queue_hw_ctx
> > 
> > 					__blk_mq_update_nr_hw_queues
> > 					 blk_mq_realloc_hw_ctxs
> > 					  hctxs = q->queue_hw_ctx
> > 					  q->queue_hw_ctx = new_hctxs
> > 					  kfree(hctxs)
> >     movslq %ebx,%rax
> >     mov    (%rdx,%rax,8),%rdi ->uaf
> > 
> > This problem was found by code review, and I comfirmed that the concurrent
> > scenario do exist(specifically 'q->queue_hw_ctx' can be changed during
> > blk_mq_run_hw_queues()), however, the uaf problem hasn't been repoduced yet
> > without hacking the kernel.
> > 
> > Sicne the queue is freezed in __blk_mq_update_nr_hw_queues(), fix the
> > problem by protecting 'queue_hw_ctx' through rcu where it can be accessed
> > without grabbing 'q_usage_counter'.
> > 
> > [1] https://lore.kernel.org/all/20220225072053.2472431-1-yukuai3@huawei.com/
> > 
> > Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> > Signed-off-by: Fengnan Chang <changfengnan@bytedance.com>
> > ---
> >  block/blk-mq.c         |  7 ++++++-
> >  block/blk-mq.h         | 11 +++++++++++
> >  include/linux/blk-mq.h |  2 +-
> >  include/linux/blkdev.h |  2 +-
> >  4 files changed, 19 insertions(+), 3 deletions(-)
> > 
> > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > index eed12fab3484..0b8b72194003 100644
> > --- a/block/blk-mq.c
> > +++ b/block/blk-mq.c
> > @@ -4524,7 +4524,12 @@ static void __blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
> >  		if (hctxs)
> >  			memcpy(new_hctxs, hctxs, q->nr_hw_queues *
> >  			       sizeof(*hctxs));
> > -		q->queue_hw_ctx = new_hctxs;
> > +		rcu_assign_pointer(q->queue_hw_ctx, new_hctxs);
> > +		/*
> > +		 * Make sure reading the old queue_hw_ctx from other
> > +		 * context concurrently won't trigger uaf.
> > +		 */
> > +		synchronize_rcu_expedited();
> >  		kfree(hctxs);
> >  		hctxs = new_hctxs;
> >  	}
> > diff --git a/block/blk-mq.h b/block/blk-mq.h
> > index 80a3f0c2bce7..52852fab78f0 100644
> > --- a/block/blk-mq.h
> > +++ b/block/blk-mq.h
> > @@ -87,6 +87,17 @@ static inline struct blk_mq_hw_ctx *blk_mq_map_queue_type(struct request_queue *
> >  	return q->queue_hw_ctx[q->tag_set->map[type].mq_map[cpu]];
> >  }
> >  
> > +static inline struct blk_mq_hw_ctx *queue_hctx(struct request_queue *q, int id)
> > +{
> > +	struct blk_mq_hw_ctx *hctx;
> > +
> > +	rcu_read_lock();
> > +	hctx = rcu_dereference(q->queue_hw_ctx)[id];
> > +	rcu_read_unlock();
> > +
> > +	return hctx;
> > +}
> 
> 
> If `hctx` is retrieved from old table, uaf will be triggered on
> `hctx` dereference after returning from queue_hctx().
> 
> So rcu read lock should be held anywhere for `hctx` deference.

oops, the rcu read lock only protects `q->queue_hw_ctx`, so this
way is fine, sorry for the noise!


Thanks. 
Ming

