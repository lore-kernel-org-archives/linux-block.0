Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89012158535;
	Fri, 28 Mar 2025 00:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743122754; cv=none; b=PaZutOBRUlGMptqM4eWkmhPRfspGhfDzpzoU98gXv36tedSmOAlu6WkUjqI1z/SBxtmj5zYe26RM8E/2nVzCY7E4Mnu2uD7DxowfDnud/lDQYIv7LXbm+XUG1gHbm11DAsua7rlM5Jz/TobwzW9rfcwsTAhFjd0cTeTEMBxVb9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743122754; c=relaxed/simple;
	bh=Zg0TjXRds9d3IutfuImhb9KsEFBHdU8wups480cdUR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nVbnwlXMpvsj2WDIY3+1RzL4Hnp8nViIm6zQ5othzRRPI3Mqz8aMw4M4AuLDpmdcOooovJz9+WND9GA09DbfJapa98mAXwjun/pnyqbBM0gSrzwTXHa4MtJc6JOn00vGJDyzJob5ot2PFC5WIJEHR1MHAVj5bNjvixX+khZKE4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V/NQWVt4; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V/NQWVt4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743122751; x=1774658751;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Zg0TjXRds9d3IutfuImhb9KsEFBHdU8wups480cdUR0=;
  b=V/NQWVt4rNgmbN5MhIMySKW2SWFyMVUNlr+5Z4O7bdhVEjMzhHQghDpi
   csgqlAVi3CjUUUU6bUgjYelDdPZzNNVs146vf6xNoLmZRy2nDYinH/PQn
   sR3AF+0JLO/XljIml19VeBcDYiHxd1gkuvtb/71aNhzStHi9RnB7oGYC8
   tAc5lQAp5X2T+Fi5QdYWxxeRbx0kUlJBLX88VKs+e66ty9/jmC/35LyO0
   lmu9GWgjRbEH+vhqUscR9VNZEcHl8eC7Mh+waUHrXjtb6WFOxwlyIPADY
   /0hw19u5aTooDmDY/TNOP5w6RrQgbDyxeIrUqn4wvQMCN571/M1GjTAZn
   A==;
X-CSE-ConnectionGUID: aqjKgau3THu5+/0enToQhw==
X-CSE-MsgGUID: X5YhAq+fQCOPiJTErUjl3g==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="55127309"
X-IronPort-AV: E=Sophos;i="6.14,281,1736841600"; 
   d="scan'208";a="55127309"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2025 17:45:51 -0700
X-CSE-ConnectionGUID: IExc0zrUT0i1ELy1npuPRg==
X-CSE-MsgGUID: pwljYi8OSQy7i3+Or1lZSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,281,1736841600"; 
   d="scan'208";a="125518335"
Received: from ly-workstation.sh.intel.com (HELO ly-workstation) ([10.239.161.23])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2025 17:45:49 -0700
Date: Fri, 28 Mar 2025 08:46:17 +0800
From: "Lai, Yi" <yi1.lai@linux.intel.com>
To: Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
	yi1.lai@intel.com
Subject: Re: [PATCH v2] block: Make request_queue lockdep splats show up
 earlier
Message-ID: <Z+XxWXGkfAkvG1kM@ly-workstation>
References: <20250318095548.5187-1-thomas.hellstrom@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250318095548.5187-1-thomas.hellstrom@linux.intel.com>

On Tue, Mar 18, 2025 at 10:55:48AM +0100, Thomas Hellström wrote:
> In recent kernels, there are lockdep splats around the
> struct request_queue::io_lockdep_map, similar to [1], but they
> typically don't show up until reclaim with writeback happens.
> 
> Having multiple kernel versions released with a known risc of kernel
> deadlock during reclaim writeback should IMHO be addressed and
> backported to -stable with the highest priority.
> 
> In order to have these lockdep splats show up earlier,
> preferrably during system initialization, prime the
> struct request_queue::io_lockdep_map as GFP_KERNEL reclaim-
> tainted. This will instead lead to lockdep splats looking similar
> to [2], but without the need for reclaim + writeback
> happening.
> 
> [1]:
> [  189.762244] ======================================================
> [  189.762432] WARNING: possible circular locking dependency detected
> [  189.762441] 6.14.0-rc6-xe+ #6 Tainted: G     U
> [  189.762450] ------------------------------------------------------
> [  189.762459] kswapd0/119 is trying to acquire lock:
> [  189.762467] ffff888110ceb710 (&q->q_usage_counter(io)#26){++++}-{0:0}, at: __submit_bio+0x76/0x230
> [  189.762485]
>                but task is already holding lock:
> [  189.762494] ffffffff834c97c0 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat+0xbe/0xb00
> [  189.762507]
>                which lock already depends on the new lock.
> 
> [  189.762519]
>                the existing dependency chain (in reverse order) is:
> [  189.762529]
>                -> #2 (fs_reclaim){+.+.}-{0:0}:
> [  189.762540]        fs_reclaim_acquire+0xc5/0x100
> [  189.762548]        kmem_cache_alloc_lru_noprof+0x4a/0x480
> [  189.762558]        alloc_inode+0xaa/0xe0
> [  189.762566]        iget_locked+0x157/0x330
> [  189.762573]        kernfs_get_inode+0x1b/0x110
> [  189.762582]        kernfs_get_tree+0x1b0/0x2e0
> [  189.762590]        sysfs_get_tree+0x1f/0x60
> [  189.762597]        vfs_get_tree+0x2a/0xf0
> [  189.762605]        path_mount+0x4cd/0xc00
> [  189.762613]        __x64_sys_mount+0x119/0x150
> [  189.762621]        x64_sys_call+0x14f2/0x2310
> [  189.762630]        do_syscall_64+0x91/0x180
> [  189.762637]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [  189.762647]
>                -> #1 (&root->kernfs_rwsem){++++}-{3:3}:
> [  189.762659]        down_write+0x3e/0xf0
> [  189.762667]        kernfs_remove+0x32/0x60
> [  189.762676]        sysfs_remove_dir+0x4f/0x60
> [  189.762685]        __kobject_del+0x33/0xa0
> [  189.762709]        kobject_del+0x13/0x30
> [  189.762716]        elv_unregister_queue+0x52/0x80
> [  189.762725]        elevator_switch+0x68/0x360
> [  189.762733]        elv_iosched_store+0x14b/0x1b0
> [  189.762756]        queue_attr_store+0x181/0x1e0
> [  189.762765]        sysfs_kf_write+0x49/0x80
> [  189.762773]        kernfs_fop_write_iter+0x17d/0x250
> [  189.762781]        vfs_write+0x281/0x540
> [  189.762790]        ksys_write+0x72/0xf0
> [  189.762798]        __x64_sys_write+0x19/0x30
> [  189.762807]        x64_sys_call+0x2a3/0x2310
> [  189.762815]        do_syscall_64+0x91/0x180
> [  189.762823]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [  189.762833]
>                -> #0 (&q->q_usage_counter(io)#26){++++}-{0:0}:
> [  189.762845]        __lock_acquire+0x1525/0x2760
> [  189.762854]        lock_acquire+0xca/0x310
> [  189.762861]        blk_mq_submit_bio+0x8a2/0xba0
> [  189.762870]        __submit_bio+0x76/0x230
> [  189.762878]        submit_bio_noacct_nocheck+0x323/0x430
> [  189.762888]        submit_bio_noacct+0x2cc/0x620
> [  189.762896]        submit_bio+0x38/0x110
> [  189.762904]        __swap_writepage+0xf5/0x380
> [  189.762912]        swap_writepage+0x3c7/0x600
> [  189.762920]        shmem_writepage+0x3da/0x4f0
> [  189.762929]        pageout+0x13f/0x310
> [  189.762937]        shrink_folio_list+0x61c/0xf60
> [  189.763261]        evict_folios+0x378/0xcd0
> [  189.763584]        try_to_shrink_lruvec+0x1b0/0x360
> [  189.763946]        shrink_one+0x10e/0x200
> [  189.764266]        shrink_node+0xc02/0x1490
> [  189.764586]        balance_pgdat+0x563/0xb00
> [  189.764934]        kswapd+0x1e8/0x430
> [  189.765249]        kthread+0x10b/0x260
> [  189.765559]        ret_from_fork+0x44/0x70
> [  189.765889]        ret_from_fork_asm+0x1a/0x30
> [  189.766198]
>                other info that might help us debug this:
> 
> [  189.767089] Chain exists of:
>                  &q->q_usage_counter(io)#26 --> &root->kernfs_rwsem --> fs_reclaim
> 
> [  189.767971]  Possible unsafe locking scenario:
> 
> [  189.768555]        CPU0                    CPU1
> [  189.768849]        ----                    ----
> [  189.769136]   lock(fs_reclaim);
> [  189.769421]                                lock(&root->kernfs_rwsem);
> [  189.769714]                                lock(fs_reclaim);
> [  189.770016]   rlock(&q->q_usage_counter(io)#26);
> [  189.770305]
>                 *** DEADLOCK ***
> 
> [  189.771167] 1 lock held by kswapd0/119:
> [  189.771453]  #0: ffffffff834c97c0 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat+0xbe/0xb00
> [  189.771770]
>                stack backtrace:
> [  189.772351] CPU: 4 UID: 0 PID: 119 Comm: kswapd0 Tainted: G     U             6.14.0-rc6-xe+ #6
> [  189.772353] Tainted: [U]=USER
> [  189.772354] Hardware name: ASUS System Product Name/PRIME B560M-A AC, BIOS 2001 02/01/2023
> [  189.772354] Call Trace:
> [  189.772355]  <TASK>
> [  189.772356]  dump_stack_lvl+0x6e/0xa0
> [  189.772359]  dump_stack+0x10/0x18
> [  189.772360]  print_circular_bug.cold+0x17a/0x1b7
> [  189.772363]  check_noncircular+0x13a/0x150
> [  189.772365]  ? __pfx_stack_trace_consume_entry+0x10/0x10
> [  189.772368]  __lock_acquire+0x1525/0x2760
> [  189.772368]  ? ret_from_fork_asm+0x1a/0x30
> [  189.772371]  lock_acquire+0xca/0x310
> [  189.772372]  ? __submit_bio+0x76/0x230
> [  189.772375]  ? lock_release+0xd5/0x2c0
> [  189.772376]  blk_mq_submit_bio+0x8a2/0xba0
> [  189.772378]  ? __submit_bio+0x76/0x230
> [  189.772380]  __submit_bio+0x76/0x230
> [  189.772382]  ? trace_hardirqs_on+0x1e/0xe0
> [  189.772384]  submit_bio_noacct_nocheck+0x323/0x430
> [  189.772386]  ? submit_bio_noacct_nocheck+0x323/0x430
> [  189.772387]  ? __might_sleep+0x58/0xa0
> [  189.772390]  submit_bio_noacct+0x2cc/0x620
> [  189.772391]  ? count_memcg_events+0x68/0x90
> [  189.772393]  submit_bio+0x38/0x110
> [  189.772395]  __swap_writepage+0xf5/0x380
> [  189.772396]  swap_writepage+0x3c7/0x600
> [  189.772397]  shmem_writepage+0x3da/0x4f0
> [  189.772401]  pageout+0x13f/0x310
> [  189.772406]  shrink_folio_list+0x61c/0xf60
> [  189.772409]  ? isolate_folios+0xe80/0x16b0
> [  189.772410]  ? mark_held_locks+0x46/0x90
> [  189.772412]  evict_folios+0x378/0xcd0
> [  189.772414]  ? evict_folios+0x34a/0xcd0
> [  189.772415]  ? lock_is_held_type+0xa3/0x130
> [  189.772417]  try_to_shrink_lruvec+0x1b0/0x360
> [  189.772420]  shrink_one+0x10e/0x200
> [  189.772421]  shrink_node+0xc02/0x1490
> [  189.772423]  ? shrink_node+0xa08/0x1490
> [  189.772424]  ? shrink_node+0xbd8/0x1490
> [  189.772425]  ? mem_cgroup_iter+0x366/0x480
> [  189.772427]  balance_pgdat+0x563/0xb00
> [  189.772428]  ? balance_pgdat+0x563/0xb00
> [  189.772430]  ? trace_hardirqs_on+0x1e/0xe0
> [  189.772431]  ? finish_task_switch.isra.0+0xcb/0x330
> [  189.772433]  ? __switch_to_asm+0x33/0x70
> [  189.772437]  kswapd+0x1e8/0x430
> [  189.772438]  ? __pfx_autoremove_wake_function+0x10/0x10
> [  189.772440]  ? __pfx_kswapd+0x10/0x10
> [  189.772441]  kthread+0x10b/0x260
> [  189.772443]  ? __pfx_kthread+0x10/0x10
> [  189.772444]  ret_from_fork+0x44/0x70
> [  189.772446]  ? __pfx_kthread+0x10/0x10
> [  189.772447]  ret_from_fork_asm+0x1a/0x30
> [  189.772450]  </TASK>
> 
> [2]:
> [    8.760253] ======================================================
> [    8.760254] WARNING: possible circular locking dependency detected
> [    8.760255] 6.14.0-rc6-xe+ #7 Tainted: G     U
> [    8.760256] ------------------------------------------------------
> [    8.760257] (udev-worker)/674 is trying to acquire lock:
> [    8.760259] ffff888100e39148 (&root->kernfs_rwsem){++++}-{3:3}, at: kernfs_remove+0x32/0x60
> [    8.760265]
>                but task is already holding lock:
> [    8.760266] ffff888110dc7680 (&q->q_usage_counter(io)#27){++++}-{0:0}, at: blk_mq_freeze_queue_nomemsave+0x12/0x30
> [    8.760272]

Hi Thomas Hellström,

Greetings!

I used Syzkaller and found that there is possible deadlock in blk_mq_freeze_queue_nomemsave in linux-next tag - next-20250325.

After bisection and the first bad commit is:
"
ffa1e7ada456 block: Make request_queue lockdep splats show up earlier
"

The deadlock can still be reproduced. You could try following reproduction binary.

All detailed into can be found at:
https://github.com/laifryiee/syzkaller_logs/tree/main/250327_170923_blk_mq_freeze_queue_nomemsave
Syzkaller repro code:
https://github.com/laifryiee/syzkaller_logs/tree/main/250327_170923_blk_mq_freeze_queue_nomemsave/repro.c
Syzkaller repro syscall steps:
https://github.com/laifryiee/syzkaller_logs/tree/main/250327_170923_blk_mq_freeze_queue_nomemsave/repro.prog
Syzkaller report:
https://github.com/laifryiee/syzkaller_logs/tree/main/250327_170923_blk_mq_freeze_queue_nomemsave/repro.report
Kconfig(make olddefconfig):
https://github.com/laifryiee/syzkaller_logs/tree/main/250327_170923_blk_mq_freeze_queue_nomemsave/kconfig_origin
Bisect info:
https://github.com/laifryiee/syzkaller_logs/tree/main/250327_170923_blk_mq_freeze_queue_nomemsave/bisect_info.log
bzImage:
https://github.com/laifryiee/syzkaller_logs/raw/refs/heads/main/250327_170923_blk_mq_freeze_queue_nomemsave/bzImage_eb4bc4b07f66f01618d9cb1aa4eaef59b1188415
Issue dmesg:
https://github.com/laifryiee/syzkaller_logs/blob/main/250327_170923_blk_mq_freeze_queue_nomemsave/eb4bc4b07f66f01618d9cb1aa4eaef59b1188415_dmesg.log

"
[   42.079025] ======================================================
[   42.079317] WARNING: possible circular locking dependency detected
[   42.079599] 6.14.0-next-20250325-eb4bc4b07f66 #1 Not tainted
[   42.079869] ------------------------------------------------------
[   42.080151] repro/680 is trying to acquire lock:
[   42.080374] ffffffff87e3c568 (uevent_sock_mutex){+.+.}-{4:4}, at: kobject_uevent_env+0x92c/0x14a0
[   42.080825]
[   42.080825] but task is already holding lock:
[   42.081104] ffff888010f0e228 (&q->q_usage_counter(io)#20){++++}-{0:0}, at: blk_mq_freeze_queue_nomemsave+0x1f/0x40
[   42.081611]
[   42.081611] which lock already depends on the new lock.
[   42.081611]
[   42.081986]
[   42.081986] the existing dependency chain (in reverse order) is:
[   42.082324]
[   42.082324] -> #2 (&q->q_usage_counter(io)#20){++++}-{0:0}:
[   42.082659]        blk_alloc_queue+0x64c/0x790
[   42.082878]        blk_mq_alloc_queue+0x18c/0x2a0
[   42.083110]        __blk_mq_alloc_disk+0x34/0x100
[   42.083342]        loop_add+0x4b9/0xbc0
[   42.083550]        loop_init+0x133/0x1a0
[   42.083761]        do_one_initcall+0x108/0x610
[   42.083981]        kernel_init_freeable+0xaab/0xeb0
[   42.084222]        kernel_init+0x28/0x2f0
[   42.084423]        ret_from_fork+0x56/0x90
[   42.084627]        ret_from_fork_asm+0x1a/0x30
[   42.084845]
[   42.084845] -> #1 (fs_reclaim){+.+.}-{0:0}:
[   42.085120]        fs_reclaim_acquire+0x116/0x160
[   42.085357]        kmem_cache_alloc_node_noprof+0x4f/0x420
[   42.085628]        __alloc_skb+0x2d6/0x3a0
[   42.085841]        alloc_uevent_skb+0x86/0x230
[   42.086056]        kobject_uevent_env+0xaa3/0x14a0
[   42.086297]        kobject_synth_uevent+0x7d2/0x8a0
[   42.086536]        store_uevent+0x1f/0x40
[   42.086740]        module_attr_store+0x60/0x90
[   42.086968]        sysfs_kf_write+0xfc/0x160
[   42.087190]        kernfs_fop_write_iter+0x41a/0x640
[   42.087429]        vfs_write+0xc5e/0x1140
[   42.087635]        ksys_write+0x14e/0x280
[   42.087836]        __x64_sys_write+0x7b/0xc0
[   42.088047]        x64_sys_call+0x16ba/0x2150
[   42.088259]        do_syscall_64+0x6d/0x150
[   42.088470]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   42.088732]
[   42.088732] -> #0 (uevent_sock_mutex){+.+.}-{4:4}:
[   42.089037]        __lock_acquire+0x14c0/0x2260
[   42.089267]        lock_acquire+0x170/0x310
[   42.089476]        __mutex_lock+0x17b/0x1700
[   42.089692]        mutex_lock_nested+0x1f/0x30
[   42.089913]        kobject_uevent_env+0x92c/0x14a0
[   42.090152]        kobject_uevent+0x24/0x30
[   42.090356]        loop_set_status+0x9b0/0xb70
[   42.090579]        lo_ioctl+0x75d/0x2840
[   42.090776]        blkdev_ioctl+0x2a1/0x6a0
[   42.090983]        __x64_sys_ioctl+0x1ba/0x220
[   42.091214]        x64_sys_call+0x122e/0x2150
[   42.091432]        do_syscall_64+0x6d/0x150
[   42.091639]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   42.091903]
[   42.091903] other info that might help us debug this:
[   42.091903]
[   42.092267] Chain exists of:
[   42.092267]   uevent_sock_mutex --> fs_reclaim --> &q->q_usage_counter(io)#20
[   42.092267]
[   42.092795]  Possible unsafe locking scenario:
[   42.092795]
[   42.093069]        CPU0                    CPU1
[   42.093291]        ----                    ----
[   42.093510]   lock(&q->q_usage_counter(io)#20);
[   42.093736]                                lock(fs_reclaim);
[   42.094012]                                lock(&q->q_usage_counter(io)#20);
[   42.094352]   lock(uevent_sock_mutex);
[   42.094540]
[   42.094540]  *** DEADLOCK ***
[   42.094540]
[   42.094819] 3 locks held by repro/680:
[   42.095005]  #0: ffff888010f3eb68 (&lo->lo_mutex){+.+.}-{4:4}, at: loop_set_status+0x33/0xb70
[   42.095415]  #1: ffff888010f0e228 (&q->q_usage_counter(io)#20){++++}-{0:0}, at: blk_mq_freeze_queue_nomemsave+0x1f/00
[   42.095925]  #2: ffff888010f0e260 (&q->q_usage_counter(queue)#24){+.+.}-{0:0}, at: blk_mq_freeze_queue_nomemsave+0x10
[   42.096457]
[   42.096457] stack backtrace:
[   42.096675] CPU: 0 UID: 0 PID: 680 Comm: repro Not tainted 6.14.0-next-20250325-eb4bc4b07f66 #1 PREEMPT(voluntary)
[   42.096683] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org4
[   42.096692] Call Trace:
[   42.096697]  <TASK>
[   42.096702]  dump_stack_lvl+0xea/0x150
[   42.096714]  dump_stack+0x19/0x20
[   42.096721]  print_circular_bug+0x283/0x350
[   42.096730]  check_noncircular+0x12f/0x150
[   42.096740]  __lock_acquire+0x14c0/0x2260
[   42.096751]  lock_acquire+0x170/0x310
[   42.096759]  ? kobject_uevent_env+0x92c/0x14a0
[   42.096772]  __mutex_lock+0x17b/0x1700
[   42.096781]  ? kobject_uevent_env+0x92c/0x14a0
[   42.096791]  ? kobject_uevent_env+0x92c/0x14a0
[   42.096805]  ? __pfx___mutex_lock+0x10/0x10
[   42.096814]  ? __sanitizer_cov_trace_cmp8+0x1c/0x30
[   42.096826]  ? add_uevent_var+0x238/0x310
[   42.096836]  ? __pfx_add_uevent_var+0x10/0x10
[   42.096850]  mutex_lock_nested+0x1f/0x30
[   42.096859]  ? mutex_lock_nested+0x1f/0x30
[   42.096869]  kobject_uevent_env+0x92c/0x14a0
[   42.096882]  kobject_uevent+0x24/0x30
[   42.096892]  loop_set_status+0x9b0/0xb70
[   42.096904]  lo_ioctl+0x75d/0x2840
[   42.096917]  ? __lock_acquire+0x410/0x2260
[   42.096926]  ? __lock_acquire+0x410/0x2260
[   42.096934]  ? __pfx_lo_ioctl+0x10/0x10
[   42.096948]  ? __lruvec_stat_mod_folio+0x1aa/0x3e0
[   42.096960]  ? __folio_batch_add_and_move+0x50a/0xb00
[   42.096973]  ? __folio_batch_add_and_move+0x50a/0xb00
[   42.096983]  ? __this_cpu_preempt_check+0x21/0x30
[   42.096993]  ? lock_release+0x14f/0x2c0
[   42.097001]  ? rcu_read_unlock+0x31/0xc0
[   42.097020]  ? __sanitizer_cov_trace_switch+0x58/0xa0
[   42.097028]  ? blkdev_common_ioctl+0x1ca/0x2130
[   42.097035]  ? __sanitizer_cov_trace_switch+0x58/0xa0
[   42.097046]  ? __pfx_blkdev_common_ioctl+0x10/0x10
[   42.097054]  ? __pfx_do_vfs_ioctl+0x10/0x10
[   42.097061]  ? __lock_acquire+0x410/0x2260
[   42.097068]  ? __lock_acquire+0x410/0x2260
[   42.097083]  ? __pfx_lo_ioctl+0x10/0x10
[   42.097092]  blkdev_ioctl+0x2a1/0x6a0
[   42.097100]  ? __pfx_blkdev_ioctl+0x10/0x10
[   42.097106]  ? ktime_get_coarse_real_ts64+0xb6/0x100
[   42.097120]  ? __pfx_blkdev_ioctl+0x10/0x10
[   42.097127]  __x64_sys_ioctl+0x1ba/0x220
[   42.097135]  x64_sys_call+0x122e/0x2150
[   42.097141]  do_syscall_64+0x6d/0x150
[   42.097149]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   42.097155] RIP: 0033:0x7f3246c3ee5d
[   42.097165] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d8
[   42.097175] RSP: 002b:00007ffea3aeccd8 EFLAGS: 00000283 ORIG_RAX: 0000000000000010
[   42.097185] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f3246c3ee5d
[   42.097189] RDX: 00000000200018c0 RSI: 0000000000004c04 RDI: 0000000000000003
[   42.097193] RBP: 00007ffea3aeccf0 R08: 0023706f6f6c2f76 R09: 00007ffea3aeccf0
[   42.097197] R10: 000000000000001f R11: 0000000000000283 R12: 00007ffea3aece48
[   42.097201] R13: 000000000040345d R14: 0000000000412e08 R15: 00007f3246fb9000
[   42.097210]  </TASK>
[   42.143450] loop4: detected capacity change from 0 to 128
[   42.158081] loop5: detected capacity change from 0 to 128
[   42.223491] loop2: detected capacity change from 0 to 128
[   42.252971] loop6: detected capacity change from 0 to 128
[   42.254478] repro: attempt to access beyond end of device
[   42.254478] loop3: rw=0, sector=0, nr_sectors = 1 limit=0
[   42.254973] FAT-fs (loop3): unable to read boot sector
"

Hope this cound be insightful to you.

Regards,
Yi Lai

---

If you don't need the following environment to reproduce the problem or if you
already have one reproduced environment, please ignore the following information.

How to reproduce:
git clone https://gitlab.com/xupengfe/repro_vm_env.git
cd repro_vm_env
tar -xvf repro_vm_env.tar.gz
cd repro_vm_env; ./start3.sh  // it needs qemu-system-x86_64 and I used v7.1.0
  // start3.sh will load bzImage_2241ab53cbb5cdb08a6b2d4688feb13971058f65 v6.2-rc5 kernel
  // You could change the bzImage_xxx as you want
  // Maybe you need to remove line "-drive if=pflash,format=raw,readonly=on,file=./OVMF_CODE.fd \" for different qemu version
You could use below command to log in, there is no password for root.
ssh -p 10023 root@localhost

After login vm(virtual machine) successfully, you could transfer reproduced
binary to the vm by below way, and reproduce the problem in vm:
gcc -pthread -o repro repro.c
scp -P 10023 repro root@localhost:/root/

Get the bzImage for target kernel:
Please use target kconfig and copy it to kernel_src/.config
make olddefconfig
make -jx bzImage           //x should equal or less than cpu num your pc has

Fill the bzImage file into above start3.sh to load the target kernel in vm.


Tips:
If you already have qemu-system-x86_64, please ignore below info.
If you want to install qemu v7.1.0 version:
git clone https://github.com/qemu/qemu.git
cd qemu
git checkout -f v7.1.0
mkdir build
cd build
yum install -y ninja-build.x86_64
yum -y install libslirp-devel.x86_64
../configure --target-list=x86_64-softmmu --enable-kvm --enable-vnc --enable-gtk --enable-sdl --enable-usb-redir --enable-slirp
make
make install 

>                which lock already depends on the new lock.
> 
> [    8.760272]
>                the existing dependency chain (in reverse order) is:
> [    8.760273]
>                -> #2 (&q->q_usage_counter(io)#27){++++}-{0:0}:
> [    8.760276]        blk_alloc_queue+0x30a/0x350
> [    8.760279]        blk_mq_alloc_queue+0x6b/0xe0
> [    8.760281]        scsi_alloc_sdev+0x276/0x3c0
> [    8.760284]        scsi_probe_and_add_lun+0x22a/0x440
> [    8.760286]        __scsi_scan_target+0x109/0x230
> [    8.760288]        scsi_scan_channel+0x65/0xc0
> [    8.760290]        scsi_scan_host_selected+0xff/0x140
> [    8.760292]        do_scsi_scan_host+0xa7/0xc0
> [    8.760293]        do_scan_async+0x1c/0x160
> [    8.760295]        async_run_entry_fn+0x32/0x150
> [    8.760299]        process_one_work+0x224/0x5f0
> [    8.760302]        worker_thread+0x1d4/0x3e0
> [    8.760304]        kthread+0x10b/0x260
> [    8.760306]        ret_from_fork+0x44/0x70
> [    8.760309]        ret_from_fork_asm+0x1a/0x30
> [    8.760312]
>                -> #1 (fs_reclaim){+.+.}-{0:0}:
> [    8.760315]        fs_reclaim_acquire+0xc5/0x100
> [    8.760317]        kmem_cache_alloc_lru_noprof+0x4a/0x480
> [    8.760319]        alloc_inode+0xaa/0xe0
> [    8.760322]        iget_locked+0x157/0x330
> [    8.760323]        kernfs_get_inode+0x1b/0x110
> [    8.760325]        kernfs_get_tree+0x1b0/0x2e0
> [    8.760327]        sysfs_get_tree+0x1f/0x60
> [    8.760329]        vfs_get_tree+0x2a/0xf0
> [    8.760332]        path_mount+0x4cd/0xc00
> [    8.760334]        __x64_sys_mount+0x119/0x150
> [    8.760336]        x64_sys_call+0x14f2/0x2310
> [    8.760338]        do_syscall_64+0x91/0x180
> [    8.760340]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [    8.760342]
>                -> #0 (&root->kernfs_rwsem){++++}-{3:3}:
> [    8.760345]        __lock_acquire+0x1525/0x2760
> [    8.760347]        lock_acquire+0xca/0x310
> [    8.760348]        down_write+0x3e/0xf0
> [    8.760350]        kernfs_remove+0x32/0x60
> [    8.760351]        sysfs_remove_dir+0x4f/0x60
> [    8.760353]        __kobject_del+0x33/0xa0
> [    8.760355]        kobject_del+0x13/0x30
> [    8.760356]        elv_unregister_queue+0x52/0x80
> [    8.760358]        elevator_switch+0x68/0x360
> [    8.760360]        elv_iosched_store+0x14b/0x1b0
> [    8.760362]        queue_attr_store+0x181/0x1e0
> [    8.760364]        sysfs_kf_write+0x49/0x80
> [    8.760366]        kernfs_fop_write_iter+0x17d/0x250
> [    8.760367]        vfs_write+0x281/0x540
> [    8.760370]        ksys_write+0x72/0xf0
> [    8.760372]        __x64_sys_write+0x19/0x30
> [    8.760374]        x64_sys_call+0x2a3/0x2310
> [    8.760376]        do_syscall_64+0x91/0x180
> [    8.760377]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [    8.760380]
>                other info that might help us debug this:
> 
> [    8.760380] Chain exists of:
>                  &root->kernfs_rwsem --> fs_reclaim --> &q->q_usage_counter(io)#27
> 
> [    8.760384]  Possible unsafe locking scenario:
> 
> [    8.760384]        CPU0                    CPU1
> [    8.760385]        ----                    ----
> [    8.760385]   lock(&q->q_usage_counter(io)#27);
> [    8.760387]                                lock(fs_reclaim);
> [    8.760388]                                lock(&q->q_usage_counter(io)#27);
> [    8.760390]   lock(&root->kernfs_rwsem);
> [    8.760391]
>                 *** DEADLOCK ***
> 
> [    8.760391] 6 locks held by (udev-worker)/674:
> [    8.760392]  #0: ffff8881209ac420 (sb_writers#4){.+.+}-{0:0}, at: ksys_write+0x72/0xf0
> [    8.760398]  #1: ffff88810c80f488 (&of->mutex#2){+.+.}-{3:3}, at: kernfs_fop_write_iter+0x136/0x250
> [    8.760402]  #2: ffff888125d1d330 (kn->active#101){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x13f/0x250
> [    8.760406]  #3: ffff888110dc7bb0 (&q->sysfs_lock){+.+.}-{3:3}, at: queue_attr_store+0x148/0x1e0
> [    8.760411]  #4: ffff888110dc7680 (&q->q_usage_counter(io)#27){++++}-{0:0}, at: blk_mq_freeze_queue_nomemsave+0x12/0x30
> [    8.760416]  #5: ffff888110dc76b8 (&q->q_usage_counter(queue)#27){++++}-{0:0}, at: blk_mq_freeze_queue_nomemsave+0x12/0x30
> [    8.760421]
>                stack backtrace:
> [    8.760422] CPU: 7 UID: 0 PID: 674 Comm: (udev-worker) Tainted: G     U             6.14.0-rc6-xe+ #7
> [    8.760424] Tainted: [U]=USER
> [    8.760425] Hardware name: ASUS System Product Name/PRIME B560M-A AC, BIOS 2001 02/01/2023
> [    8.760426] Call Trace:
> [    8.760427]  <TASK>
> [    8.760428]  dump_stack_lvl+0x6e/0xa0
> [    8.760431]  dump_stack+0x10/0x18
> [    8.760433]  print_circular_bug.cold+0x17a/0x1b7
> [    8.760437]  check_noncircular+0x13a/0x150
> [    8.760441]  ? save_trace+0x54/0x360
> [    8.760445]  __lock_acquire+0x1525/0x2760
> [    8.760446]  ? irqentry_exit+0x3a/0xb0
> [    8.760448]  ? sysvec_apic_timer_interrupt+0x57/0xc0
> [    8.760452]  lock_acquire+0xca/0x310
> [    8.760453]  ? kernfs_remove+0x32/0x60
> [    8.760457]  down_write+0x3e/0xf0
> [    8.760459]  ? kernfs_remove+0x32/0x60
> [    8.760460]  kernfs_remove+0x32/0x60
> [    8.760462]  sysfs_remove_dir+0x4f/0x60
> [    8.760464]  __kobject_del+0x33/0xa0
> [    8.760466]  kobject_del+0x13/0x30
> [    8.760467]  elv_unregister_queue+0x52/0x80
> [    8.760470]  elevator_switch+0x68/0x360
> [    8.760472]  elv_iosched_store+0x14b/0x1b0
> [    8.760475]  queue_attr_store+0x181/0x1e0
> [    8.760479]  ? lock_acquire+0xca/0x310
> [    8.760480]  ? kernfs_fop_write_iter+0x13f/0x250
> [    8.760482]  ? lock_is_held_type+0xa3/0x130
> [    8.760485]  sysfs_kf_write+0x49/0x80
> [    8.760487]  kernfs_fop_write_iter+0x17d/0x250
> [    8.760489]  vfs_write+0x281/0x540
> [    8.760494]  ksys_write+0x72/0xf0
> [    8.760497]  __x64_sys_write+0x19/0x30
> [    8.760499]  x64_sys_call+0x2a3/0x2310
> [    8.760502]  do_syscall_64+0x91/0x180
> [    8.760504]  ? trace_hardirqs_off+0x5d/0xe0
> [    8.760506]  ? handle_softirqs+0x479/0x4d0
> [    8.760508]  ? hrtimer_interrupt+0x13f/0x280
> [    8.760511]  ? irqentry_exit_to_user_mode+0x8b/0x260
> [    8.760513]  ? clear_bhb_loop+0x15/0x70
> [    8.760515]  ? clear_bhb_loop+0x15/0x70
> [    8.760516]  ? clear_bhb_loop+0x15/0x70
> [    8.760518]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [    8.760520] RIP: 0033:0x7aa3bf2f5504
> [    8.760522] Code: c7 00 16 00 00 00 b8 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 80 3d c5 8b 10 00 00 74 13 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 55 48 89 e5 48 83 ec 20 48 89
> [    8.760523] RSP: 002b:00007ffc1e3697d8 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
> [    8.760526] RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007aa3bf2f5504
> [    8.760527] RDX: 0000000000000003 RSI: 00007ffc1e369ae0 RDI: 000000000000001c
> [    8.760528] RBP: 00007ffc1e369800 R08: 00007aa3bf3f51c8 R09: 00007ffc1e3698b0
> [    8.760528] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000003
> [    8.760529] R13: 00007ffc1e369ae0 R14: 0000613ccf21f2f0 R15: 00007aa3bf3f4e80
> [    8.760533]  </TASK>
> 
> v2:
> - Update a code comment to increase readability (Ming Lei).
> 
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: linux-block@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> Reviewed-by: Ming Lei <ming.lei@redhat.com>
> ---
>  block/blk-core.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index d6c4fa3943b5..138fc3dbff45 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -455,6 +455,12 @@ struct request_queue *blk_alloc_queue(struct queue_limits *lim, int node_id)
>  	lockdep_init_map(&q->q_lockdep_map, "&q->q_usage_counter(queue)",
>  			 &q->q_lock_cls_key, 0);
>  
> +	/* Teach lockdep about lock ordering (reclaim WRT queue freeze lock). */
> +	fs_reclaim_acquire(GFP_KERNEL);
> +	rwsem_acquire_read(&q->io_lockdep_map, 0, 0, _RET_IP_);
> +	rwsem_release(&q->io_lockdep_map, _RET_IP_);
> +	fs_reclaim_release(GFP_KERNEL);
> +
>  	q->nr_requests = BLKDEV_DEFAULT_RQ;
>  
>  	return q;
> -- 
> 2.48.1
>
