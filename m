Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B845B289E2E
	for <linux-block@vger.kernel.org>; Wed,  6 Aug 2025 08:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754470786; cv=none; b=IWjfneQoL/rXKKCjXrsF10hMB2XU5yorphhyvqvYuZieDkvy8dHnxuv2qws/Wkr2e9AxYM+lR3xaE0eNHx0ipd7uouKEpfiwwZjXW0byiI9TBDzDlgNsgwSETgKfU/KWprncm7gETJNVZdvRdCE13vrYG549ce07cxbO0vjNrys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754470786; c=relaxed/simple;
	bh=bu0sTp2ReIuqGDeSJeCPrX11hVztNAC1CS+gcEgVl/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hha776/rYmfnkb9e8eWe4fZtEwxeMUHyCOuwToDfE4xz9/UDgH+UgvddbKjHsJ7aY/KuexLJf9uiyO9amDb32WKIaqC7BjBU5CyQINi2z0cmrGT6yXRcNxXxcOmYqtMVGp9/zHFIhryCP2LJmkgpvoA4kCguz5ZZdZkN675Lxqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gni7Xm2Q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gni7Xm2Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754470783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qvmVIs1zCqhP2sQf/ufEmJVCr5KBPvag99m3zXHP8KQ=;
	b=Gni7Xm2QFlFM/CzAKc+Rox0SVd28fNNUk8B9ijCF6NOzd0iJZmiGR3rIYVL3smMkwZiFvh
	W9JMixwpD5O5I2LzbJBksxv1artI4FqOIFfsN8zSqJnCMvvYd28Cgt11bbOSbScn/Zek2x
	977Wia8BrymABdTDZE8oTuk0l/WcXJ0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-111-l03hTl1lOw-WU0WwCXF41A-1; Wed,
 06 Aug 2025 04:59:26 -0400
X-MC-Unique: l03hTl1lOw-WU0WwCXF41A-1
X-Mimecast-MFC-AGG-ID: l03hTl1lOw-WU0WwCXF41A_1754470765
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 61178180029D;
	Wed,  6 Aug 2025 08:59:24 +0000 (UTC)
Received: from fedora (unknown [10.72.116.154])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CC16B1800282;
	Wed,  6 Aug 2025 08:59:19 +0000 (UTC)
Date: Wed, 6 Aug 2025 16:59:14 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	John Garry <john.garry@huawei.com>,
	Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>,
	"yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH 5/5] blk-mq: Replace tags->lock with SRCU for tag
 iterators
Message-ID: <aJMZYvCwsR8f3cJZ@fedora>
References: <20250801114440.722286-1-ming.lei@redhat.com>
 <20250801114440.722286-6-ming.lei@redhat.com>
 <b86b9098-fb76-bdfe-bdf0-1344386d067a@huaweicloud.com>
 <aJCaWLgfB_oMMdrC@fedora>
 <88ad7326-b55f-7e33-fa81-0317843fc15b@huaweicloud.com>
 <700bd14f-74da-9c10-9917-d5d56ecd2921@huaweicloud.com>
 <aJHFVdqDs5KKKuM8@fedora>
 <383cb150-9a46-8377-79df-66e8eafc7eb5@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <383cb150-9a46-8377-79df-66e8eafc7eb5@huaweicloud.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Wed, Aug 06, 2025 at 09:06:28AM +0800, Yu Kuai wrote:
> Hi,
> 
> 在 2025/08/05 16:48, Ming Lei 写道:
> > On Tue, Aug 05, 2025 at 04:38:56PM +0800, Yu Kuai wrote:
> > > Hi,
> > > 
> > > 在 2025/08/05 16:33, Yu Kuai 写道:
> > > > Hi,
> > > > 
> > > > 在 2025/08/04 19:32, Ming Lei 写道:
> > > > > On Mon, Aug 04, 2025 at 02:30:43PM +0800, Yu Kuai wrote:
> > > > > > Hi,
> > > > > > 
> > > > > > 在 2025/08/01 19:44, Ming Lei 写道:
> > > > > > > Replace the spinlock in blk_mq_find_and_get_req() with an
> > > > > > > SRCU read lock
> > > > > > > around the tag iterators.
> > > > > > > 
> > > > > > > This is done by:
> > > > > > > 
> > > > > > > - Holding the SRCU read lock in blk_mq_queue_tag_busy_iter(),
> > > > > > > blk_mq_tagset_busy_iter(), and blk_mq_hctx_has_requests().
> > > > > > > 
> > > > > > > - Removing the now-redundant tags->lock from blk_mq_find_and_get_req().
> > > > > > > 
> > > > > > > This change improves performance by replacing a spinlock with a more
> > > > > > > scalable SRCU lock, and fixes lockup issue in
> > > > > > > scsi_host_busy() in case of
> > > > > > > shost->host_blocked.
> > > > > > > 
> > > > > > > Meantime it becomes possible to use blk_mq_in_driver_rw() for io
> > > > > > > accounting.
> > > > > > > 
> > > > > > > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > > > > > > ---
> > > > > > >     block/blk-mq-tag.c | 12 ++++++++----
> > > > > > >     block/blk-mq.c     | 24 ++++--------------------
> > > > > > >     2 files changed, 12 insertions(+), 24 deletions(-)
> > > > > > > 
> > > > > > > diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> > > > > > > index 6c2f5881e0de..7ae431077a32 100644
> > > > > > > --- a/block/blk-mq-tag.c
> > > > > > > +++ b/block/blk-mq-tag.c
> > > > > > > @@ -256,13 +256,10 @@ static struct request
> > > > > > > *blk_mq_find_and_get_req(struct blk_mq_tags *tags,
> > > > > > >             unsigned int bitnr)
> > > > > > >     {
> > > > > > >         struct request *rq;
> > > > > > > -    unsigned long flags;
> > > > > > > -    spin_lock_irqsave(&tags->lock, flags);
> > > > > > >         rq = tags->rqs[bitnr];
> > > > > > >         if (!rq || rq->tag != bitnr || !req_ref_inc_not_zero(rq))
> > > > > > >             rq = NULL;
> > > > > > > -    spin_unlock_irqrestore(&tags->lock, flags);
> > > > > > >         return rq;
> > > > > > >     }
> > > > > > > 
> > > > > > Just wonder, does the lockup problem due to the tags->lock contention by
> > > > > > concurrent scsi_host_busy?
> > > > > 
> > > > > Yes.
> > > > > 
> > > > > > 
> > > > > > > @@ -440,7 +437,9 @@ void blk_mq_tagset_busy_iter(struct
> > > > > > > blk_mq_tag_set *tagset,
> > > > > > >             busy_tag_iter_fn *fn, void *priv)
> > > > > > >     {
> > > > > > >         unsigned int flags = tagset->flags;
> > > > > > > -    int i, nr_tags;
> > > > > > > +    int i, nr_tags, srcu_idx;
> > > > > > > +
> > > > > > > +    srcu_idx = srcu_read_lock(&tagset->tags_srcu);
> > > > > > >         nr_tags = blk_mq_is_shared_tags(flags) ? 1 :
> > > > > > > tagset->nr_hw_queues;
> > > > > > > @@ -449,6 +448,7 @@ void blk_mq_tagset_busy_iter(struct
> > > > > > > blk_mq_tag_set *tagset,
> > > > > > >                 __blk_mq_all_tag_iter(tagset->tags[i], fn, priv,
> > > > > > >                               BT_TAG_ITER_STARTED);
> > > > > > >         }
> > > > > > > +    srcu_read_unlock(&tagset->tags_srcu, srcu_idx);
> > > > > > 
> > > > > > And should we add cond_resched() after finish interating one tags, even
> > > > > > with the srcu change, looks like it's still possible to lockup with
> > > > > > big cpu cores & deep queue depth.
> > > > > 
> > > > > The main trouble is from the big tags->lock.
> > > > > 
> > > > > IMO it isn't needed, because max queue depth is just 10K, which is much
> > > > > bigger than actual queue depth. We can add it when someone shows it is
> > > > > really needed.
> > > > 
> > > > If we don't want this, why not using srcu here? Looks like just use
> > > > rcu_read_lock and rcu_read_unlock to protect blk_mq_find_and_get_req()
> > > > will be enough.
> > > 
> > > Like following patch:
> > > 
> > > diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> > > index d880c50629d6..e2381ee9747d 100644
> > > --- a/block/blk-mq-tag.c
> > > +++ b/block/blk-mq-tag.c
> > > @@ -255,11 +255,11 @@ static struct request *blk_mq_find_and_get_req(struct
> > > blk_mq_tags *tags,
> > >          struct request *rq;
> > >          unsigned long flags;
> > > 
> > > -       spin_lock_irqsave(&tags->lock, flags);
> > > +       rcu_read_lock();
> > >          rq = tags->rqs[bitnr];
> > >          if (!rq || rq->tag != bitnr || !req_ref_inc_not_zero(rq))
> > >                  rq = NULL;
> > > -       spin_unlock_irqrestore(&tags->lock, flags);
> > > +       rcu_read_unlock();
> > >          return rq;
> > >   }
> > 
> > srcu read lock has to be grabbed when request reference is being accessed,
> > so the above change is wrong, otherwise plain rcu is enough.
> > 
> I don't quite understand, I think it's enough to protect grabbing req
> reference, because IO issue path grab q_usage_counter before setting
> req reference to 1, and IO complete path decrease req reference to 0
> before dropping q_usage_counter.

In theory it is true, but the implementation is pretty fragile, because the
correctness replies on the implied memory barrier(un-documented) in blk_mq_get_tag()
between blk_try_enter_queue() and req_ref_set(rq, 1).

> 
> > > 
> > > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > > index b1d81839679f..a70959cad692 100644
> > > --- a/block/blk-mq.c
> > > +++ b/block/blk-mq.c
> > > @@ -3442,12 +3442,8 @@ static void blk_mq_clear_rq_mapping(struct
> > > blk_mq_tags *drv_tags,
> > > 
> > >          /*
> > >           * Wait until all pending iteration is done.
> > > -        *
> > > -        * Request reference is cleared and it is guaranteed to be observed
> > > -        * after the ->lock is released.
> > >           */
> > > -       spin_lock_irqsave(&drv_tags->lock, flags);
> > > -       spin_unlock_irqrestore(&drv_tags->lock, flags);
> > > +       synchronize_rcu();
> > 
> > We do want to avoid big delay in this code path, so call_srcu() is much
> > better.
> 
> Agreed, however, there is rcu verion helper as well, call_rcu().

I prefer to srcu, which is simple & straight-forward, especially the background
of this issue has been tough enough.


Thanks,
Ming

