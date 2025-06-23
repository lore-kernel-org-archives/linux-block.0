Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD42235076
	for <linux-block@vger.kernel.org>; Mon, 23 Jun 2025 09:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750671223; cv=none; b=P+pVPcYQEGtxfk+KmdAsv/TfNwdLejivPTAp12I+vpdlmSf/MaY5DWthAJQxla9VWGkiPnIqW33GYa6Vd+PFkqi6j4K6pB3TksnaauglrC3+eS+PopKoqfWpEtv8iUjyERTxp4Ksl4Rrn6gdso/Fkmzndzxa9TdxV916ftCq3RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750671223; c=relaxed/simple;
	bh=EzvG5re6Z3a2vYyRx9W5DWzRPoyTz7ize7tLiqtZD7k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UsfJp5zLRLiBcecTAV/S0OvbkFiNGznjY+h1MkAfr4aFrk/mh1SHBkt1+1SgReFwNDtHmFgg7v+sRosiLBAkd/O6K5xx3m0fesqr+RgsW6ucHY4Pu7ioXzsIetUlAwrgqCOJ7iZqsL5K4MaFwM6K9qx/46Ph5rTqYywJaiw1wj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kJVgkAOR; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kJVgkAOR"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55MMH9p6031109;
	Mon, 23 Jun 2025 09:33:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=y49+Wv
	72Hh+WEHccLg7usaycf/fGHobZqyyF8MqgINo=; b=kJVgkAORji7dkPnZeFpw2O
	Hn5D0hyZM8xsTLZPho6nc7v2YOQUtyOYvx195DMM0B+eR1TxQEbaKFor2D7iEGcM
	sXpm+R9gfIE0JlcFOdmoV9IQcg94eMVK/qTCcRVBvLB6Tz+Ug7fpkKpvKggbCrjO
	0yRH+b3XEzXADjZhFM7oWdNlmZecXYB1c2hi9hs8kCVfhi6tap6PYngkAZ+RjbxU
	KBQEfdyIKJaDF3QwqFwcTn8rJOom5FHB67Y+KrfeGHpYRap8FI0QlxwVN2ZRN5Ks
	lKJbSKLMn7oj2bCztZ5ZEbPi/aRTd29jG9rR49r7YnnnmFiR+XTjOUA+K579cO9g
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dm8j0kqm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Jun 2025 09:33:34 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55N60g6t014769;
	Mon, 23 Jun 2025 09:33:33 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 47e9s257a7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Jun 2025 09:33:33 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55N9XVvM12518126
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Jun 2025 09:33:32 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D5DE75806B;
	Mon, 23 Jun 2025 09:33:31 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 612D258043;
	Mon, 23 Jun 2025 09:33:29 +0000 (GMT)
Received: from [9.61.134.245] (unknown [9.61.134.245])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 23 Jun 2025 09:33:28 +0000 (GMT)
Message-ID: <f306f309-7cc2-4426-98bf-fb6684db5b7c@linux.ibm.com>
Date: Mon, 23 Jun 2025 15:03:27 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 2/2] block: fix lock dependency between percpu alloc
 lock and elevator lock
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, ming.lei@redhat.com, axboe@kernel.dk,
        sth@linux.ibm.com, gjoyce@ibm.com
References: <20250616173233.3803824-1-nilay@linux.ibm.com>
 <20250616173233.3803824-3-nilay@linux.ibm.com>
 <20250623061015.GA30266@lst.de>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250623061015.GA30266@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIzMDA1NCBTYWx0ZWRfX8DfFaE9ENNmC 86jgMbANR5IW6X0mYeBHTWAZmH83BVl7+GUtyh94wZhWbh88BzzrluApJWBzF5g557auxDlqz6Z sf+AWayjbFtGvgNXpAp9UgEemUe2vfvafZ+Tunc8uljXr2MCggOVbl+rhubUMunR4aGD7Y1P61z
 DWGs2Waynj8oVPp+dITd329xhSjlsq3LjJVCRr6k3T69G/UEez3VoTbcdCFnvCfVbSnFRBT5MlW TPx6a/JWEFA3tLRIZSJHEJWFsx5buUpL85HfKOexYmvGp+RpJG+x/LCODQ4EIyI7ogRwpBkYITM z3R/PxDIvSC68eqtBSkP6TMmUOViUTccBuLbgKMrZ4btJOJq45wEopit7R69QQNsQHi+0JBhomx
 alSd7IuaFV2ypmjGikFmDPbHLnYWqD4zq57oE2H/AXUd/zmaYCBvBWWu8Rd4SWSRzUviOCxv
X-Proofpoint-GUID: ixfNCAwiatdD12xKfwJr_tFYyTqfSUy2
X-Proofpoint-ORIG-GUID: ixfNCAwiatdD12xKfwJr_tFYyTqfSUy2
X-Authority-Analysis: v=2.4 cv=combk04i c=1 sm=1 tr=0 ts=68591f6e cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=BF9mZTA8yvTQn_YLrEUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-23_03,2025-06-23_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 spamscore=0 adultscore=0 mlxlogscore=999 clxscore=1015
 impostorscore=0 suspectscore=0 mlxscore=0 phishscore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506230054



On 6/23/25 11:40 AM, Christoph Hellwig wrote:
> On Mon, Jun 16, 2025 at 11:02:26PM +0530, Nilay Shroff wrote:
>> +static void blk_mq_init_sched_tags(struct request_queue *q,
>> +				   struct blk_mq_hw_ctx *hctx,
>> +				   unsigned int hctx_idx,
>> +				   struct elevator_queue *eq)
>>  {
>>  	if (blk_mq_is_shared_tags(q->tag_set->flags)) {
>>  		hctx->sched_tags = q->sched_shared_tags;
>> +		return;
>>  	}
>>  
>> +	hctx->sched_tags = eq->tags->u.tags[hctx_idx];
>>  }
> 
> Given how trivial this function now is, please inline it in the only
> caller.  That should also allow moving the blk_mq_is_shared_tags
> shared out of the loop over all hw contexts, and merge it with the
> check right next to it.
> 
okay, will do it the next patchset.

>> +static void blk_mq_init_sched_shared_tags(struct request_queue *queue,
>> +		struct elevator_queue *eq)
>>  {
>> +	queue->sched_shared_tags = eq->tags->u.shared_tags;
>>  	blk_mq_tag_update_sched_shared_tags(queue);
>>  }
> 
> This helper can also just be open coded in the caller now.
Yes agreed...

> 
>> +	if (blk_mq_is_shared_tags(set->flags)) {
>> +		if (tags->u.shared_tags) {
>> +			blk_mq_free_rqs(set, tags->u.shared_tags,
>> +					BLK_MQ_NO_HCTX_IDX);
>> +			blk_mq_free_rq_map(tags->u.shared_tags);
>> +		}
>> +		goto out;
>> +	}
>> +
>> +	if (!tags->u.tags)
>> +		goto out;
>> +
>> +	for (i = 0; i < tags->nr_hw_queues; i++) {
>> +		if (tags->u.tags[i]) {
>> +			blk_mq_free_rqs(set, tags->u.tags[i], i);
>> +			blk_mq_free_rq_map(tags->u.tags[i]);
>> +		}
>> +	}
> 
> Maybe restructucture this a bit:
> 
> 	if (blk_mq_is_shared_tags(set->flags)) {
> 		..
> 	} else if (tags->u.tags) {
> 	}
> 
> 	kfree(tags);
> 
> to have a simpler flow and remove the need for the "goto out"?
> 
Okay but as you know I am rewriting this logic using Xarray as
Ming pointed in last email. So this code will be restructured and
I will ensure that your above comment will be addressed in new 
logic.

>> +	tags = kcalloc(1, sizeof(struct elevator_tags), gfp);
> 
> This can use plain kzalloc.
> 
>> +	if (blk_mq_is_shared_tags(set->flags)) {
>> +
>> +		tags->u.shared_tags = blk_mq_alloc_map_and_rqs(set,
> 
> The empty line above is a bit odd.
Yes I would address this in next patchset.

> 
>> +					BLK_MQ_NO_HCTX_IDX,
>> +					MAX_SCHED_RQ);
>> +		if (!tags->u.shared_tags)
>> +			goto out;
>> +
>> +		return tags;
>> +	}
>> +
>> +	tags->u.tags = kcalloc(nr_hw_queues, sizeof(struct blk_mq_tags *), gfp);
>> +	if (!tags->u.tags)
>> +		goto out;
>> +
>> +	tags->nr_hw_queues = nr_hw_queues;
>> +	for (i = 0; i < nr_hw_queues; i++) {
>> +		tags->u.tags[i] = blk_mq_alloc_map_and_rqs(set, i,
>> +				tags->nr_requests);
>> +		if (!tags->u.tags[i])
>> +			goto out;
>> +	}
>> +
>> +	return tags;
>> +
>> +out:
>> +	__blk_mq_free_sched_tags(set, tags);
> 
> Is __blk_mq_free_sched_tags really the right thing here vs just unwinding
> what this function did?
> 
Hmm, __blk_mq_free_sched_tags actually releases everything which is allocated
in this function (so there won't be any leak), however, it really _dose_not_ 
free resources in the reverse order. It just loops over starting from the first 
nr_hw_queue index and releases whatsoever allocated. But I think you're right, 
we could probably have more structured way of unwinding stuff here instead 
of calling __blk_mq_free_sched_tags. I will handle this in the next patch.

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
> 
> Maybe add a helper for this code and the comment?
Yeah but as I mentioned above with Xarray code being added, we may 
not need the above loop. So lets see, if needed I will add a macro
and add proper comment in next patch.

> 
>> -	lockdep_assert_held(&q->tag_set->update_nr_hwq_lock);
>> +	lockdep_assert_held(&set->update_nr_hwq_lock);
>> +
>> +	if (strncmp(ctx->name, "none", 4)) {
> 
> This is a check for not having an elevator so far, right?  Wouldn't
> !q->elevator be the more obvious check for that?  Or am I missing
> something why that's not safe here?
> 
This code runs in the context of an elevator switch, not as part of an
nr_hw_queues update. Hence, at this point, q->elevator has not yet been
updated to the new elevator we’re switching to, so accessing q->elevator
here would be incorrect. Since we've already stored the name of the target
elevator in ctx->name, we use that instead of referencing q->elevator here.

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
> 
> No need to move this, it is still only used in elevator.c.
> 
Yes agreed. I'm moved it back to its original place in 
elevator.c

>>  extern struct elevator_queue *elevator_alloc(struct request_queue *,
>> -					struct elevator_type *);
>> +		struct elevator_type *, struct elevator_tags *);
> 
> Drop the extern while you're at it.
> 
Yeah sure.

Thanks,
--Nilay

