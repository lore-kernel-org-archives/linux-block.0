Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0646621A459
	for <linux-block@vger.kernel.org>; Tue, 18 Nov 2025 04:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763439393; cv=none; b=QqnJcTcowGgIma+o3VKKTteLBRsO7ycmP2UMSNlj3sfnysGD5ljlvgjEqSwaFh/W85MG/Z71jo+r0Uv4DFEbea9FkhdUvP3bJnTlvaxI0sUtT+DM2p80+ABgPxNX0ercACbP8DE1xCcs3qoQwqRgneUoycCM6YHysjUdYOAX54E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763439393; c=relaxed/simple;
	bh=0EmpycISXsiCfB+aW9O3qEFaQEOB8UQN8aa4IO0H/zg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DW2hGmKj3ahvYBh2C3I10nOFzQ7wmGF0LAat9aci4tU+kewQ0dxVGmwplLRh5y6WHXxlOzKx5i+ifHS0obvf4/fwcey/8oT1E3LPoUAuRdIr+5lQO0Q8EcnmuAfX9JOqQp14lCVeUcutXjkfRhNTZU44rg/vCZ/Y3EGiD4qtWcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G1ofr6+W; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G1ofr6+W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763439391;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+za5bpe7k71RSNz1ZZSlS9cG3UfbTIZDcQkUGjZWi8g=;
	b=G1ofr6+WCfeHkbaVEhOlZlpZ1hyjXiausMDj3MW+UJ78573WhFl5JyUzWvSkoYo5C/YU1Z
	T04wFALK2l+IbekgapTO/BHG7OmukuAzNsic+WmcJ1xHU/P8TKrHixBi0Sj+xtrA4xpYL3
	hSYk5t+qzJDj0WeFS+AB23F4VShraYs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-553-_WonIOKVOMGBMmOshQOHGQ-1; Mon,
 17 Nov 2025 23:16:25 -0500
X-MC-Unique: _WonIOKVOMGBMmOshQOHGQ-1
X-Mimecast-MFC-AGG-ID: _WonIOKVOMGBMmOshQOHGQ_1763439383
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 549C1180028A;
	Tue, 18 Nov 2025 04:16:23 +0000 (UTC)
Received: from fedora (unknown [10.72.116.204])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C30611800451;
	Tue, 18 Nov 2025 04:16:15 +0000 (UTC)
Date: Tue, 18 Nov 2025 12:16:10 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Casey Chen <cachen@purestorage.com>,
	Vikas Manocha <vmanocha@purestorage.com>,
	Yuanyuan Zhong <yzhong@purestorage.com>,
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] nvme: Convert tag_list mutex to rwsemaphore to
 avoid deadlock
Message-ID: <aRvzCs_FXa_liTWv@fedora>
References: <20251117202414.4071380-1-mkhalfella@purestorage.com>
 <20251117202414.4071380-2-mkhalfella@purestorage.com>
 <aRvTM5LbnehQU77-@fedora>
 <20251118021504.GC2197103-mkhalfella@purestorage.com>
 <aRvaXFA9mG2WDIXA@fedora>
 <20251118034405.GB2376676-mkhalfella@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251118034405.GB2376676-mkhalfella@purestorage.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Mon, Nov 17, 2025 at 07:44:05PM -0800, Mohamed Khalfella wrote:
> On Tue 2025-11-18 10:30:52 +0800, Ming Lei wrote:
> > On Mon, Nov 17, 2025 at 06:15:04PM -0800, Mohamed Khalfella wrote:
> > > On Tue 2025-11-18 10:00:19 +0800, Ming Lei wrote:
> > > > On Mon, Nov 17, 2025 at 12:23:53PM -0800, Mohamed Khalfella wrote:
> > > > >  static void blk_mq_add_queue_tag_set(struct blk_mq_tag_set *set,
> > > > >  				     struct request_queue *q)
> > > > >  {
> > > > > -	mutex_lock(&set->tag_list_lock);
> > > > > +	struct request_queue *firstq;
> > > > > +	unsigned int memflags;
> > > > >  
> > > > > -	/*
> > > > > -	 * Check to see if we're transitioning to shared (from 1 to 2 queues).
> > > > > -	 */
> > > > > -	if (!list_empty(&set->tag_list) &&
> > > > > -	    !(set->flags & BLK_MQ_F_TAG_QUEUE_SHARED)) {
> > > > > -		set->flags |= BLK_MQ_F_TAG_QUEUE_SHARED;
> > > > > -		/* update existing queue */
> > > > > -		blk_mq_update_tag_set_shared(set, true);
> > > > > -	}
> > > > > -	if (set->flags & BLK_MQ_F_TAG_QUEUE_SHARED)
> > > > > -		queue_set_hctx_shared(q, true);
> > > > > -	list_add_tail(&q->tag_set_list, &set->tag_list);
> > > > > +	down_write(&set->tag_list_rwsem);
> > > > > +	if (!list_is_singular(&set->tag_list)) {
> > > > > +		if (set->flags & BLK_MQ_F_TAG_QUEUE_SHARED)
> > > > > +			queue_set_hctx_shared(q, true);
> > > > > +		list_add_tail(&q->tag_set_list, &set->tag_list);
> > > > > +		up_write(&set->tag_list_rwsem);
> > > > > +		return;
> > > > > +	}
> > > > >  
> > > > > -	mutex_unlock(&set->tag_list_lock);
> > > > > +	/* Transitioning firstq and q to shared. */
> > > > > +	set->flags |= BLK_MQ_F_TAG_QUEUE_SHARED;
> > > > > +	list_add_tail(&q->tag_set_list, &set->tag_list);
> > > > > +	downgrade_write(&set->tag_list_rwsem);
> > > > > +	queue_set_hctx_shared(q, true);
> > > > 
> > > > queue_set_hctx_shared(q, true) should be moved into write critical area
> > > > because this queue has been added to the list.
> > > > 
> > > 
> > > I failed to see why that is the case. What can go wrong by running
> > > queue_set_hctx_shared(q, true) after downgrade_write()?
> > > 
> > > After the semaphore is downgraded we promise not to change the list
> > > set->tag_list because now we have read-only access. Marking the "q" as
> > > shared should be fine because it is new and we know there will be no
> > > users of the queue yet (that is why we skipped freezing it).
> >  
> > I think it is read/write lock's use practice. The protected data shouldn't be
> > written any more when you downgrade to read lock.
> > 
> > In this case, it may not make a difference, because it is one new queue and
> > the other readers don't use the `shared` flag, but still better to do
> > correct things from beginning and make code less fragile.
> > 
> 
> set->tag_list_rwsem protects set->tag_list. It does not protect
> hctx->flags. hctx->flags is protected by the context. In the case of "q"
> it is new and we are not expecting request allocation. In case of
> "firstq" the queue is frozen which makes it safe to update hctx->flags.
> I prefer to keep the code as it is unless there is a reason to change
> it.

Fair enough, given it is done for `firstrq`.


Thanks, 
Ming

