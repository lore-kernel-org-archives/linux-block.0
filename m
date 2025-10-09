Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C450316DEB1;
	Thu,  9 Oct 2025 01:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759971883; cv=none; b=XyfDdk92b4owUDDq2ukg5KLjl6kWvPdvmqRYPo08LsQZ5VViOO14raFjx8SoJU8v7OoFIlW4DcMIyC22gXTTOPUv/qrWGkaapuw+TFB7GDE8C9QfSt7x/u7vRATV25YubDKVMiM44qPNxEgil1TvEzeJts2AO/Ve5yEiifouN6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759971883; c=relaxed/simple;
	bh=hrLNHG+X2BW5USSrMsp/NX+xqNYQLiyVnsBa49AmAhw=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=UqCnGuNbDDl52RfoMZEAuJyCa0sYgXWSnUZ3qJxwkqztOkheIbLDChzMlys7NE81PibNY67bS8jwRke/OHFPD1afLTvvqZUAP8p4zqB22BBcTkuj/9tjZe/9YVdHEFAZkbpV+MAh4EfdqidYZPgrUVSY3kF19XiID7ZQQ97hYoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4chrp74VlxzKHMYM;
	Thu,  9 Oct 2025 08:48:15 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id B716B1A0DE3;
	Thu,  9 Oct 2025 08:48:43 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgCXW2NpBudoWY4ZCQ--.34345S3;
	Thu, 09 Oct 2025 08:48:43 +0800 (CST)
Subject: Re: [PATCH 3/7] blk-mq: add a new queue sysfs attribute async_depth
To: Yu Kuai <hailan@yukuai.org.cn>, Nilay Shroff <nilay@linux.ibm.com>,
 Yu Kuai <yukuai1@huaweicloud.com>, axboe@kernel.dk, bvanassche@acm.org,
 ming.lei@redhat.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 yi.zhang@huawei.com, yangerkun@huawei.com, johnny.chenyi@huawei.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20250930071111.1218494-1-yukuai1@huaweicloud.com>
 <20250930071111.1218494-4-yukuai1@huaweicloud.com>
 <91799590-15cd-437d-900f-8bc372f7298b@linux.ibm.com>
 <f7fd8fa3-6368-48c1-93b2-942d9d0f75c7@yukuai.org.cn>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <1b55e01b-64bc-94d9-c0cc-9850b9ee6582@huaweicloud.com>
Date: Thu, 9 Oct 2025 08:48:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <f7fd8fa3-6368-48c1-93b2-942d9d0f75c7@yukuai.org.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCXW2NpBudoWY4ZCQ--.34345S3
X-Coremail-Antispam: 1UD129KBjvJXoWxJw4rZF45CF45GF1kXw47Jwb_yoW5CF13pw
	4kJFWYkryUWF1Igr1fJw13ZryrJw4xKw17JF13tF13JryDKr12gF1rXr1jgr97Zr48AF47
	Jrn0vas8uF1DJFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBF14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
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

在 2025/10/06 9:57, Yu Kuai 写道:
> Hi,
> 
> 在 2025/10/2 23:10, Nilay Shroff 写道:
>>
>> On 9/30/25 12:41 PM, Yu Kuai wrote:
>>> From: Yu Kuai <yukuai3@huawei.com>
>>>
>>> Add a new field async_depth to request_queue and related APIs, this is
>>> currently not used, following patches will convert elevators to use
>>> this instead of internal async_depth.
>>>
>>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>>> ---
>>>   block/blk-core.c       |  1 +
>>>   block/blk-mq.c         |  4 ++++
>>>   block/blk-sysfs.c      | 47 ++++++++++++++++++++++++++++++++++++++++++
>>>   block/elevator.c       |  1 +
>>>   include/linux/blkdev.h |  1 +
>>>   5 files changed, 54 insertions(+)
>>>
>>> diff --git a/block/blk-core.c b/block/blk-core.c
>>> index dd39ff651095..76df70cfc103 100644
>>> --- a/block/blk-core.c
>>> +++ b/block/blk-core.c
>>> @@ -463,6 +463,7 @@ struct request_queue *blk_alloc_queue(struct 
>>> queue_limits *lim, int node_id)
>>>       fs_reclaim_release(GFP_KERNEL);
>>>       q->nr_requests = BLKDEV_DEFAULT_RQ;
>>> +    q->async_depth = BLKDEV_DEFAULT_RQ;
>>>       return q;
>>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>>> index 09f579414161..260e54fa48f0 100644
>>> --- a/block/blk-mq.c
>>> +++ b/block/blk-mq.c
>>> @@ -529,6 +529,8 @@ static struct request 
>>> *__blk_mq_alloc_requests(struct blk_mq_alloc_data *data)
>>>               data->rq_flags |= RQF_USE_SCHED;
>>>               if (ops->limit_depth)
>>>                   ops->limit_depth(data->cmd_flags, data);
>>> +            else if (!blk_mq_sched_sync_request(data->cmd_flags))
>>> +                data->shallow_depth = q->async_depth;
>>>           }
>> In the subsequent patches, I saw that ->limit_depth is still used for the
>> BFQ scheduler. Given that, it seems more consistent to also retain 
>> ->limit_depth
>> for the mq-deadline and Kyber schedulers, and set data->shallow_depth 
>> within their
>> respective ->limit_depth methods. If we take this approach, the 
>> additional
>> blk_mq_sched_sync_request() check above becomes unnecessary.
>>
>> So IMO:
>> - Keep ->limit_depth for all schedulers (bfq, mq-deadline, kyber).
>> - Remove the extra blk_mq_sched_sync_request() check from the core code.
> 
> I was thinking to save a function call for deadline and kyber, however, 
> I don't
> have preference here and I can do this in the next version.

How abount following, I feel this is better while cooking the new
version. Consider only bfq have specail handling for async request.

static void blk_mq_sched_limit_async_depth(struct blk_mq_alloc_data *data)
{
	if (blk_mq_sched_sync_request(data->cmd_flags))
		return;

	data->shallow_depth = q->async_depth;
	if (ops->limit_async_depth)
		ops->limit_async_depth(data);
}

Thanks,
Kuai

> 
> Thanks,
> Kuai
> 
>> Thanks,
>> --Nilay
>>
> .
> 

