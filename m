Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7490AA55
	for <linux-block@vger.kernel.org>; Mon,  4 Aug 2025 11:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754307183; cv=none; b=dDejvl1ZvRDVbjrJ8OiklxyDK1EzmOAa5yOOp/9w6hObxjUNbRJCubLPWuUfikUo4aba371OfrnFrFCu9gpN6HMsuaztBzwWfdCt3GbHUiNDqmg0HlyRmaxxP9TvSsbTBPSJbwxaVRK9wLG8ALWq5dZYEOZAqCRf/AQGf5ct4/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754307183; c=relaxed/simple;
	bh=euJd/GWtRiBMrqBrMf6n+Sx3MTOqJWAoTNp9LCUSpPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J3vtOGM6Ctv/e6ayNPkNVvaEVN3h+CyHCNBHHV2BZD9FxHs/rpLEXttlo06gHkadbYobuCeFUCL658wX5pt9DaJ7EZ6C5cZ2/r5wIYa6jBff8kGA5PQqvTb4pS91z1iG1BR++IFUaz/2a+mB71bZMmINMBeEeXwdtel4NhsH7I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fnQ4uFIy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fnQ4uFIy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754307180;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=12OsWd6Bc3Bt5ZwtVBuWjN/T8rKFlvKzhgID9opdDgI=;
	b=fnQ4uFIybA1SUgzXzMSFg6jCD/AcH0rYOP1E7GYmeGpoWf/bkjpybF9F2KkMFdTObQbZFl
	AbUDekS3PYzVsmI096stMJxvLgre8S97qlW0xVqCUVl3YM4Hv8ibMsXHBYgxUtKY2Os8RO
	sMxx1tJdXOJxN68K5Gqk7+7GC/cnWtI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-159-q_PKRN4bOTaI28VlFpPEYw-1; Mon,
 04 Aug 2025 07:32:58 -0400
X-MC-Unique: q_PKRN4bOTaI28VlFpPEYw-1
X-Mimecast-MFC-AGG-ID: q_PKRN4bOTaI28VlFpPEYw_1754307177
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E36EC1800366;
	Mon,  4 Aug 2025 11:32:56 +0000 (UTC)
Received: from fedora (unknown [10.72.116.20])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 27A3218003FC;
	Mon,  4 Aug 2025 11:32:50 +0000 (UTC)
Date: Mon, 4 Aug 2025 19:32:40 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	John Garry <john.garry@huawei.com>,
	Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>,
	"yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH 5/5] blk-mq: Replace tags->lock with SRCU for tag
 iterators
Message-ID: <aJCaWLgfB_oMMdrC@fedora>
References: <20250801114440.722286-1-ming.lei@redhat.com>
 <20250801114440.722286-6-ming.lei@redhat.com>
 <b86b9098-fb76-bdfe-bdf0-1344386d067a@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b86b9098-fb76-bdfe-bdf0-1344386d067a@huaweicloud.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Mon, Aug 04, 2025 at 02:30:43PM +0800, Yu Kuai wrote:
> Hi,
> 
> 在 2025/08/01 19:44, Ming Lei 写道:
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
> > 
> Just wonder, does the lockup problem due to the tags->lock contention by
> concurrent scsi_host_busy?

Yes.

> 
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
> 
> And should we add cond_resched() after finish interating one tags, even
> with the srcu change, looks like it's still possible to lockup with
> big cpu cores & deep queue depth.

The main trouble is from the big tags->lock.

IMO it isn't needed, because max queue depth is just 10K, which is much
bigger than actual queue depth. We can add it when someone shows it is
really needed.



Thanks,
Ming

