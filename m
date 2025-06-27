Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA21219E8
	for <linux-block@vger.kernel.org>; Fri, 27 Jun 2025 04:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750997625; cv=none; b=awObMyAX2O2jounDn0piU3pis0fmcpF3h88cN0kYRTB58aYyc4OwkW6nSFkt2zPD02Nt+ml6xsDCOGE+04NnOt7SiIT4OzGfiGxLVS2a9Zs0I7lsSsytgdJJd9c0KH1ULreGmBW2fKDfsw/ctJHk36wKzxf2sflj3hpHHc8nxi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750997625; c=relaxed/simple;
	bh=0rAsDuo5XFhNalc+5nzRas+QgaehhF6LtETWpG/rZH4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DX9+u0RNMpO4drw/axEQd1Q2T0GAQOXn3cEdUTN0e0mGA7NrlP85f0Gvaa9aCpLUePgsChdya2t8XTIT90kAhZ7qGEQp/ACyk0BDwgemnS6S0SfxvAE7ZA0IVDCKZIYW0NLOupFYtIajIMn2Rid6rMYtsHLRVgCWSKLxF6WC2qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WHNtgFLt; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WHNtgFLt"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55QNndK6015765;
	Fri, 27 Jun 2025 04:13:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=QJ8FWz
	R8Iyi9ZLad+86cyMX4l/BRNRUfRkBPhUWD6OU=; b=WHNtgFLtE+tUvT8ZQ3njPS
	Agv8IC7UqQgXQkPo9mouAuSTBUW+djioC7oqOnJOze45yDoA5V/tMVdp3qxkCSRZ
	fOQbBPeEfhmhCJqPbZAkuD3gJgzO9qbgx/vvwemG8b4H3k6ijfpliIjkpbSdcnzf
	6AdtIBxvd5fsPk8LAz5/PSEqhbS4CsB5VTO9Cg881ZNj7kABNY5lD0i7AgQ5oFva
	Ivfmx2tjVcIwhaCN+sWgdMNons/hIJmpPyFQMtTNDNK7O/SZ3F7UEac5/iONvlXv
	WnwNz292LSKXbGp+0lvRW+444Zv466vnkoLe+9xDx1TBkt0LenIiUu2rK+M3uV3g
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dm8ju1ag-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Jun 2025 04:13:36 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55R2VYuK014710;
	Fri, 27 Jun 2025 04:13:35 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 47e9s2t19f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Jun 2025 04:13:35 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55R4DXtQ26149514
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Jun 2025 04:13:33 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 44A5058065;
	Fri, 27 Jun 2025 04:13:33 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2DFDD58056;
	Fri, 27 Jun 2025 04:13:31 +0000 (GMT)
Received: from [9.61.89.181] (unknown [9.61.89.181])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 27 Jun 2025 04:13:30 +0000 (GMT)
Message-ID: <e0e4ffc2-413b-448f-8e62-5f745123e4fc@linux.ibm.com>
Date: Fri, 27 Jun 2025 09:43:29 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv4 2/3] block: fix lockdep warning caused by lock
 dependency in elv_iosched_store
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, hch@lst.de, axboe@kernel.dk,
        sth@linux.ibm.com, gjoyce@ibm.com
References: <20250624131716.630465-1-nilay@linux.ibm.com>
 <20250624131716.630465-3-nilay@linux.ibm.com> <aF1cdHXunW5aqaci@fedora>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <aF1cdHXunW5aqaci@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI3MDAyNyBTYWx0ZWRfXwRhzm/3xWX9p PoCX/fGIqQtmrw53hbLnldIulrnQYuWPdcg62478RLIY6ZS+0g5zorT+iNou17QimPyNpFw8qPG 9T54gnxseXFvVqbegr+5ADZXuH28XgE2g4ajX1E+A3s80jnBoM7O2vf/LUeBfBRaHE3fhjVn2fO
 5+scEkpKn13eI1gqmH36uKwXMSiaypm03WJd0Tr/ZxW+fVhn16dN45GZ/1Rr8pqSIfecL7Z87V8 BBfxJPUAE0exsc/788XciEVK+/uz0WP6bDqe0de5JQdJIx/W6gs8uWimAknLBZPnFSSWay3dOhc 7UG/9c9sp1vdC7gBtobpHnnHU4sATYL3DeP0rjMtfpok/aKXdRdXoVz9F0+YkhlmYKnC58WBdbA
 9zVBdU59rpMIRru/wDwCXItt2CEPmFf2juAuXBr3ILnnXS+NL/PDany0YIKEXIbfduvzanZ/
X-Proofpoint-GUID: n3vGRJvH6npJi__UESDISjipjFTe-nK4
X-Proofpoint-ORIG-GUID: n3vGRJvH6npJi__UESDISjipjFTe-nK4
X-Authority-Analysis: v=2.4 cv=combk04i c=1 sm=1 tr=0 ts=685e1a70 cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=oo1DeRlCbFGOAZmLC_sA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-27_01,2025-06-26_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 spamscore=0 adultscore=0 mlxlogscore=999 clxscore=1015
 impostorscore=0 suspectscore=0 mlxscore=0 phishscore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506270027



On 6/26/25 8:13 PM, Ming Lei wrote:
> On Tue, Jun 24, 2025 at 06:47:04PM +0530, Nilay Shroff wrote:
>> Recent lockdep reports [1] have revealed a potential deadlock caused by a
>> lock dependency between the percpu allocator lock and the elevator lock.
>> This issue can be avoided by ensuring that the allocation and release of
>> scheduler tags (sched_tags) are performed outside the elevator lock.
>> Furthermore, the queue does not need to be remain frozen during these
>> operations.
>>
>> To address this, move all sched_tags allocations and deallocations outside
>> of both the ->elevator_lock and the ->freeze_lock. Since the lifetime of
>> the elevator queue and its associated sched_tags is closely tied, the
>> allocated sched_tags are now stored in the elevator queue structure. Then,
>> during the actual elevator switch (which runs under ->freeze_lock and
>> ->elevator_lock), the pre-allocated sched_tags are assigned to the
>> appropriate q->hctx. Once the elevator switch is complete and the locks
>> are released, the old elevator queue and its associated sched_tags are
>> freed.
>>
>> This commit specifically addresses the allocation/deallocation of sched_
>> tags during elevator switching. Note that sched_tags may also be allocated
>> in other contexts, such as during nr_hw_queues updates. Supporting that
>> use case will require batch allocation/deallocation, which will be handled
>> in a follow-up patch.
>>
>> This restructuring ensures that sched_tags memory management occurs
>> entirely outside of the ->elevator_lock and ->freeze_lock context,
>> eliminating the lock dependency problem seen during scheduler updates.
>>
>> [1] https://lore.kernel.org/all/0659ea8d-a463-47c8-9180-43c719e106eb@linux.ibm.com/
>>
>> Reported-by: Stefan Haberland <sth@linux.ibm.com>
>> Closes: https://lore.kernel.org/all/0659ea8d-a463-47c8-9180-43c719e106eb@linux.ibm.com/
>> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
>> ---
>>  block/blk-mq-sched.c | 186 ++++++++++++++++++++++++++-----------------
>>  block/blk-mq-sched.h |  14 +++-
>>  block/elevator.c     |  66 +++++++++++++--
>>  block/elevator.h     |  19 ++++-
>>  4 files changed, 204 insertions(+), 81 deletions(-)
>>
>> diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
>> index 359e0704e09b..5d3132ac7777 100644
>> --- a/block/blk-mq-sched.c
>> +++ b/block/blk-mq-sched.c
>> @@ -374,64 +374,17 @@ bool blk_mq_sched_try_insert_merge(struct request_queue *q, struct request *rq,
>>  }
>>  EXPORT_SYMBOL_GPL(blk_mq_sched_try_insert_merge);
>>  
>> -static int blk_mq_sched_alloc_map_and_rqs(struct request_queue *q,
>> -					  struct blk_mq_hw_ctx *hctx,
>> -					  unsigned int hctx_idx)
>> -{
>> -	if (blk_mq_is_shared_tags(q->tag_set->flags)) {
>> -		hctx->sched_tags = q->sched_shared_tags;
>> -		return 0;
>> -	}
>> -
>> -	hctx->sched_tags = blk_mq_alloc_map_and_rqs(q->tag_set, hctx_idx,
>> -						    q->nr_requests);
>> -
>> -	if (!hctx->sched_tags)
>> -		return -ENOMEM;
>> -	return 0;
>> -}
>> -
>> -static void blk_mq_exit_sched_shared_tags(struct request_queue *queue)
>> -{
>> -	blk_mq_free_rq_map(queue->sched_shared_tags);
>> -	queue->sched_shared_tags = NULL;
>> -}
>> -
>>  /* called in queue's release handler, tagset has gone away */
>>  static void blk_mq_sched_tags_teardown(struct request_queue *q, unsigned int flags)
>>  {
>>  	struct blk_mq_hw_ctx *hctx;
>>  	unsigned long i;
>>  
>> -	queue_for_each_hw_ctx(q, hctx, i) {
>> -		if (hctx->sched_tags) {
>> -			if (!blk_mq_is_shared_tags(flags))
>> -				blk_mq_free_rq_map(hctx->sched_tags);
>> -			hctx->sched_tags = NULL;
>> -		}
>> -	}
>> +	queue_for_each_hw_ctx(q, hctx, i)
>> +		hctx->sched_tags = NULL;
>>  
>>  	if (blk_mq_is_shared_tags(flags))
>> -		blk_mq_exit_sched_shared_tags(q);
>> -}
>> -
>> -static int blk_mq_init_sched_shared_tags(struct request_queue *queue)
>> -{
>> -	struct blk_mq_tag_set *set = queue->tag_set;
>> -
>> -	/*
>> -	 * Set initial depth at max so that we don't need to reallocate for
>> -	 * updating nr_requests.
>> -	 */
>> -	queue->sched_shared_tags = blk_mq_alloc_map_and_rqs(set,
>> -						BLK_MQ_NO_HCTX_IDX,
>> -						MAX_SCHED_RQ);
>> -	if (!queue->sched_shared_tags)
>> -		return -ENOMEM;
>> -
>> -	blk_mq_tag_update_sched_shared_tags(queue);
>> -
>> -	return 0;
>> +		q->sched_shared_tags = NULL;
>>  }
>>  
>>  void blk_mq_sched_reg_debugfs(struct request_queue *q)
>> @@ -458,8 +411,106 @@ void blk_mq_sched_unreg_debugfs(struct request_queue *q)
>>  	mutex_unlock(&q->debugfs_mutex);
>>  }
>>  
>> +void __blk_mq_free_sched_tags(struct blk_mq_tag_set *set,
>> +		struct blk_mq_tags **tags, unsigned int nr_hw_queues)
>> +{
>> +	unsigned long i;
>> +
>> +	if (!tags)
>> +		return;
>> +
>> +	/* Shared tags are stored at index 0 in @tags. */
>> +	if (blk_mq_is_shared_tags(set->flags))
>> +		blk_mq_free_map_and_rqs(set, tags[0], BLK_MQ_NO_HCTX_IDX);
>> +	else {
>> +		for (i = 0; i < nr_hw_queues; i++)
>> +			blk_mq_free_map_and_rqs(set, tags[i], i);
>> +	}
>> +
>> +	kfree(tags);
>> +}
>> +
>> +void blk_mq_free_sched_tags(struct elevator_tags *et,
>> +		struct blk_mq_tag_set *set, int id)
>> +{
>> +	struct blk_mq_tags **tags;
>> +
>> +	tags = xa_load(&et->tags_table, id);
>> +	__blk_mq_free_sched_tags(set, tags, et->nr_hw_queues);
>> +}
>> +
>> +struct blk_mq_tags **__blk_mq_alloc_sched_tags(struct blk_mq_tag_set *set,
>> +				unsigned int nr_hw_queues,
>> +				unsigned int nr_requests,
>> +				gfp_t gfp)
>> +{
>> +	int i, nr_tags;
>> +	struct blk_mq_tags **tags;
>> +
>> +	if (blk_mq_is_shared_tags(set->flags))
>> +		nr_tags = 1;
>> +	else
>> +		nr_tags = nr_hw_queues;
>> +
>> +	tags = kcalloc(nr_tags, sizeof(struct blk_mq_tags *), gfp);
>> +	if (!tags)
>> +		return NULL;
>> +
>> +	if (blk_mq_is_shared_tags(set->flags)) {
>> +		/* Shared tags are stored at index 0 in @tags. */
>> +		tags[0] = blk_mq_alloc_map_and_rqs(set, BLK_MQ_NO_HCTX_IDX,
>> +					MAX_SCHED_RQ);
>> +		if (!tags[0])
>> +			goto out;
>> +	} else {
>> +		for (i = 0; i < nr_hw_queues; i++) {
>> +			tags[i] = blk_mq_alloc_map_and_rqs(set, i, nr_requests);
>> +			if (!tags[i])
>> +				goto out_unwind;
>> +		}
>> +	}
>> +
>> +	return tags;
>> +out_unwind:
>> +	while (--i >= 0)
>> +		blk_mq_free_map_and_rqs(set, tags[i], i);
>> +out:
>> +	kfree(tags);
>> +	return NULL;
>> +}
>> +
>> +int blk_mq_alloc_sched_tags(struct elevator_tags *et,
>> +		struct blk_mq_tag_set *set, int id)
>> +{
>> +	struct blk_mq_tags **tags;
>> +	gfp_t gfp = GFP_NOIO | __GFP_NOWARN | __GFP_NORETRY;
>> +
>> +	/*
>> +	 * Default to double of smaller one between hw queue_depth and
>> +	 * 128, since we don't split into sync/async like the old code
>> +	 * did. Additionally, this is a per-hw queue depth.
>> +	 */
>> +	et->nr_requests = 2 * min_t(unsigned int, set->queue_depth,
>> +			BLKDEV_DEFAULT_RQ);
>> +
>> +	tags = __blk_mq_alloc_sched_tags(set, et->nr_hw_queues,
>> +			et->nr_requests, gfp);
>> +	if (!tags)
>> +		return -ENOMEM;
>> +
>> +	if (xa_insert(&et->tags_table, id, tags, gfp))
>> +		goto out_free_tags;
> 
> Not sure why you add `tags_table` into `elevator_tags`, it looks very
> confusing just from naming, not mention only single element is stored to
> the table in elevator switch code path since queue id is the key.
> 
Yeah but if you look at next patch where we add/remove tags in batch
then you'd realise that xarray may have multiple entries inserted when
it's called from nr_hw_queue update.

> Wrt. xarray suggestion, I meant to add on xarray local variable in
> __blk_mq_update_nr_hw_queues(), then you can store allocated `elevator_tags`
> to the xarray via ->id of request_queue.
> 
I think I got it now what you have been asking for - there was some confusion 
earlier. So you are suggesting to insert pointer to 'struct elevator_tags' 
in a local Xarray when we allocate sched_tags in batch from nr_hw_queue update
context. And the key to insert 'struct elevator_tags' into Xarray would be q->id.
Then later, from elv_update_nr_hw_queues() we should retrieve the relavent
pointer to 'struct elevator_tags' from that local Xarray (using q->id) and pass
on the retrieved elevator_tags to elevator_switch function.

So this way we would not require using ->tags_table inside 'struct elevator_tags'.
Additionally, blk_mq_alloc_sched_tags() shall return allocated 'struct elevator_tags'
to the caller. And the definition of the 'struct elevator_tags' would look like this:

struct elevator_tags {
	/* num. of hardware queues for which tags are allocated */
	unsigned int nr_hw_queues;
	/* depth used while allocating tags */
	unsigned int nr_requests;
        /* The index 0 in @tags is used to store shared sched tags */
	struct blk_mq_tags **tags;	
};

This seems like a clean and straightforward solution that should be easy to implement
without much hassle. Please let me know if this still needs adjustment.

Thanks,
--Nilay

