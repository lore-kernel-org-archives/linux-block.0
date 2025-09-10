Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C850303C8A;
	Wed, 10 Sep 2025 06:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757486545; cv=none; b=USVCsIhC0IxYc5I2nb++F/rGsJDLN3LgFFJTHLrOInMZzzGRqsRCXtWYfmFcb+nBHHDGrFhh282JiOqzye1EHt6d1GF8lgAI3dR0A1mnbLS49cVHvVJSCNkYINYDhQj9lreCUiLC+b2tOJgU9N0ncA6c+DJIOpvgxmGaA9Gypos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757486545; c=relaxed/simple;
	bh=VFt52MJMXv7/WJmI+ezrk3pifNVu6VYqGJuWWHSMAKM=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=aXbkcCl9SB/Y02qFA3ypRnPbz5G1DOJFwtpLAAlMpZ4OS9YbCo370aUDYi3R0AHIJPwio3EObjKLQHqZsG/p9SjHtZG7r/bjbQOg9C6dxMlmO/g6BVd02tsBSD+8fIROzIeAYAz5ZpJ3Tzb5Y6msvHOEiH3jVrnOo5GXZWcx4dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cMB254hWHzYQvQ1;
	Wed, 10 Sep 2025 14:42:21 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 295CC1A0C21;
	Wed, 10 Sep 2025 14:42:20 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgDnMY7KHcFoTbsJCA--.50604S3;
	Wed, 10 Sep 2025 14:42:19 +0800 (CST)
Subject: Re: [PATCH for-6.18/block 06/10] blk-mq: split bitmap grow and resize
 case in blk_mq_update_nr_requests()
To: Nilay Shroff <nilay@linux.ibm.com>, Yu Kuai <hailan@yukuai.org.cn>,
 Yu Kuai <yukuai1@huaweicloud.com>, ming.lei@redhat.com, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 yi.zhang@huawei.com, yangerkun@huawei.com, johnny.chenyi@huawei.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20250908061533.3062917-1-yukuai1@huaweicloud.com>
 <20250908061533.3062917-7-yukuai1@huaweicloud.com>
 <85259339-d832-468a-a9b0-0c326c896370@linux.ibm.com>
 <8ab0b2e2-a3da-43b1-9fb8-141e85aee3b2@yukuai.org.cn>
 <a4fd99c3-faa6-4c6d-b7a5-4f32d3eed40b@linux.ibm.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <bd4e6dfb-fa9c-d36a-5ed5-4cf6411f00a6@huaweicloud.com>
Date: Wed, 10 Sep 2025 14:42:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <a4fd99c3-faa6-4c6d-b7a5-4f32d3eed40b@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDnMY7KHcFoTbsJCA--.50604S3
X-Coremail-Antispam: 1UD129KBjvJXoWxZF48XrW8Gw47WF4Uuw18AFb_yoWruF1kpr
	1kJFyUGry5Jr1kJr1Utr1UXry8Kr1UJ3WDJr18JFyUJr47Jr12gr4UXr1qgr1UJr48Jr4U
	Jr1UJr9rZr1UJr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBI14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4U
	JVW0owA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
	c2xKxwCYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7V
	AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF0xvE
	42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6x
	kF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUbGQ6JUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2025/09/10 14:30, Nilay Shroff 写道:
> 
> 
> On 9/9/25 10:09 PM, Yu Kuai wrote:
>> Hi,
>>
>> 在 2025/9/9 20:18, Nilay Shroff 写道:
>>>
>>> On 9/8/25 11:45 AM, Yu Kuai wrote:
>>>> From: Yu Kuai <yukuai3@huawei.com>
>>>>
>>>> No functional changes are intended, make code cleaner and prepare to fix
>>>> the grow case in following patches.
>>>>
>>>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>>>> ---
>>>>    block/blk-mq.c | 28 ++++++++++++++++------------
>>>>    1 file changed, 16 insertions(+), 12 deletions(-)
>>>>
>>>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>>>> index 1ff6370f7314..82fa81036115 100644
>>>> --- a/block/blk-mq.c
>>>> +++ b/block/blk-mq.c
>>>> @@ -4931,21 +4931,25 @@ int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr)
>>>>                blk_mq_tag_update_sched_shared_tags(q);
>>>>            else
>>>>                blk_mq_tag_resize_shared_tags(set, nr);
>>>> -    } else {
>>>> +    } else if (!q->elevator) {
>>>>            queue_for_each_hw_ctx(q, hctx, i) {
>>>>                if (!hctx->tags)
>>>>                    continue;
>>>> -            /*
>>>> -             * If we're using an MQ scheduler, just update the
>>>> -             * scheduler queue depth. This is similar to what the
>>>> -             * old code would do.
>>>> -             */
>>>> -            if (hctx->sched_tags)
>>>> -                ret = blk_mq_tag_update_depth(hctx,
>>>> -                            &hctx->sched_tags, nr);
>>>> -            else
>>>> -                ret = blk_mq_tag_update_depth(hctx,
>>>> -                            &hctx->tags, nr);
>>>> +            sbitmap_queue_resize(&hctx->tags->bitmap_tags,
>>>> +                nr - hctx->tags->nr_reserved_tags);
>>>> +        }
>>>> +    } else if (nr <= q->elevator->et->nr_requests) {
>>>> +        queue_for_each_hw_ctx(q, hctx, i) {
>>>> +            if (!hctx->sched_tags)
>>>> +                continue;
>>>> +            sbitmap_queue_resize(&hctx->sched_tags->bitmap_tags,
>>>> +                nr - hctx->sched_tags->nr_reserved_tags);
>>>> +        }
>>>> +    } else {
>>>> +        queue_for_each_hw_ctx(q, hctx, i) {
>>>> +            if (!hctx->sched_tags)
>>>> +                continue;
>>>> +            blk_mq_tag_update_depth(hctx, &hctx->sched_tags, nr);
>>>>                if (ret)
>>>>                    goto out;
>>>>            }
>>> The above code is good however can this be bit simplified?
>>> It's a bit difficult to follow through all nesting and so
>>> could it be simplified as below:
>>>
>>> if (shared-tags) {
>>>       if (elevator)
>>>          // resize sched-shared-tags bitmap
>>>       else
>>>          // resize shared-tags bitmap
>>> } else {
>>>       // non-shared tags
>>>       if (elevator) {
>>>           if (new-depth-is-less-than-the-current-depth)
>>>               // resize sched-tags bitmap
>>>           else
>>>               // handle sched tags grow
>>>       } else
>>>           // resize tags bitmap
>>> }
>>
>> AFAIK, if - else if chain should be better than nested if - else, right?
>>
>> If you don't mind, I can add comments to each else if chain to make code cleaner:
>>
>> if () {
>>      /* shared tags */
>>      ...
>> } else if () {
>>      /* non-shared tags and elevator is none */
>>      ...
>> } else if () {
>>      /* non-shared tags and elevator is not none, nr_requests doesn't grow */
>>      ...
>> } else () {
>>      /* non-shared tags and elevator is not none, nr_requests grow */
>>      ...
>> }
>>
> Yeah, I am good with the proper comments as well so that it'd be easy
> for anyone reviewing the code later to understand what those all nested
> if-else conditions meant.
> 

Ok, I'll do that in the next version.

Thanks for the review!
Kuai

> Thanks,
> --Nilay
> 
> .
> 

