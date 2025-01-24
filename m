Received: from omta003.cacentral1.a.cloudfilter.net (omta001.cacentral1.a.cloudfilter.net [3.97.99.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A761CFEB2;
	Fri, 24 Jan 2025 22:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.97.99.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737758546; cv=none; b=a0GjpSqEEOV4Y81j/y0fsOKbfd9rGJM9HmZ/CJTiA4Gt/oYQ1TPg+g/AqjaoXyVPIn4zRHdnaocdQxCPv6p/kY40IK4QAXl0zRxOki4Is4jx7BkGxDHXtaE/0WJnBd4CE4Lgz6QJqHTPeoFGcvTf2beBuJ5hSbCBNgRhocP7pcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737758546; c=relaxed/simple;
	bh=5UfIQEJ00wEeDUqxo63gelbyL4TajQtDvEDpi07Kqho=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=Uqgc0OClg9zE2o3d/W+A4rrmWCTMvftluawyHZzl5M9oc9aO8V7Y0mBT7BVu5BTMflopFUiv1/7XA7WxXbr0qh0fna/ggRRXxAmodb9+kO8xUsHwsdJ/0HENtng/PkqRh36ltW91gbbOhJFUHVKDvWZePF9ihFETaOgyoaWroq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuyoix.net; spf=pass smtp.mailfrom=tuyoix.net; arc=none smtp.client-ip=3.97.99.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuyoix.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuyoix.net
Received: from shw-obgw-4004a.ext.cloudfilter.net ([10.228.9.227])
	by cmsmtp with ESMTPS
	id bL9YtQcDZxv7PbSM2tjSxY; Fri, 24 Jan 2025 22:40:46 +0000
Received: from fanir.tuyoix.net ([68.150.218.192])
	by cmsmtp with ESMTP
	id bSM1tT1SsJhBPbSM1tj1yq; Fri, 24 Jan 2025 22:40:46 +0000
X-Authority-Analysis: v=2.4 cv=QY3Fvdbv c=1 sm=1 tr=0 ts=679416ee
 a=LfNn7serMq+1bQZBlMsSfQ==:117 a=LfNn7serMq+1bQZBlMsSfQ==:17
 a=kj9zAlcOel0A:10 a=VdSt8ZQiCzkA:10 a=M51BFTxLslgA:10
 a=1NA1KFWmo5hBXehAw4UA:9 a=CjuIK1q_8ugA:10
Received: from tuyoix.net (fanir.tuyoix.net [192.168.144.16])
	(authenticated bits=0)
	by fanir.tuyoix.net (8.18.1/8.18.1) with ESMTPSA id 50OMehgY015871
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Fri, 24 Jan 2025 15:40:43 -0700
Date: Fri, 24 Jan 2025 15:40:43 -0700 (MST)
From: =?UTF-8?Q?Marc_Aur=C3=A8le_La_France?= <tsi@tuyoix.net>
To: Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>,
        linux-mm@kvack.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: kswapd lockdep splat
Message-ID: <543e68df-e27d-7e6e-0d50-867dd6cf2fe0@tuyoix.net>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-CMAE-Envelope: MS4xfBr/eDz4+DrfxXDO2ZYnQB/G1nM7v/kMYJh7JSQAkTERuelLSNqkChYaXZdiJcli+Ag0qLPqakE9X3mF37JzMw4H1Y4c2PyNdmkHlf/ki7oft99K/ZE0
 TpeKiaY1iHFi/0jqPIliZ8cf8li7jYGnAPuMD/IlaztUZT3F+fUj/TjMEvmJQ2WrB1yLKktQ3Z3S0kLuzVpM2Pjh0yG37j6jeKai9lMCSRf3BiRN7mh/8rjb
 LFHNwHV6hGCYOYFvKb97oEWOMwIuhzgK0yToaOwHn0GAKyDjvEgDCCiKtwtN7kZpVlUjtBoLlkD5JFvg/weJhjB16Hb1Mzw6l7ILBVHmy+U=

Hi.

I've yet to find anywhere to post these splats to, except to where
get_maintainer.pl suggests regarding the affected source files,
mm/vmscan.c and block/blk_mq.c.

I don't have a reproduceable case, so haven't been able to bisect
anything.

Let me know if you need more information.

Thanks and have a great day.

Marc.

--8<--

======================================================
WARNING: possible circular locking dependency detected
6.13.0 #1 Not tainted
------------------------------------------------------
kswapd0/70 is trying to acquire lock:
ffff8881025d5d78 (&q->q_usage_counter(io)){++++}-{0:0}, at: blk_mq_submit_bio+0x461/0x6e0

but task is already holding lock:
ffffffff81ef5f40 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat+0x9f/0x760

which lock already depends on the new lock.

the existing dependency chain (in reverse order) is:

-> #1 (fs_reclaim){+.+.}-{0:0}:
        lock_acquire.part.0+0x94/0x1f0
        fs_reclaim_acquire+0x8d/0xc0
        __kmalloc_node_noprof+0x86/0x360
        sbitmap_init_node+0x85/0x200
        scsi_realloc_sdev_budget_map+0xc5/0x190
        scsi_add_lun+0x3ee/0x6c0
        scsi_probe_and_add_lun+0x111/0x290
        __scsi_add_device+0xc7/0xd0
        ata_scsi_scan_host+0x93/0x1b0
        async_run_entry_fn+0x21/0xa0
        process_one_work+0x1fd/0x560
        worker_thread+0x1bd/0x3a0
        kthread+0xdc/0x110
        ret_from_fork+0x2b/0x40
        ret_from_fork_asm+0x11/0x20

-> #0 (&q->q_usage_counter(io)){++++}-{0:0}:
        check_prev_add+0xe2/0xc80
        __lock_acquire+0xf37/0x12c0
        lock_acquire.part.0+0x94/0x1f0
        bio_queue_enter+0xf1/0x220
        blk_mq_submit_bio+0x461/0x6e0
        __submit_bio+0x95/0x160
        submit_bio_noacct_nocheck+0xbd/0x1a0
        swap_writepage+0xff/0x1a0
        pageout+0xfb/0x2a0
        shrink_folio_list+0x57e/0xad0
        evict_folios+0x224/0x6e0
        try_to_shrink_lruvec+0x186/0x300
        shrink_node+0x37f/0x440
        balance_pgdat+0x2a4/0x760
        kswapd+0x1b3/0x3b0
        kthread+0xdc/0x110
        ret_from_fork+0x2b/0x40
        ret_from_fork_asm+0x11/0x20

other info that might help us debug this:

  Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock(fs_reclaim);
                                lock(&q->q_usage_counter(io));
                                lock(fs_reclaim);
   rlock(&q->q_usage_counter(io));

  *** DEADLOCK ***

1 lock held by kswapd0/70:
  #0: ffffffff81ef5f40 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat+0x9f/0x760

stack backtrace:
CPU: 2 UID: 0 PID: 70 Comm: kswapd0 Not tainted 6.13.0 #1
Hardware name: ASUS All Series/Z87-WS, BIOS 2004 06/05/2014
Call Trace:
  <TASK>
  dump_stack_lvl+0x57/0x80
  print_circular_bug.cold+0x38/0x45
  check_noncircular+0x107/0x120
  ? unwind_next_frame+0x318/0x690
  check_prev_add+0xe2/0xc80
  __lock_acquire+0xf37/0x12c0
  ? stack_trace_save+0x3b/0x50
  lock_acquire.part.0+0x94/0x1f0
  ? blk_mq_submit_bio+0x461/0x6e0
  ? rcu_is_watching+0xd/0x40
  ? lock_acquire+0x100/0x140
  ? blk_mq_submit_bio+0x461/0x6e0
  ? bio_queue_enter+0xc9/0x220
  bio_queue_enter+0xf1/0x220
  ? blk_mq_submit_bio+0x461/0x6e0
  blk_mq_submit_bio+0x461/0x6e0
  ? lock_is_held_type+0xc5/0x120
  ? rcu_is_watching+0xd/0x40
  ? kmem_cache_alloc_noprof+0x209/0x260
  __submit_bio+0x95/0x160
  ? lock_is_held_type+0xc5/0x120
  ? submit_bio_noacct_nocheck+0xbd/0x1a0
  submit_bio_noacct_nocheck+0xbd/0x1a0
  swap_writepage+0xff/0x1a0
  pageout+0xfb/0x2a0
  shrink_folio_list+0x57e/0xad0
  ? rcu_is_watching+0xd/0x40
  ? scan_folios+0x5ce/0x610
  ? find_held_lock+0x2b/0x80
  ? mark_held_locks+0x40/0x70
  ? _raw_spin_unlock_irq+0x1f/0x40
  evict_folios+0x224/0x6e0
  try_to_shrink_lruvec+0x186/0x300
  shrink_node+0x37f/0x440
  balance_pgdat+0x2a4/0x760
  ? lock_acquire.part.0+0x94/0x1f0
  kswapd+0x1b3/0x3b0
  ? ipi_sync_rq_state+0x30/0x30
  ? balance_pgdat+0x760/0x760
  kthread+0xdc/0x110
  ? kthread_park+0x80/0x80
  ret_from_fork+0x2b/0x40
  ? kthread_park+0x80/0x80
  ret_from_fork_asm+0x11/0x20
  </TASK>
