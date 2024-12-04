Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA0713C9A3;
	Wed,  4 Dec 2024 03:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733282552; cv=none; b=COegDRVhwA2sjqoTYqKfc4yCnoxfTxAqPPWyG5+1kkmmF+rW+WGGI1+dCUnKNyRBbaTj2Sz5a0EwVqmIPcKhSG/06QzyEO0GhYYSNmTeGJ6IV+SKH1MZPvEiTdvK+6+SO8sdpx8DrwrkmyE82QEmxpkUrQ7swjqAMwNBNVBe3Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733282552; c=relaxed/simple;
	bh=5EhjxScwIyzpuGE8MVM5EwLlO/DD5ViAaA5dScO09lc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dOZ3IoNJ/p909Ts91J0RrpkaDlJaHpaagvudvGpokL+OnDU66B3E1SJdCoLCEJaUdqLOjuDZGEYJgNn7foTdxQ0nN5w6xnYZzicvkIZRx+ewM1BbcApk6FcaVpQWw1A2QvH8XMeH6WN/I5kcIduwpaX/ZH+4fe9U4uvYxl5FlCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VUf7dAUR; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VUf7dAUR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733282551; x=1764818551;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=5EhjxScwIyzpuGE8MVM5EwLlO/DD5ViAaA5dScO09lc=;
  b=VUf7dAURgiq/3ZsLms1sBOfJpidKlxte3BpXvNpf+szswhACIWGKHedx
   VZgaumjSfEoKUeegfTePM5Rm7xpXFIewUWlTHCJAeAZ8um5CKp/qIm8D8
   U3pnMVMdqA9mg80L1FKdg+9Rm/mAicUdWdGqRMUdZRKL8aVdloGJZrstC
   9iA/+Q58LI28IBeChzGgrLn/Po7VXoiFVOgDR5eps5t3KMb2ky3ADJ0i8
   C0jh+k6BqSnKFfvo9wz/2+2NFPCrRgd+n0k2Kl1qbg/mF7H8b0u1uuylW
   EOusv+XsvTgfods8hk6LSmQNMe4KlPofvdUG8VwFZZ78dqDnSDDXUK/GA
   w==;
X-CSE-ConnectionGUID: nU/YVcc6SFmc6XdhJznmMw==
X-CSE-MsgGUID: D2xkKYwsSMmm1vtLmWXzng==
X-IronPort-AV: E=McAfee;i="6700,10204,11275"; a="44008512"
X-IronPort-AV: E=Sophos;i="6.12,206,1728975600"; 
   d="scan'208";a="44008512"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 19:22:30 -0800
X-CSE-ConnectionGUID: Cqgru+mMRQyIVGFiJUe4eA==
X-CSE-MsgGUID: x54zsl90SA6gUj2bq4jyVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,206,1728975600"; 
   d="scan'208";a="116893604"
Received: from ly-workstation.sh.intel.com (HELO ly-workstation) ([10.239.161.23])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 19:22:27 -0800
Date: Wed, 4 Dec 2024 11:21:53 +0800
From: "Lai, Yi" <yi1.lai@linux.intel.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
	yi1.lai@intel.com, syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH V2 3/3] block: model freeze & enter queue as lock for
 supporting lockdep
Message-ID: <Z0/K0bDHBUWlt0Hl@ly-workstation>
References: <20241025003722.3630252-1-ming.lei@redhat.com>
 <20241025003722.3630252-4-ming.lei@redhat.com>
 <ZyHV7xTccCwN8j7b@ly-workstation>
 <ZyHchfaUe2cEzFMm@fedora>
 <ZyHzb8ExdDG4b8lo@ly-workstation>
 <CAFj5m9+bL23T7mMwR7g_8umTzkNJa14n8AhR3_g6QjB2YCcc5A@mail.gmail.com>
 <ZyIM0dWzxC9zBIuf@ly-workstation>
 <ZyITwN0ihIFiz9M2@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZyITwN0ihIFiz9M2@fedora>

On Wed, Oct 30, 2024 at 07:08:48PM +0800, Ming Lei wrote:
> On Wed, Oct 30, 2024 at 06:39:13PM +0800, Lai, Yi wrote:
> > On Wed, Oct 30, 2024 at 05:50:15PM +0800, Ming Lei wrote:
> > > On Wed, Oct 30, 2024 at 4:51 PM Lai, Yi <yi1.lai@linux.intel.com> wrote:
> > > >
> > > > On Wed, Oct 30, 2024 at 03:13:09PM +0800, Ming Lei wrote:
> > > > > On Wed, Oct 30, 2024 at 02:45:03PM +0800, Lai, Yi wrote:
> > > ...
> > > > >
> > > > > It should be addressed by the following patch:
> > > > >
> > > > > https://lore.kernel.org/linux-block/ZyEGLdg744U_xBjp@fedora/
> > > > >
> > > >
> > > > I have applied proposed fix patch on top of next-20241029. Issue can
> > > > still be reproduced.
> > > >
> > > > It seems the dependency chain is different from Marek's log and mine.
> > > 
> > > Can you post the new log since q->q_usage_counter(io)->fs_reclaim from
> > > blk_mq_init_sched is cut down by the patch?
> > >
> > 
> > New possible deadlock log after patch applied:
> 
> This one looks like one real deadlock, any memory allocation with
> q->sysfs_lock held has such risk.
> 
> There is another similar report related with queue sysfs store operation:
> 
> https://lore.kernel.org/linux-scsi/ZxG38G9BuFdBpBHZ@fedora/
>  
>
For v6.13-rc3, there is possible deadlock in
blk_trace_ioctl/perf_event_ctx_lock_nested/in blk_trace_ioctl. Based on
my bisection log, it all bisected to your commit f1be1788a32e block:
model freeze & enter queue as lock for supporting lockdep.

I am hoping this will be insightful to you.

possible deadlock in blk_trace_ioctl:
[   33.317360] ffff88800fc8f3e0 (&mm->mmap_lock){++++}-{4:4}, at: __might_fault+0xf1/0x1b0
[   33.317859]
[   33.317859] but task is already holding lock:
[   33.318206] ffff8880109b92e0 (&q->debugfs_mutex){+.+.}-{4:4}, at: blk_trace_ioctl+0xaa/0x290
[   33.318722]
[   33.318722] which lock already depends on the new lock.
[   33.318722]
[   33.319198]
[   33.319198] the existing dependency chain (in reverse order) is:
[   33.319637]
[   33.319637] -> #4 (&q->debugfs_mutex){+.+.}-{4:4}:
[   33.320018]        lock_acquire+0x80/0xb0
[   33.320270]        __mutex_lock+0x17c/0x1540
[   33.320555]        mutex_lock_nested+0x1f/0x30
[   33.320839]        blk_register_queue+0x146/0x510
[   33.321177]        add_disk_fwnode+0x7b7/0x1300
[   33.321490]        device_add_disk+0x31/0x40
[   33.321759]        brd_alloc.isra.0+0x4d4/0x710
[   33.322042]        brd_init+0x11e/0x1a0
[   33.322283]        do_one_initcall+0x114/0x5f0
[   33.322556]        kernel_init_freeable+0xab0/0xeb0
[   33.322857]        kernel_init+0x28/0x2f0
[   33.323108]        ret_from_fork+0x56/0x90
[   33.323362]        ret_from_fork_asm+0x1a/0x30
[   33.323638]
[   33.323638] -> #3 (&q->sysfs_lock){+.+.}-{4:4}:
[   33.324004]        lock_acquire+0x80/0xb0
[   33.324253]        __mutex_lock+0x17c/0x1540
[   33.324535]        mutex_lock_nested+0x1f/0x30
[   33.324814]        queue_attr_store+0xea/0x180
[   33.325127]        sysfs_kf_write+0x11f/0x180
[   33.325440]        kernfs_fop_write_iter+0x40e/0x630
[   33.325744]        vfs_write+0xc59/0x1140
[   33.325995]        ksys_write+0x14f/0x280
[   33.326242]        __x64_sys_write+0x7b/0xc0
[   33.326507]        x64_sys_call+0x16b3/0x2140
[   33.326776]        do_syscall_64+0x6d/0x140
[   33.327032]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   33.327367]
[   33.327367] -> #2 (&q->q_usage_counter(io)#25){++++}-{0:0}:
[   33.327796]        lock_acquire+0x80/0xb0
[   33.328045]        blk_mq_submit_bio+0x1b81/0x2430
[   33.328338]        __submit_bio+0x37b/0x530
[   33.328614]        submit_bio_noacct_nocheck+0x642/0xcd0
[   33.328940]        submit_bio_noacct+0x61f/0x1d10
[   33.329274]        submit_bio+0xce/0x480
[   33.329540]        submit_bh_wbc+0x58c/0x750
[   33.329807]        submit_bh+0x2b/0x40
[   33.330042]        ext4_read_bh_nowait+0x17f/0x260
[   33.330337]        ext4_sb_breadahead_unmovable+0xc3/0x100
[   33.330668]        __ext4_get_inode_loc+0x107c/0x1550
[   33.330977]        ext4_get_inode_loc+0xd1/0x180
[   33.331264]        ext4_reserve_inode_write+0xd7/0x280
[   33.331573]        __ext4_mark_inode_dirty+0x18b/0x8c0
[   33.331885]        ext4_ext_tree_init+0x163/0x1a0
[   33.332172]        __ext4_new_inode+0x4697/0x52d0
[   33.332458]        ext4_create+0x32e/0x550
[   33.332736]        lookup_open.isra.0+0x117c/0x1580
[   33.333047]        path_openat+0xdbf/0x2bf0
[   33.333343]        do_filp_open+0x1fd/0x460
[   33.333623]        do_sys_openat2+0x185/0x1f0
[   33.333892]        __x64_sys_openat+0x17a/0x240
[   33.334172]        x64_sys_call+0x1774/0x2140
[   33.334442]        do_syscall_64+0x6d/0x140
[   33.334696]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   33.335034]
[   33.335034] -> #1 (jbd2_handle){++++}-{0:0}:
[   33.335384]        lock_acquire+0x80/0xb0
[   33.335634]        start_this_handle+0x1081/0x1590
[   33.335926]        jbd2__journal_start+0x397/0x6b0
[   33.336216]        __ext4_journal_start_sb+0x458/0x600
[   33.336548]        ext4_dirty_inode+0xb3/0x140
[   33.336826]        __mark_inode_dirty+0x1cb/0xd80
[   33.337154]        generic_update_time+0xe0/0x110
[   33.337473]        touch_atime+0x514/0x5f0
[   33.337730]        ext4_file_mmap+0x344/0x6a0
[   33.338000]        __mmap_region+0x10e7/0x25a0
[   33.338273]        mmap_region+0x13b/0x2f0
[   33.338529]        do_mmap+0xd9b/0x11f0
[   33.338787]        vm_mmap_pgoff+0x1ea/0x390
[   33.339056]        vm_mmap+0xa3/0xd0
[   33.339290]        elf_load+0x3fe/0x750
[   33.339527]        load_elf_binary+0xe47/0x5260
[   33.339805]        bprm_execve+0x73b/0x1950
[   33.340063]        do_execveat_common.isra.0+0x521/0x650
[   33.340387]        __x64_sys_execve+0x96/0xc0
[   33.340677]        x64_sys_call+0x1b31/0x2140
[   33.340960]        do_syscall_64+0x6d/0x140
[   33.341267]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   33.341616]
[   33.341616] -> #0 (&mm->mmap_lock){++++}-{4:4}:
[   33.341989]        __lock_acquire+0x2ff8/0x5d60
[   33.342267]        lock_acquire.part.0+0x142/0x390
[   33.342564]        lock_acquire+0x80/0xb0
[   33.342814]        __might_fault+0x122/0x1b0
[   33.343079]        _copy_from_user+0x2e/0xa0
[   33.343347]        __blk_trace_setup+0xa3/0x190
[   33.343625]        blk_trace_ioctl+0x14c/0x290
[   33.343899]        blkdev_ioctl+0x11e/0x6a0
[   33.344161]        __x64_sys_ioctl+0x1ba/0x220
[   33.344434]        x64_sys_call+0x1227/0x2140
[   33.344724]        do_syscall_64+0x6d/0x140
[   33.344988]        entry_SYSCALL_64_after_hwframe+0x76/0x7e

possible deadlock in perf_event_ctx_lock_nested
[   36.357846] ffff88801108f3e0 (&mm->mmap_lock){++++}-{4:4}, at: __might_fault+0xf1/0x1b0
[   36.358351]
[   36.358351] but task is already holding lock:
[   36.358690] ffff88806c441508 (&cpuctx_mutex){+.+.}-{4:4}, at: perf_event_ctx_lock_nested+0x252/0x4f0
[   36.359229]
[   36.359229] which lock already depends on the new lock.
[   36.359229]
[   36.359695]
[   36.359695] the existing dependency chain (in reverse order) is:
[   36.360149]
[   36.360149] -> #6 (&cpuctx_mutex){+.+.}-{4:4}:
[   36.360521]        lock_acquire+0x80/0xb0
[   36.360770]        __mutex_lock+0x17c/0x1540
[   36.361036]        mutex_lock_nested+0x1f/0x30
[   36.361307]        perf_event_init_cpu+0x2be/0x910
[   36.361597]        perf_event_init+0x520/0x700
[   36.361888]        start_kernel+0x26e/0x550
[   36.362157]        x86_64_start_reservations+0x1c/0x30
[   36.362466]        x86_64_start_kernel+0xa0/0xb0
[   36.362744]        common_startup_64+0x13e/0x141
[   36.363023]
[   36.363023] -> #5 (pmus_lock){+.+.}-{4:4}:
[   36.363357]        lock_acquire+0x80/0xb0
[   36.363602]        __mutex_lock+0x17c/0x1540
[   36.363862]        mutex_lock_nested+0x1f/0x30
[   36.364155]        perf_event_init_cpu+0xd8/0x910
[   36.364450]        cpuhp_invoke_callback+0x3cf/0x9d0
[   36.364747]        __cpuhp_invoke_callback_range+0x11f/0x250
[   36.365084]        _cpu_up+0x3b0/0x7d0
[   36.365332]        cpu_up+0x192/0x220
[   36.365562]        cpuhp_bringup_mask+0x112/0x1c0
[   36.365878]        bringup_nonboot_cpus+0x1b8/0x200
[   36.366186]        smp_init+0x3c/0x140
[   36.366418]        kernel_init_freeable+0x8fc/0xeb0
[   36.366714]        kernel_init+0x28/0x2f0
[   36.366959]        ret_from_fork+0x56/0x90
[   36.367212]        ret_from_fork_asm+0x1a/0x30
[   36.367480]
[   36.367480] -> #4 (cpu_hotplug_lock){++++}-{0:0}:
[   36.367849]        lock_acquire+0x80/0xb0
[   36.368119]        __cpuhp_state_add_instance+0x58/0x2f0
[   36.368448]        blk_mq_alloc_and_init_hctx+0x270/0x1200
[   36.368776]        blk_mq_realloc_hw_ctxs+0x4cf/0x610
[   36.369079]        blk_mq_init_allocated_queue+0x3da/0x11b0
[   36.369428]        blk_mq_alloc_queue+0x225/0x2f0
[   36.369723]        __blk_mq_alloc_disk+0x34/0x100
[   36.370028]        loop_add+0x4bb/0xbc0
[   36.370274]        loop_init+0x133/0x1a0
[   36.370513]        do_one_initcall+0x114/0x5f0
[   36.370781]        kernel_init_freeable+0xab0/0xeb0
[   36.371079]        kernel_init+0x28/0x2f0
[   36.371323]        ret_from_fork+0x56/0x90
[   36.371573]        ret_from_fork_asm+0x1a/0x30
[   36.371841]
[   36.371841] -> #3 (&q->sysfs_lock){+.+.}-{4:4}:
[   36.372234]        lock_acquire+0x80/0xb0
[   36.372490]        __mutex_lock+0x17c/0x1540
[   36.372749]        mutex_lock_nested+0x1f/0x30
[   36.373021]        queue_attr_store+0xea/0x180
[   36.373291]        sysfs_kf_write+0x11f/0x180
[   36.373558]        kernfs_fop_write_iter+0x40e/0x630
[   36.373874]        vfs_write+0xc59/0x1140
[   36.374133]        ksys_write+0x14f/0x280
[   36.374376]        __x64_sys_write+0x7b/0xc0
[   36.374634]        x64_sys_call+0x16b3/0x2140
[   36.374901]        do_syscall_64+0x6d/0x140
[   36.375150]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   36.375502]
[   36.375502] -> #2 (&q->q_usage_counter(io)#25){++++}-{0:0}:
[   36.375956]        lock_acquire+0x80/0xb0
[   36.376216]        blk_mq_submit_bio+0x1b81/0x2430
[   36.376503]        __submit_bio+0x37b/0x530
[   36.376753]        submit_bio_noacct_nocheck+0x642/0xcd0
[   36.377068]        submit_bio_noacct+0x61f/0x1d10
[   36.377349]        submit_bio+0xce/0x480
[   36.377587]        submit_bh_wbc+0x58c/0x750
[   36.377864]        submit_bh+0x2b/0x40
[   36.378098]        ext4_read_bh_nowait+0x17f/0x260
[   36.378398]        ext4_sb_breadahead_unmovable+0xc3/0x100
[   36.378726]        __ext4_get_inode_loc+0x107c/0x1550
[   36.379030]        ext4_get_inode_loc+0xd1/0x180
[   36.379312]        ext4_reserve_inode_write+0xd7/0x280
[   36.379617]        __ext4_mark_inode_dirty+0x18b/0x8c0
[   36.379940]        ext4_ext_tree_init+0x163/0x1a0
[   36.380228]        __ext4_new_inode+0x4697/0x52d0
[   36.380520]        ext4_create+0x32e/0x550
[   36.380766]        lookup_open.isra.0+0x117c/0x1580
[   36.381059]        path_openat+0xdbf/0x2bf0
[   36.381310]        do_filp_open+0x1fd/0x460
[   36.381558]        do_sys_openat2+0x185/0x1f0
[   36.381839]        __x64_sys_openat+0x17a/0x240
[   36.382123]        x64_sys_call+0x1774/0x2140
[   36.382396]        do_syscall_64+0x6d/0x140
[   36.382646]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   36.382973]
[   36.382973] -> #1 (jbd2_handle){++++}-{0:0}:
[   36.383317]        lock_acquire+0x80/0xb0
[   36.383559]        start_this_handle+0x1081/0x1590
[   36.383844]        jbd2__journal_start+0x397/0x6b0
[   36.384153]        __ext4_journal_start_sb+0x458/0x600
[   36.384473]        ext4_dirty_inode+0xb3/0x140
[   36.384741]        __mark_inode_dirty+0x1cb/0xd80
[   36.385024]        generic_update_time+0xe0/0x110

possible deadlock in blk_trace_ioctl
[   42.443488] ======================================================
[   42.444172] WARNING: possible circular locking dependency detected
[   42.444846] 6.12.0-rc4+ #1 Not tainted
[   42.445265] ------------------------------------------------------
[   42.445936] repro/724 is trying to acquire lock:
[   42.446451] ffff8880055e4b98 (&mm->mmap_lock){++++}-{3:3}, at: __might_fault+0xf1/0x1b0
[   42.447368]
[   42.447368] but task is already holding lock:
[   42.448012] ffff8880050f2fc0 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_ioctl+0xaa/0x290
[   42.448969]
[   42.448969] which lock already depends on the new lock.
[   42.448969]
[   42.449879]
[   42.449879] the existing dependency chain (in reverse order) is:
[   42.450713]
[   42.450713] -> #3 (&q->debugfs_mutex){+.+.}-{3:3}:
[   42.451442]        lock_acquire+0x80/0xb0
[   42.451907]        __mutex_lock+0x15c/0x1490
[   42.452410]        mutex_lock_nested+0x1f/0x30
[   42.452934]        blk_mq_init_sched+0x46e/0x6d0
[   42.453475]        elevator_init_mq+0x2b2/0x400
[   42.453999]        add_disk_fwnode+0x11c/0x1300
[   42.454524]        device_add_disk+0x31/0x40
[   42.455017]        sd_probe+0xa79/0x1080
[   42.455473]        really_probe+0x27c/0xac0
[   42.455952]        __driver_probe_device+0x1f3/0x460
[   42.456515]        driver_probe_device+0x56/0x1b0
[   42.457052]        __device_attach_driver+0x1e7/0x300
[   42.457625]        bus_for_each_drv+0x159/0x1e0
[   42.458155]        __device_attach_async_helper+0x1e4/0x2a0
[   42.458792]        async_run_entry_fn+0xa3/0x450
[   42.459336]        process_one_work+0x92e/0x1b50
[   42.459870]        worker_thread+0x68d/0xe90
[   42.460371]        kthread+0x35a/0x470
[   42.460808]        ret_from_fork+0x56/0x90
[   42.461288]        ret_from_fork_asm+0x1a/0x30
[   42.461802]
[   42.461802] -> #2 (&q->q_usage_counter(io)#25){++++}-{0:0}:
[   42.462618]        lock_acquire+0x80/0xb0
[   42.463083]        blk_mq_submit_bio+0x1cb8/0x2580
[   42.463628]        __submit_bio+0x39f/0x550
[   42.464116]        submit_bio_noacct_nocheck+0x6a0/0xcc0
[   42.464717]        submit_bio_noacct+0x61d/0x1dc0
[   42.465258]        submit_bio+0xce/0x480
[   42.465711]        submit_bh_wbc+0x58a/0x740
[   42.466220]        submit_bh+0x2b/0x40
[   42.466668]        ext4_read_bh+0x14e/0x2c0
[   42.467163]        ext4_read_bh_lock+0x88/0xd0
[   42.467685]        ext4_block_zero_page_range+0x486/0xa20
[   42.468298]        ext4_truncate+0xe7e/0x1210
[   42.468802]        ext4_setattr+0x1b10/0x2560
[   42.470507]        notify_change+0x6d8/0x1270
[   42.471000]        do_truncate+0x171/0x240
[   42.471488]        do_ftruncate+0x602/0x750
[   42.471967]        do_sys_ftruncate+0x71/0xd0
[   42.472471]        __x64_sys_ftruncate+0x61/0x90
[   42.472999]        x64_sys_call+0x553/0x20d0
[   42.473501]        do_syscall_64+0x6d/0x140
[   42.473984]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   42.474617]
[   42.474617] -> #1 (jbd2_handle){++++}-{0:0}:
[   42.475277]        lock_acquire+0x80/0xb0
[   42.475742]        start_this_handle+0x1081/0x1590
[   42.476292]        jbd2__journal_start+0x397/0x6b0
[   42.476841]        __ext4_journal_start_sb+0x466/0x600
[   42.477424]        ext4_dirty_inode+0xb3/0x140
[   42.477936]        __mark_inode_dirty+0x1d0/0xd50
[   42.478480]        generic_update_time+0xe0/0x110
[   42.479022]        touch_atime+0x514/0x5f0
[   42.479507]        ext4_file_mmap+0x344/0x6a0
[   42.480005]        mmap_region+0x1152/0x29c0
[   42.480510]        do_mmap+0xd9b/0x11f0
[   42.480963]        vm_mmap_pgoff+0x1ea/0x390
[   42.481456]        ksys_mmap_pgoff+0x3dc/0x520
[   42.481972]        __x64_sys_mmap+0x139/0x1d0
[   42.482480]        x64_sys_call+0x18c6/0x20d0
[   42.482981]        do_syscall_64+0x6d/0x140
[   42.483467]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   42.484106]
[   42.484106] -> #0 (&mm->mmap_lock){++++}-{3:3}:
[   42.484786]        __lock_acquire+0x2f1b/0x5c90
[   42.485307]        lock_acquire.part.0+0x142/0x390
[   42.485851]        lock_acquire+0x80/0xb0
[   42.486316]        __might_fault+0x122/0x1b0
[   42.486807]        _copy_from_user+0x33/0xe0
[   42.487311]        __blk_trace_setup+0xa3/0x190
[   42.487837]        blk_trace_ioctl+0x14c/0x290
[   42.488345]        blkdev_ioctl+0x11e/0x6a0
[   42.488819]        __x64_sys_ioctl+0x1b5/0x230
[   42.489334]        x64_sys_call+0x1209/0x20d0
[   42.489854]        do_syscall_64+0x6d/0x140
[   42.490354]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   42.491011]
[   42.491011] other info that might help us debug this:
[   42.491011]
[   42.491866] Chain exists of:
[   42.491866]   &mm->mmap_lock --> &q->q_usage_counter(io)#25 --> &q->debugfs_mutex
[   42.491866]
[   42.493153]  Possible unsafe locking scenario:
[   42.493153]
[   42.493788]        CPU0                    CPU1
[   42.494285]        ----                    ----
[   42.494780]   lock(&q->debugfs_mutex);
[   42.495207]                                lock(&q->q_usage_counter(io)#25);
[   42.495978]                                lock(&q->debugfs_mutex);
[   42.496697]   rlock(&mm->mmap_lock);
[   42.497121]
[   42.497121]  *** DEADLOCK ***

Regards,
Yi Lai

> 
> 
> Thanks,
> Ming
> 
