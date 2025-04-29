Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9BD7082D
	for <linux-block@vger.kernel.org>; Tue, 29 Apr 2025 02:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745894644; cv=none; b=qcaOI9KPHOmvup0G1apDfMUu4u9PGq8FarRFcgcghtVhAD4kmHL8IqVcboYA1eQzWVbadK3oOiaO0Csg15jRUM5+0QMQrKRuAkSBQjxNNstAP5lDMNS7SGsnR3PsqjNzjHRE+oLCaTG4x+PWFth9xz5yjQyMQJLEqlhEzwYxPQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745894644; c=relaxed/simple;
	bh=MtLPInufosD5FaBR+omFm37rW8yzy56k5h5pDjMmxHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I486R0SzMOmy+1pZem4AVDvdJcffElr07WhFDjGoj49zUBAW6gmjMRVIyIrvXNhAikym0u7hwZdwlbjp8nQ3oA76bGyzgoaCtbaR/rZMXfGksmXmjIBaI3v1fgZG1iNuiLjZhXPeh6E27bS2kG8tDsKscWaOfwbChT4a8vT9Ejo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XzS28H8F; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XzS28H8F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745894640;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yIy5HGlxXwG8pEnHxCZLEvpj1YieoDaBsEwqZCIhTmg=;
	b=XzS28H8Fud1E74eRGCgQEZ4XNakez8leowCssORUH14d9vXnac/NL8OK/IjODW9PuTwVMT
	C46nJPqANLyijds8xu8MiMUHakDeKZdV4DIgc6VKVaKCLObXu4AO4L1aktqCD6mGGnLdVd
	enob5LIqMgNwhbdGsviLa1G7fwYleVM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-619-wsftAdA9N8Caucl0GuYp1Q-1; Mon,
 28 Apr 2025 22:43:57 -0400
X-MC-Unique: wsftAdA9N8Caucl0GuYp1Q-1
X-Mimecast-MFC-AGG-ID: wsftAdA9N8Caucl0GuYp1Q_1745894636
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C7B4D19560AA;
	Tue, 29 Apr 2025 02:43:55 +0000 (UTC)
Received: from fedora (unknown [10.72.116.57])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 85D63180045C;
	Tue, 29 Apr 2025 02:43:51 +0000 (UTC)
Date: Tue, 29 Apr 2025 10:43:46 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V3 08/20] block: don't allow to switch elevator if
 updating nr_hw_queues is in-progress
Message-ID: <aBA84hnKcddOff4W@fedora>
References: <20250424152148.1066220-1-ming.lei@redhat.com>
 <20250424152148.1066220-9-ming.lei@redhat.com>
 <748f3e46-51c1-47f8-8614-64efb30dd4ff@linux.ibm.com>
 <aA2WIiHJprr_bmJ5@fedora>
 <ab875b11-9591-4034-bb11-ed8a35454a75@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab875b11-9591-4034-bb11-ed8a35454a75@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Mon, Apr 28, 2025 at 09:47:02PM +0530, Nilay Shroff wrote:
> 
> 
> On 4/27/25 7:57 AM, Ming Lei wrote:
> > On Fri, Apr 25, 2025 at 06:18:33PM +0530, Nilay Shroff wrote:
> >>
> >>
> >> On 4/24/25 8:51 PM, Ming Lei wrote:
> >>> Elevator switch code is another `nr_hw_queue` reader in non-fast-IO code
> >>> path, so it can't be done if updating `nr_hw_queues` is in-progress.
> >>>
> >>> Take same approach with not allowing add/del disk when updating
> >>> nr_hw_queues is in-progress, by grabbing read lock of
> >>> set->update_nr_hwq_sema.
> >>>
> >>> Take the nested variant for avoiding the following false positive
> >>> splat[1], and this way is correct because:
> >>>
> >>> - the read lock in elv_iosched_store() is not overlapped with the read lock
> >>> in adding/deleting disk:
> >>>
> >>> - kobject attribute is only available after the kobject is added and
> >>> before it is deleted
> >>>
> >>>   -> #4 (&q->q_usage_counter(queue){++++}-{0:0}:
> >>>   -> #3 (&q->limits_lock){+.+.}-{4:4}:
> >>>   -> #2 (&disk->open_mutex){+.+.}-{4:4}:
> >>>   -> #1 (&set->update_nr_hwq_lock){.+.+}-{4:4}:
> >>>   -> #0 (kn->active#103){++++}-{0:0}:
> >>>
> >>> Link: https://lore.kernel.org/linux-block/aAWv3NPtNIKKvJZc@fedora/ [1]
> >>> Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> >>> Closes: https://lore.kernel.org/linux-block/mz4t4tlwiqjijw3zvqnjb7ovvvaegkqganegmmlc567tt5xj67@xal5ro544cnc/
> >>> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> >>> ---
> >>>  block/elevator.c | 3 +++
> >>>  1 file changed, 3 insertions(+)
> >>>
> >>> diff --git a/block/elevator.c b/block/elevator.c
> >>> index 4400eb8fe54f..56da6ab7691a 100644
> >>> --- a/block/elevator.c
> >>> +++ b/block/elevator.c
> >>> @@ -723,6 +723,7 @@ ssize_t elv_iosched_store(struct gendisk *disk, const char *buf,
> >>>  	int ret;
> >>>  	unsigned int memflags;
> >>>  	struct request_queue *q = disk->queue;
> >>> +	struct blk_mq_tag_set *set = q->tag_set;
> >>>  
> >>>  	/*
> >>>  	 * If the attribute needs to load a module, do it before freezing the
> >>> @@ -734,6 +735,7 @@ ssize_t elv_iosched_store(struct gendisk *disk, const char *buf,
> >>>  
> >>>  	elv_iosched_load_module(name);
> >>>  
> >>> +	down_read_nested(&set->update_nr_hwq_sema, 1);
> >>
> >> Why do we need to add nested read lock here? The lockdep splat[1] which
> >> you reported earlier is possibly due to the same reader lock being acquired
> >> recursively in elv_iosched_store and then elevator_change? 
> > 
> > The splat isn't related with the nested read lock.
> > 
> > If you replace down_read_nested() with down_read(), the same splat can be
> > triggered again when running `blktests block/001`.
> > 
> I couldn't recreate it on my setup using above blktests.

It is reproduced in my test vm every time after killing the nested variant:

[   74.257200] ======================================================
[   74.259369] WARNING: possible circular locking dependency detected
[   74.260772] 6.15.0-rc3_ublk+ #547 Not tainted
[   74.261950] ------------------------------------------------------
[   74.263281] check/5077 is trying to acquire lock:
[   74.264492] ffff888105f1fd18 (kn->active#119){++++}-{0:0}, at: __kernfs_remove+0x213/0x680
[   74.266006]
               but task is already holding lock:
[   74.267998] ffff88828a661e20 (&q->q_usage_counter(queue)#14){++++}-{0:0}, at: del_gendisk+0xe5/0x180
[   74.269631]
               which lock already depends on the new lock.

[   74.272645]
               the existing dependency chain (in reverse order) is:
[   74.274804]
               -> #3 (&q->q_usage_counter(queue)#14){++++}-{0:0}:
[   74.277009]        blk_queue_enter+0x4c2/0x630
[   74.278218]        blk_mq_alloc_request+0x479/0xa00
[   74.279539]        scsi_execute_cmd+0x151/0xba0
[   74.281078]        sr_check_events+0x1bc/0xa40
[   74.283012]        cdrom_check_events+0x5c/0x120
[   74.284892]        disk_check_events+0xbe/0x390
[   74.286181]        disk_check_media_change+0xf1/0x220
[   74.287455]        sr_block_open+0xce/0x230
[   74.288528]        blkdev_get_whole+0x8d/0x200
[   74.289702]        bdev_open+0x614/0xc60
[   74.290882]        blkdev_open+0x1f6/0x360
[   74.292215]        do_dentry_open+0x491/0x1820
[   74.293309]        vfs_open+0x7a/0x440
[   74.294384]        path_openat+0x1b7e/0x2ce0
[   74.295507]        do_filp_open+0x1c5/0x450
[   74.296616]        do_sys_openat2+0xef/0x180
[   74.297667]        __x64_sys_openat+0x10e/0x210
[   74.298768]        do_syscall_64+0x92/0x180
[   74.299800]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   74.300971]
               -> #2 (&disk->open_mutex){+.+.}-{4:4}:
[   74.302700]        __mutex_lock+0x19c/0x1990
[   74.303682]        bdev_open+0x6cd/0xc60
[   74.304613]        bdev_file_open_by_dev+0xc4/0x140
[   74.306008]        disk_scan_partitions+0x191/0x290
[   74.307716]        __add_disk_fwnode+0xd2a/0x1140
[   74.309394]        add_disk_fwnode+0x10e/0x220
[   74.311039]        nvme_alloc_ns+0x1833/0x2c30
[   74.312669]        nvme_scan_ns+0x5a0/0x6f0
[   74.314151]        async_run_entry_fn+0x94/0x540
[   74.315719]        process_one_work+0x86a/0x14a0
[   74.317287]        worker_thread+0x5bb/0xf90
[   74.318228]        kthread+0x371/0x720
[   74.319085]        ret_from_fork+0x31/0x70
[   74.319941]        ret_from_fork_asm+0x1a/0x30
[   74.320808]
               -> #1 (&set->update_nr_hwq_sema){.+.+}-{4:4}:
[   74.322311]        down_read+0x8e/0x470
[   74.323135]        elv_iosched_store+0x17a/0x210
[   74.324036]        queue_attr_store+0x234/0x340
[   74.324881]        kernfs_fop_write_iter+0x39b/0x5a0
[   74.325771]        vfs_write+0x5df/0xec0
[   74.326514]        ksys_write+0xff/0x200
[   74.327262]        do_syscall_64+0x92/0x180
[   74.328018]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   74.328963]
               -> #0 (kn->active#119){++++}-{0:0}:
[   74.330433]        __lock_acquire+0x145f/0x2260
[   74.331329]        lock_acquire+0x163/0x300
[   74.332221]        kernfs_drain+0x39d/0x450
[   74.333002]        __kernfs_remove+0x213/0x680
[   74.333792]        kernfs_remove_by_name_ns+0xa2/0x100
[   74.334589]        remove_files+0x8d/0x1b0
[   74.335326]        sysfs_remove_group+0x7c/0x160
[   74.336118]        sysfs_remove_groups+0x55/0xb0
[   74.336869]        __kobject_del+0x7d/0x1d0
[   74.337637]        kobject_del+0x38/0x60
[   74.338340]        blk_unregister_queue+0x153/0x2c0
[   74.339125]        __del_gendisk+0x252/0x9d0
[   74.339959]        del_gendisk+0xe5/0x180
[   74.340756]        sr_remove+0x7b/0xd0
[   74.341429]        device_release_driver_internal+0x36d/0x520
[   74.342353]        bus_remove_device+0x1ef/0x3f0
[   74.343172]        device_del+0x3be/0x9b0
[   74.343951]        __scsi_remove_device+0x27f/0x340
[   74.344724]        sdev_store_delete+0x87/0x120
[   74.345508]        kernfs_fop_write_iter+0x39b/0x5a0
[   74.346287]        vfs_write+0x5df/0xec0
[   74.347170]        ksys_write+0xff/0x200
[   74.348312]        do_syscall_64+0x92/0x180
[   74.349519]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   74.350797]
               other info that might help us debug this:

[   74.353554] Chain exists of:
                 kn->active#119 --> &disk->open_mutex --> &q->q_usage_counter(queue)#14

[   74.355535]  Possible unsafe locking scenario:

[   74.356650]        CPU0                    CPU1
[   74.357328]        ----                    ----
[   74.358026]   lock(&q->q_usage_counter(queue)#14);
[   74.358749]                                lock(&disk->open_mutex);
[   74.359561]                                lock(&q->q_usage_counter(queue)#14);
[   74.360488]   lock(kn->active#119);
[   74.361113]
                *** DEADLOCK ***

[   74.362574] 6 locks held by check/5077:
[   74.363193]  #0: ffff888114640420 (sb_writers#4){.+.+}-{0:0}, at: ksys_write+0xff/0x200
[   74.364274]  #1: ffff88829abb6088 (&of->mutex#2){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x25b/0x5a0
[   74.365937]  #2: ffff8881176ca0e0 (&shost->scan_mutex){+.+.}-{4:4}, at: sdev_store_delete+0x7f/0x120
[   74.367643]  #3: ffff88828521c380 (&dev->mutex){....}-{4:4}, at: device_release_driver_internal+0x90/0x520
[   74.369464]  #4: ffff8881176ca380 (&set->update_nr_hwq_sema){.+.+}-{4:4}, at: del_gendisk+0xdd/0x180
[   74.370961]  #5: ffff88828a661e20 (&q->q_usage_counter(queue)#14){++++}-{0:0}, at: del_gendisk+0xe5/0x180
[   74.372050]
               stack backtrace:
[   74.373111] CPU: 10 UID: 0 PID: 5077 Comm: check Not tainted 6.15.0-rc3_ublk+ #547 PREEMPT(voluntary)
[   74.373116] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-1.fc39 04/01/2014
[   74.373118] Call Trace:
[   74.373121]  <TASK>
[   74.373123]  dump_stack_lvl+0x84/0xd0
[   74.373129]  print_circular_bug.cold+0x185/0x1d0
[   74.373134]  check_noncircular+0x14a/0x170
[   74.373140]  __lock_acquire+0x145f/0x2260
[   74.373145]  lock_acquire+0x163/0x300
[   74.373149]  ? __kernfs_remove+0x213/0x680
[   74.373155]  kernfs_drain+0x39d/0x450
[   74.373158]  ? __kernfs_remove+0x213/0x680
[   74.373161]  ? __pfx_kernfs_drain+0x10/0x10
[   74.373165]  ? find_held_lock+0x2b/0x80
[   74.373168]  ? kernfs_root+0xb0/0x1c0
[   74.373173]  __kernfs_remove+0x213/0x680
[   74.373176]  ? kernfs_find_ns+0x197/0x390
[   74.373183]  kernfs_remove_by_name_ns+0xa2/0x100
[   74.373186]  remove_files+0x8d/0x1b0
[   74.373191]  sysfs_remove_group+0x7c/0x160
[   74.373194]  sysfs_remove_groups+0x55/0xb0
[   74.373198]  __kobject_del+0x7d/0x1d0
[   74.373203]  kobject_del+0x38/0x60
[   74.373206]  blk_unregister_queue+0x153/0x2c0
[   74.373210]  __del_gendisk+0x252/0x9d0
[   74.373214]  ? down_read+0x1a7/0x470
[   74.373218]  ? __pfx___del_gendisk+0x10/0x10
[   74.373221]  ? __pfx_down_read+0x10/0x10
[   74.373224]  ? lockdep_hardirqs_on_prepare+0xdb/0x190
[   74.373227]  ? trace_hardirqs_on+0x18/0x150
[   74.373231]  del_gendisk+0xe5/0x180
[   74.373235]  sr_remove+0x7b/0xd0
[   74.373239]  device_release_driver_internal+0x36d/0x520
[   74.373243]  ? kobject_put+0x5e/0x4a0
[   74.373246]  bus_remove_device+0x1ef/0x3f0
[   74.373250]  device_del+0x3be/0x9b0
[   74.373254]  ? attribute_container_device_trigger+0x181/0x1f0
[   74.373257]  ? __pfx_device_del+0x10/0x10
[   74.373260]  ? __pfx_attribute_container_device_trigger+0x10/0x10
[   74.373264]  __scsi_remove_device+0x27f/0x340
[   74.373267]  sdev_store_delete+0x87/0x120
[   74.373270]  ? __pfx_sysfs_kf_write+0x10/0x10
[   74.373273]  kernfs_fop_write_iter+0x39b/0x5a0
[   74.373276]  ? __pfx_kernfs_fop_write_iter+0x10/0x10
[   74.373278]  vfs_write+0x5df/0xec0
[   74.373282]  ? trace_hardirqs_on+0x18/0x150
[   74.373285]  ? __pfx_vfs_write+0x10/0x10
[   74.373291]  ksys_write+0xff/0x200
[   74.373295]  ? __pfx_ksys_write+0x10/0x10
[   74.373298]  ? fput_close_sync+0xd6/0x160
[   74.373303]  do_syscall_64+0x92/0x180
[   74.373309]  ? trace_hardirqs_on_prepare+0x101/0x150
[   74.373313]  ? lockdep_hardirqs_on_prepare+0xdb/0x190
[   74.373317]  ? syscall_exit_to_user_mode+0x97/0x290
[   74.373322]  ? do_syscall_64+0x9f/0x180
[   74.373330]  ? fput_close+0xd6/0x160
[   74.373333]  ? __pfx_fput_close+0x10/0x10
[   74.373338]  ? filp_close+0x25/0x40
[   74.373341]  ? do_dup2+0x287/0x4f0
[   74.373346]  ? trace_hardirqs_on_prepare+0x101/0x150
[   74.373348]  ? lockdep_hardirqs_on_prepare+0xdb/0x190
[   74.373351]  ? syscall_exit_to_user_mode+0x97/0x290
[   74.373353]  ? do_syscall_64+0x9f/0x180
[   74.373357]  ? trace_hardirqs_on_prepare+0x101/0x150
[   74.373359]  ? lockdep_hardirqs_on_prepare+0xdb/0x190
[   74.373362]  ? syscall_exit_to_user_mode+0x97/0x290
[   74.373364]  ? do_syscall_64+0x9f/0x180
[   74.373368]  ? do_syscall_64+0x9f/0x180
[   74.373371]  ? trace_hardirqs_on_prepare+0x101/0x150
[   74.373373]  ? lockdep_hardirqs_on_prepare+0xdb/0x190
[   74.373376]  ? syscall_exit_to_user_mode+0x97/0x290
[   74.373379]  ? do_syscall_64+0x9f/0x180
[   74.373382]  ? do_syscall_64+0x9f/0x180
[   74.373385]  ? clear_bhb_loop+0x35/0x90
[   74.373388]  ? clear_bhb_loop+0x35/0x90
[   74.373390]  ? clear_bhb_loop+0x35/0x90
[   74.373393]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   74.373396] RIP: 0033:0x7fa3873a8756
[   74.373409] Code: 5d e8 41 8b 93 08 03 00 00 59 5e 48 83 f8 fc 75 19 83 e2 39 83 fa 08 75 11 e8 26 ff ff ff 66 0f 1f 44 00 00 48 8b 45 10 0f 05 <48> 8b 5d f8 c9 c3 0f 1f 40 00 f3 0f 1e fa 55 48 89 e5 48 83 ec 08
[   74.373412] RSP: 002b:00007ffede0285d0 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
[   74.373416] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007fa3873a8756
[   74.373418] RDX: 0000000000000002 RSI: 000056557b3dc7d0 RDI: 0000000000000001
[   74.373420] RBP: 00007ffede0285f0 R08: 0000000000000000 R09: 0000000000000000
[   74.373421] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000002
[   74.373423] R13: 000056557b3dc7d0 R14: 00007fa3875245c0 R15: 0000000000000000
[   74.373428]  </TASK>



> 
> >>  
> >> On another note, if we suspect possible one-depth recursion for the same 
> >> class of lock then then we should use SINGLE_DEPTH_NESTING (instead of using
> >> 1 here) for subclass. But still I am not clear why this lock needs nesting.
> > 
> > It is just one false positive, because elv_iosched_store() won't happen
> > when adding disk.
> > 
> Yes, but how could we avoid false positive? It's probably because of commit 
> ffa1e7ada456 ("block: Make request_queue lockdep splats show up earlier"). How about adding manual dependency of fs-reclaim on freeze-lock after we add 
> the disk. Currently that manual dependency is added in blk_alloc_queue.

Please see the above trace, which isn't related with commit ffa1e7ada456,
and the lock chain doesn't include 'fs_reclaim' at all.

commit ffa1e7ada456 isn't wrong too, which just helps us to expose deadlock
risk early.

Thanks,
Ming

