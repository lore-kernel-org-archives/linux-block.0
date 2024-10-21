Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C7B1E3787
	for <linux-block@vger.kernel.org>; Mon, 21 Oct 2024 11:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729509475; cv=none; b=NvaV/XNBUrzvYqgcyOmMAfwttsErKdoPTgto6/Rb+rS/690CwifYAMuORGtKvXns8X78WZNXM5WL8carpgXWuHw0rtn2HvYgRXPtJKrQ1mIJjClMHJL3AwHGx4HH79P4Qta8Rlc+boYGY463aiIzsJAXLMFcJ+PbhcHfyCYZm7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729509475; c=relaxed/simple;
	bh=6PThzHUbqT3JPdtkSqCE42PU4uH4/Nzh2DK0AN24emQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eKe9ogDaFQ8Dn+n9kSjVp3/nfWjXVjdk0GousMMLRJCSgftP6JGb97lDqLGQZ+XLWBlmtO7ajQyXvpy1OTVUv0raoty6MmX5dNrySqKiZMNSIYYDpbQ/hjHpo/U6I6DLz7J2myjfmPTkMDePEIfLTXWYAzR3+dhRoA//oPM+3XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=irCoKxDP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="irCoKxDP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729509472;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CwmBZWzQ3OHR30XgKTTXHqysebgwgh7u/eCr9Z2nxEY=;
	b=irCoKxDPaLxQUrpoFX4g4biLNrR4/XjhUmrv36YZj/KlV3v9MGsq5jZdza1Ho1hIN9up1D
	G+uuv5ZXdluxUY0SulaaPlailQLx/i3eq3y7Z0nstYgHQ9c9d5zteKvd5KxGdqPYEnpjSU
	rDTP5trF3asDWXlJqGW0aU+mNYKs9BI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-255-F9WSyOJ2NzeBJIRReHkxAQ-1; Mon,
 21 Oct 2024 07:17:48 -0400
X-MC-Unique: F9WSyOJ2NzeBJIRReHkxAQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9168B1956080;
	Mon, 21 Oct 2024 11:17:47 +0000 (UTC)
Received: from fedora (unknown [10.72.116.104])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7F3CD1956056;
	Mon, 21 Oct 2024 11:17:44 +0000 (UTC)
Date: Mon, 21 Oct 2024 19:17:39 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] block: model freeze & enter queue as rwsem for
 supporting lockdep
Message-ID: <ZxY4U2nTkRhV3NWL@fedora>
References: <20241018013542.3013963-1-ming.lei@redhat.com>
 <4f4cdf6a-e1d3-4e0c-bb57-9cbe767ac112@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f4cdf6a-e1d3-4e0c-bb57-9cbe767ac112@kernel.dk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Sat, Oct 19, 2024 at 04:46:13PM -0600, Jens Axboe wrote:
> On 10/17/24 7:35 PM, Ming Lei wrote:
> > Recently we got several deadlock report[1][2][3] caused by blk_mq_freeze_queue
> > and blk_enter_queue().
> > 
> > Turns out the two are just like one rwsem, so model them as rwsem for
> > supporting lockdep:
> > 
> > 1) model blk_mq_freeze_queue() as down_write_trylock()
> > - it is exclusive lock, so dependency with blk_enter_queue() is covered
> > - it is trylock because blk_mq_freeze_queue() are allowed to run concurrently
> > 
> > 2) model blk_enter_queue() as down_read()
> > - it is shared lock, so concurrent blk_enter_queue() are allowed
> > - it is read lock, so dependency with blk_mq_freeze_queue() is modeled
> > - blk_queue_exit() is often called from other contexts(such as irq), and
> > it can't be annotated as rwsem_release(), so simply do it in
> > blk_enter_queue(), this way still covered cases as many as possible
> > 
> > NVMe is the only subsystem which may call blk_mq_freeze_queue() and
> > blk_mq_unfreeze_queue() from different context, so it is the only
> > exception for the modeling. Add one tagset flag to exclude it from
> > the lockdep support.
> > 
> > With lockdep support, such kind of reports may be reported asap and
> > needn't wait until the real deadlock is triggered.
> 
> I think this is a great idea. We've had way too many issues in this
> area, getting lockdep to grok it (and report issues) is the ideal way to
> avoid that, and even find issues we haven't come across yet.

So far, one main false positive is that the modeling becomes not
correct when calling blk_queue_start_drain() with setting disk state as
GD_DEAD or queue as QUEUE_FLAG_DYING, since __bio_queue_enter() or
blk_queue_enter() can return immediately in this situation.


[  281.645392] ======================================================
[  281.647189] WARNING: possible circular locking dependency detected
[  281.648770] 6.11.0_nbd+ #405 Not tainted
[  281.649171] ------------------------------------------------------
[  281.649668] nvme/10551 is trying to acquire lock:
[  281.650100] ffff938a5717e3e0 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at: __flush_work+0x1d6/0x4d0
[  281.650771]
               but task is already holding lock:
[  281.651442] ffff938a12206c48 (q->q_usage_counter){++++}-{0:0}, at: blk_queue_start_drain+0x12/0x40
[  281.652085]
               which lock already depends on the new lock.

[  281.653061]
               the existing dependency chain (in reverse order) is:
[  281.653820]
               -> #1 (q->q_usage_counter){++++}-{0:0}:
[  281.654525]        blk_try_enter_queue+0xc7/0x230
[  281.654951]        __submit_bio+0xa7/0x190
[  281.655339]        submit_bio_noacct_nocheck+0x1b2/0x400
[  281.655779]        __block_write_full_folio+0x1e7/0x400
[  281.656212]        write_cache_pages+0x62/0xb0
[  281.656608]        blkdev_writepages+0x56/0x90
[  281.657007]        do_writepages+0x76/0x270
[  281.657389]        __writeback_single_inode+0x5b/0x4c0
[  281.657813]        writeback_sb_inodes+0x22e/0x550
[  281.658220]        __writeback_inodes_wb+0x4c/0xf0
[  281.658617]        wb_writeback+0x193/0x3f0
[  281.658995]        wb_workfn+0x343/0x530
[  281.659353]        process_one_work+0x212/0x700
[  281.659739]        worker_thread+0x1ce/0x380
[  281.660118]        kthread+0xd2/0x110
[  281.660460]        ret_from_fork+0x31/0x50
[  281.660818]        ret_from_fork_asm+0x1a/0x30
[  281.661192]
               -> #0 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}:
[  281.661876]        __lock_acquire+0x15c0/0x23e0
[  281.662254]        lock_acquire+0xd8/0x300
[  281.662603]        __flush_work+0x1f2/0x4d0
[  281.662954]        wb_shutdown+0xa1/0xd0
[  281.663285]        bdi_unregister+0x92/0x250
[  281.663632]        del_gendisk+0x37b/0x3a0
[  281.664017]        nvme_mpath_shutdown_disk+0x58/0x60 [nvme_core]
[  281.664453]        nvme_ns_remove+0x17f/0x210 [nvme_core]
[  281.664854]        nvme_remove_namespaces+0xf7/0x150 [nvme_core]
[  281.665304]        nvme_do_delete_ctrl+0x71/0x90 [nvme_core]
[  281.665728]        nvme_delete_ctrl_sync+0x3f/0x50 [nvme_core]
[  281.666159]        nvme_sysfs_delete+0x38/0x50 [nvme_core]
[  281.666569]        kernfs_fop_write_iter+0x15c/0x210
[  281.666953]        vfs_write+0x2a7/0x540
[  281.667281]        ksys_write+0x75/0x100
[  281.667607]        do_syscall_64+0x95/0x180
[  281.667948]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  281.668352]
               other info that might help us debug this:

[  281.669122]  Possible unsafe locking scenario:

[  281.669671]        CPU0                    CPU1
[  281.670019]        ----                    ----
[  281.670358]   lock(q->q_usage_counter);
[  281.670676]                                lock((work_completion)(&(&wb->dwork)->work));
[  281.671186]                                lock(q->q_usage_counter);
[  281.671628]   lock((work_completion)(&(&wb->dwork)->work));
[  281.672056]
                *** DEADLOCK ***



thanks,
Ming

