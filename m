Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5062046A9
	for <linux-block@vger.kernel.org>; Mon,  4 Aug 2025 11:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754307345; cv=none; b=qhuM5W8PWVLKkcR7fQA5SGvA6sIxu8dbr64vb9+8WvoByz/uo8VzTrR+z2qkY79evUXyRn5l95DcnMN3QCMaFKww58xgorWo4vnOvRSo/0q172qsnm/Jpat9KvxRS7p0VUb3xQyvzDcoSt8haSF29+zYvxaOPcoeBDbhGDrh3lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754307345; c=relaxed/simple;
	bh=lnFlKVX2FeFMvsMx28QqmpLI34ZpCd2hBifiOPuPi6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MtrhSAU9UPzbFntDVEprPII+scGwnHCPyZQzpgBRe87GWRyVLNdolEoNfT1+gZBYdZC0YvGibY4XtY5vr2D7wN2xlaVef0n0svuOEuEAFD/rC7R32mpkfPSnlNEPIDAzSDrmBzG/DyfiTePbqYLMuWUe6/v+Ag90JK5t9DDxF3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eK3aXjwc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eK3aXjwc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754307343;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rHvvTihsY8BJHlBmnaZG7K2wQdWLVzsk7lG0/p+vHOs=;
	b=eK3aXjwcqwde8H0lmaiBDNAjqk6jn2WO2JieiddxxPgYr9sWc/EvXNvPnhpkUoa1hhpzZm
	uCdE6dhwysU2z++IPQ1Th1fTTVHXfCa0wIqSKzJ6ZZZusNG0HxoDCVp/P77SO3EuCoN+2C
	Uuut3IZsGQ4fjMWWATWOeKQdB9JBzEk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-175-2EJc46c8PKafKltU1cd1zw-1; Mon,
 04 Aug 2025 07:35:40 -0400
X-MC-Unique: 2EJc46c8PKafKltU1cd1zw-1
X-Mimecast-MFC-AGG-ID: 2EJc46c8PKafKltU1cd1zw_1754307339
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9D6E919560B5;
	Mon,  4 Aug 2025 11:35:38 +0000 (UTC)
Received: from fedora (unknown [10.72.116.20])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7E9A31800D8A;
	Mon,  4 Aug 2025 11:35:31 +0000 (UTC)
Date: Mon, 4 Aug 2025 19:35:24 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Hannes Reinecke <hare@suse.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Yu Kuai <yukuai3@huawei.com>, John Garry <john.garry@huawei.com>,
	Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>
Subject: Re: [PATCH 5/5] blk-mq: Replace tags->lock with SRCU for tag
 iterators
Message-ID: <aJCa_Ef6U00CZbpf@fedora>
References: <20250801114440.722286-1-ming.lei@redhat.com>
 <20250801114440.722286-6-ming.lei@redhat.com>
 <028ba177-da0c-465e-ab34-ec18039395e8@suse.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <028ba177-da0c-465e-ab34-ec18039395e8@suse.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Mon, Aug 04, 2025 at 09:13:08AM +0200, Hannes Reinecke wrote:
> On 8/1/25 13:44, Ming Lei wrote:
> > Replace the spinlock in blk_mq_find_and_get_req() with an SRCU read lock
> > around the tag iterators.
> > 
> > This is done by:
> > 
> > - Holding the SRCU read lock in blk_mq_queue_tag_busy_iter(),
> > blk_mq_tagset_busy_iter(), and blk_mq_hctx_has_requests().
> > 
> > - Removing the now-redundant tags->lock from blk_mq_find_and_get_req().
> > 
> > This change improves performance by replacing a spinlock with a more
> > scalable SRCU lock, and fixes lockup issue in scsi_host_busy() in case of
> > shost->host_blocked.
> > 
> > Meantime it becomes possible to use blk_mq_in_driver_rw() for io
> > accounting.
> > 
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >   block/blk-mq-tag.c | 12 ++++++++----
> >   block/blk-mq.c     | 24 ++++--------------------
> >   2 files changed, 12 insertions(+), 24 deletions(-)
> > 
> > diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> > index 6c2f5881e0de..7ae431077a32 100644
> > --- a/block/blk-mq-tag.c
> > +++ b/block/blk-mq-tag.c
> > @@ -256,13 +256,10 @@ static struct request *blk_mq_find_and_get_req(struct blk_mq_tags *tags,
> >   		unsigned int bitnr)
> >   {
> >   	struct request *rq;
> > -	unsigned long flags;
> > -	spin_lock_irqsave(&tags->lock, flags);
> >   	rq = tags->rqs[bitnr];
> >   	if (!rq || rq->tag != bitnr || !req_ref_inc_not_zero(rq))
> >   		rq = NULL;
> > -	spin_unlock_irqrestore(&tags->lock, flags);
> >   	return rq;
> >   }
> > @@ -440,7 +437,9 @@ void blk_mq_tagset_busy_iter(struct blk_mq_tag_set *tagset,
> >   		busy_tag_iter_fn *fn, void *priv)
> >   {
> >   	unsigned int flags = tagset->flags;
> > -	int i, nr_tags;
> > +	int i, nr_tags, srcu_idx;
> > +
> > +	srcu_idx = srcu_read_lock(&tagset->tags_srcu);
> >   	nr_tags = blk_mq_is_shared_tags(flags) ? 1 : tagset->nr_hw_queues;
> > @@ -449,6 +448,7 @@ void blk_mq_tagset_busy_iter(struct blk_mq_tag_set *tagset,
> >   			__blk_mq_all_tag_iter(tagset->tags[i], fn, priv,
> >   					      BT_TAG_ITER_STARTED);
> >   	}
> > +	srcu_read_unlock(&tagset->tags_srcu, srcu_idx);
> >   }
> >   EXPORT_SYMBOL(blk_mq_tagset_busy_iter);
> > @@ -499,6 +499,8 @@ EXPORT_SYMBOL(blk_mq_tagset_wait_completed_request);
> >   void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_tag_iter_fn *fn,
> >   		void *priv)
> >   {
> > +	int srcu_idx;
> > +
> >   	/*
> >   	 * __blk_mq_update_nr_hw_queues() updates nr_hw_queues and hctx_table
> >   	 * while the queue is frozen. So we can use q_usage_counter to avoid
> > @@ -507,6 +509,7 @@ void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_tag_iter_fn *fn,
> >   	if (!percpu_ref_tryget(&q->q_usage_counter))
> >   		return;
> > +	srcu_idx = srcu_read_lock(&q->tag_set->tags_srcu);
> >   	if (blk_mq_is_shared_tags(q->tag_set->flags)) {
> >   		struct blk_mq_tags *tags = q->tag_set->shared_tags;
> >   		struct sbitmap_queue *bresv = &tags->breserved_tags;
> > @@ -536,6 +539,7 @@ void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_tag_iter_fn *fn,
> >   			bt_for_each(hctx, q, btags, fn, priv, false);
> >   		}
> >   	}
> > +	srcu_read_unlock(&q->tag_set->tags_srcu, srcu_idx);
> >   	blk_queue_exit(q);
> >   }
> > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > index 7b4ab8e398b6..43b15e58ffe1 100644
> > --- a/block/blk-mq.c
> > +++ b/block/blk-mq.c
> > @@ -3415,7 +3415,6 @@ static void blk_mq_clear_rq_mapping(struct blk_mq_tags *drv_tags,
> >   				    struct blk_mq_tags *tags)
> >   {
> >   	struct page *page;
> > -	unsigned long flags;
> >   	/*
> >   	 * There is no need to clear mapping if driver tags is not initialized
> > @@ -3439,15 +3438,6 @@ static void blk_mq_clear_rq_mapping(struct blk_mq_tags *drv_tags,
> >   			}
> >   		}
> >   	}
> > -
> > -	/*
> > -	 * Wait until all pending iteration is done.
> > -	 *
> > -	 * Request reference is cleared and it is guaranteed to be observed
> > -	 * after the ->lock is released.
> > -	 */
> > -	spin_lock_irqsave(&drv_tags->lock, flags);
> > -	spin_unlock_irqrestore(&drv_tags->lock, flags);
> >   }
> >   void blk_mq_free_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
> > @@ -3670,8 +3660,12 @@ static bool blk_mq_hctx_has_requests(struct blk_mq_hw_ctx *hctx)
> >   	struct rq_iter_data data = {
> >   		.hctx	= hctx,
> >   	};
> > +	int srcu_idx;
> > +	srcu_idx = srcu_read_lock(&hctx->queue->tag_set->tags_srcu);
> >   	blk_mq_all_tag_iter(tags, blk_mq_has_request, &data);
> > +	srcu_read_unlock(&hctx->queue->tag_set->tags_srcu, srcu_idx);
> > +
> >   	return data.has_rq;
> >   }
> > @@ -3891,7 +3885,6 @@ static void blk_mq_clear_flush_rq_mapping(struct blk_mq_tags *tags,
> >   		unsigned int queue_depth, struct request *flush_rq)
> >   {
> >   	int i;
> > -	unsigned long flags;
> >   	/* The hw queue may not be mapped yet */
> >   	if (!tags)
> > @@ -3901,15 +3894,6 @@ static void blk_mq_clear_flush_rq_mapping(struct blk_mq_tags *tags,
> >   	for (i = 0; i < queue_depth; i++)
> >   		cmpxchg(&tags->rqs[i], flush_rq, NULL);
> > -
> > -	/*
> > -	 * Wait until all pending iteration is done.
> > -	 *
> > -	 * Request reference is cleared and it is guaranteed to be observed
> > -	 * after the ->lock is released.
> > -	 */
> > -	spin_lock_irqsave(&tags->lock, flags);
> > -	spin_unlock_irqrestore(&tags->lock, flags);
> >   }
> >   static void blk_free_flush_queue_callback(struct rcu_head *head)
> 
> While this looks good, I do wonder what happened to the 'fq' srcu.
> Don't we need to insert an srcu_read_lock() when we're trying to
> access it?

That is exactly the srcu read lock added in this patch.

Thanks,
Ming

