Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72B01FDA
	for <linux-block@vger.kernel.org>; Wed, 30 Apr 2025 00:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745974521; cv=none; b=DasGmSv6VkdnU8ihjKfqqcDICWwyO43+UYrP43ajHoU3H9YTNdXUnPoQPfHVUK1pghZuQnF/77nRxZOkHxpG0pqIswz4PtJqQg+zfb/BoS6iOWJVxyCyfStI/yEjW0Y8y2nAgOGif1aO0/BtK9W7GniIdiJmYEgaHcH53EeKJWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745974521; c=relaxed/simple;
	bh=TD0kcv4GMkIEKKivr3jCQJBr+ZJ2u9GlrWNZuW5M8/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GNx6ljCQTrR353K0VS6L1XsF9+8WZUytvJqWAPQb7XtTtwbT9/yG7gce5VG1g1JEB+WRVdesrzXEJg/M4Evu349xwAetraxKupupgVN+fL+M+zE0LfonC/ng2U54M8Gezmdl58cNp6W6kvkVlt+9REavPs6KRpwW7MJzwo5sNNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aqfL/OdX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aqfL/OdX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745974516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iEEOkkC1W7B+XyOpc96ASGD7U+9y28OuV3wF1PzsE5w=;
	b=aqfL/OdX2VDaGpmoRwoITQKwi6OtgTwO8QjFfs9Vhdb6nSjmGaAGBLFJRjjrDFH/35DaK1
	lSN+h6OQCMbLPUzvqUhwKn8b6WBYWvpD4lumMayFRuwTml8e6yNNsqo7Hbf8fsXCQO5LcH
	xmioNl9VVSm1OV/b9uFd8kyzSQWwvFk=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-690-9vhMzbmPMmaKoX4Qoyf_IA-1; Tue,
 29 Apr 2025 20:55:11 -0400
X-MC-Unique: 9vhMzbmPMmaKoX4Qoyf_IA-1
X-Mimecast-MFC-AGG-ID: 9vhMzbmPMmaKoX4Qoyf_IA_1745974510
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 329401956086;
	Wed, 30 Apr 2025 00:55:09 +0000 (UTC)
Received: from fedora (unknown [10.72.116.48])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B674B30001A2;
	Wed, 30 Apr 2025 00:55:04 +0000 (UTC)
Date: Wed, 30 Apr 2025 08:54:59 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V3 08/20] block: don't allow to switch elevator if
 updating nr_hw_queues is in-progress
Message-ID: <aBF044-d-hsx75I6@fedora>
References: <20250424152148.1066220-1-ming.lei@redhat.com>
 <20250424152148.1066220-9-ming.lei@redhat.com>
 <748f3e46-51c1-47f8-8614-64efb30dd4ff@linux.ibm.com>
 <aA2WIiHJprr_bmJ5@fedora>
 <ab875b11-9591-4034-bb11-ed8a35454a75@linux.ibm.com>
 <aBA84hnKcddOff4W@fedora>
 <5e81717f-1b64-4302-b321-c12aee697a0b@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e81717f-1b64-4302-b321-c12aee697a0b@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Tue, Apr 29, 2025 at 03:52:51PM +0530, Nilay Shroff wrote:
> 
> 
> On 4/29/25 8:13 AM, Ming Lei wrote:
> >> I couldn't recreate it on my setup using above blktests.
> > It is reproduced in my test vm every time after killing the nested variant:
> > 
> > [   74.257200] ======================================================
> > [   74.259369] WARNING: possible circular locking dependency detected
> > [   74.260772] 6.15.0-rc3_ublk+ #547 Not tainted
> > [   74.261950] ------------------------------------------------------
> > [   74.263281] check/5077 is trying to acquire lock:
> > [   74.264492] ffff888105f1fd18 (kn->active#119){++++}-{0:0}, at: __kernfs_remove+0x213/0x680
> > [   74.266006]
> >                but task is already holding lock:
> > [   74.267998] ffff88828a661e20 (&q->q_usage_counter(queue)#14){++++}-{0:0}, at: del_gendisk+0xe5/0x180
> > [   74.269631]
> >                which lock already depends on the new lock.
> > 
> > [   74.272645]
> >                the existing dependency chain (in reverse order) is:
> > [   74.274804]
> >                -> #3 (&q->q_usage_counter(queue)#14){++++}-{0:0}:
> > [   74.277009]        blk_queue_enter+0x4c2/0x630
> > [   74.278218]        blk_mq_alloc_request+0x479/0xa00
> > [   74.279539]        scsi_execute_cmd+0x151/0xba0
> > [   74.281078]        sr_check_events+0x1bc/0xa40
> > [   74.283012]        cdrom_check_events+0x5c/0x120
> > [   74.284892]        disk_check_events+0xbe/0x390
> > [   74.286181]        disk_check_media_change+0xf1/0x220
> > [   74.287455]        sr_block_open+0xce/0x230
> > [   74.288528]        blkdev_get_whole+0x8d/0x200
> > [   74.289702]        bdev_open+0x614/0xc60
> > [   74.290882]        blkdev_open+0x1f6/0x360
> > [   74.292215]        do_dentry_open+0x491/0x1820
> > [   74.293309]        vfs_open+0x7a/0x440
> > [   74.294384]        path_openat+0x1b7e/0x2ce0
> > [   74.295507]        do_filp_open+0x1c5/0x450
> > [   74.296616]        do_sys_openat2+0xef/0x180
> > [   74.297667]        __x64_sys_openat+0x10e/0x210
> > [   74.298768]        do_syscall_64+0x92/0x180
> > [   74.299800]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > [   74.300971]
> >                -> #2 (&disk->open_mutex){+.+.}-{4:4}:
> > [   74.302700]        __mutex_lock+0x19c/0x1990
> > [   74.303682]        bdev_open+0x6cd/0xc60
> > [   74.304613]        bdev_file_open_by_dev+0xc4/0x140
> > [   74.306008]        disk_scan_partitions+0x191/0x290
> > [   74.307716]        __add_disk_fwnode+0xd2a/0x1140
> > [   74.309394]        add_disk_fwnode+0x10e/0x220
> > [   74.311039]        nvme_alloc_ns+0x1833/0x2c30
> > [   74.312669]        nvme_scan_ns+0x5a0/0x6f0
> > [   74.314151]        async_run_entry_fn+0x94/0x540
> > [   74.315719]        process_one_work+0x86a/0x14a0
> > [   74.317287]        worker_thread+0x5bb/0xf90
> > [   74.318228]        kthread+0x371/0x720
> > [   74.319085]        ret_from_fork+0x31/0x70
> > [   74.319941]        ret_from_fork_asm+0x1a/0x30
> > [   74.320808]
> >                -> #1 (&set->update_nr_hwq_sema){.+.+}-{4:4}:
> > [   74.322311]        down_read+0x8e/0x470
> > [   74.323135]        elv_iosched_store+0x17a/0x210
> > [   74.324036]        queue_attr_store+0x234/0x340
> > [   74.324881]        kernfs_fop_write_iter+0x39b/0x5a0
> > [   74.325771]        vfs_write+0x5df/0xec0
> > [   74.326514]        ksys_write+0xff/0x200
> > [   74.327262]        do_syscall_64+0x92/0x180
> > [   74.328018]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > [   74.328963]
> >                -> #0 (kn->active#119){++++}-{0:0}:
> > [   74.330433]        __lock_acquire+0x145f/0x2260
> > [   74.331329]        lock_acquire+0x163/0x300
> > [   74.332221]        kernfs_drain+0x39d/0x450
> > [   74.333002]        __kernfs_remove+0x213/0x680
> > [   74.333792]        kernfs_remove_by_name_ns+0xa2/0x100
> > [   74.334589]        remove_files+0x8d/0x1b0
> > [   74.335326]        sysfs_remove_group+0x7c/0x160
> > [   74.336118]        sysfs_remove_groups+0x55/0xb0
> > [   74.336869]        __kobject_del+0x7d/0x1d0
> > [   74.337637]        kobject_del+0x38/0x60
> > [   74.338340]        blk_unregister_queue+0x153/0x2c0
> > [   74.339125]        __del_gendisk+0x252/0x9d0
> > [   74.339959]        del_gendisk+0xe5/0x180
> > [   74.340756]        sr_remove+0x7b/0xd0
> > [   74.341429]        device_release_driver_internal+0x36d/0x520
> > [   74.342353]        bus_remove_device+0x1ef/0x3f0
> > [   74.343172]        device_del+0x3be/0x9b0
> > [   74.343951]        __scsi_remove_device+0x27f/0x340
> > [   74.344724]        sdev_store_delete+0x87/0x120
> > [   74.345508]        kernfs_fop_write_iter+0x39b/0x5a0
> > [   74.346287]        vfs_write+0x5df/0xec0
> > [   74.347170]        ksys_write+0xff/0x200
> > [   74.348312]        do_syscall_64+0x92/0x180
> > [   74.349519]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > [   74.350797]
> >                other info that might help us debug this:
> > 
> > [   74.353554] Chain exists of:
> >                  kn->active#119 --> &disk->open_mutex --> &q->q_usage_counter(queue)#14
> > 
> > [   74.355535]  Possible unsafe locking scenario:
> > 
> > [   74.356650]        CPU0                    CPU1
> > [   74.357328]        ----                    ----
> > [   74.358026]   lock(&q->q_usage_counter(queue)#14);
> > [   74.358749]                                lock(&disk->open_mutex);
> > [   74.359561]                                lock(&q->q_usage_counter(queue)#14);
> > [   74.360488]   lock(kn->active#119);
> > [   74.361113]
> >                 *** DEADLOCK ***
> > 
> > [   74.362574] 6 locks held by check/5077:
> > [   74.363193]  #0: ffff888114640420 (sb_writers#4){.+.+}-{0:0}, at: ksys_write+0xff/0x200
> > [   74.364274]  #1: ffff88829abb6088 (&of->mutex#2){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x25b/0x5a0
> > [   74.365937]  #2: ffff8881176ca0e0 (&shost->scan_mutex){+.+.}-{4:4}, at: sdev_store_delete+0x7f/0x120
> > [   74.367643]  #3: ffff88828521c380 (&dev->mutex){....}-{4:4}, at: device_release_driver_internal+0x90/0x520
> > [   74.369464]  #4: ffff8881176ca380 (&set->update_nr_hwq_sema){.+.+}-{4:4}, at: del_gendisk+0xdd/0x180
> > [   74.370961]  #5: ffff88828a661e20 (&q->q_usage_counter(queue)#14){++++}-{0:0}, at: del_gendisk+0xe5/0x180
> > [   74.372050]
>  
> This has baffled me as I don't understand how could read lock in
> elv_iosched_store (ruuning in context #1) depends on (same) read
> lock in add_disk_fwnode (running under another context #2) as 
> both locks are represented by the same rw semaphore. As we see 

That is why the read lock in elv_iosched_store() is annotated as
nested(new lockdep map) for avoiding the false positive warning, because
the two can't be grabbed at the same time.

> above both elv_iosched_store and add_disk_fwnode bot run under
> different contexts and so ideally they should be able to run
> concurrently acquiring the same read lock.

In theory, it is yes, but reality is that scheduler store attribute
isn't created until disk/queue kobject is added, then switching elevator
can't happen until the kobject/attribute is exposed to userspace, that
is why the nested annotation is correct.


Thanks,
Ming

