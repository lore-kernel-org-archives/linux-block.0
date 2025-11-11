Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482121D79BE;
	Tue, 11 Nov 2025 07:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762847317; cv=none; b=iymo3I/UIAFNgXpc9unfUVzLn6hN41U+JN8043LBcykeOPJkyg9aX0g4z+vHHZZDLJhKl4mDNSrSNlnAzLlNP636yYxxJZqjLWoVlYuHOWW//KGnTOKV686I2t0yO3wBC6dV1c1KFya3s+ZYX89socLqE62yTCH6YuZBVw6HoTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762847317; c=relaxed/simple;
	bh=kxVONHuGjjteovUBxV3HVIeM3I5L7gMnD9QPcae3xTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UKAzHzaCaY9jHMMhbM+t0iQAGROgj2a5tukh426TMwbWuGBhDrzyd7qdUM5EwefnASTL17/pzl1EA0Zbyufuec/eKgjQKfnYDVB+Vlj+0H0Nc3xikOUAI1DCqN3sE02/Mo5QjT0cqy+yLT0S0b9nyIsIzCDO40/ixlPKC4LYan4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3DEC9227A87; Tue, 11 Nov 2025 08:48:29 +0100 (CET)
Date: Tue, 11 Nov 2025 08:48:28 +0100
From: Christoph Hellwig <hch@lst.de>
To: kernel test robot <oliver.sang@intel.com>
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>, linux-mm@kvack.org,
	oe-lkp@lists.linux.dev, lkp@intel.com, Jens Axboe <axboe@kernel.dk>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: poison_element vs highmem, was Re: [linux-next:master] [block]
 ec7f31b2a2: BUG:unable_to_handle_page_fault_for_address
Message-ID: <20251111074828.GA6596@lst.de>
References: <202511111411.9ebfa1ba-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202511111411.9ebfa1ba-lkp@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks like this is due to the code in poison_element, which tries
to memset more than PAGE_SIZE for a single page.  This probably
implies we are the first users of the mempool page helpers for order > 0,
or at least the first one tested by anyone on 32-bit with highmem :)

That code seems to come from

commit bdfedb76f4f5aa5e37380e3b71adee4a39f30fc6
Author: David Rientjes <rientjes@google.com>
Date:   Wed Apr 15 16:14:17 2015 -0700

    mm, mempool: poison elements backed by slab allocator

originally.  The easiest fix would be to just skip poisoning for this
case, although that would reduce the usefulness of the poisoning.

On Tue, Nov 11, 2025 at 02:23:39PM +0800, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed "BUG:unable_to_handle_page_fault_for_address" on:
> 
> commit: ec7f31b2a2d3bf6b9e4d4b8cd156587f1d0607d5 ("block: make bio auto-integrity deadlock safe")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> 
> [test failed on linux-next/master 9c0826a5d9aa4d52206dd89976858457a2a8a7ed]
> 
> in testcase: boot
> 
> config: i386-randconfig-016-20251107
> compiler: clang-20
> test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 32G
> [    1.772326][    T1] Call Trace:
> [    1.772326][    T1]  poison_element (mm/mempool.c:83 mm/mempool.c:102)
> [    1.772326][    T1]  mempool_init_node (mm/mempool.c:142 mm/mempool.c:226)
> [    1.772326][    T1]  mempool_init_noprof (mm/mempool.c:250 (discriminator 1))
> [    1.772326][    T1]  ? mempool_alloc_pages (mm/mempool.c:640)
> [    1.772326][    T1]  bio_integrity_initfn (block/bio-integrity.c:483 (discriminator 8))
> [    1.772326][    T1]  ? mempool_alloc_pages (mm/mempool.c:640)
> [    1.772326][    T1]  do_one_initcall (init/main.c:1283)
> [    1.772326][    T1]  ? kvm_sched_clock_read (arch/x86/kernel/kvmclock.c:91)
> [    1.772326][    T1]  ? sched_clock_noinstr (arch/x86/kernel/tsc.c:271)
> [    1.772326][    T1]  ? local_clock_noinstr (kernel/sched/clock.c:272 kernel/sched/clock.c:309)
> [    1.772326][    T1]  ? __lock_acquire (kernel/locking/lockdep.c:4674 kernel/locking/lockdep.c:5191)
> [    1.772326][    T1]  ? kvm_sched_clock_read (arch/x86/kernel/kvmclock.c:91)
> [    1.772326][    T1]  ? sched_clock_noinstr (arch/x86/kernel/tsc.c:271)
> [    1.772326][    T1]  ? local_clock_noinstr (kernel/sched/clock.c:272 kernel/sched/clock.c:309)
> [    1.772326][    T1]  ? local_clock (arch/x86/include/asm/preempt.h:85 (discriminator 9) kernel/sched/clock.c:319 (discriminator 9))
> [    1.772326][    T1]  ? lock_release (kernel/locking/lockdep.c:353 kernel/locking/lockdep.c:5542 kernel/locking/lockdep.c:5889)
> [    1.772326][    T1]  ? clockevents_program_event (kernel/time/clockevents.c:?)
> [    1.772326][    T1]  ? ktime_get (include/linux/seqlock.h:391 (discriminator 3) include/linux/seqlock.h:411 (discriminator 3) kernel/time/timekeeping.c:828 (discriminator 3))
> [    1.772326][    T1]  ? sched_balance_trigger (kernel/sched/fair.c:?)
> [    1.772326][    T1]  ? run_posix_cpu_timers (include/linux/sched/deadline.h:15 include/linux/sched/deadline.h:24 kernel/time/posix-cpu-timers.c:1123 kernel/time/posix-cpu-timers.c:1428)
> [    1.772326][    T1]  ? clockevents_program_event (kernel/time/clockevents.c:336)
> [    1.772326][    T1]  ? update_process_times (kernel/time/timer.c:2481)
> [    1.772326][    T1]  ? tick_handle_periodic (kernel/time/tick-common.c:120)
> [    1.772326][    T1]  ? vmware_sched_clock (arch/x86/kernel/apic/apic.c:1052)
> [    1.772326][    T1]  ? trace_hardirqs_on (kernel/trace/trace_preemptirq.c:80)
> [    1.772326][    T1]  ? irqentry_exit (kernel/entry/common.c:224 (discriminator 32768))
> [    1.772326][    T1]  ? sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1052 (discriminator 6))
> [    1.772326][    T1]  ? handle_exception (arch/x86/entry/entry_32.S:1055)
> [    1.772326][    T1]  ? netdev_bits (lib/vsprintf.c:650 lib/vsprintf.c:695 lib/vsprintf.c:721 lib/vsprintf.c:1787)
> [    1.772326][    T1]  ? strlen (arch/x86/lib/string_32.c:167)
> [    1.772326][    T1]  ? next_arg (lib/cmdline.c:273)
> [    1.772326][    T1]  ? parameq (kernel/params.c:90 (discriminator 1) kernel/params.c:99 (discriminator 1))
> [    1.772326][    T1]  ? deadline_init (block/bio-integrity.c:482)
> [    1.772326][    T1]  do_initcall_level (init/main.c:1344 (discriminator 6))
> [    1.772326][    T1]  do_initcalls (init/main.c:1358 (discriminator 2))
> [    1.772326][    T1]  do_basic_setup (init/main.c:1381)
> [    1.772326][    T1]  kernel_init_freeable (init/main.c:1597)
> [    1.772326][    T1]  ? rest_init (init/main.c:1475)
> [    1.772326][    T1]  kernel_init (init/main.c:1485)
> [    1.772326][    T1]  ret_from_fork (arch/x86/kernel/process.c:164)
> [    1.772326][    T1]  ? rest_init (init/main.c:1475)
> [    1.772326][    T1]  ret_from_fork_asm (arch/x86/entry/entry_32.S:737)
> [    1.772326][    T1]  entry_INT80_32 (arch/x86/entry/entry_32.S:945)
> [    1.772326][    T1] Modules linked in:
> [    1.772326][    T1] CR2: 00000000fffba000
> [    1.772326][    T1] ---[ end trace 0000000000000000 ]---
> [    1.772326][    T1] EIP: memset (arch/x86/include/asm/string_32.h:168 arch/x86/lib/memcpy_32.c:17)
> [    1.772326][    T1] Code: a5 8b 4d f4 83 e1 03 74 02 f3 a4 83 c4 04 5e 5f 5d 2e e9 73 41 01 00 90 90 90 3e 8d 74 26 00 55 89 e5 57 56 89 c6 89 d0 89 f7 <f3> aa 89 f0 5e 5f 5d 2e e9 53 41 01 00 cc cc cc 55 89 e5 53 57 56
> All code
> ========
>    0:	a5                   	movsl  %ds:(%rsi),%es:(%rdi)
>    1:	8b 4d f4             	mov    -0xc(%rbp),%ecx
>    4:	83 e1 03             	and    $0x3,%ecx
>    7:	74 02                	je     0xb
>    9:	f3 a4                	rep movsb %ds:(%rsi),%es:(%rdi)
>    b:	83 c4 04             	add    $0x4,%esp
>    e:	5e                   	pop    %rsi
>    f:	5f                   	pop    %rdi
>   10:	5d                   	pop    %rbp
>   11:	2e e9 73 41 01 00    	cs jmp 0x1418a
>   17:	90                   	nop
>   18:	90                   	nop
>   19:	90                   	nop
>   1a:	3e 8d 74 26 00       	ds lea 0x0(%rsi,%riz,1),%esi
>   1f:	55                   	push   %rbp
>   20:	89 e5                	mov    %esp,%ebp
>   22:	57                   	push   %rdi
>   23:	56                   	push   %rsi
>   24:	89 c6                	mov    %eax,%esi
>   26:	89 d0                	mov    %edx,%eax
>   28:	89 f7                	mov    %esi,%edi
>   2a:*	f3 aa                	rep stos %al,%es:(%rdi)		<-- trapping instruction
>   2c:	89 f0                	mov    %esi,%eax
>   2e:	5e                   	pop    %rsi
>   2f:	5f                   	pop    %rdi
>   30:	5d                   	pop    %rbp
>   31:	2e e9 53 41 01 00    	cs jmp 0x1418a
>   37:	cc                   	int3
>   38:	cc                   	int3
>   39:	cc                   	int3
>   3a:	55                   	push   %rbp
>   3b:	89 e5                	mov    %esp,%ebp
> 
> 
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20251111/202511111411.9ebfa1ba-lkp@intel.com
> 
> 
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
---end quoted text---
