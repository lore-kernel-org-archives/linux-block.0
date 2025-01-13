Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC36E23A0F0;
	Mon, 13 Jan 2025 14:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736779169; cv=none; b=n+SPoAEBHg5qSm2O/PeGWG8SXX4XjjRrBFAY0jLqdSsCe0X3WHde1CFdspBB2PODQvVQmHruClJ0Ir+Xu6c49bd9WLCUWtbH3paUXVFnIL3eMGM7MOuhcwjw+tH6onNuBY8lTL5bMLwqZ3Peeh/uWJF1iaK2kItKSxgmP8f9wrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736779169; c=relaxed/simple;
	bh=+d2MHboUplO1Z1qSBqKTWVfuHnuaesEn4viWX9cuS/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e0AE+abypMXhUVPMcYaVWtuX0Xq6L/TkOsihMURsA+lt6EjmrCDNlH09tiRa8kB3flQfQwyMe400TLgGMhLiHR3FAqpPiI3tFHcNM1vXUDYhm+DSwR0i4FtCqTmacbWG8J43AX0ky34YkxhI7uyVT04/ne4unsz9PYpR6r6svuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SJhqBDjd; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SJhqBDjd"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5d414b8af7bso7856268a12.0;
        Mon, 13 Jan 2025 06:39:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736779166; x=1737383966; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BZNVvylS4CuWFvnHE0DbQMuVVt9DVMrZo5noOZv+D18=;
        b=SJhqBDjdm6Xx1AZqqC/EKfJgq8qL8sG8B966WsAF8V892glro1ndaSxEkAoa+VWngX
         P99IFgmc5xMA2sKrjCIqB2kNAPuRzDXhmajmZviuqvy3z/0uCwbGQDndKil8qUAzdRjX
         H8pCjWNKS/6tQLnRFbVDvmpLgEwiZDlzKSu2LhHgpQPY3hSOt4hL5JjxdVGGPKWP+pYW
         1yO0P8DmZRBvYcPuV9HQj4tUOZu/TRZL9Vpszz86ikBQ+IMu5H80u/7MNRkaUeI4l94i
         aZzx3fTC/pd0jXdr61HjC9yn4T+AQB18xZFr0L4/wccEZ1knMYdXO3UJ86AL3kWZN/5V
         1HJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736779166; x=1737383966;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BZNVvylS4CuWFvnHE0DbQMuVVt9DVMrZo5noOZv+D18=;
        b=wAFAyTXs6GbrTb8tENAwn4WRR7O5GBL4rLf3Ks3zW657MhG27ogLcHqgRq1QCfU0Of
         H90nPxEtG4qpYB+DaBmKyZvUGpdTkLS4TX2QlobvZNddk7gXIyviVrQ7kPpXW6HyIo1Q
         CgjY/idpQLoor9iI7hLJ9M5DPfvHEuXUpUF8D3EUiow7lxFdtAluC1qUQdJQbeV2+tdW
         rfpFRtjL7ldLpeKPFxCrY46ViAgvOt8Ua4sLhbLUuRAvL27gX8nCHQOh2x6UDRNS7LAF
         1XAdDNbP5oIPowjA7QDIIMQVPb7LsBe7ZuQa6PoJJYD+jjd0cQrpmKK/ohjeFqOR2gz5
         3Wlg==
X-Forwarded-Encrypted: i=1; AJvYcCVTY9CiVLq8FS4e2e0/tYSpcGISl/JvWn13fzSUFm67TzuhoWdW9aDBNunzCJwqmAW5zufkNfyRXtUM6Dza@vger.kernel.org, AJvYcCXkam7f26VmGnC77AV8iZbBFYMjrfrs6scYHQ4IO7f+XGmLGgDEqgCNsLt8IzvXq7tcu0qNgfYTy3Co3A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+msF/jS9/ayCMY6+2YGg5uQ/bAvxD8vf50aJsWI/ZmVJlO6Ce
	y894xTaR75JUlia+f0wRFtVhGYu1zFWCk7QFw/+Ts86Rwy8KN+8f
X-Gm-Gg: ASbGncv2PUC8FOVAJR3ft1TU/THzFpDndA/AQSXcQdbALuJUTIgCGlt5XB+U+qZg+OW
	BvCMuDOPGyu6AwJy9hm9WcX6Y1GCxLvWp1PvitDxKHt27urrdaTRFSafbB9OAD0RiTLV0aThSgD
	9svVc1B+Pjg840rj+D+9+Pizl7VwYrQ8lV3sr87M1jdAkI//0Y88l3w/anMVXzvs0tBcKRGXuZD
	EdMmmyilxVwYQ7CRrUKDmrSvioR5HYwtw4OAwLVFBr8lCzp4ZNuwLwvXCTRFWdKwA==
X-Google-Smtp-Source: AGHT+IFdgTci+MrJ/D5yDQlBL0OHyHPo1HxVXIVZ/N8KNwM6G97Ys7Egt46Fi6tlgUDlof7Hu9/oBw==
X-Received: by 2002:a17:907:3e8c:b0:aae:83c7:6ce3 with SMTP id a640c23a62f3a-ab2abca7867mr2257065766b.43.1736779165625;
        Mon, 13 Jan 2025 06:39:25 -0800 (PST)
Received: from debian.local ([83.105.230.12])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c95647efsm508057766b.117.2025.01.13.06.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 06:39:25 -0800 (PST)
Date: Mon, 13 Jan 2025 14:39:22 +0000
From: Chris Bainbridge <chris.bainbridge@gmail.com>
To: "Lai, Yi" <yi1.lai@linux.intel.com>
Cc: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
	yi1.lai@intel.com, syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH V2 3/3] block: model freeze & enter queue as lock for
 supporting lockdep
Message-ID: <Z4Ulmv7e0-Q4wMGq@debian.local>
References: <20241025003722.3630252-1-ming.lei@redhat.com>
 <20241025003722.3630252-4-ming.lei@redhat.com>
 <ZyHV7xTccCwN8j7b@ly-workstation>
 <ZyHchfaUe2cEzFMm@fedora>
 <ZyHzb8ExdDG4b8lo@ly-workstation>
 <CAFj5m9+bL23T7mMwR7g_8umTzkNJa14n8AhR3_g6QjB2YCcc5A@mail.gmail.com>
 <ZyIM0dWzxC9zBIuf@ly-workstation>
 <ZyITwN0ihIFiz9M2@fedora>
 <Z0/K0bDHBUWlt0Hl@ly-workstation>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z0/K0bDHBUWlt0Hl@ly-workstation>

Hi,

With latest mainline 6.13-rc6, I have been getting intermittent lock
warnings when using a btrfs filesystem. The warnings bisect to this
commit:

f1be1788a32e8fa63416ad4518bbd1a85a825c9d is the first bad commit
commit f1be1788a32e8fa63416ad4518bbd1a85a825c9d
Author: Ming Lei <ming.lei@redhat.com>
Date:   Fri Oct 25 08:37:20 2024 +0800

    block: model freeze & enter queue as lock for supporting lockdep


On my system, these lockdep warnings are reproducible just by doing some
large fs operation, like copying the whole linux kernel git repo to the
btrfs filesystem.

The lockdep warning is:

[  437.745808] ======================================================
[  437.745810] WARNING: possible circular locking dependency detected
[  437.745811] 6.13.0-rc6-00037-gac70f027bab6 #112 Not tainted
[  437.745813] ------------------------------------------------------
[  437.745814] kswapd0/141 is trying to acquire lock:
[  437.745815] ffff925c11095e90 (&delayed_node->mutex){+.+.}-{4:4}, at: __btrfs_release_delayed_node.part.0+0x3f/0x280 [btrfs]
[  437.745862]
               but task is already holding lock:
[  437.745863] ffffffffb9cc8c80 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat+0x578/0xa80
[  437.745869]
               which lock already depends on the new lock.

[  437.745870]
               the existing dependency chain (in reverse order) is:
[  437.745871]
               -> #3 (fs_reclaim){+.+.}-{0:0}:
[  437.745873]        fs_reclaim_acquire+0xbd/0xf0
[  437.745877]        __kmalloc_node_noprof+0xa1/0x4f0
[  437.745880]        __kvmalloc_node_noprof+0x24/0x100
[  437.745881]        sbitmap_init_node+0x98/0x240
[  437.745885]        scsi_realloc_sdev_budget_map+0xdd/0x1d0
[  437.745889]        scsi_add_lun+0x458/0x760
[  437.745891]        scsi_probe_and_add_lun+0x15e/0x480
[  437.745892]        __scsi_scan_target+0xfb/0x230
[  437.745893]        scsi_scan_channel+0x65/0xc0
[  437.745894]        scsi_scan_host_selected+0xfb/0x160
[  437.745896]        do_scsi_scan_host+0x9d/0xb0
[  437.745897]        do_scan_async+0x1c/0x1a0
[  437.745898]        async_run_entry_fn+0x2d/0x120
[  437.745901]        process_one_work+0x210/0x730
[  437.745903]        worker_thread+0x193/0x350
[  437.745905]        kthread+0xf3/0x120
[  437.745906]        ret_from_fork+0x40/0x70
[  437.745910]        ret_from_fork_asm+0x11/0x20
[  437.745912]
               -> #2 (&q->q_usage_counter(io)#10){++++}-{0:0}:
[  437.745916]        blk_mq_submit_bio+0x970/0xb40
[  437.745918]        __submit_bio+0x116/0x200
[  437.745921]        submit_bio_noacct_nocheck+0x1bf/0x420
[  437.745923]        submit_bio_noacct+0x1cd/0x610
[  437.745925]        submit_bio+0x38/0x100
[  437.745927]        btrfs_submit_dev_bio+0xf1/0x340 [btrfs]
[  437.745956]        btrfs_submit_bio+0x132/0x170 [btrfs]
[  437.745980]        btrfs_submit_chunk+0x198/0x690 [btrfs]
[  437.746004]        btrfs_submit_bbio+0x1b/0x30 [btrfs]
[  437.746028]        read_extent_buffer_pages+0x197/0x220 [btrfs]
[  437.746060]        btrfs_read_extent_buffer+0x95/0x1d0 [btrfs]
[  437.746093]        read_block_for_search+0x21c/0x3b0 [btrfs]
[  437.746123]        btrfs_search_slot+0x36c/0x1040 [btrfs]
[  437.746151]        btrfs_init_root_free_objectid+0x88/0x120 [btrfs]
[  437.746180]        btrfs_get_root_ref+0x21a/0x3c0 [btrfs]
[  437.746206]        btrfs_get_fs_root+0x13/0x20 [btrfs]
[  437.746231]        btrfs_lookup_dentry+0x606/0x670 [btrfs]
[  437.746259]        btrfs_lookup+0x12/0x40 [btrfs]
[  437.746285]        __lookup_slow+0xf9/0x1a0
[  437.746288]        walk_component+0x10c/0x180
[  437.746290]        path_lookupat+0x67/0x1a0
[  437.746291]        filename_lookup+0xee/0x200
[  437.746294]        vfs_path_lookup+0x54/0x90
[  437.746296]        mount_subtree+0x8b/0x150
[  437.746297]        btrfs_get_tree+0x3a8/0x8b0 [btrfs]
[  437.746326]        vfs_get_tree+0x27/0x100
[  437.746328]        path_mount+0x4f3/0xc00
[  437.746330]        __x64_sys_mount+0x120/0x160
[  437.746331]        x64_sys_call+0x8a1/0xfb0
[  437.746333]        do_syscall_64+0x87/0x140
[  437.746337]        entry_SYSCALL_64_after_hwframe+0x4b/0x53
[  437.746340]
               -> #1 (btrfs-tree-01){++++}-{4:4}:
[  437.746343]        lock_release+0x130/0x2c0
[  437.746345]        up_write+0x1c/0x1f0
[  437.746348]        btrfs_tree_unlock+0x1e/0x30 [btrfs]
[  437.746378]        unlock_up+0x1ce/0x380 [btrfs]
[  437.746406]        btrfs_search_slot+0x344/0x1040 [btrfs]
[  437.746433]        btrfs_lookup_inode+0x52/0xe0 [btrfs]
[  437.746461]        __btrfs_update_delayed_inode+0x6f/0x2f0 [btrfs]
[  437.746490]        btrfs_commit_inode_delayed_inode+0x123/0x130 [btrfs]
[  437.746516]        btrfs_evict_inode+0x2ff/0x440 [btrfs]
[  437.746545]        evict+0x11f/0x2d0
[  437.746547]        iput.part.0+0x1bf/0x270
[  437.746548]        iput+0x1c/0x30
[  437.746549]        do_unlinkat+0x2d2/0x320
[  437.746551]        __x64_sys_unlinkat+0x35/0x70
[  437.746552]        x64_sys_call+0x51b/0xfb0
[  437.746554]        do_syscall_64+0x87/0x140
[  437.746556]        entry_SYSCALL_64_after_hwframe+0x4b/0x53
[  437.746558]
               -> #0 (&delayed_node->mutex){+.+.}-{4:4}:
[  437.746560]        __lock_acquire+0x1615/0x27d0
[  437.746561]        lock_acquire+0xc9/0x300
[  437.746563]        __mutex_lock+0xd3/0x920
[  437.746565]        mutex_lock_nested+0x1b/0x30
[  437.746567]        __btrfs_release_delayed_node.part.0+0x3f/0x280 [btrfs]
[  437.746592]        btrfs_remove_delayed_node+0x2a/0x40 [btrfs]
[  437.746616]        btrfs_evict_inode+0x1a5/0x440 [btrfs]
[  437.746643]        evict+0x11f/0x2d0
[  437.746644]        dispose_list+0x39/0x80
[  437.746645]        prune_icache_sb+0x59/0x90
[  437.746647]        super_cache_scan+0x14e/0x1d0
[  437.746649]        do_shrink_slab+0x176/0x7a0
[  437.746651]        shrink_slab+0x4b6/0x970
[  437.746652]        shrink_one+0x125/0x200
[  437.746654]        shrink_node+0xca3/0x13f0
[  437.746655]        balance_pgdat+0x50b/0xa80
[  437.746657]        kswapd+0x224/0x480
[  437.746658]        kthread+0xf3/0x120
[  437.746659]        ret_from_fork+0x40/0x70
[  437.746661]        ret_from_fork_asm+0x11/0x20
[  437.746663]
               other info that might help us debug this:

[  437.746664] Chain exists of:
                 &delayed_node->mutex --> &q->q_usage_counter(io)#10 --> fs_reclaim

[  437.746667]  Possible unsafe locking scenario:

[  437.746668]        CPU0                    CPU1
[  437.746668]        ----                    ----
[  437.746669]   lock(fs_reclaim);
[  437.746670]                                lock(&q->q_usage_counter(io)#10);
[  437.746672]                                lock(fs_reclaim);
[  437.746673]   lock(&delayed_node->mutex);
[  437.746674]
                *** DEADLOCK ***

[  437.746675] 2 locks held by kswapd0/141:
[  437.746676]  #0: ffffffffb9cc8c80 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat+0x578/0xa80
[  437.746680]  #1: ffff925c027fc0e0 (&type->s_umount_key#30){++++}-{4:4}, at: super_cache_scan+0x39/0x1d0
[  437.746684]
               stack backtrace:
[  437.746685] CPU: 4 UID: 0 PID: 141 Comm: kswapd0 Not tainted 6.13.0-rc6-00037-gac70f027bab6 #112
[  437.746687] Hardware name: HP HP Pavilion Aero Laptop 13-be0xxx/8916, BIOS F.16 08/01/2024
[  437.746688] Call Trace:
[  437.746689]  <TASK>
[  437.746692]  dump_stack_lvl+0x8d/0xe0
[  437.746694]  dump_stack+0x10/0x20
[  437.746696]  print_circular_bug+0x27d/0x350
[  437.746698]  check_noncircular+0x14c/0x170
[  437.746700]  __lock_acquire+0x1615/0x27d0
[  437.746703]  lock_acquire+0xc9/0x300
[  437.746704]  ? __btrfs_release_delayed_node.part.0+0x3f/0x280 [btrfs]
[  437.746730]  __mutex_lock+0xd3/0x920
[  437.746731]  ? __btrfs_release_delayed_node.part.0+0x3f/0x280 [btrfs]
[  437.746754]  ? __btrfs_release_delayed_node.part.0+0x3f/0x280 [btrfs]
[  437.746777]  mutex_lock_nested+0x1b/0x30
[  437.746779]  ? mutex_lock_nested+0x1b/0x30
[  437.746781]  __btrfs_release_delayed_node.part.0+0x3f/0x280 [btrfs]
[  437.746803]  btrfs_remove_delayed_node+0x2a/0x40 [btrfs]
[  437.746826]  btrfs_evict_inode+0x1a5/0x440 [btrfs]
[  437.746852]  ? lock_release+0xdb/0x2c0
[  437.746853]  ? evict+0x10d/0x2d0
[  437.746856]  evict+0x11f/0x2d0
[  437.746858]  dispose_list+0x39/0x80
[  437.746860]  prune_icache_sb+0x59/0x90
[  437.746861]  super_cache_scan+0x14e/0x1d0
[  437.746864]  do_shrink_slab+0x176/0x7a0
[  437.746866]  shrink_slab+0x4b6/0x970
[  437.746868]  ? shrink_slab+0x2fe/0x970
[  437.746869]  ? shrink_slab+0x383/0x970
[  437.746872]  shrink_one+0x125/0x200
[  437.746873]  ? shrink_node+0xc87/0x13f0
[  437.746875]  shrink_node+0xca3/0x13f0
[  437.746877]  ? shrink_node+0xad5/0x13f0
[  437.746879]  ? mem_cgroup_iter+0x352/0x470
[  437.746882]  balance_pgdat+0x50b/0xa80
[  437.746883]  ? balance_pgdat+0x50b/0xa80
[  437.746886]  ? lock_acquire+0xc9/0x300
[  437.746889]  kswapd+0x224/0x480
[  437.746891]  ? sugov_hold_freq+0xc0/0xc0
[  437.746894]  ? balance_pgdat+0xa80/0xa80
[  437.746895]  kthread+0xf3/0x120
[  437.746897]  ? kthread_insert_work_sanity_check+0x60/0x60
[  437.746898]  ret_from_fork+0x40/0x70
[  437.746900]  ? kthread_insert_work_sanity_check+0x60/0x60
[  437.746902]  ret_from_fork_asm+0x11/0x20
[  437.746905]  </TASK>
