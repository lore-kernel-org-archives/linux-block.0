Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859182FE06C
	for <linux-block@vger.kernel.org>; Thu, 14 Aug 2025 13:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755176561; cv=none; b=Etzu6iEdAdqecpBUV43unJPFA8QtsXJFFTl9IkjQ+S7iI/RjoQ4/8NAVF01WEOnuO7LAUTpcCHA1U9ZFTvTL23oXrwGpwJGcNEAcHM5+dPrXFAAiO4f3i/QvBzHBDNBaPrheIxypsebvsELLGjFMzjNRuzAAfXVR9oCAjmcNvHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755176561; c=relaxed/simple;
	bh=hzuK1pZRgdtzeovP11h9NBC07su8oLQuK8kZkH81GK0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O6NYtecT2FDGUB70ssw1homLiQx6Qf1eduOf6oNBu59ibxY1qPXUvHucoPfGzqaoQlTfrZEHJKlNSQ+/+NhIRjWkNbj69O64FRSkP1KUj5PE5xgyG+3EBl48HNS5PvUeE+962U+6oPEM1SEIzkgN4K+cyVkoQHIeZtAJdhJ2wVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NRjz/Mcg; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NRjz/Mcg"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57EBr5d7025083;
	Thu, 14 Aug 2025 12:57:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=fDTvV1
	+NBvMQ6AchcLBkKsaM/DsOEHVcw4KKGkb3Vo0=; b=NRjz/Mcgj0I6lbwsQ3HwSC
	HlS3KDf4tmDwlOW6DFrBZQUexH0uNXgqzsAro0/Ypiu/UkXVm1aSVtt63zPvzdUg
	pY2jyf4VwIQCpmFqY3VQAXAcGYw349pGWtEOIo7/NdT2u0nozSqa3kbcmjQsP4Rj
	3HuX5E62+lxNGwhsZFpzaeUPt1Qar9oDudjR6FYsWX9eTtlnbzFVjHyi7XuRDTOW
	XzDAolcxzjE9sIwRh+PPdmS3oQ+VnXwu9DxVJ/CPgidY0B8WPfcXk59uNDI6uczF
	edFf0GwVbp24T7N5k/RBCWB6GT21N+jCnJKAOGZXaBMnFfwiILxPFJmz5sqYU0Qw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48ehaaec1j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Aug 2025 12:57:14 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57EAw57b017594;
	Thu, 14 Aug 2025 12:57:13 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 48ekc3uv0a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Aug 2025 12:57:13 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57ECvCGi28705084
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Aug 2025 12:57:13 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D8C9458058;
	Thu, 14 Aug 2025 12:57:12 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4442F58059;
	Thu, 14 Aug 2025 12:57:10 +0000 (GMT)
Received: from [9.109.198.214] (unknown [9.109.198.214])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 14 Aug 2025 12:57:09 +0000 (GMT)
Message-ID: <e125025b-d576-4919-b00e-5d9b640bed77@linux.ibm.com>
Date: Thu, 14 Aug 2025 18:27:08 +0530
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
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <aJ3aR2JodRrAqVcO@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=KPRaDEFo c=1 sm=1 tr=0 ts=689ddd2a cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=JF9118EUAAAA:8
 a=VnNF1IyMAAAA:8 a=CzzpntjSp5ce4x9q5oAA:9 a=QEXdDO2ut3YA:10
 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-ORIG-GUID: hGctg3rk7gvxvsd847-_WHx-HuCgL69o
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDIyNCBTYWx0ZWRfX3AxvFROBTlZp
 x13f9tbRfy/kUVIfcSyoBe6LptfpTrbohJ7Xvj5khaHU2ZqwVLuIbMDUNawqfR6NEA7V7YZ1K34
 V5jRAcWX4Whg3tW9+8PN8s+7YoR7WkdB0+yaDN6WSrHhAj98AMMCEWTlgYE5sleqC4l2qGE7lQY
 t0SqA4w7YbSwmY8+i7l4PmIQSKL3gno0PrPRQ2AAYcbfGTptM2YticL/KDBsNvcwEEVDMKP8gOf
 8R76H7gENIDAaxKb+z+m9VSbX2c3PBOlJrjK9Vml4AFpYwGclnSQNMP/u//S8u2xEDEr4dAbyZN
 i8h4IoGMAl3YbvmNV0e0DesO6rzjqbeDdac1ethqgElD3v2ETaY5bSr9+3xyZ7u9P3Pt+f1ovb8
 Y7/BKPUn
X-Proofpoint-GUID: hGctg3rk7gvxvsd847-_WHx-HuCgL69o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_02,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 spamscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508120224



On 8/14/25 6:14 PM, Ming Lei wrote:
> On Thu, Aug 14, 2025 at 01:54:59PM +0530, Nilay Shroff wrote:
>> A recent lockdep[1] splat observed while running blktest block/005
>> reveals a potential deadlock caused by the cpu_hotplug_lock dependency
>> on ->freeze_lock. This dependency was introduced by commit 033b667a823e
>> ("block: blk-rq-qos: guard rq-qos helpers by static key").
>>
>> That change added a static key to avoid fetching q->rq_qos when
>> neither blk-wbt nor blk-iolatency is configured. The static key
>> dynamically patches kernel text to a NOP when disabled, eliminating
>> overhead of fetching q->rq_qos in the I/O hot path. However, enabling
>> a static key at runtime requires acquiring both cpu_hotplug_lock and
>> jump_label_mutex. When this happens after the queue has already been
>> frozen (i.e., while holding ->freeze_lock), it creates a locking
>> dependency from cpu_hotplug_lock to ->freeze_lock, which leads to a
>> potential deadlock reported by lockdep [1].
>>
>> To resolve this, replace the static key mechanism with q->queue_flags:
>> QUEUE_FLAG_QOS_ENABLED. This flag is evaluated in the fast path before
>> accessing q->rq_qos. If the flag is set, we proceed to fetch q->rq_qos;
>> otherwise, the access is skipped.
>>
>> Since q->queue_flags is commonly accessed in IO hotpath and resides in
>> the first cacheline of struct request_queue, checking it imposes minimal
>> overhead while eliminating the deadlock risk.
>>
>> This change avoids the lockdep splat without introducing performance
>> regressions.
>>
>> [1] https://lore.kernel.org/linux-block/4fdm37so3o4xricdgfosgmohn63aa7wj3ua4e5vpihoamwg3ui@fq42f5q5t5ic/
>>
>> Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
>> Closes: https://lore.kernel.org/linux-block/4fdm37so3o4xricdgfosgmohn63aa7wj3ua4e5vpihoamwg3ui@fq42f5q5t5ic/
>> Fixes: 033b667a823e ("block: blk-rq-qos: guard rq-qos helpers by static key")
>> Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
>> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
>> ---
>>  block/blk-mq-debugfs.c |  1 +
>>  block/blk-rq-qos.c     |  9 ++++---
>>  block/blk-rq-qos.h     | 54 ++++++++++++++++++++++++------------------
>>  include/linux/blkdev.h |  1 +
>>  4 files changed, 37 insertions(+), 28 deletions(-)
>>
>> diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
>> index 7ed3e71f2fc0..32c65efdda46 100644
>> --- a/block/blk-mq-debugfs.c
>> +++ b/block/blk-mq-debugfs.c
>> @@ -95,6 +95,7 @@ static const char *const blk_queue_flag_name[] = {
>>  	QUEUE_FLAG_NAME(SQ_SCHED),
>>  	QUEUE_FLAG_NAME(DISABLE_WBT_DEF),
>>  	QUEUE_FLAG_NAME(NO_ELV_SWITCH),
>> +	QUEUE_FLAG_NAME(QOS_ENABLED),
>>  };
>>  #undef QUEUE_FLAG_NAME
>>  
>> diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
>> index b1e24bb85ad2..654478dfbc20 100644
>> --- a/block/blk-rq-qos.c
>> +++ b/block/blk-rq-qos.c
>> @@ -2,8 +2,6 @@
>>  
>>  #include "blk-rq-qos.h"
>>  
>> -__read_mostly DEFINE_STATIC_KEY_FALSE(block_rq_qos);
>> -
>>  /*
>>   * Increment 'v', if 'v' is below 'below'. Returns true if we succeeded,
>>   * false if 'v' + 1 would be bigger than 'below'.
>> @@ -319,8 +317,8 @@ void rq_qos_exit(struct request_queue *q)
>>  		struct rq_qos *rqos = q->rq_qos;
>>  		q->rq_qos = rqos->next;
>>  		rqos->ops->exit(rqos);
>> -		static_branch_dec(&block_rq_qos);
>>  	}
>> +	blk_queue_flag_clear(QUEUE_FLAG_QOS_ENABLED, q);
>>  	mutex_unlock(&q->rq_qos_mutex);
>>  }
>>  
>> @@ -346,7 +344,7 @@ int rq_qos_add(struct rq_qos *rqos, struct gendisk *disk, enum rq_qos_id id,
>>  		goto ebusy;
>>  	rqos->next = q->rq_qos;
>>  	q->rq_qos = rqos;
>> -	static_branch_inc(&block_rq_qos);
>> +	blk_queue_flag_set(QUEUE_FLAG_QOS_ENABLED, q);
> 
> One stupid question: can we simply move static_branch_inc(&block_rq_qos)
> out of queue freeze in rq_qos_add()?
> 
> What matters is just the 1st static_branch_inc() which switches the counter
> from 0 to 1, when blk_mq_freeze_queue() guarantees that all in-progress code
> paths observe q->rq_qos as NULL. That means static_branch_inc(&block_rq_qos)
> needn't queue freeze protection.
> 
I thought about it earlier but that won't work because we have 
code paths freezing queue before it reaches upto rq_qos_add(),
For instance:

We have following code paths from where we invoke
rq_qos_add() APIs with queue already frozen:

ioc_qos_write()
 -> blkg_conf_open_bdev_frozen() => freezes queue
 -> blk_iocost_init()
   -> rq_qos_add()

queue_wb_lat_store()  => freezes queue
 -> wbt_init()
  -> rq_qos_add() 

And yes we do have code path leading to rq_qos_exit() 
which freezes queue first:

__del_gendisk()  => freezes queue 
  -> rq_qos_exit()   

And similarly for rq_qos_delete():
ioc_qos_write()
 -> blkg_conf_open_bdev_frozen() => freezes queue
 -> blk_iocost_init()
  -> rq_qos_del() 

So even if we move static_branch_inc() out of freeze queue 
in rq_qos_add(), it'd still cause the observed lockdep 
splat.

Thanks,
--Nilay
