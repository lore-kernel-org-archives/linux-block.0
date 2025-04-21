Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3221ADC93
	for <linux-block@vger.kernel.org>; Mon, 21 Apr 2025 02:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745203181; cv=none; b=JFMklTt2N9l/1giqK5VA64F8Rmj+zzCP/k3wzswym6DnfCgGkOOIrtGO/ISOV1jy3BLHQccn9gF4fzBsz8wtB/34E74aJBM8SOOsOn+of7Ul8nefyVd+dFLzycJQF9D6AN2r8KWp3ZEOofMPh1JM1yT5Xk9sIMNuLAUSEZ3z8j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745203181; c=relaxed/simple;
	bh=sxTXiS/W09kJvmHKYtgPclKQJukRSgtaP8fcncOYXs0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T/6ZET4Hn+06PvxhQszkFi5jrElfLoI/bjGBkh3HJKPrAvCKTTg1D/TNLYFNMkUuJ9vBmilnRabkMRxnfiY8oM+9mQkgJ1BUyE4AQb7yuxCxeo5j8z43q/d83sb/4T2n1+kgc6uk9NlTqy9FE6zffPFnm9JS9ci+pPLkRZq9IHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YmKxjQr/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YmKxjQr/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745203178;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y0JiguFtjAOZvxBCJ51hNJyhZ2TrHEL2gm4mV2FKmko=;
	b=YmKxjQr/TuYCRJfLJZyQ35+JLKJTbnf6HSlxQ1se6EBanb9xDbZhGbflN4U4inaHU2RYOr
	royAGX+iLP/iEiorgeVNQdmmGS2RFgyGM6O4JI8W/ycfZBKJ3dJIQRbBCeBdBfrha41QmW
	aDUll59xwaeWAUBul4MYH/OpuMV9HuE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-499-LxGV6AFSO6up3D3vcexOgw-1; Sun,
 20 Apr 2025 22:39:36 -0400
X-MC-Unique: LxGV6AFSO6up3D3vcexOgw-1
X-Mimecast-MFC-AGG-ID: LxGV6AFSO6up3D3vcexOgw_1745203175
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4480F1956087;
	Mon, 21 Apr 2025 02:39:34 +0000 (UTC)
Received: from fedora (unknown [10.72.116.114])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 684031800D9E;
	Mon, 21 Apr 2025 02:39:28 +0000 (UTC)
Date: Mon, 21 Apr 2025 10:39:24 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V2 07/20] block: prevent adding/deleting disk during
 updating nr_hw_queues
Message-ID: <aAWv3NPtNIKKvJZc@fedora>
References: <20250418163708.442085-1-ming.lei@redhat.com>
 <20250418163708.442085-8-ming.lei@redhat.com>
 <094c312a-38ec-4c5b-9db3-2269c37de36a@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <094c312a-38ec-4c5b-9db3-2269c37de36a@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Sat, Apr 19, 2025 at 04:50:15PM +0530, Nilay Shroff wrote:
> 
> 
> On 4/18/25 10:06 PM, Ming Lei wrote:
> > Both adding/deleting disk code are reader of `nr_hw_queues`, so we can't
> > allow them in-progress when updating nr_hw_queues, kernel panic and
> > kasan has been reported in [1].
> > 
> > Prevent adding/deleting disk during updating nr_hw_queues by setting
> > set->updating_nr_hwq, and use SRCU to fail & retry to add/delete disk.
> > 
> > This way avoids lot of trouble.
> > 
> > Reported-by: Nilay Shroff <nilay@linux.ibm.com>
> > Closes: https://lore.kernel.org/linux-block/a5896cdb-a59a-4a37-9f99-20522f5d2987@linux.ibm.com/
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> [...]
> [...]
> >  
> > +static int retry_on_updating_nr_hwq(struct gendisk_data *data,
> > +				    int (*cb)(struct gendisk_data *data))
> > +{
> > +	struct gendisk *disk = data->disk;
> > +	struct blk_mq_tag_set *set;
> > +
> > +	if (!queue_is_mq(disk->queue))
> > +		return cb(data);
> > +
> > +	set = disk->queue->tag_set;
> > +	do {
> > +		int idx, ret;
> > +
> > +		idx = srcu_read_lock(&set->update_nr_hwq_srcu);
> > +		if (set->updating_nr_hwq) {
> > +			srcu_read_unlock(&set->update_nr_hwq_srcu, idx);
> > +			goto wait;
> > +		}
> > +		ret = cb(data);
> > +		srcu_read_unlock(&set->update_nr_hwq_srcu, idx);
> > +		return ret;
> > + wait:
> > +		wait_event_interruptible(set->update_nr_hwq_wq,
> > +				!set->updating_nr_hwq);
> > +	} while (true);
> > +}
> > +
> Yes using srcu with wait event would fix this. However after looking through 
> changes it seems to me that the current changes are now modeled as below:
> 
> - Writer(blk_mq_update_nr_hw_queues) must wait until all readers are done 
>   (or prior SRCU read-side critical-section complete)
> - Readers (add/del disk) must wait until a writer(blk_mq_update_nr_hw_queues)
>   finishes
> 
> And IMO, this behavior is best modeled with a reader-writer lock, rather than 
> (S)RCU. 
> 
> In my view, RCU is optimized for read-heavy workloads with:
> - Non-blocking readers

srcu allows blocking reader

> - Deferred updates by writers
> - Writers don’t block readers and readers don’t block writers.
> 
> So I believe the simpler choice shall be using reader-writer lock instead of srcu. 
> With reader-writer lock we should be also able to get away with implementing wait 
> queue for add/del disk. Moreover, the reader-writer lock shall also work well with 
> the another reader elv_iosched_store. 

Basically I agree with you that rwsem(instead of rwlock) should match with
this case in theory, but I feel that rwsem is stronger than srcu from lock
viewpoint, and we will add new dependency if rwsem is held inside
->store(), such as the following splat.


[   93.214889] ======================================================
[   93.219162] scsi 10:0:0:0: Direct-Access     Linux    scsi_debug       0191 PQ: 0 ANSI: 7
[   93.219549] WARNING: possible circular locking dependency detected
[   93.219557] 6.15.0-rc2_ublk+ #536 Not tainted
[   93.219565] ------------------------------------------------------
[   93.219568] check/1690 is trying to acquire lock:
[   93.222730] sd 9:0:0:0: [sdc] Synchronizing SCSI cache
[   93.223139] ffff8882ad849598
[   93.224074] scsi 10:0:0:0: Power-on or device reset occurred
[   93.227331] scsi 9:0:0:0: Direct-Access     Linux    scsi_debug       0191 PQ: 0 ANSI: 7
[   93.227581]  (kn->active#103){++++}-{0:0}, at: __kernfs_remove+0x213/0x680
[   93.231428] scsi 9:0:0:0: Power-on or device reset occurred
[   93.231890]
               but task is already holding lock:
[   93.231897] ffff88828ef358a0 (&q->q_usage_counter(queue)#14
[   93.232621] sd 10:0:0:0: Attached scsi generic sg3 type 0
[   93.234640] sd 10:0:0:0: [sdc] 16384 512-byte logical blocks: (8.39 MB/8.00 MiB)
[   93.235975] ){++++}-{0:0}, at: del_gendisk+0x186/0x250
[   93.238123] sd 10:0:0:0: [sdc] Write Protect is off
[   93.239546]
               which lock already depends on the new lock.

[   93.239552]
               the existing dependency chain (in reverse order) is:
[   93.239556]
               -> #4 (&q->q_usage_counter(queue)
[   93.240114] sd 9:0:0:0: Attached scsi generic sg3 type 0
[   93.240963] sd 10:0:0:0: [sdc] Mode Sense: 00 00 00 00
[   93.241757] sd 9:0:0:0: [sde] 16384 512-byte logical blocks: (8.39 MB/8.00 MiB)
[   93.242387] #14){++++}-{0:0}:
[   93.242404]        blk_queue_enter+0x4c9/0x640
[   93.242916] sd 9:0:0:0: [sde] Write Protect is off
[   93.242948] sd 9:0:0:0: [sde] Mode Sense: 73 00 10 08
[   93.243028] sd 9:0:0:0: [sde] Asking for cache data failed
[   93.243057] sd 9:0:0:0: [sde] Assuming drive cache: write through
[   93.243120] sd 9:0:0:0: [sde] Unexpected: RSCS has been set and the permanent stream count is 0
[   93.243255] sd 9:0:0:0: [sde] Preferred minimum I/O size 512 bytes
[   93.243284] sd 9:0:0:0: [sde] Optimal transfer size 524288 bytes
[   93.243568] sd 10:0:0:0: [sdc] Asking for cache data failed
[   93.244771]        blk_mq_alloc_request+0x4ae/0x8d0
[   93.244786]        scsi_execute_cmd+0x196/0xcf0
[   93.246604] sd 10:0:0:0: [sdc] Assuming drive cache: write through
[   93.247875]        read_capacity_16+0x1cf/0xbf0
[   93.247891]        sd_revalidate_disk.isra.0+0x15c0/0x8f50
[   93.249239] sd 10:0:0:0: [sdc] Unexpected: RSCS has been set and the permanent stream count is 0
[   93.251084]        sd_probe+0x815/0xf20
[   93.251098]        really_probe+0x1e0/0x930
[   93.252235] sd 10:0:0:0: [sdc] Preferred minimum I/O size 512 bytes
[   93.253608]        __driver_probe_device+0x18c/0x3d0
[   93.253623]        driver_probe_device+0x4a/0x120
[   93.253633]        __device_attach_driver+0x162/0x270
[   93.253643]        bus_for_each_drv+0x114/0x1a0
[   93.255593] sd 10:0:0:0: [sdc] Optimal transfer size 524288 bytes
[   93.256874]        __device_attach_async_helper+0x19e/0x240
[   93.362362]        async_run_entry_fn+0x97/0x4f0
[   93.364343]        process_one_work+0x841/0x17a0
[   93.366439]        worker_thread+0x6e8/0x1270
[   93.369068]        kthread+0x388/0x750
[   93.371762]        ret_from_fork+0x31/0x70
[   93.374588]        ret_from_fork_asm+0x1a/0x30
[   93.377490]
               -> #3 (&q->limits_lock){+.+.}-{4:4}:
[   93.381214]        __mutex_lock+0x192/0x1960
[   93.383220]        get_sectorsize+0x234/0x5f0
[   93.384945]        sr_block_open+0x1a9/0x220
[   93.386895]        blkdev_get_whole+0x8f/0x200
[   93.388922]        bdev_open+0x223/0xc10
[   93.390776]        blkdev_open+0x1f3/0x350
[   93.392704]        do_dentry_open+0x491/0x1820
[   93.394676]        vfs_open+0x82/0x350
[   93.396370]        path_openat+0x1b0c/0x2b10
[   93.398150]        do_filp_open+0x1e7/0x430
[   93.400494]        do_sys_openat2+0xed/0x180
[   93.403129]        __x64_sys_openat+0x122/0x1e0
[   93.405846]        do_syscall_64+0x95/0x180
[   93.408486]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   93.411165]
               -> #2 (&disk->open_mutex){+.+.}-{4:4}:
[   93.414296]        __mutex_lock+0x192/0x1960
[   93.415744]        bdev_open+0x339/0xc10
[   93.417148]        bdev_file_open_by_dev+0xc6/0x140
[   93.418669]        disk_scan_partitions+0x190/0x280
[   93.420188]        __add_disk_fwnode+0xdfe/0x1140
[   93.421708]        device_add_disk+0x184/0x270
[   93.423162]        nvme_alloc_ns+0x16f5/0x3580
[   93.424625]        nvme_scan_ns+0x628/0x7f0
[   93.425974]        async_run_entry_fn+0x97/0x4f0
[   93.427424]        process_one_work+0x841/0x17a0
[   93.428876]        worker_thread+0x6e8/0x1270
[   93.430336]        kthread+0x388/0x750
[   93.431760]        ret_from_fork+0x31/0x70
[   93.433186]        ret_from_fork_asm+0x1a/0x30
[   93.434667]
               -> #1 (&set->update_nr_hwq_lock){.+.+}-{4:4}:
[   93.437156]        down_read_interruptible+0x92/0x490
[   93.438774]        elevator_change+0x1a8/0x210
[   93.440281]        elv_iosched_store+0x14d/0x1f0
[   93.441928]        queue_attr_store+0x235/0x2f0
[   93.443469]        kernfs_fop_write_iter+0x359/0x530
[   93.445074]        vfs_write+0x5fb/0x1130
[   93.446440]        ksys_write+0xf9/0x1c0
[   93.447714]        do_syscall_64+0x95/0x180
[   93.449042]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   93.450585]
               -> #0 (kn->active#103){++++}-{0:0}:
[   93.452761]        __lock_acquire+0x1459/0x2200
[   93.454081]        lock_acquire+0x165/0x310
[   93.455378]        kernfs_drain+0x3a8/0x460
[   93.456736]        __kernfs_remove+0x213/0x680
[   93.458162]        kernfs_remove_by_name_ns+0x9c/0x110
[   93.459707]        remove_files+0x8c/0x1a0
[   93.461066]        sysfs_remove_group+0x7b/0x160
[   93.462494]        sysfs_remove_groups+0x53/0xa0
[   93.463916]        __kobject_del+0x7d/0x1d0
[   93.465242]        kobject_del+0x35/0x50
[   93.466568]        blk_unregister_queue+0x154/0x2c0
[   93.468022]        __del_gendisk+0x4d1/0xa10
[   93.469391]        del_gendisk+0x186/0x250
[   93.470757]        sd_remove+0x89/0x130
[   93.472093]        device_release_driver_internal+0x379/0x540
[   93.473726]        bus_remove_device+0x1f5/0x3f0
[   93.475198]        device_del+0x33c/0x8d0
[   93.476458]        __scsi_remove_device+0x276/0x340
[   93.477877]        sdev_store_delete+0x87/0x120
[   93.479288]        kernfs_fop_write_iter+0x359/0x530
[   93.480710]        vfs_write+0x5fb/0x1130
[   93.481986]        ksys_write+0xf9/0x1c0
[   93.483267]        do_syscall_64+0x95/0x180
[   93.484595]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   93.486120]
               other info that might help us debug this:

[   93.489456] Chain exists of:
                 kn->active#103 --> &q->limits_lock --> &q->q_usage_counter(queue)#14

[   93.493238]  Possible unsafe locking scenario:

[   93.495533]        CPU0                    CPU1
[   93.496993]        ----                    ----
[   93.498399]   lock(&q->q_usage_counter(queue)#14);
[   93.499859]                                lock(&q->limits_lock);
[   93.501504]                                lock(&q->q_usage_counter(queue)#14);
[   93.503463]   lock(kn->active#103);
[   93.504830]
                *** DEADLOCK ***

[   93.507934] 6 locks held by check/1690:
[   93.509293]  #0: ffff88811032c420 (sb_writers#4){.+.+}-{0:0}, at: ksys_write+0xf9/0x1c0
[   93.511216]  #1: ffff888115cbb088 (&of->mutex#2){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x21d/0x530
[   93.513380]  #2: ffff888126a140e0 (&shost->scan_mutex){+.+.}-{4:4}, at: sdev_store_delete+0x7f/0x120
[   93.515654]  #3: ffff8882a1b4e380 (&dev->mutex){....}-{4:4}, at: device_release_driver_internal+0x91/0x540
[   93.517859]  #4: ffff888126a14388 (&set->update_nr_hwq_lock){.+.+}-{4:4}, at: del_gendisk+0x17c/0x250
[   93.520267]  #5: ffff88828ef358a0 (&q->q_usage_counter(queue)#14){++++}-{0:0}, at: del_gendisk+0x186/0x250
[   93.522559]
               stack backtrace:
[   93.524777] CPU: 2 UID: 0 PID: 1690 Comm: check Not tainted 6.15.0-rc2_ublk+ #536 PREEMPT(voluntary)
[   93.524785] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-1.fc39 04/01/2014
[   93.524789] Call Trace:
[   93.524794]  <TASK>
[   93.524799]  dump_stack_lvl+0x93/0xf0
[   93.524810]  print_circular_bug+0x275/0x340
[   93.524820]  check_noncircular+0x146/0x160
[   93.524831]  __lock_acquire+0x1459/0x2200
[   93.524842]  lock_acquire+0x165/0x310
[   93.524849]  ? __kernfs_remove+0x213/0x680
[   93.524857]  ? up_write+0x19e/0x500
[   93.524864]  kernfs_drain+0x3a8/0x460
[   93.524870]  ? __kernfs_remove+0x213/0x680
[   93.524878]  ? __pfx_kernfs_drain+0x10/0x10
[   93.524884]  ? find_held_lock+0x2b/0x80
[   93.524889]  ? kernfs_root+0xb0/0x1c0
[   93.524900]  __kernfs_remove+0x213/0x680
[   93.524906]  ? kernfs_find_ns+0x192/0x390
[   93.524914]  kernfs_remove_by_name_ns+0x9c/0x110
[   93.524923]  remove_files+0x8c/0x1a0
[   93.524930]  sysfs_remove_group+0x7b/0x160
[   93.524937]  sysfs_remove_groups+0x53/0xa0
[   93.524945]  __kobject_del+0x7d/0x1d0
[   93.524953]  kobject_del+0x35/0x50
[   93.524960]  blk_unregister_queue+0x154/0x2c0
[   93.524968]  __del_gendisk+0x4d1/0xa10
[   93.524978]  ? __pfx___del_gendisk+0x10/0x10
[   93.524986]  ? kobject_put+0x61/0x4b0
[   93.524995]  del_gendisk+0x186/0x250
[   93.525019]  ? __pfx_del_gendisk+0x10/0x10
[   93.525029]  ? __pm_runtime_resume+0x79/0x100
[   93.525048]  sd_remove+0x89/0x130
[   93.525059]  device_release_driver_internal+0x379/0x540
[   93.525068]  ? kobject_put+0x61/0x4b0
[   93.525076]  bus_remove_device+0x1f5/0x3f0
[   93.525085]  device_del+0x33c/0x8d0
[   93.525093]  ? attribute_container_device_trigger+0x183/0x1f0
[   93.525099]  ? __pfx_device_del+0x10/0x10
[   93.525106]  ? __pfx_attribute_container_device_trigger+0x10/0x10
[   93.525115]  __scsi_remove_device+0x276/0x340
[   93.525122]  sdev_store_delete+0x87/0x120
[   93.525128]  kernfs_fop_write_iter+0x359/0x530
[   93.525138]  vfs_write+0x5fb/0x1130
[   93.525147]  ? __pfx_vfs_write+0x10/0x10
[   93.525158]  ? lock_acquire+0x165/0x310
[   93.525165]  ? nohz_balance_exit_idle.part.0+0xe2/0x330
[   93.525175]  ksys_write+0xf9/0x1c0
[   93.525182]  ? __pfx_ksys_write+0x10/0x10
[   93.525188]  ? __pfx_run_posix_cpu_timers+0x10/0x10
[   93.525198]  do_syscall_64+0x95/0x180
[   93.525206]  ? __lock_acquire+0x432/0x2200
[   93.525219]  ? __lock_acquire+0x432/0x2200
[   93.525229]  ? lock_acquire+0x165/0x310
[   93.525236]  ? ktime_get+0x32/0x150
[   93.525243]  ? find_held_lock+0x2b/0x80
[   93.525248]  ? ktime_get+0x32/0x150
[   93.525257]  ? seqcount_lockdep_reader_access.constprop.0+0x4b/0xb0
[   93.525264]  ? kvm_sched_clock_read+0x11/0x20
[   93.525270]  ? sched_clock+0x10/0x30
[   93.525277]  ? sched_clock_cpu+0x6c/0x4c0
[   93.525286]  ? __pfx_sched_clock_cpu+0x10/0x10
[   93.525293]  ? hrtimer_interrupt+0x363/0x870
[   93.525301]  ? irqtime_account_irq+0x51/0x200
[   93.525310]  ? irqentry_exit_to_user_mode+0x90/0x280
[   93.525318]  ? clear_bhb_loop+0x35/0x90
[   93.525324]  ? clear_bhb_loop+0x35/0x90
[   93.525329]  ? clear_bhb_loop+0x35/0x90
[   93.525335]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   93.525341] RIP: 0033:0x7f6a158fb174
[   93.525364] Code: 89 02 48 c7 c0 ff ff ff ff eb bd 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 80 3d 6d b4 0d 00 00 74 13 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 55 48 89 e5 48 83 ec 20 48 89
[   93.525369] RSP: 002b:00007fff65c97158 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
[   93.525376] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f6a158fb174
[   93.525381] RDX: 0000000000000002 RSI: 0000563b4b680130 RDI: 0000000000000001
[   93.525384] RBP: 00007fff65c97180 R08: 0000000000000073 R09: 0000000000000001
[   93.525387] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000002
[   93.525395] R13: 0000563b4b680130 R14: 00007f6a159cf780 R15: 0000000000000002
[   93.525407]  </TASK>
[   93.657609] sd 11:0:0:0: [sdd] Synchronizing SCSI cache



Thanks,
Ming

