Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553542957C2;
	Fri, 15 Aug 2025 01:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755222871; cv=none; b=Jq5uEk1Fv7cRdfkhCqeDpbnfdRGlqlcbQpvG77hJuRdYae8qgbO9pXPk3wWcarzSP/nJ4B29I/NZNax46+XJtONPwVwXoUK9w+pSB3H/vnSacPwPcG0IKQRaLD+Nf+vdhGYMHzz1romTpU464uBYeWn/0faTOxGUF2fFBAz/4RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755222871; c=relaxed/simple;
	bh=n0Fo5gVgJ61eZRSjEgyMALqOkJHS6uPHNNL/ACeCPYI=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=QDG8CkZIjm81sH01o5d4IhqF6Zb/Q+tzRIBOB4AgylzIw8qcpFRwRNmn3p7z9XvDWcilFgTQPkuzBiqXYeMtvZhscG2gmusu/Kb6ZI2OCI5HJw292NYniJzqlA0ym0WxSd+n8M7Ehbxx16WdGGuy16yxzJuZmp1tpvURhO6aj6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4c34sv5H5vzYQvHG;
	Fri, 15 Aug 2025 09:54:27 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 5717D1A18C9;
	Fri, 15 Aug 2025 09:54:26 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgC3MxROk55ocS7hDg--.29912S3;
	Fri, 15 Aug 2025 09:54:24 +0800 (CST)
Subject: Re: [PATCH 08/16] blk-mq: fix blk_mq_tags double free while
 nr_requests grown
To: Nilay Shroff <nilay@linux.ibm.com>, Yu Kuai <yukuai1@huaweicloud.com>,
 axboe@kernel.dk, bvanassche@acm.org, hare@suse.de, ming.lei@redhat.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 yi.zhang@huawei.com, yangerkun@huawei.com, johnny.chenyi@huawei.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20250814033522.770575-1-yukuai1@huaweicloud.com>
 <20250814033522.770575-9-yukuai1@huaweicloud.com>
 <822e6a29-7340-4c79-a23e-ff9221cac74f@linux.ibm.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <2e2da599-b67d-251a-e0d1-348e9208675b@huaweicloud.com>
Date: Fri, 15 Aug 2025 09:54:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <822e6a29-7340-4c79-a23e-ff9221cac74f@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgC3MxROk55ocS7hDg--.29912S3
X-Coremail-Antispam: 1UD129KBjvJXoWxZFWfGryUZFy3tw47Wr4UArb_yoW5ur1UpF
	W5Wa1akry5tr17Zay2g347X34ftws7Wr13Gr4ftryrArn0krn2kr48uw4jgFW0vrs7CFsr
	Kr1DJF97X34qqa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

在 2025/08/14 20:15, Nilay Shroff 写道:
> 
> 
> On 8/14/25 9:05 AM, Yu Kuai wrote:
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> In the case user trigger tags grow by queue sysfs attribute nr_requests,
>> hctx->sched_tags will be freed directly and replaced with a new
>> allocated tags, see blk_mq_tag_update_depth().
>>
>> The problem is that hctx->sched_tags is from elevator->et->tags, while
>> et->tags is still the freed tags, hence later elevator exist will try to
>> free the tags again, causing kernel panic.
>>
>> Fix this problem by using new halper blk_mq_alloc_sched_tags() to
>> allocate a new sched_tags. Meanwhile, there is a longterm problem can be
>> fixed as well:
>>
>> If blk_mq_tag_update_depth() succeed for previous hctx, then bitmap depth
>> is updated, however, if following hctx failed, q->nr_requests is not
>> updated and the previous hctx->sched_tags endup bigger than q->nr_requests.
>>
>> Fixes: f5a6604f7a44 ("block: fix lockdep warning caused by lock dependency in elv_iosched_store")
>> Fixes: e3a2b3f931f5 ("blk-mq: allow changing of queue depth through sysfs")
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>> ---
>>   block/blk-mq.c | 31 ++++++++++++++++++++-----------
>>   1 file changed, 20 insertions(+), 11 deletions(-)
>>
>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>> index a7d6a20c1524..f1c11f591c27 100644
>> --- a/block/blk-mq.c
>> +++ b/block/blk-mq.c
>> @@ -4917,6 +4917,23 @@ void blk_mq_free_tag_set(struct blk_mq_tag_set *set)
>>   }
>>   EXPORT_SYMBOL(blk_mq_free_tag_set);
>>   
>> +static int blk_mq_sched_grow_tags(struct request_queue *q, unsigned int nr)
>> +{
>> +	struct elevator_tags *et =
>> +		blk_mq_alloc_sched_tags(q->tag_set, q->nr_hw_queues, nr);
>> +	struct blk_mq_hw_ctx *hctx;
>> +	unsigned long i;
>> +
>> +	if (!et)
>> +		return -ENOMEM;
>> +
>> +	blk_mq_free_sched_tags(q->elevator->et, q->tag_set);
>> +	queue_for_each_hw_ctx(q, hctx, i)
>> +		hctx->sched_tags = et->tags[i];
>> +	q->elevator->et = et;
>> +	return 0;
>> +}
>> +
> I see that we're allocating/freeing sched tags here after we freeze the
> queue and acquire ->elevator_lock. And so this shall cause the lockdep
> splat we saw earlier[1]. I'm not saying that your proposed change would
> cause it, but I think this is one of the code path which we missed to
> handle. So when you're at it, please ensure that we don't get into this
> splat again. We've already fixed this splat from another code paths
> (elevator change and nr_hw_queue update) but it seems we also need to
> handle that case here as well.

Thanks for pointing this, I was thinking the gfp flags inside
blk_mq_alloc_sched_tags will be enough to prevent deadlock related to 
fs_reclaim. I still need to review a lot to catch up.

Looks I need to allocate memory before freezing the queue from
queue_requests_store, I think this is fine with prevrious cleanups and
we'll know excatly if memory allocation is necessary.

BTW, just curious, do we plan or have documents anywhere to explain the
lock ordering? It will be much easier for people like me to add new code
around.

Thanks
Kuai

> 
> [1] https://lore.kernel.org/all/0659ea8d-a463-47c8-9180-43c719e106eb@linux.ibm.com/
> 
> Thanks,
> --Nilay
> .
> 

