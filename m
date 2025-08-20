Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E05C18E025;
	Wed, 20 Aug 2025 00:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755651421; cv=none; b=qJI4vs4i2vvGuwkJn9rJFGvLoetxN5LFZBH+CFiym7sEcRPkxgiM+54Qp/M6dV3DJLH6X9n4lWP+AyriwACjI/zDfidPfrmpLinyOShZ4pPmYrE336U4dX9kED7hy7IR/U24U9r2IBIgzqh20d7HOEGMp4TnC9rF2T+JtsMSIbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755651421; c=relaxed/simple;
	bh=0HQCK7/5CZQFcRFDH6/1REzuymgJzXwhlRrUXL382Xk=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=n75k3rE/8ci5WzQIxioBcXq1qG4vFZ24wP1HZIQ4fjWqTGbICCeQZGvxJ/gMrhJe0lZ3hVaL4h8iv19xU1Sfn1yLD3X2h34/FKTIMLgWiJtflI4je2HxG/A/z9QGFUGyCbyn0huXpAQWx3vFkdU0uzQgudJioEwaE8Imrbznw9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4c67MD4NyNzYQtxB;
	Wed, 20 Aug 2025 08:56:56 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 2F9A81A09D6;
	Wed, 20 Aug 2025 08:56:55 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgAXkxNVHaVoUe0VEQ--.47546S3;
	Wed, 20 Aug 2025 08:56:54 +0800 (CST)
Subject: Re: [PATCH v2 1/2] blk-mq: fix elevator depth_updated method
To: Nilay Shroff <nilay@linux.ibm.com>, Yu Kuai <yukuai1@huaweicloud.com>,
 axboe@kernel.dk, bvanassche@acm.org, ming.lei@redhat.com, hare@suse.de
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 yi.zhang@huawei.com, yangerkun@huawei.com, johnny.chenyi@huawei.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20250819012917.523272-1-yukuai1@huaweicloud.com>
 <20250819012917.523272-2-yukuai1@huaweicloud.com>
 <f0abcc02-48c6-4d09-86d6-5ca8b968dcde@linux.ibm.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <0206ea4f-4efd-b7d0-088a-9257d06dcffb@huaweicloud.com>
Date: Wed, 20 Aug 2025 08:56:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <f0abcc02-48c6-4d09-86d6-5ca8b968dcde@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAXkxNVHaVoUe0VEQ--.47546S3
X-Coremail-Antispam: 1UD129KBjvJXoWxZrW8Gr43tFWrJw18Xw4xWFg_yoW7Jw1fpr
	ZxtanIkr1rtr47uF1Yy343Xr4rt39akry2yFsxtw1rtryq9Fs3XF1rGF1xXFWIvrZ5CF4x
	Jr10qa9rXr1IqFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

在 2025/08/19 20:20, Nilay Shroff 写道:
> 
> 
> On 8/19/25 6:59 AM, Yu Kuai wrote:
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> Current depth_updated has some problems:
>>
>> 1) depth_updated() will be called for each hctx, while all elevators
>> will update async_depth for the disk level, this is not related to hctx;
>> 2) In blk_mq_update_nr_requests(), if previous hctx update succeed and
>> this hctx update failed, q->nr_requests will not be updated, while
>> async_depth is already updated with new nr_reqeuests in previous
>> depth_updated();
>> 3) All elevators are using q->nr_requests to calculate async_depth now,
>> however, q->nr_requests is still the old value when depth_updated() is
>> called from blk_mq_update_nr_requests();
>>
>> Fix those problems by:
>>
>> - pass in request_queue instead of hctx;
>> - move depth_updated() after q->nr_requests is updated in
>>    blk_mq_update_nr_requests();
>> - add depth_updated() call in blk_mq_init_sched();
>> - remove init_hctx() method for mq-deadline and bfq that is useless now;
>>
>> Fixes: 77f1e0a52d26 ("bfq: update internal depth state when queue depth changes")
>> Fixes: 39823b47bbd4 ("block/mq-deadline: Fix the tag reservation code")
>> Fixes: 42e6c6ce03fd ("lib/sbitmap: convert shallow_depth from one word to the whole sbitmap")
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>> ---
>>   block/bfq-iosched.c   | 21 ++++-----------------
>>   block/blk-mq-sched.c  |  3 +++
>>   block/blk-mq-sched.h  | 11 +++++++++++
>>   block/blk-mq.c        | 23 ++++++++++++-----------
>>   block/elevator.h      |  2 +-
>>   block/kyber-iosched.c | 10 ++++------
>>   block/mq-deadline.c   | 15 ++-------------
>>   7 files changed, 37 insertions(+), 48 deletions(-)
>>
>> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
>> index 50e51047e1fe..c0c398998aa1 100644
>> --- a/block/bfq-iosched.c
>> +++ b/block/bfq-iosched.c
>> @@ -7109,9 +7109,10 @@ void bfq_put_async_queues(struct bfq_data *bfqd, struct bfq_group *bfqg)
>>    * See the comments on bfq_limit_depth for the purpose of
>>    * the depths set in the function. Return minimum shallow depth we'll use.
>>    */
>> -static void bfq_update_depths(struct bfq_data *bfqd, struct sbitmap_queue *bt)
>> +static void bfq_depth_updated(struct request_queue *q)
>>   {
>> -	unsigned int nr_requests = bfqd->queue->nr_requests;
>> +	struct bfq_data *bfqd = q->elevator->elevator_data;
>> +	unsigned int nr_requests = q->nr_requests;
>>   
>>   	/*
>>   	 * In-word depths if no bfq_queue is being weight-raised:
>> @@ -7143,21 +7144,8 @@ static void bfq_update_depths(struct bfq_data *bfqd, struct sbitmap_queue *bt)
>>   	bfqd->async_depths[1][0] = max((nr_requests * 3) >> 4, 1U);
>>   	/* no more than ~37% of tags for sync writes (~20% extra tags) */
>>   	bfqd->async_depths[1][1] = max((nr_requests * 6) >> 4, 1U);
>> -}
>> -
>> -static void bfq_depth_updated(struct blk_mq_hw_ctx *hctx)
>> -{
>> -	struct bfq_data *bfqd = hctx->queue->elevator->elevator_data;
>> -	struct blk_mq_tags *tags = hctx->sched_tags;
>>   
>> -	bfq_update_depths(bfqd, &tags->bitmap_tags);
>> -	sbitmap_queue_min_shallow_depth(&tags->bitmap_tags, 1);
>> -}
>> -
>> -static int bfq_init_hctx(struct blk_mq_hw_ctx *hctx, unsigned int index)
>> -{
>> -	bfq_depth_updated(hctx);
>> -	return 0;
>> +	blk_mq_set_min_shallow_depth(q, 1);
>>   }
>>   
>>   static void bfq_exit_queue(struct elevator_queue *e)
>> @@ -7628,7 +7616,6 @@ static struct elevator_type iosched_bfq_mq = {
>>   		.request_merged		= bfq_request_merged,
>>   		.has_work		= bfq_has_work,
>>   		.depth_updated		= bfq_depth_updated,
>> -		.init_hctx		= bfq_init_hctx,
>>   		.init_sched		= bfq_init_queue,
>>   		.exit_sched		= bfq_exit_queue,
>>   	},
>> diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
>> index e2ce4a28e6c9..bf7dd97422ec 100644
>> --- a/block/blk-mq-sched.c
>> +++ b/block/blk-mq-sched.c
>> @@ -585,6 +585,9 @@ int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e,
>>   			}
>>   		}
>>   	}
>> +
>> +	if (e->ops.depth_updated)
>> +		e->ops.depth_updated(q);
>>   	return 0;
>>   
> 
> Overall changes look good. That said, I think it might be cleaner to structure
> it this way:
> 
> elevator_switch -> blk_mq_init_sched ->init_sched ==> sets async_depth
> blk_mq_update_nr_requests ->depth_updated ==> updates async_depth
> 
> This way, we don’t need to call ->depth_updated from blk_mq_init_sched.

Just to be sure, you mean calling the depth_updated method directly
inside the init_sched() method? This is indeed cleaner, each elevator
has to use this method to initialize async_dpeth.
> 
> In summary:
> - Avoid calling ->depth_updated during blk_mq_init_sched
> - Set async_depth when the elevator is initialized (via ->init_sched)
> - Update async_depth when nr_requests is modified through sysfs (via ->depth_updated)
> 
> Thanks,
> --Nilay
> .
> 

Thanks,
Kuai

