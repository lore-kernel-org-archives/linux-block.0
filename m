Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D2011CBA;
	Tue, 11 Mar 2025 12:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741695048; cv=none; b=tw63TyAjb8IA6iAZEHyDniN91cDVjCUiaEULZdXMtP88aZvSSkWt0TpwNVU/EyIY52APtb2LmjhDul5Sgz6ZFCuitvHxFGoowBYxeaXzvKiM10VWhPM+zeB2MEwGxST5WpxoL4tu2pBa2c44EdmwfwbY3OlFqp50xK5Lzc/A6e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741695048; c=relaxed/simple;
	bh=MPQEg5ZspKJem06ktpIpqTUrYZgcnEZSH61y0z6cE1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cjHCgWDuH+YWDsNhDRT75QRzPz+ntKoYN5434menu3z7RHy2bXwCilReiAjI+GexUiTl5nazWieP9Khcoe/EDMMTuI8H923QCVWm9+mT8ddyKyGcQtgZrw7EwTWtei0n0QA+foHGKlU3V+AUufLdfm4ZRdr+9JdHUXplONOdON4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hT8F7hR2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hT8F7hR2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32850C4CEEC;
	Tue, 11 Mar 2025 12:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741695047;
	bh=MPQEg5ZspKJem06ktpIpqTUrYZgcnEZSH61y0z6cE1w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hT8F7hR2KxabWlh8ZZQRGkj7dxr8nftImoYF0q+KU6VsZTTVREPRD2dnMRH0WX3l2
	 YmBXIlsDIwyIGHVU9B91AH2HAs7ObYRD2frrYHZAgSRe4ezF9qk7AwEXgOdTG4zd5q
	 7UMcUEZl2nlExVjCpCZ/bfV/TudPLcoAMZm/7EZ+YtxRRdgLBc1vf1Y6kj5bt78O44
	 ZvEpg4IAaoG+i+brns+Qq9ml/nrjlkEYHwseDkQxPnw5urGZLrgY2cTZV6Kfio5892
	 58IirZJbIozOINhm3+TfIz0tzqQX6cfTEY5izi5OMEKaK5gEaYXTKmnwGxTxJKFfde
	 28oEb6E1lj0VA==
Date: Tue, 11 Mar 2025 13:10:43 +0100
From: Christian Brauner <brauner@kernel.org>
To: kernel test robot <oliver.sang@intel.com>, 
	Luis Chamberlain <mcgrof@kernel.org>
Cc: Hannes Reinecke <hare@suse.de>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, John Garry <john.g.garry@oracle.com>, 
	linux-block@vger.kernel.org, ltp@lists.linux.it
Subject: Re: [linux-next:master] [block/bdev]  3c20917120:
 BUG:sleeping_function_called_from_invalid_context_at_mm/util.c
Message-ID: <20250311-testphasen-behelfen-09b950bbecbf@brauner>
References: <202503101536.27099c77-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202503101536.27099c77-lkp@intel.com>

On Mon, Mar 10, 2025 at 03:43:49PM +0800, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed "BUG:sleeping_function_called_from_invalid_context_at_mm/util.c" on:
> 
> commit: 3c20917120ce61f2a123ca0810293872f4c6b5a4 ("block/bdev: enable large folio support for large logical block sizes")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

Is this also already fixed by:

commit a64e5a596067 ("bdev: add back PAGE_SIZE block size validation for sb_set_blocksize()")

?

> 
> in testcase: ltp
> version: ltp-x86_64-0f9d817a3-1_20250222
> with following parameters:
> 
> 	disk: 1HDD
> 	fs: btrfs
> 	test: syscalls-04/close_range01
> 
> 
> 
> config: x86_64-rhel-9.4-ltp
> compiler: gcc-12
> test machine: 4 threads 1 sockets Intel(R) Core(TM) i3-3220 CPU @ 3.30GHz (Ivy Bridge) with 8G memory
> 
> (please refer to attached dmesg/kmsg for entire log/backtrace)
> 
> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202503101536.27099c77-lkp@intel.com
> 
> 
> [  218.427851][   T51] BUG: sleeping function called from invalid context at mm/util.c:901
> [  218.435981][   T51] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 51, name: kcompactd0
> [  218.444773][   T51] preempt_count: 1, expected: 0
> [  218.449601][   T51] RCU nest depth: 0, expected: 0
> [  218.454476][   T51] CPU: 2 UID: 0 PID: 51 Comm: kcompactd0 Tainted: G S                 6.14.0-rc1-00006-g3c20917120ce #1
> [  218.454486][   T51] Tainted: [S]=CPU_OUT_OF_SPEC
> [  218.454488][   T51] Hardware name: Hewlett-Packard HP Pro 3340 MT/17A1, BIOS 8.07 01/24/2013
> [  218.454492][   T51] Call Trace:
> [  218.454495][   T51]  <TASK>
> [ 218.454498][ T51] dump_stack_lvl (lib/dump_stack.c:123 (discriminator 1)) 
> [ 218.454508][ T51] __might_resched (kernel/sched/core.c:8767) 
> [ 218.454517][ T51] folio_mc_copy (include/linux/sched.h:2072 mm/util.c:901) 
> [ 218.454525][ T51] ? _raw_spin_lock (arch/x86/include/asm/atomic.h:107 include/linux/atomic/atomic-arch-fallback.h:2170 include/linux/atomic/atomic-instrumented.h:1302 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:187 include/linux/spinlock_api_smp.h:134 kernel/locking/spinlock.c:154) 
> [ 218.454532][ T51] __migrate_folio+0x11a/0x2d0 
> [ 218.454541][ T51] __buffer_migrate_folio (mm/migrate.c:945 mm/migrate.c:876) 
> [ 218.454548][ T51] move_to_new_folio (mm/migrate.c:1080) 
> [ 218.454555][ T51] migrate_folio_move (mm/migrate.c:1360) 
> [ 218.454562][ T51] ? __pfx_compaction_free (mm/compaction.c:1892) 
> [ 218.454572][ T51] ? __pfx_migrate_folio_move (mm/migrate.c:1349) 
> [ 218.454578][ T51] ? compaction_alloc_noprof (arch/x86/include/asm/bitops.h:206 arch/x86/include/asm/bitops.h:238 include/asm-generic/bitops/instrumented-non-atomic.h:142 include/linux/page-flags.h:829 include/linux/page-flags.h:850 mm/internal.h:711 mm/compaction.c:1878) 
> [ 218.454587][ T51] ? __pfx_compaction_alloc (mm/compaction.c:1882) 
> [ 218.454594][ T51] ? __pfx_compaction_free (mm/compaction.c:1892) 
> [ 218.454601][ T51] ? __pfx_compaction_free (mm/compaction.c:1892) 
> [ 218.454607][ T51] ? migrate_folio_unmap (arch/x86/include/asm/atomic.h:23 include/linux/atomic/atomic-arch-fallback.h:457 include/linux/atomic/atomic-instrumented.h:33 include/linux/mm.h:1257 include/linux/mm.h:1273 mm/migrate.c:1324) 
> [ 218.454614][ T51] migrate_pages_batch (mm/migrate.c:1721 mm/migrate.c:1959) 
> [ 218.454621][ T51] ? __pfx_compaction_free (mm/compaction.c:1892) 
> [ 218.454631][ T51] ? __pfx_migrate_pages_batch (mm/migrate.c:1779) 
> [ 218.454638][ T51] ? cgroup_rstat_updated (kernel/cgroup/rstat.c:45 kernel/cgroup/rstat.c:101) 
> [ 218.454648][ T51] migrate_pages_sync (mm/migrate.c:1992) 
> [ 218.454656][ T51] ? __pfx_compaction_alloc (mm/compaction.c:1882) 
> [ 218.454662][ T51] ? __pfx_compaction_free (mm/compaction.c:1892) 
> [ 218.454669][ T51] ? lru_gen_del_folio (include/linux/list.h:215 include/linux/list.h:229 include/linux/mm_inline.h:300) 
> [ 218.454677][ T51] ? __pfx_migrate_pages_sync (mm/migrate.c:1982) 
> [ 218.454683][ T51] ? set_pfnblock_flags_mask (mm/page_alloc.c:415 (discriminator 14)) 
> [ 218.454691][ T51] ? __pfx_lru_gen_del_folio (include/linux/mm_inline.h:284) 
> [ 218.454699][ T51] ? __pfx_compaction_alloc (mm/compaction.c:1882) 
> [ 218.454705][ T51] ? __pfx_compaction_free (mm/compaction.c:1892) 
> [ 218.454713][ T51] migrate_pages (mm/migrate.c:2098) 
> [ 218.454720][ T51] ? __pfx_compaction_alloc (mm/compaction.c:1882) 
> [ 218.454726][ T51] ? __pfx_compaction_free (mm/compaction.c:1892) 
> [ 218.454733][ T51] ? __pfx_buffer_migrate_folio_norefs (mm/migrate.c:936) 
> [ 218.454740][ T51] ? __pfx_migrate_pages (mm/migrate.c:2057) 
> [ 218.454748][ T51] ? isolate_migratepages (mm/compaction.c:2167) 
> [ 218.454757][ T51] compact_zone (mm/compaction.c:2667) 
> [ 218.454767][ T51] ? __pfx_compact_zone (mm/compaction.c:2529) 
> [ 218.454774][ T51] ? _raw_spin_lock_irqsave (arch/x86/include/asm/atomic.h:107 include/linux/atomic/atomic-arch-fallback.h:2170 include/linux/atomic/atomic-instrumented.h:1302 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:187 include/linux/spinlock_api_smp.h:111 kernel/locking/spinlock.c:162) 
> [ 218.454780][ T51] ? __pfx__raw_spin_lock_irqsave (kernel/locking/spinlock.c:161) 
> [ 218.454788][ T51] compact_node (mm/compaction.c:2934) 
> [ 218.454795][ T51] ? __pfx_compact_node (mm/compaction.c:2910) 
> [ 218.454807][ T51] ? __pfx_extfrag_for_order (mm/vmstat.c:1138) 
> [ 218.454814][ T51] ? __pfx_mutex_unlock (kernel/locking/mutex.c:518) 
> [ 218.454822][ T51] ? finish_wait (include/linux/list.h:215 include/linux/list.h:287 kernel/sched/wait.c:376) 
> [ 218.454831][ T51] kcompactd (mm/compaction.c:2235 mm/compaction.c:3227) 
> [ 218.454839][ T51] ? __pfx_kcompactd (mm/compaction.c:3179) 
> [ 218.454846][ T51] ? _raw_spin_lock_irqsave (arch/x86/include/asm/atomic.h:107 include/linux/atomic/atomic-arch-fallback.h:2170 include/linux/atomic/atomic-instrumented.h:1302 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:187 include/linux/spinlock_api_smp.h:111 kernel/locking/spinlock.c:162) 
> [ 218.454852][ T51] ? __pfx__raw_spin_lock_irqsave (kernel/locking/spinlock.c:161) 
> [ 218.454858][ T51] ? __pfx_autoremove_wake_function (kernel/sched/wait.c:383) 
> [ 218.454867][ T51] ? __kthread_parkme (arch/x86/include/asm/bitops.h:206 arch/x86/include/asm/bitops.h:238 include/asm-generic/bitops/instrumented-non-atomic.h:142 kernel/kthread.c:291) 
> [ 218.454874][ T51] ? __pfx_kcompactd (mm/compaction.c:3179) 
> [ 218.454880][ T51] kthread (kernel/kthread.c:464) 
> [ 218.454887][ T51] ? __pfx_kthread (kernel/kthread.c:413) 
> [ 218.454895][ T51] ? __pfx_kthread (kernel/kthread.c:413) 
> [ 218.454902][ T51] ret_from_fork (arch/x86/kernel/process.c:154) 
> [ 218.454910][ T51] ? __pfx_kthread (kernel/kthread.c:413) 
> [ 218.454915][ T51] ret_from_fork_asm (arch/x86/entry/entry_64.S:257) 
> [  218.454924][   T51]  </TASK>
> 
> 
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20250310/202503101536.27099c77-lkp@intel.com
> 
> 
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
> 
