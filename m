Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45866558B6
	for <linux-block@vger.kernel.org>; Mon, 26 Aug 2024 08:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724661356; cv=none; b=Q+cumpNBvxxkeEG/85cfhCZ9reeu0L9RcTnYnx1nOyHtWnik+G90lkvpq0ove4djqZLuEf8ROfr3dnW6I7fcKzyoIPAcNr98CSJdS6GReXhRW1r+XAxzQaNz7Cj7E2BwN8HaC+bgjO7d3HDQ9wwuGq05UXbkEduUFiaN+MGUZ6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724661356; c=relaxed/simple;
	bh=ASkUA2gyjsQc9oRS8REr46kHFwqkoT5Z7dP8U5l6How=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Q5AZ5SmyBD+dp8gS3VihR18f1Qp0oLlht9AOc4kjeTDkhWrSpdJ2FBlKoJe0aBkqUG0QL7J+68LBzkK0hIXcBML4AdvwRUbyL5najYsCQPlgF0vrJmyA9V103nkxM5GAqmuR4OMbUQyWe7AUTP9kO/4hyVkiGQjLynSsM0qSwZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WIcU3A9a; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WIcU3A9a"
Content-Type: text/plain;
	charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724661352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zYZBH0XywWgti9APWEcZS82Uqa8SY9jUUWio2WtUyEk=;
	b=WIcU3A9a+Fs6xRBDxl/2dkcSD/dLO36yPbPJQU6cUjH68jF3RJrD75oIjRHdV4IKZaotfn
	9Y8HP+37eSdw+je0jNV5DI65yQzMLHmbkUNxkku9pkj9y9WuYNw+KtbmkxBKytcu/jhIq9
	sw4aNXo6YTKpThRPIJUQRjxpwgALTto=
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: [PATCH 2/4] block: fix ordering between checking BLK_MQ_S_STOPPED
 and adding requests to hctx->dispatch
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <786a8d94-884c-8a31-151d-fdc82e1a0a63@huaweicloud.com>
Date: Mon, 26 Aug 2024 16:35:07 +0800
Cc: Muchun Song <songmuchun@bytedance.com>,
 Ming Lei <ming.lei@redhat.com>,
 Jens Axboe <axboe@kernel.dk>,
 "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 "yukuai (C)" <yukuai3@huawei.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <3AC15539-1B9B-4996-A150-8CAB214159E5@linux.dev>
References: <20240811101921.4031-1-songmuchun@bytedance.com>
 <20240811101921.4031-3-songmuchun@bytedance.com> <ZsKtllxojkTe3mpY@fedora>
 <CAMZfGtWxE9z4GgmpEBXzwsy_HAyOOZ85+2HUyqE-9+n1f2aPJA@mail.gmail.com>
 <786a8d94-884c-8a31-151d-fdc82e1a0a63@huaweicloud.com>
To: Yu Kuai <yukuai1@huaweicloud.com>
X-Migadu-Flow: FLOW_OUT



> On Aug 22, 2024, at 11:54, Yu Kuai <yukuai1@huaweicloud.com> wrote:
>=20
> Hi,
>=20
> =E5=9C=A8 2024/08/19 11:49, Muchun Song =E5=86=99=E9=81=93:
>> On Mon, Aug 19, 2024 at 10:28=E2=80=AFAM Ming Lei =
<ming.lei@redhat.com> wrote:
>>>=20
>>> Hi Muchun,
>>>=20
>>> On Sun, Aug 11, 2024 at 06:19:19PM +0800, Muchun Song wrote:
>>>> Supposing the following scenario with a virtio_blk driver.
>>>>=20
>>>> CPU0                                                                =
CPU1
>>>>=20
>>>> blk_mq_try_issue_directly()
>>>>     __blk_mq_issue_directly()
>>>>         q->mq_ops->queue_rq()
>>>>             virtio_queue_rq()
>>>>                 blk_mq_stop_hw_queue()
>>>>                                                                     =
virtblk_done()
>>>>     blk_mq_request_bypass_insert()                                  =
    blk_mq_start_stopped_hw_queues()
>>>>         /* Add IO request to dispatch list */   1) store            =
        blk_mq_start_stopped_hw_queue()
>>>>                                                                     =
            clear_bit(BLK_MQ_S_STOPPED)                 3) store
>>>>     blk_mq_run_hw_queue()                                           =
            blk_mq_run_hw_queue()
>>>>         if (!blk_mq_hctx_has_pending())                             =
                if (!blk_mq_hctx_has_pending())         4) load
>>>>             return                                                  =
                    return
>>>>         blk_mq_sched_dispatch_requests()                            =
                blk_mq_sched_dispatch_requests()
>>>>             if (blk_mq_hctx_stopped())          2) load             =
                    if (blk_mq_hctx_stopped())
>>>>                 return                                              =
                        return
>>>>             __blk_mq_sched_dispatch_requests()                      =
                    __blk_mq_sched_dispatch_requests()
>>>>=20
>>>> The full memory barrier should be inserted between 1) and 2), as =
well as between
>>>> 3) and 4) to make sure that either CPU0 sees BLK_MQ_S_STOPPED is =
cleared or CPU1
>>>> sees dispatch list or setting of bitmap of software queue. =
Otherwise, either CPU
>>>> will not re-run the hardware queue causing starvation.
>>>=20
>>> Yeah, it is one kind of race which is triggered when adding request =
into
>>> ->dispatch list after returning STS_RESOURCE. We were troubled by =
lots of
>>> such kind of race.
>> Yes. I saw the similar fix for BLK_MQ_S_SCHED_RESTART.
>>>=20
>>> stopping queue is used in very less drivers, and its only purpose =
should
>>> be for throttling hw queue in case that low level queue is busy. =
There seems
>>> more uses of blk_mq_stop_hw_queues(), but most of them should be =
replaced
>>> with blk_mq_quiesce_queue().
>>>=20
>>> IMO, fixing this kind of issue via memory barrier is too tricky to
>>> maintain cause WRITE/READ dependency is very hard to follow. I'd =
suggest to
>>> make memory barrier solution as the last resort, and we can try to =
figure
>>> out other easier & more reliable way first.
>> I do agree it is hard to maintain the dependencies in the future. We =
should
>> propose an easy-maintainable solution. But I thought it is a =
long-term issue
>> throughout different stable linux distros. Adding a mb is the easy =
way to fix
>> the problem (the code footprint is really small), so it will be very
>> easy for others
>> to backport those bug fixes to different stable linux distros. =
Therefore, mb
>> should be an interim solution. Then, we could improve it based on the =
solution
>> you've proposed below. What do you think?
>=20
> I'll agree with Ming, let's figure out a better fix first. Easy to =
backport to stables is not first consideration.

Hi Kuai,

All right. I usually focus on MM, it seems there is a gap between MM and =
BLock.
Anyway, let's figure out if there is any good solution.

>> Thanks,
>> Muchun.
>>>=20
>>> One idea I thought of is to call blk_mq_request_bypass_insert()(or =
rename
>>> & export it) before calling blk_mq_stop_hw_queue() in driver, then
>>> return new status code STS_STOP_DISPATCH for notifying blk-mq to =
stop
>>> dispatch simply.
>=20
> New status code look good to me, however, I wonder can we just remove
> the problematic blk_mq_stop_hw_queue(), and replace it by handling the
> new status from block layer?
>=20
> - Passing the new status to blk_mq_run_dispatch_ops, and quiesce with

I didn't fully understand your suggestion. Let me ask some questions.
blk_mq_stop_hw_queue() is usually called in blk_mq_ops->queue_rq path,
it'll be easy for this case to pass the new status to =
blk_mq_run_dispatch_ops.
Should we remove blk_mq_stop_hw_queues() as well? How to pass the new
status to blk_mq_run_dispatch_ops in this case?

> the new status, if no request is inflight, unquiesce immediately;

Actually, I didn't understand how to avoid the above race. May you =
elaborate
the scenario?

Muhcun,
Thanks.

> - unquiesce is any IO is done afterwards;




