Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3AE30100
	for <linux-block@vger.kernel.org>; Wed, 16 Apr 2025 01:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744768164; cv=none; b=gioQQXJVKvsiTyUdWsTf1IbnR2D4zgU0d+uvNRFkNPSYeXUPDLSaE7uzNxEcVV4uStuLoyU4O3GXNnuharlW16sp4zSQVtaPxgRYo0X+IuG7z2IuTIeTo8uZVJ3AUOu7Ilg0/BZJg68qmiB5ST6a3ftkP1IY3t9cixJJO8jzU7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744768164; c=relaxed/simple;
	bh=gCtrkAY/1gSAyY54nHGLOzbGiEY12hGRGMJqsUSyUh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jaq2y5voK0/Tk3HteRS7N42MBJLId3IEIWnwLQIg8lb5OxRpnOYPYEVSbCguwpQQRY/f0RaFcx1bA8tF83qUaN1+Xdw8J+0XyyxdIKU9oDs1x3gE+ntFkG8RTpJtx1bzHUTl3QHlQq9fXpNDb90K39EgguibgjsHy+qZ8EKPcac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TdcLL5Bw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TdcLL5Bw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744768161;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cPz71B32AuuUNFUzWVCyPpZBtUUQTj9p8YChRtvwXw4=;
	b=TdcLL5BwZj5HcpkhhCn5/JPfjeWTaTxe+yXlibrd0eKQt2sJZ5ATBYNCC5QpwEKJBZrG7H
	LcMfPFxqIP5Gd5DpxAPmyxGRjE2JGJXYB8Kk8GoTtMmaBT+OOSzuwayYmukBj8T+MTffuz
	DkSeu8/1P/opSrsc1qUQVglbZ9JfnaI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-92-CpVJXOHiNSm8YgEGdWoglg-1; Tue,
 15 Apr 2025 21:49:18 -0400
X-MC-Unique: CpVJXOHiNSm8YgEGdWoglg-1
X-Mimecast-MFC-AGG-ID: CpVJXOHiNSm8YgEGdWoglg_1744768156
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 91D35180025B;
	Wed, 16 Apr 2025 01:49:16 +0000 (UTC)
Received: from fedora (unknown [10.72.116.72])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D9CC41828A9F;
	Wed, 16 Apr 2025 01:49:11 +0000 (UTC)
Date: Wed, 16 Apr 2025 09:49:06 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 09/15] block: unifying elevator change
Message-ID: <Z_8Mkkja_ujKPYLd@fedora>
References: <20250410133029.2487054-1-ming.lei@redhat.com>
 <20250410133029.2487054-10-ming.lei@redhat.com>
 <83f5e47a-8738-4776-ae23-7ff0cad7ba48@linux.ibm.com>
 <Z_xjQ3djcyF39F_w@fedora>
 <a5896cdb-a59a-4a37-9f99-20522f5d2987@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5896cdb-a59a-4a37-9f99-20522f5d2987@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Tue, Apr 15, 2025 at 06:00:47PM +0530, Nilay Shroff wrote:
> 
> 
> On 4/14/25 6:52 AM, Ming Lei wrote:
> > On Fri, Apr 11, 2025 at 12:07:34AM +0530, Nilay Shroff wrote:
> >>
> >>
> >> On 4/10/25 7:00 PM, Ming Lei wrote:
> >>>  /*
> >>>   * Use the default elevator settings. If the chosen elevator initialization
> >>>   * fails, fall back to the "none" elevator (no elevator).
> >>>   */
> >>> -void elevator_init_mq(struct request_queue *q)
> >>> +void elevator_set_default(struct request_queue *q)
> >>>  {
> >>> -	struct elevator_type *e;
> >>> -	unsigned int memflags;
> >>> +	struct elev_change_ctx ctx = { };
> >>>  	int err;
> >>>  
> >>> -	WARN_ON_ONCE(blk_queue_registered(q));
> >>> -
> >>> -	if (unlikely(q->elevator))
> >>> +	if (!queue_is_mq(q))
> >>>  		return;
> >>>  
> >>> -	e = elevator_get_default(q);
> >>> -	if (!e)
> >>> +	ctx.name = use_default_elevator(q) ? "mq-deadline" : "none";
> >>> +	if (!q->elevator && !strcmp(ctx.name, "none"))
> >>>  		return;
> >>> +	err = elevator_change(q, &ctx);
> >>> +	if (err < 0)
> >>> +		pr_warn("\"%s\" set elevator failed %d, "
> >>> +			"falling back to \"none\"\n", ctx.name, err);
> >>> +}
> >>>  
> >> If we fail to set the evator to default (mq-deadline) while registering queue, 
> >> because nr_hw_queue update is simultaneously running then we may end up setting 
> >> the queue elevator to none and that's not correct. Isn't it?
> > 
> > It still works with none.
> > 
> > I think it isn't one big deal. And if it is really one issue in future, we can
> > set one flag in elevator_set_default(), and let blk_mq_update_nr_hw_queues set
> > default sched for us.
> > 
> >>
> >>> +void elevator_set_none(struct request_queue *q)
> >>> +{
> >>> +	struct elev_change_ctx ctx = {
> >>> +		.name	= "none",
> >>> +		.uevent = 1,
> >>> +	};
> >>> +	int err;
> >>>  
> >>> -	blk_mq_unfreeze_queue(q, memflags);
> >>> +	if (!queue_is_mq(q))
> >>> +		return;
> >>>  
> >>> -	if (err) {
> >>> -		pr_warn("\"%s\" elevator initialization failed, "
> >>> -			"falling back to \"none\"\n", e->elevator_name);
> >>> -	}
> >>> +	if (!q->elevator)
> >>> +		return;
> >>>  
> >>> -	elevator_put(e);
> >>> +	err = elevator_change(q, &ctx);
> >>> +	if (err < 0)
> >>> +		pr_warn("%s: set none elevator failed %d\n", __func__, err);
> >>>  }
> >>>  
> >> Here as well if we fail to disable/exit elevator while deleting disk 
> >> because nr_hw_queue update is simultaneously running  then we may
> >> leak elevator resource? 
> > 
> > When blk_mq_update_nr_hw_queues() observes that queue is dying, it
> > forces to change elevator to none, so there isn't elevator leak issue.
> > 
> Yes if we get into blk_mq_update_nr_hw_queues after dying flag is set.
> But what if blk_mq_update_nr_hw_queues doesn't see dying flag and starts 
> running __elevator_change. However later we set dying flag from del_gendisk
> and starts running elevator_set_none simultaneously on another cpu? 
> In this case elevator_set_none would fail to set the elevator to "none" as 
> blk_mq_update_nr_hw_queues is running on another cpu. Isn't it?
> 
> >>
> >>> @@ -565,11 +559,7 @@ int __must_check add_disk_fwnode(struct device *parent, struct gendisk *disk,
> >>>  	if (disk->major == BLOCK_EXT_MAJOR)
> >>>  		blk_free_ext_minor(disk->first_minor);
> >>>  out_exit_elevator:
> >>> -	if (disk->queue->elevator) {
> >>> -		mutex_lock(&disk->queue->elevator_lock);
> >>> -		elevator_exit(disk->queue);
> >>> -		mutex_unlock(&disk->queue->elevator_lock);
> >>> -	}
> >>> +	elevator_set_none(disk->queue);
> >> Same comment as above here as well but this is in add_disk code path.
> > 
> > We can avoid it by forcing to change to none in blk_mq_update_nr_hw_queues() for
> > !blk_queue_registered()
> > 
> Here as well there's a thin race window possible assuming add_disk fails 
> after we registered queue. Assuming nr_hw_queue update starts running
> and it sees queue is registered however on another cpu add_disk fails 
> just after registering queue. So in this case still it might be possible
> that elevator_set_none might fail to set elevator to "none" just because
> nr_hw_queue update is running on another cpu. What do you think?

Yeah.

It isn't hard to solve, but just don't want to make the whole
implementation too complicated.

Another way is to prevent add_disk & del_disk from happening during
updating nr_hw_queues, and this way is reasonable too because both blk_mq
debugfs & sysfs registering depends on nr_hw_queues.

Meantime we can retry add_disk/del_disk until updating_nr_hw_queues are
finished, and one waitqueue can be added, so the wait can be:


add_disk():
	while (true) {
		srcu_read_lock()
		if (set->is_updating_nr_hw_queus) {
			srcu_read_unlock();
			goto wait;
		}
		__add_disk();
		srcu_read_unlock()
		break;
	wait:
		wait_event(set->wq, !set->is_updating_nr_hw_queus);
	}

Thanks,
Ming

