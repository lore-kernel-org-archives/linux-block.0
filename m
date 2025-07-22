Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7BBA1940A2
	for <linux-block@vger.kernel.org>; Tue, 22 Jul 2025 11:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753183663; cv=none; b=OjdWmusfWjNtSe/GA4op1z/dmAgj/ND1HO3GluCag10IIA6UO73FAse5/wC2MERTkkgQfwG4ceChb5RhWhCr5BTwd0CPJOKHxjiRkwlerC/KIvF0Vm2LSvfQnQOdkMm5orjnCP7losp1ngw/B/H2sB9Sby2eV5DDQCgJIKUFN4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753183663; c=relaxed/simple;
	bh=5nancgvlERKm9q73nXz7bt4IooA27EH0RcoVjUe72G0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BHmiZRGPLROkTmJv03v14oZlNLKvSlwpLqnCkIIVfyoehZ0i0degGWyjKmMYwtc19q5LT9lPqudFs5mnABEPef+3HwXUwimNRg3uCMcXuSVyVDezuawf4B3/5s8RhzkOEOFqyWbgfaZULGw5xf/V41snh4FbsInC+m+ovadE6Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=szi4DwMR; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="szi4DwMR"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56M6JxVc018705;
	Tue, 22 Jul 2025 11:27:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=0w4bze
	Ccr1YR1ptiguXehIYQoLQipn2FZBfsA+L6XBI=; b=szi4DwMRrpxLRHkfATgmyY
	YKXouNsguqS54T8fEzobmAAgf5eQJyQcykRNAWQK65Y87M1DFqXj7N1ls88eWZTk
	tpoRH0SKoQwCVikedtNvOaEfKqwijZmB1/xcqK/d/3g5vHDrClnTLw13Jj1S0ae0
	/6eUo6tgZ2f5FpWqZqD1pCseViKkAfukDXgK+GGqRmN2yFGW6G6f4b8/I48o0Z6J
	oR1jZkj7S9vRFcDH7bxcPwawZ44wbIE0iVfnN+YqrXnjImhVSA9tycbL4SRQfqFZ
	FNDiws000MvApWt84LwKVVMNZU6iM09eRflltDbt978tUSuZeIokh7Dtklt+/xDQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4805uqwybv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Jul 2025 11:27:21 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56MB0LNJ012415;
	Tue, 22 Jul 2025 11:27:20 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 480p302py8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Jul 2025 11:27:20 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56MBRJtS1311256
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Jul 2025 11:27:19 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5309F58050;
	Tue, 22 Jul 2025 11:27:19 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2AC1958045;
	Tue, 22 Jul 2025 11:27:16 +0000 (GMT)
Received: from [9.109.203.242] (unknown [9.109.203.242])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 22 Jul 2025 11:27:15 +0000 (GMT)
Message-ID: <43099391-2279-473d-8c13-70486b96f50f@linux.ibm.com>
Date: Tue, 22 Jul 2025 16:57:14 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2] block: restore two stage elevator switch while running
 nr_hw_queue update
To: Yu Kuai <yukuai1@huaweicloud.com>, linux-block@vger.kernel.org
Cc: yi.zhang@redhat.com, ming.lei@redhat.com, hch@lst.de, axboe@kernel.dk,
        shinichiro.kawasaki@wdc.com, gjoyce@ibm.com,
        "yukuai (C)"
 <yukuai3@huawei.com>
References: <20250718133232.626418-1-nilay@linux.ibm.com>
 <b7cc0c1c-6027-4f1a-8ca1-e7ac4ae9e5ec@huaweicloud.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <b7cc0c1c-6027-4f1a-8ca1-e7ac4ae9e5ec@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 3AjyiOx03q1O6C6ghhrSQ4lWlULvygre
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDA5MSBTYWx0ZWRfXwOPHOddoRiQm
 fEgoP0D+DKIMxov6XmnNCcfwiC0GpmGOsiy8aaqYz19nk3mIEZMRDRUEGP9GmSiQ9pq2XE9C4TE
 aAQaij7BDv6C56x6hK+WppFxKdqIEoWoagV5WOE9AXYsz44AogAT6wp24kPqNDzRJxvd7acIaP3
 8UKztIyP8Jdq4W0iLZ2tMzCYI1ZUX2L9GdbiRCuB95pr0PPXO0hweAAtUWpd5vVivmKCqAQLDZK
 m1XjTT52uRtf0ySDEkK0UnN5heSv9Ln3elBwYMsC+ypix4XF3M2jyy4ixQeWGueZFb/mBonb9sc
 5Sr2x8c1pK8Vo5QTyfJ4q//7XTB/z2yU9tIEftcRxiV2FdbQcEZNk7cjwZly5Y1oa2f5vYgWLFH
 T5iI/XngqkyDZnvoJr9KI1KqcvE/oErtZUFoa3J4IxpAwVAZ4YPi2LvQQjJeEV86BFN6wT0a
X-Authority-Analysis: v=2.4 cv=dpnbC0g4 c=1 sm=1 tr=0 ts=687f7599 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=PwqIDW34ylWqLZTyn7IA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 3AjyiOx03q1O6C6ghhrSQ4lWlULvygre
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_02,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 adultscore=0 phishscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507220091



On 7/22/25 7:51 AM, Yu Kuai wrote:
>> +/*
>> + * Stores elevator type in xarray and set current elevator to none. It uses
>> + * q->id as an index to store the elevator type into the xarray.
>> + */
>> +static int blk_mq_elv_switch_none(struct request_queue *q,
>> +        struct xarray *elv_tbl)
>> +{
>> +    int ret = 0;
>> +
>> +    lockdep_assert_held_write(&q->tag_set->update_nr_hwq_lock);
>> +
>> +    /*
>> +     * Accessing q->elevator without holding q->elevator_lock is safe here
>> +     * because we're called from nr_hw_queue update which is protected by
>> +     * set->update_nr_hwq_lock in the writer context. So, scheduler update/
>> +     * switch code (which acquires the same lock in the reader context)
>> +     * can't run concurrently.
>> +     */
>> +    if (q->elevator) {
>> +
>> +        ret = xa_insert(elv_tbl, q->id, q->elevator->type, GFP_KERNEL);
>> +        if (ret) {
>> +            WARN_ON_ONCE(1);
>> +            goto out;
>> +        }
> Perhaps this is simpler, remove the out tag and return directly:
> 
> if (WARN_ON_ONCE(ret))
>     return ret;

Yes I can do that.

> And BTW, I feel the warning is not necessary here for small memory
> allocation failure.
IMO, it’s actually useful to print a warning in this case — even though
the memory allocation failure is relatively minor. Since the failure causes
the code to unwind back to the original state and prevents the nr_hw_queues
from being updated, having a warning message can help indicate why the update
didn't go through. It provides visibility into what went wrong, which can
be valuable for debugging or understanding unexpected behavior.

> 
>> +        /*
>> +         * Before we switch elevator to 'none', take a reference to
>> +         * the elevator module so that while nr_hw_queue update is
>> +         * running, no one can remove elevator module. We'd put the
>> +         * reference to elevator module later when we switch back
>> +         * elevator.
>> +         */
>> +        __elevator_get(q->elevator->type);
>> +
>> +        elevator_set_none(q);
>> +    }
>> +out:
>> +    return ret;
>> +}
>> +
>>   static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
>>                               int nr_hw_queues)
>>   {
>> @@ -4973,6 +5029,7 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
>>       int prev_nr_hw_queues = set->nr_hw_queues;
>>       unsigned int memflags;
>>       int i;
>> +    struct xarray elv_tbl;
> 
> Perhaps:
> 
> DEFINE_XARRAY(elv_tbl)
It may not work because then we have to initialize it at compile time 
at file scope. Then if we've multiple threads running nr_hw_queue update
(for different tagsets) then we can't use that shared copy of elv_tbl 
as is and we've to protect it with another lock. So, IMO, instead creating 
xarray locally here makes sense.

>>         lockdep_assert_held(&set->tag_list_lock);
>>   @@ -4984,6 +5041,9 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
>>           return;
>>         memflags = memalloc_noio_save();
>> +
>> +    xa_init(&elv_tbl);
>> +
>>       list_for_each_entry(q, &set->tag_list, tag_set_list) {
>>           blk_mq_debugfs_unregister_hctxs(q);
>>           blk_mq_sysfs_unregister_hctxs(q);
>> @@ -4992,11 +5052,17 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
>>       list_for_each_entry(q, &set->tag_list, tag_set_list)
>>           blk_mq_freeze_queue_nomemsave(q);
>>   -    if (blk_mq_realloc_tag_set_tags(set, nr_hw_queues) < 0) {
>> -        list_for_each_entry(q, &set->tag_list, tag_set_list)
>> -            blk_mq_unfreeze_queue_nomemrestore(q);
>> -        goto reregister;
>> -    }
>> +    /*
>> +     * Switch IO scheduler to 'none', cleaning up the data associated
>> +     * with the previous scheduler. We will switch back once we are done
>> +     * updating the new sw to hw queue mappings.
>> +     */
>> +    list_for_each_entry(q, &set->tag_list, tag_set_list)
>> +        if (blk_mq_elv_switch_none(q, &elv_tbl))
>> +            goto switch_back;
> 
> Can we move the freeze queue into blk_mq_elv_switch_none? To
> corresponding with unfreeze queue in blk_mq_elv_switch_back().
> 
Ideally yes, but as Ming pointed in the first version of this 
patch we want to minimize code changes, as much possible, in 
the bug fix patch so that it'd be easy to back port to the older
kernel release. Having said that, we'll have another patch (not
a bug fix) where we'd address this by restructuring the code
around this area.

>> +
>> +    if (blk_mq_realloc_tag_set_tags(set, nr_hw_queues) < 0)
>> +        goto switch_back;
>>     fallback:
>>       blk_mq_update_queue_map(set);
>> @@ -5016,12 +5082,11 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
>>           }
>>           blk_mq_map_swqueue(q);
>>       }
>> -
>> -    /* elv_update_nr_hw_queues() unfreeze queue for us */
>> +switch_back:
>> +    /* The blk_mq_elv_switch_back unfreezes queue for us. */
>>       list_for_each_entry(q, &set->tag_list, tag_set_list)
>> -        elv_update_nr_hw_queues(q);
>> +        blk_mq_elv_switch_back(q, &elv_tbl);
>>   -reregister:
>>       list_for_each_entry(q, &set->tag_list, tag_set_list) {
>>           blk_mq_sysfs_register_hctxs(q);
>>           blk_mq_debugfs_register_hctxs(q);
>> @@ -5029,6 +5094,9 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
>>           blk_mq_remove_hw_queues_cpuhp(q);
>>           blk_mq_add_hw_queues_cpuhp(q);
>>       }
>> +
>> +    xa_destroy(&elv_tbl);
>> +
>>       memalloc_noio_restore(memflags);
>>         /* Free the excess tags when nr_hw_queues shrink. */
>> diff --git a/block/blk.h b/block/blk.h
>> index 37ec459fe656..fae7653a941f 100644
>> --- a/block/blk.h
>> +++ b/block/blk.h
>> @@ -321,7 +321,7 @@ bool blk_bio_list_merge(struct request_queue *q, struct list_head *list,
>>     bool blk_insert_flush(struct request *rq);
>>   -void elv_update_nr_hw_queues(struct request_queue *q);
>> +void elv_update_nr_hw_queues(struct request_queue *q, struct elevator_type *e);
>>   void elevator_set_default(struct request_queue *q);
>>   void elevator_set_none(struct request_queue *q);
>>   diff --git a/block/elevator.c b/block/elevator.c
>> index ab22542e6cf0..83d0bfb90a03 100644
>> --- a/block/elevator.c
>> +++ b/block/elevator.c
>> @@ -689,7 +689,7 @@ static int elevator_change(struct request_queue *q, struct elv_change_ctx *ctx)
>>    * The I/O scheduler depends on the number of hardware queues, this forces a
>>    * reattachment when nr_hw_queues changes.
>>    */
>> -void elv_update_nr_hw_queues(struct request_queue *q)
>> +void elv_update_nr_hw_queues(struct request_queue *q, struct elevator_type *e)
> 
> Now that this function no longer just update nr_hw_queues, but switch
> elevator from none to e, this name will be confusing. Since there is
> just one caller from blk_mq_update_nr_hw_queues(), I feel it's better
> to move the implematation to blk_mq_elv_switch_back() directly.
> 
Yeah correct, and that's what exactly I implemented in the first version
of this patch but then as I mentioned above we'd want to minimize the
code restructuring changes in a bug fix patch so that it'd be easy to
backport.

>>   {
>>       struct elv_change_ctx ctx = {};
>>       int ret = -ENODEV;
>> @@ -697,8 +697,8 @@ void elv_update_nr_hw_queues(struct request_queue *q)
>>       WARN_ON_ONCE(q->mq_freeze_depth == 0);
>>         mutex_lock(&q->elevator_lock);
>> -    if (q->elevator && !blk_queue_dying(q) && blk_queue_registered(q)) {
>> -        ctx.name = q->elevator->type->elevator_name;
>> +    if (e && !blk_queue_dying(q) && blk_queue_registered(q)) {
>> +        ctx.name = e->elevator_name;
> 
> This looks not optimal, since you don't need elevator_lock to protect e.
>>             /* force to reattach elevator after nr_hw_queue is updated */
>>           ret = elevator_switch(q, &ctx);
>>
> 
> BTW, this is not related to this patch. Should we handle fall_back
> failure like blk_mq_sysfs_register_hctxs()?
> 
OKay I guess you meant here handle failure case by unwinding the 
queue instead of looping through it from start to end. If yes, then
it could be done but again we may not want to do it the bug fix patch.

Thanks,
--Nilay

