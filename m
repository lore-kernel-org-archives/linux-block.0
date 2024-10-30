Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08921E47A8;
	Wed, 30 Oct 2024 10:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730284811; cv=none; b=UXgmOAo96kIyP5g7wTde5KDhD7q7vFdfh3SgZeBHZwZRLAKfgkfTYCQyKNPuQmuM7e1VLZlQh5WWy41beCeB55/blN04SYKBYWdWbrlBR491+f/2Vt1ZI2w1roN6f1K9pMDFPcEj0ocRr97PbJQZ2/ym3IT/6U5GDWwjAYZkp9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730284811; c=relaxed/simple;
	bh=Beu2G9fqaW0aV7Joe95llfKhihnQgcoRUyGFvd6qS6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IjPiyz2Qj1Ejk97MtElw99gl+SWW+3WqcG03MKXFvZniy0YCN8KmbmrXrTZR52oDEwg5up1w3NbCZzOiTNhQyGPvlqxkFkE/rIzp41PpZVD2LMFmtCKUG7NlaVidRSzOAXExgbSguCvnqAyyFUnKw35x7GlKk9iBEs2E5nLLUsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JLLEosZH; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JLLEosZH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730284809; x=1761820809;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Beu2G9fqaW0aV7Joe95llfKhihnQgcoRUyGFvd6qS6w=;
  b=JLLEosZHy85a204M+TtRhMslthyza3smrslperSixTx8Sv9Ftfl2hBpC
   d8JJEJN2XkO7hs4xdBjzGcEk9p5E9oVp1zVnEQ8Q+iWO0UWJplywVHgXb
   hojYhBSoGm+pvCq+9lxusPuxeVZiAepSvwPXLGiIJH1gC6Dk15lvCHXsR
   jhi3lxRyib1XTjTen+8Vd0RyhFNYzvD3zEZgLMi/Tri0dTxLvzFkBFEou
   ZWC0DEoz+A3flatGAYoGl418MWN1v7MhBBp7xuEe5y9ETtaeMJcX4e2i5
   /+XZN3L+PUCECv6i44Ozy7mawowUZa3dKHk8jcqNsCg5dfKuk0Ah42lVc
   g==;
X-CSE-ConnectionGUID: gEJYNRwvRNGPo3tPZ58W4g==
X-CSE-MsgGUID: 8iJF7pBWQxmNvujg9+C8Fg==
X-IronPort-AV: E=McAfee;i="6700,10204,11240"; a="41379718"
X-IronPort-AV: E=Sophos;i="6.11,244,1725346800"; 
   d="scan'208";a="41379718"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 03:40:09 -0700
X-CSE-ConnectionGUID: fF+2RlqhRQqxlOtF99j+IA==
X-CSE-MsgGUID: u5LqDYe5S0WSO8bomquhbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,244,1725346800"; 
   d="scan'208";a="113074771"
Received: from ly-workstation.sh.intel.com (HELO ly-workstation) ([10.239.161.23])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 03:40:03 -0700
Date: Wed, 30 Oct 2024 18:39:13 +0800
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
Message-ID: <ZyIM0dWzxC9zBIuf@ly-workstation>
References: <20241025003722.3630252-1-ming.lei@redhat.com>
 <20241025003722.3630252-4-ming.lei@redhat.com>
 <ZyHV7xTccCwN8j7b@ly-workstation>
 <ZyHchfaUe2cEzFMm@fedora>
 <ZyHzb8ExdDG4b8lo@ly-workstation>
 <CAFj5m9+bL23T7mMwR7g_8umTzkNJa14n8AhR3_g6QjB2YCcc5A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFj5m9+bL23T7mMwR7g_8umTzkNJa14n8AhR3_g6QjB2YCcc5A@mail.gmail.com>

On Wed, Oct 30, 2024 at 05:50:15PM +0800, Ming Lei wrote:
> On Wed, Oct 30, 2024 at 4:51 PM Lai, Yi <yi1.lai@linux.intel.com> wrote:
> >
> > On Wed, Oct 30, 2024 at 03:13:09PM +0800, Ming Lei wrote:
> > > On Wed, Oct 30, 2024 at 02:45:03PM +0800, Lai, Yi wrote:
> ...
> > >
> > > It should be addressed by the following patch:
> > >
> > > https://lore.kernel.org/linux-block/ZyEGLdg744U_xBjp@fedora/
> > >
> >
> > I have applied proposed fix patch on top of next-20241029. Issue can
> > still be reproduced.
> >
> > It seems the dependency chain is different from Marek's log and mine.
> 
> Can you post the new log since q->q_usage_counter(io)->fs_reclaim from
> blk_mq_init_sched is cut down by the patch?
>

New possible deadlock log after patch applied:

[   52.485023] repro: page allocation failure: order:1, mode:0x10cc0(GFP_KERNEL|__GFP_NORETRY), nodemask=(null),cpuset=/,mems0
[   52.486074] CPU: 1 UID: 0 PID: 635 Comm: repro Not tainted 6.12.0-rc5-next-20241029-kvm-dirty #6
[   52.486752] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/014
[   52.487616] Call Trace:
[   52.487820]  <TASK>
[   52.488001]  dump_stack_lvl+0x121/0x150
[   52.488345]  dump_stack+0x19/0x20
[   52.488616]  warn_alloc+0x218/0x350
[   52.488913]  ? __pfx_warn_alloc+0x10/0x10
[   52.489263]  ? __alloc_pages_direct_compact+0x130/0xa10
[   52.489699]  ? __pfx___alloc_pages_direct_compact+0x10/0x10
[   52.490151]  ? __drain_all_pages+0x27b/0x480
[   52.490522]  __alloc_pages_slowpath.constprop.0+0x14d6/0x21e0
[   52.491018]  ? __pfx___alloc_pages_slowpath.constprop.0+0x10/0x10
[   52.491519]  ? lock_is_held_type+0xef/0x150
[   52.491875]  ? __pfx_get_page_from_freelist+0x10/0x10
[   52.492291]  ? lock_acquire+0x80/0xb0
[   52.492619]  __alloc_pages_noprof+0x5d4/0x6f0
[   52.492992]  ? __pfx___alloc_pages_noprof+0x10/0x10
[   52.493405]  ? __sanitizer_cov_trace_switch+0x58/0xa0
[   52.493830]  ? policy_nodemask+0xf9/0x450
[   52.494169]  alloc_pages_mpol_noprof+0x30a/0x580
[   52.494561]  ? __pfx_alloc_pages_mpol_noprof+0x10/0x10
[   52.494982]  ? sysvec_apic_timer_interrupt+0x6a/0xd0
[   52.495396]  ? asm_sysvec_apic_timer_interrupt+0x1f/0x30
[   52.495845]  alloc_pages_noprof+0xa9/0x180
[   52.496201]  kimage_alloc_pages+0x79/0x240
[   52.496558]  kimage_alloc_control_pages+0x1cb/0xa60
[   52.496982]  ? __pfx_kimage_alloc_control_pages+0x10/0x10
[   52.497437]  ? __sanitizer_cov_trace_const_cmp1+0x1e/0x30
[   52.497897]  do_kexec_load+0x3a6/0x8e0
[   52.498228]  ? __pfx_do_kexec_load+0x10/0x10
[   52.498593]  ? __sanitizer_cov_trace_const_cmp8+0x1c/0x30
[   52.499035]  ? _copy_from_user+0xb6/0xf0
[   52.499371]  __x64_sys_kexec_load+0x1cc/0x240
[   52.499740]  x64_sys_call+0xf0f/0x20d0
[   52.500055]  do_syscall_64+0x6d/0x140
[   52.500367]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   52.500778] RIP: 0033:0x7f310423ee5d
[   52.501077] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c88
[   52.502494] RSP: 002b:00007fffcecca558 EFLAGS: 00000207 ORIG_RAX: 00000000000000f6
[   52.503087] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f310423ee5d
[   52.503644] RDX: 0000000020000040 RSI: 0000000000000009 RDI: 0000000000000000
[   52.504198] RBP: 00007fffcecca560 R08: 00007fffcecc9fd0 R09: 00007fffcecca590
[   52.504767] R10: 0000000000000000 R11: 0000000000000207 R12: 00007fffcecca6d8
[   52.505345] R13: 0000000000401c72 R14: 0000000000403e08 R15: 00007f3104469000
[   52.505949]  </TASK>
[   52.506239] Mem-Info:
[   52.506449] active_anon:119 inactive_anon:14010 isolated_anon:0
[   52.506449]  active_file:17895 inactive_file:87 isolated_file:0
[   52.506449]  unevictable:0 dirty:15 writeback:0
[   52.506449]  slab_reclaimable:6957 slab_unreclaimable:20220
[   52.506449]  mapped:11598 shmem:1150 pagetables:766
[   52.506449]  sec_pagetables:0 bounce:0
[   52.506449]  kernel_misc_reclaimable:0
[   52.506449]  free:13776 free_pcp:99 free_cma:0
[   52.509456] Node 0 active_anon:476kB inactive_anon:56040kB active_file:71580kB inactive_file:348kB unevictable:0kB isolateo
[   52.511881] Node 0 DMA free:440kB boost:0kB min:440kB low:548kB high:656kB reserved_highatomic:0KB active_anon:0kB inactivB
[   52.513883] lowmem_reserve[]: 0 1507 0 0 0
[   52.514269] Node 0 DMA32 free:54664kB boost:0kB min:44612kB low:55764kB high:66916kB reserved_highatomic:0KB active_anon:4B
[   52.516485] lowmem_reserve[]: 0 0 0 0 0
[   52.516831] Node 0 DMA: 0*4kB 1*8kB (U) 1*16kB (U) 1*32kB (U) 0*64kB 1*128kB (U) 1*256kB (U) 0*512kB 0*1024kB 0*2048kB 0*4B
[   52.517895] Node 0 DMA32: 2970*4kB (UME) 1123*8kB (UME) 532*16kB (UME) 280*32kB (UM) 126*64kB (UM) 27*128kB (UME) 9*256kB B
[   52.519279] Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
[   52.519387]
[   52.519971] Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=2048kB
[   52.520138] ======================================================
[   52.520805] 19113 total pagecache pages
[   52.521702] WARNING: possible circular locking dependency detected
[   52.522016] 0 pages in swap cache
[   52.522022] Free swap  = 124984kB
[   52.522027] Total swap = 124996kB
[   52.523720] 6.12.0-rc5-next-20241029-kvm-dirty #6 Not tainted
[   52.523741] ------------------------------------------------------
[   52.524059] 524158 pages RAM
[   52.525050] kswapd0/56 is trying to acquire lock:
[   52.525452] 0 pages HighMem/MovableOnly
[   52.525461] 129765 pages reserved
[   52.525465] 0 pages cma reserved
[   52.525469] 0 pages hwpoisoned
[   52.527163] ffff8880104374e8 (&q->q_usage_counter(io)#25){++++}-{0:0}, at: __submit_bio+0x39f/0x550
[   52.532396]
[   52.532396] but task is already holding lock:
[   52.533293] ffffffff872322a0 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat+0xb0f/0x1500
[   52.534508]
[   52.534508] which lock already depends on the new lock.
[   52.534508]
[   52.535723]
[   52.535723] the existing dependency chain (in reverse order) is:
[   52.536818]
[   52.536818] -> #2 (fs_reclaim){+.+.}-{0:0}:
[   52.537705]        lock_acquire+0x80/0xb0
[   52.538337]        fs_reclaim_acquire+0x116/0x160
[   52.539076]        blk_mq_alloc_and_init_hctx+0x4df/0x1200
[   52.539906]        blk_mq_realloc_hw_ctxs+0x4cf/0x610
[   52.540676]        blk_mq_init_allocated_queue+0x3da/0x11b0
[   52.541547]        blk_mq_alloc_queue+0x22c/0x300
[   52.542279]        __blk_mq_alloc_disk+0x34/0x100
[   52.543011]        loop_add+0x4c9/0xbd0
[   52.543622]        loop_init+0x133/0x1a0
[   52.544248]        do_one_initcall+0x114/0x5d0
[   52.544954]        kernel_init_freeable+0xab0/0xeb0
[   52.545732]        kernel_init+0x28/0x2f0
[   52.546366]        ret_from_fork+0x56/0x90
[   52.547009]        ret_from_fork_asm+0x1a/0x30
[   52.547698]
[   52.547698] -> #1 (&q->sysfs_lock){+.+.}-{4:4}:
[   52.548625]        lock_acquire+0x80/0xb0
[   52.549276]        __mutex_lock+0x17c/0x1540
[   52.549958]        mutex_lock_nested+0x1f/0x30
[   52.550664]        queue_attr_store+0xea/0x180
[   52.551360]        sysfs_kf_write+0x11f/0x180
[   52.552036]        kernfs_fop_write_iter+0x40e/0x630
[   52.552808]        vfs_write+0xc59/0x1140
[   52.553446]        ksys_write+0x14f/0x290
[   52.554068]        __x64_sys_write+0x7b/0xc0
[   52.554728]        x64_sys_call+0x1685/0x20d0
[   52.555397]        do_syscall_64+0x6d/0x140
[   52.556029]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   52.556865]
[   52.556865] -> #0 (&q->q_usage_counter(io)#25){++++}-{0:0}:
[   52.557963]        __lock_acquire+0x2ff8/0x5d60
[   52.558667]        lock_acquire.part.0+0x142/0x390
[   52.559427]        lock_acquire+0x80/0xb0
[   52.560057]        blk_mq_submit_bio+0x1cbe/0x2590
[   52.560801]        __submit_bio+0x39f/0x550
[   52.561473]        submit_bio_noacct_nocheck+0x647/0xcc0
[   52.562285]        submit_bio_noacct+0x620/0x1e00
[   52.563017]        submit_bio+0xce/0x480
[   52.563637]        __swap_writepage+0x2f1/0xdf0
[   52.564349]        swap_writepage+0x464/0xbc0
[   52.565022]        shmem_writepage+0xdeb/0x1340
[   52.565745]        pageout+0x3bc/0x9b0
[   52.566353]        shrink_folio_list+0x16b9/0x3b60
[   52.567104]        shrink_lruvec+0xd78/0x2790
[   52.567794]        shrink_node+0xb29/0x2870
[   52.568454]        balance_pgdat+0x9c2/0x1500
[   52.569142]        kswapd+0x765/0xe00
[   52.569741]        kthread+0x35a/0x470
[   52.570340]        ret_from_fork+0x56/0x90
[   52.570993]        ret_from_fork_asm+0x1a/0x30
[   52.571696]
[   52.571696] other info that might help us debug this:
[   52.571696]
[   52.572904] Chain exists of:
[   52.572904]   &q->q_usage_counter(io)#25 --> &q->sysfs_lock --> fs_reclaim
[   52.572904]
[   52.574631]  Possible unsafe locking scenario:
[   52.574631]
[   52.575547]        CPU0                    CPU1
[   52.576246]        ----                    ----
[   52.576942]   lock(fs_reclaim);
[   52.577467]                                lock(&q->sysfs_lock);
[   52.578382]                                lock(fs_reclaim);
[   52.579250]   rlock(&q->q_usage_counter(io)#25);
[   52.579974]
[   52.579974]  *** DEADLOCK ***
[   52.579974]
[   52.580866] 1 lock held by kswapd0/56:
[   52.581459]  #0: ffffffff872322a0 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat+0xb0f/0x1500
[   52.582731]
[   52.582731] stack backtrace:
[   52.583404] CPU: 0 UID: 0 PID: 56 Comm: kswapd0 Not tainted 6.12.0-rc5-next-20241029-kvm-dirty #6
[   52.584735] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/014
[   52.586439] Call Trace:
[   52.586836]  <TASK>
[   52.587190]  dump_stack_lvl+0xea/0x150
[   52.587753]  dump_stack+0x19/0x20
[   52.588253]  print_circular_bug+0x47f/0x750
[   52.588872]  check_noncircular+0x2f4/0x3e0
[   52.589492]  ? __pfx_check_noncircular+0x10/0x10
[   52.590180]  ? lockdep_lock+0xd0/0x1d0
[   52.590741]  ? __pfx_lockdep_lock+0x10/0x10
[   52.590790] kexec: Could not allocate control_code_buffer
[   52.591341]  __lock_acquire+0x2ff8/0x5d60
[   52.592365]  ? __pfx___lock_acquire+0x10/0x10
[   52.593087]  ? __pfx_mark_lock.part.0+0x10/0x10
[   52.593753]  ? __kasan_check_read+0x15/0x20
[   52.594366]  lock_acquire.part.0+0x142/0x390
[   52.594989]  ? __submit_bio+0x39f/0x550
[   52.595554]  ? __pfx_lock_acquire.part.0+0x10/0x10
[   52.596246]  ? debug_smp_processor_id+0x20/0x30
[   52.596900]  ? rcu_is_watching+0x19/0xc0
[   52.597484]  ? trace_lock_acquire+0x139/0x1b0
[   52.598118]  lock_acquire+0x80/0xb0
[   52.598633]  ? __submit_bio+0x39f/0x550
[   52.599191]  blk_mq_submit_bio+0x1cbe/0x2590
[   52.599805]  ? __submit_bio+0x39f/0x550
[   52.600361]  ? __kasan_check_read+0x15/0x20
[   52.600966]  ? __pfx_blk_mq_submit_bio+0x10/0x10
[   52.601632]  ? __pfx_mark_lock.part.0+0x10/0x10
[   52.602285]  ? __this_cpu_preempt_check+0x21/0x30
[   52.602968]  ? __this_cpu_preempt_check+0x21/0x30
[   52.603646]  ? lock_release+0x441/0x870
[   52.604207]  __submit_bio+0x39f/0x550
[   52.604742]  ? __pfx___submit_bio+0x10/0x10
[   52.605364]  ? __this_cpu_preempt_check+0x21/0x30
[   52.606045]  ? seqcount_lockdep_reader_access.constprop.0+0xb4/0xd0
[   52.606940]  ? __sanitizer_cov_trace_const_cmp1+0x1e/0x30
[   52.607707]  ? kvm_clock_get_cycles+0x43/0x70
[   52.608345]  submit_bio_noacct_nocheck+0x647/0xcc0
[   52.609045]  ? __pfx_submit_bio_noacct_nocheck+0x10/0x10
[   52.609820]  ? __sanitizer_cov_trace_switch+0x58/0xa0
[   52.610552]  submit_bio_noacct+0x620/0x1e00
[   52.611167]  submit_bio+0xce/0x480
[   52.611677]  __swap_writepage+0x2f1/0xdf0
[   52.612267]  swap_writepage+0x464/0xbc0
[   52.612837]  shmem_writepage+0xdeb/0x1340
[   52.613441]  ? __pfx_shmem_writepage+0x10/0x10
[   52.614090]  ? __kasan_check_write+0x18/0x20
[   52.614716]  ? folio_clear_dirty_for_io+0xc1/0x600
[   52.615403]  pageout+0x3bc/0x9b0
[   52.615894]  ? __pfx_pageout+0x10/0x10
[   52.616471]  ? __pfx_folio_referenced_one+0x10/0x10
[   52.617169]  ? __pfx_folio_lock_anon_vma_read+0x10/0x10
[   52.617918]  ? __pfx_invalid_folio_referenced_vma+0x10/0x10
[   52.618713]  shrink_folio_list+0x16b9/0x3b60
[   52.619346]  ? __pfx_shrink_folio_list+0x10/0x10
[   52.620021]  ? __this_cpu_preempt_check+0x21/0x30
[   52.620713]  ? mark_lock.part.0+0xf3/0x17b0
[   52.621339]  ? isolate_lru_folios+0xcb1/0x1250
[   52.621991]  ? __pfx_mark_lock.part.0+0x10/0x10
[   52.622655]  ? __this_cpu_preempt_check+0x21/0x30
[   52.623335]  ? lock_release+0x441/0x870
[   52.623900]  ? __this_cpu_preempt_check+0x21/0x30
[   52.624573]  ? _raw_spin_unlock_irq+0x2c/0x60
[   52.625204]  ? lockdep_hardirqs_on+0x89/0x110
[   52.625848]  shrink_lruvec+0xd78/0x2790
[   52.626422]  ? __pfx_shrink_lruvec+0x10/0x10
[   52.627040]  ? __this_cpu_preempt_check+0x21/0x30
[   52.627729]  ? __this_cpu_preempt_check+0x21/0x30
[   52.628423]  ? trace_lock_acquire+0x139/0x1b0
[   52.629061]  ? trace_lock_acquire+0x139/0x1b0
[   52.629752]  shrink_node+0xb29/0x2870
[   52.630305]  ? __pfx_shrink_node+0x10/0x10
[   52.630899]  ? pgdat_balanced+0x1d4/0x230
[   52.631490]  balance_pgdat+0x9c2/0x1500
[   52.632055]  ? __pfx_balance_pgdat+0x10/0x10
[   52.632669]  ? __this_cpu_preempt_check+0x21/0x30
[   52.633380]  kswapd+0x765/0xe00
[   52.633861]  ? __pfx_kswapd+0x10/0x10
[   52.634393]  ? local_clock_noinstr+0xb0/0xd0
[   52.635015]  ? __pfx_autoremove_wake_function+0x10/0x10
[   52.635759]  ? __sanitizer_cov_trace_const_cmp1+0x1e/0x30
[   52.636525]  ? __kthread_parkme+0x15d/0x230
[   52.637134]  kthread+0x35a/0x470
[   52.637616]  ? __pfx_kswapd+0x10/0x10
[   52.638146]  ? __pfx_kthread+0x10/0x10
[   52.638693]  ret_from_fork+0x56/0x90
[   52.639227]  ? __pfx_kthread+0x10/0x10
[   52.639778]  ret_from_fork_asm+0x1a/0x30
[   52.640391]  </TASK>


> Thanks,
> Ming
> 
