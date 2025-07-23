Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF837EAD7
	for <linux-block@vger.kernel.org>; Wed, 23 Jul 2025 00:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753231075; cv=none; b=DKnMufLx8ugys2ic2TDIat9pJ9YV+ZiO6wsELNf1RR+DDNFU+kLjOaQmhMOuEkMpk7EUtHPW++oL9UbeK0FPfUPiCJ+lPpsDisWc+y0m/3UMTrw6JV/qxKeFnLsM4Ums0lzMJbEXil47kp6Ckg5gPzqpDcd/D0tQ7ZDbgopCfnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753231075; c=relaxed/simple;
	bh=FY4+48/YFtHAVwNfu/7TY+arwMAYaTmUMz5fISMjaac=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=nxIDrN/z8LrZgZ2xgwdEBAVtOjnSzvAKO0NEgUPLq9O5MSjvDrNjQ61UkLwUv8tQiu5cSOegKfhKXTaSewreYLKX6QK2SOky9UpIXfL4lYUx5jfwbP82cDZ4cFx1pNM5/WCGJEQ5zNoZb9b26MKozShqTPAlkQe1snDK3CI9e7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bmwG664tVzKHNQ7
	for <linux-block@vger.kernel.org>; Wed, 23 Jul 2025 08:37:50 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 906881A0F1E
	for <linux-block@vger.kernel.org>; Wed, 23 Jul 2025 08:37:49 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP2 (Coremail) with SMTP id Syh0CgDnpbfbLoBoFZGdBA--.63724S3;
	Wed, 23 Jul 2025 08:37:49 +0800 (CST)
Subject: Re: [PATCHv2] block: restore two stage elevator switch while running
 nr_hw_queue update
To: Nilay Shroff <nilay@linux.ibm.com>, Yu Kuai <yukuai1@huaweicloud.com>,
 linux-block@vger.kernel.org
Cc: yi.zhang@redhat.com, ming.lei@redhat.com, hch@lst.de, axboe@kernel.dk,
 shinichiro.kawasaki@wdc.com, gjoyce@ibm.com, "yukuai (C)"
 <yukuai3@huawei.com>
References: <20250718133232.626418-1-nilay@linux.ibm.com>
 <b7cc0c1c-6027-4f1a-8ca1-e7ac4ae9e5ec@huaweicloud.com>
 <43099391-2279-473d-8c13-70486b96f50f@linux.ibm.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <c339715d-4a4b-0a4a-4d53-86eabe7b5d97@huaweicloud.com>
Date: Wed, 23 Jul 2025 08:37:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <43099391-2279-473d-8c13-70486b96f50f@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgDnpbfbLoBoFZGdBA--.63724S3
X-Coremail-Antispam: 1UD129KBjvJXoWxtryUtrWktF4rtryxtw4kCrg_yoWDGr4UpF
	Z5tay7Kry5JF18Xw1UXw17GFy5Ar1UK3WUXr1IqFyUArsrtrs2gr1UXr1qgF48Ar4kJr47
	tr1UJFZrZFy3XrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBY14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUbGQ6JUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2025/07/22 19:27, Nilay Shroff 写道:
> 
> 
> On 7/22/25 7:51 AM, Yu Kuai wrote:
>>> +/*
>>> + * Stores elevator type in xarray and set current elevator to none. It uses
>>> + * q->id as an index to store the elevator type into the xarray.
>>> + */
>>> +static int blk_mq_elv_switch_none(struct request_queue *q,
>>> +        struct xarray *elv_tbl)
>>> +{
>>> +    int ret = 0;
>>> +
>>> +    lockdep_assert_held_write(&q->tag_set->update_nr_hwq_lock);
>>> +
>>> +    /*
>>> +     * Accessing q->elevator without holding q->elevator_lock is safe here
>>> +     * because we're called from nr_hw_queue update which is protected by
>>> +     * set->update_nr_hwq_lock in the writer context. So, scheduler update/
>>> +     * switch code (which acquires the same lock in the reader context)
>>> +     * can't run concurrently.
>>> +     */
>>> +    if (q->elevator) {
>>> +
>>> +        ret = xa_insert(elv_tbl, q->id, q->elevator->type, GFP_KERNEL);
>>> +        if (ret) {
>>> +            WARN_ON_ONCE(1);
>>> +            goto out;
>>> +        }
>> Perhaps this is simpler, remove the out tag and return directly:
>>
>> if (WARN_ON_ONCE(ret))
>>      return ret;
> 
> Yes I can do that.
> 
>> And BTW, I feel the warning is not necessary here for small memory
>> allocation failure.
> IMO, it’s actually useful to print a warning in this case — even though
> the memory allocation failure is relatively minor. Since the failure causes
> the code to unwind back to the original state and prevents the nr_hw_queues
> from being updated, having a warning message can help indicate why the update
> didn't go through. It provides visibility into what went wrong, which can
> be valuable for debugging or understanding unexpected behavior.
> 
>>
>>> +        /*
>>> +         * Before we switch elevator to 'none', take a reference to
>>> +         * the elevator module so that while nr_hw_queue update is
>>> +         * running, no one can remove elevator module. We'd put the
>>> +         * reference to elevator module later when we switch back
>>> +         * elevator.
>>> +         */
>>> +        __elevator_get(q->elevator->type);
>>> +
>>> +        elevator_set_none(q);
>>> +    }
>>> +out:
>>> +    return ret;
>>> +}
>>> +
>>>    static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
>>>                                int nr_hw_queues)
>>>    {
>>> @@ -4973,6 +5029,7 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
>>>        int prev_nr_hw_queues = set->nr_hw_queues;
>>>        unsigned int memflags;
>>>        int i;
>>> +    struct xarray elv_tbl;
>>
>> Perhaps:
>>
>> DEFINE_XARRAY(elv_tbl)
> It may not work because then we have to initialize it at compile time
> at file scope. Then if we've multiple threads running nr_hw_queue update
> (for different tagsets) then we can't use that shared copy of elv_tbl
> as is and we've to protect it with another lock. So, IMO, instead creating
> xarray locally here makes sense.

I'm confused, I don't add static and this should still be a stack value,
I mean use this help to initialize it is simpler :)
> 
>>>          lockdep_assert_held(&set->tag_list_lock);
>>>    @@ -4984,6 +5041,9 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
>>>            return;
>>>          memflags = memalloc_noio_save();
>>> +
>>> +    xa_init(&elv_tbl);
>>> +
>>>        list_for_each_entry(q, &set->tag_list, tag_set_list) {
>>>            blk_mq_debugfs_unregister_hctxs(q);
>>>            blk_mq_sysfs_unregister_hctxs(q);
>>> @@ -4992,11 +5052,17 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
>>>        list_for_each_entry(q, &set->tag_list, tag_set_list)
>>>            blk_mq_freeze_queue_nomemsave(q);
>>>    -    if (blk_mq_realloc_tag_set_tags(set, nr_hw_queues) < 0) {
>>> -        list_for_each_entry(q, &set->tag_list, tag_set_list)
>>> -            blk_mq_unfreeze_queue_nomemrestore(q);
>>> -        goto reregister;
>>> -    }
>>> +    /*
>>> +     * Switch IO scheduler to 'none', cleaning up the data associated
>>> +     * with the previous scheduler. We will switch back once we are done
>>> +     * updating the new sw to hw queue mappings.
>>> +     */
>>> +    list_for_each_entry(q, &set->tag_list, tag_set_list)
>>> +        if (blk_mq_elv_switch_none(q, &elv_tbl))
>>> +            goto switch_back;
>>
>> Can we move the freeze queue into blk_mq_elv_switch_none? To
>> corresponding with unfreeze queue in blk_mq_elv_switch_back().
>>
> Ideally yes, but as Ming pointed in the first version of this
> patch we want to minimize code changes, as much possible, in
> the bug fix patch so that it'd be easy to back port to the older
> kernel release. Having said that, we'll have another patch (not
> a bug fix) where we'd address this by restructuring the code
> around this area.

Ok.
> 
>>> +
>>> +    if (blk_mq_realloc_tag_set_tags(set, nr_hw_queues) < 0)
>>> +        goto switch_back;
>>>      fallback:
>>>        blk_mq_update_queue_map(set);
>>> @@ -5016,12 +5082,11 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
>>>            }
>>>            blk_mq_map_swqueue(q);
>>>        }
>>> -
>>> -    /* elv_update_nr_hw_queues() unfreeze queue for us */
>>> +switch_back:
>>> +    /* The blk_mq_elv_switch_back unfreezes queue for us. */
>>>        list_for_each_entry(q, &set->tag_list, tag_set_list)
>>> -        elv_update_nr_hw_queues(q);
>>> +        blk_mq_elv_switch_back(q, &elv_tbl);
>>>    -reregister:
>>>        list_for_each_entry(q, &set->tag_list, tag_set_list) {
>>>            blk_mq_sysfs_register_hctxs(q);
>>>            blk_mq_debugfs_register_hctxs(q);
>>> @@ -5029,6 +5094,9 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
>>>            blk_mq_remove_hw_queues_cpuhp(q);
>>>            blk_mq_add_hw_queues_cpuhp(q);
>>>        }
>>> +
>>> +    xa_destroy(&elv_tbl);
>>> +
>>>        memalloc_noio_restore(memflags);
>>>          /* Free the excess tags when nr_hw_queues shrink. */
>>> diff --git a/block/blk.h b/block/blk.h
>>> index 37ec459fe656..fae7653a941f 100644
>>> --- a/block/blk.h
>>> +++ b/block/blk.h
>>> @@ -321,7 +321,7 @@ bool blk_bio_list_merge(struct request_queue *q, struct list_head *list,
>>>      bool blk_insert_flush(struct request *rq);
>>>    -void elv_update_nr_hw_queues(struct request_queue *q);
>>> +void elv_update_nr_hw_queues(struct request_queue *q, struct elevator_type *e);
>>>    void elevator_set_default(struct request_queue *q);
>>>    void elevator_set_none(struct request_queue *q);
>>>    diff --git a/block/elevator.c b/block/elevator.c
>>> index ab22542e6cf0..83d0bfb90a03 100644
>>> --- a/block/elevator.c
>>> +++ b/block/elevator.c
>>> @@ -689,7 +689,7 @@ static int elevator_change(struct request_queue *q, struct elv_change_ctx *ctx)
>>>     * The I/O scheduler depends on the number of hardware queues, this forces a
>>>     * reattachment when nr_hw_queues changes.
>>>     */
>>> -void elv_update_nr_hw_queues(struct request_queue *q)
>>> +void elv_update_nr_hw_queues(struct request_queue *q, struct elevator_type *e)
>>
>> Now that this function no longer just update nr_hw_queues, but switch
>> elevator from none to e, this name will be confusing. Since there is
>> just one caller from blk_mq_update_nr_hw_queues(), I feel it's better
>> to move the implematation to blk_mq_elv_switch_back() directly.
>>
> Yeah correct, and that's what exactly I implemented in the first version
> of this patch but then as I mentioned above we'd want to minimize the
> code restructuring changes in a bug fix patch so that it'd be easy to
> backport.

Sure.
> 
>>>    {
>>>        struct elv_change_ctx ctx = {};
>>>        int ret = -ENODEV;
>>> @@ -697,8 +697,8 @@ void elv_update_nr_hw_queues(struct request_queue *q)
>>>        WARN_ON_ONCE(q->mq_freeze_depth == 0);
>>>          mutex_lock(&q->elevator_lock);
>>> -    if (q->elevator && !blk_queue_dying(q) && blk_queue_registered(q)) {
>>> -        ctx.name = q->elevator->type->elevator_name;
>>> +    if (e && !blk_queue_dying(q) && blk_queue_registered(q)) {
>>> +        ctx.name = e->elevator_name;
>>
>> This looks not optimal, since you don't need elevator_lock to protect e.
>>>              /* force to reattach elevator after nr_hw_queue is updated */
>>>            ret = elevator_switch(q, &ctx);
>>>
>>
>> BTW, this is not related to this patch. Should we handle fall_back
>> failure like blk_mq_sysfs_register_hctxs()?
>>
> OKay I guess you meant here handle failure case by unwinding the
> queue instead of looping through it from start to end. If yes, then
> it could be done but again we may not want to do it the bug fix patch.
> 

Not like that, actually I don't have any ideas for now, the hctxs is
unregistered first, and if register failed, for example, due to -ENOMEM,
I can't find a way to fallback :(

Thanks,
Kuai

> Thanks,
> --Nilay
> 
> .
> 

