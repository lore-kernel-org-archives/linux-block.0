Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860FE21578F
	for <linux-block@vger.kernel.org>; Wed, 18 Jun 2025 06:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750229585; cv=none; b=nRFv5qP0J0jKvQ1vQIcbs7yPcXcSTInVG6IkqAkPqTBVeRDlcKP1f0/oZ6R5n/YjkhX76QoaKaEBS1FKt9ct4K3+Bymm6T90gSvDUMoJ0O22L0y4AvtCiICUFEXWoXp6ih0LJQkz9E/+PVSVtmPANp2C6wqUIvKurzkRmYigAxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750229585; c=relaxed/simple;
	bh=DOcwZEafvgAuNd6TFzD+3qb27pMPrpxNx9N0oZReOE8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bszoo6jHKNSECIesdUk6V3gzliD+lZb77A7bf8OzAPNZP7YgqlW85csI92zOU0Aja6GhsN9CKO3bYtsu1NlSp9qzNKLcyDzWmmGpA/jsxVEwciSDGMYMTIVWM6zCwMHHlclMqQ8a3l2C/jtZoYwqkNu8qpo3ACaGZ8ROFn8aBB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=V12eBzq2; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="V12eBzq2"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55I3Kc7Z017100;
	Wed, 18 Jun 2025 06:52:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Wa3R9P
	qLDfzCrYRB4n0xQG9X/FN4e8OpxOoFwf9pVNc=; b=V12eBzq2+7kxwBMpz6YTfr
	7WKqBXpMoxn4zFm0UO/yJN2qVhhJsyE+HnDyDi18uNNQXg116bcU7VJQO81IDRYr
	x1Q2/tW3DK/KHC9ggV0hb+5uOeojrfChDVPV1IC6d9ABCcyZSXMM3OspBrd2X0ja
	DP2qQGSYOTNXPPyGB4gxRLKk8wmlaI36idOsPtSQ5RWyFWF3y3e5fzcSbrFPH4//
	8a7ngGE4V0Sr1IEWvp317VTGz1BVe+ZvJQOE0yp1pBawmVa+vmFNiUNEI1JSY2SO
	cOZ0vn8efPmie11PzaBx2DKPVmBBU9Mp3Sr8LWxW3GzJgXOGHpHIV4eUnuB2O2Tg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 478ygncuq3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Jun 2025 06:52:57 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55I5OLls014247;
	Wed, 18 Jun 2025 06:52:56 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 479p42fa61-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Jun 2025 06:52:56 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55I6qnbc29622884
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Jun 2025 06:52:50 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9F5A658062;
	Wed, 18 Jun 2025 06:52:54 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8D1965805A;
	Wed, 18 Jun 2025 06:52:52 +0000 (GMT)
Received: from [9.61.55.75] (unknown [9.61.55.75])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 18 Jun 2025 06:52:52 +0000 (GMT)
Message-ID: <085835ca-a2fb-4e10-82c2-3a7778431345@linux.ibm.com>
Date: Wed, 18 Jun 2025 12:22:50 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 2/2] block: fix lock dependency between percpu alloc
 lock and elevator lock
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, hch@lst.de, axboe@kernel.dk,
        sth@linux.ibm.com, gjoyce@ibm.com
References: <20250616173233.3803824-1-nilay@linux.ibm.com>
 <20250616173233.3803824-3-nilay@linux.ibm.com> <aFItNzzr-4iQbjyY@fedora>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <aFItNzzr-4iQbjyY@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE4MDA1NyBTYWx0ZWRfX+iPhIDvpYbDd B0bM8XLql/pKwi0SG2EQLBn543iOVKOiWeLoftQ/szuOJUkC+wpPoV61gtgIb3U7GkzaMxg/lO+ Uympwy/COysNRIHdrcqHsurEs9KyG04qgTczZInkI8yJdiVjVS9I12toxqS38zOebWoxDixy4ag
 ssqndD+QWrEfF8pW3SgZrt0t3+1Yzh+43phPsquVP9eNcWXMuKHPdhkXYnDo/JId/6JwFK85ahS Iroh8RYBNcj3qTc+aVNhNE8pLwVUeoUqI4Cq9jwptMhQemSRVgoJwZwVlgZdyCP8qQWVpY+NuMA v9gjcgXWZzJFkyrdWLNMVRPxYUucAwiMSNhGxJZXTu+DFPsEkgwfUhr7Ncgm+aYj/cjt01KopwT
 n6XnuYLkloJOTALq2ztu/9v+TqiqizfUXHWjijG3Fqe0LXd+dVVbqATrtezoifOSiXJCF0Gd
X-Authority-Analysis: v=2.4 cv=fYSty1QF c=1 sm=1 tr=0 ts=68526249 cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=kIOJ_G1Yg4J84UdusMsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Y7Y9GPC1cf2SwTWnhImz88ufu99bwdDf
X-Proofpoint-GUID: Y7Y9GPC1cf2SwTWnhImz88ufu99bwdDf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-18_02,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 spamscore=0 mlxlogscore=999 lowpriorityscore=0 adultscore=0 mlxscore=0
 impostorscore=0 bulkscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506180057



On 6/18/25 8:36 AM, Ming Lei wrote:

>> +int blk_mq_alloc_sched_tags(struct blk_mq_tag_set *set,
>> +			    unsigned int nr_hw_queues,
>> +			    struct elevator_tags ***elv_tags)
> 
> We seldom see triple indirect pointers in linux kernel, :-) 

Yeah lets see if we could avoid it by using xarray as you suggested.
> 
>> +{
>> +	unsigned long idx = 0, count = 0;
>> +	struct request_queue *q;
>> +	struct elevator_tags **tags;
>> +	gfp_t gfp = GFP_NOIO | __GFP_NOWARN | __GFP_NORETRY;
>> +
>> +	lockdep_assert_held_write(&set->update_nr_hwq_lock);
>> +	/*
>> +	 * Accessing q->elevator without holding q->elevator_lock is safe
>> +	 * because we're holding here set->update_nr_hwq_lock in the writer
>> +	 * context. So, scheduler update/switch code (which acquires the same
>> +	 * lock but in the reader context) can't run concurrently.
>> +	 */
>> +	list_for_each_entry(q, &set->tag_list, tag_set_list) {
>> +		if (q->elevator)
>> +			count++;
>> +	}
>> +
>> +	if (!count)
>> +		return 0;
>> +
>> +	tags = kcalloc(count, sizeof(struct elevator_tags *), gfp);
>> +	if (!tags)
>> +		return -ENOMEM;
>> +
>> +	list_for_each_entry(q, &set->tag_list, tag_set_list) {
>> +		if (q->elevator) {
>> +			tags[idx] = __blk_mq_alloc_sched_tags(set, nr_hw_queues,
>> +					q->id);
>> +			if (!tags[idx])
>> +				goto out;
>> +
>> +			idx++;
>> +		}
>> +	}
>> +
>> +	*elv_tags = tags;
>> +	return count;
>> +out:
>> +	blk_mq_free_sched_tags(set, tags);
>> +	return -ENOMEM;
>> +}
> 
> I believe lots of code can be saved if you take xarray to store the
> allocated 'struct elevator_tags', and use q->id as the key.
> 
I think using xarray is a nice idea! I will rewrite this code 
using xarray in the next revision.

> Also the handling for updating_nr_hw_queues has new batch alloc & free logic
> and should be done in standalone patch. Per my experience, bug is easier to
> hide in the big patch, which is more hard to review.
> 
Sure, I'd further split the patch in the next revision.

>> @@ -676,11 +690,16 @@ static int elevator_change(struct request_queue *q, struct elv_change_ctx *ctx)
>>  	blk_mq_cancel_work_sync(q);
>>  	mutex_lock(&q->elevator_lock);
>>  	if (!(q->elevator && elevator_match(q->elevator->type, ctx->name)))
>> -		ret = elevator_switch(q, ctx);
>> +		ret = elevator_switch(q, ctx, tags);
> 
> tags may be passed via 'ctx'.
Hmm ok we can do that. I will add @tags in @ctx.

> 
>>  	mutex_unlock(&q->elevator_lock);
>>  	blk_mq_unfreeze_queue(q, memflags);
>>  	if (!ret)
>>  		ret = elevator_change_done(q, ctx);
>> +	/*
>> +	 * Free sched tags if it's allocated but we couldn't switch elevator.
>> +	 */
>> +	if (tags && !ctx->new)
>> +		__blk_mq_free_sched_tags(set, tags);
> 
> Maybe you can let elevator_change_done() cover failure handling, and
> move the above two line into elevator_change_done().
Yes precisely I thought about it, but then later realized that 
elevator_change_done() may not be called always. For instance, in 
case elevator_switch() fails and hence returns non-zero value 
then in that case elevator_change_done() would be skipped. But 
still in the elvator_switch() failure case, we'd have allocated 
sched_tags and so we have to free it.

> 
>> diff --git a/block/elevator.h b/block/elevator.h
>> index a4de5f9ad790..0b92121005cf 100644
>> --- a/block/elevator.h
>> +++ b/block/elevator.h
>> @@ -23,6 +23,17 @@ enum elv_merge {
>>  struct blk_mq_alloc_data;
>>  struct blk_mq_hw_ctx;
>>  
>> +/* Holding context data for changing elevator */
>> +struct elv_change_ctx {
>> +	const char *name;
>> +	bool no_uevent;
>> +
>> +	/* for unregistering old elevator */
>> +	struct elevator_queue *old;
>> +	/* for registering new elevator */
>> +	struct elevator_queue *new;
>> +};
>> +
> 
> 'elv_change_ctx' is only used in block/elevator.c, not sure why you
> move it to the header.
Oh yes, in the previous version of this patch it was used outside of
the elevator.c and so I moved it into  a common header but later in
this patch I missed to move it back into the elevator.h file as now
the only user of 'elv_change_ctx' exists in elevator.c file. I will
fix this in the next revision.

>>  struct elevator_mq_ops {
>>  	int (*init_sched)(struct request_queue *, struct elevator_queue *);
>>  	void (*exit_sched)(struct elevator_queue *);
>> @@ -107,12 +118,27 @@ void elv_rqhash_add(struct request_queue *q, struct request *rq);
>>  void elv_rqhash_reposition(struct request_queue *q, struct request *rq);
>>  struct request *elv_rqhash_find(struct request_queue *q, sector_t offset);
>>  
>> +struct elevator_tags {
>> +	/* num. of hardware queues for which tags are allocated */
>> +	unsigned int nr_hw_queues;
>> +	/* depth used while allocating tags */
>> +	unsigned int nr_requests;
>> +	/* request queue id (q->id) used during elevator_tags_lookup() */
>> +	int id;
>> +	union {
>> +		/* tags shared across all queues */
>> +		struct blk_mq_tags *shared_tags;
>> +		/* array of blk_mq_tags pointers, one per hardware queue. */
>> +		struct blk_mq_tags **tags;
>> +	} u;
>> +};
> 
> I feel it is simpler to just save shared tags in the 1st item
> of the array, then you can store 'struct blk_mq_tags' in flex array of
> 'struct elevator_tags', save one extra allocation & many failure handling
> code.
> 
Yes sounds good! I will send out another patchset with above 
suggested changes.

Thanks,
--Nilay

