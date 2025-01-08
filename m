Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5821FCCF6;
	Wed,  8 Jan 2025 14:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736347381; cv=none; b=bUX2w7bMn00BTwpMBgM+pNBsu4ITs0gwG4s8Q+/Ysf2BpJPCqbxZKMfoG17tEerJZQFYN0nWh0/5dp38jM8/kJkaxuS5MExte05d9G4+kj79ZyeIWoQYdpCicO308DOWm9WJ8UQvBNtcVcOTNE93PVGNtkQqj26wRcMLWy8A0jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736347381; c=relaxed/simple;
	bh=xddAnYy+MgV/Qs76atlTi08HILgVY9HKc0Qy/Bun9eA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MNpXZwHq/7VczJgcjK6sSmCzdWZv7JW2AfUvTSDJOWn8hfgJhbKchE90rmYTTjLLt1NIaZBg6IbbQU5etW9Hsbv9UTEy1VYx5e080cUTRnkp80PQL07rC1vzKVYXQftW7HbHZ76o9xnTCIwrU4YVWEPryUq1PDrn9DTXgNEkDvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FnAAsmVc; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+KLFfvsR; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FnAAsmVc; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+KLFfvsR; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FnAAsmVc";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+KLFfvsR";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FnAAsmVc";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+KLFfvsR"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 100E61F452;
	Wed,  8 Jan 2025 14:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736347377; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IR5B7zsm0Q/MBwvaMv+9R/0GdcwPmWzbxoC/Ln39gfE=;
	b=FnAAsmVcfbReMh6KhQ8jqPxHN0VjkerGFzjYCDNBvR/VNPqWc6IJPNFJhghUt+uKzDQKzr
	AQP7LibS9sKq0f0xlen/jFtHop4Tj7jf9ZrYJSB1DgLCw0MPmnb3ezmDKJRIU+7+xEDhHF
	Ac/HnnidujVLwVh9PdWrFYiQPPXQbko=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736347377;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IR5B7zsm0Q/MBwvaMv+9R/0GdcwPmWzbxoC/Ln39gfE=;
	b=+KLFfvsRNkLVwt/k0IUSxK6AiqNoe6b3H3btBcZnGz4EDH+hZwtZPlv8e539Z/WoZX9rEA
	DtsgBmE1JDjQeABA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736347377; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IR5B7zsm0Q/MBwvaMv+9R/0GdcwPmWzbxoC/Ln39gfE=;
	b=FnAAsmVcfbReMh6KhQ8jqPxHN0VjkerGFzjYCDNBvR/VNPqWc6IJPNFJhghUt+uKzDQKzr
	AQP7LibS9sKq0f0xlen/jFtHop4Tj7jf9ZrYJSB1DgLCw0MPmnb3ezmDKJRIU+7+xEDhHF
	Ac/HnnidujVLwVh9PdWrFYiQPPXQbko=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736347377;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IR5B7zsm0Q/MBwvaMv+9R/0GdcwPmWzbxoC/Ln39gfE=;
	b=+KLFfvsRNkLVwt/k0IUSxK6AiqNoe6b3H3btBcZnGz4EDH+hZwtZPlv8e539Z/WoZX9rEA
	DtsgBmE1JDjQeABA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EB0621351A;
	Wed,  8 Jan 2025 14:42:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6YcdOvCOfmcFTwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 08 Jan 2025 14:42:56 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 91163A0889; Wed,  8 Jan 2025 15:42:51 +0100 (CET)
Date: Wed, 8 Jan 2025 15:42:51 +0100
From: Jan Kara <jack@suse.cz>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: jack@suse.cz, yukuai3@huawei.com, axboe@kernel.dk, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, yi.zhang@huawei.com, 
	yangerkun@huawei.com
Subject: Re: [PATCH] block, bfq: fix waker_bfqq UAF after bfq_split_bfqq()
Message-ID: <odhd37amhss2kfhniix2jzy4crg4fb2d7u6qdwplevyiegb6rm@f4fqrg4vebls>
References: <20250108084148.1549973-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250108084148.1549973-1-yukuai1@huaweicloud.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Wed 08-01-25 16:41:48, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Our syzkaller report a following UAF for v6.6:
> 
> BUG: KASAN: slab-use-after-free in bfq_init_rq+0x175d/0x17a0 block/bfq-iosched.c:6958
> Read of size 8 at addr ffff8881b57147d8 by task fsstress/232726
> 
> CPU: 2 PID: 232726 Comm: fsstress Not tainted 6.6.0-g3629d1885222 #39
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0x91/0xf0 lib/dump_stack.c:106
>  print_address_description.constprop.0+0x66/0x300 mm/kasan/report.c:364
>  print_report+0x3e/0x70 mm/kasan/report.c:475
>  kasan_report+0xb8/0xf0 mm/kasan/report.c:588
>  hlist_add_head include/linux/list.h:1023 [inline]
>  bfq_init_rq+0x175d/0x17a0 block/bfq-iosched.c:6958
>  bfq_insert_request.isra.0+0xe8/0xa20 block/bfq-iosched.c:6271
>  bfq_insert_requests+0x27f/0x390 block/bfq-iosched.c:6323
>  blk_mq_insert_request+0x290/0x8f0 block/blk-mq.c:2660
>  blk_mq_submit_bio+0x1021/0x15e0 block/blk-mq.c:3143
>  __submit_bio+0xa0/0x6b0 block/blk-core.c:639
>  __submit_bio_noacct_mq block/blk-core.c:718 [inline]
>  submit_bio_noacct_nocheck+0x5b7/0x810 block/blk-core.c:747
>  submit_bio_noacct+0xca0/0x1990 block/blk-core.c:847
>  __ext4_read_bh fs/ext4/super.c:205 [inline]
>  ext4_read_bh+0x15e/0x2e0 fs/ext4/super.c:230
>  __read_extent_tree_block+0x304/0x6f0 fs/ext4/extents.c:567
>  ext4_find_extent+0x479/0xd20 fs/ext4/extents.c:947
>  ext4_ext_map_blocks+0x1a3/0x2680 fs/ext4/extents.c:4182
>  ext4_map_blocks+0x929/0x15a0 fs/ext4/inode.c:660
>  ext4_iomap_begin_report+0x298/0x480 fs/ext4/inode.c:3569
>  iomap_iter+0x3dd/0x1010 fs/iomap/iter.c:91
>  iomap_fiemap+0x1f4/0x360 fs/iomap/fiemap.c:80
>  ext4_fiemap+0x181/0x210 fs/ext4/extents.c:5051
>  ioctl_fiemap.isra.0+0x1b4/0x290 fs/ioctl.c:220
>  do_vfs_ioctl+0x31c/0x11a0 fs/ioctl.c:811
>  __do_sys_ioctl fs/ioctl.c:869 [inline]
>  __se_sys_ioctl+0xae/0x190 fs/ioctl.c:857
>  do_syscall_x64 arch/x86/entry/common.c:51 [inline]
>  do_syscall_64+0x70/0x120 arch/x86/entry/common.c:81
>  entry_SYSCALL_64_after_hwframe+0x78/0xe2
> 
> Allocated by task 232719:
>  kasan_save_stack+0x22/0x50 mm/kasan/common.c:45
>  kasan_set_track+0x25/0x30 mm/kasan/common.c:52
>  __kasan_slab_alloc+0x87/0x90 mm/kasan/common.c:328
>  kasan_slab_alloc include/linux/kasan.h:188 [inline]
>  slab_post_alloc_hook mm/slab.h:768 [inline]
>  slab_alloc_node mm/slub.c:3492 [inline]
>  kmem_cache_alloc_node+0x1b8/0x6f0 mm/slub.c:3537
>  bfq_get_queue+0x215/0x1f00 block/bfq-iosched.c:5869
>  bfq_get_bfqq_handle_split+0x167/0x5f0 block/bfq-iosched.c:6776
>  bfq_init_rq+0x13a4/0x17a0 block/bfq-iosched.c:6938
>  bfq_insert_request.isra.0+0xe8/0xa20 block/bfq-iosched.c:6271
>  bfq_insert_requests+0x27f/0x390 block/bfq-iosched.c:6323
>  blk_mq_insert_request+0x290/0x8f0 block/blk-mq.c:2660
>  blk_mq_submit_bio+0x1021/0x15e0 block/blk-mq.c:3143
>  __submit_bio+0xa0/0x6b0 block/blk-core.c:639
>  __submit_bio_noacct_mq block/blk-core.c:718 [inline]
>  submit_bio_noacct_nocheck+0x5b7/0x810 block/blk-core.c:747
>  submit_bio_noacct+0xca0/0x1990 block/blk-core.c:847
>  __ext4_read_bh fs/ext4/super.c:205 [inline]
>  ext4_read_bh_nowait+0x15a/0x240 fs/ext4/super.c:217
>  ext4_read_bh_lock+0xac/0xd0 fs/ext4/super.c:242
>  ext4_bread_batch+0x268/0x500 fs/ext4/inode.c:958
>  __ext4_find_entry+0x448/0x10f0 fs/ext4/namei.c:1671
>  ext4_lookup_entry fs/ext4/namei.c:1774 [inline]
>  ext4_lookup.part.0+0x359/0x6f0 fs/ext4/namei.c:1842
>  ext4_lookup+0x72/0x90 fs/ext4/namei.c:1839
>  __lookup_slow+0x257/0x480 fs/namei.c:1696
>  lookup_slow fs/namei.c:1713 [inline]
>  walk_component+0x454/0x5c0 fs/namei.c:2004
>  link_path_walk.part.0+0x773/0xda0 fs/namei.c:2331
>  link_path_walk fs/namei.c:3826 [inline]
>  path_openat+0x1b9/0x520 fs/namei.c:3826
>  do_filp_open+0x1b7/0x400 fs/namei.c:3857
>  do_sys_openat2+0x5dc/0x6e0 fs/open.c:1428
>  do_sys_open fs/open.c:1443 [inline]
>  __do_sys_openat fs/open.c:1459 [inline]
>  __se_sys_openat fs/open.c:1454 [inline]
>  __x64_sys_openat+0x148/0x200 fs/open.c:1454
>  do_syscall_x64 arch/x86/entry/common.c:51 [inline]
>  do_syscall_64+0x70/0x120 arch/x86/entry/common.c:81
>  entry_SYSCALL_64_after_hwframe+0x78/0xe2
> 
> Freed by task 232726:
>  kasan_save_stack+0x22/0x50 mm/kasan/common.c:45
>  kasan_set_track+0x25/0x30 mm/kasan/common.c:52
>  kasan_save_free_info+0x2b/0x50 mm/kasan/generic.c:522
>  ____kasan_slab_free mm/kasan/common.c:236 [inline]
>  __kasan_slab_free+0x12a/0x1b0 mm/kasan/common.c:244
>  kasan_slab_free include/linux/kasan.h:164 [inline]
>  slab_free_hook mm/slub.c:1827 [inline]
>  slab_free_freelist_hook mm/slub.c:1853 [inline]
>  slab_free mm/slub.c:3820 [inline]
>  kmem_cache_free+0x110/0x760 mm/slub.c:3842
>  bfq_put_queue+0x6a7/0xfb0 block/bfq-iosched.c:5428
>  bfq_forget_entity block/bfq-wf2q.c:634 [inline]
>  bfq_put_idle_entity+0x142/0x240 block/bfq-wf2q.c:645
>  bfq_forget_idle+0x189/0x1e0 block/bfq-wf2q.c:671
>  bfq_update_vtime block/bfq-wf2q.c:1280 [inline]
>  __bfq_lookup_next_entity block/bfq-wf2q.c:1374 [inline]
>  bfq_lookup_next_entity+0x350/0x480 block/bfq-wf2q.c:1433
>  bfq_update_next_in_service+0x1c0/0x4f0 block/bfq-wf2q.c:128
>  bfq_deactivate_entity+0x10a/0x240 block/bfq-wf2q.c:1188
>  bfq_deactivate_bfqq block/bfq-wf2q.c:1592 [inline]
>  bfq_del_bfqq_busy+0x2e8/0xad0 block/bfq-wf2q.c:1659
>  bfq_release_process_ref+0x1cc/0x220 block/bfq-iosched.c:3139
>  bfq_split_bfqq+0x481/0xdf0 block/bfq-iosched.c:6754
>  bfq_init_rq+0xf29/0x17a0 block/bfq-iosched.c:6934
>  bfq_insert_request.isra.0+0xe8/0xa20 block/bfq-iosched.c:6271
>  bfq_insert_requests+0x27f/0x390 block/bfq-iosched.c:6323
>  blk_mq_insert_request+0x290/0x8f0 block/blk-mq.c:2660
>  blk_mq_submit_bio+0x1021/0x15e0 block/blk-mq.c:3143
>  __submit_bio+0xa0/0x6b0 block/blk-core.c:639
>  __submit_bio_noacct_mq block/blk-core.c:718 [inline]
>  submit_bio_noacct_nocheck+0x5b7/0x810 block/blk-core.c:747
>  submit_bio_noacct+0xca0/0x1990 block/blk-core.c:847
>  __ext4_read_bh fs/ext4/super.c:205 [inline]
>  ext4_read_bh+0x15e/0x2e0 fs/ext4/super.c:230
>  __read_extent_tree_block+0x304/0x6f0 fs/ext4/extents.c:567
>  ext4_find_extent+0x479/0xd20 fs/ext4/extents.c:947
>  ext4_ext_map_blocks+0x1a3/0x2680 fs/ext4/extents.c:4182
>  ext4_map_blocks+0x929/0x15a0 fs/ext4/inode.c:660
>  ext4_iomap_begin_report+0x298/0x480 fs/ext4/inode.c:3569
>  iomap_iter+0x3dd/0x1010 fs/iomap/iter.c:91
>  iomap_fiemap+0x1f4/0x360 fs/iomap/fiemap.c:80
>  ext4_fiemap+0x181/0x210 fs/ext4/extents.c:5051
>  ioctl_fiemap.isra.0+0x1b4/0x290 fs/ioctl.c:220
>  do_vfs_ioctl+0x31c/0x11a0 fs/ioctl.c:811
>  __do_sys_ioctl fs/ioctl.c:869 [inline]
>  __se_sys_ioctl+0xae/0x190 fs/ioctl.c:857
>  do_syscall_x64 arch/x86/entry/common.c:51 [inline]
>  do_syscall_64+0x70/0x120 arch/x86/entry/common.c:81
>  entry_SYSCALL_64_after_hwframe+0x78/0xe2
> 
> commit 1ba0403ac644 ("block, bfq: fix uaf for accessing waker_bfqq after
> splitting") fix the problem that if waker_bfqq is in the merge chain,
> and current is the only procress, waker_bfqq can be freed from
> bfq_split_bfqq(). However, the case that waker_bfqq is not in the merge
> chain is missed, and if the procress reference of waker_bfqq is 0,
> waker_bfqq can be freed as well.
> 
> Fix the problem by checking procress reference if waker_bfqq is not in
> the merge_chain.
> 
> Fixes: 1ba0403ac644 ("block, bfq: fix uaf for accessing waker_bfqq after splitting")
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  block/bfq-iosched.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index 068c63e95738..c69e9faad15a 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -6844,16 +6844,24 @@ static struct bfq_queue *bfq_waker_bfqq(struct bfq_queue *bfqq)
>  		if (new_bfqq == waker_bfqq) {
>  			/*
>  			 * If waker_bfqq is in the merge chain, and current
> -			 * is the only procress.
> +			 * is the only procress, waker_bfqq can be freed.
					^^^ can you please fix the typo
while modifying the comment? It should be "process".


>  			 */
>  			if (bfqq_process_refs(waker_bfqq) == 1)
>  				return NULL;
> -			break;
> +
> +			return waker_bfqq;

So how do you know bfqq_process_refs(waker_bfqq) is not 0 in this case?

>  		}
>  
>  		new_bfqq = new_bfqq->new_bfqq;
>  	}
>  
> +	/*
> +	 * If waker_bfqq is not in the merge chain, and it's procress reference
							     ^^^ process
> +	 * is 0, waker_bfqq can be freed.
> +	 */
> +	if (bfqq_process_refs(waker_bfqq) == 0)
> +		return NULL;
> +
>  	return waker_bfqq;
>  }

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
