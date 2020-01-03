Return-Path: <SRS0=4w+H=2Y=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D388BC32771
	for <linux-block@archiver.kernel.org>; Fri,  3 Jan 2020 03:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B24AF21D7D
	for <linux-block@archiver.kernel.org>; Fri,  3 Jan 2020 03:06:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbgACDGe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Jan 2020 22:06:34 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:47644 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727325AbgACDGe (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 2 Jan 2020 22:06:34 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 7E5ED8A828111D5EE3C1;
        Fri,  3 Jan 2020 11:06:31 +0800 (CST)
Received: from [127.0.0.1] (10.133.219.224) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.439.0; Fri, 3 Jan 2020
 11:06:26 +0800
Subject: Re: [PATCH] block: make sure last_lookup set as NULL after part
 deleted
To:     Ming Lei <ming.lei@redhat.com>
CC:     Yufen Yu <yuyufen@huawei.com>, <axboe@kernel.dk>,
        <linux-block@vger.kernel.org>, <hch@lst.de>,
        <zhengchuan@huawei.com>, <yi.zhang@huawei.com>,
        <paulmck@kernel.org>, <joel@joelfernandes.org>,
        <rcu@vger.kernel.org>
References: <20191231110945.10857-1-yuyufen@huawei.com>
 <a9ce86d6-dadb-9301-7d76-8cef81d782fd@huawei.com>
 <20200102012314.GB16719@ming.t460p>
From:   Hou Tao <houtao1@huawei.com>
Message-ID: <c12da8ca-be66-496b-efb2-a60ceaf9ce54@huawei.com>
Date:   Fri, 3 Jan 2020 11:06:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20200102012314.GB16719@ming.t460p>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.219.224]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

On 2020/1/2 9:23, Ming Lei wrote:
> On Tue, Dec 31, 2019 at 10:55:47PM +0800, Hou Tao wrote:
>> Hi,
>>
>> On 2019/12/31 19:09, Yufen Yu wrote:
>>> When delete partition executes concurrently with IOs issue,
>>> it may cause use-after-free on part in disk_map_sector_rcu()
>>> as following:
>> snip
>>
>>>
>>> diff --git a/block/genhd.c b/block/genhd.c
>>> index ff6268970ddc..39fa8999905f 100644
>>> --- a/block/genhd.c
>>> +++ b/block/genhd.c
>>> @@ -293,7 +293,23 @@ struct hd_struct *disk_map_sector_rcu(struct gendisk *disk, sector_t sector)
>>>  		part = rcu_dereference(ptbl->part[i]);
>>>  
>>>  		if (part && sector_in_part(part, sector)) {
>> snip
>>
>>>  			rcu_assign_pointer(ptbl->last_lookup, part);
>>> +			part = rcu_dereference(ptbl->part[i]);
>>> +			if (part == NULL) {
>>> +				rcu_assign_pointer(ptbl->last_lookup, NULL);
>>> +				break;
>>> +			}
>>>  			return part;
>>>  		}
>>>  	}
>>
>> Not ensure whether the re-read can handle the following case or not:
>>
We have written a similar test case for the following case and found out that
process C still may got the freed hd_struct pointer from process A. So
the re-read will not resolve the problem.

>> process A                                 process B                          process C
>>
>> disk_map_sector_rcu():                    delete_partition():               disk_map_sector_rcu():
>>
>> rcu_read_lock
>>
>>   // need to iterate partition table
>>   part[i] != NULL   (1)                   part[i] = NULL (2)
>>                                           smp_mb()
>>                                           last_lookup = NULL (3)
>>                                           call_rcu()  (4)
>>     last_lookup = part[i] (5)
>>
>>
>>                                                                              rcu_read_lock()
>>                                                                              read last_lookup return part[i] (6)
>>                                                                              sector_in_part() is OK (7)
>>                                                                              return part[i] (8)
>>
>>   part[i] == NULL (9)
>>       last_lookup = NULL (10)
>>   rcu_read_unlock() (11)
>>                                            one RCU grace period completes
>>                                            __delete_partition() (12)
>>                                            free hd_partition (13)
>>                                                                              // use-after-free
>>                                                                              hd_struct_try_get(part[i])  (14)
>>
>> * the number in the parenthesis is the sequence of events.
>>



>> Maybe RCU experts can shed some light on this problem, so cc +paulmck@kernel.org, +joel@joelfernandes.org and +RCU maillist.
>>
>> If the above case is possible, maybe we can fix the problem by pinning last_lookup through increasing its ref-count
>> (the following patch is only compile tested):
>>
>> diff --git a/block/genhd.c b/block/genhd.c
>> index 6e8543ca6912..179e0056fae1 100644
>> --- a/block/genhd.c
>> +++ b/block/genhd.c
>> @@ -279,7 +279,14 @@ struct hd_struct *disk_map_sector_rcu(struct gendisk *disk, sector_t sector)
>>  		part = rcu_dereference(ptbl->part[i]);
>>
>>  		if (part && sector_in_part(part, sector)) {
>> -			rcu_assign_pointer(ptbl->last_lookup, part);
>> +			struct hd_struct *old;
>> +
>> +			if (!hd_struct_try_get(part))
>> +				break;
>> +
>> +			old = xchg(&ptbl->last_lookup, part);
>> +			if (old)
>> +				hd_struct_put(old);
>>  			return part;
>>  		}
>>  	}
>> @@ -1231,7 +1238,11 @@ static void disk_replace_part_tbl(struct gendisk *disk,
>>  	rcu_assign_pointer(disk->part_tbl, new_ptbl);
>>
>>  	if (old_ptbl) {
>> -		rcu_assign_pointer(old_ptbl->last_lookup, NULL);
>> +		struct hd_struct *part;
>> +
>> +		part = xchg(&old_ptbl->last_lookup, NULL);
>> +		if (part)
>> +			hd_struct_put(part);
>>  		kfree_rcu(old_ptbl, rcu_head);
>>  	}
>>  }
>> diff --git a/block/partition-generic.c b/block/partition-generic.c
>> index 98d60a59b843..441c1c591c04 100644
>> --- a/block/partition-generic.c
>> +++ b/block/partition-generic.c
>> @@ -285,7 +285,8 @@ void delete_partition(struct gendisk *disk, int partno)
>>  		return;
>>
>>  	rcu_assign_pointer(ptbl->part[partno], NULL);
>> -	rcu_assign_pointer(ptbl->last_lookup, NULL);
>> +	if (cmpxchg(&ptbl->last_lookup, part, NULL) == part)
>> +		hd_struct_put(part);
>>  	kobject_put(part->holder_dir);
>>  	device_del(part_to_dev(part));
> 
> IMO this approach looks good.
>
Not sure about the overhead when there are concurrent IOs on different partitions,
we will measure that.

We have got a seemingly better solution: caching the index of last_lookup in tbl->part[]
instead of caching the pointer itself, so we can ensure the validity of returned pointer
by ensuring it's not NULL in tbl->part[] as does when last_lookup is NULL or 0.

> Given partition is actually protected by percpu-refcount now, I guess the
> RCU annotation for referencing ->part[partno] and ->last_lookup may not
> be necessary, together with the part->rcu_work.
> 
So we will depends on the invocation of of call_rcu() on __percpu_ref_switch_mode() to
ensure the RCU readers will find part[i] is NULL before trying to increasing
the atomic ref-counter of part[i], right ?

Regards,
Tao

> 
> Thanks,
> Ming
> 
> 
> .
> 

