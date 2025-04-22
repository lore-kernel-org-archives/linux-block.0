Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C092367D4
	for <linux-block@vger.kernel.org>; Tue, 22 Apr 2025 08:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745309622; cv=none; b=TrB+8lIPkmvxX8+0wZP2rJYJUgwxTTn3mxyCqQWJc6gO3pSDk9N0UxtIYVkOMGntM9qviFH57NsxbSn4VBYOe3CGlFVFhJSfLBam4qusBeZTVadH2nhQW2nsVsph+cZ5S9jxAG7FYHLPjiYnxlDxHMOd4s1sKrrN5+/wnLsLWGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745309622; c=relaxed/simple;
	bh=4kViGjaLUDqCGRUiYHO6Me6JaGQHEDdOSt28cLBTMyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j45W6i0Sj5PmKUW/vIv89HFuCOx9Giebt5isFjdA8jv+VLsFb/hutV/XElepuoA3GVBHNtwoK0V3RfsFLnw6TMpOc6F9SaMOxImjCmpGNh7cIs05GCVVgs9Aw92JfJpxVqy2MTO4pNGVRjKI1evFtfo1WzcG6gMgjZ3fC+1ckhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V15kyF0I; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V15kyF0I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745309616;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eGWGrWcObjRUQxZy2lXHI+7olCXX0Ahq60KcQQO/EAk=;
	b=V15kyF0Ie2VtJZTmfeRkEDBy6HUTkTbHUsWFbHCE8VcKYJell1B92HUWw9UkmKXMPEhB/U
	//mxEm++mP08ZCJ0xbMwQkUPAiepbQFLsQ/NAsTeo8camfhrA7Xrbi3bcv4TzxffRM1J78
	UdduQf/ZoNfNnnoMIxJ5NLaAdxfv6oA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-320-GF6PEemsOSSMgWl7xRmwVA-1; Tue,
 22 Apr 2025 04:13:30 -0400
X-MC-Unique: GF6PEemsOSSMgWl7xRmwVA-1
X-Mimecast-MFC-AGG-ID: GF6PEemsOSSMgWl7xRmwVA_1745309609
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E9A931800368;
	Tue, 22 Apr 2025 08:13:28 +0000 (UTC)
Received: from fedora (unknown [10.72.116.157])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 654E9180047F;
	Tue, 22 Apr 2025 08:13:23 +0000 (UTC)
Date: Tue, 22 Apr 2025 16:13:19 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V2 20/20] block: move wbt_enable_default() out of queue
 freezing from sched ->exit()
Message-ID: <aAdPn-47ctywQGIT@fedora>
References: <20250418163708.442085-1-ming.lei@redhat.com>
 <20250418163708.442085-21-ming.lei@redhat.com>
 <261d7b81-e611-47f4-ad55-6f7716c278c7@linux.ibm.com>
 <aAXzToqtIlAoUP7t@fedora>
 <286f9d0e-b782-4062-b0eb-cba6fa81e388@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <286f9d0e-b782-4062-b0eb-cba6fa81e388@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Tue, Apr 22, 2025 at 11:44:59AM +0530, Nilay Shroff wrote:
> 
> 
> On 4/21/25 12:57 PM, Ming Lei wrote:
> > On Sat, Apr 19, 2025 at 08:09:04PM +0530, Nilay Shroff wrote:
> >>
> >>
> >> On 4/18/25 10:07 PM, Ming Lei wrote:
> >>> scheduler's ->exit() is called with queue frozen and elevator lock is held, and
> >>> wbt_enable_default() can't be called with queue frozen, otherwise the
> >>> following lockdep warning is triggered:
> >>>
> >>> 	#6 (&q->rq_qos_mutex){+.+.}-{4:4}:
> >>> 	#5 (&eq->sysfs_lock){+.+.}-{4:4}:
> >>> 	#4 (&q->elevator_lock){+.+.}-{4:4}:
> >>> 	#3 (&q->q_usage_counter(io)#3){++++}-{0:0}:
> >>> 	#2 (fs_reclaim){+.+.}-{0:0}:
> >>> 	#1 (&sb->s_type->i_mutex_key#3){+.+.}-{4:4}:
> >>> 	#0 (&q->debugfs_mutex){+.+.}-{4:4}:
> >>>
> >>> Fix the issue by moving wbt_enable_default() out of bfq's exit(), and
> >>> call it from elevator_change_done().
> >>>
> >>> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> >>> ---
> >>>  block/bfq-iosched.c | 2 +-
> >>>  block/elevator.c    | 5 +++++
> >>>  block/elevator.h    | 1 +
> >>>  3 files changed, 7 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> >>> index 40e4106a71e7..310ce1d8c41e 100644
> >>> --- a/block/bfq-iosched.c
> >>> +++ b/block/bfq-iosched.c
> >>> @@ -7211,7 +7211,7 @@ static void bfq_exit_queue(struct elevator_queue *e)
> >>>  
> >>>  	blk_stat_disable_accounting(bfqd->queue);
> >>>  	blk_queue_flag_clear(QUEUE_FLAG_DISABLE_WBT, bfqd->queue);
> >>> -	wbt_enable_default(bfqd->queue->disk);
> >>> +	set_bit(ELEVATOR_FLAG_ENABLE_WBT_ON_EXIT, &e->flags);
> >>>  
> >>>  	kfree(bfqd);
> >>>  }
> >>> diff --git a/block/elevator.c b/block/elevator.c
> >>> index 8652fe45a2db..378553fce5d8 100644
> >>> --- a/block/elevator.c
> >>> +++ b/block/elevator.c
> >>> @@ -687,8 +687,13 @@ int elevator_change_done(struct request_queue *q, struct elv_change_ctx *ctx)
> >>>  	int ret = 0;
> >>>  
> >>>  	if (ctx->old) {
> >>> +		bool enable_wbt = test_bit(ELEVATOR_FLAG_ENABLE_WBT_ON_EXIT,
> >>> +				&ctx->old->flags);
> >>> +
> >>>  		elv_unregister_queue(q, ctx->old);
> >>>  		kobject_put(&ctx->old->kobj);
> >>> +		if (enable_wbt)
> >>> +			wbt_enable_default(q->disk);
> >>>  	}
> >>>  	if (ctx->new) {
> >>>  		ret = elv_register_queue(q, ctx->new, ctx->uevent);
> >>> diff --git a/block/elevator.h b/block/elevator.h
> >>> index 486be0690499..b14c611c74b6 100644
> >>> --- a/block/elevator.h
> >>> +++ b/block/elevator.h
> >>> @@ -122,6 +122,7 @@ struct elevator_queue
> >>>  
> >>>  #define ELEVATOR_FLAG_REGISTERED	0
> >>>  #define ELEVATOR_FLAG_DYING		1
> >>> +#define ELEVATOR_FLAG_ENABLE_WBT_ON_EXIT	2
> >>>  
> >>>  /* Holding context data for changing elevator */
> >>>  struct elv_change_ctx {
> >>
> >> It seems invoking wbt_enable_default from elevator_change_done could probably
> >> still race with ioc_qos_write or queue_wb_lat_store. Both ioc_qos_write and 
> >> queue_wb_lat_store run with ->freeze_lock and ->elevator_lock protection.
> > 
> > Actually wbt_enable_default() and wbt_init() needn't the above protection,
> > especially since the patch 2/20 removes q->elevator use in
> > wbt_enable_default().
> > 
> Yes agreed, and as I understand XXX_FLAG_DISABLE_WBT was earlier elevator_queue->flags 
> but now (with patch 2/20) it has been moved to request_queue->flags. As elevator_change_done 
> first puts elevator_queue object which would potentially releases/frees the  elevator_queue 
> object. Next while we enable wbt (in elevator_change_done)  we may not have access to the 
> elevator_queue object and so now we reference  QUEUE_FLAG_DISABLE_WBT using request_queue->flags. 
> That's, I believe, the purpose of patch 2/20.
> 
> However even with patch 2/20 change, both elevator_change_done and ioc_qos_write or
> queue_wb_lat_store may run in parallel, isn't it?
> 
> therad1:
> blk_mq_update_nr_hw_queues
>   -> __blk_mq_update_nr_hw_queues
>     -> elevator_change_done
>       -> wbt_enable_default
>         -> wbt_init
>          -> wbt_update_limits

Here wbt_update_limits() is called on un-attached `struct rq_wb` instance,
which is just allocated from heap.

> 
> therad2:
> queue_wb_lat_store
>   -> wbt_set_min_lat
>    -> wbt_update_limits

The above one is run on attached `struct rq_wb` instance.

And there can only be one attached `struct rq_wb` instance, so the above
race doesn't exist because attaching wbt to queue/disk is covered by `q->rq_qos_mutex`.


Thanks,
Ming

