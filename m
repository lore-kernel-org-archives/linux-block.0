Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4B5274670
	for <linux-block@vger.kernel.org>; Fri, 15 Aug 2025 09:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755251023; cv=none; b=RYzs/XSwP+kjz9UCroJDTu1W9cEIcHY2yuKw4BKE/B4Pe17p3Atk3HL1AhJhhqqDhrrI8lOKl7dbCJbbb/N13PZV2sYSh5NGN3gWp/zRx8FWHWVp5twjP8oF49g8mR6SYAxG0sxlWHEnmxLcYFeqWZWJiLbPLbPx5WbR9QdUGXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755251023; c=relaxed/simple;
	bh=mmXrbhmz/+Q4taqtuJ6vF5svdNtiOVcg0qzAwui785k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ozJoK21Rm8z3gCa9ZK2qEgCp3ORV66zCH6H7M9hdJxblFyyRyoVFG3YHIneu6eDzf1G5MTeEl2yZJz+01XxC4+vLquuAgBR7hBQD9IMuam2erdjIn8NClDjUQgjplBK66evACXzuuoSXDaD+2keHhUSPdN4cnqXBf1EwfIn/DL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UldcodPa; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UldcodPa"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57F3tH7F029882;
	Fri, 15 Aug 2025 09:43:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=YMwM3e
	DQoKc8RI3r5mj3mx2XYYGVTYOErMysR46DcLU=; b=UldcodPaIM3/YCwmhYdGx8
	i6HC9y1DLKGAgf0lEOHAzwHVURqCJk3MKl7+bypal1OIASN3DR3cl6r3rqnr7KhN
	5ViVcFKPYLBQA5IWwAsZ6ajV7qV770nf6JMIBCDLhvzq+LU/FzEYv8WOfBpKcA/U
	+hDI/5a1eql4fDbD3OjGb2a/zgeC1jEwXKLUWyEFM9JH7WfNhDC9UeJ9s+j5ssF9
	XMdF2/uJ7lTLIGtVrBqKXRMheZkfn6+y4k/fZGl6LiRDLotudAffqGAZLfCBgqQb
	eizAaW3djXFF6gpc8djQ9ndvLohOrDjiwmLfCKVberP90uz39Ubsg5z6eIcNDBhw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48dvrpegm8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Aug 2025 09:43:25 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57F94MBt017600;
	Fri, 15 Aug 2025 09:43:24 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 48ekc400ja-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Aug 2025 09:43:24 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57F9hNFA29295280
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Aug 2025 09:43:23 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B8EA55805F;
	Fri, 15 Aug 2025 09:43:23 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E6D845805A;
	Fri, 15 Aug 2025 09:43:20 +0000 (GMT)
Received: from [9.61.133.254] (unknown [9.61.133.254])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 15 Aug 2025 09:43:20 +0000 (GMT)
Message-ID: <16975629-4988-4841-86bb-d4f3f40cc849@linux.ibm.com>
Date: Fri, 15 Aug 2025 15:13:19 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 3/3] block: avoid cpu_hotplug_lock depedency on
 freeze_lock
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, axboe@kernel.dk, yukuai1@huaweicloud.com,
        hch@lst.de, shinichiro.kawasaki@wdc.com, kch@nvidia.com,
        gjoyce@ibm.com
References: <20250814082612.500845-1-nilay@linux.ibm.com>
 <20250814082612.500845-4-nilay@linux.ibm.com> <aJ3aR2JodRrAqVcO@fedora>
 <e125025b-d576-4919-b00e-5d9b640bed77@linux.ibm.com>
 <aJ3myQW2A8HtteBC@fedora>
 <e33e97f7-0c12-4f70-81d0-4fea05557579@linux.ibm.com>
 <aJ57lZLhktXxaBoh@fedora>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <aJ57lZLhktXxaBoh@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDIxOSBTYWx0ZWRfX7vD0k22FeaYg
 rSL0oBZhJCalRpZE9jwydSQWca0MfN0V8DOIb1GjjcubipMfEUdZaDQW1V6gCuH5wJ58Btd+9+L
 m9ATXoltU13qgUfhc6cFYczxDsRuQKQNUY2uEsvYeoO1z+jrfDJKzgcqbxkQ8BtNYxIzu0D+d+y
 oX90AUa2hojWBM+4sRx7TuNGfKKvADiGeHCugkLUP8H9+rt8ykfadywjT5pBtungSr9siOo44Cf
 hWbVV2t8zXLmqjtLtZN6laILaQlvXQHqtHXfA7tlIKnNh9AxODpJsm5RmjXrlKXCheqQdZ9/zLm
 4VK4j0R7rkDNzIOVHUW0QPyD6tTSJBDBqDBk1M5eGS+EbF6mKG1G23Ahlqc1RlwARoKTwYPuYzV
 xFHCloqT
X-Authority-Analysis: v=2.4 cv=GrpC+l1C c=1 sm=1 tr=0 ts=689f013d cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=JF9118EUAAAA:8
 a=VnNF1IyMAAAA:8 a=NZdxs53CIEgwjd5_7P4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-GUID: vrYW6GS0eBTomsIzh-0_cmHBY6M63_wj
X-Proofpoint-ORIG-GUID: vrYW6GS0eBTomsIzh-0_cmHBY6M63_wj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-15_03,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 spamscore=0 impostorscore=0 suspectscore=0
 phishscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508120219



On 8/15/25 5:43 AM, Ming Lei wrote:
> On Thu, Aug 14, 2025 at 08:01:11PM +0530, Nilay Shroff wrote:
>>
>>
>> On 8/14/25 7:08 PM, Ming Lei wrote:
>>> On Thu, Aug 14, 2025 at 06:27:08PM +0530, Nilay Shroff wrote:
>>>>
>>>>
>>>> On 8/14/25 6:14 PM, Ming Lei wrote:
>>>>> On Thu, Aug 14, 2025 at 01:54:59PM +0530, Nilay Shroff wrote:
>>>>>> A recent lockdep[1] splat observed while running blktest block/005
>>>>>> reveals a potential deadlock caused by the cpu_hotplug_lock dependency
>>>>>> on ->freeze_lock. This dependency was introduced by commit 033b667a823e
>>>>>> ("block: blk-rq-qos: guard rq-qos helpers by static key").
>>>>>>
>>>>>> That change added a static key to avoid fetching q->rq_qos when
>>>>>> neither blk-wbt nor blk-iolatency is configured. The static key
>>>>>> dynamically patches kernel text to a NOP when disabled, eliminating
>>>>>> overhead of fetching q->rq_qos in the I/O hot path. However, enabling
>>>>>> a static key at runtime requires acquiring both cpu_hotplug_lock and
>>>>>> jump_label_mutex. When this happens after the queue has already been
>>>>>> frozen (i.e., while holding ->freeze_lock), it creates a locking
>>>>>> dependency from cpu_hotplug_lock to ->freeze_lock, which leads to a
>>>>>> potential deadlock reported by lockdep [1].
>>>>>>
>>>>>> To resolve this, replace the static key mechanism with q->queue_flags:
>>>>>> QUEUE_FLAG_QOS_ENABLED. This flag is evaluated in the fast path before
>>>>>> accessing q->rq_qos. If the flag is set, we proceed to fetch q->rq_qos;
>>>>>> otherwise, the access is skipped.
>>>>>>
>>>>>> Since q->queue_flags is commonly accessed in IO hotpath and resides in
>>>>>> the first cacheline of struct request_queue, checking it imposes minimal
>>>>>> overhead while eliminating the deadlock risk.
>>>>>>
>>>>>> This change avoids the lockdep splat without introducing performance
>>>>>> regressions.
>>>>>>
>>>>>> [1] https://lore.kernel.org/linux-block/4fdm37so3o4xricdgfosgmohn63aa7wj3ua4e5vpihoamwg3ui@fq42f5q5t5ic/
>>>>>>
>>>>>> Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
>>>>>> Closes: https://lore.kernel.org/linux-block/4fdm37so3o4xricdgfosgmohn63aa7wj3ua4e5vpihoamwg3ui@fq42f5q5t5ic/
>>>>>> Fixes: 033b667a823e ("block: blk-rq-qos: guard rq-qos helpers by static key")
>>>>>> Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
>>>>>> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
>>>>>> ---
>>>>>>  block/blk-mq-debugfs.c |  1 +
>>>>>>  block/blk-rq-qos.c     |  9 ++++---
>>>>>>  block/blk-rq-qos.h     | 54 ++++++++++++++++++++++++------------------
>>>>>>  include/linux/blkdev.h |  1 +
>>>>>>  4 files changed, 37 insertions(+), 28 deletions(-)
>>>>>>
>>>>>> diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
>>>>>> index 7ed3e71f2fc0..32c65efdda46 100644
>>>>>> --- a/block/blk-mq-debugfs.c
>>>>>> +++ b/block/blk-mq-debugfs.c
>>>>>> @@ -95,6 +95,7 @@ static const char *const blk_queue_flag_name[] = {
>>>>>>  	QUEUE_FLAG_NAME(SQ_SCHED),
>>>>>>  	QUEUE_FLAG_NAME(DISABLE_WBT_DEF),
>>>>>>  	QUEUE_FLAG_NAME(NO_ELV_SWITCH),
>>>>>> +	QUEUE_FLAG_NAME(QOS_ENABLED),
>>>>>>  };
>>>>>>  #undef QUEUE_FLAG_NAME
>>>>>>  
>>>>>> diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
>>>>>> index b1e24bb85ad2..654478dfbc20 100644
>>>>>> --- a/block/blk-rq-qos.c
>>>>>> +++ b/block/blk-rq-qos.c
>>>>>> @@ -2,8 +2,6 @@
>>>>>>  
>>>>>>  #include "blk-rq-qos.h"
>>>>>>  
>>>>>> -__read_mostly DEFINE_STATIC_KEY_FALSE(block_rq_qos);
>>>>>> -
>>>>>>  /*
>>>>>>   * Increment 'v', if 'v' is below 'below'. Returns true if we succeeded,
>>>>>>   * false if 'v' + 1 would be bigger than 'below'.
>>>>>> @@ -319,8 +317,8 @@ void rq_qos_exit(struct request_queue *q)
>>>>>>  		struct rq_qos *rqos = q->rq_qos;
>>>>>>  		q->rq_qos = rqos->next;
>>>>>>  		rqos->ops->exit(rqos);
>>>>>> -		static_branch_dec(&block_rq_qos);
>>>>>>  	}
>>>>>> +	blk_queue_flag_clear(QUEUE_FLAG_QOS_ENABLED, q);
>>>>>>  	mutex_unlock(&q->rq_qos_mutex);
>>>>>>  }
>>>>>>  
>>>>>> @@ -346,7 +344,7 @@ int rq_qos_add(struct rq_qos *rqos, struct gendisk *disk, enum rq_qos_id id,
>>>>>>  		goto ebusy;
>>>>>>  	rqos->next = q->rq_qos;
>>>>>>  	q->rq_qos = rqos;
>>>>>> -	static_branch_inc(&block_rq_qos);
>>>>>> +	blk_queue_flag_set(QUEUE_FLAG_QOS_ENABLED, q);
>>>>>
>>>>> One stupid question: can we simply move static_branch_inc(&block_rq_qos)
>>>>> out of queue freeze in rq_qos_add()?
>>>>>
>>>>> What matters is just the 1st static_branch_inc() which switches the counter
>>>>> from 0 to 1, when blk_mq_freeze_queue() guarantees that all in-progress code
>>>>> paths observe q->rq_qos as NULL. That means static_branch_inc(&block_rq_qos)
>>>>> needn't queue freeze protection.
>>>>>
>>>> I thought about it earlier but that won't work because we have 
>>>> code paths freezing queue before it reaches upto rq_qos_add(),
>>>> For instance:
>>>>
>>>> We have following code paths from where we invoke
>>>> rq_qos_add() APIs with queue already frozen:
>>>>
>>>> ioc_qos_write()
>>>>  -> blkg_conf_open_bdev_frozen() => freezes queue
>>>>  -> blk_iocost_init()
>>>>    -> rq_qos_add()
>>>>
>>>> queue_wb_lat_store()  => freezes queue
>>>>  -> wbt_init()
>>>>   -> rq_qos_add() 
>>>
>>> The above two shouldn't be hard to solve, such as, add helper
>>> rq_qos_prep_add() for increasing the static branch counter.
>>>
>> Yes but then it means that IOs which would be in flight 
>> would take a hit in hotpath: In hotpath those IOs
>> would evaluate static key branch to true and then fetch 
>> q->rq_qos (which probably would not be in the first
>> cacheline). So are we okay to take hat hit in IO 
>> hotpath?
> 
> But it is that in-tree code is doing, isn't it?
> 
> `static branch` is only evaluated iff at least one rqos is added.
> 
In the current in-tree implementation, the static branch is evaluated
only if at least one rq_qos is added.

Per you suggested change, we would increment the static branch key before
freezing the queue (and before attaching the QoS policy to the request queue).
This means that any I/O already in flight would see the static branch key
as enabled and would proceed to fetch q->rq_qos, even though q->rq_qos would
still be NULL at that point since the QoS policy hasn’t yet been attached.
This results in a performance penalty due to the additional q->rq_qos fetch.

In contrast, the current tree avoids this penalty. The existing sequence is:
- Freeze the queue.
- Attach the QoS policy to the queue (q->rq_qos becomes non-NULL).
- Increment the static branch key.
- Unfreeze the queue.

With this ordering, if the hotpath finds the static branch key enabled, it is
guaranteed that q->rq_qos is non-NULL. Thus, we either:
- Skip evaluating the static branch key (and q->rq_qos) entirely, or
- If the static branch key is enabled, also have a valid q->rq_qos.

In summary, it appears that your proposed ordering introduces a window where the
static branch key is enabled but q->rq_qos is still NULL, incurring unnecessary
fetch overhead in the I/O hotpath.

Thanks,
--Nilay


