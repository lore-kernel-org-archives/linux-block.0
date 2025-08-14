Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1783B1AB
	for <linux-block@vger.kernel.org>; Thu, 14 Aug 2025 14:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755181905; cv=none; b=AqnBJmQxVQuV2RwFyo7HQ34L18dDAOreVvxxNA+Xz1PqtYhxvI6M3tnYLoIMCxoTyWJzhflNwevOmJRGQaT/vSTKXzgFMudI3spT5QbBZB8fpIuGtboZGmvidaFc/fkQfsQjxQrhaMN7HFUiZU0MrJjO1sMDXhLcVVdQxKTYrLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755181905; c=relaxed/simple;
	bh=WgITpGmVnaJ+Hfld5YO9YqBzinaPu/JejrUyL54DzHQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KHgmbJk5GHvUkMUrHRpSEU4dJGLY8loaWPwTuZ7hNQBj3/8ECye6aBGLUyODMHRkrdG45O5bLweHPJ7CvzeHpydT0ugQMA/3FRoMvZTHSGhR5e25Il89rbM5l/Bp6L2gUQojfiQ+XVxgwGM8haq5bwbRYPlEaHAae1N0fyo0wC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dA/5/dhz; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dA/5/dhz"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57EEVWVG011950;
	Thu, 14 Aug 2025 14:31:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=EgCA9T
	CqK8beIHpQTND5WSEyHvh6WdF4yuxfMgOdNKY=; b=dA/5/dhzPvAa7j5XOOSSxF
	NwMfOIrPmG1qnVgt2F3F6LD9SlYCXWI67Iytvv8SvunatXLWGtLFpXX3GIyitcto
	5W0KIcJ9ZCWOdvVouAd2JZS/PIbwcHFmDdXjdS29MzdNVaB4DJQvDTS6jZaCxkfl
	rpJwET5fh/Od2rP6janyk2grf6hhzW7KyLEqa7y7/hDiMLw7r+wnqrdQYe47YE6G
	PZ+1qXmiE0UIwNi+zYkOig5SV3R7jFG6t18mvc90IQ3ztVoCz0t01qPxfz+8PLnI
	tau1IrKyMbCSweurbv4ChoYCpxsiMddreKy+lGaip2m37fwLNBe9OO5QNOVwo2Sw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48durujjte-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Aug 2025 14:31:32 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57EEIggH025643;
	Thu, 14 Aug 2025 14:31:16 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 48ejvmmbce-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Aug 2025 14:31:16 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57EEVF5H21627530
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Aug 2025 14:31:15 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3FEFE58059;
	Thu, 14 Aug 2025 14:31:15 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AA17758057;
	Thu, 14 Aug 2025 14:31:12 +0000 (GMT)
Received: from [9.109.198.214] (unknown [9.109.198.214])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 14 Aug 2025 14:31:12 +0000 (GMT)
Message-ID: <e33e97f7-0c12-4f70-81d0-4fea05557579@linux.ibm.com>
Date: Thu, 14 Aug 2025 20:01:11 +0530
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
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <aJ3myQW2A8HtteBC@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: IZAWhSs9WvMjc9eyUsRMXRFFWEA8U08i
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDIyNCBTYWx0ZWRfX5nzl9fcPpgAZ
 So43rzPdZcmp9PUCrUB0xsCfbQyXo9o9NgI8VtFemNEjMEGJ6RsAn2Rm8lry0n+O8tfU087Vtfv
 a7t2PLJW3TNEK7nILG47y4Kn2eDO81/I4nOy7s7Y4TyoxKO1r2+2p1Y6RcN8Ul53RRvLS+Md/Hz
 25opZoo5FpqeBcFOobBjuvKY5F/dt6pdR03fnosQS7YBXaBEIGCRnvoLHjWAE7GXDPlvVmLfkiw
 Gd6nqNN2amG7zCWddIGK1ElYl5Mv9FraMxRq78EAq9Hyz3Wl+ypdXorGZyZ04Jgji/k3Xz86f0u
 i7gafoPn5HMC8rP2yLA6RAzI+VlKqm18CN0w1vfw58JqWLmUXywzqGOv9CKT3GiJY9XE9eakIp/
 UpzNlaBY
X-Authority-Analysis: v=2.4 cv=QtNe3Uyd c=1 sm=1 tr=0 ts=689df344 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=JF9118EUAAAA:8
 a=VnNF1IyMAAAA:8 a=6tXiPXw5URFcH89598kA:9 a=QEXdDO2ut3YA:10
 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-ORIG-GUID: IZAWhSs9WvMjc9eyUsRMXRFFWEA8U08i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_02,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 phishscore=0 clxscore=1015 malwarescore=0
 spamscore=0 suspectscore=0 impostorscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508120224



On 8/14/25 7:08 PM, Ming Lei wrote:
> On Thu, Aug 14, 2025 at 06:27:08PM +0530, Nilay Shroff wrote:
>>
>>
>> On 8/14/25 6:14 PM, Ming Lei wrote:
>>> On Thu, Aug 14, 2025 at 01:54:59PM +0530, Nilay Shroff wrote:
>>>> A recent lockdep[1] splat observed while running blktest block/005
>>>> reveals a potential deadlock caused by the cpu_hotplug_lock dependency
>>>> on ->freeze_lock. This dependency was introduced by commit 033b667a823e
>>>> ("block: blk-rq-qos: guard rq-qos helpers by static key").
>>>>
>>>> That change added a static key to avoid fetching q->rq_qos when
>>>> neither blk-wbt nor blk-iolatency is configured. The static key
>>>> dynamically patches kernel text to a NOP when disabled, eliminating
>>>> overhead of fetching q->rq_qos in the I/O hot path. However, enabling
>>>> a static key at runtime requires acquiring both cpu_hotplug_lock and
>>>> jump_label_mutex. When this happens after the queue has already been
>>>> frozen (i.e., while holding ->freeze_lock), it creates a locking
>>>> dependency from cpu_hotplug_lock to ->freeze_lock, which leads to a
>>>> potential deadlock reported by lockdep [1].
>>>>
>>>> To resolve this, replace the static key mechanism with q->queue_flags:
>>>> QUEUE_FLAG_QOS_ENABLED. This flag is evaluated in the fast path before
>>>> accessing q->rq_qos. If the flag is set, we proceed to fetch q->rq_qos;
>>>> otherwise, the access is skipped.
>>>>
>>>> Since q->queue_flags is commonly accessed in IO hotpath and resides in
>>>> the first cacheline of struct request_queue, checking it imposes minimal
>>>> overhead while eliminating the deadlock risk.
>>>>
>>>> This change avoids the lockdep splat without introducing performance
>>>> regressions.
>>>>
>>>> [1] https://lore.kernel.org/linux-block/4fdm37so3o4xricdgfosgmohn63aa7wj3ua4e5vpihoamwg3ui@fq42f5q5t5ic/
>>>>
>>>> Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
>>>> Closes: https://lore.kernel.org/linux-block/4fdm37so3o4xricdgfosgmohn63aa7wj3ua4e5vpihoamwg3ui@fq42f5q5t5ic/
>>>> Fixes: 033b667a823e ("block: blk-rq-qos: guard rq-qos helpers by static key")
>>>> Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
>>>> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
>>>> ---
>>>>  block/blk-mq-debugfs.c |  1 +
>>>>  block/blk-rq-qos.c     |  9 ++++---
>>>>  block/blk-rq-qos.h     | 54 ++++++++++++++++++++++++------------------
>>>>  include/linux/blkdev.h |  1 +
>>>>  4 files changed, 37 insertions(+), 28 deletions(-)
>>>>
>>>> diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
>>>> index 7ed3e71f2fc0..32c65efdda46 100644
>>>> --- a/block/blk-mq-debugfs.c
>>>> +++ b/block/blk-mq-debugfs.c
>>>> @@ -95,6 +95,7 @@ static const char *const blk_queue_flag_name[] = {
>>>>  	QUEUE_FLAG_NAME(SQ_SCHED),
>>>>  	QUEUE_FLAG_NAME(DISABLE_WBT_DEF),
>>>>  	QUEUE_FLAG_NAME(NO_ELV_SWITCH),
>>>> +	QUEUE_FLAG_NAME(QOS_ENABLED),
>>>>  };
>>>>  #undef QUEUE_FLAG_NAME
>>>>  
>>>> diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
>>>> index b1e24bb85ad2..654478dfbc20 100644
>>>> --- a/block/blk-rq-qos.c
>>>> +++ b/block/blk-rq-qos.c
>>>> @@ -2,8 +2,6 @@
>>>>  
>>>>  #include "blk-rq-qos.h"
>>>>  
>>>> -__read_mostly DEFINE_STATIC_KEY_FALSE(block_rq_qos);
>>>> -
>>>>  /*
>>>>   * Increment 'v', if 'v' is below 'below'. Returns true if we succeeded,
>>>>   * false if 'v' + 1 would be bigger than 'below'.
>>>> @@ -319,8 +317,8 @@ void rq_qos_exit(struct request_queue *q)
>>>>  		struct rq_qos *rqos = q->rq_qos;
>>>>  		q->rq_qos = rqos->next;
>>>>  		rqos->ops->exit(rqos);
>>>> -		static_branch_dec(&block_rq_qos);
>>>>  	}
>>>> +	blk_queue_flag_clear(QUEUE_FLAG_QOS_ENABLED, q);
>>>>  	mutex_unlock(&q->rq_qos_mutex);
>>>>  }
>>>>  
>>>> @@ -346,7 +344,7 @@ int rq_qos_add(struct rq_qos *rqos, struct gendisk *disk, enum rq_qos_id id,
>>>>  		goto ebusy;
>>>>  	rqos->next = q->rq_qos;
>>>>  	q->rq_qos = rqos;
>>>> -	static_branch_inc(&block_rq_qos);
>>>> +	blk_queue_flag_set(QUEUE_FLAG_QOS_ENABLED, q);
>>>
>>> One stupid question: can we simply move static_branch_inc(&block_rq_qos)
>>> out of queue freeze in rq_qos_add()?
>>>
>>> What matters is just the 1st static_branch_inc() which switches the counter
>>> from 0 to 1, when blk_mq_freeze_queue() guarantees that all in-progress code
>>> paths observe q->rq_qos as NULL. That means static_branch_inc(&block_rq_qos)
>>> needn't queue freeze protection.
>>>
>> I thought about it earlier but that won't work because we have 
>> code paths freezing queue before it reaches upto rq_qos_add(),
>> For instance:
>>
>> We have following code paths from where we invoke
>> rq_qos_add() APIs with queue already frozen:
>>
>> ioc_qos_write()
>>  -> blkg_conf_open_bdev_frozen() => freezes queue
>>  -> blk_iocost_init()
>>    -> rq_qos_add()
>>
>> queue_wb_lat_store()  => freezes queue
>>  -> wbt_init()
>>   -> rq_qos_add() 
> 
> The above two shouldn't be hard to solve, such as, add helper
> rq_qos_prep_add() for increasing the static branch counter.
> 
Yes but then it means that IOs which would be in flight 
would take a hit in hotpath: In hotpath those IOs
would evaluate static key branch to true and then fetch 
q->rq_qos (which probably would not be in the first
cacheline). So are we okay to take hat hit in IO 
hotpath?

Thanks,
--Nilay
