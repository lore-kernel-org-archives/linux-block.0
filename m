Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC2D332638
	for <linux-block@vger.kernel.org>; Thu, 26 Feb 2026 17:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772127628; cv=none; b=gnOdVl6fqulvauBI6Rmj92l3Y+vPKNXnSZCQ5/9LtxpUCZJGPbNh9ms8JFk9Dz8gUywA7N8tt16p8ptGwduO4lauIjyzXjfd5Wq3PDd72rWgiZPvPNiFzNBtun1oo935SGFLBnwTjbnNW/xbZ8bGpj0WEwFtWHRkMh2KvV0UBTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772127628; c=relaxed/simple;
	bh=X1NFuVuwdKxO+z9ISO9VwMU5XrVyyYQFmICLdtv7jDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jEC4puyT5OnToJpDNaFmk119AhiGGf0TtZRisdO0q+W3AqYFz2hUgPCoPav5B1pay5BzTUYOysoOi9lcOHHMo3+13UgC4xIdfKJ6looXkjOuLmVYuyQNvB9xPGqDD/mDG/E9Kh/RzKY/XPG8/cKSzhfOatjLUahAONn3O4kipl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=SH3Ou5sE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=W83zxFoS; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=SW3YgwmF; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=eU36ZaSA; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SH3Ou5sE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="W83zxFoS";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SW3YgwmF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="eU36ZaSA"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D31131FAB8;
	Thu, 26 Feb 2026 17:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772127624; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AXs/RsDBHjGRJfjfFAGz+4wFtmpWD2NFJ2Ti9sGQ/SA=;
	b=SH3Ou5sEnKBtg8uljKq/DihYSVo6MIWJBM/2etNXi66fJu5UblMHy9+LdXkXqOqxx8Ss07
	8rRHibhRTBlw+Eb+2nzvNlX+pXBcWAOT+M87bnhe3ViZneWyxITxOUsbpXlosJjsZU3RBk
	+h6cUxywdnWcAf7I7cC2nHfM7xav/Vg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772127624;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AXs/RsDBHjGRJfjfFAGz+4wFtmpWD2NFJ2Ti9sGQ/SA=;
	b=W83zxFoSWepVykY6DB5EUEitnLtSKx/k4qYuyZiIvTWrfb3eWlY/NoH3+VRuyhkUQpy4r6
	cBaQrWvCpBZBmNCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772127623; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AXs/RsDBHjGRJfjfFAGz+4wFtmpWD2NFJ2Ti9sGQ/SA=;
	b=SW3YgwmFsj26pY70eJhnV9WoubeBgkze9akSMwLHq/+c6O5yaA542khQ6VpURd72hjiEnu
	MSEdKjVfllybsblp4OwDXVbusDJk5mBzuT1k+7CmOCcEU4Xm4wXUW26/MDG6gQ3eZ7vc/i
	UKXrXfqKxvLwD3BIhpE6l3YxN/YsEF4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772127623;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AXs/RsDBHjGRJfjfFAGz+4wFtmpWD2NFJ2Ti9sGQ/SA=;
	b=eU36ZaSAdRQDjiMSx5TauPvJH12I2/y291NEjNDiXOLvPR/XZzbZtJ0PGguBQwMh+ItVvh
	S0UGaCOs/WJGQBAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A19713EA62;
	Thu, 26 Feb 2026 17:40:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id y1FOBIaFoGmaZQAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Thu, 26 Feb 2026 17:40:22 +0000
Date: Thu, 26 Feb 2026 17:40:20 +0000
From: Pedro Falcato <pfalcato@suse.de>
To: syzbot <syzbot+709f5ab0e03871dec50a@syzkaller.appspotmail.com>
Cc: Liam.Howlett@oracle.com, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, lorenzo.stoakes@oracle.com, 
	shakeel.butt@linux.dev, surenb@google.com, syzkaller-bugs@googlegroups.com, 
	vbabka@suse.cz, netdev@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
	linux-block@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Jakub Kicinski <kuba@kernel.org>
Subject: Re: [syzbot] [mm?] possible deadlock in lock_mm_and_find_vma (4)
Message-ID: <ibhdm4y3cwmornxfyxckosbznmtx3hi37tdp4xvha7a7wyaktp@rkrjyxdqmgb2>
References: <69a05ea3.050a0220.305b49.0022.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69a05ea3.050a0220.305b49.0022.GAE@google.com>
X-Spam-Score: -1.30
X-Spam-Level: 
X-Spamd-Result: default: False [-1.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=6259cfbe2d15cac4];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_RCPT(0.00)[709f5ab0e03871dec50a];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Spam-Flag: NO

+Cc netdev, block, nbd people

On Thu, Feb 26, 2026 at 06:54:27AM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    32a92f8c8932 Convert more 'alloc_obj' cases to default GFP..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=13cd6f3a580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=6259cfbe2d15cac4
> dashboard link: https://syzkaller.appspot.com/bug?extid=709f5ab0e03871dec50a
> compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/64d473c704b2/disk-32a92f8c.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/570c8f79c450/vmlinux-32a92f8c.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/b3d4ccd686ce/bzImage-32a92f8c.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+709f5ab0e03871dec50a@syzkaller.appspotmail.com
> 
> ======================================================
> WARNING: possible circular locking dependency detected
> syzkaller #0 Tainted: G             L     
> ------------------------------------------------------
> syz.3.3387/17804 is trying to acquire lock:
> ffffffff8e9aaf80 (fs_reclaim){+.+.}-{0:0}, at: might_alloc include/linux/sched/mm.h:317 [inline]
> ffffffff8e9aaf80 (fs_reclaim){+.+.}-{0:0}, at: prepare_alloc_pages+0x166/0x5f0 mm/page_alloc.c:5018
> 
> but task is already holding lock:
> ffff88807ad4b440 (&mm->mmap_lock){++++}-{4:4}, at: mmap_read_trylock include/linux/mmap_lock.h:611 [inline]
> ffff88807ad4b440 (&mm->mmap_lock){++++}-{4:4}, at: get_mmap_lock_carefully mm/mmap_lock.c:441 [inline]
> ffff88807ad4b440 (&mm->mmap_lock){++++}-{4:4}, at: lock_mm_and_find_vma+0x35/0x6f0 mm/mmap_lock.c:501
> 
> which lock already depends on the new lock.
> 
> 
> the existing dependency chain (in reverse order) is:
> 
> -> #7 (&mm->mmap_lock){++++}-{4:4}:
>        __might_fault+0xde/0x140 mm/memory.c:7217
>        _inline_copy_from_user include/linux/uaccess.h:169 [inline]
>        _copy_from_user+0x29/0xd0 lib/usercopy.c:18
>        copy_from_user include/linux/uaccess.h:223 [inline]
>        copy_from_sockptr_offset include/linux/sockptr.h:48 [inline]
>        copy_from_sockptr include/linux/sockptr.h:61 [inline]
>        do_ip_setsockopt+0x2363/0x3200 net/ipv4/ip_sockglue.c:1294
>        ip_setsockopt+0x5a/0xf0 net/ipv4/ip_sockglue.c:1417
>        ipv6_setsockopt+0x155/0x170 net/ipv6/ipv6_sockglue.c:968
>        tcp_setsockopt+0xa7/0x100 net/ipv4/tcp.c:4217
>        smc_setsockopt+0x1b6/0xa10 net/smc/af_smc.c:3097
>        do_sock_setsockopt+0xf3/0x1d0 net/socket.c:2322
>        __sys_setsockopt+0x119/0x190 net/socket.c:2347
>        __do_sys_setsockopt net/socket.c:2353 [inline]
>        __se_sys_setsockopt net/socket.c:2350 [inline]
>        __x64_sys_setsockopt+0xbd/0x160 net/socket.c:2350
>        do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>        do_syscall_64+0x106/0xf80 arch/x86/entry/syscall_64.c:94
>        entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> -> #6 (k-sk_lock-AF_INET6){+.+.}-{0:0}:
>        lock_sock_nested+0x41/0xf0 net/core/sock.c:3780
>        lock_sock include/net/sock.h:1709 [inline]
>        inet_shutdown+0x67/0x410 net/ipv4/af_inet.c:913
>        nbd_mark_nsock_dead+0xae/0x5c0 drivers/block/nbd.c:318
>        sock_shutdown+0x16b/0x200 drivers/block/nbd.c:411
>        nbd_clear_sock drivers/block/nbd.c:1427 [inline]
>        nbd_config_put+0x1eb/0x750 drivers/block/nbd.c:1451
>        nbd_release+0xb7/0x190 drivers/block/nbd.c:1756
>        blkdev_put_whole+0xb0/0xf0 block/bdev.c:737
>        bdev_release+0x47f/0x6d0 block/bdev.c:1160
>        blkdev_release+0x15/0x20 block/fops.c:705
>        __fput+0x3ff/0xb40 fs/file_table.c:469
>        task_work_run+0x150/0x240 kernel/task_work.c:233
>        resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
>        __exit_to_user_mode_loop kernel/entry/common.c:67 [inline]
>        exit_to_user_mode_loop+0x100/0x4a0 kernel/entry/common.c:98
>        __exit_to_user_mode_prepare include/linux/irq-entry-common.h:226 [inline]
>        syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:256 [inline]
>        syscall_exit_to_user_mode include/linux/entry-common.h:325 [inline]
>        do_syscall_64+0x668/0xf80 arch/x86/entry/syscall_64.c:100
>        entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> -> #5 (&nsock->tx_lock){+.+.}-{4:4}:
>        __mutex_lock_common kernel/locking/mutex.c:614 [inline]
>        __mutex_lock+0x1a2/0x1b90 kernel/locking/mutex.c:776
>        nbd_handle_cmd drivers/block/nbd.c:1143 [inline]
>        nbd_queue_rq+0x428/0x1080 drivers/block/nbd.c:1207
>        blk_mq_dispatch_rq_list+0x422/0x1e70 block/blk-mq.c:2148
>        __blk_mq_do_dispatch_sched block/blk-mq-sched.c:168 [inline]
>        blk_mq_do_dispatch_sched block/blk-mq-sched.c:182 [inline]
>        __blk_mq_sched_dispatch_requests+0xcea/0x1620 block/blk-mq-sched.c:307
>        blk_mq_sched_dispatch_requests+0xd7/0x1c0 block/blk-mq-sched.c:329
>        blk_mq_run_hw_queue+0x23c/0x670 block/blk-mq.c:2386
>        blk_mq_dispatch_list+0x51d/0x1360 block/blk-mq.c:2949
>        blk_mq_flush_plug_list block/blk-mq.c:2997 [inline]
>        blk_mq_flush_plug_list+0x130/0x600 block/blk-mq.c:2969
>        __blk_flush_plug+0x2c4/0x4b0 block/blk-core.c:1230
>        blk_finish_plug block/blk-core.c:1257 [inline]
>        __submit_bio+0x584/0x6c0 block/blk-core.c:649
>        __submit_bio_noacct_mq block/blk-core.c:722 [inline]
>        submit_bio_noacct_nocheck+0x562/0xc10 block/blk-core.c:753
>        submit_bio_noacct+0xd17/0x2010 block/blk-core.c:884
>        blk_crypto_submit_bio include/linux/blk-crypto.h:203 [inline]
>        submit_bh_wbc+0x59c/0x770 fs/buffer.c:2821
>        submit_bh fs/buffer.c:2826 [inline]
>        block_read_full_folio+0x4c8/0x8e0 fs/buffer.c:2458
>        filemap_read_folio+0xfc/0x3b0 mm/filemap.c:2496
>        do_read_cache_folio+0x2d7/0x6b0 mm/filemap.c:4096
>        read_mapping_folio include/linux/pagemap.h:1028 [inline]
>        read_part_sector+0xd1/0x370 block/partitions/core.c:723
>        adfspart_check_ICS+0x93/0x910 block/partitions/acorn.c:360
>        check_partition block/partitions/core.c:142 [inline]
>        blk_add_partitions block/partitions/core.c:590 [inline]
>        bdev_disk_changed+0x7f8/0xc80 block/partitions/core.c:694
>        blkdev_get_whole+0x187/0x290 block/bdev.c:764
>        bdev_open+0x2c7/0xe40 block/bdev.c:973
>        blkdev_open+0x34e/0x4f0 block/fops.c:697
>        do_dentry_open+0x6d8/0x1660 fs/open.c:949
>        vfs_open+0x82/0x3f0 fs/open.c:1081
>        do_open fs/namei.c:4671 [inline]
>        path_openat+0x208c/0x31a0 fs/namei.c:4830
>        do_file_open+0x20e/0x430 fs/namei.c:4859
>        do_sys_openat2+0x10d/0x1e0 fs/open.c:1366
>        do_sys_open fs/open.c:1372 [inline]
>        __do_sys_openat fs/open.c:1388 [inline]
>        __se_sys_openat fs/open.c:1383 [inline]
>        __x64_sys_openat+0x12d/0x210 fs/open.c:1383
>        do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>        do_syscall_64+0x106/0xf80 arch/x86/entry/syscall_64.c:94
>        entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> -> #4 (&cmd->lock){+.+.}-{4:4}:
>        __mutex_lock_common kernel/locking/mutex.c:614 [inline]
>        __mutex_lock+0x1a2/0x1b90 kernel/locking/mutex.c:776
>        nbd_queue_rq+0xba/0x1080 drivers/block/nbd.c:1199
>        blk_mq_dispatch_rq_list+0x422/0x1e70 block/blk-mq.c:2148
>        __blk_mq_do_dispatch_sched block/blk-mq-sched.c:168 [inline]
>        blk_mq_do_dispatch_sched block/blk-mq-sched.c:182 [inline]
>        __blk_mq_sched_dispatch_requests+0xcea/0x1620 block/blk-mq-sched.c:307
>        blk_mq_sched_dispatch_requests+0xd7/0x1c0 block/blk-mq-sched.c:329
>        blk_mq_run_hw_queue+0x23c/0x670 block/blk-mq.c:2386
>        blk_mq_dispatch_list+0x51d/0x1360 block/blk-mq.c:2949
>        blk_mq_flush_plug_list block/blk-mq.c:2997 [inline]
>        blk_mq_flush_plug_list+0x130/0x600 block/blk-mq.c:2969
>        __blk_flush_plug+0x2c4/0x4b0 block/blk-core.c:1230
>        blk_finish_plug block/blk-core.c:1257 [inline]
>        __submit_bio+0x584/0x6c0 block/blk-core.c:649
>        __submit_bio_noacct_mq block/blk-core.c:722 [inline]
>        submit_bio_noacct_nocheck+0x562/0xc10 block/blk-core.c:753
>        submit_bio_noacct+0xd17/0x2010 block/blk-core.c:884
>        blk_crypto_submit_bio include/linux/blk-crypto.h:203 [inline]
>        submit_bh_wbc+0x59c/0x770 fs/buffer.c:2821
>        submit_bh fs/buffer.c:2826 [inline]
>        block_read_full_folio+0x4c8/0x8e0 fs/buffer.c:2458
>        filemap_read_folio+0xfc/0x3b0 mm/filemap.c:2496
>        do_read_cache_folio+0x2d7/0x6b0 mm/filemap.c:4096
>        read_mapping_folio include/linux/pagemap.h:1028 [inline]
>        read_part_sector+0xd1/0x370 block/partitions/core.c:723
>        adfspart_check_ICS+0x93/0x910 block/partitions/acorn.c:360
>        check_partition block/partitions/core.c:142 [inline]
>        blk_add_partitions block/partitions/core.c:590 [inline]
>        bdev_disk_changed+0x7f8/0xc80 block/partitions/core.c:694
>        blkdev_get_whole+0x187/0x290 block/bdev.c:764
>        bdev_open+0x2c7/0xe40 block/bdev.c:973
>        blkdev_open+0x34e/0x4f0 block/fops.c:697
>        do_dentry_open+0x6d8/0x1660 fs/open.c:949
>        vfs_open+0x82/0x3f0 fs/open.c:1081
>        do_open fs/namei.c:4671 [inline]
>        path_openat+0x208c/0x31a0 fs/namei.c:4830
>        do_file_open+0x20e/0x430 fs/namei.c:4859
>        do_sys_openat2+0x10d/0x1e0 fs/open.c:1366
>        do_sys_open fs/open.c:1372 [inline]
>        __do_sys_openat fs/open.c:1388 [inline]
>        __se_sys_openat fs/open.c:1383 [inline]
>        __x64_sys_openat+0x12d/0x210 fs/open.c:1383
>        do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>        do_syscall_64+0x106/0xf80 arch/x86/entry/syscall_64.c:94
>        entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> -> #3 (set->srcu){.+.+}-{0:0}:
>        srcu_lock_sync include/linux/srcu.h:199 [inline]
>        __synchronize_srcu+0xa1/0x2a0 kernel/rcu/srcutree.c:1505
>        blk_mq_wait_quiesce_done block/blk-mq.c:284 [inline]
>        blk_mq_wait_quiesce_done block/blk-mq.c:281 [inline]
>        blk_mq_quiesce_queue block/blk-mq.c:304 [inline]
>        blk_mq_quiesce_queue+0x149/0x1c0 block/blk-mq.c:299
>        elevator_switch+0x17b/0x7e0 block/elevator.c:576
>        elevator_change+0x352/0x530 block/elevator.c:681
>        elevator_set_default+0x29e/0x360 block/elevator.c:754
>        blk_register_queue+0x412/0x590 block/blk-sysfs.c:940
>        __add_disk+0x73f/0xe40 block/genhd.c:528
>        add_disk_fwnode+0x118/0x5c0 block/genhd.c:597
>        add_disk include/linux/blkdev.h:785 [inline]
>        nbd_dev_add+0x77a/0xb10 drivers/block/nbd.c:1984
>        nbd_init+0x291/0x2b0 drivers/block/nbd.c:2692
>        do_one_initcall+0x11d/0x760 init/main.c:1382
>        do_initcall_level init/main.c:1444 [inline]
>        do_initcalls init/main.c:1460 [inline]
>        do_basic_setup init/main.c:1479 [inline]
>        kernel_init_freeable+0x6e5/0x7a0 init/main.c:1692
>        kernel_init+0x1f/0x1e0 init/main.c:1582
>        ret_from_fork+0x754/0xd80 arch/x86/kernel/process.c:158
>        ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
> 
> -> #2 (&q->elevator_lock){+.+.}-{4:4}:
>        __mutex_lock_common kernel/locking/mutex.c:614 [inline]
>        __mutex_lock+0x1a2/0x1b90 kernel/locking/mutex.c:776
>        queue_requests_store+0x38b/0x660 block/blk-sysfs.c:117
>        queue_attr_store+0x25f/0x2f0 block/blk-sysfs.c:866
>        sysfs_kf_write+0xf2/0x150 fs/sysfs/file.c:142
>        kernfs_fop_write_iter+0x3e0/0x5f0 fs/kernfs/file.c:352
>        new_sync_write fs/read_write.c:595 [inline]
>        vfs_write+0x6ac/0x1070 fs/read_write.c:688
>        ksys_pwrite64 fs/read_write.c:795 [inline]
>        __do_sys_pwrite64 fs/read_write.c:803 [inline]
>        __se_sys_pwrite64 fs/read_write.c:800 [inline]
>        __x64_sys_pwrite64+0x1eb/0x250 fs/read_write.c:800
>        do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>        do_syscall_64+0x106/0xf80 arch/x86/entry/syscall_64.c:94
>        entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> -> #1 (&q->q_usage_counter(io)#26){++++}-{0:0}:
>        blk_alloc_queue+0x610/0x790 block/blk-core.c:461
>        blk_mq_alloc_queue+0x174/0x290 block/blk-mq.c:4429
>        __blk_mq_alloc_disk+0x29/0x120 block/blk-mq.c:4476
>        loop_add+0x498/0xb60 drivers/block/loop.c:2049
>        loop_init+0x1d3/0x200 drivers/block/loop.c:2288
>        do_one_initcall+0x11d/0x760 init/main.c:1382
>        do_initcall_level init/main.c:1444 [inline]
>        do_initcalls init/main.c:1460 [inline]
>        do_basic_setup init/main.c:1479 [inline]
>        kernel_init_freeable+0x6e5/0x7a0 init/main.c:1692
>        kernel_init+0x1f/0x1e0 init/main.c:1582
>        ret_from_fork+0x754/0xd80 arch/x86/kernel/process.c:158
>        ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
> 
> -> #0 (fs_reclaim){+.+.}-{0:0}:
>        check_prev_add kernel/locking/lockdep.c:3165 [inline]
>        check_prevs_add kernel/locking/lockdep.c:3284 [inline]
>        validate_chain kernel/locking/lockdep.c:3908 [inline]
>        __lock_acquire+0x14b8/0x2630 kernel/locking/lockdep.c:5237
>        lock_acquire kernel/locking/lockdep.c:5868 [inline]
>        lock_acquire+0x1cf/0x380 kernel/locking/lockdep.c:5825
>        __fs_reclaim_acquire mm/page_alloc.c:4348 [inline]
>        fs_reclaim_acquire+0xc4/0x100 mm/page_alloc.c:4362
>        might_alloc include/linux/sched/mm.h:317 [inline]
>        prepare_alloc_pages+0x166/0x5f0 mm/page_alloc.c:5018
>        __alloc_frozen_pages_noprof+0x19a/0x2ba0 mm/page_alloc.c:5239
>        alloc_pages_mpol+0x1fb/0x550 mm/mempolicy.c:2484
>        alloc_frozen_pages_noprof mm/mempolicy.c:2555 [inline]
>        alloc_pages_noprof+0x131/0x390 mm/mempolicy.c:2575
>        pagetable_alloc_noprof include/linux/mm.h:3404 [inline]
>        pmd_alloc_one_noprof include/asm-generic/pgalloc.h:143 [inline]
>        __pmd_alloc+0x3b/0x9c0 mm/memory.c:6709
>        pmd_alloc include/linux/mm.h:3320 [inline]
>        __handle_mm_fault+0xa99/0x2b60 mm/memory.c:6406
>        handle_mm_fault+0x36d/0xa20 mm/memory.c:6623
>        do_user_addr_fault+0x74c/0x12f0 arch/x86/mm/fault.c:1385
>        handle_page_fault arch/x86/mm/fault.c:1474 [inline]
>        exc_page_fault+0x6f/0xd0 arch/x86/mm/fault.c:1527
>        asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:618
>        rep_movs_alternative+0x30/0x90 arch/x86/lib/copy_user_64.S:53
>        copy_user_generic arch/x86/include/asm/uaccess_64.h:126 [inline]
>        raw_copy_from_user arch/x86/include/asm/uaccess_64.h:141 [inline]
>        _inline_copy_from_user include/linux/uaccess.h:185 [inline]
>        _copy_from_user+0x98/0xd0 lib/usercopy.c:18
>        copy_from_user include/linux/uaccess.h:223 [inline]
>        get_user_ifreq+0x77/0x1c0 net/socket.c:3350
>        br_ioctl_stub+0x23d/0x4d0 net/bridge/br_ioctl.c:409
>        br_ioctl_call+0x53/0xa0 net/socket.c:1227
>        sock_ioctl+0x616/0x6b0 net/socket.c:1329
>        vfs_ioctl fs/ioctl.c:51 [inline]
>        __do_sys_ioctl fs/ioctl.c:597 [inline]
>        __se_sys_ioctl fs/ioctl.c:583 [inline]
>        __x64_sys_ioctl+0x18e/0x210 fs/ioctl.c:583
>        do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>        do_syscall_64+0x106/0xf80 arch/x86/entry/syscall_64.c:94
>        entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> other info that might help us debug this:
> 
> Chain exists of:
>   fs_reclaim --> k-sk_lock-AF_INET6 --> &mm->mmap_lock
> 
>  Possible unsafe locking scenario:
> 
>        CPU0                    CPU1
>        ----                    ----
>   rlock(&mm->mmap_lock);
>                                lock(k-sk_lock-AF_INET6);
>                                lock(&mm->mmap_lock);
>   lock(fs_reclaim);
> 
>  *** DEADLOCK ***
> 
> 2 locks held by syz.3.3387/17804:
>  #0: ffffffff905e2228 (br_ioctl_mutex){+.+.}-{4:4}, at: br_ioctl_call+0x34/0xa0 net/socket.c:1225
>  #1: ffff88807ad4b440 (&mm->mmap_lock){++++}-{4:4}, at: mmap_read_trylock include/linux/mmap_lock.h:611 [inline]
>  #1: ffff88807ad4b440 (&mm->mmap_lock){++++}-{4:4}, at: get_mmap_lock_carefully mm/mmap_lock.c:441 [inline]
>  #1: ffff88807ad4b440 (&mm->mmap_lock){++++}-{4:4}, at: lock_mm_and_find_vma+0x35/0x6f0 mm/mmap_lock.c:501
>

It looks to me like the issue is:
 setsockopt(nbd_sock) -> takes sk_lock -> copy_from_user -> page fault ->
   mmap_lock -> allocation needs reclaim -> fs_reclaim -> fs does IO -> nbd
   grabs sk_lock -> deadlock

Looks longstanding. No idea why it's finding it only now.

I would suggest something like this, if the diagnosis is correct
(plus adapting all callers):

diff --git a/net/core/sock.c b/net/core/sock.c
index 5976100a9d55..8a100c404c8e 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1140,8 +1140,10 @@ sock_devmem_dontneed(struct sock *sk, sockptr_t optval, unsigned int optlen)
 }
 #endif
 
-void sockopt_lock_sock(struct sock *sk)
+__must_check unsigned int sockopt_lock_sock(struct sock *sk)
 {
+       unsigned int flags = 0;
+
        /* When current->bpf_ctx is set, the setsockopt is called from
         * a bpf prog.  bpf has ensured the sk lock has been
         * acquired before calling setsockopt().
@@ -1149,15 +1151,27 @@ void sockopt_lock_sock(struct sock *sk)
        if (has_current_bpf_ctx())
                return;
 
+       if (!(sk->sk_allocation & __GFP_IO)) {
+               /* If the socket cannot tolerate IO for its own allocations,
+                * it's almost certain it will not be able to tolerate IO under
+                * lock_sock(). However, sockopt code likes to possibly trigger
+                * reclaim (due to page faults) under lock_sock(), and that can
+                * uncontrollably do IO.
+                */
+               flags = memalloc_noio_save();
+       }
+
        lock_sock(sk);
+       return flags;
 }
 EXPORT_SYMBOL(sockopt_lock_sock);
 
-void sockopt_release_sock(struct sock *sk)
+void sockopt_release_sock(struct sock *sk, unsigned int memalloc_flags)
 {
        if (has_current_bpf_ctx())
                return;
 
+       memalloc_noio_restore(memalloc_flags);
        release_sock(sk);
 }
 EXPORT_SYMBOL(sockopt_release_sock);



I would send it, but I would like to get some sort of repro first, at least
on my end.

-- 
Pedro
