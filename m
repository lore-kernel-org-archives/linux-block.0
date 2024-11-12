Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C29230989
	for <linux-block@vger.kernel.org>; Tue, 12 Nov 2024 11:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731411162; cv=none; b=lDJpDJBiEBP8zWL08UkavHy9dUM/ZXwLJPR/LKukp0mxj1joAugLQfqGxpmzmQTt9vzkdNCs+9Xvhr423sOEpaTq4gofut3Y/ipMOEcbkewjAc9c3ymG7oH8Ep0kPfIEYy1lyEKkWcNFXOUiFd5zHavYfLVM+sIZRSmgCjSF35I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731411162; c=relaxed/simple;
	bh=i3J2WW52Q5vHUFYlMrykWBSAcaKWLZjOqC0wLaKxXwU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=dHvZXu1QTczX/QprsiPDxavaYV4MD27Y7wfQkXNsBgjUrAmHQnpuYupBx8xU0thXxZgrxw2TiP/4ZI4oD+tiyfpZOyHQ551/hWKOy7eO6YAL21gjKxc2DnN9rLnwHQJzytu0KQz8s3QoRU4ScP8yQW8cT51h+uoNM7XkpqAuDVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=jVnvwSBE; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="jVnvwSBE"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20241112113231euoutp02a478df7f330ed28c4e6f552d688e3b37~HNUTyG9M82010820108euoutp02R
	for <linux-block@vger.kernel.org>; Tue, 12 Nov 2024 11:32:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20241112113231euoutp02a478df7f330ed28c4e6f552d688e3b37~HNUTyG9M82010820108euoutp02R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1731411152;
	bh=aps9zg/Y097qXkqoLuGlXw+XF3k4ZzImEUVkm6bX5W0=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=jVnvwSBE7B1JzpBtGlyfGs+4rYiGp/4mIbJlbJ1iR3nsfPIdTleVLtwYlt7P9V2IT
	 JXkm5T2P6IJA8XSLC4J/HoW1u6FoelAO7QHBi/8qB9AFRKeiIDZazrztKgQgemqZEo
	 LuHak873A4j3yXtlzLEQhF+74FTtON7UMFy4mndM=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20241112113231eucas1p20ec1d7b5f44c4c1220622a65f28e28d0~HNUTgQRp60030200302eucas1p28;
	Tue, 12 Nov 2024 11:32:31 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 40.99.20397.FCC33376; Tue, 12
	Nov 2024 11:32:31 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20241112113231eucas1p2d0b9e74abd4f0e6bac730c982619cd7f~HNUTIRtff0030200302eucas1p27;
	Tue, 12 Nov 2024 11:32:31 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20241112113231eusmtrp1564f7a5b533f385128d116ed63fb63eb~HNUTHgHTq2747627476eusmtrp1D;
	Tue, 12 Nov 2024 11:32:31 +0000 (GMT)
X-AuditID: cbfec7f5-e59c770000004fad-64-67333ccfb0c6
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 44.A3.19654.FCC33376; Tue, 12
	Nov 2024 11:32:31 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20241112113230eusmtip2684a5deb2ffe509a9cf9d6ee403b016b~HNUSGlYe01324513245eusmtip2U;
	Tue, 12 Nov 2024 11:32:30 +0000 (GMT)
Message-ID: <d86a4cfc-ea64-4d95-af6a-186c02d2a162@samsung.com>
Date: Tue, 12 Nov 2024 12:32:29 +0100
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
In-Reply-To: <ZzMqsmCVwfSHC7Vb@fedora>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLKsWRmVeSWpSXmKPExsWy7djP87rnbYzTDaZ3KlusvtvPZrFmSyOT
	xbQPP5ktVq4+ymSx95a2xeVdc9gsTh87wWJxaHIzk8WlAwuYLI73HmCyaLlj6sDtcfmKt8fO
	WXfZPTav0PK4fLbUY9OqTjaP3Tcb2Dze77vK5vF5k1wARxSXTUpqTmZZapG+XQJXxoSXr9kL
	DulVzJo5n7mB8bxaFyMnh4SAicTFu3uZuhi5OIQEVjBKvD7QzAbhfGGUONdyiA2kSkjgM6PE
	jE/mMB2Hvr2GKlrOKHFh7mqo9o+MEq3X3rCDVPEK2EnsWX6fCcRmEVCVmHnsPRNEXFDi5Mwn
	LCC2qIC8xP1bM8DqhQXiJD62v2AFsUUElCTu3l3NDjKUWeAKk8SmiyvBmpkFxCVuPZkPZrMJ
	GEp0ve0CO49TQE1iy/6z7BA18hLb385hBmmWEOjmlNi9sJ0d4m4Xia13t7FB2MISr45vgYrL
	SJye3MMC0dDOKLHg930mCGcCo0TD81uMEFXWEnfO/QLq5gBaoSmxfpc+RNhRonn2dmaQsIQA
	n8SNt4IQR/BJTNo2HSrMK9HRJgRRrSYx6/g6uLUHL1xinsCoNAspXGYheXMWkndmIexdwMiy
	ilE8tbQ4Nz212DgvtVyvODG3uDQvXS85P3cTIzCFnf53/OsOxhWvPuodYmTiYDzEKMHBrCTC
	q+Gvny7Em5JYWZValB9fVJqTWnyIUZqDRUmcVzVFPlVIID2xJDU7NbUgtQgmy8TBKdXA1H93
	m9kTzTmrQ7XCLjxbsUpkd/gUcbMzc9b29bIESIp3izf+e3rlwefMozJ7Sn5Zypsu/BRsbDP/
	92WpTdpOVkV3bly7eqjwwusEoy23f+9yXJB3ysx7Xz/Ta973NzeybNRPtJ3nIJoaUHJzGtOi
	5/rLXL9rdroZ3T0Yd2PZFI3UfkFBRYGK8mPM0/2Ea9TOil97y72yun7Tislb52gV52nd/5uo
	GZN488A2viJ/q6g3FrP0xWcsfM+rcXH/vj0umyZrPYhWUDBWPbBEZnnDsshNlxKftR2pibqs
	MMUyrKizafsHi1u2C7wulQm6V/aqNF0NimFbIFQwe4vtL7F2psWLHxw99untLvU/6eU9OUos
	xRmJhlrMRcWJAIBGEn3QAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAIsWRmVeSWpSXmKPExsVy+t/xe7rnbYzTDRYc47ZYfbefzWLNlkYm
	i2kffjJbrFx9lMli7y1ti8u75rBZnD52gsXi0ORmJotLBxYwWRzvPcBk0XLH1IHb4/IVb4+d
	s+6ye2xeoeVx+Wypx6ZVnWweu282sHm833eVzePzJrkAjig9m6L80pJUhYz84hJbpWhDCyM9
	Q0sLPSMTSz1DY/NYKyNTJX07m5TUnMyy1CJ9uwS9jAkvX7MXHNKrmDVzPnMD43m1LkZODgkB
	E4lD316zdTFycQgJLGWUWLtkBTNEQkbi5LQGVghbWOLPtS6ooveMEtNvfGADSfAK2EnsWX6f
	CcRmEVCVmHnsPRNEXFDi5MwnLCC2qIC8xP1bM9hBbGGBOImP7S/AhooIKEncvbuaHWQos8AV
	Jokzt5axQ2y4yyTx6foDsA3MAuISt57MB5vKJmAo0fW2CyzOKaAmsWX/WXaIGjOJrq1djBC2
	vMT2t3OYJzAKzUJyyCwko2YhaZmFpGUBI8sqRpHU0uLc9NxiI73ixNzi0rx0veT83E2MwKjd
	duznlh2MK1991DvEyMTBeIhRgoNZSYRXw18/XYg3JbGyKrUoP76oNCe1+BCjKTA0JjJLiSbn
	A9NGXkm8oZmBqaGJmaWBqaWZsZI4L9uV82lCAumJJanZqakFqUUwfUwcnFINTFEPXV5vuH1+
	68Ern+NVrBrDgm+dEkopLLMwcFJa+e5gg0TobwtXSekI/xCmoA/Ty87O2VomfC+1fJEJ5xzG
	NI4OrSzvV5ek9C5lfnh3dvqODKWXP3yW/FD5tGr3BKsLlgeSaq62/rx1+DmD/ApFs0Xz5HWD
	fHmFbSevrPRL1WCSNjvwJT3p1aUHMWkr5196vy2cqWryW/fklHTRQkuG9auFN4h9Ep2lob2n
	pCLHlyW0sWOGyeqqiENqpTYBn71vZ26rKTi9Um4RU0panfN9cZulb3NmCRvarwhITE/bIX57
	e4v+Moc5j/sjd1xgu2u/9FXAusNn+XnW7r48YfmVGW7CqTxtQT+77975GnOyUomlOCPRUIu5
	qDgRAO2UxxFjAwAA
X-CMS-MailID: 20241112113231eucas1p2d0b9e74abd4f0e6bac730c982619cd7f
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
	<6551c33f-b9e1-45ab-b420-d022d6e4e402@samsung.com> <ZzMqsmCVwfSHC7Vb@fedora>

On 12.11.2024 11:15, Ming Lei wrote:
> On Tue, Nov 12, 2024 at 09:36:40AM +0100, Marek Szyprowski wrote:
>> On 29.10.2024 16:58, Ming Lei wrote:
>>> On Tue, Oct 29, 2024 at 12:13:35PM +0100, Marek Szyprowski wrote:
>>>> On 25.10.2024 02:37, Ming Lei wrote:
>>>>> Recently we got several deadlock report[1][2][3] caused by
>>>>> blk_mq_freeze_queue and blk_enter_queue().
>>>>>
>>>>> Turns out the two are just like acquiring read/write lock, so model them
>>>>> as read/write lock for supporting lockdep:
>>>>>
>>>>> 1) model q->q_usage_counter as two locks(io and queue lock)
>>>>>
>>>>> - queue lock covers sync with blk_enter_queue()
>>>>>
>>>>> - io lock covers sync with bio_enter_queue()
>>>>>
>>>>> 2) make the lockdep class/key as per-queue:
>>>>>
>>>>> - different subsystem has very different lock use pattern, shared lock
>>>>>     class causes false positive easily
>>>>>
>>>>> - freeze_queue degrades to no lock in case that disk state becomes DEAD
>>>>>      because bio_enter_queue() won't be blocked any more
>>>>>
>>>>> - freeze_queue degrades to no lock in case that request queue becomes dying
>>>>>      because blk_enter_queue() won't be blocked any more
>>>>>
>>>>> 3) model blk_mq_freeze_queue() as acquire_exclusive & try_lock
>>>>> - it is exclusive lock, so dependency with blk_enter_queue() is covered
>>>>>
>>>>> - it is trylock because blk_mq_freeze_queue() are allowed to run
>>>>>      concurrently
>>>>>
>>>>> 4) model blk_enter_queue() & bio_enter_queue() as acquire_read()
>>>>> - nested blk_enter_queue() are allowed
>>>>>
>>>>> - dependency with blk_mq_freeze_queue() is covered
>>>>>
>>>>> - blk_queue_exit() is often called from other contexts(such as irq), and
>>>>> it can't be annotated as lock_release(), so simply do it in
>>>>> blk_enter_queue(), this way still covered cases as many as possible
>>>>>
>>>>> With lockdep support, such kind of reports may be reported asap and
>>>>> needn't wait until the real deadlock is triggered.
>>>>>
>>>>> For example, lockdep report can be triggered in the report[3] with this
>>>>> patch applied.
>>>>>
>>>>> [1] occasional block layer hang when setting 'echo noop > /sys/block/sda/queue/scheduler'
>>>>> https://bugzilla.kernel.org/show_bug.cgi?id=219166
>>>>>
>>>>> [2] del_gendisk() vs blk_queue_enter() race condition
>>>>> https://lore.kernel.org/linux-block/20241003085610.GK11458@google.com/
>>>>>
>>>>> [3] queue_freeze & queue_enter deadlock in scsi
>>>>> https://lore.kernel.org/linux-block/ZxG38G9BuFdBpBHZ@fedora/T/#u
>>>>>
>>>>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>>>>> Signed-off-by: Ming Lei <ming.lei@redhat.com>
>>>> This patch landed yesterday in linux-next as commit f1be1788a32e
>>>> ("block: model freeze & enter queue as lock for supporting lockdep").
>>>> In my tests I found that it introduces the following 2 lockdep warnings:
>>>>
>>>>> ...
>>>>
>>>> 2. On QEMU's ARM64 virt machine, observed during system suspend/resume
>>>> cycle:
>>>>
>>>> # time rtcwake -s10 -mmem
>>>> rtcwake: wakeup from "mem" using /dev/rtc0 at Tue Oct 29 11:54:30 2024
>>>> PM: suspend entry (s2idle)
>>>> Filesystems sync: 0.004 seconds
>>>> Freezing user space processes
>>>> Freezing user space processes completed (elapsed 0.007 seconds)
>>>> OOM killer disabled.
>>>> Freezing remaining freezable tasks
>>>> Freezing remaining freezable tasks completed (elapsed 0.004 seconds)
>>>>
>>>> ======================================================
>>>> WARNING: possible circular locking dependency detected
>>>> 6.12.0-rc4+ #9291 Not tainted
>>>> ------------------------------------------------------
>>>> rtcwake/1299 is trying to acquire lock:
>>>> ffff80008358a7f8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock+0x1c/0x28
>>>>
>>>> but task is already holding lock:
>>>> ffff000006136d68 (&q->q_usage_counter(io)#5){++++}-{0:0}, at:
>>>> virtblk_freeze+0x24/0x60
>>>>
>>>> which lock already depends on the new lock.
>>>>
>>>>
>>>> the existing dependency chain (in reverse order) is:
>>> This one looks a real thing, at least the added lockdep code works as
>>> expected, also the blk_mq_freeze_queue() use in virtio-blk's ->suspend()
>>> is questionable. I will take a further look.
>> Did you find a way to fix this one? I still observe such warnings in my
>> tests, even though your lockdep fixes are already merged to -next:
>> https://lore.kernel.org/all/20241031133723.303835-1-ming.lei@redhat.com/
> The lockdep fixes in ->next is just for making the added lockdep work
> correctly, and virtio-blk is another story.
>
> It might be fine to annotate it with blk_mq_freeze_queue_no_owner(),
> but it looks very fragile to call freeze queue in ->suspend(), and the lock
> is just kept as being grabbed in the whole suspend code path.
>
> Can you try the following patch?

Yes, this hides this lockdep warning, but imho it looks like a 
workaround, not a final fix.

Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>


> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 194417abc105..21488740eb15 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -1594,6 +1594,7 @@ static int virtblk_freeze(struct virtio_device *vdev)
>   
>   	/* Ensure no requests in virtqueues before deleting vqs. */
>   	blk_mq_freeze_queue(vblk->disk->queue);
> +	blk_mq_unfreeze_queue(vblk->disk->queue);
>   
>   	/* Ensure we don't receive any more interrupts */
>   	virtio_reset_device(vdev);
> @@ -1617,8 +1618,6 @@ static int virtblk_restore(struct virtio_device *vdev)
>   		return ret;
>   
>   	virtio_device_ready(vdev);
> -
> -	blk_mq_unfreeze_queue(vblk->disk->queue);
>   	return 0;
>   }
>   #endif
>
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

