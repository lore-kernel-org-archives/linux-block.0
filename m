Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9F520B20C
	for <linux-block@vger.kernel.org>; Fri, 10 Jan 2025 10:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736503996; cv=none; b=C2mpy47Mse3+M+2c2QpKLTgY0oNuj2lDZJWEiSzk2TBwkxXFqhHHBVIwtqRcOgxp2cpCx1bRndhl4P3VwD8j+T91qWRWLJE3OUKbNFlpoVc26MvaIqneEoghLfi2jZ2rn0//NrJIb2TgCcqKEAcyJcnU8mr5ROz+vYeSJ+E9RDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736503996; c=relaxed/simple;
	bh=FP+gu1eG7nv3DmWDHJxcu2TQSSReSbviCZKq9oetxNE=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=SvfBYr13hBnBJ7C4tfHHAs11pDPWk+sLdfju+FLRmXnpf7NJ8sjlKVcWpuNXdbBMBdTsRLYe3p7QsIb+xeT0ZH4SFyBVMpt+PkNv5X2A7QZUYZ/x+90ZzAn/NPH78zjsmOQaTtg5bHZFS/UpULJ4F724F6GiQLBqPnP2iooa6EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UbmpvBTD; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UbmpvBTD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736503995; x=1768039995;
  h=message-id:subject:from:to:cc:date:
   content-transfer-encoding:mime-version;
  bh=FP+gu1eG7nv3DmWDHJxcu2TQSSReSbviCZKq9oetxNE=;
  b=UbmpvBTDr5iBop8jBPBYPy9eA00ndb8VghyxONBdr2/mrzdyHfJxkpda
   5qRgCsdETODz4Hq/BmA0YhCAyqnukPocspDWVvogCnfCz+e55k/XXLiPi
   UkvJIT1/DS8Tuk4bWnasL/KzYDhWrQUPvShrhPniyraBaNlmCJpM80kOT
   ZLNWX5MJPn/Y1PMCS7pbQAMG+qGrxxW8I8jpVYQ5AiIZKLKa2YRnWUpRY
   xMY6BJQtHaYND8AyXGsuCIxVe4lcJTmINqG0IPeWfb5odaRhwg3xHlCcA
   j6/ebfoEqNl2b3jfzD3Uc2mB/UwSTgHBWXpUHNzpqwv5d8mG7bion3CrW
   Q==;
X-CSE-ConnectionGUID: WZ0tmYVfTnGnMsXRtCl5ww==
X-CSE-MsgGUID: 3oMzCeDNSSefegv29gb6cA==
X-IronPort-AV: E=McAfee;i="6700,10204,11310"; a="36952503"
X-IronPort-AV: E=Sophos;i="6.12,303,1728975600"; 
   d="scan'208";a="36952503"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2025 02:13:14 -0800
X-CSE-ConnectionGUID: QoiMDErMTSKDXLORTPFZlg==
X-CSE-MsgGUID: MFJTm/YmRyujY9mdrUK94A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="108733909"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO [10.245.246.11]) ([10.245.246.11])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2025 02:13:12 -0800
Message-ID: <65a8ef7321bf905ab27c383395016fe299f6dfd9.camel@linux.intel.com>
Subject: Blockdev 6.13-rc lockdep splat regressions
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org
Date: Fri, 10 Jan 2025 11:12:58 +0100
Organization: Intel Sweden AB, Registration Number: 556189-6027
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 (3.54.2-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Ming, Others

On 6.13-rc6 I'm seeing a couple of lockdep splats which appear
introduced by the commit

f1be1788a32e ("block: model freeze & enter queue as lock for supporting
lockdep")

The first one happens when swap-outs start to a scsi disc,
Simple reproducer is to start a couple of parallel "gitk" on the kernel
repo and watch them exhaust available memory.

the second is easily triggered by entering a debugfs trace directory,
apparently triggering automount:
cd /sys/kernel/debug/tracing/events

Are you aware of these?
Thanks,
Thomas

#1
[  399.006581] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
[  399.006756] WARNING: possible circular locking dependency detected
[  399.006767] 6.12.0-rc4+ #1 Tainted: G     U           N
[  399.006776] ------------------------------------------------------
[  399.006801] kswapd0/116 is trying to acquire lock:
[  399.006810] ffff9a67a1284a28 (&q->q_usage_counter(io)){++++}-{0:0},
at: __submit_bio+0xf0/0x1c0
[  399.006845]=20
               but task is already holding lock:
[  399.006856] ffffffff8a65bf00 (fs_reclaim){+.+.}-{0:0}, at:
balance_pgdat+0xe2/0xa20
[  399.006874]=20
               which lock already depends on the new lock.

[  399.006890]=20
               the existing dependency chain (in reverse order) is:
[  399.006905]=20
               -> #1 (fs_reclaim){+.+.}-{0:0}:
[  399.006919]        fs_reclaim_acquire+0x9d/0xd0
[  399.006931]        __kmalloc_node_noprof+0xa5/0x460
[  399.006943]        sbitmap_init_node+0x84/0x1e0
[  399.006953]        scsi_realloc_sdev_budget_map+0xc8/0x1a0
[  399.006965]        scsi_add_lun+0x419/0x710
[  399.006976]        scsi_probe_and_add_lun+0x12d/0x450
[  399.006988]        __scsi_scan_target+0x112/0x230
[  399.006999]        scsi_scan_channel+0x59/0x90
[  399.007009]        scsi_scan_host_selected+0xe5/0x120
[  399.007021]        do_scan_async+0x1b/0x160
[  399.007031]        async_run_entry_fn+0x31/0x130
[  399.007043]        process_one_work+0x21a/0x590
[  399.007054]        worker_thread+0x1c3/0x3b0
[  399.007065]        kthread+0xd2/0x100
[  399.007074]        ret_from_fork+0x31/0x50
[  399.007085]        ret_from_fork_asm+0x1a/0x30
[  399.007096]=20
               -> #0 (&q->q_usage_counter(io)){++++}-{0:0}:
[  399.007111]        __lock_acquire+0x13ac/0x2170
[  399.007123]        lock_acquire+0xd0/0x2f0
[  399.007134]        blk_mq_submit_bio+0x90b/0xb00
[  399.007145]        __submit_bio+0xf0/0x1c0
[  399.007155]        submit_bio_noacct_nocheck+0x324/0x420
[  399.007167]        swap_writepage+0x14a/0x2c0
[  399.007178]        pageout+0x129/0x2d0
[  399.007608]        shrink_folio_list+0x5a0/0xd80
[  399.008045]        evict_folios+0x27a/0x790
[  399.008486]        try_to_shrink_lruvec+0x225/0x2b0
[  399.008926]        shrink_one+0x102/0x1f0
[  399.009360]        shrink_node+0xa7c/0x1130
[  399.009821]        balance_pgdat+0x560/0xa20
[  399.010254]        kswapd+0x20a/0x440
[  399.010698]        kthread+0xd2/0x100
[  399.011141]        ret_from_fork+0x31/0x50
[  399.011584]        ret_from_fork_asm+0x1a/0x30
[  399.012024]=20
               other info that might help us debug this:

[  399.013283]  Possible unsafe locking scenario:

[  399.014160]        CPU0                    CPU1
[  399.014584]        ----                    ----
[  399.015010]   lock(fs_reclaim);
[  399.015439]                                lock(&q-
>q_usage_counter(io));
[  399.015867]                                lock(fs_reclaim);
[  399.016208]   rlock(&q->q_usage_counter(io));
[  399.016538]=20
                *** DEADLOCK ***

[  399.017539] 1 lock held by kswapd0/116:
[  399.017887]  #0: ffffffff8a65bf00 (fs_reclaim){+.+.}-{0:0}, at:
balance_pgdat+0xe2/0xa20
[  399.018218]=20
               stack backtrace:
[  399.018887] CPU: 11 UID: 0 PID: 116 Comm: kswapd0 Tainted: G     U=20
N 6.12.0-rc4+ #1
[  399.019217] Tainted: [U]=3DUSER, [N]=3DTEST
[  399.019543] Hardware name: ASUS System Product Name/PRIME B560M-A
AC, BIOS 2001 02/01/2023
[  399.019911] Call Trace:
[  399.020235]  <TASK>
[  399.020556]  dump_stack_lvl+0x6e/0xa0
[  399.020890]  print_circular_bug.cold+0x178/0x1be
[  399.021207]  check_noncircular+0x148/0x160
[  399.021523]  __lock_acquire+0x13ac/0x2170
[  399.021852]  lock_acquire+0xd0/0x2f0
[  399.022167]  ? __submit_bio+0xf0/0x1c0
[  399.022489]  ? blk_mq_submit_bio+0x8e0/0xb00
[  399.022830]  ? lock_release+0xd3/0x2b0
[  399.023143]  blk_mq_submit_bio+0x90b/0xb00
[  399.023460]  ? __submit_bio+0xf0/0x1c0
[  399.023785]  ? lock_acquire+0xd0/0x2f0
[  399.024096]  __submit_bio+0xf0/0x1c0
[  399.024404]  submit_bio_noacct_nocheck+0x324/0x420
[  399.024713]  swap_writepage+0x14a/0x2c0
[  399.025037]  pageout+0x129/0x2d0
[  399.025348]  shrink_folio_list+0x5a0/0xd80
[  399.025668]  ? evict_folios+0x25a/0x790
[  399.026007]  evict_folios+0x27a/0x790
[  399.026325]  try_to_shrink_lruvec+0x225/0x2b0
[  399.026635]  shrink_one+0x102/0x1f0
[  399.026957]  ? shrink_node+0xa63/0x1130
[  399.027264]  shrink_node+0xa7c/0x1130
[  399.027570]  ? shrink_node+0x908/0x1130
[  399.027888]  balance_pgdat+0x560/0xa20
[  399.028197]  ? lockdep_hardirqs_on_prepare+0xdb/0x190
[  399.028510]  ? finish_task_switch.isra.0+0xc4/0x2a0
[  399.028829]  kswapd+0x20a/0x440
[  399.029136]  ? __pfx_autoremove_wake_function+0x10/0x10
[  399.029483]  ? __pfx_kswapd+0x10/0x10
[  399.029912]  kthread+0xd2/0x100
[  399.030306]  ? __pfx_kthread+0x10/0x10
[  399.030699]  ret_from_fork+0x31/0x50
[  399.031105]  ? __pfx_kthread+0x10/0x10
[  399.031520]  ret_from_fork_asm+0x1a/0x30
[  399.031934]  </TASK>

#2:
[   81.960829] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   81.961010] WARNING: possible circular locking dependency detected
[   81.961048] 6.12.0-rc4+ #3 Tainted: G     U           =20
[   81.961082] ------------------------------------------------------
[   81.961117] bash/2744 is trying to acquire lock:
[   81.961147] ffffffff8b6754d0 (namespace_sem){++++}-{4:4}, at:
finish_automount+0x77/0x3a0
[   81.961215]=20
               but task is already holding lock:
[   81.961249] ffff8d7a8051ce50 (&sb->s_type->i_mutex_key#3){++++}-
{4:4}, at: finish_automount+0x6b/0x3a0
[   81.961316]=20
               which lock already depends on the new lock.

[   81.961361]=20
               the existing dependency chain (in reverse order) is:
[   81.961403]=20
               -> #6 (&sb->s_type->i_mutex_key#3){++++}-{4:4}:
[   81.961452]        down_write+0x2e/0xb0
[   81.961486]        start_creating.part.0+0x5f/0x120
[   81.961523]        debugfs_create_dir+0x36/0x190
[   81.961557]        blk_register_queue+0xba/0x220
[   81.961594]        add_disk_fwnode+0x235/0x430
[   81.961626]        nvme_alloc_ns+0x7eb/0xb50 [nvme_core]
[   81.961696]        nvme_scan_ns+0x251/0x330 [nvme_core]
[   81.962053]        async_run_entry_fn+0x31/0x130
[   81.962088]        process_one_work+0x21a/0x590
[   81.962122]        worker_thread+0x1c3/0x3b0
[   81.962153]        kthread+0xd2/0x100
[   81.962179]        ret_from_fork+0x31/0x50
[   81.962211]        ret_from_fork_asm+0x1a/0x30
[   81.962243]=20
               -> #5 (&q->debugfs_mutex){+.+.}-{4:4}:
[   81.962287]        __mutex_lock+0xad/0xb80
[   81.962319]        blk_mq_init_sched+0x181/0x260
[   81.962350]        elevator_init_mq+0xb0/0x100
[   81.962381]        add_disk_fwnode+0x50/0x430
[   81.962412]        sd_probe+0x335/0x530
[   81.962441]        really_probe+0xdb/0x340
[   81.962474]        __driver_probe_device+0x78/0x110
[   81.962510]        driver_probe_device+0x1f/0xa0
[   81.962545]        __device_attach_driver+0x89/0x110
[   81.962581]        bus_for_each_drv+0x98/0xf0
[   81.962613]        __device_attach_async_helper+0xa5/0xf0
[   81.962651]        async_run_entry_fn+0x31/0x130
[   81.962686]        process_one_work+0x21a/0x590
[   81.962718]        worker_thread+0x1c3/0x3b0
[   81.962750]        kthread+0xd2/0x100
[   81.962775]        ret_from_fork+0x31/0x50
[   81.962806]        ret_from_fork_asm+0x1a/0x30
[   81.962838]=20
               -> #4 (&q->q_usage_counter(queue)#3){++++}-{0:0}:
[   81.962887]        blk_queue_enter+0x1bc/0x1e0
[   81.962918]        blk_mq_alloc_request+0x144/0x2b0
[   81.962951]        scsi_execute_cmd+0x78/0x490
[   81.962985]        read_capacity_16+0x111/0x410
[   81.963017]        sd_revalidate_disk.isra.0+0x545/0x2eb0
[   81.963053]        sd_probe+0x2eb/0x530
[   81.963081]        really_probe+0xdb/0x340
[   81.963112]        __driver_probe_device+0x78/0x110
[   81.963148]        driver_probe_device+0x1f/0xa0
[   81.963182]        __device_attach_driver+0x89/0x110
[   81.963218]        bus_for_each_drv+0x98/0xf0
[   81.963250]        __device_attach_async_helper+0xa5/0xf0
[   81.964380]        async_run_entry_fn+0x31/0x130
[   81.965502]        process_one_work+0x21a/0x590
[   81.965868]        worker_thread+0x1c3/0x3b0
[   81.966198]        kthread+0xd2/0x100
[   81.966528]        ret_from_fork+0x31/0x50
[   81.966855]        ret_from_fork_asm+0x1a/0x30
[   81.967179]=20
               -> #3 (&q->limits_lock){+.+.}-{4:4}:
[   81.967815]        __mutex_lock+0xad/0xb80
[   81.968133]        nvme_update_ns_info_block+0x128/0x870 [nvme_core]
[   81.968456]        nvme_update_ns_info+0x41/0x220 [nvme_core]
[   81.968774]        nvme_alloc_ns+0x8a6/0xb50 [nvme_core]
[   81.969090]        nvme_scan_ns+0x251/0x330 [nvme_core]
[   81.969401]        async_run_entry_fn+0x31/0x130
[   81.969703]        process_one_work+0x21a/0x590
[   81.970004]        worker_thread+0x1c3/0x3b0
[   81.970302]        kthread+0xd2/0x100
[   81.970603]        ret_from_fork+0x31/0x50
[   81.970901]        ret_from_fork_asm+0x1a/0x30
[   81.971195]=20
               -> #2 (&q->q_usage_counter(io)){++++}-{0:0}:
[   81.971776]        blk_mq_submit_bio+0x90b/0xb00
[   81.972071]        __submit_bio+0xf0/0x1c0
[   81.972364]        submit_bio_noacct_nocheck+0x324/0x420
[   81.972660]        btrfs_submit_chunk+0x1a7/0x660
[   81.972956]        btrfs_submit_bbio+0x1a/0x30
[   81.973250]        read_extent_buffer_pages+0x15e/0x210
[   81.973546]        btrfs_read_extent_buffer+0x93/0x180
[   81.973841]        read_tree_block+0x30/0x60
[   81.974137]        read_block_for_search+0x219/0x320
[   81.974432]        btrfs_search_slot+0x335/0xd30
[   81.974729]        btrfs_init_root_free_objectid+0x90/0x130
[   81.975027]        open_ctree+0xa35/0x13eb
[   81.975326]        btrfs_get_tree.cold+0x6b/0xfd
[   81.975627]        vfs_get_tree+0x29/0xe0
[   81.975926]        fc_mount+0x12/0x40
[   81.976223]        btrfs_get_tree+0x2c1/0x6b0
[   81.976520]        vfs_get_tree+0x29/0xe0
[   81.976816]        vfs_cmd_create+0x59/0xe0
[   81.977112]        __do_sys_fsconfig+0x4f3/0x6c0
[   81.977408]        do_syscall_64+0x95/0x180
[   81.977705]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   81.978005]=20
               -> #1 (btrfs-root-01){++++}-{4:4}:
[   81.978595]        down_read_nested+0x34/0x150
[   81.978895]        btrfs_tree_read_lock_nested+0x25/0xd0
[   81.979195]        btrfs_read_lock_root_node+0x44/0xe0
[   81.979494]        btrfs_search_slot+0x143/0xd30
[   81.979793]        btrfs_search_backwards+0x2e/0x90
[   81.980108]        btrfs_get_subvol_name_from_objectid+0xd8/0x3c0
[   81.980409]        btrfs_show_options+0x294/0x780
[   81.980718]        show_mountinfo+0x207/0x2a0
[   81.981025]        seq_read_iter+0x2bc/0x480
[   81.981327]        vfs_read+0x294/0x370
[   81.981628]        ksys_read+0x73/0xf0
[   81.981925]        do_syscall_64+0x95/0x180
[   81.982222]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   81.982523]=20
               -> #0 (namespace_sem){++++}-{4:4}:
[   81.983116]        __lock_acquire+0x13ac/0x2170
[   81.983415]        lock_acquire+0xd0/0x2f0
[   81.983714]        down_write+0x2e/0xb0
[   81.984014]        finish_automount+0x77/0x3a0
[   81.984313]        __traverse_mounts+0x9d/0x210
[   81.984612]        step_into+0x349/0x770
[   81.984909]        link_path_walk.part.0.constprop.0+0x21e/0x390
[   81.985211]        path_lookupat+0x3e/0x1a0
[   81.985511]        filename_lookup+0xde/0x1d0
[   81.985811]        vfs_statx+0x8d/0x100
[   81.986108]        vfs_fstatat+0x63/0xc0
[   81.986405]        __do_sys_newfstatat+0x3c/0x80
[   81.986704]        do_syscall_64+0x95/0x180
[   81.987005]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   81.987307]=20
               other info that might help us debug this:

[   81.988204] Chain exists of:
                 namespace_sem --> &q->debugfs_mutex --> &sb->s_type-
>i_mutex_key#3

[   81.989113]  Possible unsafe locking scenario:

[   81.989723]        CPU0                    CPU1
[   81.990028]        ----                    ----
[   81.990331]   lock(&sb->s_type->i_mutex_key#3);
[   81.990637]                                lock(&q->debugfs_mutex);
[   81.990947]                                lock(&sb->s_type-
>i_mutex_key#3);
[   81.991257]   lock(namespace_sem);
[   81.991565]=20
                *** DEADLOCK ***

[   81.992465] 1 lock held by bash/2744:
[   81.992766]  #0: ffff8d7a8051ce50 (&sb->s_type-
>i_mutex_key#3){++++}-{4:4}, at: finish_automount+0x6b/0x3a0
[   81.993084]=20
               stack backtrace:
[   81.993704] CPU: 2 UID: 0 PID: 2744 Comm: bash Tainted: G     U   =20
6.12.0-rc4+ #3
[   81.994025] Tainted: [U]=3DUSER
[   81.994343] Hardware name: ASUS System Product Name/PRIME B560M-A
AC, BIOS 2001 02/01/2023
[   81.994673] Call Trace:
[   81.995002]  <TASK>
[   81.995328]  dump_stack_lvl+0x6e/0xa0
[   81.995657]  print_circular_bug.cold+0x178/0x1be
[   81.995987]  check_noncircular+0x148/0x160
[   81.996318]  __lock_acquire+0x13ac/0x2170
[   81.996649]  lock_acquire+0xd0/0x2f0
[   81.996978]  ? finish_automount+0x77/0x3a0
[   81.997328]  ? vfs_kern_mount.part.0+0x50/0xb0
[   81.997660]  ? kfree+0xd8/0x370
[   81.997991]  down_write+0x2e/0xb0
[   81.998318]  ? finish_automount+0x77/0x3a0
[   81.998646]  finish_automount+0x77/0x3a0
[   81.998975]  __traverse_mounts+0x9d/0x210
[   81.999303]  step_into+0x349/0x770
[   81.999629]  link_path_walk.part.0.constprop.0+0x21e/0x390
[   81.999958]  path_lookupat+0x3e/0x1a0
[   82.000287]  filename_lookup+0xde/0x1d0
[   82.000618]  vfs_statx+0x8d/0x100
[   82.000944]  ? strncpy_from_user+0x22/0xf0
[   82.001271]  vfs_fstatat+0x63/0xc0
[   82.001614]  __do_sys_newfstatat+0x3c/0x80
[   82.001943]  do_syscall_64+0x95/0x180
[   82.002270]  ? lockdep_hardirqs_on_prepare+0xdb/0x190
[   82.002601]  ? syscall_exit_to_user_mode+0x97/0x290
[   82.002933]  ? do_syscall_64+0xa1/0x180
[   82.003262]  ? lockdep_hardirqs_on_prepare+0xdb/0x190
[   82.003592]  ? syscall_exit_to_user_mode+0x97/0x290
[   82.003923]  ? clear_bhb_loop+0x45/0xa0
[   82.004251]  ? clear_bhb_loop+0x45/0xa0
[   82.004576]  ? clear_bhb_loop+0x45/0xa0
[   82.004899]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   82.005224] RIP: 0033:0x7f82fa5ef73e
[   82.005558] Code: 0f 1f 40 00 48 8b 15 d1 66 10 00 f7 d8 64 89 02 b8
ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 41 89 ca b8 06 01 00 00 0f
05 <3d> 00 f0 ff ff 77 0b 31 c0 c3 0f 1f 84 00 00 00 00 00 48 8b 15 99
[   82.005925] RSP: 002b:00007ffd2e30cd98 EFLAGS: 00000246 ORIG_RAX:
0000000000000106
[   82.006301] RAX: ffffffffffffffda RBX: 000055dfa1952b30 RCX:
00007f82fa5ef73e
[   82.006678] RDX: 00007ffd2e30cdc0 RSI: 000055dfa1952b10 RDI:
00000000ffffff9c
[   82.007057] RBP: 00007ffd2e30ce90 R08: 000055dfa1952b30 R09:
00007f82fa6f6b20
[   82.007437] R10: 0000000000000000 R11: 0000000000000246 R12:
000055dfa1952b11
[   82.007822] R13: 000055dfa1952b30 R14: 000055dfa1952b11 R15:
0000000000000003
[   82.008209]  </TASK>
=20



