Return-Path: <SRS0=PDkS=23=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEA4FC33C9B
	for <linux-block@archiver.kernel.org>; Mon,  6 Jan 2020 09:41:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC4EB21775
	for <linux-block@archiver.kernel.org>; Mon,  6 Jan 2020 09:41:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbgAFJlz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 Jan 2020 04:41:55 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:35782 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725821AbgAFJly (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 6 Jan 2020 04:41:54 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 302F993AB37AD0E966A9;
        Mon,  6 Jan 2020 17:41:52 +0800 (CST)
Received: from [127.0.0.1] (10.133.219.224) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Mon, 6 Jan 2020
 17:41:46 +0800
Subject: Re: [PATCH] block: make sure last_lookup set as NULL after part
 deleted
To:     Ming Lei <ming.lei@redhat.com>, Yufen Yu <yuyufen@huawei.com>
CC:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>, <hch@lst.de>,
        <zhengchuan@huawei.com>, <yi.zhang@huawei.com>,
        <paulmck@kernel.org>, <joel@joelfernandes.org>,
        <rcu@vger.kernel.org>
References: <20191231110945.10857-1-yuyufen@huawei.com>
 <a9ce86d6-dadb-9301-7d76-8cef81d782fd@huawei.com>
 <20200102012314.GB16719@ming.t460p>
 <c12da8ca-be66-496b-efb2-a60ceaf9ce54@huawei.com>
 <20200103041805.GA29924@ming.t460p>
 <ea362a86-d2de-7dfe-c826-d59e8b5068c3@huawei.com>
 <20200103081745.GA11275@ming.t460p>
 <82c10514-aec5-0d7c-118f-32c261015c6a@huawei.com>
 <20200103151616.GA23308@ming.t460p>
 <582f8e81-6127-47aa-f7fe-035251052238@huawei.com>
 <20200106081137.GA10487@ming.t460p>
From:   Hou Tao <houtao1@huawei.com>
Message-ID: <747c3856-afa4-0909-dae2-f3b23aa38118@huawei.com>
Date:   Mon, 6 Jan 2020 17:41:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20200106081137.GA10487@ming.t460p>
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

On 2020/1/6 16:11, Ming Lei wrote:
> On Mon, Jan 06, 2020 at 03:39:07PM +0800, Yufen Yu wrote:
>> Hi, Ming
>>
>> On 2020/1/3 23:16, Ming Lei wrote:
>>> Hello Yufen,
>>>
>>> OK, we still can move clearing .last_lookup into __delete_partition(),
>>> at that time all IO path can observe the partition percpu-refcount killed.
>>>
>>> Also the rcu work fn is run after one RCU grace period, at that time,
>>> the NULL .last_lookup becomes visible in all IO path too.
>>>
>>> diff --git a/block/blk-core.c b/block/blk-core.c
>>> index 089e890ab208..79599f5fd5b7 100644
>>> --- a/block/blk-core.c
>>> +++ b/block/blk-core.c
>>> @@ -1365,18 +1365,6 @@ void blk_account_io_start(struct request *rq, bool new_io)
>>>   		part_stat_inc(part, merges[rw]);
>>>   	} else {
>>>   		part = disk_map_sector_rcu(rq->rq_disk, blk_rq_pos(rq));
>>> -		if (!hd_struct_try_get(part)) {
>>> -			/*
>>> -			 * The partition is already being removed,
>>> -			 * the request will be accounted on the disk only
>>> -			 *
>>> -			 * We take a reference on disk->part0 although that
>>> -			 * partition will never be deleted, so we can treat
>>> -			 * it as any other partition.
>>> -			 */
>>> -			part = &rq->rq_disk->part0;
>>> -			hd_struct_get(part);
>>> -		}
>>>   		part_inc_in_flight(rq->q, part, rw);
>>>   		rq->part = part;
>>>   	}
>>> diff --git a/block/genhd.c b/block/genhd.c
>>> index ff6268970ddc..e3dec90b1f43 100644
>>> --- a/block/genhd.c
>>> +++ b/block/genhd.c
>>> @@ -286,17 +286,21 @@ struct hd_struct *disk_map_sector_rcu(struct gendisk *disk, sector_t sector)
>>>   	ptbl = rcu_dereference(disk->part_tbl);
>>>   	part = rcu_dereference(ptbl->last_lookup);
>>> -	if (part && sector_in_part(part, sector))
>>> +	if (part && sector_in_part(part, sector) && hd_struct_try_get(part))
>>>   		return part;
>>>   	for (i = 1; i < ptbl->len; i++) {
>>>   		part = rcu_dereference(ptbl->part[i]);
>>>   		if (part && sector_in_part(part, sector)) {
>>> +                       if (!hd_struct_try_get(part))
>>> +                               goto exit;
>>>   			rcu_assign_pointer(ptbl->last_lookup, part);
>>>   			return part;
>>>   		}
>>>   	}
>>> + exit:
>>> +	hd_struct_get(&disk->part0);
>>>   	return &disk->part0;
>>>   }
>>>   EXPORT_SYMBOL_GPL(disk_map_sector_rcu);
>>> diff --git a/block/partition-generic.c b/block/partition-generic.c
>>> index 1d20c9cf213f..1739f750dbf2 100644
>>> --- a/block/partition-generic.c
>>> +++ b/block/partition-generic.c
>>> @@ -262,6 +262,12 @@ static void delete_partition_work_fn(struct work_struct *work)
>>>   void __delete_partition(struct percpu_ref *ref)
>>>   {
>>>   	struct hd_struct *part = container_of(ref, struct hd_struct, ref);
>>> +	struct disk_part_tbl *ptbl =
>>> +		rcu_dereference_protected(part->disk->part_tbl, 1);
>>> +
>>> +	rcu_assign_pointer(ptbl->last_lookup, NULL);
>>> +	put_device(disk_to_dev(part->disk));
>>> +
>>>   	INIT_RCU_WORK(&part->rcu_work, delete_partition_work_fn);
>>>   	queue_rcu_work(system_wq, &part->rcu_work);
>>>   }
>>> @@ -283,8 +289,9 @@ void delete_partition(struct gendisk *disk, int partno)
>>>   	if (!part)
>>>   		return;
>>> +	get_device(disk_to_dev(disk));
>>>   	rcu_assign_pointer(ptbl->part[partno], NULL);
>>> -	rcu_assign_pointer(ptbl->last_lookup, NULL);
>>> +
>>>   	kobject_put(part->holder_dir);
>>>   	device_del(part_to_dev(part));
>>> @@ -349,6 +356,7 @@ struct hd_struct *add_partition(struct gendisk *disk, int partno,
>>>   	p->nr_sects = len;
>>>   	p->partno = partno;
>>>   	p->policy = get_disk_ro(disk);
>>> +	p->disk = disk;
>>>   	if (info) {
>>>   		struct partition_meta_info *pinfo = alloc_part_info(disk);
>>> diff --git a/include/linux/genhd.h b/include/linux/genhd.h
>>> index 8bb63027e4d6..66660ec5e8ee 100644
>>> --- a/include/linux/genhd.h
>>> +++ b/include/linux/genhd.h
>>> @@ -129,6 +129,7 @@ struct hd_struct {
>>>   #else
>>>   	struct disk_stats dkstats;
>>>   #endif
>>> +	struct gendisk *disk;
>>>   	struct percpu_ref ref;
>>>   	struct rcu_work rcu_work;
>>>   };
>>
>>
>> IMO, this change can solve the problem. But, __delete_partition will
>> depend on the implementation of disk_release(). If disk .release modify
>> as blocked in the future, then __delete_partition will also be blocked,
>> which is not expected in rcu callback function.
> 
> __delete_partition() won't be blocked because it just calls queue_rcu_work() to
> release the partition instance in wq context.
> 
>>
>> We may cache index of part[] instead of part[i] itself to fix the use-after-free bug.
>> https://patchwork.kernel.org/patch/11318767/
> 
> That approach can fix the issue too, but extra overhead is added in the
> fast path because partition retrieval is changed to the following way:
> 
> 	+       last_lookup = READ_ONCE(ptbl->last_lookup);
> 	+       if (last_lookup > 0 && last_lookup < ptbl->len) {
> 	+               part = rcu_dereference(ptbl->part[last_lookup]);
> 	+               if (part && sector_in_part(part, sector))
> 	+                       return part;
> 	+       }
> 
> from 
> 	part = rcu_dereference(ptbl->last_lookup);
> 
> So ptbl->part[] has to be fetched, it is fine if the ->part[] array
> shares same cacheline with ptbl->last_lookup, but one disk may have
> too many partitions, then your approach may introduce one extra cache
> miss every time.
> 
Yes. The solution you proposed also adds an invocation of percpu_ref_tryget_live()
in the fast path. Not sure which one will have a better performance. However the
reason we prefer the index caching is the simplicity instead of performance.

> READ_ONCE() may imply one read barrier too.
> 
According to the manual, it only matters on Alpha machines and READ_ONCE() also
exists in rcu_dereference().

Regards,
Tao

> 
> Thanks,
> Ming
> 
> 
> .
> 

