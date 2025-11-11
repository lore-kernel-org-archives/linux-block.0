Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923582522A7
	for <linux-block@vger.kernel.org>; Tue, 11 Nov 2025 04:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762835187; cv=none; b=l4UItq/ZtiQQIMA4RE8WDYG5dprx/78tkf+OrZcPVlk+Es8FB+L6pP0HTosJKiP1LOvNpKwlonivGrLI5DP61lUHZcEcqbn6BnydbQfvVMIWBc0j68ooAbxLr96069pVNBwF1XqH3ha0IXRa1pQyR+ypLAJBUFMUrJaDMwFF4UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762835187; c=relaxed/simple;
	bh=AIBWUK/icsYshQTN4IFrZwBxd5nmKK/UotwNpaiTnmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LwI7gSi1ifbDNQjFAi4C+zMA3C9MfarSoghBKXcloMK/bW/kztzrVusyqbFAnozMO3rJlPBoiQNh7T9aTvr33P4gYKsm4UWPhUZjZe5svLXey13h5gd0Q1ozakXDzwKpqMs8WoV9Jp9hm4hghcOos3UGssKnuNnDb9CM7vAC0Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=EoMpa7vs; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EoMpa7vs"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=mnPvZZHd0PsXMl65PHk56JXEdP4cQxdmbJtes24hSjw=; b=EoMpa7vssz09Yrl1nMqoYp2Gjp
	edjdtdw7On0Pgczak9J0TLMA4Ue6O5/lCDr+A5yWBXB6vIcNCSkmQVJQAD+Ek6JCemhGcMfPGHcXx
	f2pBmUsPe0LRnalAq198RKq3KvSbtRpg+PHNeYfTSzWlvpw4jltDL/i0xK6w8ieWH9eG1QIRPyruS
	rzxtoFb73Y3Ifmzu4AqwtqXTrkHj9+SFjkWR5JktKZsO6bEsylUCfkbOisEMkrbKsFHgA4IUlDSfX
	lbFGGjTwkjVnipQjUE9H5nUaYzR4/e9uRA4Rlu/AezaPKnOodp2Er73uFOfH3o7wokCFoYxsM5mIT
	dm7f5C3A==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIfxV-0000000ER5s-2OuB;
	Tue, 11 Nov 2025 04:26:21 +0000
Date: Tue, 11 Nov 2025 04:26:21 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Keith Busch <kbusch@meta.com>
Cc: hch@lst.de, linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	axboe@kernel.dk, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv5 1/2] block: accumulate memory segment gaps per bio
Message-ID: <aRK67ahJn15u5OGC@casper.infradead.org>
References: <20251014150456.2219261-1-kbusch@meta.com>
 <20251014150456.2219261-2-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014150456.2219261-2-kbusch@meta.com>

On Tue, Oct 14, 2025 at 08:04:55AM -0700, Keith Busch wrote:
> The blk-mq dma iterator has an optimization for requests that align to
> the device's iommu merge boundary. This boundary may be larger than the
> device's virtual boundary, but the code had been depending on that queue
> limit to know ahead of time if the request is guaranteed to align to
> that optimization.
> 
> Rather than rely on that queue limit, which many devices may not report,
> save the lowest set bit of any boundary gap between each segment in the
> bio while checking the segments. The request stores the value for
> merging and quickly checking per io if the request can use iova
> optimizations.

Hi Keith,

I just hit this bug:

generic/455       run fstests generic/455 at 2025-11-11 04:11:25
XFS (vdb): Mounting V5 Filesystem 54edd3b5-5306-493b-9ecd-f06cd9a8d669
XFS (vdb): Ending clean mount
XFS (dm-4): Mounting V5 Filesystem 3eb16918-3537-4d69-999a-ba226510f6c2
XFS (dm-4): Ending clean mount
XFS (dm-4): Unmounting Filesystem 3eb16918-3537-4d69-999a-ba226510f6c2
BUG: kernel NULL pointer dereference, address: 0000000000000008
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 0 P4D 0
Oops: Oops: 0000 [#1] SMP NOPTI
CPU: 0 UID: 0 PID: 1614197 Comm: kworker/u64:2 Not tainted 6.18.0-rc4-next-20251
110-ktest-00017-g2307dc640a8d #131 NONE
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Workqueue: dm-thin do_worker
RIP: 0010:bio_get_last_bvec+0x20/0xe0
Code: 90 90 90 90 90 90 90 90 90 90 55 49 89 f2 48 89 f9 48 89 e5 53 8b 77 2c 8b 47 30 44 8b 4f 28 49 89 f0 49 c1 e0 04 4c 03 47 50 <41> 8b 78 08 41 8b 58 0c 4d 8b 18 29 c7 44 39 cf 4d 89 1a 41 0f 47
RSP: 0018:ffff88814d1ef8d8 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff8881044b5500 RCX: ffff88811fd23d78
RDX: ffff88811fd235f8 RSI: 0000000000000000 RDI: ffff88811fd23d78
RBP: ffff88814d1ef8e0 R08: 0000000000000000 R09: 0000000000020000
R10: ffff88814d1ef8f0 R11: 0000000000000200 R12: 0000000000000000
R13: ffff88811fd235f8 R14: 0000000000000000 R15: ffff8881044b5500
FS:  0000000000000000(0000) GS:ffff8881f6ac9000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000008 CR3: 000000000263a000 CR4: 0000000000750eb0
PKRU: 55555554
Call Trace:
 <TASK>
 bio_seg_gap+0x4c/0x150
 bio_attempt_front_merge+0x19a/0x3a0
 blk_attempt_bio_merge.part.0+0xb4/0x110
 blk_attempt_plug_merge+0xd6/0xe0
 blk_mq_submit_bio+0x76c/0x9f0
 ? lock_release+0xbb/0x260
 __submit_bio+0xa5/0x380
 submit_bio_noacct_nocheck+0x126/0x380
 ? submit_bio_noacct_nocheck+0x126/0x380
 submit_bio_noacct+0x17f/0x3c0
 ? __cond_resched+0x1e/0x60
 submit_bio+0xd6/0x100
 end_discard+0x3a/0x90
 process_prepared_discard_passdown_pt1+0xff/0x180
 process_discard_cell_passdown+0x19e/0x2a0
 process_discard_bio+0x105/0x1a0
 do_worker+0x824/0xa40
 ? process_one_work+0x1ad/0x530
 process_one_work+0x1ed/0x530
 ? move_linked_works+0x77/0xb0
 worker_thread+0x1cf/0x3d0
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x100/0x220
 ? _raw_spin_unlock_irq+0x2b/0x40
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x249/0x280
 ? __pfx_kthread+0x10/0x10
 ret_from_fork_asm+0x1a/0x30
 </TASK>
Modules linked in: [last unloaded: crc_t10dif]
CR2: 0000000000000008
---[ end trace 0000000000000000 ]---
RIP: 0010:bio_get_last_bvec+0x20/0xe0
Code: 90 90 90 90 90 90 90 90 90 90 55 49 89 f2 48 89 f9 48 89 e5 53 8b 77 2c 8b 47 30 44 8b 4f 28 49 89 f0 49 c1 e0 04 4c 03 47 50 <41> 8b 78 08 41 8b 58 0c 4d 8b 18 29 c7 44 39 cf 4d 89 1a 41 0f 47
RSP: 0018:ffff88814d1ef8d8 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff8881044b5500 RCX: ffff88811fd23d78
RDX: ffff88811fd235f8 RSI: 0000000000000000 RDI: ffff88811fd23d78
RBP: ffff88814d1ef8e0 R08: 0000000000000000 R09: 0000000000020000
R10: ffff88814d1ef8f0 R11: 0000000000000200 R12: 0000000000000000
R13: ffff88811fd235f8 R14: 0000000000000000 R15: ffff8881044b5500
FS:  0000000000000000(0000) GS:ffff8881f6ac9000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000008 CR3: 000000000263a000 CR4: 0000000000750eb0
PKRU: 55555554
Kernel panic - not syncing: Fatal exception
Kernel Offset: disabled
---[ end Kernel panic - not syncing: Fatal exception ]---

I'm not saying it's definitely your patch; after all, there's 17 of
my slab patches on top of next-20251110, but when I looked on lore for
'bio_get_last_bvec' this was the only patch since 2021 that mentioned it,
so I thought I'd drop you a note in case you see the bug immediately.
I'm heading to bed, and will be out tomorrow, so my opportunities to be
helpful will be limited.
