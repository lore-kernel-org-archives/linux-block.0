Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD061B813;
	Thu, 29 Aug 2024 07:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724918281; cv=none; b=gRqJRl8zdYuqlylS4TIcg8wWaOua6xuQHqhzDzptCKp5iWj9sb621vdtkAOG2iO5Vqg9zrfjEt0cWRdEytvRUYLhljaYpTYWE7/bYxeN6Wk0gz/XCuvZhkW0x+dUU/q5FqeJnKbQvtKkC0+QayBHh3Sh5MyobDFXei3W2Znx71k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724918281; c=relaxed/simple;
	bh=ywXiJuCIAp+FUwvoN7xFnuVKXf104lA4QjU/swyqYXw=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ibvoC413FwRB4NVKODoDRVsIxkZJNvLB8X7x4vHSzv9E2tPjlFAk5rD36+DmEXG2kwz68J1VfOrLatSG4HYkJhPfi4lEfwbNpUICMs+/gU82q3NfFcyGYMB2L/1UW9jME7oleemqikosSuMjk2442i+HV6BOZ57sY+1sxn3gBXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WvYXz5LzHz4f3lg5;
	Thu, 29 Aug 2024 15:57:39 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 45D861A1122;
	Thu, 29 Aug 2024 15:57:55 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP4 (Coremail) with SMTP id gCh0CgBHboQBKtBmD7khDA--.8899S3;
	Thu, 29 Aug 2024 15:57:55 +0800 (CST)
Subject: Re: [PATCH 2/4] block: fix ordering between checking BLK_MQ_S_STOPPED
 and adding requests to hctx->dispatch
To: Muchun Song <muchun.song@linux.dev>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: Muchun Song <songmuchun@bytedance.com>, Ming Lei <ming.lei@redhat.com>,
 Jens Axboe <axboe@kernel.dk>,
 "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, "yukuai (C)" <yukuai3@huawei.com>
References: <20240811101921.4031-1-songmuchun@bytedance.com>
 <20240811101921.4031-3-songmuchun@bytedance.com> <ZsKtllxojkTe3mpY@fedora>
 <CAMZfGtWxE9z4GgmpEBXzwsy_HAyOOZ85+2HUyqE-9+n1f2aPJA@mail.gmail.com>
 <786a8d94-884c-8a31-151d-fdc82e1a0a63@huaweicloud.com>
 <3AC15539-1B9B-4996-A150-8CAB214159E5@linux.dev>
 <d044b53b-4917-778d-0f77-c99da8f03769@huaweicloud.com>
 <0AC85BFB-F887-4512-887D-A2E7D36D9C52@linux.dev>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <0506fba7-dcff-d58a-ebfc-703cba565d97@huaweicloud.com>
Date: Thu, 29 Aug 2024 15:57:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <0AC85BFB-F887-4512-887D-A2E7D36D9C52@linux.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBHboQBKtBmD7khDA--.8899S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Ar15Zr4fGr4xXr4rCrW5GFg_yoW7tw47pa
	18Ja1jkw4UJr4Utw12vr4xKr15tr43CrW7WryfGry3uwn09r1Fqr40yr15uFWxCr4DCr47
	tw4UXrZ7XF4kZr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCYjI0SjxkI62AI1cAE67vI
	Y487MxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r
	1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CE
	b7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0x
	vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAI
	cVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kf
	nxnUUI43ZEXa7VUbSfO7UUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2024/08/27 15:31, Muchun Song 写道:
> 
> 
>> On Aug 26, 2024, at 16:53, Yu Kuai <yukuai1@huaweicloud.com> wrote:
>>
>> Hi,
>>
>> 在 2024/08/26 16:35, Muchun Song 写道:
>>>> On Aug 22, 2024, at 11:54, Yu Kuai <yukuai1@huaweicloud.com> wrote:
>>>>
>>>> Hi,
>>>>
>>>> 在 2024/08/19 11:49, Muchun Song 写道:
>>>>> On Mon, Aug 19, 2024 at 10:28 AM Ming Lei <ming.lei@redhat.com> wrote:
>>>>>>
>>>>>> Hi Muchun,
>>>>>>
>>>>>> On Sun, Aug 11, 2024 at 06:19:19PM +0800, Muchun Song wrote:
>>>>>>> Supposing the following scenario with a virtio_blk driver.
>>>>>>>
>>>>>>> CPU0                                                                CPU1
>>>>>>>
>>>>>>> blk_mq_try_issue_directly()
>>>>>>>      __blk_mq_issue_directly()
>>>>>>>          q->mq_ops->queue_rq()
>>>>>>>              virtio_queue_rq()
>>>>>>>                  blk_mq_stop_hw_queue()
>>>>>>>                                                                      virtblk_done()
>>>>>>>      blk_mq_request_bypass_insert()                                      blk_mq_start_stopped_hw_queues()
>>>>>>>          /* Add IO request to dispatch list */   1) store                    blk_mq_start_stopped_hw_queue()
>>>>>>>                                                                                  clear_bit(BLK_MQ_S_STOPPED)                 3) store
>>>>>>>      blk_mq_run_hw_queue()                                                       blk_mq_run_hw_queue()
>>>>>>>          if (!blk_mq_hctx_has_pending())                                             if (!blk_mq_hctx_has_pending())         4) load
>>>>>>>              return                                                                      return
>>>>>>>          blk_mq_sched_dispatch_requests()                                            blk_mq_sched_dispatch_requests()
>>>>>>>              if (blk_mq_hctx_stopped())          2) load                                 if (blk_mq_hctx_stopped())
>>>>>>>                  return                                                                      return
>>>>>>>              __blk_mq_sched_dispatch_requests()                                          __blk_mq_sched_dispatch_requests()
>>>>>>>
>>>>>>> The full memory barrier should be inserted between 1) and 2), as well as between
>>>>>>> 3) and 4) to make sure that either CPU0 sees BLK_MQ_S_STOPPED is cleared or CPU1
>>>>>>> sees dispatch list or setting of bitmap of software queue. Otherwise, either CPU
>>>>>>> will not re-run the hardware queue causing starvation.
>>>>>>
>>>>>> Yeah, it is one kind of race which is triggered when adding request into
>>>>>> ->dispatch list after returning STS_RESOURCE. We were troubled by lots of
>>>>>> such kind of race.
>>>>> Yes. I saw the similar fix for BLK_MQ_S_SCHED_RESTART.
>>>>>>
>>>>>> stopping queue is used in very less drivers, and its only purpose should
>>>>>> be for throttling hw queue in case that low level queue is busy. There seems
>>>>>> more uses of blk_mq_stop_hw_queues(), but most of them should be replaced
>>>>>> with blk_mq_quiesce_queue().
>>>>>>
>>>>>> IMO, fixing this kind of issue via memory barrier is too tricky to
>>>>>> maintain cause WRITE/READ dependency is very hard to follow. I'd suggest to
>>>>>> make memory barrier solution as the last resort, and we can try to figure
>>>>>> out other easier & more reliable way first.
>>>>> I do agree it is hard to maintain the dependencies in the future. We should
>>>>> propose an easy-maintainable solution. But I thought it is a long-term issue
>>>>> throughout different stable linux distros. Adding a mb is the easy way to fix
>>>>> the problem (the code footprint is really small), so it will be very
>>>>> easy for others
>>>>> to backport those bug fixes to different stable linux distros. Therefore, mb
>>>>> should be an interim solution. Then, we could improve it based on the solution
>>>>> you've proposed below. What do you think?
>>>>
>>>> I'll agree with Ming, let's figure out a better fix first. Easy to backport to stables is not first consideration.
>>> Hi Kuai,
>>> All right. I usually focus on MM, it seems there is a gap between MM and BLock.
>>> Anyway, let's figure out if there is any good solution.
>>>>> Thanks,
>>>>> Muchun.
>>>>>>
>>>>>> One idea I thought of is to call blk_mq_request_bypass_insert()(or rename
>>>>>> & export it) before calling blk_mq_stop_hw_queue() in driver, then
>>>>>> return new status code STS_STOP_DISPATCH for notifying blk-mq to stop
>>>>>> dispatch simply.
>>>>
>>>> New status code look good to me, however, I wonder can we just remove
>>>> the problematic blk_mq_stop_hw_queue(), and replace it by handling the
>>>> new status from block layer?
>>>>
>>>> - Passing the new status to blk_mq_run_dispatch_ops, and quiesce with
>>> I didn't fully understand your suggestion. Let me ask some questions.
>>> blk_mq_stop_hw_queue() is usually called in blk_mq_ops->queue_rq path,
>>> it'll be easy for this case to pass the new status to blk_mq_run_dispatch_ops.
>>> Should we remove blk_mq_stop_hw_queues() as well? How to pass the new
>>> status to blk_mq_run_dispatch_ops in this case?
>>
>> For queue_rq from dispatch path, it can be removed. However, it is
>> called from remove path as well, I don't check yet if it can be removed
>> there, that's another story.
> 
> The reason why I asked this question is that blk_mq_stop_hw_queues() also needs
> to be fixed. See my patch 3.

I just reviewed that patch, please check following.
> 
>>
>> And just add a return value for dispatch_ops to pass status.
>>
>> Thanks,
>> Kuai
>>
>>>> the new status, if no request is inflight, unquiesce immediately;
>>> Actually, I didn't understand how to avoid the above race. May you elaborate
>>> the scenario?
> 
> Sorry for repeating, I didn't get your point here. May you elaborate
> your suggestion? Thanks very much.

// dispatch path, replace stop queue with quiesce queue;
if (__blk_mq_run_dispatch_ops() != STS_STOP_DISPATCH)
        return;

blk_mq_quiesce_queue();
/* other context already stop dispatch */
if (test_and_set_bit(QUEUE_FLAG_STOP_DISPATCH, &q->queue_flags)) {
        blk_mq_unquiesce_queue();
        return;
}

/*
  * IO is done before stopping dispatch, hence can't let IO complete to
  * unquiesce queue.
  */
if (!blk_mq_inflight() && test_and_clear_bit(QUEUE_FLAG_STOP_DISPATCH, 
&q->queue_flags))
        blk_mq_unquiesce_queue();

// complete path
if (test_and_clear_bit(QUEUE_FLAG_STOP_DISPATCH, &q->queue_flags))
        blk_mq_unquiesce_queue();

Thanks,
Kuai

> 
>>> Muhcun,
>>> Thanks.
>>>> - unquiesce is any IO is done afterwards;
>>> .
> 
> 
> .
> 

