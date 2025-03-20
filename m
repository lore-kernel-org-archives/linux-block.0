Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D94522068D;
	Thu, 20 Mar 2025 12:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742472681; cv=none; b=YDcUINihL2zecc7Eb+0gsJ7zQQp3YSY5HUa8PJ4R7044oG5kRbwjblQKWqtkBPF7HmCy43rsButKHnReRFo7fmreP+J6UlXTwYf91e6Q8ZE3Rk1o6Q9OCON4MzsHj0TfV25g1heJhOlvMuKNoqn5z+ziU25hAWKX6h+lFm3B2io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742472681; c=relaxed/simple;
	bh=lAA6dsHJHk9It386Fum5QAZ0hCirSjpfY33LKsMgCE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e8T89uUlT+RRQXaj3HrBdHKcr6v1ZU9fGkMuVgqbaC6NCRg+ZqcUMG3u3XqYKs6AmOmYcMDLjI41qZj/LO8v7lflIKnjITLiQixuP5KDwfZ9SHRksrRWVWFG8NMOqwaGBmRN1/+iTpNAbkmzu95NQy29VLHdIhZBTq2jwwe5yyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RDooq5R/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RDooq5R/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8452FC4CEDD;
	Thu, 20 Mar 2025 12:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742472681;
	bh=lAA6dsHJHk9It386Fum5QAZ0hCirSjpfY33LKsMgCE4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RDooq5R/FovOLHSj7M1hearKsRBi0uJDIUlrK2RPUohurT0kPQqO2XG5pn+WfIMcC
	 CkcWQIb32h22p3f1KSPmYNzRQZe2JSxuvHzG2rU/PjBKwaHp7hc5JIvi2kx6pRGXjF
	 smDPAdey/CSvCs4JjPJok7clPISdEE1yB1EQzWMwDMgGqnrGGIj7l1mbGF8DnYww7D
	 xNEabK6TtuoxdRdzKOm34JLTO38OwiKJNp1QWkTIn53u+I1WL0V0SM0QEAeOhFrZQ0
	 MtjOmFzSva/VR2pI9/Sylmdamaz9SNgKBwyzu9BZP/OoL3fGpdlqwW7vFVkWAzoCwy
	 LJ6VCZcapNSbg==
Date: Thu, 20 Mar 2025 05:11:19 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Matthew Wilcox <willy@infradead.org>,
	Johannes Weiner <hannes@cmpxchg.org>
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
Message-ID: <Z9wF57eEBR-42K9a@bombadil.infradead.org>
References: <202503101536.27099c77-lkp@intel.com>
 <20250311-testphasen-behelfen-09b950bbecbf@brauner>
 <Z9kEdPLNT8SOyOQT@xsang-OptiPlex-9020>
 <Z9krpfrKjnFs6mfE@bombadil.infradead.org>
 <Z9mFKa3p5P9TBSTQ@casper.infradead.org>
 <Z9n_Iu6W40ZNnKwT@bombadil.infradead.org>
 <Z9oy3i3n_HKFu1M1@casper.infradead.org>
 <Z9r27eUk993BNWTX@bombadil.infradead.org>
 <Z9sYGccL4TocoITf@bombadil.infradead.org>
 <Z9sZ5_lJzTwGShQT@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9sZ5_lJzTwGShQT@casper.infradead.org>

On Wed, Mar 19, 2025 at 07:24:23PM +0000, Matthew Wilcox wrote:
> On Wed, Mar 19, 2025 at 12:16:41PM -0700, Luis Chamberlain wrote:
> > On Wed, Mar 19, 2025 at 09:55:11AM -0700, Luis Chamberlain wrote:
> > > FWIW, I'm not seeing this crash or any kernel splat within the
> > > same time (I'll let this run the full 2.5 hours now to verify) on
> > > vanilla 6.14.0-rc3 + the 64k-sector-size patches, which would explain why I
> > > hadn't seen this in my earlier testing over 10 ext4 profiles on fstests. This
> > > particular crash seems likely to be an artifact on the development cycle on
> > > next-20250317.
> > 
> > I confirm that with a vanilla 6.14.0-rc3 + the 64k-sector-size patches a 2.5
> > hour run generic/750 doesn't crash at all. So indeed something on the
> > development cycle leads to this particular crash.
> 
> We can't debug two problems at once.
> 
> FOr the first problem, I've demonstrated what the cause is, and that's
> definitely introduced by your patch, so we need to figure out a
> solution.

Sure, yeah I followed that.

> For the second problem, we don't know what it is.  Do you want to bisect
> it to figure out which commit introduced it?

Sure, the culprit is the patch titled:

mm: page_alloc: trace type pollution from compaction capturing

Johannes, any ideas? You can reproduce easily (1-2 minutes) by running
fstests against ext4 with a 4k block size filesystem on linux-next
against the test generic/750.

Below is the splat decoded.

Mar 20 11:52:55 extra-ext4-4k kernel: Linux version 6.14.0-rc6+ (mcgrof@beefy) (gcc (Debian 14.2.0-16) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44) #51 SMP PREEMPT_DYNAMIC Thu Mar 20 11:50:32 UTC 2025
Mar 20 11:52:55 extra-ext4-4k kernel: Command line: BOOT_IMAGE=/boot/vmlinuz-6.14.0-rc6+ root=PARTUUID=503fa6f2-2d5b-4d7e-8cf8-3a811de326ce ro console=tty0 console=tty1 console=ttyS0,115200n8 console=ttyS0

< -- etc -->

Mar 20 11:55:27 extra-ext4-4k unknown: run fstests generic/750 at 2025-03-20 11:55:27
Mar 20 11:55:28 extra-ext4-4k kernel: EXT4-fs (loop5): mounted filesystem c20cbdee-a370-4743-80aa-95dec0beaaa2 r/w with ordered data mode. Quota mode: none.
Mar 20 11:56:29 extra-ext4-4k kernel: BUG: unable to handle page fault for address: ffff93098000ba00
Mar 20 11:56:29 extra-ext4-4k kernel: #PF: supervisor read access in kernel mode
Mar 20 11:56:29 extra-ext4-4k kernel: #PF: error_code(0x0000) - not-present page
Mar 20 11:56:29 extra-ext4-4k kernel: PGD 3a201067 P4D 3a201067 PUD 0
Mar 20 11:56:29 extra-ext4-4k kernel: Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
Mar 20 11:56:29 extra-ext4-4k kernel: CPU: 0 UID: 0 PID: 74 Comm: kcompactd0 Not tainted 6.14.0-rc6+ #51
Mar 20 11:56:29 extra-ext4-4k kernel: Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 2024.11-5 01/28/2025
Mar 20 11:56:29 extra-ext4-4k kernel: RIP: 0010:__zone_watermark_ok (mm/page_alloc.c:3256) 
Mar 20 11:56:29 extra-ext4-4k kernel: Code: 00 00 00 41 f7 c0 38 02 00 00 0f 85 2c 01 00 00 48 8b 4f 30 48 63 d2 48 01 ca 85 db 0f 84 f3 00 00 00 49 29 d1 bb 80 00 00 00 <4c> 03 54 f7 38 31 d2 4d 39 ca 0f 8d d2 00 00 00 ba 01 00 00 00 85
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
Mar 20 11:56:29 extra-ext4-4k kernel: RSP: 0018:ffffa5bb002b7c78 EFLAGS: 00010206
Mar 20 11:56:29 extra-ext4-4k kernel: RAX: 0000000000000000 RBX: 0000000000000080 RCX: 0000000000000000
Mar 20 11:56:29 extra-ext4-4k kernel: RDX: 0000000000000000 RSI: 0000000000002431 RDI: ffff93097fff9840
Mar 20 11:56:29 extra-ext4-4k kernel: RBP: 0000000000000009 R08: 0000000000000080 R09: 0000000000005e90
Mar 20 11:56:29 extra-ext4-4k kernel: R10: 0000000000000c8e R11: 0000000000000c8e R12: 0000000000000000
Mar 20 11:56:29 extra-ext4-4k kernel: R13: 0000000000002431 R14: 0000000000000002 R15: 0000000000000000
Mar 20 11:56:29 extra-ext4-4k kernel: FS:  0000000000000000(0000) GS:ffff93097bc00000(0000) knlGS:0000000000000000
Mar 20 11:56:29 extra-ext4-4k kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Mar 20 11:56:29 extra-ext4-4k kernel: CR2: ffff93098000ba00 CR3: 000000010c602004 CR4: 0000000000772ef0
Mar 20 11:56:29 extra-ext4-4k kernel: DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
Mar 20 11:56:29 extra-ext4-4k kernel: DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Mar 20 11:56:29 extra-ext4-4k kernel: PKRU: 55555554
Mar 20 11:56:29 extra-ext4-4k kernel: Call Trace:
Mar 20 11:56:29 extra-ext4-4k kernel:  <TASK>
Mar 20 11:56:29 extra-ext4-4k kernel: ? __die_body.cold (arch/x86/kernel/dumpstack.c:478 (discriminator 1) arch/x86/kernel/dumpstack.c:465 (discriminator 1) arch/x86/kernel/dumpstack.c:420 (discriminator 1)) 
Mar 20 11:56:29 extra-ext4-4k kernel: ? page_fault_oops (arch/x86/mm/fault.c:710 (discriminator 1)) 
Mar 20 11:56:29 extra-ext4-4k kernel: ? search_module_extables (kernel/module/main.c:3733 (discriminator 3)) 
Mar 20 11:56:29 extra-ext4-4k kernel: ? __zone_watermark_ok (mm/page_alloc.c:3256) 
Mar 20 11:56:29 extra-ext4-4k kernel: ? search_bpf_extables (kernel/bpf/core.c:804) 
Mar 20 11:56:29 extra-ext4-4k kernel: ? exc_page_fault (arch/x86/mm/fault.c:1182 (discriminator 1) arch/x86/mm/fault.c:1478 (discriminator 1) arch/x86/mm/fault.c:1538 (discriminator 1)) 
Mar 20 11:56:29 extra-ext4-4k kernel: ? asm_exc_page_fault (./arch/x86/include/asm/idtentry.h:574) 
Mar 20 11:56:29 extra-ext4-4k kernel: ? __zone_watermark_ok (mm/page_alloc.c:3256) 
Mar 20 11:56:29 extra-ext4-4k kernel: ? asm_sysvec_call_function_single (./arch/x86/include/asm/idtentry.h:574) 
Mar 20 11:56:29 extra-ext4-4k kernel: compaction_suitable (mm/compaction.c:2438) 
Mar 20 11:56:29 extra-ext4-4k kernel: compaction_suit_allocation_order (mm/compaction.c:2525 (discriminator 1)) 
Mar 20 11:56:29 extra-ext4-4k kernel: kcompactd_do_work (mm/compaction.c:3106) 
Mar 20 11:56:29 extra-ext4-4k kernel: kcompactd (mm/compaction.c:3220) 
Mar 20 11:56:29 extra-ext4-4k kernel: ? __pfx_autoremove_wake_function (kernel/sched/wait.c:383) 
Mar 20 11:56:29 extra-ext4-4k kernel: ? __pfx_kcompactd (mm/compaction.c:3184) 
Mar 20 11:56:29 extra-ext4-4k kernel: kthread (kernel/kthread.c:464) 
Mar 20 11:56:29 extra-ext4-4k kernel: ? __pfx_kthread (kernel/kthread.c:413) 
Mar 20 11:56:29 extra-ext4-4k kernel: ? _raw_spin_unlock (./include/linux/spinlock_api_smp.h:143 (discriminator 3) kernel/locking/spinlock.c:186 (discriminator 3)) 
Mar 20 11:56:29 extra-ext4-4k kernel: ? finish_task_switch.isra.0 (./arch/x86/include/asm/paravirt.h:691 kernel/sched/sched.h:1533 kernel/sched/core.c:5132 kernel/sched/core.c:5250) 
Mar 20 11:56:29 extra-ext4-4k kernel: ? __pfx_kthread (kernel/kthread.c:413) 
Mar 20 11:56:29 extra-ext4-4k kernel: ret_from_fork (arch/x86/kernel/process.c:148) 
Mar 20 11:56:29 extra-ext4-4k kernel: ? __pfx_kthread (kernel/kthread.c:413) 
Mar 20 11:56:29 extra-ext4-4k kernel: ret_from_fork_asm (arch/x86/entry/entry_64.S:257) 
Mar 20 11:56:29 extra-ext4-4k kernel:  </TASK>
Mar 20 11:56:29 extra-ext4-4k kernel: Modules linked in: loop sunrpc 9p nls_iso8859_1 nls_cp437 vfat crc32c_generic fat kvm_intel kvm ghash_clmulni_intel sha512_ssse3 sha512_generic sha256_ssse3 sha1_ssse3 aesni_intel gf128mul crypto_simd 9pnet_virtio cryptd virtio_console virtio_balloon button evdev joydev serio_raw dm_mod nvme_fabrics drm nvme_core nfnetlink vsock_loopback vmw_vsock_virtio_transport_common vsock autofs4 ext4 crc16 mbcache jbd2 btrfs blake2b_generic efivarfs raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq raid1 raid0 md_mod virtio_net net_failover failover virtio_blk psmouse virtio_pci virtio_pci_legacy_dev virtio_pci_modern_dev virtio virtio_ring
Mar 20 11:56:29 extra-ext4-4k kernel: CR2: ffff93098000ba00
Mar 20 11:56:29 extra-ext4-4k kernel: ---[ end trace 0000000000000000 ]---
Mar 20 11:56:29 extra-ext4-4k kernel: RIP: 0010:__zone_watermark_ok (mm/page_alloc.c:3256) 
Mar 20 11:56:29 extra-ext4-4k kernel: Code: 00 00 00 41 f7 c0 38 02 00 00 0f 85 2c 01 00 00 48 8b 4f 30 48 63 d2 48 01 ca 85 db 0f 84 f3 00 00 00 49 29 d1 bb 80 00 00 00 <4c> 03 54 f7 38 31 d2 4d 39 ca 0f 8d d2 00 00 00 ba 01 00 00 00 85
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
Mar 20 11:56:29 extra-ext4-4k kernel: RSP: 0018:ffffa5bb002b7c78 EFLAGS: 00010206
Mar 20 11:56:29 extra-ext4-4k kernel: RAX: 0000000000000000 RBX: 0000000000000080 RCX: 0000000000000000
Mar 20 11:56:29 extra-ext4-4k kernel: RDX: 0000000000000000 RSI: 0000000000002431 RDI: ffff93097fff9840
Mar 20 11:56:29 extra-ext4-4k kernel: RBP: 0000000000000009 R08: 0000000000000080 R09: 0000000000005e90
Mar 20 11:56:29 extra-ext4-4k kernel: R10: 0000000000000c8e R11: 0000000000000c8e R12: 0000000000000000
Mar 20 11:56:29 extra-ext4-4k kernel: R13: 0000000000002431 R14: 0000000000000002 R15: 0000000000000000
Mar 20 11:56:29 extra-ext4-4k kernel: FS:  0000000000000000(0000) GS:ffff93097bc00000(0000) knlGS:0000000000000000
Mar 20 11:56:29 extra-ext4-4k kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Mar 20 11:56:29 extra-ext4-4k kernel: CR2: ffff93098000ba00 CR3: 000000010c602004 CR4: 0000000000772ef0
Mar 20 11:56:29 extra-ext4-4k kernel: DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
Mar 20 11:56:29 extra-ext4-4k kernel: DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Mar 20 11:56:29 extra-ext4-4k kernel: PKRU: 55555554
Mar 20 11:56:29 extra-ext4-4k kernel: note: kcompactd0[74] exited with irqs disabled

  Luis
