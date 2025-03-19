Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9AB1DF269;
	Wed, 19 Mar 2025 16:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742403312; cv=none; b=tL9pIP2uPhYrbQJ8XDPDAkCtTd1a63JGpSiCo1yV+YiC1dGBp/odAvw0yz4uciHp/2Ha0FTb9O5X+P62QlKGWwkPm/jnMbjINag2Cg+u4mFOPRlYQeid58ZWLbPBI5RxKrCZ1POx59d5VCaEEuPhDO8zk5NqhcSxu3d0MYMcZh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742403312; c=relaxed/simple;
	bh=YG1lqXuTVitaQTx0MKscRbh3Dt+lh4llH2H8fTLhHVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TOiLD7mb6cCTzRaoxhBn6l1Q+fH08p+5jmIm8pduNKz7KKkz6O5539BF0iHn06dSjp/Un/XwogJQL1TpsTlu+XShJUD4QHXxjc5SiQs7JeXN5iuy28ksElilk8XGTP7h2nE4alCdT9tk8N4s4mCAY4gT2sevt0zDfRb3ugSJlYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IXmBIYVS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IXmBIYVS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C37EC4CEE4;
	Wed, 19 Mar 2025 16:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742403311;
	bh=YG1lqXuTVitaQTx0MKscRbh3Dt+lh4llH2H8fTLhHVw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IXmBIYVSTqAzoxSG1SvTMbhRL/PzdtfzwMquPpbMeKO3DFJoSsUGG8AyK62d2RWLD
	 r6DA6gq0912rc9ovA21jhjVhSG6dqoJ8/ZwaRgxEhvV8H31c58N5hEL6ixGr3IPxu5
	 xOACRBra1xdzICRa2xlFvYl/D+JuubVF6dovL3QmbDbbVBvF+jLE5fJZcfh7U9BInY
	 FKVVNNmghXL5F1YKD8N2m06RjQlorH0uZkMZDwBSNcjxpwoW5uq/eU3HeSBay6aseN
	 xlVVghbUckL7FpKEIeefCn+cWjchDYph8iyHEq9BEMrLnXdgyar7Uh4TrWfAOX0F7Y
	 h9c1LGMJg0epA==
Date: Wed, 19 Mar 2025 09:55:09 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Jan Kara <jack@suse.cz>, Oliver Sang <oliver.sang@intel.com>,
	David Hildenbrand <david@redhat.com>,
	Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org,
	Christian Brauner <brauner@kernel.org>,
	Hannes Reinecke <hare@suse.de>, oe-lkp@lists.linux.dev,
	lkp@intel.com, John Garry <john.g.garry@oracle.com>,
	linux-block@vger.kernel.org, ltp@lists.linux.it,
	Pankaj Raghav <p.raghav@samsung.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	David Bueso <dave@stgolabs.net>
Subject: Re: [linux-next:master] [block/bdev]  3c20917120:
 BUG:sleeping_function_called_from_invalid_context_at_mm/util.c
Message-ID: <Z9r27eUk993BNWTX@bombadil.infradead.org>
References: <202503101536.27099c77-lkp@intel.com>
 <20250311-testphasen-behelfen-09b950bbecbf@brauner>
 <Z9kEdPLNT8SOyOQT@xsang-OptiPlex-9020>
 <Z9krpfrKjnFs6mfE@bombadil.infradead.org>
 <Z9mFKa3p5P9TBSTQ@casper.infradead.org>
 <Z9n_Iu6W40ZNnKwT@bombadil.infradead.org>
 <Z9oy3i3n_HKFu1M1@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9oy3i3n_HKFu1M1@casper.infradead.org>

On Wed, Mar 19, 2025 at 02:58:38AM +0000, Matthew Wilcox wrote:
> On Tue, Mar 18, 2025 at 04:17:54PM -0700, Luis Chamberlain wrote:
> > Ah, then that LTP test isn't going to easily reproduce bugs around
> > compaction bug. To help proactively find compaction bugs more
> > deterministically we wrote generic/750 and indeed we can easily see
> > issues creep up with a SOAK_DURATION=9000 on ext4 on linux-next as of
> > yesterday next-20250317.
> 
> Umm .. this is an entirely separate bug.  How much COMFIG_DEBUG do you
> have enabled (ie is this a consequence of something that we have an
> assert for, but you've disabled?)

grep ^CONFIG_DEBUG .config
CONFIG_DEBUG_BUGVERBOSE=y
CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_MISC=y
CONFIG_DEBUG_INFO=y
CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
CONFIG_DEBUG_INFO_COMPRESSED_NONE=y
CONFIG_DEBUG_FS=y
CONFIG_DEBUG_FS_ALLOW_ALL=y
CONFIG_DEBUG_WX=y
CONFIG_DEBUG_KMEMLEAK=y
CONFIG_DEBUG_KMEMLEAK_MEM_POOL_SIZE=16000
CONFIG_DEBUG_VM_IRQSOFF=y
CONFIG_DEBUG_VM=y
CONFIG_DEBUG_VM_PGFLAGS=y
CONFIG_DEBUG_MEMORY_INIT=y
CONFIG_DEBUG_PREEMPT=y
CONFIG_DEBUG_LIST=y
CONFIG_DEBUG_MAPLE_TREE=y

Let me know if you want me to enable some other ones, these are always
enabled on any kdevops reportings.

> Not quite sure what this is.  Perhaps running this through decode_stacktrace.sh
> would be helpful?

Sure here is a fresh splat on next-20250317. What can be seen here is
that the issue can be easily reproduced within just one minute of the
test running.  FWIW, I'm not seeing this crash or any kernel splat within the
same time (I'll let this run the full 2.5 hours now to verify) on
vanilla 6.14.0-rc3 + the 64k-sector-size patches, which would explain why I
hadn't seen this in my earlier testing over 10 ext4 profiles on fstests. This
particular crash seems likely to be an artifact on the development cycle on
next-20250317.

Mar 19 16:20:41 extra-ext4-defaults kernel: Linux version 6.14.0-rc7-next-20250317 (mcgrof@beef) (gcc (Debian 14.2.0-16) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44) #32 SMP PREEMPT_DYNAMIC Wed Mar 19 16:18:39 UTC 2025
Mar 19 16:20:41 extra-ext4-defaults kernel: Command line: BOOT_IMAGE=/boot/vmlinuz-6.14.0-rc7-next-20250317 root=PARTUUID=503fa6f2-2d5b-4d7e-8cf8-3a811de326ce ro console=tty0 console=tty1 console=ttyS0,115200n8 console=ttyS0

< etc >

Mar 19 16:21:23 extra-ext4-defaults kernel: EXT4-fs (loop16): mounted filesystem 200cf81b-dd0f-4614-8c4b-6f4af34aa9ff r/w with ordered data mode. Quota mode: none.
Mar 19 16:21:29 extra-ext4-defaults kernel: EXT4-fs (loop5): mounted filesystem cd905b7c-532b-4244-96b7-d2b393f3b16e r/w with ordered data mode. Quota mode: none.
Mar 19 16:21:29 extra-ext4-defaults kernel: EXT4-fs (loop5): unmounting filesystem cd905b7c-532b-4244-96b7-d2b393f3b16e.
Mar 19 16:21:29 extra-ext4-defaults kernel: EXT4-fs (loop16): unmounting filesystem 200cf81b-dd0f-4614-8c4b-6f4af34aa9ff.
Mar 19 16:21:29 extra-ext4-defaults kernel: EXT4-fs (loop16): mounted filesystem 200cf81b-dd0f-4614-8c4b-6f4af34aa9ff r/w with ordered data mode. Quota mode: none.
Mar 19 16:21:29 extra-ext4-defaults unknown: run fstests generic/750 at 2025-03-19 16:21:29
Mar 19 16:21:30 extra-ext4-defaults kernel: EXT4-fs (loop5): mounted filesystem f7af9558-57b0-4266-8326-a1bdda0be33a r/w with ordered data mode. Quota mode: none.
Mar 19 16:22:28 extra-ext4-defaults kernel: BUG: unable to handle page fault for address: ffff8f0e00013350
Mar 19 16:22:28 extra-ext4-defaults kernel: #PF: supervisor read access in kernel mode
Mar 19 16:22:28 extra-ext4-defaults kernel: #PF: error_code(0x0000) - not-present page
Mar 19 16:22:28 extra-ext4-defaults kernel: PGD 158401067 P4D 158401067 PUD 0
Mar 19 16:22:28 extra-ext4-defaults kernel: Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
Mar 19 16:22:28 extra-ext4-defaults kernel: CPU: 2 UID: 0 PID: 74 Comm: kcompactd0 Not tainted 6.14.0-rc7-next-20250317 #32
Mar 19 16:22:28 extra-ext4-defaults kernel: Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 2024.11-5 01/28/2025
Mar 19 16:22:28 extra-ext4-defaults kernel: RIP: 0010:__zone_watermark_ok (mm/page_alloc.c:3339) 
Mar 19 16:22:28 extra-ext4-defaults kernel: Code: 00 00 00 41 f7 c0 38 02 00 00 0f 85 2c 01 00 00 48 8b 4f 30 48 63 d2 48 01 ca 85 db 0f 84 f3 00 00 00 49 29 d1 bb 80 00 00 00 <4c> 03 54 f7 38 31 d2 4d 39 ca 0f 8d d2 00 00 00 ba 01 00 00 00 85
All code
========
   0:	00 00                	add    %al,(%rax)
   2:	00 41 f7             	add    %al,-0x9(%rcx)
   5:	c0 38 02             	sarb   $0x2,(%rax)
   8:	00 00                	add    %al,(%rax)
   a:	0f 85 2c 01 00 00    	jne    0x13c
  10:	48 8b 4f 30          	mov    0x30(%rdi),%rcx
  14:	48 63 d2             	movslq %edx,%rdx
  17:	48 01 ca             	add    %rcx,%rdx
  1a:	85 db                	test   %ebx,%ebx
  1c:	0f 84 f3 00 00 00    	je     0x115
  22:	49 29 d1             	sub    %rdx,%r9
  25:	bb 80 00 00 00       	mov    $0x80,%ebx
  2a:*	4c 03 54 f7 38       	add    0x38(%rdi,%rsi,8),%r10		<-- trapping instruction
  2f:	31 d2                	xor    %edx,%edx
  31:	4d 39 ca             	cmp    %r9,%r10
  34:	0f 8d d2 00 00 00    	jge    0x10c
  3a:	ba 01 00 00 00       	mov    $0x1,%edx
  3f:	85                   	.byte 0x85

Code starting with the faulting instruction
===========================================
   0:	4c 03 54 f7 38       	add    0x38(%rdi,%rsi,8),%r10
   5:	31 d2                	xor    %edx,%edx
   7:	4d 39 ca             	cmp    %r9,%r10
   a:	0f 8d d2 00 00 00    	jge    0xe2
  10:	ba 01 00 00 00       	mov    $0x1,%edx
  15:	85                   	.byte 0x85
Mar 19 16:22:28 extra-ext4-defaults kernel: RSP: 0018:ffffa3ed002b7c78 EFLAGS: 00010202
Mar 19 16:22:28 extra-ext4-defaults kernel: RAX: 0000000000000000 RBX: 0000000000000080 RCX: 0000000000000000
Mar 19 16:22:28 extra-ext4-defaults kernel: RDX: 0000000000000000 RSI: 0000000000003033 RDI: ffff8f0dffffb180
Mar 19 16:22:28 extra-ext4-defaults kernel: RBP: 0000000000000009 R08: 0000000000000080 R09: 0000000000002ffb
Mar 19 16:22:28 extra-ext4-defaults kernel: R10: 0000000000000c09 R11: 0000000000000c09 R12: 0000000000000002
Mar 19 16:22:28 extra-ext4-defaults kernel: R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000003033
Mar 19 16:22:28 extra-ext4-defaults kernel: FS:  0000000000000000(0000) GS:ffff8f0e72f4e000(0000) knlGS:0000000000000000
Mar 19 16:22:28 extra-ext4-defaults kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Mar 19 16:22:28 extra-ext4-defaults kernel: CR2: ffff8f0e00013350 CR3: 0000000116942002 CR4: 0000000000772ef0
Mar 19 16:22:28 extra-ext4-defaults kernel: DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
Mar 19 16:22:28 extra-ext4-defaults kernel: DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Mar 19 16:22:28 extra-ext4-defaults kernel: PKRU: 55555554
Mar 19 16:22:28 extra-ext4-defaults kernel: Call Trace:
Mar 19 16:22:28 extra-ext4-defaults kernel:  <TASK>
Mar 19 16:22:28 extra-ext4-defaults kernel: ? __die_body.cold (arch/x86/kernel/dumpstack.c:478 (discriminator 1) arch/x86/kernel/dumpstack.c:465 (discriminator 1) arch/x86/kernel/dumpstack.c:420 (discriminator 1)) 
Mar 19 16:22:28 extra-ext4-defaults kernel: ? page_fault_oops (arch/x86/mm/fault.c:710 (discriminator 1)) 
Mar 19 16:22:28 extra-ext4-defaults kernel: ? search_module_extables (kernel/module/main.c:3687) 
Mar 19 16:22:28 extra-ext4-defaults kernel: ? __zone_watermark_ok (mm/page_alloc.c:3339) 
Mar 19 16:22:28 extra-ext4-defaults kernel: ? search_bpf_extables (kernel/bpf/core.c:804) 
Mar 19 16:22:28 extra-ext4-defaults kernel: ? exc_page_fault (arch/x86/mm/fault.c:1182 (discriminator 1) arch/x86/mm/fault.c:1478 (discriminator 1) arch/x86/mm/fault.c:1538 (discriminator 1)) 
Mar 19 16:22:28 extra-ext4-defaults kernel: ? asm_exc_page_fault (./arch/x86/include/asm/idtentry.h:574) 
Mar 19 16:22:28 extra-ext4-defaults kernel: ? __zone_watermark_ok (mm/page_alloc.c:3339) 
Mar 19 16:22:28 extra-ext4-defaults kernel: compaction_suitable (mm/compaction.c:2454) 
Mar 19 16:22:28 extra-ext4-defaults kernel: compaction_suit_allocation_order (mm/compaction.c:2547) 
Mar 19 16:22:28 extra-ext4-defaults kernel: kcompactd_do_work (mm/compaction.c:3129) 
Mar 19 16:22:28 extra-ext4-defaults kernel: kcompactd (mm/compaction.c:3243) 
Mar 19 16:22:28 extra-ext4-defaults kernel: ? __pfx_autoremove_wake_function (kernel/sched/wait.c:383) 
Mar 19 16:22:28 extra-ext4-defaults kernel: ? __pfx_kcompactd (mm/compaction.c:3207) 
Mar 19 16:22:28 extra-ext4-defaults kernel: kthread (kernel/kthread.c:464) 
Mar 19 16:22:28 extra-ext4-defaults kernel: ? __pfx_kthread (kernel/kthread.c:413) 
Mar 19 16:22:28 extra-ext4-defaults kernel: ? _raw_spin_unlock (./include/linux/spinlock_api_smp.h:143 (discriminator 3) kernel/locking/spinlock.c:186 (discriminator 3)) 
Mar 19 16:22:28 extra-ext4-defaults kernel: ? finish_task_switch.isra.0 (./arch/x86/include/asm/paravirt.h:686 kernel/sched/sched.h:1533 kernel/sched/core.c:5125 kernel/sched/core.c:5243) 
Mar 19 16:22:28 extra-ext4-defaults kernel: ? __pfx_kthread (kernel/kthread.c:413) 
Mar 19 16:22:28 extra-ext4-defaults kernel: ret_from_fork (arch/x86/kernel/process.c:153) 
Mar 19 16:22:28 extra-ext4-defaults kernel: ? __pfx_kthread (kernel/kthread.c:413) 
Mar 19 16:22:28 extra-ext4-defaults kernel: ret_from_fork_asm (arch/x86/entry/entry_64.S:258) 
Mar 19 16:22:28 extra-ext4-defaults kernel:  </TASK>
Mar 19 16:22:28 extra-ext4-defaults kernel: Modules linked in: loop sunrpc 9p nls_iso8859_1 nls_cp437 crc32c_generic vfat fat kvm_intel kvm ghash_clmulni_intel sha512_ssse3 sha512_generic sha256_ssse3 sha1_ssse3 aesni_intel gf128mul crypto_simd virtio_balloon cryptd 9pnet_virtio virtio_console joydev evdev button serio_raw nvme_fabrics dm_mod nvme_core drm nfnetlink vsock_loopback vmw_vsock_virtio_transport_common vsock autofs4 ext4 crc16 mbcache jbd2 btrfs blake2b_generic efivarfs raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq raid1 raid0 md_mod virtio_net net_failover failover virtio_blk virtio_pci psmouse virtio_pci_legacy_dev virtio_pci_modern_dev virtio virtio_ring
Mar 19 16:22:28 extra-ext4-defaults kernel: CR2: ffff8f0e00013350
Mar 19 16:22:28 extra-ext4-defaults kernel: ---[ end trace 0000000000000000 ]---
Mar 19 16:22:28 extra-ext4-defaults kernel: RIP: 0010:__zone_watermark_ok (mm/page_alloc.c:3339) 
Mar 19 16:22:28 extra-ext4-defaults kernel: Code: 00 00 00 41 f7 c0 38 02 00 00 0f 85 2c 01 00 00 48 8b 4f 30 48 63 d2 48 01 ca 85 db 0f 84 f3 00 00 00 49 29 d1 bb 80 00 00 00 <4c> 03 54 f7 38 31 d2 4d 39 ca 0f 8d d2 00 00 00 ba 01 00 00 00 85
All code
========
   0:	00 00                	add    %al,(%rax)
   2:	00 41 f7             	add    %al,-0x9(%rcx)
   5:	c0 38 02             	sarb   $0x2,(%rax)
   8:	00 00                	add    %al,(%rax)
   a:	0f 85 2c 01 00 00    	jne    0x13c
  10:	48 8b 4f 30          	mov    0x30(%rdi),%rcx
  14:	48 63 d2             	movslq %edx,%rdx
  17:	48 01 ca             	add    %rcx,%rdx
  1a:	85 db                	test   %ebx,%ebx
  1c:	0f 84 f3 00 00 00    	je     0x115
  22:	49 29 d1             	sub    %rdx,%r9
  25:	bb 80 00 00 00       	mov    $0x80,%ebx
  2a:*	4c 03 54 f7 38       	add    0x38(%rdi,%rsi,8),%r10		<-- trapping instruction
  2f:	31 d2                	xor    %edx,%edx
  31:	4d 39 ca             	cmp    %r9,%r10
  34:	0f 8d d2 00 00 00    	jge    0x10c
  3a:	ba 01 00 00 00       	mov    $0x1,%edx
  3f:	85                   	.byte 0x85

Code starting with the faulting instruction
===========================================
   0:	4c 03 54 f7 38       	add    0x38(%rdi,%rsi,8),%r10
   5:	31 d2                	xor    %edx,%edx
   7:	4d 39 ca             	cmp    %r9,%r10
   a:	0f 8d d2 00 00 00    	jge    0xe2
  10:	ba 01 00 00 00       	mov    $0x1,%edx
  15:	85                   	.byte 0x85
Mar 19 16:22:28 extra-ext4-defaults kernel: RSP: 0018:ffffa3ed002b7c78 EFLAGS: 00010202
Mar 19 16:22:28 extra-ext4-defaults kernel: RAX: 0000000000000000 RBX: 0000000000000080 RCX: 0000000000000000
Mar 19 16:22:28 extra-ext4-defaults kernel: RDX: 0000000000000000 RSI: 0000000000003033 RDI: ffff8f0dffffb180
Mar 19 16:22:28 extra-ext4-defaults kernel: RBP: 0000000000000009 R08: 0000000000000080 R09: 0000000000002ffb
Mar 19 16:22:28 extra-ext4-defaults kernel: R10: 0000000000000c09 R11: 0000000000000c09 R12: 0000000000000002
Mar 19 16:22:28 extra-ext4-defaults kernel: R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000003033
Mar 19 16:22:28 extra-ext4-defaults kernel: FS:  0000000000000000(0000) GS:ffff8f0e72f4e000(0000) knlGS:0000000000000000
Mar 19 16:22:28 extra-ext4-defaults kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Mar 19 16:22:28 extra-ext4-defaults kernel: CR2: ffff8f0e00013350 CR3: 0000000116942002 CR4: 0000000000772ef0
Mar 19 16:22:28 extra-ext4-defaults kernel: DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
Mar 19 16:22:28 extra-ext4-defaults kernel: DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Mar 19 16:22:28 extra-ext4-defaults kernel: PKRU: 55555554
Mar 19 16:22:28 extra-ext4-defaults kernel: note: kcompactd0[74] exited with irqs disabled
