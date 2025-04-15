Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4163327B4EF
	for <linux-block@vger.kernel.org>; Tue, 15 Apr 2025 10:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744711635; cv=none; b=pYPq7WAFxB+zo6giEjYTg/7OkQdRqOA4l6KhtlittMygRRhh6qmGebOfH+bBmF8JXBQDBwj3EXnScr+U3YdKGlfhMT2ltHW5WS/hts+HA8WFT1/MNnWpqgkv7p9wJe4aiGYOyvDh7Gui22BaXXGsybCN911P6QReTIvO1mzeR5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744711635; c=relaxed/simple;
	bh=xtVrwFh5e41vTbYXDsUVTvtC+AGL5L9u1d6CZeCO0yA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J4w3nvO27/y8ilDgEjmBKWKFqXNsCCLxtrybtdfmO3iGgeo75W2xjrIjj301r1+na7wqYolDJbWn1wky+4kHBb0F3hL9rglxbwIxm6+/TX7N20T9r88FUvFg38TUcJW+pjNG29nbstxSbKKXXLzU6P2WQBnt4W33P/m8lwbi4fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VkA1JMbq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VkA1JMbq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744711632;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3iqVuxZodv/9DdNyAXc6CM9l0J63zHrWcD6alJGhj0c=;
	b=VkA1JMbqoKDsClPdQiTDmpymxS3n3EXjBeqj6fWMKIgpiUuXqlOx1yxsoyhwcId4/g5QmV
	sTYoJ5eiF2dqScE+bGeGewscvMY4KIuM/q7JL1xM03iZtn3RSOyA8nWbVvMe9VWr3h/qVy
	Wokb/A3FoRY+H3T3bd/C4JsfrLIZE8M=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-81-YgMcZQjOO56CTMAQmS-_MQ-1; Tue,
 15 Apr 2025 06:07:08 -0400
X-MC-Unique: YgMcZQjOO56CTMAQmS-_MQ-1
X-Mimecast-MFC-AGG-ID: YgMcZQjOO56CTMAQmS-_MQ_1744711627
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AD9871955BC9;
	Tue, 15 Apr 2025 10:07:06 +0000 (UTC)
Received: from fedora (unknown [10.72.116.70])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B64331808867;
	Tue, 15 Apr 2025 10:07:02 +0000 (UTC)
Date: Tue, 15 Apr 2025 18:06:57 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 12/15] block: move debugfs/sysfs register out of freezing
 queue
Message-ID: <Z_4vwU7HMLCShZUO@fedora>
References: <20250410133029.2487054-1-ming.lei@redhat.com>
 <20250410133029.2487054-13-ming.lei@redhat.com>
 <b28d98a6-b406-45b0-a5db-11bc600be75f@linux.ibm.com>
 <Z_xn-Zl5FDGdZ_Bk@fedora>
 <96d870d2-19f2-489e-951f-b92a56b59bf6@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96d870d2-19f2-489e-951f-b92a56b59bf6@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Tue, Apr 15, 2025 at 03:07:18PM +0530, Nilay Shroff wrote:
> 
> 
> On 4/14/25 7:12 AM, Ming Lei wrote:
> > On Fri, Apr 11, 2025 at 12:27:17AM +0530, Nilay Shroff wrote:
> >>
> >>
> >> On 4/10/25 7:00 PM, Ming Lei wrote:
> >>> Move debugfs/sysfs register out of freezing queue in
> >>> __blk_mq_update_nr_hw_queues(), so that the following lockdep dependency
> >>> can be killed:
> >>>
> >>> 	#2 (&q->q_usage_counter(io)#16){++++}-{0:0}:
> >>> 	#1 (fs_reclaim){+.+.}-{0:0}:
> >>> 	#0 (&sb->s_type->i_mutex_key#3){+.+.}-{4:4}: //debugfs
> >>>
> >>> And registering/un-registering debugfs/sysfs does not require queue to be
> >>> frozen.
> >>>
> >>> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> >>> ---
> >>>  block/blk-mq.c | 20 ++++++++++----------
> >>>  1 file changed, 10 insertions(+), 10 deletions(-)
> >>>
> >>> diff --git a/block/blk-mq.c b/block/blk-mq.c
> >>> index 7219b01764da..0fb72a698d77 100644
> >>> --- a/block/blk-mq.c
> >>> +++ b/block/blk-mq.c
> >>> @@ -4947,15 +4947,15 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
> >>>  	if (set->nr_maps == 1 && nr_hw_queues == set->nr_hw_queues)
> >>>  		return;
> >>>  
> >>> -	memflags = memalloc_noio_save();
> >>> -	list_for_each_entry(q, &set->tag_list, tag_set_list)
> >>> -		blk_mq_freeze_queue_nomemsave(q);
> >>> -
> >>>  	list_for_each_entry(q, &set->tag_list, tag_set_list) {
> >>>  		blk_mq_debugfs_unregister_hctxs(q);
> >>>  		blk_mq_sysfs_unregister_hctxs(q);
> >>>  	}
> >> As we removed hctx sysfs protection while un-registering it, this might
> >> cause crash or other side-effect if simultaneously these sysfs attributes
> >> are accessed. The read access of these attributes are still protected 
> >> using ->elevator_lock. 
> > 
> > The ->elevator_lock in ->show() is useless except for reading the elevator
> > internal data(sched tags, requests, ...), even for reading elevator data,
> > it should have been relying on elevator reference, instead of lock, but
> > that is another topic & improvement in future.
> > 
> > Also this patch does _not_ change ->elevator_lock for above debugfs/sysfs
> > unregistering, does it? It is always done without holding ->elevator_lock.
> > Also ->show() does not require ->q_usage_counter too.
> > 
> > As I mentioned, kobject/sysfs provides protection between ->show()/->store()
> > and kobject_del(), isn't it the reason why you want to remove ->sys_lock?
> > 
> > https://lore.kernel.org/linux-block/20250226124006.1593985-1-nilay@linux.ibm.com/
> > 
> Yes you were correct, that was the reason we wanted to remove ->sysfs_lock.
> However for these particular hctx sysfs attributes (nr_tags and nr_reserved_tags)
> could be updated simultaneously from another blk-mq sysfs attribute named nr_requests.
> Hence IMO, the default protection provided by sysfs/kernfs may not be sufficient and
> so we need to protect those attributes using ->elevator_lock.

Yes, what is why this patchset doesn't kill more ->elevator_lock uses, such
as, the uses in blk-mq-debugs, update_nr_requests, but many of them can be
replaced with grabbing elevator reference.

But with/without this patch, the touched register/unregisger code does not
require ->elevator_lock:

                blk_mq_debugfs_unregister_hctxs(q);
                blk_mq_sysfs_unregister_hctxs(q);

so I don't understand why you argue here about ->elevator_lock use?

> 
> Consider this case: While blk_mq_update_nr_hw_queues removes hctx attributes,
> and simultaneously if nr_requests is also updating num of tags, would that not 
> cause any side effect?

Why is updating nr_requests related with removing hctx attributes?

Can you explain the side effect in details?

> Maybe we also want to protect blk_mq_update_nr_requests
> with srcu read lock (set->update_nr_hwq_srcu) so that it couldn't run while  
> blk_mq_update_nr_hw_queues is in progress?

Yeah, agree, and it can be one new patch for covering race between
blk_mq_update_nr_requests and blk_mq_update_nr_hw_queues, the point is just
that nr_hw_queues is being changed, and not related with removing hctx
attributes, IMO.


Thanks,
Ming

