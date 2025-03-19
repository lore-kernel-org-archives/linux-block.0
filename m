Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0439217E0;
	Wed, 19 Mar 2025 02:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742353157; cv=none; b=XaXIvbVmQCguYQMrh2x9cNvNcQUo4Nplmg/Sxl0F/9F8IspMLOrTTuNKocbz1Wlhc4LNFL7VzZ7FkmTpCVy+ApdzztD5sq1YHARo5WWg2iZzfwm9FX6/rchEdxB5MpkWzVnnMGDLsPX0gO2lXabMx1iZ0zLPmQ2p+6vV8b1GewQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742353157; c=relaxed/simple;
	bh=ORxf7Wl5D6pS8hxyVlm8qbOGe2MYj8z7WfpvvQwBnEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KL2lQ8ydV+0lPk4OR7mxxt4q2IxoNzTZP26f4zXRkX9Pl6EkoOeSOdU/HlcD0P4UEUabBQtTgtvO73vUtHUb1tLO85lYdVHTUujgUJIljsSX+KR8Pr48yFEhnxd7p0915z4WrY8eQjR8qGj/OxwNNVLJe/g0+TQvEQQg5h055wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jDoB0hg4; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jDoB0hg4"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=A6RUDuo3cNbiixoqkREg738jFP2pjKLFG8KWUHUl4c0=; b=jDoB0hg4x2xQ8jBQAABOdNuRkb
	wdwD8AnWSTs9PuPFmcCVKeyR1EKXtetZOtAd4rnPG3BwGR4uaC6bPq5lzZa4dFYQjAaJlKn+IYZ1c
	Fmh2kdaZAAbBg2oHN5vZElMEinKBLfjUOdk0aoSR5sAVTdIN3kcxsWwjDh4JA8aSpGpLTpmiuXwNO
	nNVGz4OYn9mq0kAgF5z5FmFjsl/ANEL/Y/XB7DKXmObB6rMdiIux+TJdbdxmewGQr6dn2V/X0CLSn
	g9PbLXnfsdqK/z29aNIwts4XT4hNMoO9n2YOsy4ptub+BX659yoSo5srmxfHrYsXAdLIh+QFlmGjQ
	/ojSY0sQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tujde-00000000cmK-2G74;
	Wed, 19 Mar 2025 02:58:38 +0000
Date: Wed, 19 Mar 2025 02:58:38 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Oliver Sang <oliver.sang@intel.com>,
	David Hildenbrand <david@redhat.com>,
	Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org,
	Christian Brauner <brauner@kernel.org>,
	Hannes Reinecke <hare@suse.de>, oe-lkp@lists.linux.dev,
	lkp@intel.com, John Garry <john.g.garry@oracle.com>,
	linux-block@vger.kernel.org, ltp@lists.linux.it,
	Pankaj Raghav <p.raghav@samsung.com>,
	Daniel Gomez <da.gomez@samsung.com>
Subject: Re: [linux-next:master] [block/bdev]  3c20917120:
 BUG:sleeping_function_called_from_invalid_context_at_mm/util.c
Message-ID: <Z9oy3i3n_HKFu1M1@casper.infradead.org>
References: <202503101536.27099c77-lkp@intel.com>
 <20250311-testphasen-behelfen-09b950bbecbf@brauner>
 <Z9kEdPLNT8SOyOQT@xsang-OptiPlex-9020>
 <Z9krpfrKjnFs6mfE@bombadil.infradead.org>
 <Z9mFKa3p5P9TBSTQ@casper.infradead.org>
 <Z9n_Iu6W40ZNnKwT@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9n_Iu6W40ZNnKwT@bombadil.infradead.org>

On Tue, Mar 18, 2025 at 04:17:54PM -0700, Luis Chamberlain wrote:
> Ah, then that LTP test isn't going to easily reproduce bugs around
> compaction bug. To help proactively find compaction bugs more
> deterministically we wrote generic/750 and indeed we can easily see
> issues creep up with a SOAK_DURATION=9000 on ext4 on linux-next as of
> yesterday next-20250317.

Umm .. this is an entirely separate bug.  How much COMFIG_DEBUG do you
have enabled (ie is this a consequence of something that we have an
assert for, but you've disabled?)

> BUG: unable to handle page fault for address: ffff9d5640010c48
> #PF: supervisor read access in kernel mode
> #PF: error_code(0x0000) - not-present page
> PGD 38601067 P4D 38601067 PUD 0 
> Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
> CPU: 0 UID: 0 PID: 74 Comm: kcompactd0 Not tainted 6.14.0-rc7-next-20250317 #30
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 2024.11-5 01/28/2025
> RIP: 0010:__zone_watermark_ok+0x4e/0x1e0
> Code: 00 00 00 41 f7 c0 38 02 00 00 0f 85 2c 01 00 00 48 8b 4f 30 48 63 d2 48 01 ca 85 db 0f 84 f3 00 00 00 49 29 d1 bb 80 00 00 00 <4c> 03 54 f7 38 31 d2 4d 39 ca 0f 8d d2 00 00 00 ba 01 00 00 00 85
> RSP: 0018:ffffbf47c02b7c78 EFLAGS: 00010202
> RAX: 0000000000000000 RBX: 0000000000000080 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: 0000000000002f52 RDI: ffff9d563fff9180
> RBP: 0000000000000009 R08: 0000000000000080 R09: 00000000000030a1
> R10: 0000000000000be4 R11: 0000000000000be4 R12: 0000000000000002
> R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000002f52

  2a:*	4c 03 54 f7 38       	add    0x38(%rdi,%rsi,8),%r10		<-- trapping instruction

Not quite sure what this is.  Perhaps running this through decode_stacktrace.sh
would be helpful?

> FS:  0000000000000000(0000) GS:ffff9d56b6cce000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffff9d5640010c48 CR3: 0000000115920006 CR4: 0000000000772ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> PKRU: 55555554
> Call Trace:
>  <TASK>
>  ? __die_body.cold+0x19/0x28
>  ? page_fault_oops+0xa1/0x230
>  ? search_module_extables+0x40/0x60
>  ? __zone_watermark_ok+0x4e/0x1e0
>  ? search_bpf_extables+0x5b/0x80
>  ? exc_page_fault+0x16d/0x190
>  ? __zone_watermark_ok+0x4e/0x1e0
>  ? hrtimer_try_to_cancel+0x78/0x110
>  compaction_suit_allocation_order+0x8f/0x110
>  kcompactd_do_work+0xbc/0x260
>  kcompactd+0x396/0x3e0
>  ? __pfx_autoremove_wake_function+0x10/0x10
>  ? __pfx_kcompactd+0x10/0x10
>  kthread+0xf6/0x240
>  ? __pfx_kthread+0x10/0x10
>  ? _raw_spin_unlock+0x15/0x30
>  ? finish_task_switch.isra.0+0x94/0x290
>  ? __pfx_kthread+0x10/0x10
>  ret_from_fork+0x2d/0x50
>  ? __pfx_kthread+0x10/0x10
>  ret_from_fork_asm+0x1a/0x30
>  </TASK>
> Modules linked in: exfat xfs ext2 loop sunrpc 9p nls_iso8859_1 nls_cp437 crc32c_generic vfat fat kvm_intel kvm ghash_clmulni_intel sha512_ssse3 sha512_generic sha256_ssse3 sha1_ssse3 aesni_intel gf128mul crypto_simd cryptd 9pnet_virtio virtio_console virtio_balloon button joydev evdev serio_raw nvme_fabrics dm_mod nvme_core drm vsock_loopback vmw_vsock_virtio_transport_common vsock nfnetlink autofs4 ext4 crc16 mbcache jbd2 btrfs blake2b_generic efivarfs raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq raid1 raid0 md_mod virtio_net net_failover failover virtio_blk psmouse virtio_pci virtio_pci_legacy_dev virtio_pci_modern_dev virtio virtio_ring
> CR2: ffff9d5640010c48
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:__zone_watermark_ok+0x4e/0x1e0
> Code: 00 00 00 41 f7 c0 38 02 00 00 0f 85 2c 01 00 00 48 8b 4f 30 48 63 d2 48 01 ca 85 db 0f 84 f3 00 00 00 49 29 d1 bb 80 00 00 00 <4c> 03 54 f7 38 31 d2 4d 39 ca 0f 8d d2 00 00 00 ba 01 00 00 00 85
> RSP: 0018:ffffbf47c02b7c78 EFLAGS: 00010202
> RAX: 0000000000000000 RBX: 0000000000000080 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: 0000000000002f52 RDI: ffff9d563fff9180
> RBP: 0000000000000009 R08: 0000000000000080 R09: 00000000000030a1
> R10: 0000000000000be4 R11: 0000000000000be4 R12: 0000000000000002
> R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000002f52
> FS:  0000000000000000(0000) GS:ffff9d56b6cce000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffff9d5640010c48 CR3: 0000000115920006 CR4: 0000000000772ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> PKRU: 55555554
> note: kcompactd0[74] exited with irqs disabled
