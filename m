Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D54514F98
	for <linux-block@vger.kernel.org>; Sun, 12 May 2024 09:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715505414; cv=none; b=MrqsvDzm1yKrTvNbHA86ck081IFTokiYewA9dwJ0we++lOwluKXeXM/arI5WGHJVPZ0PkPM/ybi2mm8uPUWU7IORpjzMcwR0Pk2CVG4l/7YSxkj2qaOpzZelaK4/YrovTI6w3ifFBhqhI0SvAvpV4yB1FdDY+Z2BT/QEAHQSwHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715505414; c=relaxed/simple;
	bh=19sA2RjaXaz+k5J9xv15ZSie9pKfY5mJJmnTg0cqDwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oCTWUqPPMmqNkHdjhDvuTAwlfuTvaH8Ekk2TefL9PSk6+eI0eoqAdOuSEoi/9PnTzYO84in40deahcmTVV9UyeRzW3om7tA42zFeKv1uiqpctut7pGmMCOBA2qRnvynddH0T1+EyCbAQX9ariah9XKkHtOVPHpWabObRVp2TplY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RsvOhVlW; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RsvOhVlW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=JUtrR+ezbkUJo5YeGiMRdC7hm5fLmDEeb4SdGYjk/co=; b=RsvOhVlW0/Bc6r2RVjEtnD5Z8a
	VLP2WEyH5SrMl5iZKwo3xeiSyGPQF67c9f8ddRpaVA0PeX3wjkvOpoEdL0A0OcfWZChh18zR0XQql
	zqBut5PiE58naVHhsXjGLkAn1AaXtd9ylFJp13OSMNv/iZDWOZ4GoSMbODDQ1ARIKF2kpjeD5XV/J
	yAxgR3KDSWWq1Cv1XlduTmj3YLPP+ARtpt41y6o2LH41KFXAE9pbkSayNU4LKnzDJClTe0ZdTrmOv
	y4x6JsZXJTXQqo65jEtqpfxT8t2Nxmcml018lQkPkPh2PMJjXv0xehfx0d4CE2kjkM7gIJYxbAu4c
	oMHEywMg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s65K3-00000009dwL-2WyW;
	Sun, 12 May 2024 09:16:47 +0000
Date: Sun, 12 May 2024 02:16:47 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Matthew Wilcox <willy@infradead.org>,
	Kent Overstreet <kent.overstreet@linux.dev>
Cc: hare@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	Pankaj Raghav <kernel@pankajraghav.com>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH 5/5] nvme: enable logical block size > PAGE_SIZE
Message-ID: <ZkCI_21z_h1ez4sN@bombadil.infradead.org>
References: <20240510102906.51844-1-hare@kernel.org>
 <20240510102906.51844-6-hare@kernel.org>
 <Zj_6vDMwyb2O6ztI@bombadil.infradead.org>
 <Zj__oIGiY8xzrwnb@casper.infradead.org>
 <ZkAEhFLVD9gSk0y0@bombadil.infradead.org>
 <ZkAszpvBkb5_UUiH@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZkAszpvBkb5_UUiH@bombadil.infradead.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Sat, May 11, 2024 at 07:43:26PM -0700, Luis Chamberlain wrote:
> I'll try next going above 512 KiB.

At 1 MiB NVMe LBA format we crash with the BUG_ON(sectors <= 0) on bio_split().

[   13.401651] ------------[ cut here ]------------
[   13.403298] kernel BUG at block/bio.c:1626!
[   13.404708] invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
[   13.406390] CPU: 5 PID: 87 Comm: kworker/u38:1 Not tainted 6.9.0-rc6+ #2
[   13.408480] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   13.411304] Workqueue: nvme-wq nvme_scan_work [nvme_core]
[   13.412928] RIP: 0010:bio_split (block/bio.c:1626 (discriminator 1)) 
[ 13.414148] Code: 5b 4c 89 e0 5d 41 5c 41 5d c3 cc cc cc cc c7 43 28 00 00 00 00 eb db 0f 0b 45 31 e4 5b 5d 4c 89 e0 41 5c 41 5d c3 cc cc cc cc <0f> 0b 0f 0b 4c 89 e7 e8 bf ee ff ff eb e1 66 66 2e 0f 1f 84 00 00
All code
========
   0:	5b                   	pop    %rbx
   1:	4c 89 e0             	mov    %r12,%rax
   4:	5d                   	pop    %rbp
   5:	41 5c                	pop    %r12
   7:	41 5d                	pop    %r13
   9:	c3                   	ret
   a:	cc                   	int3
   b:	cc                   	int3
   c:	cc                   	int3
   d:	cc                   	int3
   e:	c7 43 28 00 00 00 00 	movl   $0x0,0x28(%rbx)
  15:	eb db                	jmp    0xfffffffffffffff2
  17:	0f 0b                	ud2
  19:	45 31 e4             	xor    %r12d,%r12d
  1c:	5b                   	pop    %rbx
  1d:	5d                   	pop    %rbp
  1e:	4c 89 e0             	mov    %r12,%rax
  21:	41 5c                	pop    %r12
  23:	41 5d                	pop    %r13
  25:	c3                   	ret
  26:	cc                   	int3
  27:	cc                   	int3
  28:	cc                   	int3
  29:	cc                   	int3
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	0f 0b                	ud2
  2e:	4c 89 e7             	mov    %r12,%rdi
  31:	e8 bf ee ff ff       	call   0xffffffffffffeef5
  36:	eb e1                	jmp    0x19
  38:	66                   	data16
  39:	66                   	data16
  3a:	2e                   	cs
  3b:	0f                   	.byte 0xf
  3c:	1f                   	(bad)
  3d:	84 00                	test   %al,(%rax)
	...

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	0f 0b                	ud2
   4:	4c 89 e7             	mov    %r12,%rdi
   7:	e8 bf ee ff ff       	call   0xffffffffffffeecb
   c:	eb e1                	jmp    0xffffffffffffffef
   e:	66                   	data16
   f:	66                   	data16
  10:	2e                   	cs
  11:	0f                   	.byte 0xf
  12:	1f                   	(bad)
  13:	84 00                	test   %al,(%rax)
	...
[   13.420639] RSP: 0018:ffffc056407bb8e0 EFLAGS: 00010246
[   13.422140] RAX: 0000000000000001 RBX: ffff9d97c165fa80 RCX: ffff9d97e65ce860
[   13.424128] RDX: 0000000000000c00 RSI: 0000000000000000 RDI: ffff9d97c165fa80
[   13.426123] RBP: 0000000000000000 R08: 0000000000000080 R09: 0000000000000000
[   13.428372] R10: ffff9d97c165fa80 R11: ffff9d97c165faf8 R12: ffff9d97df3f7250
[   13.430636] R13: 0000000000000000 R14: 0000000000000001 R15: 0000000000000000
[   13.432510] FS:  0000000000000000(0000) GS:ffff9d983bd40000(0000) knlGS:0000000000000000
[   13.434539] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   13.435987] CR2: 000055b34c8d6188 CR3: 000000011dfb8002 CR4: 0000000000770ef0
[   13.437664] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   13.439354] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
[   13.440911] PKRU: 55555554
[   13.441605] Call Trace:
[   13.442250]  <TASK>
[   13.442836] ? die (arch/x86/kernel/dumpstack.c:421 arch/x86/kernel/dumpstack.c:434 arch/x86/kernel/dumpstack.c:447) 
[   13.443585] ? do_trap (arch/x86/kernel/traps.c:114 arch/x86/kernel/traps.c:155) 
[   13.444356] ? bio_split (block/bio.c:1626 (discriminator 1)) 
[   13.445127] ? do_error_trap (./arch/x86/include/asm/traps.h:58 arch/x86/kernel/traps.c:176) 
[   13.445975] ? bio_split (block/bio.c:1626 (discriminator 1)) 
[   13.446760] ? exc_invalid_op (arch/x86/kernel/traps.c:267) 
[   13.447635] ? bio_split (block/bio.c:1626 (discriminator 1)) 
[   13.448325] ? asm_exc_invalid_op (./arch/x86/include/asm/idtentry.h:621) 
[   13.449137] ? bio_split (block/bio.c:1626 (discriminator 1)) 
[   13.449819] __bio_split_to_limits (block/blk-merge.c:366) 
[   13.450675] blk_mq_submit_bio (block/blk-mq.c:2973) 
[   13.451490] ? kmem_cache_alloc (./include/linux/kmemleak.h:42 mm/slub.c:3802 mm/slub.c:3845 mm/slub.c:3852) 
[   13.452253] ? __mod_node_page_state (mm/vmstat.c:403 (discriminator 2)) 
[   13.453050] submit_bio_noacct_nocheck (./include/linux/bio.h:639 block/blk-core.c:701 block/blk-core.c:729) 
[   13.453897] ? submit_bio_noacct (block/blk-core.c:758 (discriminator 1)) 
[   13.454658] block_read_full_folio (fs/buffer.c:2429 (discriminator 1)) 
[   13.455467] ? __pfx_blkdev_get_block (block/fops.c:409) 
[   13.456240] ? __pfx_blkdev_read_folio (block/fops.c:437) 
[   13.457014] ? __pfx_blkdev_read_folio (block/fops.c:437) 
[   13.457792] filemap_read_folio (mm/filemap.c:2335) 
[   13.458484] do_read_cache_folio (mm/filemap.c:3763) 
[   13.459220] ? __pfx_adfspart_check_ICS (block/partitions/acorn.c:351) 
[   13.459967] read_part_sector (./include/linux/pagemap.h:970 block/partitions/core.c:715) 
[   13.460602] adfspart_check_ICS (block/partitions/acorn.c:361) 
[   13.461269] ? snprintf (lib/vsprintf.c:2963) 
[   13.461844] ? __pfx_adfspart_check_ICS (block/partitions/acorn.c:351) 
[   13.462601] bdev_disk_changed (block/partitions/core.c:138 block/partitions/core.c:582 block/partitions/core.c:686 block/partitions/core.c:635) 
[   13.463268] blkdev_get_whole (block/bdev.c:684) 
[   13.463871] bdev_open (block/bdev.c:893) 
[   13.464386] bdev_file_open_by_dev (block/bdev.c:995 block/bdev.c:969) 
[   13.465006] disk_scan_partitions (block/genhd.c:369 (discriminator 1)) 
[   13.465621] device_add_disk (block/genhd.c:512) 
[   13.466199] nvme_scan_ns (drivers/nvme/host/core.c:3807 (discriminator 1) drivers/nvme/host/core.c:3961 (discriminator 1)) nvme_core
[   13.466885] nvme_scan_work (drivers/nvme/host/core.c:4015 drivers/nvme/host/core.c:4105) nvme_core
[   13.467598] process_one_work (kernel/workqueue.c:3254) 
[   13.468186] worker_thread (kernel/workqueue.c:3329 (discriminator 2) kernel/workqueue.c:3416 (discriminator 2)) 
[   13.468723] ? _raw_spin_lock_irqsave (./arch/x86/include/asm/atomic.h:115 (discriminator 4) ./include/linux/atomic/atomic-arch-fallback.h:2170 (discriminator 4) ./include/linux/atomic/atomic-instrumented.h:1302 (discriminator 4) ./include/asm-generic/qspinlock.h:111 (discriminator 4) ./include/linux/spinlock.h:187 (discriminator 4) ./include/linux/spinlock_api_smp.h:111 (discriminator 4) kernel/locking/spinlock.c:162 (discriminator 4)) 
[   13.469343] ? __pfx_worker_thread (kernel/workqueue.c:3362) 
[   13.469933] kthread (kernel/kthread.c:388) 
[   13.470395] ? __pfx_kthread (kernel/kthread.c:341) 
[   13.470928] ret_from_fork (arch/x86/kernel/process.c:147) 
[   13.471457] ? __pfx_kthread (kernel/kthread.c:341) 
[   13.472008] ret_from_fork_asm (arch/x86/entry/entry_64.S:257) 
[   13.472540]  </TASK>
[   13.472865] Modules linked in: crc32c_intel psmouse nvme nvme_core t10_pi crc64_rocksoft crc64 virtio_pci virtio_pci_legacy_dev virtio_pci_modern_dev virtio virtio_ring
[   13.474629] ---[ end trace 0000000000000000 ]---
[   13.475229] RIP: 0010:bio_split (block/bio.c:1626 (discriminator 1)) 
[ 13.475742] Code: 5b 4c 89 e0 5d 41 5c 41 5d c3 cc cc cc cc c7 43 28 00 00 00 00 eb db 0f 0b 45 31 e4 5b 5d 4c 89 e0 41 5c 41 5d c3 cc cc cc cc <0f> 0b 0f 0b 4c 89 e7 e8 bf ee ff ff eb e1 66 66 2e 0f 1f 84 00 00
All code
========
   0:	5b                   	pop    %rbx
   1:	4c 89 e0             	mov    %r12,%rax
   4:	5d                   	pop    %rbp
   5:	41 5c                	pop    %r12
   7:	41 5d                	pop    %r13
   9:	c3                   	ret
   a:	cc                   	int3
   b:	cc                   	int3
   c:	cc                   	int3
   d:	cc                   	int3
   e:	c7 43 28 00 00 00 00 	movl   $0x0,0x28(%rbx)
  15:	eb db                	jmp    0xfffffffffffffff2
  17:	0f 0b                	ud2
  19:	45 31 e4             	xor    %r12d,%r12d
  1c:	5b                   	pop    %rbx
  1d:	5d                   	pop    %rbp
  1e:	4c 89 e0             	mov    %r12,%rax
  21:	41 5c                	pop    %r12
  23:	41 5d                	pop    %r13
  25:	c3                   	ret
  26:	cc                   	int3
  27:	cc                   	int3
  28:	cc                   	int3
  29:	cc                   	int3
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	0f 0b                	ud2
  2e:	4c 89 e7             	mov    %r12,%rdi
  31:	e8 bf ee ff ff       	call   0xffffffffffffeef5
  36:	eb e1                	jmp    0x19
  38:	66                   	data16
  39:	66                   	data16
  3a:	2e                   	cs
  3b:	0f                   	.byte 0xf
  3c:	1f                   	(bad)
  3d:	84 00                	test   %al,(%rax)
	...

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	0f 0b                	ud2
   4:	4c 89 e7             	mov    %r12,%rdi
   7:	e8 bf ee ff ff       	call   0xffffffffffffeecb
   c:	eb e1                	jmp    0xffffffffffffffef
   e:	66                   	data16
   f:	66                   	data16
  10:	2e                   	cs
  11:	0f                   	.byte 0xf
  12:	1f                   	(bad)
  13:	84 00                	test   %al,(%rax)
	...
[   13.477749] RSP: 0018:ffffc056407bb8e0 EFLAGS: 00010246
[   13.478405] RAX: 0000000000000001 RBX: ffff9d97c165fa80 RCX: ffff9d97e65ce860
[   13.479230] RDX: 0000000000000c00 RSI: 0000000000000000 RDI: ffff9d97c165fa80
[   13.480026] RBP: 0000000000000000 R08: 0000000000000080 R09: 0000000000000000
[   13.480802] R10: ffff9d97c165fa80 R11: ffff9d97c165faf8 R12: ffff9d97df3f7250
[   13.481568] R13: 0000000000000000 R14: 0000000000000001 R15: 0000000000000000
[   13.482337] FS:  0000000000000000(0000) GS:ffff9d983bd40000(0000) knlGS:0000000000000000
[   13.483218] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   13.483853] CR2: 000055b34c8d6188 CR3: 000000011dfb8002 CR4: 0000000000770ef0
[   13.484584] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   13.485327] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
[   13.486070] PKRU: 55555554
