Return-Path: <gqjiang@suse.com>
Subject: Re: [PATCH BUGFIX V2 1/2] block, bfq: put async queues for root bfq
 groups too
To: Paolo Valente <paolo.valente@linaro.org>, Guoqing Jiang <gqjiang@suse.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block <linux-block@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>, Mark Brown <broonie@kernel.org>,
 linus.walleij@linaro.org, bfq-iosched@googlegroups.com,
 oleksandr@natalenko.name, 162996@studenti.unimore.it,
 Davide Ferrari <davideferrari8@gmail.com>
References: <20180109092759.5454-1-paolo.valente@linaro.org>
 <20180109092759.5454-2-paolo.valente@linaro.org>
 <b24f17b0-7594-fd78-fdc7-85ffabbc2fed@suse.com>
 <D75A2C53-9012-481B-986B-88F9040A3FB3@linaro.org>
From: Guoqing Jiang <gqjiang@suse.com>
Message-ID: <c885b566-9a3d-4a82-015b-a6f71e6ce1a3@suse.com>
Date: Wed, 10 Jan 2018 14:31:37 +0800
MIME-Version: 1.0
In-Reply-To: <D75A2C53-9012-481B-986B-88F9040A3FB3@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>



On 01/10/2018 02:13 PM, Paolo Valente wrote:
>
>> Il giorno 10 gen 2018, alle ore 02:41, Guoqing Jiang <gqjiang@suse.com> ha scritto:
>>
>>
>>
>> On 01/09/2018 05:27 PM, Paolo Valente wrote:
>>> For each pair [device for which bfq is selected as I/O scheduler,
>>> group in blkio/io], bfq maintains a corresponding bfq group. Each such
>>> bfq group contains a set of async queues, with each async queue
>>> created on demand, i.e., when some I/O request arrives for it.  On
>>> creation, an async queue gets an extra reference, to make sure that
>>> the queue is not freed as long as its bfq group exists.  Accordingly,
>>> to allow the queue to be freed after the group exited, this extra
>>> reference must released on group exit.
>>>
>>> The above holds also for a bfq root group, i.e., for the bfq group
>>> corresponding to the root blkio/io root for a given device. Yet, by
>>> mistake, the references to the existing async queues of a root group
>>> are not released when the latter exits. This causes a memory leak when
>>> the instance of bfq for a given device exits. In a similar vein,
>>> bfqg_stats_xfer_dead is not executed for a root group.
>>>
>>> This commit fixes bfq_pd_offline so that the latter executes the above
>>> missing operations for a root group too.
>>>
>>> Reported-by: Holger Hoffstätte <holger@applied-asynchrony.com>
>>> Reported-by: Guoqing Jiang <gqjiang@suse.com>
>>> Signed-off-by: Davide Ferrari <davideferrari8@gmail.com>
>>> Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
>>> ---
>>>   block/bfq-cgroup.c | 7 +++++--
>>>   1 file changed, 5 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
>>> index da1525ec4c87..d819dc77fe65 100644
>>> --- a/block/bfq-cgroup.c
>>> +++ b/block/bfq-cgroup.c
>>> @@ -775,10 +775,11 @@ static void bfq_pd_offline(struct blkg_policy_data *pd)
>>>   	unsigned long flags;
>>>   	int i;
>>>   +	spin_lock_irqsave(&bfqd->lock, flags);
>>> +
>>>   	if (!entity) /* root group */
>>> -		return;
>>> +		goto put_async_queues;
>>>   -	spin_lock_irqsave(&bfqd->lock, flags);
>>>   	/*
>>>   	 * Empty all service_trees belonging to this group before
>>>   	 * deactivating the group itself.
>>> @@ -809,6 +810,8 @@ static void bfq_pd_offline(struct blkg_policy_data *pd)
>>>   	}
>>>     	__bfq_deactivate_entity(entity, false);
>>> +
>>> +put_async_queues:
>>>   	bfq_put_async_queues(bfqd, bfqg);
>>>     	spin_unlock_irqrestore(&bfqd->lock, flags);
>> With this change, bfqg_stats_xfer_dead will be called even entity is not existed,
> Actually, the entity associated with the bfq group being offlined
> exists even if the local variable entity is NULL here.  Simply, that
> variable gets NULL if the bfq group is the bfq root group for a
> device.
>
>> is it necessary?
> No, I opted for this solution to not shake the code too much, and
> considering that
> - bfqg_stats_xfer_dead simply does nothing if applied
> to a root group
> - who knows, in the future that function may need
> do be invoked for a root group too.
>
> Yet, if you guys think that it would be cleaner to not invoke
> bfqg_stats_xfer_dead at all for a root group, I'll change the code
> accordingly (this would introduce a little asymmetry with
> cfq_pd_offline, which invokes cfqg_stats_xfer_dead unconditionally).

Thanks a lot for the explanation, I am fine with it.

Acked-by: Guoqing Jiang <gqjiang@suse.com>

Regards,
Guoqing
