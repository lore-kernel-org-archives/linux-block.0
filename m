Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4066D15746E
	for <linux-block@vger.kernel.org>; Tue, 27 Aug 2024 07:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724743932; cv=none; b=VCv5s4cZbrFJhoGQiuNDqmWZZyWJ1cU1DAo822pje6HmbODHPVzykXVVi0V50jqmP70tbWMCQ5w+pR5DeCn1VPD/iHzO6NspDmoPUhFt6s3+etizxiZrNbtCEGhrwLU2wRddB7sKsfo+1f3qRbY/sOY9Vk9VmmnN47rtk+fyVmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724743932; c=relaxed/simple;
	bh=htgvHkO/sM6vb0evXT+a5RKrtwD+zZv4TeIAKiJAUAg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=tNdwflzjEd8ow05e9omIOI7M146nEgjlj5SYRRZOzQs102nF77bU8AFPG+LL9J1bizTQ+4epEMDoMC0vanrjlSFzvU+D9zDiuG/73ZVq4dsPBZShPqW2BVR7FQ/B16FF7XscbriKkIuulskzuaWAw1oEC3TalE8s+DZxYfDYVoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=U5OROc7A; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="U5OROc7A"
Content-Type: text/plain;
	charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724743928;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NXV4/htXT29RV8EpSV8BYHk1NDt7bT21YYLHpiqyNBU=;
	b=U5OROc7AZdw/P6L+wELiD2y8Bs+ngIjvJaorDTbVKhfG18IZ9KEmRzqLIj1zNcgw7AhsBE
	hyAdTpgJILg0s8QeSe9lYDCOBKZIDETiUmN/QBpbSPdiY4tyVXETri4rAyOtc1atWTPajB
	Pk7j5gkdByEzNtehlHbaNAGiek9XaDA=
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
In-Reply-To: <d044b53b-4917-778d-0f77-c99da8f03769@huaweicloud.com>
Date: Tue, 27 Aug 2024 15:31:27 +0800
Cc: Muchun Song <songmuchun@bytedance.com>,
 Ming Lei <ming.lei@redhat.com>,
 Jens Axboe <axboe@kernel.dk>,
 "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 "yukuai (C)" <yukuai3@huawei.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <0AC85BFB-F887-4512-887D-A2E7D36D9C52@linux.dev>
References: <20240811101921.4031-1-songmuchun@bytedance.com>
 <20240811101921.4031-3-songmuchun@bytedance.com> <ZsKtllxojkTe3mpY@fedora>
 <CAMZfGtWxE9z4GgmpEBXzwsy_HAyOOZ85+2HUyqE-9+n1f2aPJA@mail.gmail.com>
 <786a8d94-884c-8a31-151d-fdc82e1a0a63@huaweicloud.com>
 <3AC15539-1B9B-4996-A150-8CAB214159E5@linux.dev>
 <d044b53b-4917-778d-0f77-c99da8f03769@huaweicloud.com>
To: Yu Kuai <yukuai1@huaweicloud.com>
X-Migadu-Flow: FLOW_OUT



> On Aug 26, 2024, at 16:53, Yu Kuai <yukuai1@huaweicloud.com> wrote:
>=20
> Hi,
>=20
> =E5=9C=A8 2024/08/26 16:35, Muchun Song =E5=86=99=E9=81=93:
>>> On Aug 22, 2024, at 11:54, Yu Kuai <yukuai1@huaweicloud.com> wrote:
>>>=20
>>> Hi,
>>>=20
>>> =E5=9C=A8 2024/08/19 11:49, Muchun Song =E5=86=99=E9=81=93:
>>>> On Mon, Aug 19, 2024 at 10:28=E2=80=AFAM Ming Lei =
<ming.lei@redhat.com> wrote:
>>>>>=20
>>>>> Hi Muchun,
>>>>>=20
>>>>> On Sun, Aug 11, 2024 at 06:19:19PM +0800, Muchun Song wrote:
>>>>>> Supposing the following scenario with a virtio_blk driver.
>>>>>>=20
>>>>>> CPU0                                                              =
  CPU1
>>>>>>=20
>>>>>> blk_mq_try_issue_directly()
>>>>>>     __blk_mq_issue_directly()
>>>>>>         q->mq_ops->queue_rq()
>>>>>>             virtio_queue_rq()
>>>>>>                 blk_mq_stop_hw_queue()
>>>>>>                                                                   =
  virtblk_done()
>>>>>>     blk_mq_request_bypass_insert()                                =
      blk_mq_start_stopped_hw_queues()
>>>>>>         /* Add IO request to dispatch list */   1) store          =
          blk_mq_start_stopped_hw_queue()
>>>>>>                                                                   =
              clear_bit(BLK_MQ_S_STOPPED)                 3) store
>>>>>>     blk_mq_run_hw_queue()                                         =
              blk_mq_run_hw_queue()
>>>>>>         if (!blk_mq_hctx_has_pending())                           =
                  if (!blk_mq_hctx_has_pending())         4) load
>>>>>>             return                                                =
                      return
>>>>>>         blk_mq_sched_dispatch_requests()                          =
                  blk_mq_sched_dispatch_requests()
>>>>>>             if (blk_mq_hctx_stopped())          2) load           =
                      if (blk_mq_hctx_stopped())
>>>>>>                 return                                            =
                          return
>>>>>>             __blk_mq_sched_dispatch_requests()                    =
                      __blk_mq_sched_dispatch_requests()
>>>>>>=20
>>>>>> The full memory barrier should be inserted between 1) and 2), as =
well as between
>>>>>> 3) and 4) to make sure that either CPU0 sees BLK_MQ_S_STOPPED is =
cleared or CPU1
>>>>>> sees dispatch list or setting of bitmap of software queue. =
Otherwise, either CPU
>>>>>> will not re-run the hardware queue causing starvation.
>>>>>=20
>>>>> Yeah, it is one kind of race which is triggered when adding =
request into
>>>>> ->dispatch list after returning STS_RESOURCE. We were troubled by =
lots of
>>>>> such kind of race.
>>>> Yes. I saw the similar fix for BLK_MQ_S_SCHED_RESTART.
>>>>>=20
>>>>> stopping queue is used in very less drivers, and its only purpose =
should
>>>>> be for throttling hw queue in case that low level queue is busy. =
There seems
>>>>> more uses of blk_mq_stop_hw_queues(), but most of them should be =
replaced
>>>>> with blk_mq_quiesce_queue().
>>>>>=20
>>>>> IMO, fixing this kind of issue via memory barrier is too tricky to
>>>>> maintain cause WRITE/READ dependency is very hard to follow. I'd =
suggest to
>>>>> make memory barrier solution as the last resort, and we can try to =
figure
>>>>> out other easier & more reliable way first.
>>>> I do agree it is hard to maintain the dependencies in the future. =
We should
>>>> propose an easy-maintainable solution. But I thought it is a =
long-term issue
>>>> throughout different stable linux distros. Adding a mb is the easy =
way to fix
>>>> the problem (the code footprint is really small), so it will be =
very
>>>> easy for others
>>>> to backport those bug fixes to different stable linux distros. =
Therefore, mb
>>>> should be an interim solution. Then, we could improve it based on =
the solution
>>>> you've proposed below. What do you think?
>>>=20
>>> I'll agree with Ming, let's figure out a better fix first. Easy to =
backport to stables is not first consideration.
>> Hi Kuai,
>> All right. I usually focus on MM, it seems there is a gap between MM =
and BLock.
>> Anyway, let's figure out if there is any good solution.
>>>> Thanks,
>>>> Muchun.
>>>>>=20
>>>>> One idea I thought of is to call blk_mq_request_bypass_insert()(or =
rename
>>>>> & export it) before calling blk_mq_stop_hw_queue() in driver, then
>>>>> return new status code STS_STOP_DISPATCH for notifying blk-mq to =
stop
>>>>> dispatch simply.
>>>=20
>>> New status code look good to me, however, I wonder can we just =
remove
>>> the problematic blk_mq_stop_hw_queue(), and replace it by handling =
the
>>> new status from block layer?
>>>=20
>>> - Passing the new status to blk_mq_run_dispatch_ops, and quiesce =
with
>> I didn't fully understand your suggestion. Let me ask some questions.
>> blk_mq_stop_hw_queue() is usually called in blk_mq_ops->queue_rq =
path,
>> it'll be easy for this case to pass the new status to =
blk_mq_run_dispatch_ops.
>> Should we remove blk_mq_stop_hw_queues() as well? How to pass the new
>> status to blk_mq_run_dispatch_ops in this case?
>=20
> For queue_rq from dispatch path, it can be removed. However, it is
> called from remove path as well, I don't check yet if it can be =
removed
> there, that's another story.

The reason why I asked this question is that blk_mq_stop_hw_queues() =
also needs
to be fixed. See my patch 3.

>=20
> And just add a return value for dispatch_ops to pass status.
>=20
> Thanks,
> Kuai
>=20
>>> the new status, if no request is inflight, unquiesce immediately;
>> Actually, I didn't understand how to avoid the above race. May you =
elaborate
>> the scenario?

Sorry for repeating, I didn't get your point here. May you elaborate
your suggestion? Thanks very much.

>> Muhcun,
>> Thanks.
>>> - unquiesce is any IO is done afterwards;
>> .


