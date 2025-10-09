Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5997B2AD16;
	Thu,  9 Oct 2025 06:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759992128; cv=none; b=T3nCeXvov/C7Dvu2QM2v/KRZwhrXyCAKyDEovFM4dft6YqBQrqXx/zRVuxycnC8s6j1bgCcbYxvLBJQEzWvcmmMIEJt5D44Q2nuA+a9tK5SOQHRwh10SM+5CWDAzAc9pGA/Y+fI/kb+zDXnCjP35ZiU24IgX+RnNL0ejU6dZKlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759992128; c=relaxed/simple;
	bh=s+a/xCuOVLTKCHopUjAF0LLm7jKEXv9Xm59IVrJKNg8=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=TB3/RWFkD15oPNSQwYlZEFnjOF92AFnXBB2Riu6/Cc310DL+pWr3oABVzf6a0FjKaBoBjauLxXR484ty3gkIs9XX4OLzsLH3aYif926eFOVYc3g/RPPM+sIz4je9+vlyD+uutCrWkhsRVjyyHunekYbE7ntt0vwEJwLkA4YWiCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cj0dp02xszKHMLd;
	Thu,  9 Oct 2025 14:41:34 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 739201A156D;
	Thu,  9 Oct 2025 14:42:02 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgAn6mE4Wedoxqc1CQ--.40502S3;
	Thu, 09 Oct 2025 14:42:02 +0800 (CST)
Subject: Re: [PATCH 3/7] blk-mq: add a new queue sysfs attribute async_depth
To: Yu Kuai <yukuai1@huaweicloud.com>, Yu Kuai <hailan@yukuai.org.cn>,
 Nilay Shroff <nilay@linux.ibm.com>, axboe@kernel.dk, bvanassche@acm.org,
 ming.lei@redhat.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 yi.zhang@huawei.com, yangerkun@huawei.com, johnny.chenyi@huawei.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20250930071111.1218494-1-yukuai1@huaweicloud.com>
 <20250930071111.1218494-4-yukuai1@huaweicloud.com>
 <91799590-15cd-437d-900f-8bc372f7298b@linux.ibm.com>
 <f7fd8fa3-6368-48c1-93b2-942d9d0f75c7@yukuai.org.cn>
 <1b55e01b-64bc-94d9-c0cc-9850b9ee6582@huaweicloud.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <cfefdf5c-984f-1505-be15-0cc9e79df31b@huaweicloud.com>
Date: Thu, 9 Oct 2025 14:42:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1b55e01b-64bc-94d9-c0cc-9850b9ee6582@huaweicloud.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAn6mE4Wedoxqc1CQ--.40502S3
X-Coremail-Antispam: 1UD129KBjvJXoWxZr1kCFy8Wr1DXF1UKF17ZFb_yoW5tF1fpw
	4kJFWYkrWUWr1Igr1Sqw1UZryrtr4xKw17JF13JF13JryDKr12gF1rXr1jgr97Zr48AF4U
	Jrn8X3sxuF1DtrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBF14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUd-B_UUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2025/10/09 8:48, Yu Kuai 写道:
> Hi,
> 
> 在 2025/10/06 9:57, Yu Kuai 写道:
>> Hi,
>>
>> 在 2025/10/2 23:10, Nilay Shroff 写道:
>>>
>>> On 9/30/25 12:41 PM, Yu Kuai wrote:
>>>> From: Yu Kuai <yukuai3@huawei.com>
>>>>
>>>> Add a new field async_depth to request_queue and related APIs, this is
>>>> currently not used, following patches will convert elevators to use
>>>> this instead of internal async_depth.
>>>>
>>>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>>>> ---
>>>>   block/blk-core.c       |  1 +
>>>>   block/blk-mq.c         |  4 ++++
>>>>   block/blk-sysfs.c      | 47 
>>>> ++++++++++++++++++++++++++++++++++++++++++
>>>>   block/elevator.c       |  1 +
>>>>   include/linux/blkdev.h |  1 +
>>>>   5 files changed, 54 insertions(+)
>>>>
>>>> diff --git a/block/blk-core.c b/block/blk-core.c
>>>> index dd39ff651095..76df70cfc103 100644
>>>> --- a/block/blk-core.c
>>>> +++ b/block/blk-core.c
>>>> @@ -463,6 +463,7 @@ struct request_queue *blk_alloc_queue(struct 
>>>> queue_limits *lim, int node_id)
>>>>       fs_reclaim_release(GFP_KERNEL);
>>>>       q->nr_requests = BLKDEV_DEFAULT_RQ;
>>>> +    q->async_depth = BLKDEV_DEFAULT_RQ;
>>>>       return q;
>>>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>>>> index 09f579414161..260e54fa48f0 100644
>>>> --- a/block/blk-mq.c
>>>> +++ b/block/blk-mq.c
>>>> @@ -529,6 +529,8 @@ static struct request 
>>>> *__blk_mq_alloc_requests(struct blk_mq_alloc_data *data)
>>>>               data->rq_flags |= RQF_USE_SCHED;
>>>>               if (ops->limit_depth)
>>>>                   ops->limit_depth(data->cmd_flags, data);
>>>> +            else if (!blk_mq_sched_sync_request(data->cmd_flags))
>>>> +                data->shallow_depth = q->async_depth;
>>>>           }
>>> In the subsequent patches, I saw that ->limit_depth is still used for 
>>> the
>>> BFQ scheduler. Given that, it seems more consistent to also retain 
>>> ->limit_depth
>>> for the mq-deadline and Kyber schedulers, and set data->shallow_depth 
>>> within their
>>> respective ->limit_depth methods. If we take this approach, the 
>>> additional
>>> blk_mq_sched_sync_request() check above becomes unnecessary.
>>>
>>> So IMO:
>>> - Keep ->limit_depth for all schedulers (bfq, mq-deadline, kyber).
>>> - Remove the extra blk_mq_sched_sync_request() check from the core code.
>>
>> I was thinking to save a function call for deadline and kyber, 
>> however, I don't
>> have preference here and I can do this in the next version.
> 
> How abount following, I feel this is better while cooking the new
> version. Consider only bfq have specail handling for async request.
> 
> static void blk_mq_sched_limit_async_depth(struct blk_mq_alloc_data *data)
> {
>      if (blk_mq_sched_sync_request(data->cmd_flags))
>          return;
> 
>      data->shallow_depth = q->async_depth;
>      if (ops->limit_async_depth)
>          ops->limit_async_depth(data);
> }
> 

Just realize I forgot that bfq can limit sync requests as well due to
bfq cgroup policy, so this is not good.

Please ignore this :)

Thanks,
Kuai

> Thanks,
> Kuai
> 
>>
>> Thanks,
>> Kuai
>>
>>> Thanks,
>>> --Nilay
>>>
>> .
>>
> 
> .
> 

