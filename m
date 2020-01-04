Return-Path: <SRS0=MEbK=2Z=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACEC6C32770
	for <linux-block@archiver.kernel.org>; Sat,  4 Jan 2020 09:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E8D424649
	for <linux-block@archiver.kernel.org>; Sat,  4 Jan 2020 09:16:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbgADJQo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 4 Jan 2020 04:16:44 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:8678 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726133AbgADJQn (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 4 Jan 2020 04:16:43 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id D4EE1D14FE2955177214;
        Sat,  4 Jan 2020 17:16:39 +0800 (CST)
Received: from [127.0.0.1] (10.133.219.224) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Sat, 4 Jan 2020
 17:16:34 +0800
Subject: Re: [PATCH] block: make sure last_lookup set as NULL after part
 deleted
To:     Joel Fernandes <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
CC:     Yufen Yu <yuyufen@huawei.com>, <axboe@kernel.dk>,
        <linux-block@vger.kernel.org>, <ming.lei@redhat.com>, <hch@lst.de>,
        <zhengchuan@huawei.com>, <yi.zhang@huawei.com>,
        <rcu@vger.kernel.org>
References: <20191231110945.10857-1-yuyufen@huawei.com>
 <a9ce86d6-dadb-9301-7d76-8cef81d782fd@huawei.com>
 <20191231231158.GW13449@paulmck-ThinkPad-P72>
 <20200103234521.GG189259@google.com>
From:   Hou Tao <houtao1@huawei.com>
Message-ID: <27b4c66e-316a-b261-364d-0b246d48e6bd@huawei.com>
Date:   Sat, 4 Jan 2020 17:16:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20200103234521.GG189259@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.219.224]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Joel,

On 2020/1/4 7:45, Joel Fernandes wrote:
> On Tue, Dec 31, 2019 at 03:11:58PM -0800, Paul E. McKenney wrote:
>> On Tue, Dec 31, 2019 at 10:55:47PM +0800, Hou Tao wrote:
>>> Hi,
>>>
>>> On 2019/12/31 19:09, Yufen Yu wrote:
>>>> When delete partition executes concurrently with IOs issue,
>>>> it may cause use-after-free on part in disk_map_sector_rcu()
>>>> as following:
>>> snip
>>>
>>>>
>>>> diff --git a/block/genhd.c b/block/genhd.c
>>>> index ff6268970ddc..39fa8999905f 100644
>>>> --- a/block/genhd.c
>>>> +++ b/block/genhd.c
>>>> @@ -293,7 +293,23 @@ struct hd_struct *disk_map_sector_rcu(struct gendisk *disk, sector_t sector)
>>>>  		part = rcu_dereference(ptbl->part[i]);
>>>>  
>>>>  		if (part && sector_in_part(part, sector)) {
>>> snip
>>>
>>>>  			rcu_assign_pointer(ptbl->last_lookup, part);
>>>> +			part = rcu_dereference(ptbl->part[i]);
>>>> +			if (part == NULL) {
>>>> +				rcu_assign_pointer(ptbl->last_lookup, NULL);
>>>> +				break;
>>>> +			}
>>>>  			return part;
>>>>  		}
>>>>  	}
>>>
>>> Not ensure whether the re-read can handle the following case or not:
>>>
>>> process A                                 process B                          process C
>>>
>>> disk_map_sector_rcu():                    delete_partition():               disk_map_sector_rcu():
>>>
>>> rcu_read_lock
>>>
>>>   // need to iterate partition table
>>>   part[i] != NULL   (1)                   part[i] = NULL (2)
>>>                                           smp_mb()
>>>                                           last_lookup = NULL (3)
>>>                                           call_rcu()  (4)
>>>     last_lookup = part[i] (5)
>>>
>>>
>>>                                                                              rcu_read_lock()
>>>                                                                              read last_lookup return part[i] (6)
>>>                                                                              sector_in_part() is OK (7)
>>>                                                                              return part[i] (8)
>>
>> Just for the record...
>>
>> Use of RCU needs to ensure that readers cannot access the to-be-freed
>> structure -before- invoking call_rcu().  Which does look to happen here
>> with the "last_lookup = NULL".  But in addition, the callback needs to
>> get access to the to-be-freed structure via some sideband (usually the
>> structure passed to call_rcu()), not from the reader-accessible structure.
>>
>> Or am I misinterpreting this sequence of events?
> 
> If I understand correctly, the issue described above is there are 2 threads
> setting last_lookup pointer simultaneously, one of them is NULLing it and
> waiting for a GP before freeing it (process B above), while the other is
> assigning to it concurrently after it was just NULLed (process A). Meanwhile
> process C starts a reader section *after* the GP by process B already started
> and accesses the reassigned pointer causing use-after-free.
> 
> Did I miss something?
> 
No. It's exactly the same as you have summarized. And thanks for that.

> I believe the fix is what Tao already posted which is to use refcounts so
> that the destructor does not free it while references are already held. Is
> that what the final fix is going to be? That other thread is pretty long so I
> lost track a bit..
> We are just trying to find a better solution (e.g. more readable or understandable).

Regards,
Tao

> thanks,
> 
>  - Joel
> 
> 
> 
>> 							Thanx, Paul
>>
>>>   part[i] == NULL (9)
>>>       last_lookup = NULL (10)
>>>   rcu_read_unlock() (11)
>>>                                            one RCU grace period completes
>>>                                            __delete_partition() (12)
>>>                                            free hd_partition (13)
>>>                                                                              // use-after-free
>>>                                                                              hd_struct_try_get(part[i])  (14)
>>>
>>> * the number in the parenthesis is the sequence of events.
>>>
>>> Maybe RCU experts can shed some light on this problem, so cc +paulmck@kernel.org, +joel@joelfernandes.org and +RCU maillist.
>>>
>>> If the above case is possible, maybe we can fix the problem by pinning last_lookup through increasing its ref-count
>>> (the following patch is only compile tested):
>>>
>>> diff --git a/block/genhd.c b/block/genhd.c
>>> index 6e8543ca6912..179e0056fae1 100644
>>> --- a/block/genhd.c
>>> +++ b/block/genhd.c
>>> @@ -279,7 +279,14 @@ struct hd_struct *disk_map_sector_rcu(struct gendisk *disk, sector_t sector)
>>>  		part = rcu_dereference(ptbl->part[i]);
>>>
>>>  		if (part && sector_in_part(part, sector)) {
>>> -			rcu_assign_pointer(ptbl->last_lookup, part);
>>> +			struct hd_struct *old;
>>> +
>>> +			if (!hd_struct_try_get(part))
>>> +				break;
>>> +
>>> +			old = xchg(&ptbl->last_lookup, part);
>>> +			if (old)
>>> +				hd_struct_put(old);
>>>  			return part;
>>>  		}
>>>  	}
>>> @@ -1231,7 +1238,11 @@ static void disk_replace_part_tbl(struct gendisk *disk,
>>>  	rcu_assign_pointer(disk->part_tbl, new_ptbl);
>>>
>>>  	if (old_ptbl) {
>>> -		rcu_assign_pointer(old_ptbl->last_lookup, NULL);
>>> +		struct hd_struct *part;
>>> +
>>> +		part = xchg(&old_ptbl->last_lookup, NULL);
>>> +		if (part)
>>> +			hd_struct_put(part);
>>>  		kfree_rcu(old_ptbl, rcu_head);
>>>  	}
>>>  }
>>> diff --git a/block/partition-generic.c b/block/partition-generic.c
>>> index 98d60a59b843..441c1c591c04 100644
>>> --- a/block/partition-generic.c
>>> +++ b/block/partition-generic.c
>>> @@ -285,7 +285,8 @@ void delete_partition(struct gendisk *disk, int partno)
>>>  		return;
>>>
>>>  	rcu_assign_pointer(ptbl->part[partno], NULL);
>>> -	rcu_assign_pointer(ptbl->last_lookup, NULL);
>>> +	if (cmpxchg(&ptbl->last_lookup, part, NULL) == part)
>>> +		hd_struct_put(part);
>>>  	kobject_put(part->holder_dir);
>>>  	device_del(part_to_dev(part));
>>>
>>> -- 
>>> 2.22.0
>>>
>>> Regards,
>>> Tao
>>>
>>>
>>>> diff --git a/block/partition-generic.c b/block/partition-generic.c
>>>> index 1d20c9cf213f..1e0065ed6f02 100644
>>>> --- a/block/partition-generic.c
>>>> +++ b/block/partition-generic.c
>>>> @@ -284,6 +284,13 @@ void delete_partition(struct gendisk *disk, int partno)
>>>>  		return;
>>>>  
>>>>  	rcu_assign_pointer(ptbl->part[partno], NULL);
>>>> +	/*
>>>> +	 * Without the memory barrier, disk_map_sector_rcu()
>>>> +	 * may read the old value after overwriting the
>>>> +	 * last_lookup. Then it can not clear last_lookup,
>>>> +	 * which may cause use-after-free.
>>>> +	 */
>>>> +	smp_mb();
>>>>  	rcu_assign_pointer(ptbl->last_lookup, NULL);
>>>>  	kobject_put(part->holder_dir);
>>>>  	device_del(part_to_dev(part));
>>>>
>>>
> 
> .
> 

