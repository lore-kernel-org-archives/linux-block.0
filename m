Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916457DA82
	for <linux-block@vger.kernel.org>; Wed, 11 Jun 2025 05:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749620494; cv=none; b=Klj9Qxkeuve4mJKaxaU/0acDbNYkd3owAN+D6VF0sX34/UyeNmy08LyMAPyk24SPItL8sMrXbn56DeMR44FxCLmdFPRuuWq0IHCPslWkaMtshn9aO8Q3ZdCSYfBEJBn/7v/yzPdovfBH3ApbThZe+GyeFt+HDlR9hq403WyMSTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749620494; c=relaxed/simple;
	bh=UCcQ6FdJudyHKOV/dxstSlg5Sp5lKAwic5vv80RMZMU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l+pccZlVIcdfvqNgkvv2ai72RpdwZ9Hh9DHngDAZ9DqiX2dRw8ULf31LzAxjDqAkW72P7R7M8bPLiWj8pdw+bXXRO+YTSev87Sn9MoorunEEqewFzDeIZZKmynRsOHZq+AGg5A+V7Qco8mNE65EfYJcedoQWL+5gZEMQ83Iz9gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FuVvENkJ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FuVvENkJ"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55B58mJp000881;
	Wed, 11 Jun 2025 05:41:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=AB7FqA
	tU4V4i0TGetWygo1JUh4iaGpF+x9crQPeppUs=; b=FuVvENkJFzVfMoa3ELnDMl
	2nAApyb2r/Q89jDxUQQ1qOuHqKtoYu9Bz+rTViXdN9mKa8EeUpkQkHsqxDZtHm3V
	9iQ353LFVGo0eEZ/rIAa3rOZrrbX/q5Bb+t32cpHyFkH/fGIAxaDLEsmKwMiBt+G
	7XDMYtVv6EwG7GT0IXc3qbbVQKaegcJoPD0oEionfjk5ChOZGTNhOC2DzaWMDzZJ
	RSE9T+xRoixG3m2EKO4jpDdQDAljOEH3KnnPGz6tV+JnjrLu+yqN0LfP9/jOJNMI
	TJcayI8/unvzVrpqowReByt6Z08rru33E4UYtAPoLdXm15HroZDbLEWtXOPWaZ5A
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 474bup2hhw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Jun 2025 05:41:27 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55B558Qg015369;
	Wed, 11 Jun 2025 05:41:26 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4750rp66uc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Jun 2025 05:41:26 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55B5fPaO23069184
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Jun 2025 05:41:25 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2386C58059;
	Wed, 11 Jun 2025 05:41:25 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9EF5F58058;
	Wed, 11 Jun 2025 05:41:22 +0000 (GMT)
Received: from [9.61.37.3] (unknown [9.61.37.3])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 11 Jun 2025 05:41:22 +0000 (GMT)
Message-ID: <c3ee3c27-6bd2-47ba-bead-5fc859d4b9f0@linux.ibm.com>
Date: Wed, 11 Jun 2025 11:11:20 +0530
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
 <9f5b0cbb-10cb-44a7-9565-28673bcbdf84@linux.ibm.com>
 <aEZDZJUVnYNPc9Sa@fedora>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <aEZDZJUVnYNPc9Sa@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=H4Hbw/Yi c=1 sm=1 tr=0 ts=68491707 cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=ly_TqxuQc45jG9IK0e4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjExMDA0NSBTYWx0ZWRfXz7Zd0D4GHSuO fr938Ne6nweeLjEMjiaJO81Mpb7/KJDya9ruUIeVjZKNPQ/wKpGXTVJbknqlV1oLGB9Hpmxxq3e 4xIq9lcM676Kwvuwn+ERw7EAE4eheSk631Dowl1NDbouF9njOqFfmvkgvYeeMnxAOlReOCWRuFM
 AwhkCG3OdoOqASZD893DPwuBHxK6rjyFJL9pmw5rgS5rLtIXUcII38fi1Z1MsrmTpD0tJifD0R4 WvMEaXE12bUaGlrDkaPnLqjvHIuxeOD3ZfOGEnv4U2GV7+7NXhnw5nq3jFvGVBOYtJkFQHg11lV AX+syIrUmJYVMT1KiKJjtDEt13VfrXWFOug7A+htqIfHHpWwHpUlnMPktQDK2GERu9Qdhw69cac
 OYCeEnBEg0vDq/XrpfbJ1X6z/ItZt+tFcs6nG5K4BuL9ikvkvJ5DCN4CeqhL2qSj/Gf8TSe6
X-Proofpoint-GUID: Mox2Dp_mQJiCtH1n0lSIv_2ztELMaWAy
X-Proofpoint-ORIG-GUID: Mox2Dp_mQJiCtH1n0lSIv_2ztELMaWAy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-11_02,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 phishscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 malwarescore=0 mlxscore=0
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506110045



On 6/9/25 7:43 AM, Ming Lei wrote:
> On Thu, Jun 05, 2025 at 11:22:17AM +0530, Nilay Shroff wrote:
>>
>>
>> On 6/3/25 2:07 PM, Ming Lei wrote:
>>> On Wed, May 28, 2025 at 06:03:58PM +0530, Nilay Shroff wrote:
>>
>>>> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
>>>> index 0cb1e9873aab..51d406da4abf 100644
>>>> --- a/block/bfq-iosched.c
>>>> +++ b/block/bfq-iosched.c
>>>> @@ -7232,17 +7232,12 @@ static void bfq_init_root_group(struct bfq_group *root_group,
>>>>  	root_group->sched_data.bfq_class_idle_last_service = jiffies;
>>>>  }
>>>>  
>>>> -static int bfq_init_queue(struct request_queue *q, struct elevator_type *e)
>>>> +static int bfq_init_queue(struct request_queue *q, struct elevator_queue *eq)
>>>>  {
>>>>  	struct bfq_data *bfqd;
>>>> -	struct elevator_queue *eq;
>>>>  	unsigned int i;
>>>>  	struct blk_independent_access_ranges *ia_ranges = q->disk->ia_ranges;
>>>>  
>>>> -	eq = elevator_alloc(q, e);
>>>> -	if (!eq)
>>>> -		return -ENOMEM;
>>>> -
>>>
>>> Please make the above elevator interface change be one standalone patch if possible,
>>> which may help review much.
>>
>> Yeah you're right, in fact I considered to make elevator interface changes into 
>> a separate patch however the changes are so much tightly coupled with block layer
>> change that I couldn't make it independent. As you may see here I replaced second
>> argument of ->init_sched from "struct elevator_type *" to "struct elevator_queue *".
>> And as you might have noticed we allocate the "struct elevator_queue *" very early
>> while switching the elevator and that's passed down to this ->init_sched function
>> through elv_change_ctx. So making elevator interface change a standalone patch 
>> is not possible.
> 
> You can make a patch to move elevator_queue allocation into
> blk_mq_init_sched() first, then pass it to all ->init_sched()
> implementation first. And you can avoid to pass 'elevator_queue *'
> from 'struct elv_change_ctx'.
> 
Hmm okay, so we'd allocate elevator_queue, while we're holding ->elevator_lock 
and ->freeze_lock, from within blk_mq_init_sched(). As you mentioned it's safe
because elevator_queue dynamic allocation uses a plain kmalloc, I'd change this
in the next patch.

>>
>>>>  
>>>> +int blk_mq_alloc_elevator_and_sched_tags(struct request_queue *q,
>>>> +		struct elv_change_ctx *ctx)
>>>> +{
>>>> +	unsigned long i;
>>>> +	struct elevator_queue *elevator;
>>>> +	struct elevator_type *e;
>>>> +	struct blk_mq_tag_set *set = q->tag_set;
>>>> +	gfp_t gfp = GFP_NOIO | __GFP_NOWARN | __GFP_NORETRY;
>>>> +
>>>> +	if (strncmp(ctx->new.name, "none", 4)) {
>>>
>>> You can return early if new name is "none", then all indent in the code
>>> block can be avoided.
>> Yeah agreed, will do it in the next patch.
>>
>>>
>>>> +
>>>> +		e = elevator_find_get(ctx->new.name);
>>>> +		if (!e)
>>>> +			return -EINVAL;
>>>> +
>>>> +		elevator = ctx->new.elevator = elevator_alloc(q, e);
>>>
>>> You needn't to allocate elevator queue here, then the big elv_change_ctx change
>>> may be avoided by passing sched tags directly.
>>
>> Hmm, okay so you recommend keeping allocation of elevator queue in ->init_sched
>> method as it's today?
> 
> I meant you can move elevator queue allocation into blk_mq_init_sched(), then
> you just need to pass allocated sched tag via `elv_change_ctx` or function
> parameter.

Yeah got it! Will do it in the next patch.

> 
>> If so then yes it could be done but then as I see the elvator 
>> queue is being freed in elevator_change_done() after we release ->elevator_lock
>> So I thought it's also quite possible in theory to allocate elevator queue outside
>> of ->elevator_lock. Moreover, we shall not require holding ->elevator_lock or 
>> ->freeze_lock while allocating elevator queue, and thus probably avoid holding
>> block layer locks while perfroming dynamic allocation, isn't it?
>>
>>>
>>> Also it may be fragile to allocate elevator queue here without holding elevator
>>> lock. You may have to document this way is safe by allocating elevator
>>> queue with specified elevator type lockless.
>>>
>> Yes I'd document it. And looking through this code path it appears safe because
>> we first get reference to the elevator type before assiging elevator type to
>> the elevator queue in elevator_alloc(). Do you see any potential issue with 
>> this, if we were to allocate elevator queue lockless here?
> 
> The correctness depends that our current implementation disables 
> updating nr_hw_queues by holding set->update_nr_hwq_lock, otherwise you
> have to double check nr_hw_queues after grabbing elevator_lock, so this
> point might need to document.
> 
Yep! In fact you might have seen I commented about it in elv_update_nr_hw_queues() 
just before we call blk_mq_alloc_elevator_and_sched_tags(). But now anyways, as
discussed above, we're moving elevator_queue allocation under blk_mq_init_sched(),
we may not need to document this.

>>
>>>> diff --git a/block/blk-mq-sched.h b/block/blk-mq-sched.h
>>>> index 1326526bb733..6c0f1936b81c 100644
>>>> --- a/block/blk-mq-sched.h
>>>> +++ b/block/blk-mq-sched.h
>>>> @@ -7,6 +7,26 @@
>>>>  
>>>>  #define MAX_SCHED_RQ (16 * BLKDEV_DEFAULT_RQ)
>>>>  
>>>> +/* Holding context data for changing elevator */
>>>> +struct elv_change_ctx {
>>>> +	/* for unregistering/freeing old elevator */
>>>> +	struct {
>>>> +		struct elevator_queue *elevator;
>>>> +	} old;
>>>> +
>>>> +	/* for registering/allocating new elevator */
>>>> +	struct {
>>>> +		const char *name;
>>>> +		bool no_uevent;
>>>> +		unsigned long nr_requests;
>>>> +		struct elevator_queue *elevator;
>>>> +		int inited;
>>>> +	} new;
>>>> +
>>>> +	/* elevator switch status */
>>>> +	int status;
>>>> +};
>>>> +
>>>
>>> As I mentioned, 'elv_change_ctx' becomes more complicated, which may be
>>> avoided.
>> Yes I agreed, however as I mentioned above if we choose to allocate 
>> elevator queue before we acquire ->elevator_lock or ->freeze_lock
> 
> Allocating elevator queue is just plain kmalloc(), which can be done
> under ->elevator_lock or ->freeze_lock, since we have called
> memalloc_noio_save().
> 
Yes agreed!

>> then we may need to keep this updated elv_change_ctx. So it depends
>> on whether we choose to allocate elevator queue befor acquiring locks or
>> keeping allocation under ->init_sched.
>>
>>> Queue is still frozen, so the dependency between freeze lock and
>>> the global percpu allocation lock isn't cut completely.
>>>
>> Yes correct and so in the commit message I mentioned that this depedency is
>> currenlty cut only while calling elevator switch from elv_iosched_store context
>> through sysfs. We do need to still cut it in the conetxt of elevator switch 
>> being called from blk_mq_update_nr_hw_queues context or called while unregistering 
>> queue from del_gendisk. And this I thought should be handled in a seperate patch.
>> Anyways, I would explicitly call this out in the commit message.
> 
> OK, looks fine, I'd suggest to address them all in single patchset, because
> it is same problem, and helps us to review with single context.
> 
Alright, I'd make a patchset and handle all cases.

Thanks,
--Nilay
