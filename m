Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62EC57CAA
	for <linux-block@vger.kernel.org>; Mon, 13 May 2024 16:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715616488; cv=none; b=aSkrcKk8cO6M4PXKqZMaCMAp9NhXbrTFAKDT6iyMT8fv2F/OgRDGIEanuV/UM7KZcIeAPDq/5ZDrWBx8iatZmFgkovixJJElfXotREYP7eIbd401/M1UfYM2/lM9EaF8Xt3Rl6QdgjBFgK4QUHbwTN0dW0+7D6nqZ+uMyQkfi3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715616488; c=relaxed/simple;
	bh=c9swV6duCxPH3HIO7maXl86RzMhB6INmJwJdvR9pjJk=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=REHxF+1QXlK9OV5sHAbB4h7HMVl7EdHWH2FbhxT+kZCjJtxR4i1xE/zr2ZiCSnLjQe0GqtoTGGDaPL0nMAso8sVTLAY8rGY2gcwJdg97s9M8Qw6IaBY/E4E9wI5pFoFj7x41HAko4sxp07o8LMGzZa7Nz5uO8jmxjr5u78X5B3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=l+ei2APR; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=IWuoZiDg; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yiGEDvC3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fuzOuyps; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="l+ei2APR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="IWuoZiDg";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yiGEDvC3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fuzOuyps"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E194D5C55E;
	Mon, 13 May 2024 16:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715616485; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MXd+mQ0I/4p2Fnz//2efaEsxzZCqjWgZHObwlVmMP6Y=;
	b=l+ei2APRL4sWRyD52/CqzY2Jvg6VJj7aOgpFc8ULzYMfjQwycIW+jZuIZNMBJcAAy9w8uj
	5WbT1VYZO/96sYffpnBPSqocMCl8EM/V39GWuzbgH+qe90hzyjKPF78532i0giH6s9Y12S
	xFI9cRwVI8jxBxtefRrpQEo34AwJ/Q0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715616485;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MXd+mQ0I/4p2Fnz//2efaEsxzZCqjWgZHObwlVmMP6Y=;
	b=IWuoZiDgITwEL6vvM12H+0lJLRebX0EiwjupSKgMXHLkQshjL8aX4WXgTWCDoIYCVum4kU
	fYWSwyUp7d7xY5AA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715616484; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MXd+mQ0I/4p2Fnz//2efaEsxzZCqjWgZHObwlVmMP6Y=;
	b=yiGEDvC3CXA0UaWvTplUDxu66GtNfRPqEmdiDauxza+Q4ttGLwjizjuHuzq5sGNIo454+I
	BYsQ27+lUCj0N+V4ygju6qUON/7hVog6QF/1T4f3QwFSgmzAI/mio2sf6pvZs9P2AQTSS2
	t4sS6H45oNYnoWXRaweS+8UKRfoqCwc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715616484;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MXd+mQ0I/4p2Fnz//2efaEsxzZCqjWgZHObwlVmMP6Y=;
	b=fuzOuypscPqKgL56ohR4oEKpsyRQATXUQBvkZbAFvgIhyt2IdeMiLXo6LeI2HlKLeuuVAy
	dZ4G/JZO/omRoLDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 521151372E;
	Mon, 13 May 2024 16:08:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lfhRAeI6Qma2XgAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 13 May 2024 16:08:02 +0000
Content-Type: multipart/mixed; boundary="------------OXbQbRe7LLBA7oGLZQEoccO7"
Message-ID: <993991e6-7f06-4dfd-b5d7-554b9574384c@suse.de>
Date: Mon, 13 May 2024 18:07:55 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] nvme: enable logical block size > PAGE_SIZE
Content-Language: en-US
To: Luis Chamberlain <mcgrof@kernel.org>, Matthew Wilcox
 <willy@infradead.org>, Kent Overstreet <kent.overstreet@linux.dev>
Cc: hare@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Pankaj Raghav <kernel@pankajraghav.com>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, Pankaj Raghav <p.raghav@samsung.com>
References: <20240510102906.51844-1-hare@kernel.org>
 <20240510102906.51844-6-hare@kernel.org>
 <Zj_6vDMwyb2O6ztI@bombadil.infradead.org>
 <Zj__oIGiY8xzrwnb@casper.infradead.org>
 <ZkAEhFLVD9gSk0y0@bombadil.infradead.org>
 <ZkAszpvBkb5_UUiH@bombadil.infradead.org>
 <ZkCI_21z_h1ez4sN@bombadil.infradead.org>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <ZkCI_21z_h1ez4sN@bombadil.infradead.org>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.19 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain,text/x-patch];
	XM_UA_NO_VERSION(0.01)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	HAS_ATTACHMENT(0.00)[]
X-Spam-Score: -3.19
X-Spam-Flag: NO

This is a multi-part message in MIME format.
--------------OXbQbRe7LLBA7oGLZQEoccO7
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/12/24 11:16, Luis Chamberlain wrote:
> On Sat, May 11, 2024 at 07:43:26PM -0700, Luis Chamberlain wrote:
>> I'll try next going above 512 KiB.
> 
> At 1 MiB NVMe LBA format we crash with the BUG_ON(sectors <= 0) on bio_split().
> 
> [   13.401651] ------------[ cut here ]------------
> [   13.403298] kernel BUG at block/bio.c:1626!
> [   13.404708] invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
> [   13.406390] CPU: 5 PID: 87 Comm: kworker/u38:1 Not tainted 6.9.0-rc6+ #2
> [   13.408480] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> [   13.411304] Workqueue: nvme-wq nvme_scan_work [nvme_core]
> [   13.412928] RIP: 0010:bio_split (block/bio.c:1626 (discriminator 1))
> [ 13.414148] Code: 5b 4c 89 e0 5d 41 5c 41 5d c3 cc cc cc cc c7 43 28 00 00 00 00 eb db 0f 0b 45 31 e4 5b 5d 4c 89 e0 41 5c 41 5d c3 cc cc cc cc <0f> 0b 0f 0b 4c 89 e7 e8 bf ee ff ff eb e1 66 66 2e 0f 1f 84 00 00
> All code
> ========
>     0:	5b                   	pop    %rbx
>     1:	4c 89 e0             	mov    %r12,%rax
>     4:	5d                   	pop    %rbp
>     5:	41 5c                	pop    %r12
>     7:	41 5d                	pop    %r13
>     9:	c3                   	ret
>     a:	cc                   	int3
>     b:	cc                   	int3
>     c:	cc                   	int3
>     d:	cc                   	int3
>     e:	c7 43 28 00 00 00 00 	movl   $0x0,0x28(%rbx)
>    15:	eb db                	jmp    0xfffffffffffffff2
>    17:	0f 0b                	ud2
>    19:	45 31 e4             	xor    %r12d,%r12d
>    1c:	5b                   	pop    %rbx
>    1d:	5d                   	pop    %rbp
>    1e:	4c 89 e0             	mov    %r12,%rax
>    21:	41 5c                	pop    %r12
>    23:	41 5d                	pop    %r13
>    25:	c3                   	ret
>    26:	cc                   	int3
>    27:	cc                   	int3
>    28:	cc                   	int3
>    29:	cc                   	int3
>    2a:*	0f 0b                	ud2		<-- trapping instruction
>    2c:	0f 0b                	ud2
>    2e:	4c 89 e7             	mov    %r12,%rdi
>    31:	e8 bf ee ff ff       	call   0xffffffffffffeef5
>    36:	eb e1                	jmp    0x19
>    38:	66                   	data16
>    39:	66                   	data16
>    3a:	2e                   	cs
>    3b:	0f                   	.byte 0xf
>    3c:	1f                   	(bad)
>    3d:	84 00                	test   %al,(%rax)
> 	...
> 
> Code starting with the faulting instruction
> ===========================================
>     0:	0f 0b                	ud2
>     2:	0f 0b                	ud2
>     4:	4c 89 e7             	mov    %r12,%rdi
>     7:	e8 bf ee ff ff       	call   0xffffffffffffeecb
>     c:	eb e1                	jmp    0xffffffffffffffef
>     e:	66                   	data16
>     f:	66                   	data16
>    10:	2e                   	cs
>    11:	0f                   	.byte 0xf
>    12:	1f                   	(bad)
>    13:	84 00                	test   %al,(%rax)
> 	...
> [   13.420639] RSP: 0018:ffffc056407bb8e0 EFLAGS: 00010246
> [   13.422140] RAX: 0000000000000001 RBX: ffff9d97c165fa80 RCX: ffff9d97e65ce860
> [   13.424128] RDX: 0000000000000c00 RSI: 0000000000000000 RDI: ffff9d97c165fa80
> [   13.426123] RBP: 0000000000000000 R08: 0000000000000080 R09: 0000000000000000
> [   13.428372] R10: ffff9d97c165fa80 R11: ffff9d97c165faf8 R12: ffff9d97df3f7250
> [   13.430636] R13: 0000000000000000 R14: 0000000000000001 R15: 0000000000000000
> [   13.432510] FS:  0000000000000000(0000) GS:ffff9d983bd40000(0000) knlGS:0000000000000000
> [   13.434539] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   13.435987] CR2: 000055b34c8d6188 CR3: 000000011dfb8002 CR4: 0000000000770ef0
> [   13.437664] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [   13.439354] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
> [   13.440911] PKRU: 55555554
> [   13.441605] Call Trace:
> [   13.442250]  <TASK>
> [   13.442836] ? die (arch/x86/kernel/dumpstack.c:421 arch/x86/kernel/dumpstack.c:434 arch/x86/kernel/dumpstack.c:447)
> [   13.443585] ? do_trap (arch/x86/kernel/traps.c:114 arch/x86/kernel/traps.c:155)
> [   13.444356] ? bio_split (block/bio.c:1626 (discriminator 1))
> [   13.445127] ? do_error_trap (./arch/x86/include/asm/traps.h:58 arch/x86/kernel/traps.c:176)
> [   13.445975] ? bio_split (block/bio.c:1626 (discriminator 1))
> [   13.446760] ? exc_invalid_op (arch/x86/kernel/traps.c:267)
> [   13.447635] ? bio_split (block/bio.c:1626 (discriminator 1))
> [   13.448325] ? asm_exc_invalid_op (./arch/x86/include/asm/idtentry.h:621)
> [   13.449137] ? bio_split (block/bio.c:1626 (discriminator 1))
> [   13.449819] __bio_split_to_limits (block/blk-merge.c:366)
> [   13.450675] blk_mq_submit_bio (block/blk-mq.c:2973)
> [   13.451490] ? kmem_cache_alloc (./include/linux/kmemleak.h:42 mm/slub.c:3802 mm/slub.c:3845 mm/slub.c:3852)
> [   13.452253] ? __mod_node_page_state (mm/vmstat.c:403 (discriminator 2))
> [   13.453050] submit_bio_noacct_nocheck (./include/linux/bio.h:639 block/blk-core.c:701 block/blk-core.c:729)
> [   13.453897] ? submit_bio_noacct (block/blk-core.c:758 (discriminator 1))
> [   13.454658] block_read_full_folio (fs/buffer.c:2429 (discriminator 1))
> [   13.455467] ? __pfx_blkdev_get_block (block/fops.c:409)
> [   13.456240] ? __pfx_blkdev_read_folio (block/fops.c:437)
> [   13.457014] ? __pfx_blkdev_read_folio (block/fops.c:437)
> [   13.457792] filemap_read_folio (mm/filemap.c:2335)
> [   13.458484] do_read_cache_folio (mm/filemap.c:3763)
> [   13.459220] ? __pfx_adfspart_check_ICS (block/partitions/acorn.c:351)
> [   13.459967] read_part_sector (./include/linux/pagemap.h:970 block/partitions/core.c:715)
> [   13.460602] adfspart_check_ICS (block/partitions/acorn.c:361)
> [   13.461269] ? snprintf (lib/vsprintf.c:2963)
> [   13.461844] ? __pfx_adfspart_check_ICS (block/partitions/acorn.c:351)
> [   13.462601] bdev_disk_changed (block/partitions/core.c:138 block/partitions/core.c:582 block/partitions/core.c:686 block/partitions/core.c:635)
> [   13.463268] blkdev_get_whole (block/bdev.c:684)
> [   13.463871] bdev_open (block/bdev.c:893)
> [   13.464386] bdev_file_open_by_dev (block/bdev.c:995 block/bdev.c:969)
> [   13.465006] disk_scan_partitions (block/genhd.c:369 (discriminator 1))
> [   13.465621] device_add_disk (block/genhd.c:512)
> [   13.466199] nvme_scan_ns (drivers/nvme/host/core.c:3807 (discriminator 1) drivers/nvme/host/core.c:3961 (discriminator 1)) nvme_core
> [   13.466885] nvme_scan_work (drivers/nvme/host/core.c:4015 drivers/nvme/host/core.c:4105) nvme_core
> [   13.467598] process_one_work (kernel/workqueue.c:3254)
> [   13.468186] worker_thread (kernel/workqueue.c:3329 (discriminator 2) kernel/workqueue.c:3416 (discriminator 2))
> [   13.468723] ? _raw_spin_lock_irqsave (./arch/x86/include/asm/atomic.h:115 (discriminator 4) ./include/linux/atomic/atomic-arch-fallback.h:2170 (discriminator 4) ./include/linux/atomic/atomic-instrumented.h:1302 (discriminator 4) ./include/asm-generic/qspinlock.h:111 (discriminator 4) ./include/linux/spinlock.h:187 (discriminator 4) ./include/linux/spinlock_api_smp.h:111 (discriminator 4) kernel/locking/spinlock.c:162 (discriminator 4))
> [   13.469343] ? __pfx_worker_thread (kernel/workqueue.c:3362)
> [   13.469933] kthread (kernel/kthread.c:388)
> [   13.470395] ? __pfx_kthread (kernel/kthread.c:341)
> [   13.470928] ret_from_fork (arch/x86/kernel/process.c:147)
> [   13.471457] ? __pfx_kthread (kernel/kthread.c:341)
> [   13.472008] ret_from_fork_asm (arch/x86/entry/entry_64.S:257)
> [   13.472540]  </TASK>
> [   13.472865] Modules linked in: crc32c_intel psmouse nvme nvme_core t10_pi crc64_rocksoft crc64 virtio_pci virtio_pci_legacy_dev virtio_pci_modern_dev virtio virtio_ring
> [   13.474629] ---[ end trace 0000000000000000 ]---
> [   13.475229] RIP: 0010:bio_split (block/bio.c:1626 (discriminator 1))
> [ 13.475742] Code: 5b 4c 89 e0 5d 41 5c 41 5d c3 cc cc cc cc c7 43 28 00 00 00 00 eb db 0f 0b 45 31 e4 5b 5d 4c 89 e0 41 5c 41 5d c3 cc cc cc cc <0f> 0b 0f 0b 4c 89 e7 e8 bf ee ff ff eb e1 66 66 2e 0f 1f 84 00 00
> All code
> ========
>     0:	5b                   	pop    %rbx
>     1:	4c 89 e0             	mov    %r12,%rax
>     4:	5d                   	pop    %rbp
>     5:	41 5c                	pop    %r12
>     7:	41 5d                	pop    %r13
>     9:	c3                   	ret
>     a:	cc                   	int3
>     b:	cc                   	int3
>     c:	cc                   	int3
>     d:	cc                   	int3
>     e:	c7 43 28 00 00 00 00 	movl   $0x0,0x28(%rbx)
>    15:	eb db                	jmp    0xfffffffffffffff2
>    17:	0f 0b                	ud2
>    19:	45 31 e4             	xor    %r12d,%r12d
>    1c:	5b                   	pop    %rbx
>    1d:	5d                   	pop    %rbp
>    1e:	4c 89 e0             	mov    %r12,%rax
>    21:	41 5c                	pop    %r12
>    23:	41 5d                	pop    %r13
>    25:	c3                   	ret
>    26:	cc                   	int3
>    27:	cc                   	int3
>    28:	cc                   	int3
>    29:	cc                   	int3
>    2a:*	0f 0b                	ud2		<-- trapping instruction
>    2c:	0f 0b                	ud2
>    2e:	4c 89 e7             	mov    %r12,%rdi
>    31:	e8 bf ee ff ff       	call   0xffffffffffffeef5
>    36:	eb e1                	jmp    0x19
>    38:	66                   	data16
>    39:	66                   	data16
>    3a:	2e                   	cs
>    3b:	0f                   	.byte 0xf
>    3c:	1f                   	(bad)
>    3d:	84 00                	test   %al,(%rax)
> 	...
> 
> Code starting with the faulting instruction
> ===========================================
>     0:	0f 0b                	ud2
>     2:	0f 0b                	ud2
>     4:	4c 89 e7             	mov    %r12,%rdi
>     7:	e8 bf ee ff ff       	call   0xffffffffffffeecb
>     c:	eb e1                	jmp    0xffffffffffffffef
>     e:	66                   	data16
>     f:	66                   	data16
>    10:	2e                   	cs
>    11:	0f                   	.byte 0xf
>    12:	1f                   	(bad)
>    13:	84 00                	test   %al,(%rax)
> 	...
> [   13.477749] RSP: 0018:ffffc056407bb8e0 EFLAGS: 00010246
> [   13.478405] RAX: 0000000000000001 RBX: ffff9d97c165fa80 RCX: ffff9d97e65ce860
> [   13.479230] RDX: 0000000000000c00 RSI: 0000000000000000 RDI: ffff9d97c165fa80
> [   13.480026] RBP: 0000000000000000 R08: 0000000000000080 R09: 0000000000000000
> [   13.480802] R10: ffff9d97c165fa80 R11: ffff9d97c165faf8 R12: ffff9d97df3f7250
> [   13.481568] R13: 0000000000000000 R14: 0000000000000001 R15: 0000000000000000
> [   13.482337] FS:  0000000000000000(0000) GS:ffff9d983bd40000(0000) knlGS:0000000000000000
> [   13.483218] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   13.483853] CR2: 000055b34c8d6188 CR3: 000000011dfb8002 CR4: 0000000000770ef0
> [   13.484584] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [   13.485327] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
> [   13.486070] PKRU: 55555554
> 

Ah. MAX_BUFS_PER_PAGE getting in the way.

Can you test with the attached patch?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

--------------OXbQbRe7LLBA7oGLZQEoccO7
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-fs-buffer-restart-block_read_full_folio-to-avoid-arr.patch"
Content-Disposition: attachment;
 filename*0="0001-fs-buffer-restart-block_read_full_folio-to-avoid-arr.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSA1NTBmOGYzYjU1NmNmZDFmOTE5MGUzODk1NTExY2Y0NjY1OTUyMWQxIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBIYW5uZXMgUmVpbmVja2UgPGhhcmVAc3VzZS5kZT4K
RGF0ZTogV2VkLCAxNCBGZWIgMjAyNCAwOToyMDoyMSArMDEwMApTdWJqZWN0OiBbUEFUQ0hd
IGZzL2J1ZmZlcjogcmVzdGFydCBibG9ja19yZWFkX2Z1bGxfZm9saW8oKSB0byBhdm9pZCBh
cnJheQogb3ZlcmZsb3cKCmJsb2NrX3JlYWRfZnVsbF9mb2xpbygpIHVzZXMgYW4gb24tc3Rh
Y2sgYXJyYXkgdG8gaG9sZCBhbnkgYnVmZmVyX2hlYWRzCndoaWNoIHNob3VsZCBiZSB1cGRh
dGVkLiBUaGUgYXJyYXkgaXMgc2l6ZWQgZm9yIHRoZSBudW1iZXIgb2YgYnVmZmVyX2hlYWRz
CnBlciBQQUdFX1NJWkUsIHdoaWNoIG9mIGNvdXJzZSB3aWxsIG92ZXJmbG93IGZvciBsYXJn
ZSBmb2xpb3MuClNvIGluc3RlYWQgb2YgaW5jcmVhc2luZyB0aGUgc2l6ZSBvZiB0aGUgYXJy
YXkgKGFuZCB0aGVyZWJ5IGluY3VycmluZwphIHBvc3NpYmxlIHN0YWNrIG92ZXJmbG93IGZv
ciByZWFsbHkgbGFyZ2UgZm9saW9zKSBzdG9wIHRoZSBpdGVyYXRpb24Kd2hlbiB0aGUgYXJy
YXkgaXMgZmlsbGVkIHVwLCBzdWJtaXQgdGhlc2UgYnVmZmVyX2hlYWRzLCBhbmQgcmVzdGFy
dAp0aGUgaXRlcmF0aW9uIHdpdGggdGhlIHJlbWFpbmluZyBidWZmZXJfaGVhZHMuCgpTaWdu
ZWQtb2ZmLWJ5OiBIYW5uZXMgUmVpbmVja2UgPGhhcmVAc3VzZS5kZT4KLS0tCiBmcy9idWZm
ZXIuYyB8IDE5ICsrKysrKysrKysrKysrKysrLS0KIDEgZmlsZSBjaGFuZ2VkLCAxNyBpbnNl
cnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2ZzL2J1ZmZlci5jIGIv
ZnMvYnVmZmVyLmMKaW5kZXggZmE4OGUzMDBhOTQ2Li40MTUxMTE5M2FlNWMgMTAwNjQ0Ci0t
LSBhL2ZzL2J1ZmZlci5jCisrKyBiL2ZzL2J1ZmZlci5jCkBAIC0yMzQ5LDcgKzIzNDksNyBA
QCBpbnQgYmxvY2tfcmVhZF9mdWxsX2ZvbGlvKHN0cnVjdCBmb2xpbyAqZm9saW8sIGdldF9i
bG9ja190ICpnZXRfYmxvY2spCiB7CiAJc3RydWN0IGlub2RlICppbm9kZSA9IGZvbGlvLT5t
YXBwaW5nLT5ob3N0OwogCXNlY3Rvcl90IGlibG9jaywgbGJsb2NrOwotCXN0cnVjdCBidWZm
ZXJfaGVhZCAqYmgsICpoZWFkLCAqYXJyW01BWF9CVUZfUEVSX1BBR0VdOworCXN0cnVjdCBi
dWZmZXJfaGVhZCAqYmgsICpoZWFkLCAqcmVzdGFydF9iaCA9IE5VTEwsICphcnJbTUFYX0JV
Rl9QRVJfUEFHRV07CiAJc2l6ZV90IGJsb2Nrc2l6ZTsKIAlpbnQgbnIsIGk7CiAJaW50IGZ1
bGx5X21hcHBlZCA9IDE7CkBAIC0yMzY2LDYgKzIzNjYsNyBAQCBpbnQgYmxvY2tfcmVhZF9m
dWxsX2ZvbGlvKHN0cnVjdCBmb2xpbyAqZm9saW8sIGdldF9ibG9ja190ICpnZXRfYmxvY2sp
CiAJaWJsb2NrID0gZGl2X3U2NChmb2xpb19wb3MoZm9saW8pLCBibG9ja3NpemUpOwogCWxi
bG9jayA9IGRpdl91NjQobGltaXQgKyBibG9ja3NpemUgLSAxLCBibG9ja3NpemUpOwogCWJo
ID0gaGVhZDsKK3Jlc3RhcnQ6CiAJbnIgPSAwOwogCWkgPSAwOwogCkBAIC0yNDAwLDcgKzI0
MDEsMTIgQEAgaW50IGJsb2NrX3JlYWRfZnVsbF9mb2xpbyhzdHJ1Y3QgZm9saW8gKmZvbGlv
LCBnZXRfYmxvY2tfdCAqZ2V0X2Jsb2NrKQogCQkJCWNvbnRpbnVlOwogCQl9CiAJCWFycltu
cisrXSA9IGJoOwotCX0gd2hpbGUgKGkrKywgaWJsb2NrKyssIChiaCA9IGJoLT5iX3RoaXNf
cGFnZSkgIT0gaGVhZCk7CisJfSB3aGlsZSAoaSsrLCBpYmxvY2srKywgKGJoID0gYmgtPmJf
dGhpc19wYWdlKSAhPSBoZWFkICYmIG5yIDwgTUFYX0JVRl9QRVJfUEFHRSk7CisKKwlpZiAo
bnIgPT0gTUFYX0JVRl9QRVJfUEFHRSAmJiBiaCAhPSBoZWFkKQorCQlyZXN0YXJ0X2JoID0g
Ymg7CisJZWxzZQorCQlyZXN0YXJ0X2JoID0gTlVMTDsKIAogCWlmIChmdWxseV9tYXBwZWQp
CiAJCWZvbGlvX3NldF9tYXBwZWR0b2Rpc2soZm9saW8pOwpAQCAtMjQzMyw2ICsyNDM5LDE1
IEBAIGludCBibG9ja19yZWFkX2Z1bGxfZm9saW8oc3RydWN0IGZvbGlvICpmb2xpbywgZ2V0
X2Jsb2NrX3QgKmdldF9ibG9jaykKIAkJZWxzZQogCQkJc3VibWl0X2JoKFJFUV9PUF9SRUFE
LCBiaCk7CiAJfQorCS8qCisJICogRm91bmQgbW9yZSBidWZmZXJzIHRoYW4gJ2FycicgY291
bGQgaG9sZCwKKwkgKiByZXN0YXJ0IHRvIHN1Ym1pdCB0aGUgcmVtYWluaW5nIG9uZXMuCisJ
ICovCisJaWYgKHJlc3RhcnRfYmgpIHsKKwkJYmggPSByZXN0YXJ0X2JoOworCQlnb3RvIHJl
c3RhcnQ7CisJfQorCiAJcmV0dXJuIDA7CiB9CiBFWFBPUlRfU1lNQk9MKGJsb2NrX3JlYWRf
ZnVsbF9mb2xpbyk7Ci0tIAoyLjM1LjMKCg==

--------------OXbQbRe7LLBA7oGLZQEoccO7--
