Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2AE1519BF
	for <linux-block@vger.kernel.org>; Tue, 29 Apr 2025 12:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745928698; cv=none; b=B6W+GAQ+CJ9njiuQsq+km0hMKIlQ3F3E1kAOipDrSnGAFbzeypbtN/luwYhnEc3Jj7lSpM9wDn3Ws9zSKOHnBemMOcNLJOS4JPn7SLc1O2YMdQ76w2w8v/XaA+wOS3Tq7r3/ONfRlvzeeozb+tsNtwWYSCQTTMGW8dG61NjJYjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745928698; c=relaxed/simple;
	bh=1bJ16CTqR+fKfEMYOepaX5K3Rd86yWIDW0+6rIoQOkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q99W4lNMcJxPj8bfLd5rxw2svsiEdoERSREvK4dyWGJCnxx5dR3/slNhPw1vI6yM/U58IV+8iFJl/o5VJvauJkzUSa8I89/WJKsp9LSxCZoG3IwWFH2cOJtTEmG12w629UmwQGAKe/mgqbBHDWFp09MFJ6lxjPYCho60CT1MpBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=etQKo9O+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="etQKo9O+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745928695;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9+hLUZuSLbAdk4jI9bcgcaDcAUCcjmjmXFjH3khji7c=;
	b=etQKo9O++2sbcFR4s4M6uA8tonTTqfUeKKbUCy6z6Tc12m3PLSuCWE+Vz1GyNS8/4h6ESc
	eB8ZaR55AE6RfhLKVE7xpgqnK3ssAY5DxfNlMmtNHYVNJRbMpEC3foyDz9mwFaky6nM7XX
	wFmQZr69mwnhMqEJX1kqu862K16GcmU=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-556-spouMhALO6yc7_P7jIIxRQ-1; Tue,
 29 Apr 2025 08:11:33 -0400
X-MC-Unique: spouMhALO6yc7_P7jIIxRQ-1
X-Mimecast-MFC-AGG-ID: spouMhALO6yc7_P7jIIxRQ_1745928692
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 817411956048;
	Tue, 29 Apr 2025 12:11:32 +0000 (UTC)
Received: from fedora (unknown [10.72.116.24])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DE89C180047F;
	Tue, 29 Apr 2025 12:11:27 +0000 (UTC)
Date: Tue, 29 Apr 2025 20:11:22 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Stefan Haberland <sth@linux.ibm.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V3 00/20] block: unify elevator changing and fix lockdep
 warning
Message-ID: <aBDB6sJS8dVxwe6x@fedora>
References: <20250424152148.1066220-1-ming.lei@redhat.com>
 <0659ea8d-a463-47c8-9180-43c719e106eb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0659ea8d-a463-47c8-9180-43c719e106eb@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Tue, Apr 29, 2025 at 02:00:27PM +0200, Stefan Haberland wrote:
> Am 24.04.25 um 17:21 schrieb Ming Lei:
> 
> > Hello Jens,
> >
> > This patchset cleans up elevator change code, and unifying it via single
> > helper, meantime moves kobject_add/del & debugfs register/unregister out of
> > queue freezing & elevator_lock. This way fixes many lockdep warnings
> > reported recently, especially since fs_reclaim is connected with freeze lock
> > manually by commit ffa1e7ada456 ("block: Make request_queue lockdep splats
> > show up earlier").
> >
> >
> > Thanks,
> > Ming
> >
> > V3:
> > 	- replace srcu with rw_sem for avoiding race between add/del disk &
> > 	  elevator switch and updating nr_hw_queues (Nilay Shoff)
> >
> > 	- add elv_update_nr_hw_queues() for elevator reattachment in case of
> > 	updating nr_hw_queues, meantime keep elv_change_ctx as local structure
> > 	(Christoph)
> >
> > 	- replace ->elevator_lock with disk->rqos_state_mutex for covering wbt
> > 	state change
> >
> > 	- add new patch "block: use q->elevator with ->elevator_lock held in elv_iosched_show()"
> >
> > 	- small cleanup & commit log improvement
> >
> > V2:
> > 	- retry add/del disk when blk_mq_update_nr_hw_queues() is in-progress
> >
> > 	- swap blk_mq_add_queue_tag_set() with blk_mq_map_swqueue() in
> > 	blk_mq_init_allocated_queue() (Nilay Shroff)
> >
> > 	- move ELEVATOR_FLAG_DISABLE_WBT to request queue's flags (Nilay Shoff) 
> >
> > 	- fix race because of delaying elevator unregister
> >
> > 	- define flags of `elv_change_ctx` as `bool` (Christoph)
> >
> > 	- improve comment and commit log (Christoph)
> >
> > Ming Lei (20):
> >   block: move blk_mq_add_queue_tag_set() after blk_mq_map_swqueue()
> >   block: move ELEVATOR_FLAG_DISABLE_WBT a request queue flag
> >   block: don't call freeze queue in elevator_switch() and
> >     elevator_disable()
> >   block: use q->elevator with ->elevator_lock held in elv_iosched_show()
> >   block: add two helpers for registering/un-registering sched debugfs
> >   block: move sched debugfs register into elvevator_register_queue
> >   block: prevent adding/deleting disk during updating nr_hw_queues
> >   block: don't allow to switch elevator if updating nr_hw_queues is
> >     in-progress
> >   block: simplify elevator reattachment for updating nr_hw_queues
> >   block: move blk_unregister_queue() & device_del() after freeze wait
> >   block: move queue freezing & elevator_lock into elevator_change()
> >   block: add `struct elv_change_ctx` for unifying elevator change
> >   block: unifying elevator change
> >   block: pass elevator_queue to elv_register_queue & unregister_queue
> >   block: fail to show/store elevator sysfs attribute if elevator is
> >     dying
> >   block: move elv_register[unregister]_queue out of elevator_lock
> >   block: move debugfs/sysfs register out of freezing queue
> >   block: remove several ->elevator_lock
> >   block: move hctx cpuhp add/del out of queue freezing
> >   block: move wbt_enable_default() out of queue freezing from sched
> >     ->exit()
> >
> >  block/bfq-iosched.c    |   6 +-
> >  block/blk-mq-debugfs.c |  12 +-
> >  block/blk-mq-sched.c   |  41 +++---
> >  block/blk-mq.c         | 132 +++---------------
> >  block/blk-sysfs.c      |  24 ++--
> >  block/blk-wbt.c        |  13 +-
> >  block/blk.h            |   8 +-
> >  block/elevator.c       | 302 ++++++++++++++++++++++++++++-------------
> >  block/elevator.h       |   6 +-
> >  block/genhd.c          | 129 +++++++++++-------
> >  include/linux/blk-mq.h |   3 +
> >  include/linux/blkdev.h |   5 +
> >  12 files changed, 365 insertions(+), 316 deletions(-)
> 
> Hi,
> while testing the patchset on s390 I still get the following lockdep splat on each boot:
> 
> ======================================================
>  WARNING: possible circular locking dependency detected
>  6.15.0-rc4-gc2b4d8dcb3d2 #3 Not tainted
>  ------------------------------------------------------
>  (udev-worker)/1810 is trying to acquire lock:
>  0000005fb84de3a8 (&q->elevator_lock){+.+.}-{4:4}, at: elevator_change+0x54/0x130
> 
>  but task is already holding lock:
>  0000005fb84dde18 (&q->q_usage_counter(io)#34){++++}-{0:0}, at: blk_mq_freeze_queue_nomemsave+0x26/0x40
> 
>  which lock already depends on the new lock.
> 
>  the existing dependency chain (in reverse order) is:
> 
>  -> #3 (&q->q_usage_counter(io)#34){++++}-{0:0}:
>         __lock_acquire+0x6da/0xcc0
>         lock_acquire.part.0+0x10c/0x290
>         lock_acquire+0xb0/0x1a0
>         blk_alloc_queue+0x306/0x340
>         blk_mq_alloc_queue+0x60/0xd0
>         scsi_alloc_sdev+0x27c/0x3b0
>         scsi_probe_and_add_lun+0x31a/0x480
>         scsi_report_lun_scan+0x382/0x430
>         __scsi_scan_target+0x11a/0x240
>         scsi_scan_target+0xdc/0x100
>         fc_scsi_scan_rport+0xc2/0xd0
>         process_one_work+0x2a6/0x5d0
>         worker_thread+0x220/0x410
>         kthread+0x164/0x2d0
>         __ret_from_fork+0x3c/0x60
>         ret_from_fork+0xa/0x38
> 
>  -> #2 (fs_reclaim){+.+.}-{0:0}:
>         __lock_acquire+0x6da/0xcc0
>         lock_acquire.part.0+0x10c/0x290
>         lock_acquire+0xb0/0x1a0
>         __fs_reclaim_acquire+0x44/0x50
>         fs_reclaim_acquire+0xba/0x100
>         __kmalloc_noprof+0xae/0x5e0
>         pcpu_alloc_chunk+0x30/0x170
>         pcpu_create_chunk+0x22/0x130
>         pcpu_alloc_noprof+0x842/0x970
>         do_kmem_cache_create+0x1e0/0x4b0
>         __kmem_cache_create_args+0x238/0x340
>         register_ftrace_graph+0x438/0x460
>         trace_selftest_startup_function_graph+0x62/0x260
>         run_tracer_selftest+0x116/0x1b0
>         register_tracer+0x192/0x260
>         do_one_initcall+0x4a/0x180
>         do_initcalls+0x146/0x170
>         kernel_init_freeable+0x230/0x270
>         kernel_init+0x2e/0x188
>         __ret_from_fork+0x3c/0x60
>         ret_from_fork+0xa/0x38
> 
>  -> #1 (pcpu_alloc_mutex){+.+.}-{4:4}:
>         __lock_acquire+0x6da/0xcc0
>         lock_acquire.part.0+0x10c/0x290
>         lock_acquire+0xb0/0x1a0
>         __mutex_lock+0xae/0xa20
>         mutex_lock_killable_nested+0x32/0x40
>         pcpu_alloc_noprof+0x6ea/0x970

It is one known dependency on percpu alloc lock, and we can't cover every
one in single patchset, especially this patchset is becoming bigger.

And this percpu lock splat becomes much easier to address after the elevator
patchset is merged.

We can move the elevator data allocation out of queue freeze, then the
dependency can be cut.


Thanks
Ming

