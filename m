Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D576423AD
	for <linux-block@vger.kernel.org>; Sat, 16 Aug 2025 01:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755306068; cv=none; b=gGkg5OFnLjvgikduFQSvImNLbJr1M91hEgGzX1JH1sO0W062lzttDoT6pOhogOR08zJI9bkc0f9D4g41AbZXjOd0lHHUtQK2W8xojhC5yeW7tBgfVRrXuO0V4BSiFBqlk9CR12D+4j+boH6mxLL9ywf2Vc6Ia7keuZQ1PgHBZ7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755306068; c=relaxed/simple;
	bh=cFYTFy0vh+HCyvPgC0mrSFwwf7B8MnTrpz1h3fJryi0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qZkRZfZ7xXGeWFIlJg59WubcZQJ0CVh6TYa+Jf3F55Q+v3et3D46zXF/oA8dIFjbklntyESl+xYBhQIImyYqLdLlBjVG4l+Bq1aL2qFtY2gCgT6FGDOTdjHicoc0WIVkllTwuEf8smkou5djVjDkuHl7luCXurdI01h9EtW3Dys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vNs9gul6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vNs9gul6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 490EBC4CEEB;
	Sat, 16 Aug 2025 01:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755306068;
	bh=cFYTFy0vh+HCyvPgC0mrSFwwf7B8MnTrpz1h3fJryi0=;
	h=Date:Reply-To:Subject:To:Cc:References:From:In-Reply-To:From;
	b=vNs9gul60UZWuX43hXZY6DdnNr7FezlspYetwsp4dQA8gW+kHUi+jLNi6+vndJ9Si
	 zvE+HKi7QExXQaQbDLzWpvtGS3tLMqhV4L/IaqbQ2uSjVv6fwcGBil/bjMxOFb9Iuw
	 9mQdVlD0RHvE90KMB7UzZNlhmPExnQ+5afMIPkuRzYrIUSO5bWBS+X2DocvQb7cGWM
	 m+SU8hQhv5RmD/GiRfqejdepcdCsVpmrOnf9a9KmbNH9/qjt+qWdSn9dW5YFWVoRz0
	 IMWieVTMK6vpT6Z3UcdHtnSPFYtO9JkPkWkCKbgiGw6KEwpnMpPKAb2IxIMZ9Sc8yk
	 Rxf0DxgocUOjQ==
Message-ID: <f80fb115-9098-4d62-be5f-e0e421bde9c3@kernel.org>
Date: Sat, 16 Aug 2025 09:01:03 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: yukuai@kernel.org
Subject: Re: [PATCHv3 3/3] block: avoid cpu_hotplug_lock depedency on
 freeze_lock
To: Nilay Shroff <nilay@linux.ibm.com>, Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, axboe@kernel.dk, yukuai1@huaweicloud.com,
 hch@lst.de, shinichiro.kawasaki@wdc.com, kch@nvidia.com, gjoyce@ibm.com
References: <20250814082612.500845-1-nilay@linux.ibm.com>
 <20250814082612.500845-4-nilay@linux.ibm.com> <aJ3aR2JodRrAqVcO@fedora>
 <e125025b-d576-4919-b00e-5d9b640bed77@linux.ibm.com>
 <aJ3myQW2A8HtteBC@fedora>
 <e33e97f7-0c12-4f70-81d0-4fea05557579@linux.ibm.com>
 <aJ57lZLhktXxaBoh@fedora>
 <16975629-4988-4841-86bb-d4f3f40cc849@linux.ibm.com>
 <aJ80-lNF-ilorQq8@fedora>
 <c6cf9190-0e23-4db3-a85d-d7f62cd3f568@linux.ibm.com>
From: Yu Kuai <yukuai@kernel.org>
In-Reply-To: <c6cf9190-0e23-4db3-a85d-d7f62cd3f568@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

在 2025/8/16 2:33, Nilay Shroff 写道:
>
> On 8/15/25 6:54 PM, Ming Lei wrote:
>> On Fri, Aug 15, 2025 at 03:13:19PM +0530, Nilay Shroff wrote:
>>>
>>> On 8/15/25 5:43 AM, Ming Lei wrote:
>>>> On Thu, Aug 14, 2025 at 08:01:11PM +0530, Nilay Shroff wrote:
>>>>>
>>>>> On 8/14/25 7:08 PM, Ming Lei wrote:
>>>>>> On Thu, Aug 14, 2025 at 06:27:08PM +0530, Nilay Shroff wrote:
>>>>>>>
>>>>>>> On 8/14/25 6:14 PM, Ming Lei wrote:
>>>>>>>> On Thu, Aug 14, 2025 at 01:54:59PM +0530, Nilay Shroff wrote:
>>>>>>>>> A recent lockdep[1] splat observed while running blktest block/005
>>>>>>>>> reveals a potential deadlock caused by the cpu_hotplug_lock dependency
>>>>>>>>> on ->freeze_lock. This dependency was introduced by commit 033b667a823e
>>>>>>>>> ("block: blk-rq-qos: guard rq-qos helpers by static key").
>>>>>>>>>
>>>>>>>>> That change added a static key to avoid fetching q->rq_qos when
>>>>>>>>> neither blk-wbt nor blk-iolatency is configured. The static key
>>>>>>>>> dynamically patches kernel text to a NOP when disabled, eliminating
>>>>>>>>> overhead of fetching q->rq_qos in the I/O hot path. However, enabling
>>>>>>>>> a static key at runtime requires acquiring both cpu_hotplug_lock and
>>>>>>>>> jump_label_mutex. When this happens after the queue has already been
>>>>>>>>> frozen (i.e., while holding ->freeze_lock), it creates a locking
>>>>>>>>> dependency from cpu_hotplug_lock to ->freeze_lock, which leads to a
>>>>>>>>> potential deadlock reported by lockdep [1].
>>>>>>>>>
>>>>>>>>> To resolve this, replace the static key mechanism with q->queue_flags:
>>>>>>>>> QUEUE_FLAG_QOS_ENABLED. This flag is evaluated in the fast path before
>>>>>>>>> accessing q->rq_qos. If the flag is set, we proceed to fetch q->rq_qos;
>>>>>>>>> otherwise, the access is skipped.
>>>>>>>>>
>>>>>>>>> Since q->queue_flags is commonly accessed in IO hotpath and resides in
>>>>>>>>> the first cacheline of struct request_queue, checking it imposes minimal
>>>>>>>>> overhead while eliminating the deadlock risk.
>>>>>>>>>
>>>>>>>>> This change avoids the lockdep splat without introducing performance
>>>>>>>>> regressions.
>>>>>>>>>
>>>>>>>>> [1] https://lore.kernel.org/linux-block/4fdm37so3o4xricdgfosgmohn63aa7wj3ua4e5vpihoamwg3ui@fq42f5q5t5ic/
>>>>>>>>>
>>>>>>>>> Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
>>>>>>>>> Closes: https://lore.kernel.org/linux-block/4fdm37so3o4xricdgfosgmohn63aa7wj3ua4e5vpihoamwg3ui@fq42f5q5t5ic/
>>>>>>>>> Fixes: 033b667a823e ("block: blk-rq-qos: guard rq-qos helpers by static key")
>>>>>>>>> Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
>>>>>>>>> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
>>>>>>>>> ---
>>>>>>>>>   block/blk-mq-debugfs.c |  1 +
>>>>>>>>>   block/blk-rq-qos.c     |  9 ++++---
>>>>>>>>>   block/blk-rq-qos.h     | 54 ++++++++++++++++++++++++------------------
>>>>>>>>>   include/linux/blkdev.h |  1 +
>>>>>>>>>   4 files changed, 37 insertions(+), 28 deletions(-)
>>>>>>>>>
>>>>>>>>> diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
>>>>>>>>> index 7ed3e71f2fc0..32c65efdda46 100644
>>>>>>>>> --- a/block/blk-mq-debugfs.c
>>>>>>>>> +++ b/block/blk-mq-debugfs.c
>>>>>>>>> @@ -95,6 +95,7 @@ static const char *const blk_queue_flag_name[] = {
>>>>>>>>>   	QUEUE_FLAG_NAME(SQ_SCHED),
>>>>>>>>>   	QUEUE_FLAG_NAME(DISABLE_WBT_DEF),
>>>>>>>>>   	QUEUE_FLAG_NAME(NO_ELV_SWITCH),
>>>>>>>>> +	QUEUE_FLAG_NAME(QOS_ENABLED),
>>>>>>>>>   };
>>>>>>>>>   #undef QUEUE_FLAG_NAME
>>>>>>>>>   
>>>>>>>>> diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
>>>>>>>>> index b1e24bb85ad2..654478dfbc20 100644
>>>>>>>>> --- a/block/blk-rq-qos.c
>>>>>>>>> +++ b/block/blk-rq-qos.c
>>>>>>>>> @@ -2,8 +2,6 @@
>>>>>>>>>   
>>>>>>>>>   #include "blk-rq-qos.h"
>>>>>>>>>   
>>>>>>>>> -__read_mostly DEFINE_STATIC_KEY_FALSE(block_rq_qos);
>>>>>>>>> -
>>>>>>>>>   /*
>>>>>>>>>    * Increment 'v', if 'v' is below 'below'. Returns true if we succeeded,
>>>>>>>>>    * false if 'v' + 1 would be bigger than 'below'.
>>>>>>>>> @@ -319,8 +317,8 @@ void rq_qos_exit(struct request_queue *q)
>>>>>>>>>   		struct rq_qos *rqos = q->rq_qos;
>>>>>>>>>   		q->rq_qos = rqos->next;
>>>>>>>>>   		rqos->ops->exit(rqos);
>>>>>>>>> -		static_branch_dec(&block_rq_qos);
>>>>>>>>>   	}
>>>>>>>>> +	blk_queue_flag_clear(QUEUE_FLAG_QOS_ENABLED, q);
>>>>>>>>>   	mutex_unlock(&q->rq_qos_mutex);
>>>>>>>>>   }
>>>>>>>>>   
>>>>>>>>> @@ -346,7 +344,7 @@ int rq_qos_add(struct rq_qos *rqos, struct gendisk *disk, enum rq_qos_id id,
>>>>>>>>>   		goto ebusy;
>>>>>>>>>   	rqos->next = q->rq_qos;
>>>>>>>>>   	q->rq_qos = rqos;
>>>>>>>>> -	static_branch_inc(&block_rq_qos);
>>>>>>>>> +	blk_queue_flag_set(QUEUE_FLAG_QOS_ENABLED, q);
>>>>>>>> One stupid question: can we simply move static_branch_inc(&block_rq_qos)
>>>>>>>> out of queue freeze in rq_qos_add()?
>>>>>>>>
>>>>>>>> What matters is just the 1st static_branch_inc() which switches the counter
>>>>>>>> from 0 to 1, when blk_mq_freeze_queue() guarantees that all in-progress code
>>>>>>>> paths observe q->rq_qos as NULL. That means static_branch_inc(&block_rq_qos)
>>>>>>>> needn't queue freeze protection.
>>>>>>>>
>>>>>>> I thought about it earlier but that won't work because we have
>>>>>>> code paths freezing queue before it reaches upto rq_qos_add(),
>>>>>>> For instance:
>>>>>>>
>>>>>>> We have following code paths from where we invoke
>>>>>>> rq_qos_add() APIs with queue already frozen:
>>>>>>>
>>>>>>> ioc_qos_write()
>>>>>>>   -> blkg_conf_open_bdev_frozen() => freezes queue
>>>>>>>   -> blk_iocost_init()
>>>>>>>     -> rq_qos_add()
>>>>>>>
>>>>>>> queue_wb_lat_store()  => freezes queue
>>>>>>>   -> wbt_init()
>>>>>>>    -> rq_qos_add()
>>>>>> The above two shouldn't be hard to solve, such as, add helper
>>>>>> rq_qos_prep_add() for increasing the static branch counter.
>>>>>>
>>>>> Yes but then it means that IOs which would be in flight
>>>>> would take a hit in hotpath: In hotpath those IOs
>>>>> would evaluate static key branch to true and then fetch
>>>>> q->rq_qos (which probably would not be in the first
>>>>> cacheline). So are we okay to take hat hit in IO
>>>>> hotpath?
>>>> But it is that in-tree code is doing, isn't it?
>>>>
>>>> `static branch` is only evaluated iff at least one rqos is added.
>>>>
>>> In the current in-tree implementation, the static branch is evaluated
>>> only if at least one rq_qos is added.
>>>
>>> Per you suggested change, we would increment the static branch key before
>>> freezing the queue (and before attaching the QoS policy to the request queue).
>>> This means that any I/O already in flight would see the static branch key
>>> as enabled and would proceed to fetch q->rq_qos, even though q->rq_qos would
>>> still be NULL at that point since the QoS policy hasn’t yet been attached.
>>> This results in a performance penalty due to the additional q->rq_qos fetch.
>>>
>>> In contrast, the current tree avoids this penalty. The existing sequence is:
>>> - Freeze the queue.
>>> - Attach the QoS policy to the queue (q->rq_qos becomes non-NULL).
>>> - Increment the static branch key.
>>> - Unfreeze the queue.
>>>
>>> With this ordering, if the hotpath finds the static branch key enabled, it is
>>> guaranteed that q->rq_qos is non-NULL. Thus, we either:
>>> - Skip evaluating the static branch key (and q->rq_qos) entirely, or
>>> - If the static branch key is enabled, also have a valid q->rq_qos.
>>>
>>> In summary, it appears that your proposed ordering introduces a window where the
>>> static branch key is enabled but q->rq_qos is still NULL, incurring unnecessary
>>> fetch overhead in the I/O hotpath.
>> Yes, but the window is pretty small, so the extra overhead isn't something
>> matters. More importantly it shows correct static_branch_*() usage, which is
>> supposed to be called safely without subsystem lock.
>>
> I see your point about static_branch_*() usage being independent of the subsystem
> lock, but in this case that “small window” still sits directly in the I/O hotpath
> and will be hit by all in-flight requests during queue freeze. The current ordering
> is intentionally structured so that:
>
> 1. The branch is only enabled after q->rq_qos is guaranteed non-NULL.
> 2. Any hotpath evaluation of the static key implies a valid pointer
>     dereference with no wasted cache miss.
> Even if the window is short, we’d still pay for unnecessary q->rq_qos loads and
> possible cacheline misses for every inflight I/O during that period. In practice,
> that’s why this patch replaces the static key with a queue_flags bit: it’s lock-
> free to update, eliminates the deadlock risk, and preserves the “no penalty until
> active” property without depending on lock ordering subtlety.
>
> Having said that, I’m not opposed to reworking the patch per your proposal if
> all agree the minor hotpath cost is acceptable, but wanted to make sure the
> trade-off is clear.

I'm good with this set, you already have my review :)

BTW, this set have another advantage that the flag is per disk, the 
static branch

can only optimize when all the disks in the system doesn't enable 
rq_qos, is one

disk enable it, all disks in the system that doesn't have rq_qos enabled 
will all suffer

from the additional cacheline load.


Thanks

Kuai

>
> Thanks,
> --Nilay
>
>
