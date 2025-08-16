Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A663EA8D;
	Sat, 16 Aug 2025 02:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755313048; cv=none; b=IHAbfYLhZavDDQurC4hOXqYzfEnsbyi+vLw2SSSRcHya1T6HR3ZIWLzqgcnYQOgTKvI4tshZi4wsLzbnJt5r/PpwQVtf2iN6Pw7BXNHUOrJ0Gf7et9U9g0orhbwQNYLQkg0c2x4QxzVPHPzKspN4c+OyvW8zOfHuv5jqAQHi6TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755313048; c=relaxed/simple;
	bh=9+X2ZEiERK6NjxysThGLD5jYBovImzJ0hxY0qwiJ3ns=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fPH7o8U6RAlysHfbruVLFsVSpSaao5i8LAOIIbhUJss9w3SJ0x1JSzTIQE28gm+OaCwE4adiZwlgdCWMknh/x8ujS8chJQqNFAVUqIuR3W3i67RkNe35kw21OISG7BvCeulX1c+b4dqVWCweC9mpboRVETHPjDu6iBARdHHCgMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S4RKmj4Y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S4RKmj4Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5DDFC4CEEB;
	Sat, 16 Aug 2025 02:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755313048;
	bh=9+X2ZEiERK6NjxysThGLD5jYBovImzJ0hxY0qwiJ3ns=;
	h=Date:Reply-To:Subject:To:Cc:References:From:In-Reply-To:From;
	b=S4RKmj4YzpBNdZ/i/vZidoCwib+WQn/HXEt9KErw4ttLhyaFo4Il9h/vrTMpMAlR6
	 2MFXNEWo7Gz2Myjk/Cv8Nu/T88BNJgJwTQdHScqdHqprAv1SxNKqK7VaGN3PHnIQFU
	 /LI9492heNA3r6bPu40l8LMvyOEdwMi58fO7VJHTjjn3TgUt9FYZZlaA7/9TivrRoT
	 4Y1AphaQB3qlCRPVKakgdRMlS5I61H8vfzLFNYO0RwEyjKw1n+XGnyqejzJidMTNre
	 dqbwsDnXuVtvbUcYeHZnW4LGqGYikZZFqww8Dea+/NajH4AZrrBXhpR/0HRGJUUjdF
	 o80/mzvJ46dHQ==
Message-ID: <af40ef99-9b61-4725-ba77-c5d3741add99@kernel.org>
Date: Sat, 16 Aug 2025 10:57:23 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: yukuai@kernel.org
Subject: Re: [PATCH 08/10] blk-mq: fix blk_mq_tags double free while
 nr_requests grown
To: Nilay Shroff <nilay@linux.ibm.com>, Yu Kuai <yukuai1@huaweicloud.com>,
 axboe@kernel.dk, hare@suse.de, ming.lei@redhat.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com,
 johnny.chenyi@huawei.com
References: <20250815080216.410665-1-yukuai1@huaweicloud.com>
 <20250815080216.410665-9-yukuai1@huaweicloud.com>
 <c5e63966-e7f6-4d82-9d66-3a0abccc9d17@linux.ibm.com>
From: Yu Kuai <yukuai@kernel.org>
In-Reply-To: <c5e63966-e7f6-4d82-9d66-3a0abccc9d17@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

在 2025/8/16 3:30, Nilay Shroff 写道:
>
> On 8/15/25 1:32 PM, Yu Kuai wrote:
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
>> Fix this problem by using new allocated elevator_tags, also convert
>> blk_mq_update_nr_requests to void since this helper will never fail now.
>>
>> Meanwhile, there is a longterm problem can be fixed as well:
>>
>> If blk_mq_tag_update_depth() succeed for previous hctx, then bitmap depth
>> is updated, however, if following hctx failed, q->nr_requests is not
>> updated and the previous hctx->sched_tags endup bigger than q->nr_requests.
>>
>> Fixes: f5a6604f7a44 ("block: fix lockdep warning caused by lock dependency in elv_iosched_store")
>> Fixes: e3a2b3f931f5 ("blk-mq: allow changing of queue depth through sysfs")
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>> ---
>>   block/blk-mq.c    | 19 ++++++-------------
>>   block/blk-mq.h    |  4 +++-
>>   block/blk-sysfs.c | 21 ++++++++++++++-------
>>   3 files changed, 23 insertions(+), 21 deletions(-)
>>
>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>> index 11c8baebb9a0..e9f037a25fe3 100644
>> --- a/block/blk-mq.c
>> +++ b/block/blk-mq.c
>> @@ -4917,12 +4917,12 @@ void blk_mq_free_tag_set(struct blk_mq_tag_set *set)
>>   }
>>   EXPORT_SYMBOL(blk_mq_free_tag_set);
>>   
>> -int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr)
>> +void blk_mq_update_nr_requests(struct request_queue *q,
>> +			       struct elevator_tags *et, unsigned int nr)
>>   {
>>   	struct blk_mq_tag_set *set = q->tag_set;
>>   	struct blk_mq_hw_ctx *hctx;
>>   	unsigned long i;
>> -	int ret = 0;
>>   
>>   	blk_mq_quiesce_queue(q);
>>   
>> @@ -4946,24 +4946,17 @@ int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr)
>>   				nr - hctx->sched_tags->nr_reserved_tags);
>>   		}
>>   	} else {
>> -		queue_for_each_hw_ctx(q, hctx, i) {
>> -			if (!hctx->tags)
>> -				continue;
>> -			ret = blk_mq_tag_update_depth(hctx, &hctx->sched_tags,
>> -						      nr);
>> -			if (ret)
>> -				goto out;
>> -		}
>> +		blk_mq_free_sched_tags(q->elevator->et, set);
> I think you also need to ensure that elevator tags are freed after we unfreeze
> queue and release ->elevator_lock otherwise we may get into the lockdep splat
> for pcpu_lock dependency on ->freeze_lock and/or ->elevator_lock. Please note
> that blk_mq_free_sched_tags internally invokes sbitmap_free which invokes
> free_percpu which acquires pcpu_lock.

Ok, thanks for the notice. However, as Ming suggested, we might fix this 
problem

in the next merge window. I'll send one patch to fix this regression by 
replace

st->tags with reallocated new sched_tags as well.


Thanks,

Kuai

>   
> Thanks,
> --Nilay
>
>
>
