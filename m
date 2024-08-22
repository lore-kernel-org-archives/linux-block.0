Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F0C2E64B;
	Thu, 22 Aug 2024 03:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724298893; cv=none; b=dPDkBmgRxvMtirVOrgru9ja9HWijB8DKD9tkHr3Ck0nN7DPjE2PKQ3NBYTnez3mx3hqoQ1Ar8rLe2m4w0xM4jJPIZ4Ep+hDKlxEUj4C2cbeqQVqRAGHk6ADdMwmSlN4Dqcq1dpaMhpIqzlMgx0DHbeKL2vpw7zw7OeF4afDGL1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724298893; c=relaxed/simple;
	bh=mKGxxLXRjwIPYRp9onC2QgTcqbbV/WwUgqAhUr35P7I=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=SF1jWQaC+NreDYRerwAoTn+KfyD7+Qsvj+S6sIgVuFFD6B+ClFVOV4tkySE73m/t4V6sKSUdHuPu0osmkD6G0YuQTTzv9YvbfESw1qyoA9yXylPUjeOIT3HFU6jWDuQED8JEaHLCuW7nwFwjKB+xH9RpP1FuUceepHdf4u8qqjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Wq8Tm2W6Cz4f3jsx;
	Thu, 22 Aug 2024 11:54:36 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 0E27D1A018D;
	Thu, 22 Aug 2024 11:54:46 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP4 (Coremail) with SMTP id gCh0CgAXPoSEtsZmGZl6CQ--.44088S3;
	Thu, 22 Aug 2024 11:54:45 +0800 (CST)
Subject: Re: [PATCH 2/4] block: fix ordering between checking BLK_MQ_S_STOPPED
 and adding requests to hctx->dispatch
To: Muchun Song <songmuchun@bytedance.com>, Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>,
 "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, muchun.song@linux.dev,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20240811101921.4031-1-songmuchun@bytedance.com>
 <20240811101921.4031-3-songmuchun@bytedance.com> <ZsKtllxojkTe3mpY@fedora>
 <CAMZfGtWxE9z4GgmpEBXzwsy_HAyOOZ85+2HUyqE-9+n1f2aPJA@mail.gmail.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <786a8d94-884c-8a31-151d-fdc82e1a0a63@huaweicloud.com>
Date: Thu, 22 Aug 2024 11:54:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAMZfGtWxE9z4GgmpEBXzwsy_HAyOOZ85+2HUyqE-9+n1f2aPJA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAXPoSEtsZmGZl6CQ--.44088S3
X-Coremail-Antispam: 1UD129KBjvJXoWxWw4fXFW8Cr1UGw1DZr15twb_yoW5tw15pa
	1kta1Yyw4Dt3yvqw47Zr4xGw1Yy39IkrW7CryfG343Wwn8K34vvr40k3WY9FyIkrs5Cr4x
	tw4UXrZ7uan5ZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AK
	xVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1l
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j
	6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUwx
	hLUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2024/08/19 11:49, Muchun Song 写道:
> On Mon, Aug 19, 2024 at 10:28 AM Ming Lei <ming.lei@redhat.com> wrote:
>>
>> Hi Muchun,
>>
>> On Sun, Aug 11, 2024 at 06:19:19PM +0800, Muchun Song wrote:
>>> Supposing the following scenario with a virtio_blk driver.
>>>
>>> CPU0                                                                CPU1
>>>
>>> blk_mq_try_issue_directly()
>>>      __blk_mq_issue_directly()
>>>          q->mq_ops->queue_rq()
>>>              virtio_queue_rq()
>>>                  blk_mq_stop_hw_queue()
>>>                                                                      virtblk_done()
>>>      blk_mq_request_bypass_insert()                                      blk_mq_start_stopped_hw_queues()
>>>          /* Add IO request to dispatch list */   1) store                    blk_mq_start_stopped_hw_queue()
>>>                                                                                  clear_bit(BLK_MQ_S_STOPPED)                 3) store
>>>      blk_mq_run_hw_queue()                                                       blk_mq_run_hw_queue()
>>>          if (!blk_mq_hctx_has_pending())                                             if (!blk_mq_hctx_has_pending())         4) load
>>>              return                                                                      return
>>>          blk_mq_sched_dispatch_requests()                                            blk_mq_sched_dispatch_requests()
>>>              if (blk_mq_hctx_stopped())          2) load                                 if (blk_mq_hctx_stopped())
>>>                  return                                                                      return
>>>              __blk_mq_sched_dispatch_requests()                                          __blk_mq_sched_dispatch_requests()
>>>
>>> The full memory barrier should be inserted between 1) and 2), as well as between
>>> 3) and 4) to make sure that either CPU0 sees BLK_MQ_S_STOPPED is cleared or CPU1
>>> sees dispatch list or setting of bitmap of software queue. Otherwise, either CPU
>>> will not re-run the hardware queue causing starvation.
>>
>> Yeah, it is one kind of race which is triggered when adding request into
>> ->dispatch list after returning STS_RESOURCE. We were troubled by lots of
>> such kind of race.
> 
> Yes. I saw the similar fix for BLK_MQ_S_SCHED_RESTART.
> 
>>
>> stopping queue is used in very less drivers, and its only purpose should
>> be for throttling hw queue in case that low level queue is busy. There seems
>> more uses of blk_mq_stop_hw_queues(), but most of them should be replaced
>> with blk_mq_quiesce_queue().
>>
>> IMO, fixing this kind of issue via memory barrier is too tricky to
>> maintain cause WRITE/READ dependency is very hard to follow. I'd suggest to
>> make memory barrier solution as the last resort, and we can try to figure
>> out other easier & more reliable way first.
> 
> I do agree it is hard to maintain the dependencies in the future. We should
> propose an easy-maintainable solution. But I thought it is a long-term issue
> throughout different stable linux distros. Adding a mb is the easy way to fix
> the problem (the code footprint is really small), so it will be very
> easy for others
> to backport those bug fixes to different stable linux distros. Therefore, mb
> should be an interim solution. Then, we could improve it based on the solution
> you've proposed below. What do you think?

I'll agree with Ming, let's figure out a better fix first. Easy to 
backport to stables is not first consideration.
> 
> Thanks,
> Muchun.
> 
>>
>> One idea I thought of is to call blk_mq_request_bypass_insert()(or rename
>> & export it) before calling blk_mq_stop_hw_queue() in driver, then
>> return new status code STS_STOP_DISPATCH for notifying blk-mq to stop
>> dispatch simply.

New status code look good to me, however, I wonder can we just remove
the problematic blk_mq_stop_hw_queue(), and replace it by handling the
new status from block layer?

- Passing the new status to blk_mq_run_dispatch_ops, and quiesce with
the new status, if no request is inflight, unquiesce immediately;
- unquiesce is any IO is done afterwards;

Thanks,
Kuai

>>
>>
>> thanks,
>> Ming
>>
> 
> .
> 

