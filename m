Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA71F9FE
	for <linux-block@vger.kernel.org>; Tue, 18 Mar 2025 01:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742260728; cv=none; b=G9XN8+6huSIm4RVqgxphQdFc1YGzHuo0j7fVTgz+9kraGwze/EJF+b0BtQZZ4UtoF1gpwz0VUDT4VR+Brn8XtAmk3vO4YPw7QE9RGby1VThR3SSu+AZV2ByNi0qamPH0Shi7AAjDmxhOp7pVAuB1RdkF+zpp2g+YZsK3GFu1nl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742260728; c=relaxed/simple;
	bh=M+B/6piCoVT36DqafOuHKdfeMCvuAneiPvbBrhT8EkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l7hk2It0jn5VDD2CNFgTcQwTi432cyIw81zxd+r90BQjiXNVZEhwqM/jbdHcPMIiZiRRN3/LMjlddHJ/t62XWCNU3kOTVptY+YieVggarFuCy4TzAqzOhu0oZOkJL4tdbtExE3RRkrHVSYY7FAnfc+uhp2n2FMlSucROrlC+FzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BMZSsoH9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BMZSsoH9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742260723;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vwj8wfVHH8dVRlGPSXF5b2XuQUgiS/Aen/KRoOjn+7w=;
	b=BMZSsoH9iM26kkLpkV5XxN+KTgW+H3Wk+TrXi7qAK/u5wYfMLMsn/gX49XTvhWWa1WxCZC
	kgdfRgcEhOEogMdpTXjqStW3LtvBFR29g6CBHpQWvoHE37oqUtn7hFQjBN/dwEi3HxXsWH
	AG9Q3HQzisxBXofiIBvFqSX2KnV81Z4=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-657-rWp3VH4iP4iubDvSMlaoLQ-1; Mon,
 17 Mar 2025 21:18:39 -0400
X-MC-Unique: rWp3VH4iP4iubDvSMlaoLQ-1
X-Mimecast-MFC-AGG-ID: rWp3VH4iP4iubDvSMlaoLQ_1742260718
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0B347195609F;
	Tue, 18 Mar 2025 01:18:38 +0000 (UTC)
Received: from fedora (unknown [10.72.120.14])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BCCB91956095;
	Tue, 18 Mar 2025 01:18:33 +0000 (UTC)
Date: Tue, 18 Mar 2025 09:18:27 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] block: Make request_queue lockdep splats show up
 earlier
Message-ID: <Z9jJ401CKYYXys0o@fedora>
References: <20250317171156.2954-1-thomas.hellstrom@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250317171156.2954-1-thomas.hellstrom@linux.intel.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Mon, Mar 17, 2025 at 06:11:55PM +0100, Thomas Hellström wrote:
> In recent kernels, there are lockdep splats around the
> struct request_queue::io_lockdep_map, similar to [1], but they
> typically don't show up until reclaim with writeback happens.
> 
> Having multiple kernel versions released with a known risc of kernel
> deadlock during reclaim writeback should IMHO be addressed and
> backported to -stable with the highest priority.
> 
> In order to have these lockdep splats show up earlier,
> preferrably during system initialization, prime the
> struct request_queue::io_lockdep_map as GFP_KERNEL reclaim-
> tainted. This will instead lead to lockdep splats looking similar
> to [2], but without the need for reclaim + writeback
> happening.
> 
> [1]:
> [  189.762244] ======================================================
> [  189.762432] WARNING: possible circular locking dependency detected
> [  189.762441] 6.14.0-rc6-xe+ #6 Tainted: G     U
> [  189.762450] ------------------------------------------------------
> [  189.762459] kswapd0/119 is trying to acquire lock:
> [  189.762467] ffff888110ceb710 (&q->q_usage_counter(io)#26){++++}-{0:0}, at: __submit_bio+0x76/0x230
> [  189.762485]
>                but task is already holding lock:
> [  189.762494] ffffffff834c97c0 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat+0xbe/0xb00
> [  189.762507]
>                which lock already depends on the new lock.
> 
> [  189.762519]
>                the existing dependency chain (in reverse order) is:
> [  189.762529]
>                -> #2 (fs_reclaim){+.+.}-{0:0}:
> [  189.762540]        fs_reclaim_acquire+0xc5/0x100
> [  189.762548]        kmem_cache_alloc_lru_noprof+0x4a/0x480
> [  189.762558]        alloc_inode+0xaa/0xe0
> [  189.762566]        iget_locked+0x157/0x330
> [  189.762573]        kernfs_get_inode+0x1b/0x110
> [  189.762582]        kernfs_get_tree+0x1b0/0x2e0
> [  189.762590]        sysfs_get_tree+0x1f/0x60
> [  189.762597]        vfs_get_tree+0x2a/0xf0
> [  189.762605]        path_mount+0x4cd/0xc00
> [  189.762613]        __x64_sys_mount+0x119/0x150
> [  189.762621]        x64_sys_call+0x14f2/0x2310
> [  189.762630]        do_syscall_64+0x91/0x180
> [  189.762637]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [  189.762647]
>                -> #1 (&root->kernfs_rwsem){++++}-{3:3}:
> [  189.762659]        down_write+0x3e/0xf0
> [  189.762667]        kernfs_remove+0x32/0x60
> [  189.762676]        sysfs_remove_dir+0x4f/0x60
> [  189.762685]        __kobject_del+0x33/0xa0
> [  189.762709]        kobject_del+0x13/0x30
> [  189.762716]        elv_unregister_queue+0x52/0x80
> [  189.762725]        elevator_switch+0x68/0x360
> [  189.762733]        elv_iosched_store+0x14b/0x1b0
> [  189.762756]        queue_attr_store+0x181/0x1e0
> [  189.762765]        sysfs_kf_write+0x49/0x80
> [  189.762773]        kernfs_fop_write_iter+0x17d/0x250
> [  189.762781]        vfs_write+0x281/0x540
> [  189.762790]        ksys_write+0x72/0xf0
> [  189.762798]        __x64_sys_write+0x19/0x30
> [  189.762807]        x64_sys_call+0x2a3/0x2310
> [  189.762815]        do_syscall_64+0x91/0x180
> [  189.762823]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [  189.762833]
>                -> #0 (&q->q_usage_counter(io)#26){++++}-{0:0}:
> [  189.762845]        __lock_acquire+0x1525/0x2760
> [  189.762854]        lock_acquire+0xca/0x310
> [  189.762861]        blk_mq_submit_bio+0x8a2/0xba0
> [  189.762870]        __submit_bio+0x76/0x230
> [  189.762878]        submit_bio_noacct_nocheck+0x323/0x430
> [  189.762888]        submit_bio_noacct+0x2cc/0x620
> [  189.762896]        submit_bio+0x38/0x110
> [  189.762904]        __swap_writepage+0xf5/0x380
> [  189.762912]        swap_writepage+0x3c7/0x600
> [  189.762920]        shmem_writepage+0x3da/0x4f0
> [  189.762929]        pageout+0x13f/0x310
> [  189.762937]        shrink_folio_list+0x61c/0xf60
> [  189.763261]        evict_folios+0x378/0xcd0
> [  189.763584]        try_to_shrink_lruvec+0x1b0/0x360
> [  189.763946]        shrink_one+0x10e/0x200
> [  189.764266]        shrink_node+0xc02/0x1490
> [  189.764586]        balance_pgdat+0x563/0xb00
> [  189.764934]        kswapd+0x1e8/0x430
> [  189.765249]        kthread+0x10b/0x260
> [  189.765559]        ret_from_fork+0x44/0x70
> [  189.765889]        ret_from_fork_asm+0x1a/0x30
> [  189.766198]
>                other info that might help us debug this:
> 
> [  189.767089] Chain exists of:
>                  &q->q_usage_counter(io)#26 --> &root->kernfs_rwsem --> fs_reclaim
> 
> [  189.767971]  Possible unsafe locking scenario:
> 
> [  189.768555]        CPU0                    CPU1
> [  189.768849]        ----                    ----
> [  189.769136]   lock(fs_reclaim);
> [  189.769421]                                lock(&root->kernfs_rwsem);
> [  189.769714]                                lock(fs_reclaim);
> [  189.770016]   rlock(&q->q_usage_counter(io)#26);
> [  189.770305]
>                 *** DEADLOCK ***
> 
> [  189.771167] 1 lock held by kswapd0/119:
> [  189.771453]  #0: ffffffff834c97c0 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat+0xbe/0xb00
> [  189.771770]
>                stack backtrace:
> [  189.772351] CPU: 4 UID: 0 PID: 119 Comm: kswapd0 Tainted: G     U             6.14.0-rc6-xe+ #6
> [  189.772353] Tainted: [U]=USER
> [  189.772354] Hardware name: ASUS System Product Name/PRIME B560M-A AC, BIOS 2001 02/01/2023
> [  189.772354] Call Trace:
> [  189.772355]  <TASK>
> [  189.772356]  dump_stack_lvl+0x6e/0xa0
> [  189.772359]  dump_stack+0x10/0x18
> [  189.772360]  print_circular_bug.cold+0x17a/0x1b7
> [  189.772363]  check_noncircular+0x13a/0x150
> [  189.772365]  ? __pfx_stack_trace_consume_entry+0x10/0x10
> [  189.772368]  __lock_acquire+0x1525/0x2760
> [  189.772368]  ? ret_from_fork_asm+0x1a/0x30
> [  189.772371]  lock_acquire+0xca/0x310
> [  189.772372]  ? __submit_bio+0x76/0x230
> [  189.772375]  ? lock_release+0xd5/0x2c0
> [  189.772376]  blk_mq_submit_bio+0x8a2/0xba0
> [  189.772378]  ? __submit_bio+0x76/0x230
> [  189.772380]  __submit_bio+0x76/0x230
> [  189.772382]  ? trace_hardirqs_on+0x1e/0xe0
> [  189.772384]  submit_bio_noacct_nocheck+0x323/0x430
> [  189.772386]  ? submit_bio_noacct_nocheck+0x323/0x430
> [  189.772387]  ? __might_sleep+0x58/0xa0
> [  189.772390]  submit_bio_noacct+0x2cc/0x620
> [  189.772391]  ? count_memcg_events+0x68/0x90
> [  189.772393]  submit_bio+0x38/0x110
> [  189.772395]  __swap_writepage+0xf5/0x380
> [  189.772396]  swap_writepage+0x3c7/0x600
> [  189.772397]  shmem_writepage+0x3da/0x4f0
> [  189.772401]  pageout+0x13f/0x310
> [  189.772406]  shrink_folio_list+0x61c/0xf60
> [  189.772409]  ? isolate_folios+0xe80/0x16b0
> [  189.772410]  ? mark_held_locks+0x46/0x90
> [  189.772412]  evict_folios+0x378/0xcd0
> [  189.772414]  ? evict_folios+0x34a/0xcd0
> [  189.772415]  ? lock_is_held_type+0xa3/0x130
> [  189.772417]  try_to_shrink_lruvec+0x1b0/0x360
> [  189.772420]  shrink_one+0x10e/0x200
> [  189.772421]  shrink_node+0xc02/0x1490
> [  189.772423]  ? shrink_node+0xa08/0x1490
> [  189.772424]  ? shrink_node+0xbd8/0x1490
> [  189.772425]  ? mem_cgroup_iter+0x366/0x480
> [  189.772427]  balance_pgdat+0x563/0xb00
> [  189.772428]  ? balance_pgdat+0x563/0xb00
> [  189.772430]  ? trace_hardirqs_on+0x1e/0xe0
> [  189.772431]  ? finish_task_switch.isra.0+0xcb/0x330
> [  189.772433]  ? __switch_to_asm+0x33/0x70
> [  189.772437]  kswapd+0x1e8/0x430
> [  189.772438]  ? __pfx_autoremove_wake_function+0x10/0x10
> [  189.772440]  ? __pfx_kswapd+0x10/0x10
> [  189.772441]  kthread+0x10b/0x260
> [  189.772443]  ? __pfx_kthread+0x10/0x10
> [  189.772444]  ret_from_fork+0x44/0x70
> [  189.772446]  ? __pfx_kthread+0x10/0x10
> [  189.772447]  ret_from_fork_asm+0x1a/0x30
> [  189.772450]  </TASK>
> 
> [2]:
> [    8.760253] ======================================================
> [    8.760254] WARNING: possible circular locking dependency detected
> [    8.760255] 6.14.0-rc6-xe+ #7 Tainted: G     U
> [    8.760256] ------------------------------------------------------
> [    8.760257] (udev-worker)/674 is trying to acquire lock:
> [    8.760259] ffff888100e39148 (&root->kernfs_rwsem){++++}-{3:3}, at: kernfs_remove+0x32/0x60
> [    8.760265]
>                but task is already holding lock:
> [    8.760266] ffff888110dc7680 (&q->q_usage_counter(io)#27){++++}-{0:0}, at: blk_mq_freeze_queue_nomemsave+0x12/0x30
> [    8.760272]
>                which lock already depends on the new lock.
> 
> [    8.760272]
>                the existing dependency chain (in reverse order) is:
> [    8.760273]
>                -> #2 (&q->q_usage_counter(io)#27){++++}-{0:0}:
> [    8.760276]        blk_alloc_queue+0x30a/0x350
> [    8.760279]        blk_mq_alloc_queue+0x6b/0xe0
> [    8.760281]        scsi_alloc_sdev+0x276/0x3c0
> [    8.760284]        scsi_probe_and_add_lun+0x22a/0x440
> [    8.760286]        __scsi_scan_target+0x109/0x230
> [    8.760288]        scsi_scan_channel+0x65/0xc0
> [    8.760290]        scsi_scan_host_selected+0xff/0x140
> [    8.760292]        do_scsi_scan_host+0xa7/0xc0
> [    8.760293]        do_scan_async+0x1c/0x160
> [    8.760295]        async_run_entry_fn+0x32/0x150
> [    8.760299]        process_one_work+0x224/0x5f0
> [    8.760302]        worker_thread+0x1d4/0x3e0
> [    8.760304]        kthread+0x10b/0x260
> [    8.760306]        ret_from_fork+0x44/0x70
> [    8.760309]        ret_from_fork_asm+0x1a/0x30
> [    8.760312]
>                -> #1 (fs_reclaim){+.+.}-{0:0}:
> [    8.760315]        fs_reclaim_acquire+0xc5/0x100
> [    8.760317]        kmem_cache_alloc_lru_noprof+0x4a/0x480
> [    8.760319]        alloc_inode+0xaa/0xe0
> [    8.760322]        iget_locked+0x157/0x330
> [    8.760323]        kernfs_get_inode+0x1b/0x110
> [    8.760325]        kernfs_get_tree+0x1b0/0x2e0
> [    8.760327]        sysfs_get_tree+0x1f/0x60
> [    8.760329]        vfs_get_tree+0x2a/0xf0
> [    8.760332]        path_mount+0x4cd/0xc00
> [    8.760334]        __x64_sys_mount+0x119/0x150
> [    8.760336]        x64_sys_call+0x14f2/0x2310
> [    8.760338]        do_syscall_64+0x91/0x180
> [    8.760340]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [    8.760342]
>                -> #0 (&root->kernfs_rwsem){++++}-{3:3}:
> [    8.760345]        __lock_acquire+0x1525/0x2760
> [    8.760347]        lock_acquire+0xca/0x310
> [    8.760348]        down_write+0x3e/0xf0
> [    8.760350]        kernfs_remove+0x32/0x60
> [    8.760351]        sysfs_remove_dir+0x4f/0x60
> [    8.760353]        __kobject_del+0x33/0xa0
> [    8.760355]        kobject_del+0x13/0x30
> [    8.760356]        elv_unregister_queue+0x52/0x80
> [    8.760358]        elevator_switch+0x68/0x360
> [    8.760360]        elv_iosched_store+0x14b/0x1b0
> [    8.760362]        queue_attr_store+0x181/0x1e0
> [    8.760364]        sysfs_kf_write+0x49/0x80
> [    8.760366]        kernfs_fop_write_iter+0x17d/0x250
> [    8.760367]        vfs_write+0x281/0x540
> [    8.760370]        ksys_write+0x72/0xf0
> [    8.760372]        __x64_sys_write+0x19/0x30
> [    8.760374]        x64_sys_call+0x2a3/0x2310
> [    8.760376]        do_syscall_64+0x91/0x180
> [    8.760377]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [    8.760380]
>                other info that might help us debug this:
> 
> [    8.760380] Chain exists of:
>                  &root->kernfs_rwsem --> fs_reclaim --> &q->q_usage_counter(io)#27
> 
> [    8.760384]  Possible unsafe locking scenario:
> 
> [    8.760384]        CPU0                    CPU1
> [    8.760385]        ----                    ----
> [    8.760385]   lock(&q->q_usage_counter(io)#27);
> [    8.760387]                                lock(fs_reclaim);
> [    8.760388]                                lock(&q->q_usage_counter(io)#27);
> [    8.760390]   lock(&root->kernfs_rwsem);
> [    8.760391]
>                 *** DEADLOCK ***
> 
> [    8.760391] 6 locks held by (udev-worker)/674:
> [    8.760392]  #0: ffff8881209ac420 (sb_writers#4){.+.+}-{0:0}, at: ksys_write+0x72/0xf0
> [    8.760398]  #1: ffff88810c80f488 (&of->mutex#2){+.+.}-{3:3}, at: kernfs_fop_write_iter+0x136/0x250
> [    8.760402]  #2: ffff888125d1d330 (kn->active#101){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x13f/0x250
> [    8.760406]  #3: ffff888110dc7bb0 (&q->sysfs_lock){+.+.}-{3:3}, at: queue_attr_store+0x148/0x1e0
> [    8.760411]  #4: ffff888110dc7680 (&q->q_usage_counter(io)#27){++++}-{0:0}, at: blk_mq_freeze_queue_nomemsave+0x12/0x30
> [    8.760416]  #5: ffff888110dc76b8 (&q->q_usage_counter(queue)#27){++++}-{0:0}, at: blk_mq_freeze_queue_nomemsave+0x12/0x30
> [    8.760421]
>                stack backtrace:
> [    8.760422] CPU: 7 UID: 0 PID: 674 Comm: (udev-worker) Tainted: G     U             6.14.0-rc6-xe+ #7
> [    8.760424] Tainted: [U]=USER
> [    8.760425] Hardware name: ASUS System Product Name/PRIME B560M-A AC, BIOS 2001 02/01/2023
> [    8.760426] Call Trace:
> [    8.760427]  <TASK>
> [    8.760428]  dump_stack_lvl+0x6e/0xa0
> [    8.760431]  dump_stack+0x10/0x18
> [    8.760433]  print_circular_bug.cold+0x17a/0x1b7
> [    8.760437]  check_noncircular+0x13a/0x150
> [    8.760441]  ? save_trace+0x54/0x360
> [    8.760445]  __lock_acquire+0x1525/0x2760
> [    8.760446]  ? irqentry_exit+0x3a/0xb0
> [    8.760448]  ? sysvec_apic_timer_interrupt+0x57/0xc0
> [    8.760452]  lock_acquire+0xca/0x310
> [    8.760453]  ? kernfs_remove+0x32/0x60
> [    8.760457]  down_write+0x3e/0xf0
> [    8.760459]  ? kernfs_remove+0x32/0x60
> [    8.760460]  kernfs_remove+0x32/0x60
> [    8.760462]  sysfs_remove_dir+0x4f/0x60
> [    8.760464]  __kobject_del+0x33/0xa0
> [    8.760466]  kobject_del+0x13/0x30
> [    8.760467]  elv_unregister_queue+0x52/0x80
> [    8.760470]  elevator_switch+0x68/0x360
> [    8.760472]  elv_iosched_store+0x14b/0x1b0
> [    8.760475]  queue_attr_store+0x181/0x1e0
> [    8.760479]  ? lock_acquire+0xca/0x310
> [    8.760480]  ? kernfs_fop_write_iter+0x13f/0x250
> [    8.760482]  ? lock_is_held_type+0xa3/0x130
> [    8.760485]  sysfs_kf_write+0x49/0x80
> [    8.760487]  kernfs_fop_write_iter+0x17d/0x250
> [    8.760489]  vfs_write+0x281/0x540
> [    8.760494]  ksys_write+0x72/0xf0
> [    8.760497]  __x64_sys_write+0x19/0x30
> [    8.760499]  x64_sys_call+0x2a3/0x2310
> [    8.760502]  do_syscall_64+0x91/0x180
> [    8.760504]  ? trace_hardirqs_off+0x5d/0xe0
> [    8.760506]  ? handle_softirqs+0x479/0x4d0
> [    8.760508]  ? hrtimer_interrupt+0x13f/0x280
> [    8.760511]  ? irqentry_exit_to_user_mode+0x8b/0x260
> [    8.760513]  ? clear_bhb_loop+0x15/0x70
> [    8.760515]  ? clear_bhb_loop+0x15/0x70
> [    8.760516]  ? clear_bhb_loop+0x15/0x70
> [    8.760518]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [    8.760520] RIP: 0033:0x7aa3bf2f5504
> [    8.760522] Code: c7 00 16 00 00 00 b8 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 80 3d c5 8b 10 00 00 74 13 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 55 48 89 e5 48 83 ec 20 48 89
> [    8.760523] RSP: 002b:00007ffc1e3697d8 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
> [    8.760526] RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007aa3bf2f5504
> [    8.760527] RDX: 0000000000000003 RSI: 00007ffc1e369ae0 RDI: 000000000000001c
> [    8.760528] RBP: 00007ffc1e369800 R08: 00007aa3bf3f51c8 R09: 00007ffc1e3698b0
> [    8.760528] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000003
> [    8.760529] R13: 00007ffc1e369ae0 R14: 0000613ccf21f2f0 R15: 00007aa3bf3f4e80
> [    8.760533]  </TASK>
> 
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: linux-block@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> ---
>  block/blk-core.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index d6c4fa3943b5..4aa439309406 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -455,6 +455,12 @@ struct request_queue *blk_alloc_queue(struct queue_limits *lim, int node_id)
>  	lockdep_init_map(&q->q_lockdep_map, "&q->q_usage_counter(queue)",
>  			 &q->q_lock_cls_key, 0);
>  
> +	/* Prime io_lockdep_map as reclaim tainted */

Maybe it is more readable to change to:

 /* Teach lockdep about lock ordering wrt. queue freeze lock */

> +	fs_reclaim_acquire(GFP_KERNEL);
> +	rwsem_acquire_read(&q->io_lockdep_map, 0, 0, _RET_IP_);
> +	rwsem_release(&q->io_lockdep_map, _RET_IP_);
> +	fs_reclaim_release(GFP_KERNEL);

Looks fine, especially this approach has been used widely in tree:

Reviewed-by: Ming Lei <ming.lei@redhat.com> 


Thanks,
Ming

