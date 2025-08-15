Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395C7125A9;
	Fri, 15 Aug 2025 01:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755221549; cv=none; b=anCmmRvr7U56bqsliysCpFaUHBTZcMMudkJ3E9Q8p92p77KjwPmlNd6UZjeHn+QaIijSpWfztE2XdhUeHBdE8mlFV78D8rvYjrfeFOboD7M29VXEGsUjwlswFGr4ez9JHxsqcl1zk92rMAmcGm8iQ3H+FT0iWYi/kURFb14Ynw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755221549; c=relaxed/simple;
	bh=vEXFWBWqeNLLUnrpTboM3dHS9/dfw8xwNUJxGm1EiZg=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=lvTEL0646hbo7pAaxkXavjUw2ad0QSftZY2Q5fdoom7XYo3BP9uA592dc3xaT4moVtMzZniSc4KskurFsqYoohFuBXB9ey8DMQHfrRzTQlT/9etkYI8FET29YIuldU7t31BRhlIXT1kHr7TazrsF0q/+gXraOJdr7OqwzIWwHxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4c34NS18cLzKHMvF;
	Fri, 15 Aug 2025 09:32:24 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 766CB1A1511;
	Fri, 15 Aug 2025 09:32:23 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgDnYhMmjp5oGnTfDg--.26725S3;
	Fri, 15 Aug 2025 09:32:23 +0800 (CST)
Subject: Re: [PATCH 03/16] blk-mq: remove useless checkings from
 blk_mq_update_nr_requests()
To: Nilay Shroff <nilay@linux.ibm.com>, Yu Kuai <yukuai1@huaweicloud.com>,
 axboe@kernel.dk, bvanassche@acm.org, hare@suse.de, ming.lei@redhat.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 yi.zhang@huawei.com, yangerkun@huawei.com, johnny.chenyi@huawei.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20250814033522.770575-1-yukuai1@huaweicloud.com>
 <20250814033522.770575-4-yukuai1@huaweicloud.com>
 <97b63163-a122-48f0-805a-a06cf792903f@linux.ibm.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <31a567ac-180a-b2de-2233-e758a9a977d8@huaweicloud.com>
Date: Fri, 15 Aug 2025 09:32:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <97b63163-a122-48f0-805a-a06cf792903f@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDnYhMmjp5oGnTfDg--.26725S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw1fKw17Xr4xuFWUuw4UArb_yoW8AFWfpa
	y3Ga12k340qr42kas2qanrXa47Kr4kAr1xCr43t3WayryDKFnFvr1rJw4UWryIvrs3Aw4x
	GF4UArZFvw1kZFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBF14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUpwZcUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2025/08/14 20:23, Nilay Shroff 写道:
> 
> 
> On 8/14/25 9:05 AM, Yu Kuai wrote:
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> 1) queue_requests_store() is the only caller of
>> blk_mq_update_nr_requests(), where queue is already freezed, no need to
>> check mq_freeze_depth;
>> 2) q->tag_set must be set for request_based device, and queue_is_mq() is
>> already checked in blk_mq_queue_attr_visible(), no need to check
>> q->tag_set.
>> 3) During initialization, hctx->tags in initialized before queue
>> kobject, and during del_gendisk, queue kobject is deleted before
>> exiting hctx, hence checking hctx->tags is useless.
>>
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>> ---
>>   block/blk-mq.c | 11 +----------
>>   1 file changed, 1 insertion(+), 10 deletions(-)
>>
>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>> index b67d6c02eceb..3a219b7b3688 100644
>> --- a/block/blk-mq.c
>> +++ b/block/blk-mq.c
>> @@ -4921,24 +4921,15 @@ int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr)
>>   {
>>   	struct blk_mq_tag_set *set = q->tag_set;
>>   	struct blk_mq_hw_ctx *hctx;
>> -	int ret;
>> +	int ret = 0;
>>   	unsigned long i;
>>   
>> -	if (WARN_ON_ONCE(!q->mq_freeze_depth))
>> -		return -EINVAL;
>> -
>> -	if (!set)
>> -		return -EINVAL;
>> -
>>   	if (q->nr_requests == nr)
>>   		return 0;
>>   
>>   	blk_mq_quiesce_queue(q);
>>   
>> -	ret = 0;
>>   	queue_for_each_hw_ctx(q, hctx, i) {
>> -		if (!hctx->tags)
>> -			continue;
> It's possible that hctx->tags is set to NULL in case no software
> queues are mapped to the hardware queue. So it seems that this
> check is valid. Please see blk_mq_map_swqueue().

Ok, thanks for the reviw.

I didn't notice this, just wonder how can this happen?
nr_hw_queues > NR_CPUS?

Thanks,
Kuai

> 
> Thanks,
> --Nilay
> 
> .
> 

