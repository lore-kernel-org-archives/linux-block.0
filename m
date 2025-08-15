Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853DB1FDA89
	for <linux-block@vger.kernel.org>; Fri, 15 Aug 2025 18:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755282845; cv=none; b=uL/vKKXQO4omPgkSI9NZvnGnm7j6oy+Au0yQVCavZhoywz4/xXjmzvg9W1lhZ/M4WrziK/1RvYozzmTZOlXK3ugeh/+1udx95dW1PPi7DFA5LvUPD2Gef34fZq4OYYIXe6mrMWCwwX6yaTlF0MUZqrjd8PZG95dXRzVKaseOO5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755282845; c=relaxed/simple;
	bh=cM/nFUhi4s1+Av8+9ypgb9qVTa8wE4EBFicMNu1Ym5A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XmKze+IK/45HVFItSX9fpwkXwxLLgFDEmg1uZbzNOmnxMiQD9NUWQlXnngjfVPqvaPYMfM5e94X9cSfYpereqqe50Ak16sPZAPFhKgGnE/DbfW0X5d7O2nCbQl5xhN/flRrRszIJxIrkiH+IMifI7/+5vITTJllt6BZlXjoAYb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qhptp/0S; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qhptp/0S"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57FGFOht011970;
	Fri, 15 Aug 2025 18:33:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=GxebQt
	8H4u9+Urz6HTYfl3CvMOSs2q23ivEcoMijAHE=; b=qhptp/0S4OzucgLlHhOQn3
	dfU+xp8XA5QvVWJm+ngPbqxt+zSm1sM8BblgllIAb4PqjmsY27vQzAM00hi6Phkm
	W7aXZOrTRdHvIxyZuN6UvvBOSTf6Oft6QhtPJv8YamVeOvjYd+NyI3STrQvGF67W
	QECv5z3ut4BRqpX53jKc28t7dNIK0K91MlNZTTeyGnHSFUoB3C662ZnW6E3sZw90
	k2A67caS+3kPtql1lNXF2u5MJeWhwbPviAVMgJeOAjbGtJhQ6SjMUF4yFpkEV53X
	U4mHk2k6pJCDdwl3u8OxgPLhoCoyW7u6hGO3jnXwN/w3De6yj/qbxII/AluZEPSw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48dururqwb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Aug 2025 18:33:47 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57FGuE5Z020623;
	Fri, 15 Aug 2025 18:33:46 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48ehnqa43p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Aug 2025 18:33:46 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57FIXksh29885092
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Aug 2025 18:33:46 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 27F2F5803F;
	Fri, 15 Aug 2025 18:33:46 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DA57558056;
	Fri, 15 Aug 2025 18:33:42 +0000 (GMT)
Received: from [9.61.100.151] (unknown [9.61.100.151])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 15 Aug 2025 18:33:42 +0000 (GMT)
Message-ID: <c6cf9190-0e23-4db3-a85d-d7f62cd3f568@linux.ibm.com>
Date: Sat, 16 Aug 2025 00:03:41 +0530
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
 <16975629-4988-4841-86bb-d4f3f40cc849@linux.ibm.com>
 <aJ80-lNF-ilorQq8@fedora>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <aJ80-lNF-ilorQq8@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 94kJ2uHBGxEgdtXF8U5cmZi3IHPxKimN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDIyNCBTYWx0ZWRfX+KJ2ZWVuNDsv
 +ZbZOYjCm5/qYNodrQA7C4UnFuXMaRNuW71JKID+W3wIezb7itnYZsfEwO/XNFWysv7woDugXjB
 IrhXxQcv9BYmqshQMx0WkpEvTVYmK2JkNRbtjVdP1yoqEOtxsPHSZBYp7z41cK5SB5dmHhgJhvx
 xc+mSxCoGxMugahrTZuj1i4YW38+vH/VsJCVa4AIuSapFisOIc7QcSDNPs0W85E/Bo3tpk5X55+
 IPegV0KdebAcI0sCI3u27DqhjcKG4g/kQSfECoaW/zVjIeO3I3A2XUF8PKbG7AsQSppLiFsJOH4
 B9BzTQY+yTcf2Gb4s8Yu7Gp8PE/aEdllq65Z29K0ULcmgLTklkBFCgE1wuCT3rjSr15MKfq3gt2
 XHh7QnJ3
X-Authority-Analysis: v=2.4 cv=QtNe3Uyd c=1 sm=1 tr=0 ts=689f7d8b cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=JF9118EUAAAA:8
 a=VnNF1IyMAAAA:8 a=HdNLkjWRgNRL3kcsLjcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-ORIG-GUID: 94kJ2uHBGxEgdtXF8U5cmZi3IHPxKimN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-15_06,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 phishscore=0 clxscore=1015 malwarescore=0
 spamscore=0 suspectscore=0 impostorscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508120224



On 8/15/25 6:54 PM, Ming Lei wrote:
> On Fri, Aug 15, 2025 at 03:13:19PM +0530, Nilay Shroff wrote:
>>
>>
>> On 8/15/25 5:43 AM, Ming Lei wrote:
>>> On Thu, Aug 14, 2025 at 08:01:11PM +0530, Nilay Shroff wrote:
>>>>
>>>>
>>>> On 8/14/25 7:08 PM, Ming Lei wrote:
>>>>> On Thu, Aug 14, 2025 at 06:27:08PM +0530, Nilay Shroff wrote:
>>>>>>
>>>>>>
>>>>>> On 8/14/25 6:14 PM, Ming Lei wrote:
>>>>>>> On Thu, Aug 14, 2025 at 01:54:59PM +0530, Nilay Shroff wrote:
>>>>>>>> A recent lockdep[1] splat observed while running blktest block/005
>>>>>>>> reveals a potential deadlock caused by the cpu_hotplug_lock dependency
>>>>>>>> on ->freeze_lock. This dependency was introduced by commit 033b667a823e
>>>>>>>> ("block: blk-rq-qos: guard rq-qos helpers by static key").
>>>>>>>>
>>>>>>>> That change added a static key to avoid fetching q->rq_qos when
>>>>>>>> neither blk-wbt nor blk-iolatency is configured. The static key
>>>>>>>> dynamically patches kernel text to a NOP when disabled, eliminating
>>>>>>>> overhead of fetching q->rq_qos in the I/O hot path. However, enabling
>>>>>>>> a static key at runtime requires acquiring both cpu_hotplug_lock and
>>>>>>>> jump_label_mutex. When this happens after the queue has already been
>>>>>>>> frozen (i.e., while holding ->freeze_lock), it creates a locking
>>>>>>>> dependency from cpu_hotplug_lock to ->freeze_lock, which leads to a
>>>>>>>> potential deadlock reported by lockdep [1].
>>>>>>>>
>>>>>>>> To resolve this, replace the static key mechanism with q->queue_flags:
>>>>>>>> QUEUE_FLAG_QOS_ENABLED. This flag is evaluated in the fast path before
>>>>>>>> accessing q->rq_qos. If the flag is set, we proceed to fetch q->rq_qos;
>>>>>>>> otherwise, the access is skipped.
>>>>>>>>
>>>>>>>> Since q->queue_flags is commonly accessed in IO hotpath and resides in
>>>>>>>> the first cacheline of struct request_queue, checking it imposes minimal
>>>>>>>> overhead while eliminating the deadlock risk.
>>>>>>>>
>>>>>>>> This change avoids the lockdep splat without introducing performance
>>>>>>>> regressions.
>>>>>>>>
>>>>>>>> [1] https://lore.kernel.org/linux-block/4fdm37so3o4xricdgfosgmohn63aa7wj3ua4e5vpihoamwg3ui@fq42f5q5t5ic/
>>>>>>>>
>>>>>>>> Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
>>>>>>>> Closes: https://lore.kernel.org/linux-block/4fdm37so3o4xricdgfosgmohn63aa7wj3ua4e5vpihoamwg3ui@fq42f5q5t5ic/
>>>>>>>> Fixes: 033b667a823e ("block: blk-rq-qos: guard rq-qos helpers by static key")
>>>>>>>> Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
>>>>>>>> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
>>>>>>>> ---
>>>>>>>>  block/blk-mq-debugfs.c |  1 +
>>>>>>>>  block/blk-rq-qos.c     |  9 ++++---
>>>>>>>>  block/blk-rq-qos.h     | 54 ++++++++++++++++++++++++------------------
>>>>>>>>  include/linux/blkdev.h |  1 +
>>>>>>>>  4 files changed, 37 insertions(+), 28 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
>>>>>>>> index 7ed3e71f2fc0..32c65efdda46 100644
>>>>>>>> --- a/block/blk-mq-debugfs.c
>>>>>>>> +++ b/block/blk-mq-debugfs.c
>>>>>>>> @@ -95,6 +95,7 @@ static const char *const blk_queue_flag_name[] = {
>>>>>>>>  	QUEUE_FLAG_NAME(SQ_SCHED),
>>>>>>>>  	QUEUE_FLAG_NAME(DISABLE_WBT_DEF),
>>>>>>>>  	QUEUE_FLAG_NAME(NO_ELV_SWITCH),
>>>>>>>> +	QUEUE_FLAG_NAME(QOS_ENABLED),
>>>>>>>>  };
>>>>>>>>  #undef QUEUE_FLAG_NAME
>>>>>>>>  
>>>>>>>> diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
>>>>>>>> index b1e24bb85ad2..654478dfbc20 100644
>>>>>>>> --- a/block/blk-rq-qos.c
>>>>>>>> +++ b/block/blk-rq-qos.c
>>>>>>>> @@ -2,8 +2,6 @@
>>>>>>>>  
>>>>>>>>  #include "blk-rq-qos.h"
>>>>>>>>  
>>>>>>>> -__read_mostly DEFINE_STATIC_KEY_FALSE(block_rq_qos);
>>>>>>>> -
>>>>>>>>  /*
>>>>>>>>   * Increment 'v', if 'v' is below 'below'. Returns true if we succeeded,
>>>>>>>>   * false if 'v' + 1 would be bigger than 'below'.
>>>>>>>> @@ -319,8 +317,8 @@ void rq_qos_exit(struct request_queue *q)
>>>>>>>>  		struct rq_qos *rqos = q->rq_qos;
>>>>>>>>  		q->rq_qos = rqos->next;
>>>>>>>>  		rqos->ops->exit(rqos);
>>>>>>>> -		static_branch_dec(&block_rq_qos);
>>>>>>>>  	}
>>>>>>>> +	blk_queue_flag_clear(QUEUE_FLAG_QOS_ENABLED, q);
>>>>>>>>  	mutex_unlock(&q->rq_qos_mutex);
>>>>>>>>  }
>>>>>>>>  
>>>>>>>> @@ -346,7 +344,7 @@ int rq_qos_add(struct rq_qos *rqos, struct gendisk *disk, enum rq_qos_id id,
>>>>>>>>  		goto ebusy;
>>>>>>>>  	rqos->next = q->rq_qos;
>>>>>>>>  	q->rq_qos = rqos;
>>>>>>>> -	static_branch_inc(&block_rq_qos);
>>>>>>>> +	blk_queue_flag_set(QUEUE_FLAG_QOS_ENABLED, q);
>>>>>>>
>>>>>>> One stupid question: can we simply move static_branch_inc(&block_rq_qos)
>>>>>>> out of queue freeze in rq_qos_add()?
>>>>>>>
>>>>>>> What matters is just the 1st static_branch_inc() which switches the counter
>>>>>>> from 0 to 1, when blk_mq_freeze_queue() guarantees that all in-progress code
>>>>>>> paths observe q->rq_qos as NULL. That means static_branch_inc(&block_rq_qos)
>>>>>>> needn't queue freeze protection.
>>>>>>>
>>>>>> I thought about it earlier but that won't work because we have 
>>>>>> code paths freezing queue before it reaches upto rq_qos_add(),
>>>>>> For instance:
>>>>>>
>>>>>> We have following code paths from where we invoke
>>>>>> rq_qos_add() APIs with queue already frozen:
>>>>>>
>>>>>> ioc_qos_write()
>>>>>>  -> blkg_conf_open_bdev_frozen() => freezes queue
>>>>>>  -> blk_iocost_init()
>>>>>>    -> rq_qos_add()
>>>>>>
>>>>>> queue_wb_lat_store()  => freezes queue
>>>>>>  -> wbt_init()
>>>>>>   -> rq_qos_add() 
>>>>>
>>>>> The above two shouldn't be hard to solve, such as, add helper
>>>>> rq_qos_prep_add() for increasing the static branch counter.
>>>>>
>>>> Yes but then it means that IOs which would be in flight 
>>>> would take a hit in hotpath: In hotpath those IOs
>>>> would evaluate static key branch to true and then fetch 
>>>> q->rq_qos (which probably would not be in the first
>>>> cacheline). So are we okay to take hat hit in IO 
>>>> hotpath?
>>>
>>> But it is that in-tree code is doing, isn't it?
>>>
>>> `static branch` is only evaluated iff at least one rqos is added.
>>>
>> In the current in-tree implementation, the static branch is evaluated
>> only if at least one rq_qos is added.
>>
>> Per you suggested change, we would increment the static branch key before
>> freezing the queue (and before attaching the QoS policy to the request queue).
>> This means that any I/O already in flight would see the static branch key
>> as enabled and would proceed to fetch q->rq_qos, even though q->rq_qos would
>> still be NULL at that point since the QoS policy hasn’t yet been attached.
>> This results in a performance penalty due to the additional q->rq_qos fetch.
>>
>> In contrast, the current tree avoids this penalty. The existing sequence is:
>> - Freeze the queue.
>> - Attach the QoS policy to the queue (q->rq_qos becomes non-NULL).
>> - Increment the static branch key.
>> - Unfreeze the queue.
>>
>> With this ordering, if the hotpath finds the static branch key enabled, it is
>> guaranteed that q->rq_qos is non-NULL. Thus, we either:
>> - Skip evaluating the static branch key (and q->rq_qos) entirely, or
>> - If the static branch key is enabled, also have a valid q->rq_qos.
>>
>> In summary, it appears that your proposed ordering introduces a window where the
>> static branch key is enabled but q->rq_qos is still NULL, incurring unnecessary
>> fetch overhead in the I/O hotpath.
> 
> Yes, but the window is pretty small, so the extra overhead isn't something
> matters. More importantly it shows correct static_branch_*() usage, which is
> supposed to be called safely without subsystem lock.
> 
I see your point about static_branch_*() usage being independent of the subsystem
lock, but in this case that “small window” still sits directly in the I/O hotpath
and will be hit by all in-flight requests during queue freeze. The current ordering
is intentionally structured so that:

1. The branch is only enabled after q->rq_qos is guaranteed non-NULL.
2. Any hotpath evaluation of the static key implies a valid pointer
   dereference with no wasted cache miss.
Even if the window is short, we’d still pay for unnecessary q->rq_qos loads and
possible cacheline misses for every inflight I/O during that period. In practice,
that’s why this patch replaces the static key with a queue_flags bit: it’s lock-
free to update, eliminates the deadlock risk, and preserves the “no penalty until
active” property without depending on lock ordering subtlety. 

Having said that, I’m not opposed to reworking the patch per your proposal if 
all agree the minor hotpath cost is acceptable, but wanted to make sure the
trade-off is clear. 

Thanks,
--Nilay

