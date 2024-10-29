Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBFF205148
	for <linux-block@vger.kernel.org>; Tue, 29 Oct 2024 11:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730200764; cv=none; b=m3txZNgma11yuk8iIWTg+97SSUoV0LXtuqpYQI3EtF5kjkZcJ7+9hC5mlnGnWuDaWTEEm5yUG9HA4CRNtYuCgDduQRNgDSvzHLvLbU7pxrBdj+QqwB8k5gxBrXvw/LSIFaTn5BnD8abZmRlsst+U4F64an1INViemMedTaWYw8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730200764; c=relaxed/simple;
	bh=DbutkOpxqabeZSGhKwSVEWcsKZazu76xQmU9dK8Xgx8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=Ua0TApwfE8yrcq+6DI0tlAHjS2vl36D6O0ZqQcPcti4ZZKPj5IuZrzLjjMBGy4jm08uxawtDnkblMbQTiM297P9bvlV0Y3AkzZuEZHa4vDxdxntEuzmqrfXYtsi2mZE3+npiOm0HxjrxDnCw41iDX9mqYYTwsdfGYhrs0huHvbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=ji9mAlAC; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ji9mAlAC"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20241029111339euoutp02156a38a7fa21bdf3862dd1b11a53ecce~C6B1wTpFe2721327213euoutp02H
	for <linux-block@vger.kernel.org>; Tue, 29 Oct 2024 11:13:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20241029111339euoutp02156a38a7fa21bdf3862dd1b11a53ecce~C6B1wTpFe2721327213euoutp02H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1730200420;
	bh=oUBn2d0EjFycnMUt9fC0KXPraVou5/cMi92xHqEKxNU=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=ji9mAlACoIZ08wcMVg/FQGQPkMU7x+7hDhAPeeZg6KfLXGlyZSkWTwQVv9p68BZ5B
	 g0jbzBaWulN1Md+Jbwg/+7lHL3NX5e1AbGoBqZATHAl0bk3NiEJFpn6K5WTt8ZSJU1
	 kzLgKIeRdje0Z+1d4ZPikPWOxW3S/EEpypllP834=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20241029111339eucas1p188c54cb7819700cbd0d3fce807625568~C6B1WfFcO0346603466eucas1p1R;
	Tue, 29 Oct 2024 11:13:39 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 78.92.20397.363C0276; Tue, 29
	Oct 2024 11:13:39 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20241029111338eucas1p2bd56c697b825eef235604e892569207e~C6B0lB6W12418024180eucas1p2Z;
	Tue, 29 Oct 2024 11:13:38 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20241029111338eusmtrp1a29cd98ec6a7156478f027deefff79f8~C6B0kei9W2589825898eusmtrp1O;
	Tue, 29 Oct 2024 11:13:38 +0000 (GMT)
X-AuditID: cbfec7f5-e59c770000004fad-85-6720c3630b81
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 89.AA.19654.263C0276; Tue, 29
	Oct 2024 11:13:38 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20241029111337eusmtip2d214be32623164fab86ba830518326f7~C6BzHyyJB2796727967eusmtip2s;
	Tue, 29 Oct 2024 11:13:37 +0000 (GMT)
Message-ID: <ca16370e-d646-4eee-b9cc-87277c89c43c@samsung.com>
Date: Tue, 29 Oct 2024 12:13:35 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 3/3] block: model freeze & enter queue as lock for
 supporting lockdep
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>, Peter Zijlstra <peterz@infradead.org>,
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, Ingo
	Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20241025003722.3630252-4-ming.lei@redhat.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBKsWRmVeSWpSXmKPExsWy7djPc7rJhxXSDTZ8kLFYfbefzWLNlkYm
	i2kffjJbrFx9lMli7y1ti8u75rBZnD52gsXi0ORmJotLBxYwWRzvPcBk0XLH1IHb4/IVb4+d
	s+6ye2xeoeVx+Wypx6ZVnWweu282sHm833eVzePzJrkAjigum5TUnMyy1CJ9uwSujI2X57EX
	LK+rWLT5GXsD45G8LkZODgkBE4kf8x6ygthCAisYJU6150LYXxgl5pzShLA/M0pc6nPoYuQA
	q3/zkqmLkQsovJxRov3TdnYI5yOjxNN7T5lAGngF7CSeL1zHCGKzCKhKLOw4zQIRF5Q4OfMJ
	mC0qIC9x/9YMdhBbWCBO4mP7C1aQBSIC8RKXDtWCzGQWmM4kMX/GHLA5zALiEreezAebzyZg
	KNH1tosNxOYUsJZ4f3cXC0SNvETz1tnMIM0SAv2cEjNevmaBuNpF4uwNNoiHhSVeHd/CDmHL
	SJye3MMCUd/OKLHg930mCGcCo0TD81uMEFXWEnfO/WIDGcQsoCmxfpc+RNhRonn2dmaI+XwS
	N94KQtzAJzFp23SoMK9ER5sQRLWaxKzj6+DWHrxwiXkCo9IspFCZheTLWUi+mYWwdwEjyypG
	8dTS4tz01GLjvNRyveLE3OLSvHS95PzcTYzAxHX63/GvOxhXvPqod4iRiYPxEKMEB7OSCO/q
	WNl0Id6UxMqq1KL8+KLSnNTiQ4zSHCxK4ryqKfKpQgLpiSWp2ampBalFMFkmDk6pBqYFe2Ms
	fi3ifHctXnzpxViNRfdE+F+qbzzy7NzfO+8stnE06f86Zbvo+my/rpdT7un/lv+17eLKsLlN
	hzN3crE5qcfvembPE9EgnzDzy6eCVJmNdRv/f3Hybqra431uwuT8fZffTzZrSr8+MfyJXzHz
	6TNnVT61VrtVuXznyd/qtH2HJN+JHIeHjbN3NvgXatTfXNMWmy+9YfqNqzuFeU69Xm/X/KHH
	/3RbkC5L3RROB6dF1teYC/lqVkyVzr0e6WGRlz9n0s/rdYda5207qPo/YmPTq0izeuHrD6bG
	vd1o5ZFSL9FyXK7i8N7l+/sjpv2fMVvlgLyT4ynWK3nHXi3I7q04xcxpb+i6tDZiuyu7Ektx
	RqKhFnNRcSIAWD814ssDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHIsWRmVeSWpSXmKPExsVy+t/xe7pJhxXSDXY/U7FYfbefzWLNlkYm
	i2kffjJbrFx9lMli7y1ti8u75rBZnD52gsXi0ORmJotLBxYwWRzvPcBk0XLH1IHb4/IVb4+d
	s+6ye2xeoeVx+Wypx6ZVnWweu282sHm833eVzePzJrkAjig9m6L80pJUhYz84hJbpWhDCyM9
	Q0sLPSMTSz1DY/NYKyNTJX07m5TUnMyy1CJ9uwS9jI2X57EXLK+rWLT5GXsD45G8LkYODgkB
	E4k3L5m6GLk4hASWMkrs+3mWtYuREyguI3FyWgOULSzx51oXG0TRe0aJL5unsYEkeAXsJJ4v
	XMcIYrMIqEos7DjNAhEXlDg58wmYLSogL3H/1gx2EFtYIE7iY/sLsKEiAvESHQc3soAMZRaY
	ziTR8OMn2CAhgWyJ89v+MYPYzALiEreezGcCsdkEDCW63naBLeYUsJZ4f3cXC0SNmUTX1i5G
	CFteonnrbOYJjEKzkNwxC8moWUhaZiFpWcDIsopRJLW0ODc9t9hIrzgxt7g0L10vOT93EyMw
	Yrcd+7llB+PKVx/1DjEycTAeYpTgYFYS4V0dK5suxJuSWFmVWpQfX1Sak1p8iNEUGBgTmaVE
	k/OBKSOvJN7QzMDU0MTM0sDU0sxYSZyX7cr5NCGB9MSS1OzU1ILUIpg+Jg5OqQamNe838JYo
	Hd7oq9vk7/rF6nRf9/qeueqzo5omsmWXMVRq9f8oXflRZfXNvDyHbRwaEUZOBpOFarx70ptN
	HhyYoViSZOx3ZKcK46JfXcrGjjOaX9mUHN0Zuma7uclL+WTvrFmneaYlRBZEJ76KvDvP+4TW
	A/laAbnaGTbaRppcqlKeP84XXX1TzXXlT5D45n9HPTbPrFt873FczTlNVzG/gqnXpGLlLVac
	LNqx04HpdW3OwjKRD+aiGamRpneTJiieyZmieVd3x+K6GfOulO4RD9g8xTvGseuDsCx3btFf
	90X6kxRr/pepzri6aL0U92yHOWsrQvz3LF7AsnPmVJO4qJl7Fq9V4nBuOzUpS0CJpTgj0VCL
	uag4EQCNdnKTYQMAAA==
X-CMS-MailID: 20241029111338eucas1p2bd56c697b825eef235604e892569207e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20241029111338eucas1p2bd56c697b825eef235604e892569207e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20241029111338eucas1p2bd56c697b825eef235604e892569207e
References: <20241025003722.3630252-1-ming.lei@redhat.com>
	<20241025003722.3630252-4-ming.lei@redhat.com>
	<CGME20241029111338eucas1p2bd56c697b825eef235604e892569207e@eucas1p2.samsung.com>

On 25.10.2024 02:37, Ming Lei wrote:
> Recently we got several deadlock report[1][2][3] caused by
> blk_mq_freeze_queue and blk_enter_queue().
>
> Turns out the two are just like acquiring read/write lock, so model them
> as read/write lock for supporting lockdep:
>
> 1) model q->q_usage_counter as two locks(io and queue lock)
>
> - queue lock covers sync with blk_enter_queue()
>
> - io lock covers sync with bio_enter_queue()
>
> 2) make the lockdep class/key as per-queue:
>
> - different subsystem has very different lock use pattern, shared lock
>   class causes false positive easily
>
> - freeze_queue degrades to no lock in case that disk state becomes DEAD
>    because bio_enter_queue() won't be blocked any more
>
> - freeze_queue degrades to no lock in case that request queue becomes dying
>    because blk_enter_queue() won't be blocked any more
>
> 3) model blk_mq_freeze_queue() as acquire_exclusive & try_lock
> - it is exclusive lock, so dependency with blk_enter_queue() is covered
>
> - it is trylock because blk_mq_freeze_queue() are allowed to run
>    concurrently
>
> 4) model blk_enter_queue() & bio_enter_queue() as acquire_read()
> - nested blk_enter_queue() are allowed
>
> - dependency with blk_mq_freeze_queue() is covered
>
> - blk_queue_exit() is often called from other contexts(such as irq), and
> it can't be annotated as lock_release(), so simply do it in
> blk_enter_queue(), this way still covered cases as many as possible
>
> With lockdep support, such kind of reports may be reported asap and
> needn't wait until the real deadlock is triggered.
>
> For example, lockdep report can be triggered in the report[3] with this
> patch applied.
>
> [1] occasional block layer hang when setting 'echo noop > /sys/block/sda/queue/scheduler'
> https://bugzilla.kernel.org/show_bug.cgi?id=219166
>
> [2] del_gendisk() vs blk_queue_enter() race condition
> https://lore.kernel.org/linux-block/20241003085610.GK11458@google.com/
>
> [3] queue_freeze & queue_enter deadlock in scsi
> https://lore.kernel.org/linux-block/ZxG38G9BuFdBpBHZ@fedora/T/#u
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

This patch landed yesterday in linux-next as commit f1be1788a32e 
("block: model freeze & enter queue as lock for supporting lockdep").  
In my tests I found that it introduces the following 2 lockdep warnings:

1. On Samsung Exynos 4412-based Odroid U3 board (ARM 32bit), observed 
when booting it:

======================================================
WARNING: possible circular locking dependency detected
6.12.0-rc4-00037-gf1be1788a32e #9290 Not tainted
------------------------------------------------------
find/1284 is trying to acquire lock:
cf3b8534 (&mm->mmap_lock){++++}-{3:3}, at: __might_fault+0x30/0x70

but task is already holding lock:
c203a0c8 (&sb->s_type->i_mutex_key#2){++++}-{3:3}, at: 
iterate_dir+0x30/0x140

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #4 (&sb->s_type->i_mutex_key#2){++++}-{3:3}:
        down_write+0x44/0xc4
        start_creating+0x8c/0x170
        debugfs_create_dir+0x1c/0x178
        blk_register_queue+0xa0/0x1c0
        add_disk_fwnode+0x210/0x434
        brd_alloc+0x1cc/0x210
        brd_init+0xac/0x104
        do_one_initcall+0x64/0x30c
        kernel_init_freeable+0x1c4/0x228
        kernel_init+0x1c/0x12c
        ret_from_fork+0x14/0x28

-> #3 (&q->debugfs_mutex){+.+.}-{3:3}:
        __mutex_lock+0x94/0x94c
        mutex_lock_nested+0x1c/0x24
        blk_mq_init_sched+0x140/0x204
        elevator_init_mq+0xb8/0x130
        add_disk_fwnode+0x3c/0x434
        mmc_blk_alloc_req+0x34c/0x464
        mmc_blk_probe+0x1f4/0x6f8
        really_probe+0xe0/0x3d8
        __driver_probe_device+0x9c/0x1e4
        driver_probe_device+0x30/0xc0
        __device_attach_driver+0xa8/0x120
        bus_for_each_drv+0x80/0xcc
        __device_attach+0xac/0x1fc
        bus_probe_device+0x8c/0x90
        device_add+0x5a4/0x7cc
        mmc_add_card+0x118/0x2c8
        mmc_attach_mmc+0xd8/0x174
        mmc_rescan+0x2ec/0x3a8
        process_one_work+0x240/0x6d0
        worker_thread+0x1a0/0x398
        kthread+0x104/0x138
        ret_from_fork+0x14/0x28

-> #2 (&q->q_usage_counter(io)#17){++++}-{0:0}:
        blk_mq_submit_bio+0x8dc/0xb34
        __submit_bio+0x78/0x148
        submit_bio_noacct_nocheck+0x204/0x32c
        ext4_mpage_readpages+0x558/0x7b0
        read_pages+0x64/0x28c
        page_cache_ra_unbounded+0x118/0x1bc
        filemap_get_pages+0x124/0x7ec
        filemap_read+0x174/0x5b0
        __kernel_read+0x128/0x2c0
        bprm_execve+0x230/0x7a4
        kernel_execve+0xec/0x194
        try_to_run_init_process+0xc/0x38
        kernel_init+0xdc/0x12c
        ret_from_fork+0x14/0x28

-> #1 (mapping.invalidate_lock#2){++++}-{3:3}:
        down_read+0x44/0x224
        filemap_fault+0x648/0x10f0
        __do_fault+0x38/0xd4
        handle_mm_fault+0xaf8/0x14d0
        do_page_fault+0xe0/0x5c8
        do_DataAbort+0x3c/0xb0
        __dabt_svc+0x50/0x80
        __clear_user_std+0x34/0x68
        elf_load+0x1a8/0x208
        load_elf_binary+0x3f4/0x13cc
        bprm_execve+0x28c/0x7a4
        do_execveat_common+0x150/0x198
        sys_execve+0x30/0x38
        ret_fast_syscall+0x0/0x1c

-> #0 (&mm->mmap_lock){++++}-{3:3}:
        __lock_acquire+0x158c/0x2970
        lock_acquire+0x130/0x384
        __might_fault+0x50/0x70
        filldir64+0x94/0x28c
        dcache_readdir+0x174/0x260
        iterate_dir+0x64/0x140
        sys_getdents64+0x60/0x130
        ret_fast_syscall+0x0/0x1c

other info that might help us debug this:

Chain exists of:
   &mm->mmap_lock --> &q->debugfs_mutex --> &sb->s_type->i_mutex_key#2

  Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   rlock(&sb->s_type->i_mutex_key#2);
                                lock(&q->debugfs_mutex);
lock(&sb->s_type->i_mutex_key#2);
   rlock(&mm->mmap_lock);

  *** DEADLOCK ***

2 locks held by find/1284:
  #0: c3df1e88 (&f->f_pos_lock){+.+.}-{3:3}, at: fdget_pos+0x88/0xd0
  #1: c203a0c8 (&sb->s_type->i_mutex_key#2){++++}-{3:3}, at: 
iterate_dir+0x30/0x140

stack backtrace:
CPU: 1 UID: 0 PID: 1284 Comm: find Not tainted 
6.12.0-rc4-00037-gf1be1788a32e #9290
Hardware name: Samsung Exynos (Flattened Device Tree)
Call trace:
  unwind_backtrace from show_stack+0x10/0x14
  show_stack from dump_stack_lvl+0x68/0x88
  dump_stack_lvl from print_circular_bug+0x31c/0x394
  print_circular_bug from check_noncircular+0x16c/0x184
  check_noncircular from __lock_acquire+0x158c/0x2970
  __lock_acquire from lock_acquire+0x130/0x384
  lock_acquire from __might_fault+0x50/0x70
  __might_fault from filldir64+0x94/0x28c
  filldir64 from dcache_readdir+0x174/0x260
  dcache_readdir from iterate_dir+0x64/0x140
  iterate_dir from sys_getdents64+0x60/0x130
  sys_getdents64 from ret_fast_syscall+0x0/0x1c
Exception stack(0xf22b5fa8 to 0xf22b5ff0)
5fa0:                   004b4fa0 004b4f80 00000004 004b4fa0 00008000 
00000000
5fc0: 004b4fa0 004b4f80 00000001 000000d9 00000000 004b4af0 00000000 
000010ea
5fe0: 004b1eb4 bea05af0 b6da4b08 b6da4a28

--->8---


2. On QEMU's ARM64 virt machine, observed during system suspend/resume 
cycle:

# time rtcwake -s10 -mmem
rtcwake: wakeup from "mem" using /dev/rtc0 at Tue Oct 29 11:54:30 2024
PM: suspend entry (s2idle)
Filesystems sync: 0.004 seconds
Freezing user space processes
Freezing user space processes completed (elapsed 0.007 seconds)
OOM killer disabled.
Freezing remaining freezable tasks
Freezing remaining freezable tasks completed (elapsed 0.004 seconds)

======================================================
WARNING: possible circular locking dependency detected
6.12.0-rc4+ #9291 Not tainted
------------------------------------------------------
rtcwake/1299 is trying to acquire lock:
ffff80008358a7f8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock+0x1c/0x28

but task is already holding lock:
ffff000006136d68 (&q->q_usage_counter(io)#5){++++}-{0:0}, at: 
virtblk_freeze+0x24/0x60

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (&q->q_usage_counter(io)#5){++++}-{0:0}:
        blk_mq_submit_bio+0x7c0/0x9d8
        __submit_bio+0x74/0x164
        submit_bio_noacct_nocheck+0x2d4/0x3b4
        submit_bio_noacct+0x148/0x3fc
        submit_bio+0x130/0x204
        submit_bh_wbc+0x148/0x1bc
        submit_bh+0x18/0x24
        ext4_read_bh_nowait+0x70/0x100
        ext4_sb_breadahead_unmovable+0x50/0x80
        __ext4_get_inode_loc+0x354/0x654
        ext4_get_inode_loc+0x40/0xa8
        ext4_reserve_inode_write+0x40/0xf0
        __ext4_mark_inode_dirty+0x88/0x300
        ext4_ext_tree_init+0x40/0x4c
        __ext4_new_inode+0x99c/0x1614
        ext4_create+0xe4/0x1d4
        lookup_open.isra.0+0x47c/0x540
        path_openat+0x370/0x9e8
        do_filp_open+0x80/0x130
        do_sys_openat2+0xb4/0xe8
        __arm64_compat_sys_openat+0x5c/0xa4
        invoke_syscall+0x48/0x110
        el0_svc_common.constprop.0+0x40/0xe8
        do_el0_svc_compat+0x20/0x3c
        el0_svc_compat+0x44/0xe0
        el0t_32_sync_handler+0x98/0x148
        el0t_32_sync+0x194/0x198

-> #2 (jbd2_handle){++++}-{0:0}:
        start_this_handle+0x178/0x4e8
        jbd2__journal_start+0x110/0x298
        __ext4_journal_start_sb+0x9c/0x274
        ext4_dirty_inode+0x38/0x88
        __mark_inode_dirty+0x90/0x568
        generic_update_time+0x50/0x64
        touch_atime+0x2c0/0x324
        ext4_file_mmap+0x68/0x88
        mmap_region+0x448/0xa38
        do_mmap+0x3dc/0x540
        vm_mmap_pgoff+0xf8/0x1b4
        ksys_mmap_pgoff+0x148/0x1f0
        __arm64_compat_sys_aarch32_mmap2+0x20/0x2c
        invoke_syscall+0x48/0x110
        el0_svc_common.constprop.0+0x40/0xe8
        do_el0_svc_compat+0x20/0x3c
        el0_svc_compat+0x44/0xe0
        el0t_32_sync_handler+0x98/0x148
        el0t_32_sync+0x194/0x198

-> #1 (&mm->mmap_lock){++++}-{3:3}:
        __might_fault+0x5c/0x80
        inet_gifconf+0xcc/0x278
        dev_ifconf+0xc4/0x1f8
        sock_ioctl+0x234/0x384
        compat_sock_ioctl+0x180/0x35c
        __arm64_compat_sys_ioctl+0x14c/0x16c
        invoke_syscall+0x48/0x110
        el0_svc_common.constprop.0+0x40/0xe8
        do_el0_svc_compat+0x20/0x3c
        el0_svc_compat+0x44/0xe0
        el0t_32_sync_handler+0x98/0x148
        el0t_32_sync+0x194/0x198

-> #0 (rtnl_mutex){+.+.}-{3:3}:
        __lock_acquire+0x1374/0x2224
        lock_acquire+0x200/0x340
        __mutex_lock+0x98/0x428
        mutex_lock_nested+0x24/0x30
        rtnl_lock+0x1c/0x28
        virtnet_freeze_down.isra.0+0x20/0x9c
        virtnet_freeze+0x44/0x60
        virtio_device_freeze+0x68/0x94
        virtio_mmio_freeze+0x14/0x20
        platform_pm_suspend+0x2c/0x6c
        dpm_run_callback+0xa4/0x218
        device_suspend+0x12c/0x52c
        dpm_suspend+0x10c/0x2e4
        dpm_suspend_start+0x70/0x78
        suspend_devices_and_enter+0x130/0x798
        pm_suspend+0x1ac/0x2e8
        state_store+0x8c/0x110
        kobj_attr_store+0x18/0x2c
        sysfs_kf_write+0x4c/0x78
        kernfs_fop_write_iter+0x120/0x1b4
        vfs_write+0x2b0/0x35c
        ksys_write+0x68/0xf4
        __arm64_sys_write+0x1c/0x28
        invoke_syscall+0x48/0x110
        el0_svc_common.constprop.0+0x40/0xe8
        do_el0_svc_compat+0x20/0x3c
        el0_svc_compat+0x44/0xe0
        el0t_32_sync_handler+0x98/0x148
        el0t_32_sync+0x194/0x198

other info that might help us debug this:

Chain exists of:
   rtnl_mutex --> jbd2_handle --> &q->q_usage_counter(io)#5

  Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock(&q->q_usage_counter(io)#5);
                                lock(jbd2_handle);
lock(&q->q_usage_counter(io)#5);
   lock(rtnl_mutex);

  *** DEADLOCK ***

9 locks held by rtcwake/1299:
  #0: ffff0000069103f8 (sb_writers#7){.+.+}-{0:0}, at: vfs_write+0x1e4/0x35c
  #1: ffff000007c0ae88 (&of->mutex#2){+.+.}-{3:3}, at: 
kernfs_fop_write_iter+0xf0/0x1b4
  #2: ffff0000046906e8 (kn->active#24){.+.+}-{0:0}, at: 
kernfs_fop_write_iter+0xf8/0x1b4
  #3: ffff800082fd9908 (system_transition_mutex){+.+.}-{3:3}, at: 
pm_suspend+0x88/0x2e8
  #4: ffff000006137678 (&q->q_usage_counter(io)#6){++++}-{0:0}, at: 
virtblk_freeze+0x24/0x60
  #5: ffff0000061376b0 (&q->q_usage_counter(queue)#2){++++}-{0:0}, at: 
virtblk_freeze+0x24/0x60
  #6: ffff000006136d68 (&q->q_usage_counter(io)#5){++++}-{0:0}, at: 
virtblk_freeze+0x24/0x60
  #7: ffff000006136da0 (&q->q_usage_counter(queue)){++++}-{0:0}, at: 
virtblk_freeze+0x24/0x60
  #8: ffff0000056208f8 (&dev->mutex){....}-{3:3}, at: 
device_suspend+0xf8/0x52c

stack backtrace:
CPU: 0 UID: 0 PID: 1299 Comm: rtcwake Not tainted 6.12.0-rc4+ #9291
Hardware name: linux,dummy-virt (DT)
Call trace:
  dump_backtrace+0x94/0xec
  show_stack+0x18/0x24
  dump_stack_lvl+0x90/0xd0
  dump_stack+0x18/0x24
  print_circular_bug+0x298/0x37c
  check_noncircular+0x15c/0x170
  __lock_acquire+0x1374/0x2224
  lock_acquire+0x200/0x340
  __mutex_lock+0x98/0x428
  mutex_lock_nested+0x24/0x30
  rtnl_lock+0x1c/0x28
  virtnet_freeze_down.isra.0+0x20/0x9c
  virtnet_freeze+0x44/0x60
  virtio_device_freeze+0x68/0x94
  virtio_mmio_freeze+0x14/0x20
  platform_pm_suspend+0x2c/0x6c
  dpm_run_callback+0xa4/0x218
  device_suspend+0x12c/0x52c
  dpm_suspend+0x10c/0x2e4
  dpm_suspend_start+0x70/0x78
  suspend_devices_and_enter+0x130/0x798
  pm_suspend+0x1ac/0x2e8
  state_store+0x8c/0x110
  kobj_attr_store+0x18/0x2c
  sysfs_kf_write+0x4c/0x78
  kernfs_fop_write_iter+0x120/0x1b4
  vfs_write+0x2b0/0x35c
  ksys_write+0x68/0xf4
  __arm64_sys_write+0x1c/0x28
  invoke_syscall+0x48/0x110
  el0_svc_common.constprop.0+0x40/0xe8
  do_el0_svc_compat+0x20/0x3c
  el0_svc_compat+0x44/0xe0
  el0t_32_sync_handler+0x98/0x148
  el0t_32_sync+0x194/0x198
virtio_blk virtio2: 1/0/0 default/read/poll queues
virtio_blk virtio3: 1/0/0 default/read/poll queues
OOM killer enabled.
Restarting tasks ... done.
random: crng reseeded on system resumption
PM: suspend exit

--->8---

Let me know if You need more information about my test systems.

> ---
>   block/blk-core.c       | 18 ++++++++++++++++--
>   block/blk-mq.c         | 26 ++++++++++++++++++++++----
>   block/blk.h            | 29 ++++++++++++++++++++++++++---
>   block/genhd.c          | 15 +++++++++++----
>   include/linux/blkdev.h |  6 ++++++
>   5 files changed, 81 insertions(+), 13 deletions(-)

 > ...

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

