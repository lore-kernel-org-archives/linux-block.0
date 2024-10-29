Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC38119995A
	for <linux-block@vger.kernel.org>; Tue, 29 Oct 2024 16:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730221161; cv=none; b=jCF3lWTy0QJMdylb/kmiy3cGHGwP40dIEgEi2U43duz33MZJObjCuj68YYZV2JtZqUvzTbNzvBj7thg2VUXDe9Qwr8E6Hp7mcT2xbr+rBqyf4K3KePfOmznFbfSgYlQRiYQOSYRK0fg9EP6+4vpHlnWDxlW2eesHVmlTMcaAzng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730221161; c=relaxed/simple;
	bh=p9OcOatV/shZSJ85jmqpN9GJn+erA0lcT0csTjrDl+E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=HJ/fSbUYM3LFnPXE0JaWySe3nE0KMPndo9Fih8p6Zuua/42646liEJYR8s2U7/6grjETffqfHCoqBSiOMvDEgzBF8s7tcf2I60GxTQJJPGOXod51Qy0+MFFSHmYI5Fd9lm37ognWHeoYj1QRTGxzgCLaglWf2Gn1Rtu0ZgMSOgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=dBuyKyJp; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="dBuyKyJp"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20241029165914euoutp0185d8834035bea5635a1b26a3aa93f78e~C_vkqPO-T1393813938euoutp01U
	for <linux-block@vger.kernel.org>; Tue, 29 Oct 2024 16:59:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20241029165914euoutp0185d8834035bea5635a1b26a3aa93f78e~C_vkqPO-T1393813938euoutp01U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1730221154;
	bh=L62/9kwiQtae4wfkI0cgzEOovOjqmCi7qbdFQKAki8A=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=dBuyKyJpN960dd+tmYqbBV5rKrM5CPeE9LDEmYeNrU7XHwPYxcSXMpkVvpU0DHTOX
	 czcghA9oy9nsbymwGSdEcfRUAx8m6QXRdZde5h/1shDYZ4x9tiQTm4qeG7KxRsP6Zj
	 i1HMlXMlJ30lMMBhmrf6eCJIRCk+329aRppUH3Dk=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20241029165914eucas1p1f3a707b39fe176566a86d5a70038c741~C_vkQ0jqx2825628256eucas1p1h;
	Tue, 29 Oct 2024 16:59:14 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 0F.F7.20397.26411276; Tue, 29
	Oct 2024 16:59:14 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20241029165914eucas1p279d2d34b29709b11e75384d1ea9f9b52~C_vj5kthl1882218822eucas1p2Q;
	Tue, 29 Oct 2024 16:59:14 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20241029165914eusmtrp137b5ad53ab2ef148f3a8056a4da9c4b1~C_vj5AnUj1295712957eusmtrp1i;
	Tue, 29 Oct 2024 16:59:14 +0000 (GMT)
X-AuditID: cbfec7f5-ed1d670000004fad-5f-672114621f15
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id AE.F2.19920.16411276; Tue, 29
	Oct 2024 16:59:14 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20241029165912eusmtip2c9e97104747012c5f2d439ba51fba11d~C_vifRCUQ0205302053eusmtip2y;
	Tue, 29 Oct 2024 16:59:12 +0000 (GMT)
Message-ID: <18ad815b-889c-45c4-812b-700f6a04dc18@samsung.com>
Date: Tue, 29 Oct 2024 17:59:11 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 3/3] block: model freeze & enter queue as lock for
 supporting lockdep
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, Christoph
	Hellwig <hch@lst.de>, Peter Zijlstra <peterz@infradead.org>, Waiman Long
	<longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar
	<mingo@redhat.com>, Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <ZyEGLdg744U_xBjp@fedora>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLKsWRmVeSWpSXmKPExsWy7djP87pJIorpBusuiVusvtvPZrFmSyOT
	xbQPP5ktVq4+ymSx95a2xeVdc9gsTh87wWJxaHIzk8WlAwuYLI73HmCyaLlj6sDtcfmKt8fO
	WXfZPTav0PK4fLbUY9OqTjaP3Tcb2Dze77vK5vF5k1wARxSXTUpqTmZZapG+XQJXxu9fh9kL
	9thVTD90nrmBcYFJFyMnh4SAicShmVeZuxi5OIQEVjBKLHj1hh3C+cIoceb1U1YI5zOjxP/z
	d9lgWi4d2gnVspxRYuXS98wgCSGBj4wSf15bgNi8AnYS195fZwSxWQRUJZp2bmaEiAtKnJz5
	hAXEFhWQl7h/awY7iC0sECfxsf0FK4gtIqAkcffuarAzmAWuMElsuriSCSTBLCAucevJfDCb
	TcBQouttF9hFnAJqEu8XrmGBqJGXaN46G+w6CYF+Tom5m84wQZztIvHzzhZ2CFtY4tVxGFtG
	4vTkHhaIhnZgCPy+zwThTGCUaHh+ixGiylrizrlfQOs4gFZoSqzfpQ8RdpRonr2dGSQsIcAn
	ceOtIMQRfBKTtk2HCvNKdLQJQVSrScw6vg5u7cELl5gnMCrNQgqXWUjenIXknVkIexcwsqxi
	FE8tLc5NTy02zkst1ytOzC0uzUvXS87P3cQITGGn/x3/uoNxxauPeocYmTgYDzFKcDArifCu
	jpVNF+JNSaysSi3Kjy8qzUktPsQozcGiJM6rmiKfKiSQnliSmp2aWpBaBJNl4uCUamAS3Nlr
	8c03NbfTc8e5oPLdMyJ5VDqXyHsfbd29/WN/3OOABXJPK3/GLnjx8PC0h7K/LgTY5bN6xcSW
	CIYFn2TKvbzm9pfr9dOT3mvsXuL6bsnjF425Z4Svq8RE833ctFywVG2Bm0iJ3ONC8xXTF6xf
	vz22wZ9LfKackqHjiaD9j+awnbtddWMyL0vD/L0qa5gvc0xjForjVLtnpbN8jbTsi86DLlKT
	l18ylr/cM6Fq8Zzp7R+nzBe9uorj9k6Xm43H53Vx7Pia+auyiq3/ecrvX+G77nzMyQn149T3
	YJrvILiR17KV6b+fsgdz54lNSd2J3WlHbB+wsp6LXs2osVH5lqp/9X77F1//fZ1WqqOoxFKc
	kWioxVxUnAgAa4aqONADAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHIsWRmVeSWpSXmKPExsVy+t/xe7pJIorpBnv+MVqsvtvPZrFmSyOT
	xbQPP5ktVq4+ymSx95a2xeVdc9gsTh87wWJxaHIzk8WlAwuYLI73HmCyaLlj6sDtcfmKt8fO
	WXfZPTav0PK4fLbUY9OqTjaP3Tcb2Dze77vK5vF5k1wAR5SeTVF+aUmqQkZ+cYmtUrShhZGe
	oaWFnpGJpZ6hsXmslZGpkr6dTUpqTmZZapG+XYJexu9fh9kL9thVTD90nrmBcYFJFyMnh4SA
	icSlQzuZQWwhgaWMEnNe+ELEZSROTmtghbCFJf5c62LrYuQCqnnPKLG44Qk7SIJXwE7i2vvr
	jCA2i4CqRNPOzYwQcUGJkzOfsIDYogLyEvdvzQCrFxaIk/jY/gJsqIiAksTdu6vZQYYyC1xh
	kjhzaxk7xBV9TBLf9laB2MwC4hK3nsxnArHZBAwlut6CXMHJwSmgJvF+4RoWiBozia6tXYwQ
	trxE89bZzBMYhWYhuWMWklGzkLTMQtKygJFlFaNIamlxbnpusaFecWJucWleul5yfu4mRmDE
	bjv2c/MOxnmvPuodYmTiYDzEKMHBrCTCuzpWNl2INyWxsiq1KD++qDQntfgQoykwMCYyS4km
	5wNTRl5JvKGZgamhiZmlgamlmbGSOK/b5fNpQgLpiSWp2ampBalFMH1MHJxSDUziiRadMnm6
	8x8pTlM+2ls6KUogKyfioL/cu8/fL01T2nSlS2nmrhtLd03X3Paz3SvBOngiT+bNvSsvfhTv
	FGzba+/+b/X67tcxVX+bD6b7XyioC9DccsNiTpdt1bbEHzIBvRsPnC1q0tfd/bJjX/zkk8k2
	HicmJq9nePyCbdEG/8dPFyzP8H9fIczJ/diX1Xix92cBDo39hWd6/fuMuns89W/0GK25eZ7d
	9B8vD3vQt/07t0u6f437OONS9iPnc11Bek4qr387aL/mKOJf927CfLvcOXw+a64EO7/hXfqR
	2Tli6bPLG+UFtzq7ts6cOj/Lc+ZCPfGZryS3zklmE/r8VvzjhS9XhTVFGcq3J/1SYinOSDTU
	Yi4qTgQAjNAPpmEDAAA=
X-CMS-MailID: 20241029165914eucas1p279d2d34b29709b11e75384d1ea9f9b52
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20241029111338eucas1p2bd56c697b825eef235604e892569207e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20241029111338eucas1p2bd56c697b825eef235604e892569207e
References: <20241025003722.3630252-1-ming.lei@redhat.com>
	<20241025003722.3630252-4-ming.lei@redhat.com>
	<CGME20241029111338eucas1p2bd56c697b825eef235604e892569207e@eucas1p2.samsung.com>
	<ca16370e-d646-4eee-b9cc-87277c89c43c@samsung.com> <ZyEGLdg744U_xBjp@fedora>

On 29.10.2024 16:58, Ming Lei wrote:
> On Tue, Oct 29, 2024 at 12:13:35PM +0100, Marek Szyprowski wrote:
>> On 25.10.2024 02:37, Ming Lei wrote:
>>> Recently we got several deadlock report[1][2][3] caused by
>>> blk_mq_freeze_queue and blk_enter_queue().
>>>
>>> Turns out the two are just like acquiring read/write lock, so model them
>>> as read/write lock for supporting lockdep:
>>>
>>> 1) model q->q_usage_counter as two locks(io and queue lock)
>>>
>>> - queue lock covers sync with blk_enter_queue()
>>>
>>> - io lock covers sync with bio_enter_queue()
>>>
>>> 2) make the lockdep class/key as per-queue:
>>>
>>> - different subsystem has very different lock use pattern, shared lock
>>>    class causes false positive easily
>>>
>>> - freeze_queue degrades to no lock in case that disk state becomes DEAD
>>>     because bio_enter_queue() won't be blocked any more
>>>
>>> - freeze_queue degrades to no lock in case that request queue becomes dying
>>>     because blk_enter_queue() won't be blocked any more
>>>
>>> 3) model blk_mq_freeze_queue() as acquire_exclusive & try_lock
>>> - it is exclusive lock, so dependency with blk_enter_queue() is covered
>>>
>>> - it is trylock because blk_mq_freeze_queue() are allowed to run
>>>     concurrently
>>>
>>> 4) model blk_enter_queue() & bio_enter_queue() as acquire_read()
>>> - nested blk_enter_queue() are allowed
>>>
>>> - dependency with blk_mq_freeze_queue() is covered
>>>
>>> - blk_queue_exit() is often called from other contexts(such as irq), and
>>> it can't be annotated as lock_release(), so simply do it in
>>> blk_enter_queue(), this way still covered cases as many as possible
>>>
>>> With lockdep support, such kind of reports may be reported asap and
>>> needn't wait until the real deadlock is triggered.
>>>
>>> For example, lockdep report can be triggered in the report[3] with this
>>> patch applied.
>>>
>>> [1] occasional block layer hang when setting 'echo noop > /sys/block/sda/queue/scheduler'
>>> https://bugzilla.kernel.org/show_bug.cgi?id=219166
>>>
>>> [2] del_gendisk() vs blk_queue_enter() race condition
>>> https://lore.kernel.org/linux-block/20241003085610.GK11458@google.com/
>>>
>>> [3] queue_freeze & queue_enter deadlock in scsi
>>> https://lore.kernel.org/linux-block/ZxG38G9BuFdBpBHZ@fedora/T/#u
>>>
>>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>>> Signed-off-by: Ming Lei <ming.lei@redhat.com>
>> This patch landed yesterday in linux-next as commit f1be1788a32e
>> ("block: model freeze & enter queue as lock for supporting lockdep").
>> In my tests I found that it introduces the following 2 lockdep warnings:
>>
>> 1. On Samsung Exynos 4412-based Odroid U3 board (ARM 32bit), observed
>> when booting it:
>>
>> ======================================================
>> WARNING: possible circular locking dependency detected
>> 6.12.0-rc4-00037-gf1be1788a32e #9290 Not tainted
>> ------------------------------------------------------
>> find/1284 is trying to acquire lock:
>> cf3b8534 (&mm->mmap_lock){++++}-{3:3}, at: __might_fault+0x30/0x70
>>
>> but task is already holding lock:
>> c203a0c8 (&sb->s_type->i_mutex_key#2){++++}-{3:3}, at:
>> iterate_dir+0x30/0x140
>>
>> which lock already depends on the new lock.
>>
>>
>> the existing dependency chain (in reverse order) is:
>>
>> -> #4 (&sb->s_type->i_mutex_key#2){++++}-{3:3}:
>>          down_write+0x44/0xc4
>>          start_creating+0x8c/0x170
>>          debugfs_create_dir+0x1c/0x178
>>          blk_register_queue+0xa0/0x1c0
>>          add_disk_fwnode+0x210/0x434
>>          brd_alloc+0x1cc/0x210
>>          brd_init+0xac/0x104
>>          do_one_initcall+0x64/0x30c
>>          kernel_init_freeable+0x1c4/0x228
>>          kernel_init+0x1c/0x12c
>>          ret_from_fork+0x14/0x28
>>
>> -> #3 (&q->debugfs_mutex){+.+.}-{3:3}:
>>          __mutex_lock+0x94/0x94c
>>          mutex_lock_nested+0x1c/0x24
>>          blk_mq_init_sched+0x140/0x204
>>          elevator_init_mq+0xb8/0x130
>>          add_disk_fwnode+0x3c/0x434
> The above chain can be cut by the following patch because disk state
> can be thought as DEAD in add_disk(), can you test it?

Seems to be fixing this issue. Feel free to add:

Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>


> diff --git a/block/elevator.c b/block/elevator.c
> index 4122026b11f1..efa6ff941a25 100644
> --- a/block/elevator.c
> +++ b/block/elevator.c
> @@ -600,12 +600,14 @@ void elevator_init_mq(struct request_queue *q)
>   	 * requests, then no need to quiesce queue which may add long boot
>   	 * latency, especially when lots of disks are involved.
>   	 */
> -	blk_mq_freeze_queue(q);
> +	if (__blk_freeze_queue_start(q))
> +		blk_freeze_acquire_lock(q, true, false);
>   	blk_mq_cancel_work_sync(q);
>   
>   	err = blk_mq_init_sched(q, e);
>   
> -	blk_mq_unfreeze_queue(q);
> +	if (__blk_mq_unfreeze_queue(q, false))
> +		blk_unfreeze_release_lock(q, true, false);
>   
>   	if (err) {
>   		pr_warn("\"%s\" elevator initialization failed, "
>
> ...
>
>> 2 locks held by find/1284:
>>    #0: c3df1e88 (&f->f_pos_lock){+.+.}-{3:3}, at: fdget_pos+0x88/0xd0
>>    #1: c203a0c8 (&sb->s_type->i_mutex_key#2){++++}-{3:3}, at:
>> iterate_dir+0x30/0x140
>>
>> stack backtrace:
>> CPU: 1 UID: 0 PID: 1284 Comm: find Not tainted
>> 6.12.0-rc4-00037-gf1be1788a32e #9290
>> Hardware name: Samsung Exynos (Flattened Device Tree)
>> Call trace:
>>    unwind_backtrace from show_stack+0x10/0x14
>>    show_stack from dump_stack_lvl+0x68/0x88
>>    dump_stack_lvl from print_circular_bug+0x31c/0x394
>>    print_circular_bug from check_noncircular+0x16c/0x184
>>    check_noncircular from __lock_acquire+0x158c/0x2970
>>    __lock_acquire from lock_acquire+0x130/0x384
>>    lock_acquire from __might_fault+0x50/0x70
>>    __might_fault from filldir64+0x94/0x28c
>>    filldir64 from dcache_readdir+0x174/0x260
>>    dcache_readdir from iterate_dir+0x64/0x140
>>    iterate_dir from sys_getdents64+0x60/0x130
>>    sys_getdents64 from ret_fast_syscall+0x0/0x1c
>> Exception stack(0xf22b5fa8 to 0xf22b5ff0)
>> 5fa0:                   004b4fa0 004b4f80 00000004 004b4fa0 00008000
>> 00000000
>> 5fc0: 004b4fa0 004b4f80 00000001 000000d9 00000000 004b4af0 00000000
>> 000010ea
>> 5fe0: 004b1eb4 bea05af0 b6da4b08 b6da4a28
>>
>> --->8---
>>
>>
>> 2. On QEMU's ARM64 virt machine, observed during system suspend/resume
>> cycle:
>>
>> # time rtcwake -s10 -mmem
>> rtcwake: wakeup from "mem" using /dev/rtc0 at Tue Oct 29 11:54:30 2024
>> PM: suspend entry (s2idle)
>> Filesystems sync: 0.004 seconds
>> Freezing user space processes
>> Freezing user space processes completed (elapsed 0.007 seconds)
>> OOM killer disabled.
>> Freezing remaining freezable tasks
>> Freezing remaining freezable tasks completed (elapsed 0.004 seconds)
>>
>> ======================================================
>> WARNING: possible circular locking dependency detected
>> 6.12.0-rc4+ #9291 Not tainted
>> ------------------------------------------------------
>> rtcwake/1299 is trying to acquire lock:
>> ffff80008358a7f8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock+0x1c/0x28
>>
>> but task is already holding lock:
>> ffff000006136d68 (&q->q_usage_counter(io)#5){++++}-{0:0}, at:
>> virtblk_freeze+0x24/0x60
>>
>> which lock already depends on the new lock.
>>
>>
>> the existing dependency chain (in reverse order) is:
> This one looks a real thing, at least the added lockdep code works as
> expected, also the blk_mq_freeze_queue() use in virtio-blk's ->suspend()
> is questionable. I will take a further look.
>
>
> Thanks,
> Ming
>
>
Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

