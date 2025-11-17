Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C037330F546
	for <linux-block@vger.kernel.org>; Mon, 17 Nov 2025 11:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763379049; cv=none; b=LWtxhtcV4/0RmU4zjrPV6ZD8EgiIkc3Jp6KjBQTkUtncQkVAjASVSN4m0UO1155uZqzZBbFghqaY6jR1JIvACGScN/ew7rqv8JCDwV/MLkFy2aCPA4c7eCJkYgprAupnWEuD3TOZp7clJ32+xwu2RBPDBssO/Gt7SDrP13GknjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763379049; c=relaxed/simple;
	bh=/IgVtmR2tJIW7L+cGTHPm+sSVujjl9oIQdT1Adufc9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IiMoGZyx6nXw9SCfVcPtFAFHMLXtOphCQgmSGCKIKHABvCjIDNjEWw9iytSrgwYIUhKbSzZAFAZU5mpqxLMG+dXuePcisf6jevwAli9g+vSNFotuPOvmmMVEzff6iAq63IrXjf+7FAFz3Ygs7Qmm+PmcX13yXBtQAoqIRZNSNuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P+fFkQXw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P+fFkQXw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763379045;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=71fL8xS1JDva3A3Oc54/YAYalpolC3bgLC5Vj435Bhk=;
	b=P+fFkQXw+mcv8fG7MeyTH9ADJ6FtGAbT6WfO0F7lr4TjwR2LhljrZPnbmUKHCV2IQBbEyo
	34hkAAiNzw4Uerf2t1qbJTrNlUEIt9Vuz17PaTkhbFa9Eik12wonOVQ91NJivFQnkpGcQt
	Hup4Q2QU8azslr6aWTILSL5YXkoYEbE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-53-wUVbJy9fPu-cpl51lwXs5Q-1; Mon,
 17 Nov 2025 06:30:42 -0500
X-MC-Unique: wUVbJy9fPu-cpl51lwXs5Q-1
X-Mimecast-MFC-AGG-ID: wUVbJy9fPu-cpl51lwXs5Q_1763379041
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A249618D95C7;
	Mon, 17 Nov 2025 11:30:40 +0000 (UTC)
Received: from fedora (unknown [10.72.116.42])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7FCC33003754;
	Mon, 17 Nov 2025 11:30:36 +0000 (UTC)
Date: Mon, 17 Nov 2025 19:30:31 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Yu Kuai <yukuai@fnnas.com>, axboe@kernel.dk,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	tj@kernel.org
Subject: Re: [PATCH RESEND 1/5] block/blk-rq-qos: add a new helper
 rq_qos_add_freezed()
Message-ID: <aRsHVyvL8sMrmDlt@fedora>
References: <20251116041024.120500-1-yukuai@fnnas.com>
 <20251116041024.120500-2-yukuai@fnnas.com>
 <aRsAdF3GxNJ3Q1Qv@fedora>
 <1bd4a77f-399f-4dbe-a6b6-79b07f5e2759@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1bd4a77f-399f-4dbe-a6b6-79b07f5e2759@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Mon, Nov 17, 2025 at 04:43:11PM +0530, Nilay Shroff wrote:
> 
> 
> On 11/17/25 4:31 PM, Ming Lei wrote:
> > On Sun, Nov 16, 2025 at 12:10:20PM +0800, Yu Kuai wrote:
> >> queue should not be freezed under rq_qos_mutex, see example index
> >> commit 9730763f4756 ("block: correct locking order for protecting blk-wbt
> >> parameters"), which means current implementation of rq_qos_add() is
> >> problematic. Add a new helper and prepare to fix this problem in
> >> following patches.
> >>
> >> Signed-off-by: Yu Kuai <yukuai@fnnas.com>
> >> ---
> >>  block/blk-rq-qos.c | 27 +++++++++++++++++++++++++++
> >>  block/blk-rq-qos.h |  2 ++
> >>  2 files changed, 29 insertions(+)
> >>
> >> diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
> >> index 654478dfbc20..353397d7e126 100644
> >> --- a/block/blk-rq-qos.c
> >> +++ b/block/blk-rq-qos.c
> >> @@ -322,6 +322,33 @@ void rq_qos_exit(struct request_queue *q)
> >>  	mutex_unlock(&q->rq_qos_mutex);
> >>  }
> >>  
> >> +int rq_qos_add_freezed(struct rq_qos *rqos, struct gendisk *disk,
> >> +		       enum rq_qos_id id, const struct rq_qos_ops *ops)
> >> +{
> >> +	struct request_queue *q = disk->queue;
> >> +
> >> +	WARN_ON_ONCE(q->mq_freeze_depth == 0);
> >> +	lockdep_assert_held(&q->rq_qos_mutex);
> >> +
> >> +	if (rq_qos_id(q, id))
> >> +		return -EBUSY;
> >> +
> >> +	rqos->disk = disk;
> >> +	rqos->id = id;
> >> +	rqos->ops = ops;
> >> +	rqos->next = q->rq_qos;
> >> +	q->rq_qos = rqos;
> >> +	blk_queue_flag_set(QUEUE_FLAG_QOS_ENABLED, q);
> >> +
> >> +	if (rqos->ops->debugfs_attrs) {
> >> +		mutex_lock(&q->debugfs_mutex);
> >> +		blk_mq_debugfs_register_rqos(rqos);
> >> +		mutex_unlock(&q->debugfs_mutex);
> >> +	}
> > 
> > It will cause more lockdep splat to let q->debugfs_mutex depend on queue freeze,
> > 
> I think we already have that ->debugfs_mutex dependency on ->freeze_lock. 
> for instance, 
>   ioc_qos_write  => freeze-queue
>    blk_iocost_init
>      rq_qos_add 

Why is queue freeze needed in above code path?

Also blk_iolatency_init()/rq_qos_add() doesn't freeze queue.

> 
> and also, 
>   queue_wb_lat_store  => freeze-queue
>     wbt_init
>       rq_qos_add

Not all wbt_enable_default()/wbt_init() is called with queue frozen, but Kuai's
patchset changes all to freeze queue before registering debugfs entry, people will
complain new warning.

> 
> > Also blk_mq_debugfs_register_rqos() does _not_ require queue to be frozen,
> > and it should be fine to move blk_mq_debugfs_register_rqos() out of queue
> > freeze.
> > 
> Yes correct, but I thought this pacthset is meant only to address incorrect 
> locking order between ->rq_qos_mutex and ->freeze_lock. So do you suggest
> also refactoring code to avoid ->debugfs_mutex dependency on ->freeze_lock?
> If yes then shouldn't that be handled in a separate patchset?

It is fine to fix in that way, but at least regression shouldn't be caused.

More importantly we shouldn't add new unnecessary dependency on queue freeze.

Thanks,
Ming

