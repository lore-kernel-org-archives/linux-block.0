Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849BB1C1F13
	for <linux-block@vger.kernel.org>; Thu, 10 Apr 2025 02:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744251055; cv=none; b=Noiq/H0kHtYjQ+JogYDGthDEdjMCQ0lG0temZX8KBXVEP8JSlD464SlHxWHBQ86Gp174HHKgmUs0h0kwk0Zpg8pI/Utd+HjhuZCe/7aV5b/f2J1zsLTzmtr6fEp64noZ1aLLsQa8rvTHtsY9DyAk42XN3lvoKfzVy4bCz15nMVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744251055; c=relaxed/simple;
	bh=5sZvu1Ou31lv+/54ZojKAArbpHA4yfQade2EkyUNAPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I3EaBw0cEqfZuYMcUfuxVi5zLa5S2FH/BUV1t5y4NfBenWSSlvv9kVKISRG9NT0ph2KGZC7ychlSZrCCO9nNeQowF0PAdC4i/RZ09eU2qBB62LXrscCIMvirnMZ4x89XCdb64UhKucus0rYQn5Or0SuEdsSQyfVwzYw2E+yZkmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jJTkMfsm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jJTkMfsm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744251052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oKGnpuPU7kD11I+yz1MSiqXQRYRxHKG0sX4OPHEaOys=;
	b=jJTkMfsm3jNU6r8V8/qATp1vMHc69YaRY9+BMjYf00fNWU19Rphyj0egPhxDRrmLNsTe/0
	+ULYDKS3Ca5pCymPMenp5i+0qQFF5QDoWSATZMxy1/NGosiRD5qI3hiZc/uQLSuyTV3+RI
	FFNqTxgla7LFyWe4tSxMTEcDNLwNCfI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-90-MZl1sp2iPjaNdrM7cCR_lQ-1; Wed,
 09 Apr 2025 22:10:50 -0400
X-MC-Unique: MZl1sp2iPjaNdrM7cCR_lQ-1
X-Mimecast-MFC-AGG-ID: MZl1sp2iPjaNdrM7cCR_lQ_1744251049
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C03171800EC5;
	Thu, 10 Apr 2025 02:10:48 +0000 (UTC)
Received: from fedora (unknown [10.72.120.20])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CEAE91809BF7;
	Thu, 10 Apr 2025 02:10:43 +0000 (UTC)
Date: Thu, 10 Apr 2025 10:10:37 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	syzbot+4c7e0f9b94ad65811efb@syzkaller.appspotmail.com
Subject: Re: [PATCH] block: don't grab elevator lock during queue
 initialization
Message-ID: <Z_concavD65-DXqA@fedora>
References: <Z_NB2VA9D5eqf0yH@fedora>
 <ea09ea46-4772-4947-a9ad-195e83f1490d@linux.ibm.com>
 <Z_TSYOzPI3GwVms7@fedora>
 <c2c9e913-1c24-49c7-bfc5-671728f8dddc@linux.ibm.com>
 <Z_UpoiWlBnwaUW7B@fedora>
 <ff08d88c-4680-40be-890a-19191e019419@linux.ibm.com>
 <Z_ZeEXyLLzrYcN3b@fedora>
 <03ba309d-b266-4596-83aa-1731c6cc1cfb@linux.ibm.com>
 <Z_Z_Vt2Rv2UfC1qv@fedora>
 <5c2274c0-fd82-4752-b735-32e52de2a80f@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c2274c0-fd82-4752-b735-32e52de2a80f@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Thu, Apr 10, 2025 at 01:15:22AM +0530, Nilay Shroff wrote:
> 
> 
> On 4/9/25 7:38 PM, Ming Lei wrote:
> >>>>> __blk_mq_update_nr_hw_queues is the only chance for tagset wide queues
> >>>>> involved wrt. switching elevator. If elevator switching is not allowed
> >>>>> when __blk_mq_update_nr_hw_queues() is started, why do we need per-set
> >>>>> lock?
> >>>>>
> >>>> Yes if elevator switch is not allowed then we probably don't need per-set lock. 
> >>>> However my question was if we were to not allow elevator switch while 
> >>>> __blk_mq_update_nr_hw_queues is running then how would we implement it?
> >>>
> >>> It can be done easily by tag_set->srcu.
> >> Ok great if that's possible! But I'm not sure how it could be done in this
> >> case. I think both __blk_mq_update_nr_hw_queues and elv_iosched_store
> >> run in the writer/updater context. So you may still need lock? Can you
> >> please send across a (informal) patch with your idea ?

> On Wed, Apr 09, 2025 at 07:16:03PM +0530, Nilay Shroff wrote:
>> Yes new incoming NS may not be live yet when we iterate through
>> ctrl->namespaces. So we don't need bother about it yet.

If new NS needn't to be considered, the issue is easier to deal with updating
nr_hw_queues, such as:

- disable scheduler in 1st iterating tag_list

- update nr_hw_queues in 2nd iterating tag_list

- restore scheduler in 3rd iterating tag_list

->tag_list_lock is acquired & released in each iteration.

Then per-set lock isn't needed any more.

> > 
> > Please see the attached patch which treats elv_iosched_store() as reader.
> > 
> I looked trough patch and looks good. However we still have an issue 
> in code paths where we acquire ->elevator_lock without first freezing 
> the queue.In this case if we try allocate memory using GFP_KERNEL 
> then fs_reclaim would still trigger lockdep splat. As for this case
> the lock order would be,
> 
> elevator_lock -> fs_reclaim(GFP_KERNEL) -> &q->q_usage_counter(io)

That is why I call ->elevator_lock is used too much, especially it is
depended for dealing with kobject & sysfs, which isn't needed in this way.

> 
> In fact, I tested your patch and got into the above splat. I've 
> attached lockdep splat for your reference. So IMO, we should instead
> try make locking order such that ->freeze_lock shall never depend on
> ->elevator_lock. It seems one way to make that possible if we make
> ->elevator_lock per-set. 

The attached patch is just for avoiding race between add/del disk vs.
updating nr_hw_queues, and it should have been for covering race between
adding/exiting request queue vs. updating nr_hw_queues.

If re-order can be done, that is definitely good, but...

> 
> >>>
> >>> Actually freeze lock is already held for nvme before calling
> >>> blk_mq_update_nr_hw_queues, and it is reasonable to suppose queue
> >>> frozen for updating nr_hw_queues, so the above order may not match
> >>> with the existed code.
> >>>
> >>> Do we need to consider nvme or blk_mq_update_nr_hw_queues now?
> >>>
> >> I think we should consider (may be in different patch) updating
> >> nvme_quiesce_io_queues and nvme_unquiesce_io_queues and remove
> >> its dependency on ->tag_list_lock.
> > 
> > If we need to take nvme into account, the above lock order doesn't work,
> > because nvme freezes queue before calling blk_mq_update_nr_hw_queues(),
> > and elevator lock still depends on freeze lock.
> > 
> > If it needn't to be considered, per-set lock becomes necessary.
> IMO, in addition to nvme_quiesce_io_queues and nvme_unquiesce_io_queues
> we shall also update nvme pci, rdma and tcp drivers so that those 
> drivers neither freeze queue prior to invoking blk_mq_update_nr_hw_queues
> nor unfreeze queue after blk_mq_update_nr_hw_queues returns. I see that
> nvme loop and fc don't freeze queue prior to invoking blk_mq_update_nr_hw_queues.

This way you cause new deadlock or new trouble if you reply on freeze in
blk_mq_update_nr_hw_queues():

 ->tag_list_lock
 	freeze_lock

If timeout or io failure happens during the above freeze_lock, timeout
handler can not move on because new blk_mq_update_nr_hw_queues() can't
grab the lock.

Either deadlock or device has to been removed.

> 
> >>>>
> >>>> So now ->freeze_lock should not depend on ->elevator_lock and that shall
> >>>> help avoid few of the recent lockdep splats reported with fs_reclaim.
> >>>> What do you think?
> >>>
> >>> Yes, reordering ->freeze_lock and ->elevator_lock may avoid many fs_reclaim
> >>> related splat.
> >>>
> >>> However, in del_gendisk(), freeze_lock is still held before calling
> >>> elevator_exit() and blk_unregister_queue(), and looks not easy to reorder.
> >>
> >> Yes agreed, however elevator_exit() called from del_gendisk() or 
> >> elv_unregister_queue() called from blk_unregister_queue() are called 
> >> after we unregister the queue. And if queue has been already unregistered
> >> while invoking elevator_exit or del_gensidk then ideally we don't need to
> >> acquire ->elevator_lock. The same is true for elevator_exit() called 
> >> from add_disk_fwnode(). So IMO, we should update these paths to avoid 
> >> acquiring ->elevator_lock.
> > 
> > As I mentioned, blk_mq_update_nr_hw_queues() still can come, which is one
> > host wide event, so either lock or srcu sync is needed.
> Yes agreed, I see that blk_mq_update_nr_hw_queues can run in parallel 
> with del_gendisk or blk_unregister_queue.

Then the per-set lock is required in both add/del disk, then how to re-order
freeze_lock & elevator lock in del_gendisk()? 

And there is same risk with the one in blk_mq_update_nr_hw_queues().

> 
> Thanks,
> --Nilay

> [  399.112145] ======================================================
> [  399.112153] WARNING: possible circular locking dependency detected
> [  399.112160] 6.15.0-rc1+ #159 Not tainted
> [  399.112167] ------------------------------------------------------
> [  399.112174] bash/5891 is trying to acquire lock:
> [  399.112181] c0000000bc2334f8 (&q->elevator_lock){+.+.}-{4:4}, at: elv_iosched_store+0x11c/0x5d4
> [  399.112205]
> [  399.112205] but task is already holding lock:
> [  399.112211] c0000000bc232fd8 (&q->q_usage_counter(io)#20){++++}-{0:0}, at: blk_mq_freeze_queue_nomemsave+0x28/0x40
> [  399.112231]
> [  399.112231] which lock already depends on the new lock.
> [  399.112231]
> [  399.112239]
> [  399.112239] the existing dependency chain (in reverse order) is:
> [  399.112246]
> [  399.112246] -> #2 (&q->q_usage_counter(io)#20){++++}-{0:0}:
> [  399.112260]        blk_alloc_queue+0x3a8/0x3e4
> [  399.112268]        blk_mq_alloc_queue+0x88/0x11c
> [  399.112278]        __blk_mq_alloc_disk+0x34/0xd8
> [  399.112290]        null_add_dev+0x3c8/0x914 [null_blk]
> [  399.112306]        null_init+0x1e0/0x4bc [null_blk]
> [  399.112319]        do_one_initcall+0x8c/0x4b8
> [  399.112340]        do_init_module+0x7c/0x2c4
> [  399.112396]        init_module_from_file+0xb4/0x108
> [  399.112405]        idempotent_init_module+0x26c/0x368
> [  399.112414]        sys_finit_module+0x98/0x150
> [  399.112422]        system_call_exception+0x134/0x360
> [  399.112430]        system_call_vectored_common+0x15c/0x2ec
> [  399.112441]
> [  399.112441] -> #1 (fs_reclaim){+.+.}-{0:0}:
> [  399.112453]        fs_reclaim_acquire+0xe4/0x120
> [  399.112461]        kmem_cache_alloc_noprof+0x74/0x570
> [  399.112469]        __kernfs_new_node+0x98/0x37c
> [  399.112479]        kernfs_new_node+0x94/0xe4
> [  399.112490]        kernfs_create_dir_ns+0x44/0x120
> [  399.112501]        sysfs_create_dir_ns+0x94/0x160
> [  399.112512]        kobject_add_internal+0xf4/0x3c8
> [  399.112524]        kobject_add+0x70/0x10c
> [  399.112533]        elv_register_queue+0x70/0x14c
> [  399.112562]        blk_register_queue+0x1d8/0x2bc
> [  399.112575]        add_disk_fwnode+0x3b4/0x5d0
> [  399.112588]        sd_probe+0x3bc/0x5b4 [sd_mod]
> [  399.112601]        really_probe+0x104/0x4c4
> [  399.112613]        __driver_probe_device+0xb8/0x200
> [  399.112623]        driver_probe_device+0x54/0x128
> [  399.112632]        __driver_attach_async_helper+0x7c/0x150
> [  399.112641]        async_run_entry_fn+0x60/0x1bc
> [  399.112665]        process_one_work+0x2ac/0x7e4
> [  399.112678]        worker_thread+0x238/0x460
> [  399.112691]        kthread+0x158/0x188
> [  399.112700]        start_kernel_thread+0x14/0x18
> [  399.112722]
> [  399.112722] -> #0 (&q->elevator_lock){+.+.}-{4:4}:

Another ways is to make sure that ->elevator_lock isn't required for dealing
with kobject/debugfs thing, which needs to refactor elevator code.

Such as, ->elevator_lock is grabbed in debugfs handler, removing sched debugfs
actually need to drain reader, that is deadlock too.

Thanks,
Ming

