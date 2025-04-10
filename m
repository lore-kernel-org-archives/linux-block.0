Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F49E1F873E
	for <linux-block@vger.kernel.org>; Thu, 10 Apr 2025 14:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744295037; cv=none; b=ESeu+XkeNv0399zh87Aa0OXvCI7+/ZmMODzgtCKARi3INe/1B2G/AEGYufANgupIgU9j9IXMCmk5yQul/gxGIvfUPebVUXDrPaVbf+kj3gbwbPPIHCcRNV/ZvdjCCuAH5qRCXXaglTSdK7XL3Yal3408Ri7PMZQmD+EjIMPAzeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744295037; c=relaxed/simple;
	bh=ieqiEQml1yRjJGOIyHWGcRbrpWo+VQI+1mIHyTorQqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B/zQqSTxcIczmVrJsDIpdf6nLBB/FsajR1TroJWYvOuEzEy1Us+oi7WmRzLvHLgRNeyrya74+xF+z0ARhg8ByDwj4cbgwTgNNjq+AZjB6e7DnXbO3bE6BXGKNb/9Js2WX0xpKeolWOaiEFvhRES+mYOl8XlZrSciXF0I2X3VkMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Iy8BRXqL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Iy8BRXqL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744295034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e7upomymvw2gpqgJdv3A+yAD5DQVZ2+RJ7b8mxyblIs=;
	b=Iy8BRXqLjDMekH8XzJ2v8yg6Qu3HRJJ1a6ebGfh27uPIS1LRRcAarBoScmDF24z+r8uTx2
	8N1mclPgftreIFXVVXwG/MMJrr1tXlX9JcjYW6h4Xp0I12U7ZGdBXV8EVNTuE7wnEQl2m4
	sGObKPpZ/59HZDGrQAHCgR1HaNbS9ks=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-153-kzSd-5IYMh-_BO7OuHPCeQ-1; Thu,
 10 Apr 2025 10:23:50 -0400
X-MC-Unique: kzSd-5IYMh-_BO7OuHPCeQ-1
X-Mimecast-MFC-AGG-ID: kzSd-5IYMh-_BO7OuHPCeQ_1744295029
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9B86719560B0;
	Thu, 10 Apr 2025 14:23:49 +0000 (UTC)
Received: from fedora (unknown [10.72.120.20])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E48CA1944D01;
	Thu, 10 Apr 2025 14:23:44 +0000 (UTC)
Date: Thu, 10 Apr 2025 22:23:38 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	syzbot+4c7e0f9b94ad65811efb@syzkaller.appspotmail.com
Subject: Re: [PATCH] block: don't grab elevator lock during queue
 initialization
Message-ID: <Z_fUaumnM2lzQKIh@fedora>
References: <Z_TSYOzPI3GwVms7@fedora>
 <c2c9e913-1c24-49c7-bfc5-671728f8dddc@linux.ibm.com>
 <Z_UpoiWlBnwaUW7B@fedora>
 <ff08d88c-4680-40be-890a-19191e019419@linux.ibm.com>
 <Z_ZeEXyLLzrYcN3b@fedora>
 <03ba309d-b266-4596-83aa-1731c6cc1cfb@linux.ibm.com>
 <Z_Z_Vt2Rv2UfC1qv@fedora>
 <5c2274c0-fd82-4752-b735-32e52de2a80f@linux.ibm.com>
 <Z_concavD65-DXqA@fedora>
 <917201e2-acac-4ab0-982e-04635806304c@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <917201e2-acac-4ab0-982e-04635806304c@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Thu, Apr 10, 2025 at 07:06:23PM +0530, Nilay Shroff wrote:
> 
> 
> On 4/10/25 7:40 AM, Ming Lei wrote:
> > 
> > If new NS needn't to be considered, the issue is easier to deal with updating
> > nr_hw_queues, such as:
> > 
> > - disable scheduler in 1st iterating tag_list
> > 
> > - update nr_hw_queues in 2nd iterating tag_list
> > 
> > - restore scheduler in 3rd iterating tag_list
> > 
> > ->tag_list_lock is acquired & released in each iteration.
> > 
> > Then per-set lock isn't needed any more.
> > 
> Hmm still thinking...
> >>>
> >>> Please see the attached patch which treats elv_iosched_store() as reader.
> >>>
> >> I looked trough patch and looks good. However we still have an issue 
> >> in code paths where we acquire ->elevator_lock without first freezing 
> >> the queue.In this case if we try allocate memory using GFP_KERNEL 
> >> then fs_reclaim would still trigger lockdep splat. As for this case
> >> the lock order would be,
> >>
> >> elevator_lock -> fs_reclaim(GFP_KERNEL) -> &q->q_usage_counter(io)
> > 
> > That is why I call ->elevator_lock is used too much, especially it is
> > depended for dealing with kobject & sysfs, which isn't needed in this way.
> > 
> >>
> >> In fact, I tested your patch and got into the above splat. I've 
> >> attached lockdep splat for your reference. So IMO, we should instead
> >> try make locking order such that ->freeze_lock shall never depend on
> >> ->elevator_lock. It seems one way to make that possible if we make
> >> ->elevator_lock per-set. 
> > 
> > The attached patch is just for avoiding race between add/del disk vs.
> > updating nr_hw_queues, and it should have been for covering race between
> > adding/exiting request queue vs. updating nr_hw_queues.
> > 
> Okay understood.
> 
> > If re-order can be done, that is definitely good, but...
> Yeah so I tried re-ordering locks so that we first grab q->elevator_lock 
> and then ->freeze_lock. As we know there's a challenge with re-arranging
> the lock order in __blk_mq_update_nr_hw_queues, but I managed to rectify 
> the lock order. I added one more tag_list iterator where we first acquire
> ->elevator lock and then in the next tag_list iterator we acquire 
> ->freeze_lock. I have also updated this lock order at other call sites.
> 
> Then as we have already discussed, there's also another challenge re-arranging
> the lock order in del_gendisk, however, I managed to mitigate that by moving 
> elevator_exit and elv_unregister_queue (from blk_unregister_queue)  just after
> we delete queue tag set (or in another words when remove the queue from the 
> tag-list) in del_gendisk. So that means that we could now safely invoke 
> elv_unregister_queue and elevator_exit from  del_gendisk without needing to
> acquire ->elevator_lock.
> 
> For reference, I attached a (informal) patch. Yes I know this patch would not
> fix all splats. But at-least we would stop observing splat related to 
> ->frezze_lock dependency on ->elevator_lcok. 

I just sent out the whole patchset, which did one thing basically: move kobject
& debugfs & cpuhp out of queue freezing, then no any lockdep is observed in my
test VM after running blktests of './check block/'.

So the point is _not_ related with elevator lock or its order with
freeze lock. What matters is actually "do not connect freeze lock with
other subsystem(debugfs, sysfs, cpuhp, ...)", because freeze_lock relies
on fs_reclaim directly with commit ffa1e7ada456, but other subsystem easily
depends on fs_reclaim again.

I did have patches to follow your idea to reorder elevator lock vs. freeze
lock, but it didn't make difference, even though after I killed most of
elevator_lock.

Finally I realized the above point.

> 
> > 
> >>
> >>>>>
> >>>>> Actually freeze lock is already held for nvme before calling
> >>>>> blk_mq_update_nr_hw_queues, and it is reasonable to suppose queue
> >>>>> frozen for updating nr_hw_queues, so the above order may not match
> >>>>> with the existed code.
> >>>>>
> >>>>> Do we need to consider nvme or blk_mq_update_nr_hw_queues now?
> >>>>>
> >>>> I think we should consider (may be in different patch) updating
> >>>> nvme_quiesce_io_queues and nvme_unquiesce_io_queues and remove
> >>>> its dependency on ->tag_list_lock.
> >>>
> >>> If we need to take nvme into account, the above lock order doesn't work,
> >>> because nvme freezes queue before calling blk_mq_update_nr_hw_queues(),
> >>> and elevator lock still depends on freeze lock.
> >>>
> >>> If it needn't to be considered, per-set lock becomes necessary.
> >> IMO, in addition to nvme_quiesce_io_queues and nvme_unquiesce_io_queues
> >> we shall also update nvme pci, rdma and tcp drivers so that those 
> >> drivers neither freeze queue prior to invoking blk_mq_update_nr_hw_queues
> >> nor unfreeze queue after blk_mq_update_nr_hw_queues returns. I see that
> >> nvme loop and fc don't freeze queue prior to invoking blk_mq_update_nr_hw_queues.
> > 
> > This way you cause new deadlock or new trouble if you reply on freeze in
> > blk_mq_update_nr_hw_queues():
> > 
> >  ->tag_list_lock
> >  	freeze_lock
> > 
> > If timeout or io failure happens during the above freeze_lock, timeout
> > handler can not move on because new blk_mq_update_nr_hw_queues() can't
> > grab the lock.
> > 
> > Either deadlock or device has to been removed.
> > 
> With this new attached patch do you still foresee this issue? Yes this patch 
> doesn't change anything with nvme driver, but later we may update nvme driver
> so that nvme driver doesn't require freezing queue before invoking blk_mq_
> update_nr_hw_queues. I think this is requires so that we follow the same lock
> order in all call paths wrt ->elevator_lock and ->freeze_lock.

nvme freeze lock is non_owner, and it can't be verified now, so don't use
nvme for running this lock test.

> 
> >>> As I mentioned, blk_mq_update_nr_hw_queues() still can come, which is one
> >>> host wide event, so either lock or srcu sync is needed.
> >> Yes agreed, I see that blk_mq_update_nr_hw_queues can run in parallel 
> >> with del_gendisk or blk_unregister_queue.
> > 
> > Then the per-set lock is required in both add/del disk, then how to re-order
> > freeze_lock & elevator lock in del_gendisk()? 
> > 
> > And there is same risk with the one in blk_mq_update_nr_hw_queues().
> > 
> Yes please see above as I explained how we could potentially avoid lock order 
> issue in del_gendisk.
> > 
> > Another ways is to make sure that ->elevator_lock isn't required for dealing
> > with kobject/debugfs thing, which needs to refactor elevator code.
> > 
> > Such as, ->elevator_lock is grabbed in debugfs handler, removing sched debugfs
> > actually need to drain reader, that is deadlock too.
> > 
> I do agree. But I think lets first focus on cutting dependency of ->freeze_lock 
> on ->elevator_lock. Once we get past it we may address other. 
> 
> This commit ffa1e7ada456 ("block: Make request_queue lockdep splats show up 
> earlier") has now opened up pandora's box of lockdep splats :) 
> Anyways it's good that we could now catch these issues early on. In general,
> I feel that now this change would show up early on the issues where ->freeze_lock
> depends on any other locks. 

It also shows block layer freeze queue API should be used very carefully, fortunately
we have the powerful lockdep.



Thanks,
Ming

