Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7E71AD3E5
	for <linux-block@vger.kernel.org>; Thu,  5 Jun 2025 05:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749102752; cv=none; b=nZmDKLGxeccwQXZkm9ildNJKzY5trPQQBjr1hITPwrorjQZRVY180yITR5/AMLI5rq9VtKp5rSyeQ/WF8CplWsB0o0m6xuTvriWvh5t6x/JHT+Kmrz/f0rVRskIkCw6gNuSju/iCRCNmEYZTcSv+jYzaVp+myRWH7SOE+RirnBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749102752; c=relaxed/simple;
	bh=JciSyiceL5IkFwryjWrxwdk3fSpkIVDd6JyuBGuFrn8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FZkRay1Nc6jKTBqCFsFNkBSLs+N71f5XR3rwSQdvx5lz8kD5F14IFj3zXm3IroQ9KZhQbxp6x/sbB8U0jjMti14I2iRo9ISNFSQ5dXjWqeOZz5h6FEvuqyxpgscp4eszu7Iox8kug5XkAWX850oh6on0JNfmXtqKCZRMRz049XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UU42Hiw/; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UU42Hiw/"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 554NJgg7031704;
	Thu, 5 Jun 2025 05:52:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=4SiwDu
	psQSUvVpGu1n2PLjqQ5OfdvnhHDJiiys9Nrs0=; b=UU42Hiw/gcqTEeTUChciFD
	lZgaXhEANYnnJwG9oFKJhG6q/gWv6DRKa/3Ve52EYHIy8Yd6W6p/g74c6/ci8VtO
	6moZVmjnxBp5RlhSQbm8nNw8So6R56j952ItJvfT+XyFS48Cbe53HW9oQGZy+mL7
	52Y115FZ+PS0A1vRiRn0aIgpgRg2aO7+kkQHBQrpYJA81/Q9f18+FtA83cNanQNN
	C37dbroP5UxF18AnrYDdrkPH56Ry6hHqDz1D7IXb8mRe2fgkTUJgY9rg3Sh356sh
	YsyMz1UzIzGmUfOUi2b/VHPCM0ar4gNu9+qyDVdP2b93fN5R8ytcRt5aPaG/eLVA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 471geyxnhw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Jun 2025 05:52:23 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5553gAjN024883;
	Thu, 5 Jun 2025 05:52:23 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 470dkmk8uc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Jun 2025 05:52:23 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5555qMKl27263242
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 5 Jun 2025 05:52:22 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0EFE85805B;
	Thu,  5 Jun 2025 05:52:22 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C23DB5804B;
	Thu,  5 Jun 2025 05:52:19 +0000 (GMT)
Received: from [9.109.198.212] (unknown [9.109.198.212])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  5 Jun 2025 05:52:19 +0000 (GMT)
Message-ID: <9f5b0cbb-10cb-44a7-9565-28673bcbdf84@linux.ibm.com>
Date: Thu, 5 Jun 2025 11:22:17 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2] block: fix lock dependency between percpu alloc lock
 and elevator lock
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, hch@lst.de, axboe@kernel.dk,
        sth@linux.ibm.com, gjoyce@ibm.com
References: <20250528123638.1029700-1-nilay@linux.ibm.com>
 <aD60SF6QGMSPykq-@fedora>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <aD60SF6QGMSPykq-@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: HiZczpvlhHAZPXqUsVHBYsl0VgPKVt3R
X-Proofpoint-ORIG-GUID: HiZczpvlhHAZPXqUsVHBYsl0VgPKVt3R
X-Authority-Analysis: v=2.4 cv=X4dSKHTe c=1 sm=1 tr=0 ts=68413098 cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=rN6svEpRv8TEEN-SXq8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA1MDA0NyBTYWx0ZWRfXzgYtP5d3zQrH aqE66eZJoXwXCMUgkWokYw9mY+sH3ISqdWCyj00aUhhiig70iOkaghnxfCNivSnl7stvpAB2OCK Poe53bJyJUvOsqC70UYLMRmT/HJpzEloIu8nWSFsSW8DHqBj0xKrgIs+kM+Dbj5ZGyrD/VbxFQe
 YurVrmGrgf+N/mNXe6sK2ZEolkayz6e+Ob2jzk6t7C5SfF2U21pke+y62Q3CZumyRlShv4xgcAM DFI30nYtLTdbY60orUkTVawfkkxBjRSUNlaZYy23frXxAmiNHXUrQCGtog60crFkZOHdmacDwee Z1dKme/O/B4GoWFKQ/fkN3iCaYf/5bD2TVvcHqnen9TlF93SP0REEB49VMfJ93RaYkHu/e/nzzQ
 QBEF7LcSBDP8wv7+xh/e3gjn76WV3lhjF5uieQM4Q1i14uTx30RAff1Rqk3+HZ33bgb8O5CU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-05_01,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 clxscore=1015 phishscore=0 bulkscore=0
 malwarescore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506050047



On 6/3/25 2:07 PM, Ming Lei wrote:
> On Wed, May 28, 2025 at 06:03:58PM +0530, Nilay Shroff wrote:

>> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
>> index 0cb1e9873aab..51d406da4abf 100644
>> --- a/block/bfq-iosched.c
>> +++ b/block/bfq-iosched.c
>> @@ -7232,17 +7232,12 @@ static void bfq_init_root_group(struct bfq_group *root_group,
>>  	root_group->sched_data.bfq_class_idle_last_service = jiffies;
>>  }
>>  
>> -static int bfq_init_queue(struct request_queue *q, struct elevator_type *e)
>> +static int bfq_init_queue(struct request_queue *q, struct elevator_queue *eq)
>>  {
>>  	struct bfq_data *bfqd;
>> -	struct elevator_queue *eq;
>>  	unsigned int i;
>>  	struct blk_independent_access_ranges *ia_ranges = q->disk->ia_ranges;
>>  
>> -	eq = elevator_alloc(q, e);
>> -	if (!eq)
>> -		return -ENOMEM;
>> -
> 
> Please make the above elevator interface change be one standalone patch if possible,
> which may help review much.

Yeah you're right, in fact I considered to make elevator interface changes into 
a separate patch however the changes are so much tightly coupled with block layer
change that I couldn't make it independent. As you may see here I replaced second
argument of ->init_sched from "struct elevator_type *" to "struct elevator_queue *".
And as you might have noticed we allocate the "struct elevator_queue *" very early
while switching the elevator and that's passed down to this ->init_sched function
through elv_change_ctx. So making elevator interface change a standalone patch 
is not possible.

>>  
>> +int blk_mq_alloc_elevator_and_sched_tags(struct request_queue *q,
>> +		struct elv_change_ctx *ctx)
>> +{
>> +	unsigned long i;
>> +	struct elevator_queue *elevator;
>> +	struct elevator_type *e;
>> +	struct blk_mq_tag_set *set = q->tag_set;
>> +	gfp_t gfp = GFP_NOIO | __GFP_NOWARN | __GFP_NORETRY;
>> +
>> +	if (strncmp(ctx->new.name, "none", 4)) {
> 
> You can return early if new name is "none", then all indent in the code
> block can be avoided.
Yeah agreed, will do it in the next patch.

> 
>> +
>> +		e = elevator_find_get(ctx->new.name);
>> +		if (!e)
>> +			return -EINVAL;
>> +
>> +		elevator = ctx->new.elevator = elevator_alloc(q, e);
> 
> You needn't to allocate elevator queue here, then the big elv_change_ctx change
> may be avoided by passing sched tags directly.

Hmm, okay so you recommend keeping allocation of elevator queue in ->init_sched
method as it's today? If so then yes it could be done but then as I see the elvator 
queue is being freed in elevator_change_done() after we release ->elevator_lock
So I thought it's also quite possible in theory to allocate elevator queue outside
of ->elevator_lock. Moreover, we shall not require holding ->elevator_lock or 
->freeze_lock while allocating elevator queue, and thus probably avoid holding
block layer locks while perfroming dynamic allocation, isn't it?

> 
> Also it may be fragile to allocate elevator queue here without holding elevator
> lock. You may have to document this way is safe by allocating elevator
> queue with specified elevator type lockless.
> 
Yes I'd document it. And looking through this code path it appears safe because
we first get reference to the elevator type before assiging elevator type to
the elevator queue in elevator_alloc(). Do you see any potential issue with 
this, if we were to allocate elevator queue lockless here?

>> diff --git a/block/blk-mq-sched.h b/block/blk-mq-sched.h
>> index 1326526bb733..6c0f1936b81c 100644
>> --- a/block/blk-mq-sched.h
>> +++ b/block/blk-mq-sched.h
>> @@ -7,6 +7,26 @@
>>  
>>  #define MAX_SCHED_RQ (16 * BLKDEV_DEFAULT_RQ)
>>  
>> +/* Holding context data for changing elevator */
>> +struct elv_change_ctx {
>> +	/* for unregistering/freeing old elevator */
>> +	struct {
>> +		struct elevator_queue *elevator;
>> +	} old;
>> +
>> +	/* for registering/allocating new elevator */
>> +	struct {
>> +		const char *name;
>> +		bool no_uevent;
>> +		unsigned long nr_requests;
>> +		struct elevator_queue *elevator;
>> +		int inited;
>> +	} new;
>> +
>> +	/* elevator switch status */
>> +	int status;
>> +};
>> +
> 
> As I mentioned, 'elv_change_ctx' becomes more complicated, which may be
> avoided.
Yes I agreed, however as I mentioned above if we choose to allocate 
elevator queue before we acquire ->elevator_lock or ->freeze_lock
then we may need to keep this updated elv_change_ctx. So it depends
on whether we choose to allocate elevator queue befor acquiring locks or
keeping allocation under ->init_sched.

> Queue is still frozen, so the dependency between freeze lock and
> the global percpu allocation lock isn't cut completely.
> 
Yes correct and so in the commit message I mentioned that this depedency is
currenlty cut only while calling elevator switch from elv_iosched_store context
through sysfs. We do need to still cut it in the conetxt of elevator switch 
being called from blk_mq_update_nr_hw_queues context or called while unregistering 
queue from del_gendisk. And this I thought should be handled in a seperate patch.
Anyways, I would explicitly call this out in the commit message.

Thanks,
--Nilay
