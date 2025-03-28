Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EEE20E6;
	Fri, 28 Mar 2025 09:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743155281; cv=none; b=PCsHt6RIAxsphuxlh4pfsMxFzkz2xLPuKi5eTSYQ/B5mLwmhMd3IoXaVWTfCpTHVieaRc6QWHRRiY0iDM/VYTZNh1PROugj3uJNfqAGkoNEs+WM/goP2eCn5xE3rBGTlsGjjyC8EXfclPknAxVtTsl4KIU5WZe5xzdgnJznsAAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743155281; c=relaxed/simple;
	bh=L1ZhqRI/3AJIXQgEqaTudZR8WC5Mp92X10KbrCftwaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d0KiM4Fovs0/NVaYbQIJYM6OYGWg1l4TxgCQhcr14rvE0jnUPJGRCdUlMsROlTeXs/qGXl1lwYIPjtGs9cXO9mR59CfK5t+iwyk2PRvclG6fGlo7V+OcdWig7DHzTRSqebvQc6EFv3J3lh8lYEyDLItlvoVQlYJnVGOrhGmKIcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=enYSWdxw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="enYSWdxw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66014C4CEE4;
	Fri, 28 Mar 2025 09:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743155280;
	bh=L1ZhqRI/3AJIXQgEqaTudZR8WC5Mp92X10KbrCftwaE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=enYSWdxwpGyjDxGb/SJLtqANY8cacr0AHWSdU8cA/Uspwi3xJRKoaFea0DNJBuTD1
	 6qqR1EKuZP1hm8jAD7n1U4b9zBP5lnQpCfGHtWTEh+PUTwc80D++zBXCcvutiPb/w1
	 KzAhWJ4LMIg2pE6AZMDXUHWq01IEgwFpHuAzjFDQFUFK+px0fYNeBcv8R9yA5x1OYc
	 RhEerHZvXx+UjG3amXr5TnTjF7riaCxXREOOJyCXhlSGdnd1xvB4quocMb88cZUU/4
	 9NcurqWuhoic9KipXxlMwIYLN8zpGJhhvM6IL1dXI2PJvzZ8arGnoX0FV1f+8crihO
	 yY3MIMZjpR/aA==
Date: Fri, 28 Mar 2025 02:47:58 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Jan Kara <jack@suse.cz>, Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Oliver Sang <oliver.sang@intel.com>,
	Matthew Wilcox <willy@infradead.org>,
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
Message-ID: <Z-ZwToVfJbdTVRtG@bombadil.infradead.org>
References: <Z9r27eUk993BNWTX@bombadil.infradead.org>
 <Z9sYGccL4TocoITf@bombadil.infradead.org>
 <Z9sZ5_lJzTwGShQT@casper.infradead.org>
 <Z9wF57eEBR-42K9a@bombadil.infradead.org>
 <20250322231440.GA1894930@cmpxchg.org>
 <Z99dk_ZMNRFgaaH8@bombadil.infradead.org>
 <Z9-zL3pRpCHm5a0w@bombadil.infradead.org>
 <Z+JSwb8BT0tZrSrx@xsang-OptiPlex-9020>
 <Z-X_FiXDTSvRSksp@bombadil.infradead.org>
 <Z-YjyBF-M9ciJC7X@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-YjyBF-M9ciJC7X@bombadil.infradead.org>

On Thu, Mar 27, 2025 at 09:21:30PM -0700, Luis Chamberlain wrote:
> Would the extra ref check added via commit 060913999d7a9e50 ("mm:
> migrate: support poisoned recover from migrate folio") make the removal
> of the spin lock safe now given all the buffers are locked from the
> folio? This survives some basic sanity checks on my end with
> generic/750 against ext4 and also filling a drive at the same time with
> fio. I have a feeling is we are not sure, do we have a reproducer for
> the issue reported through ebdf4de5642fb6 ("mm: migrate: fix reference
> check race between __find_get_block() and migration")? I suspect the
> answer is no.

<-- snip -->

> diff --git a/mm/migrate.c b/mm/migrate.c
> index 97f0edf0c032..6a5d125ecde9 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -859,12 +859,12 @@ static int __buffer_migrate_folio(struct address_space *mapping,
>  			}
>  			bh = bh->b_this_page;
>  		} while (bh != head);
> +		spin_unlock(&mapping->i_private_lock);
>  		if (busy) {
>  			if (invalidated) {
>  				rc = -EAGAIN;
>  				goto unlock_buffers;
>  			}
> -			spin_unlock(&mapping->i_private_lock);
>  			invalidate_bh_lrus();
>  			invalidated = true;
>  			goto recheck_buffers;
> @@ -882,8 +882,6 @@ static int __buffer_migrate_folio(struct address_space *mapping,
>  	} while (bh != head);
>  
>  unlock_buffers:
> -	if (check_refs)
> -		spin_unlock(&mapping->i_private_lock);
>  	bh = head;
>  	do {
>  		unlock_buffer(bh);
> diff --git a/mm/util.c b/mm/util.c
> index 448117da071f..3585bdb8700a 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -735,6 +735,8 @@ int folio_mc_copy(struct folio *dst, struct folio *src)
>  	long nr = folio_nr_pages(src);
>  	long i = 0;
>  
> +	might_sleep();
> +
>  	for (;;) {
>  		if (copy_mc_highpage(folio_page(dst, i), folio_page(src, i)))
>  			return -EHWPOISON;

Nah, this ends up producing the following so I'm inclined at this point
to just rever the 64k 64k block size enablment until we get this figured
out because I can't think of an easy quick solution to this.


Mar 28 03:35:30 extra-ext4-4k kernel: Linux version 6.14.0-rc7-next-20250321-dirty (mcgrof@beef) (gcc (Debian 14.2.0-16) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44) #57 SMP PREEMPT_DYNAMIC Fri Mar 28 03:33:04 UTC 2025
Mar 28 03:35:30 extra-ext4-4k kernel: Command line: BOOT_IMAGE=/boot/vmlinuz-6.14.0-rc7-next-20250321-dirty root=PARTUUID=503fa6f2-2d5b-4d7e-8cf8-3a811de326ce ro console=tty0 console=tty1 console=ttyS0,115200n8 console=ttyS0

<-- snip -->

Mar 28 03:36:32 extra-ext4-4k kernel: EXT4-fs (loop16): mounted filesystem 90cdb700-ad4a-4261-a1be-4f4627772317 r/w with ordered data mode. Quota mode: none.
Mar 28 03:36:37 extra-ext4-4k kernel: EXT4-fs (loop5): mounted filesystem fef0662d-01fc-483d-87ac-8e4ef2939de3 r/w with ordered data mode. Quota mode: none.
Mar 28 03:36:37 extra-ext4-4k kernel: EXT4-fs (loop5): unmounting filesystem fef0662d-01fc-483d-87ac-8e4ef2939de3.
Mar 28 03:36:37 extra-ext4-4k kernel: EXT4-fs (loop16): unmounting filesystem 90cdb700-ad4a-4261-a1be-4f4627772317.
Mar 28 03:36:37 extra-ext4-4k kernel: EXT4-fs (loop16): mounted filesystem 90cdb700-ad4a-4261-a1be-4f4627772317 r/w with ordered data mode. Quota mode: none.
Mar 28 03:36:37 extra-ext4-4k unknown: run fstests generic/750 at 2025-03-28 03:36:37
Mar 28 03:36:39 extra-ext4-4k kernel: EXT4-fs (loop5): mounted filesystem ed8a8fa0-0ea1-4820-aa26-366cd64a6e36 r/w with ordered data mode. Quota mode: none.
Mar 28 03:39:06 extra-ext4-4k kernel: rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { P7603 } 8 jiffies s: 565 root: 0x0/T
Mar 28 03:39:06 extra-ext4-4k kernel: rcu: blocking rcu_node structures (internal RCU debug):
Mar 28 03:59:47 extra-ext4-4k kernel: NOHZ tick-stop error: local softirq work is pending, handler #10!!!
Mar 28 04:24:47 extra-ext4-4k kernel: ------------[ cut here ]------------
Mar 28 04:24:47 extra-ext4-4k kernel: WARNING: CPU: 7 PID: 1790 at mm/slub.c:4756 free_large_kmalloc+0xc1/0x100
Mar 28 04:24:47 extra-ext4-4k kernel: Modules linked in: loop sunrpc 9p nls_iso8859_1 kvm_intel nls_cp437 vfat crc32c_generic fat kvm ghash_clmulni_intel sha512_ssse3 sha256_ssse3 sha1_ssse3 aesni_intel gf128mul crypto_simd cryptd 9pnet_virtio virtio_balloon virtio_console evdev button joydev serio_raw nvme_fabrics nvme_core dm_mod drm nfnetlink vsock_loopback vmw_vsock_virtio_transport_common vsock autofs4 ext4 crc16 mbcache jbd2 btrfs blake2b_generic efivarfs raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq raid1 raid0 md_mod virtio_net net_failover failover virtio_blk virtio_pci virtio_pci_legacy_dev virtio_pci_modern_dev psmouse virtio virtio_ring
Mar 28 04:24:47 extra-ext4-4k kernel: CPU: 7 UID: 0 PID: 1790 Comm: fsstress Not tainted 6.14.0-rc7-next-20250321-dirty #57 PREEMPT(full) 
Mar 28 04:24:47 extra-ext4-4k kernel: Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 2024.11-5 01/28/2025
Mar 28 04:24:47 extra-ext4-4k kernel: RIP: 0010:free_large_kmalloc+0xc1/0x100
Mar 28 04:24:47 extra-ext4-4k kernel: Code: f8 00 00 00 75 24 0f 0b 80 3d de 57 3b 01 00 0f 84 4f 63 be ff bd 00 f0 ff ff eb 8e 48 c7 c6 10 03 27 90 e8 61 32 fa ff 0f 0b <0f> 0b 48 83 c4 08 48 89 df 48 c7 c6 18 db 31 90 5b 5d e9 48 32 fa
Mar 28 04:24:47 extra-ext4-4k kernel: RSP: 0018:ffffa95942a67ac8 EFLAGS: 00010202
Mar 28 04:24:47 extra-ext4-4k kernel: RAX: 00000000000000ff RBX: fffffc63c4219c40 RCX: 0000000000000001
Mar 28 04:24:47 extra-ext4-4k kernel: RDX: 0000000000000000 RSI: ffff978e08671000 RDI: fffffc63c4219c40
Mar 28 04:24:47 extra-ext4-4k kernel: RBP: 0000000000000000 R08: 0000000000000020 R09: fffffffffffffff0
Mar 28 04:24:47 extra-ext4-4k kernel: R10: 00000000000000a0 R11: 0000000000000004 R12: 0000000000000000
Mar 28 04:24:47 extra-ext4-4k kernel: R13: ffff978e08671000 R14: 0000000000000000 R15: ffff978d03bf1000
Mar 28 04:24:47 extra-ext4-4k kernel: FS:  00007fefc4670740(0000) GS:ffff978eecda0000(0000) knlGS:0000000000000000
Mar 28 04:24:47 extra-ext4-4k kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Mar 28 04:24:47 extra-ext4-4k kernel: CR2: 00007fefc4872000 CR3: 0000000075fa6002 CR4: 0000000000772ef0
Mar 28 04:24:47 extra-ext4-4k kernel: DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
Mar 28 04:24:47 extra-ext4-4k kernel: DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Mar 28 04:24:47 extra-ext4-4k kernel: PKRU: 55555554
Mar 28 04:24:47 extra-ext4-4k kernel: Call Trace:
Mar 28 04:24:47 extra-ext4-4k kernel:  <TASK>
Mar 28 04:24:47 extra-ext4-4k kernel:  ? __warn.cold+0xb7/0x14f
Mar 28 04:24:47 extra-ext4-4k kernel:  ? free_large_kmalloc+0xc1/0x100
Mar 28 04:24:47 extra-ext4-4k kernel:  ? report_bug+0xe6/0x170
Mar 28 04:24:47 extra-ext4-4k kernel:  ? free_large_kmalloc+0xc1/0x100
Mar 28 04:24:47 extra-ext4-4k kernel:  ? handle_bug+0x199/0x260
Mar 28 04:24:47 extra-ext4-4k kernel:  ? exc_invalid_op+0x13/0x60
Mar 28 04:24:47 extra-ext4-4k kernel:  ? asm_exc_invalid_op+0x16/0x20
Mar 28 04:24:47 extra-ext4-4k kernel:  ? free_large_kmalloc+0xc1/0x100
Mar 28 04:24:47 extra-ext4-4k kernel:  ext4_xattr_block_set+0x191/0x1200 [ext4]
Mar 28 04:24:47 extra-ext4-4k kernel:  ? xattr_find_entry+0x96/0x110 [ext4]
Mar 28 04:24:47 extra-ext4-4k kernel:  ext4_xattr_set_handle+0x572/0x630 [ext4]
Mar 28 04:24:47 extra-ext4-4k kernel:  ext4_xattr_set+0x7c/0x150 [ext4]
Mar 28 04:24:47 extra-ext4-4k kernel:  __vfs_removexattr+0x7c/0xb0
Mar 28 04:24:47 extra-ext4-4k kernel:  __vfs_removexattr_locked+0xb7/0x150
Mar 28 04:24:47 extra-ext4-4k kernel:  vfs_removexattr+0x58/0x100
Mar 28 04:24:47 extra-ext4-4k kernel:  path_removexattrat+0x17d/0x330
Mar 28 04:24:47 extra-ext4-4k kernel:  ? __do_sys_newfstatat+0x33/0x60
Mar 28 04:24:47 extra-ext4-4k kernel:  __x64_sys_removexattr+0x19/0x20
Mar 28 04:24:47 extra-ext4-4k kernel:  do_syscall_64+0x69/0x140
Mar 28 04:24:47 extra-ext4-4k kernel:  entry_SYSCALL_64_after_hwframe+0x76/0x7e
Mar 28 04:24:47 extra-ext4-4k kernel: RIP: 0033:0x7fefc4781037
Mar 28 04:24:47 extra-ext4-4k kernel: Code: f0 ff ff 73 01 c3 48 8b 0d be 8d 0d 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 b8 c5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 91 8d 0d 00 f7 d8 64 89 01 48
Mar 28 04:24:47 extra-ext4-4k kernel: RSP: 002b:00007ffc2b5a5d48 EFLAGS: 00000206 ORIG_RAX: 00000000000000c5
Mar 28 04:24:47 extra-ext4-4k kernel: RAX: ffffffffffffffda RBX: 000000000002d937 RCX: 00007fefc4781037
Mar 28 04:24:47 extra-ext4-4k kernel: RDX: 0000000000000000 RSI: 00007ffc2b5a5d70 RDI: 0000563075ae5850
Mar 28 04:24:47 extra-ext4-4k kernel: RBP: 00007ffc2b5a5d70 R08: 0000000000000064 R09: 00000000ffffffff
Mar 28 04:24:47 extra-ext4-4k kernel: R10: 0000000000000000 R11: 0000000000000206 R12: 00000000000030d4
Mar 28 04:24:47 extra-ext4-4k kernel: R13: 8f5c28f5c28f5c29 R14: 00007ffc2b5a5e20 R15: 0000563064291ea0
Mar 28 04:24:47 extra-ext4-4k kernel:  </TASK>
Mar 28 04:24:47 extra-ext4-4k kernel: irq event stamp: 94586373
Mar 28 04:24:47 extra-ext4-4k kernel: hardirqs last  enabled at (94586383): [<ffffffff8f19ee1e>] __up_console_sem+0x5e/0x70
Mar 28 04:24:47 extra-ext4-4k kernel: hardirqs last disabled at (94586394): [<ffffffff8f19ee03>] __up_console_sem+0x43/0x70
Mar 28 04:24:47 extra-ext4-4k kernel: softirqs last  enabled at (94585948): [<ffffffff8f0ffa53>] __irq_exit_rcu+0xc3/0x120
Mar 28 04:24:47 extra-ext4-4k kernel: softirqs last disabled at (94585929): [<ffffffff8f0ffa53>] __irq_exit_rcu+0xc3/0x120
Mar 28 04:24:47 extra-ext4-4k kernel: ---[ end trace 0000000000000000 ]---
Mar 28 04:24:47 extra-ext4-4k kernel: page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x402a88 pfn:0x108671
Mar 28 04:24:47 extra-ext4-4k kernel: flags: 0x57fffc000000000(node=1|zone=2|lastcpupid=0x1ffff)
Mar 28 04:24:47 extra-ext4-4k kernel: raw: 057fffc000000000 dead000000000100 dead000000000122 0000000000000000
Mar 28 04:24:47 extra-ext4-4k kernel: raw: 0000000000402a88 0000000000000000 00000000ffffffff 0000000000000000
Mar 28 04:24:47 extra-ext4-4k kernel: page dumped because: Not a kmalloc allocation
Mar 28 04:50:41 extra-ext4-4k kernel: BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!
Mar 28 04:50:41 extra-ext4-4k kernel: turning off the locking correctness validator.
Mar 28 04:50:41 extra-ext4-4k kernel: CPU: 4 UID: 0 PID: 668 Comm: btrfs-transacti Tainted: G        W           6.14.0-rc7-next-20250321-dirty #57 PREEMPT(full) 
Mar 28 04:50:41 extra-ext4-4k kernel: Tainted: [W]=WARN
Mar 28 04:50:41 extra-ext4-4k kernel: Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 2024.11-5 01/28/2025
Mar 28 04:50:41 extra-ext4-4k kernel: Call Trace:
Mar 28 04:50:41 extra-ext4-4k kernel:  <TASK>
Mar 28 04:50:41 extra-ext4-4k kernel:  dump_stack_lvl+0x68/0x90
Mar 28 04:50:41 extra-ext4-4k kernel:  __lock_acquire+0x1eaf/0x2210
Mar 28 04:50:41 extra-ext4-4k kernel:  ? __lock_acquire+0xc77/0x2210
Mar 28 04:50:41 extra-ext4-4k kernel:  lock_acquire+0xd1/0x2e0
Mar 28 04:50:41 extra-ext4-4k kernel:  ? put_cpu_partial+0x5f/0x1d0
Mar 28 04:50:41 extra-ext4-4k kernel:  ? lock_acquire+0xe1/0x2e0
Mar 28 04:50:41 extra-ext4-4k kernel:  put_cpu_partial+0x68/0x1d0
Mar 28 04:50:41 extra-ext4-4k kernel:  ? put_cpu_partial+0x5f/0x1d0
Mar 28 04:50:41 extra-ext4-4k kernel:  get_partial_node.part.0+0xde/0x400
Mar 28 04:50:41 extra-ext4-4k kernel:  ___slab_alloc+0x361/0x13c0
Mar 28 04:50:41 extra-ext4-4k kernel:  ? __alloc_object+0x2f/0x240
Mar 28 04:50:41 extra-ext4-4k kernel:  ? mark_held_locks+0x40/0x70
Mar 28 04:50:41 extra-ext4-4k kernel:  ? ___slab_alloc+0x701/0x13c0
Mar 28 04:50:41 extra-ext4-4k kernel:  ? lockdep_hardirqs_on+0x78/0x100
Mar 28 04:50:41 extra-ext4-4k kernel:  ? __alloc_object+0x2f/0x240
Mar 28 04:50:41 extra-ext4-4k kernel:  ? __slab_alloc.isra.0+0x52/0xa0
Mar 28 04:50:41 extra-ext4-4k kernel:  __slab_alloc.isra.0+0x52/0xa0
Mar 28 04:50:41 extra-ext4-4k kernel:  ? __alloc_object+0x2f/0x240
Mar 28 04:50:41 extra-ext4-4k kernel:  kmem_cache_alloc_noprof+0x1e3/0x430
Mar 28 04:50:41 extra-ext4-4k kernel:  ? xas_alloc+0x9f/0xc0
Mar 28 04:50:41 extra-ext4-4k kernel:  __alloc_object+0x2f/0x240
Mar 28 04:50:41 extra-ext4-4k kernel:  __create_object+0x22/0x90
Mar 28 04:50:41 extra-ext4-4k kernel:  ? xas_alloc+0x9f/0xc0
Mar 28 04:50:41 extra-ext4-4k kernel:  kmem_cache_alloc_lru_noprof+0x337/0x430
Mar 28 04:50:41 extra-ext4-4k kernel:  ? __lock_acquire+0x45d/0x2210
Mar 28 04:50:41 extra-ext4-4k kernel:  ? stack_depot_save_flags+0x23/0x9d0
Mar 28 04:50:41 extra-ext4-4k kernel:  xas_alloc+0x9f/0xc0
Mar 28 04:50:41 extra-ext4-4k kernel:  xas_create+0x309/0x6f0
Mar 28 04:50:41 extra-ext4-4k kernel:  xas_store+0x54/0x700
Mar 28 04:50:41 extra-ext4-4k kernel:  __xa_cmpxchg+0xb9/0x140
Mar 28 04:50:41 extra-ext4-4k kernel:  add_delayed_ref+0x11d/0xa50 [btrfs]
Mar 28 04:50:41 extra-ext4-4k kernel:  btrfs_alloc_tree_block+0x3ea/0x5a0 [btrfs]
Mar 28 04:50:41 extra-ext4-4k kernel:  split_leaf+0x167/0x6d0 [btrfs]
Mar 28 04:50:41 extra-ext4-4k kernel:  setup_leaf_for_split+0x19f/0x200 [btrfs]
Mar 28 04:50:41 extra-ext4-4k kernel:  btrfs_split_item+0x21/0x50 [btrfs]
Mar 28 04:50:41 extra-ext4-4k kernel:  btrfs_del_csums+0x270/0x3a0 [btrfs]
Mar 28 04:50:41 extra-ext4-4k kernel:  ? btrfs_csum_root+0x83/0xb0 [btrfs]
Mar 28 04:50:41 extra-ext4-4k kernel:  __btrfs_free_extent.isra.0+0x5fb/0xcc0 [btrfs]
Mar 28 04:50:41 extra-ext4-4k kernel:  __btrfs_run_delayed_refs+0x51d/0xf40 [btrfs]
Mar 28 04:50:41 extra-ext4-4k kernel:  btrfs_run_delayed_refs+0x3d/0x110 [btrfs]
Mar 28 04:50:41 extra-ext4-4k kernel:  btrfs_commit_transaction+0x8f/0xee0 [btrfs]
Mar 28 04:50:41 extra-ext4-4k kernel:  ? btrfs_init_block_rsv+0x51/0x60 [btrfs]
Mar 28 04:50:41 extra-ext4-4k kernel:  ? start_transaction+0x22c/0xaa0 [btrfs]
Mar 28 04:50:41 extra-ext4-4k kernel:  transaction_kthread+0x152/0x1b0 [btrfs]
Mar 28 04:50:41 extra-ext4-4k kernel:  ? __pfx_transaction_kthread+0x10/0x10 [btrfs]
Mar 28 04:50:41 extra-ext4-4k kernel:  kthread+0x107/0x250
Mar 28 04:50:41 extra-ext4-4k kernel:  ? find_held_lock+0x2b/0x80
Mar 28 04:50:41 extra-ext4-4k kernel:  ? ret_from_fork+0x17/0x50
Mar 28 04:50:41 extra-ext4-4k kernel:  ? ret_from_fork+0x17/0x50
Mar 28 04:50:41 extra-ext4-4k kernel:  ? lock_release+0x17d/0x2c0
Mar 28 04:50:41 extra-ext4-4k kernel:  ? __pfx_kthread+0x10/0x10
Mar 28 04:50:41 extra-ext4-4k kernel:  ? __pfx_kthread+0x10/0x10
Mar 28 04:50:41 extra-ext4-4k kernel:  ret_from_fork+0x2d/0x50
Mar 28 04:50:41 extra-ext4-4k kernel:  ? __pfx_kthread+0x10/0x10
Mar 28 04:50:41 extra-ext4-4k kernel:  ret_from_fork_asm+0x1a/0x30
Mar 28 04:50:41 extra-ext4-4k kernel:  </TASK>
Mar 28 05:04:32 extra-ext4-4k kernel: page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x20889c pfn:0x4a3e
Mar 28 05:04:32 extra-ext4-4k kernel: flags: 0xffffc000000000(node=0|zone=1|lastcpupid=0x1ffff)
Mar 28 05:04:32 extra-ext4-4k kernel: raw: 00ffffc000000000 fffffc63c041d448 ffff978d7bc347f0 0000000000000000
Mar 28 05:04:32 extra-ext4-4k kernel: raw: 000000000020889c 0000000000000000 00000000ffffffff 0000000000000000
Mar 28 05:04:32 extra-ext4-4k kernel: page dumped because: Not a kmalloc allocation
Mar 28 05:31:13 extra-ext4-4k kernel: page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x498b96 pfn:0x76f4
Mar 28 05:31:13 extra-ext4-4k kernel: flags: 0xffffc000000000(node=0|zone=1|lastcpupid=0x1ffff)
Mar 28 05:31:13 extra-ext4-4k kernel: raw: 00ffffc000000000 fffffc63c01d9308 fffffc63c01df648 0000000000000000
Mar 28 05:31:13 extra-ext4-4k kernel: raw: 0000000000498b96 0000000000000000 00000000ffffffff 0000000000000000
Mar 28 05:31:13 extra-ext4-4k kernel: page dumped because: Not a kmalloc allocation
Mar 28 05:57:09 extra-ext4-4k kernel: EXT4-fs error (device loop5): ext4_get_first_dir_block:3538: inode #5174: comm fsstress: directory missing '.'
Mar 28 06:04:43 extra-ext4-4k kernel: EXT4-fs warning (device loop5): ext4_empty_dir:3088: inode #5176: comm fsstress: directory missing '.'
Mar 28 06:05:19 extra-ext4-4k kernel: page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x243117 pfn:0x104ddb
Mar 28 06:05:19 extra-ext4-4k kernel: flags: 0x57fffc000000000(node=1|zone=2|lastcpupid=0x1ffff)
Mar 28 06:05:19 extra-ext4-4k kernel: raw: 057fffc000000000 fffffc63c4136fc8 ffff978d7bcb4970 0000000000000000
Mar 28 06:05:19 extra-ext4-4k kernel: raw: 0000000000243117 0000000000000000 00000000ffffffff 0000000000000000
Mar 28 06:05:19 extra-ext4-4k kernel: page dumped because: Not a kmalloc allocation
Mar 28 06:15:16 extra-ext4-4k kernel: EXT4-fs warning (device loop5): ext4_empty_dir:3088: inode #5176: comm fsstress: directory missing '.'
Mar 28 06:23:04 extra-ext4-4k kernel: EXT4-fs error (device loop5): __ext4_find_entry:1626: inode #5173: comm fsstress: checksumming directory block 0
Mar 28 06:23:15 extra-ext4-4k kernel: EXT4-fs error (device loop5): __ext4_find_entry:1626: inode #5173: comm fsstress: checksumming directory block 0
Mar 28 06:23:23 extra-ext4-4k kernel: EXT4-fs error (device loop5): __ext4_find_entry:1626: inode #5173: comm fsstress: checksumming directory block 0
Mar 28 06:23:28 extra-ext4-4k kernel: EXT4-fs error (device loop5): __ext4_find_entry:1626: inode #5173: comm fsstress: checksumming directory block 0
Mar 28 06:23:43 extra-ext4-4k kernel: EXT4-fs error (device loop5): __ext4_find_entry:1626: inode #5173: comm fsstress: checksumming directory block 0
Mar 28 06:24:02 extra-ext4-4k kernel: EXT4-fs error (device loop5): __ext4_find_entry:1626: inode #5173: comm fsstress: checksumming directory block 0
Mar 28 06:24:35 extra-ext4-4k kernel: EXT4-fs error (device loop5): __ext4_find_entry:1626: inode #5173: comm fsstress: checksumming directory block 0
Mar 28 06:30:04 extra-ext4-4k kernel: EXT4-fs warning (device loop5): ext4_empty_dir:3088: inode #5173: comm fsstress: directory missing '.'
Mar 28 06:32:30 extra-ext4-4k kernel: EXT4-fs warning (device loop5): ext4_empty_dir:3088: inode #5188: comm fsstress: directory missing '.'
Mar 28 06:32:39 extra-ext4-4k kernel: EXT4-fs warning (device loop5): ext4_empty_dir:3088: inode #5176: comm fsstress: directory missing '.'
Mar 28 06:38:54 extra-ext4-4k kernel: EXT4-fs warning (device loop5): ext4_empty_dir:3088: inode #5173: comm fsstress: directory missing '.'
Mar 28 06:41:37 extra-ext4-4k kernel: EXT4-fs warning (device loop5): ext4_empty_dir:3088: inode #5187: comm fsstress: directory missing '.'
Mar 28 06:42:05 extra-ext4-4k kernel: EXT4-fs error (device loop5): __ext4_find_entry:1626: inode #5173: comm fsstress: checksumming directory block 0
Mar 28 06:42:06 extra-ext4-4k kernel: EXT4-fs error (device loop5): __ext4_find_entry:1626: inode #5173: comm fsstress: checksumming directory block 0
Mar 28 06:42:22 extra-ext4-4k kernel: EXT4-fs error (device loop5): __ext4_find_entry:1626: inode #5173: comm fsstress: checksumming directory block 0
Mar 28 06:42:38 extra-ext4-4k kernel: EXT4-fs error (device loop5): __ext4_find_entry:1626: inode #5173: comm fsstress: checksumming directory block 0
Mar 28 06:42:42 extra-ext4-4k kernel: EXT4-fs error (device loop5): __ext4_find_entry:1626: inode #5173: comm fsstress: checksumming directory block 0
Mar 28 06:42:53 extra-ext4-4k kernel: EXT4-fs error (device loop5): __ext4_find_entry:1626: inode #5173: comm fsstress: checksumming directory block 0
Mar 28 06:42:54 extra-ext4-4k kernel: EXT4-fs error (device loop5): __ext4_find_entry:1626: inode #5173: comm fsstress: checksumming directory block 0
Mar 28 06:43:02 extra-ext4-4k kernel: EXT4-fs error (device loop5): __ext4_find_entry:1626: inode #5173: comm fsstress: checksumming directory block 0
Mar 28 06:43:12 extra-ext4-4k kernel: EXT4-fs error (device loop5): __ext4_find_entry:1626: inode #5173: comm fsstress: checksumming directory block 0
Mar 28 06:43:15 extra-ext4-4k kernel: EXT4-fs error (device loop5): __ext4_find_entry:1626: inode #5173: comm fsstress: checksumming directory block 0
Mar 28 06:53:28 extra-ext4-4k kernel: EXT4-fs warning (device loop5): ext4_empty_dir:3088: inode #5188: comm fsstress: directory missing '.'
Mar 28 06:54:36 extra-ext4-4k kernel: EXT4-fs warning (device loop5): ext4_empty_dir:3088: inode #5176: comm fsstress: directory missing '.'
Mar 28 06:55:07 extra-ext4-4k kernel: EXT4-fs error (device loop5): __ext4_find_entry:1626: inode #5173: comm fsstress: checksumming directory block 0
Mar 28 06:55:09 extra-ext4-4k kernel: EXT4-fs error (device loop5): __ext4_find_entry:1626: inode #5173: comm fsstress: checksumming directory block 0
Mar 28 06:55:12 extra-ext4-4k kernel: EXT4-fs error (device loop5): __ext4_find_entry:1626: inode #5173: comm fsstress: checksumming directory block 0
Mar 28 07:04:21 extra-ext4-4k kernel: EXT4-fs error (device loop5): ext4_get_first_dir_block:3538: inode #5173: comm fsstress: directory missing '.'
Mar 28 07:11:04 extra-ext4-4k kernel: EXT4-fs warning (device loop5): ext4_empty_dir:3088: inode #5173: comm fsstress: directory missing '.'
Mar 28 07:13:11 extra-ext4-4k kernel: EXT4-fs error (device loop5): ext4_get_first_dir_block:3538: inode #5174: comm fsstress: directory missing '.'
Mar 28 07:15:45 extra-ext4-4k kernel: EXT4-fs error (device loop5): __ext4_find_entry:1626: inode #5176: comm fsstress: checksumming directory block 0
Mar 28 07:15:49 extra-ext4-4k kernel: EXT4-fs error (device loop5): __ext4_find_entry:1626: inode #5176: comm fsstress: checksumming directory block 0
Mar 28 07:15:51 extra-ext4-4k kernel: EXT4-fs error (device loop5): __ext4_find_entry:1626: inode #5176: comm fsstress: checksumming directory block 0
Mar 28 07:15:52 extra-ext4-4k kernel: EXT4-fs error (device loop5): __ext4_find_entry:1626: inode #5176: comm fsstress: checksumming directory block 0
Mar 28 07:16:00 extra-ext4-4k kernel: EXT4-fs error (device loop5): __ext4_find_entry:1626: inode #5176: comm fsstress: checksumming directory block 0
Mar 28 07:16:41 extra-ext4-4k kernel: EXT4-fs error (device loop5): ext4_get_first_dir_block:3538: inode #5187: comm fsstress: directory missing '.'
Mar 28 07:24:00 extra-ext4-4k kernel: EXT4-fs error (device loop5): __ext4_find_entry:1626: inode #5176: comm fsstress: checksumming directory block 0
Mar 28 07:24:31 extra-ext4-4k kernel: EXT4-fs error (device loop5): __ext4_find_entry:1626: inode #5176: comm fsstress: checksumming directory block 0
Mar 28 07:25:40 extra-ext4-4k kernel: EXT4-fs error (device loop5): __ext4_find_entry:1626: inode #8703: comm fsstress: checksumming directory block 0
Mar 28 07:25:47 extra-ext4-4k kernel: EXT4-fs error (device loop5): __ext4_find_entry:1626: inode #8703: comm fsstress: checksumming directory block 0
Mar 28 07:25:50 extra-ext4-4k kernel: EXT4-fs error (device loop5): __ext4_find_entry:1626: inode #8703: comm fsstress: checksumming directory block 0
Mar 28 07:26:18 extra-ext4-4k kernel: EXT4-fs error (device loop5): __ext4_find_entry:1626: inode #8684: comm fsstress: checksumming directory block 0
Mar 28 07:41:04 extra-ext4-4k kernel: EXT4-fs error (device loop5): ext4_get_first_dir_block:3538: inode #5188: comm fsstress: directory missing '.'
Mar 28 07:41:11 extra-ext4-4k kernel: EXT4-fs error (device loop5): __ext4_find_entry:1626: inode #5174: comm fsstress: checksumming directory block 0
Mar 28 07:44:41 extra-ext4-4k kernel: EXT4-fs error (device loop5): ext4_get_first_dir_block:3538: inode #5187: comm fsstress: directory missing '.'
Mar 28 07:47:20 extra-ext4-4k kernel: EXT4-fs warning (device loop5): ext4_empty_dir:3088: inode #5187: comm fsstress: directory missing '.'
Mar 28 07:47:28 extra-ext4-4k kernel: EXT4-fs warning (device loop5): ext4_empty_dir:3088: inode #5187: comm fsstress: directory missing '.'
Mar 28 07:47:56 extra-ext4-4k kernel: EXT4-fs error (device loop5): __ext4_find_entry:1626: inode #5176: comm fsstress: checksumming directory block 0
Mar 28 07:49:05 extra-ext4-4k kernel: EXT4-fs warning (device loop5): ext4_empty_dir:3088: inode #5187: comm fsstress: directory missing '.'
Mar 28 07:53:26 extra-ext4-4k kernel: EXT4-fs warning (device loop5): ext4_empty_dir:3088: inode #5173: comm fsstress: directory missing '.'
Mar 28 08:16:43 extra-ext4-4k kernel: EXT4-fs error (device loop5): ext4_find_extent:938: inode #1104560: comm fsstress: pblk 4932229 bad header/extent: invalid magic - magic 8383, entries 33667, max 33667(0), depth 33667(0)
Mar 28 08:16:43 extra-ext4-4k kernel: EXT4-fs error (device loop5): ext4_find_extent:938: inode #1104560: comm fsstress: pblk 4932229 bad header/extent: invalid magic - magic 8383, entries 33667, max 33667(0), depth 33667(0)
Mar 28 08:16:43 extra-ext4-4k kernel: EXT4-fs error (device loop5): ext4_find_extent:938: inode #1104560: comm fsstress: pblk 4932229 bad header/extent: invalid magic - magic 8383, entries 33667, max 33667(0), depth 33667(0)
Mar 28 08:16:43 extra-ext4-4k kernel: EXT4-fs error (device loop5): ext4_find_extent:938: inode #1104560: comm fsstress: pblk 4932229 bad header/extent: invalid magic - magic 8383, entries 33667, max 33667(0), depth 33667(0)
Mar 28 08:16:43 extra-ext4-4k kernel: EXT4-fs error (device loop5): ext4_find_extent:938: inode #1104560: comm fsstress: pblk 4932229 bad header/extent: invalid magic - magic 8383, entries 33667, max 33667(0), depth 33667(0)
Mar 28 08:16:43 extra-ext4-4k kernel: EXT4-fs error (device loop5): ext4_find_extent:938: inode #1104560: comm fsstress: pblk 4932229 bad header/extent: invalid magic - magic 8383, entries 33667, max 33667(0), depth 33667(0)
Mar 28 08:16:43 extra-ext4-4k kernel: EXT4-fs error (device loop5): ext4_find_extent:938: inode #1104560: comm fsstress: pblk 4932229 bad header/extent: invalid magic - magic 8383, entries 33667, max 33667(0), depth 33667(0)
Mar 28 08:16:43 extra-ext4-4k kernel: EXT4-fs error (device loop5): ext4_find_extent:938: inode #1104560: comm fsstress: pblk 4932229 bad header/extent: invalid magic - magic 8383, entries 33667, max 33667(0), depth 33667(0)
Mar 28 08:16:43 extra-ext4-4k kernel: EXT4-fs error (device loop5): ext4_find_extent:938: inode #1104560: comm fsstress: pblk 4932229 bad header/extent: invalid magic - magic 8383, entries 33667, max 33667(0), depth 33667(0)
Mar 28 08:16:43 extra-ext4-4k kernel: EXT4-fs error (device loop5): ext4_find_extent:938: inode #1104560: comm fsstress: pblk 4932229 bad header/extent: invalid magic - magic 8383, entries 33667, max 33667(0), depth 33667(0)
Mar 28 08:19:26 extra-ext4-4k kernel: EXT4-fs error: 6 callbacks suppressed
Mar 28 08:19:26 extra-ext4-4k kernel: EXT4-fs error (device loop5): __ext4_find_entry:1626: inode #5173: comm fsstress: checksumming directory block 0
Mar 28 08:21:37 extra-ext4-4k kernel: EXT4-fs warning (device loop5): ext4_empty_dir:3088: inode #5173: comm fsstress: directory missing '.'
Mar 28 08:28:17 extra-ext4-4k kernel: EXT4-fs warning (device loop5): ext4_empty_dir:3088: inode #5173: comm fsstress: directory missing '.'
Mar 28 08:30:17 extra-ext4-4k kernel: EXT4-fs error (device loop5): ext4_find_extent:938: inode #1104560: comm fsstress: pblk 4932229 bad header/extent: invalid magic - magic 8383, entries 33667, max 33667(0), depth 33667(0)
Mar 28 08:31:02 extra-ext4-4k kernel: EXT4-fs warning (device loop5): ext4_empty_dir:3088: inode #5176: comm fsstress: directory missing '.'
Mar 28 08:32:21 extra-ext4-4k kernel: EXT4-fs error (device loop5): __ext4_find_entry:1626: inode #8699: comm fsstress: checksumming directory block 0
Mar 28 08:32:23 extra-ext4-4k kernel: EXT4-fs error (device loop5): __ext4_find_entry:1626: inode #8699: comm fsstress: checksumming directory block 0
Mar 28 08:32:24 extra-ext4-4k kernel: EXT4-fs error (device loop5): __ext4_find_entry:1626: inode #8699: comm fsstress: checksumming directory block 0
Mar 28 08:32:31 extra-ext4-4k kernel: EXT4-fs error (device loop5): __ext4_find_entry:1626: inode #8699: comm fsstress: checksumming directory block 0
Mar 28 08:32:36 extra-ext4-4k kernel: EXT4-fs error (device loop5): __ext4_find_entry:1626: inode #8699: comm fsstress: checksumming directory block 0
Mar 28 08:32:43 extra-ext4-4k kernel: EXT4-fs warning (device loop5): ext4_empty_dir:3088: inode #5176: comm fsstress: directory missing '.'
Mar 28 08:34:47 extra-ext4-4k kernel: EXT4-fs warning (device loop5): ext4_empty_dir:3088: inode #5174: comm fsstress: directory missing '.'
Mar 28 08:34:58 extra-ext4-4k kernel: EXT4-fs warning (device loop5): ext4_empty_dir:3088: inode #5173: comm fsstress: directory missing '.'
Mar 28 08:35:01 extra-ext4-4k kernel: EXT4-fs warning (device loop5): ext4_empty_dir:3088: inode #5187: comm fsstress: directory missing '.'
Mar 28 08:37:11 extra-ext4-4k kernel: EXT4-fs error (device loop5): __ext4_find_entry:1626: inode #8699: comm fsstress: checksumming directory block 0
Mar 28 08:37:12 extra-ext4-4k kernel: EXT4-fs error (device loop5): __ext4_find_entry:1626: inode #8699: comm fsstress: checksumming directory block 0
Mar 28 08:37:14 extra-ext4-4k kernel: EXT4-fs warning (device loop5): ext4_empty_dir:3088: inode #5188: comm fsstress: directory missing '.'
Mar 28 08:37:17 extra-ext4-4k kernel: EXT4-fs error (device loop5): __ext4_find_entry:1626: inode #8699: comm fsstress: checksumming directory block 0
Mar 28 08:39:32 extra-ext4-4k kernel: EXT4-fs warning (device loop5): ext4_empty_dir:3088: inode #5174: comm fsstress: directory missing '.'
Mar 28 08:40:52 extra-ext4-4k kernel: EXT4-fs error (device loop5): __ext4_find_entry:1626: inode #5176: comm fsstress: checksumming directory block 0
Mar 28 08:40:55 extra-ext4-4k kernel: EXT4-fs error (device loop5): __ext4_find_entry:1626: inode #5176: comm fsstress: checksumming directory block 0
Mar 28 08:41:03 extra-ext4-4k kernel: EXT4-fs warning (device loop5): ext4_empty_dir:3088: inode #5173: comm fsstress: directory missing '.'
Mar 28 08:54:04 extra-ext4-4k kernel: EXT4-fs error (device loop5): ext4_get_first_dir_block:3538: inode #5187: comm fsstress: directory missing '.'
Mar 28 08:58:02 extra-ext4-4k kernel: EXT4-fs warning (device loop5): ext4_empty_dir:3088: inode #5188: comm fsstress: directory missing '.'
Mar 28 09:00:10 extra-ext4-4k kernel: EXT4-fs error (device loop5): ext4_get_first_dir_block:3538: inode #5174: comm fsstress: directory missing '.'
Mar 28 09:01:30 extra-ext4-4k kernel: EXT4-fs error (device loop5): __ext4_find_entry:1626: inode #5174: comm fsstress: checksumming directory block 0
Mar 28 09:04:55 extra-ext4-4k kernel: EXT4-fs warning (device loop5): ext4_empty_dir:3088: inode #5176: comm fsstress: directory missing '.'
Mar 28 09:05:48 extra-ext4-4k kernel: EXT4-fs warning (device loop5): ext4_empty_dir:3088: inode #5188: comm fsstress: directory missing '.'
Mar 28 09:07:16 extra-ext4-4k kernel: EXT4-fs error (device loop5): __ext4_find_entry:1626: inode #5176: comm fsstress: checksumming directory block 0
Mar 28 09:07:21 extra-ext4-4k kernel: EXT4-fs error (device loop5): __ext4_find_entry:1626: inode #5176: comm fsstress: checksumming directory block 0
Mar 28 09:07:31 extra-ext4-4k kernel: EXT4-fs error (device loop5): __ext4_find_entry:1626: inode #5176: comm fsstress: checksumming directory block 0
Mar 28 09:07:33 extra-ext4-4k kernel: EXT4-fs error (device loop5): __ext4_find_entry:1626: inode #5173: comm fsstress: checksumming directory block 0
Mar 28 09:07:34 extra-ext4-4k kernel: EXT4-fs error (device loop5): __ext4_find_entry:1626: inode #5173: comm fsstress: checksumming directory block 0
Mar 28 09:07:42 extra-ext4-4k kernel: EXT4-fs error (device loop5): __ext4_find_entry:1626: inode #5173: comm fsstress: checksumming directory block 0
Mar 28 09:07:43 extra-ext4-4k kernel: EXT4-fs error (device loop5): __ext4_find_entry:1626: inode #5173: comm fsstress: checksumming directory block 0
Mar 28 09:07:49 extra-ext4-4k kernel: EXT4-fs error (device loop5): __ext4_find_entry:1626: inode #5173: comm fsstress: checksumming directory block 0
Mar 28 09:13:23 extra-ext4-4k kernel: EXT4-fs error (device loop5): __ext4_find_entry:1626: inode #5188: comm fsstress: checksumming directory block 0
Mar 28 09:13:44 extra-ext4-4k kernel: EXT4-fs error (device loop5): __ext4_find_entry:1626: inode #5188: comm fsstress: checksumming directory block 0
Mar 28 09:13:56 extra-ext4-4k kernel: EXT4-fs error (device loop5): __ext4_find_entry:1626: inode #5188: comm fsstress: checksumming directory block 0
Mar 28 09:14:06 extra-ext4-4k kernel: EXT4-fs error (device loop5): __ext4_find_entry:1626: inode #5188: comm fsstress: checksumming directory block 0
Mar 28 09:14:33 extra-ext4-4k kernel: EXT4-fs error (device loop5): __ext4_find_entry:1626: inode #5187: comm fsstress: checksumming directory block 0
Mar 28 09:14:35 extra-ext4-4k kernel: EXT4-fs error (device loop5): __ext4_find_entry:1626: inode #5187: comm fsstress: checksumming directory block 0
Mar 28 09:14:50 extra-ext4-4k kernel: EXT4-fs error (device loop5): __ext4_find_entry:1626: inode #5187: comm fsstress: checksumming directory block 0
Mar 28 09:14:51 extra-ext4-4k kernel: EXT4-fs error (device loop5): __ext4_find_entry:1626: inode #5187: comm fsstress: checksumming directory block 0
Mar 28 09:14:53 extra-ext4-4k kernel: EXT4-fs error (device loop5): __ext4_find_entry:1626: inode #5187: comm fsstress: checksumming directory block 0
Mar 28 09:14:54 extra-ext4-4k kernel: EXT4-fs error (device loop5): __ext4_find_entry:1626: inode #5187: comm fsstress: checksumming directory block 0
Mar 28 09:14:55 extra-ext4-4k kernel: EXT4-fs error (device loop5): __ext4_find_entry:1626: inode #5187: comm fsstress: checksumming directory block 0
Mar 28 09:14:56 extra-ext4-4k kernel: EXT4-fs error (device loop5): __ext4_find_entry:1626: inode #5187: comm fsstress: checksumming directory block 0
Mar 28 09:14:57 extra-ext4-4k kernel: EXT4-fs error (device loop5): __ext4_find_entry:1626: inode #5187: comm fsstress: checksumming directory block 0
Mar 28 09:15:00 extra-ext4-4k kernel: EXT4-fs error (device loop5): __ext4_find_entry:1626: inode #5187: comm fsstress: checksumming directory block 0
Mar 28 09:15:11 extra-ext4-4k kernel: EXT4-fs error (device loop5): __ext4_find_entry:1626: inode #5187: comm fsstress: checksumming directory block 0
Mar 28 09:16:55 extra-ext4-4k kernel: EXT4-fs error (device loop5): ext4_find_extent:938: inode #1104560: comm fsstress: pblk 4932229 bad header/extent: invalid magic - magic 8383, entries 33667, max 33667(0), depth 33667(0)
Mar 28 09:17:22 extra-ext4-4k kernel: NOHZ tick-stop error: local softirq work is pending, handler #10!!!
