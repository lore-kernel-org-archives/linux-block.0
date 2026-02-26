Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101DD3EDACF
	for <linux-block@vger.kernel.org>; Thu, 26 Feb 2026 15:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772120303; cv=none; b=OKA9ii1l+4zWW6/VRmvWb3+KT1pZh2Pd1xBcxmIWjCw+TdxyRSjGqWYY0Vyzddz4qquPYcK4stIG2m5S2EatzYc1vCsB8gBRT5ZZA+xRJAXcHzuHUFrXdbjKj2zoOcZdYaXKMJa2dIEbHdmiAJGpd6FJrmPwD1N6UlPk3zlVNUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772120303; c=relaxed/simple;
	bh=ssXkoZLNw5U/Sj/ACER4l+EgfA3oMnML0uj4dVaRpcw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XmW+9Qw+NdzCMLKaDsL0sYOhivq2KWoFEQj47FPMikc8MMSH6XUvlaMqWzhfJNiJt73udHqutdNUDbUo9LqxJsLG0ZlnGXDiE9HdaO+/2sOJVoC2vtmP6tZkuHM1mFrj6M+5MJWZrMhAA7jUTKUzy3bMPcq7rG+59+e506m/t8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iZb0JAR8; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iZb0JAR8"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61QDgEKm1936303;
	Thu, 26 Feb 2026 15:38:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=vRSnJx
	IeuGHXVMc4CQeQe521vBwwPZnYU3eR6M4E0ZE=; b=iZb0JAR8QRvv8GEN+CEDI2
	9Z87aqoyDuLD8GFYkNWwJR3iH3LNIyx1SHLarHpLbcNQtMLdeY4kq1RHRrc+VXvG
	Bybcs6sxbeSAoj2ea+zVMGWyR7FD3l2bLBsh0QJnC1HNIXD+YwHu/9yGtg2ypsCJ
	fTOt1TzHoIY7gIMpT4ZZdqGkjlkjTTwcpHkp0nx52nzmlswVfSvN3MmH83Epj39P
	yfk01keMvxeXeTi0s8jwW1k2P5JisRO2KPNpHTyyKRdTaU0OiAZk0Re4VgH8CN3Z
	vZzBlTINw5i8ygkKdnbbCLui9lnCDgAsjk1QWu707lJdiFM2dbfbMyrvS9SzNhlQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cf4bs6epj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Feb 2026 15:38:07 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61QDG7gv001674;
	Thu, 26 Feb 2026 15:38:07 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cfr1ncbd9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Feb 2026 15:38:07 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61QFc6lm10552032
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Feb 2026 15:38:06 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6558D58053;
	Thu, 26 Feb 2026 15:38:06 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7CD9758043;
	Thu, 26 Feb 2026 15:38:01 +0000 (GMT)
Received: from [9.43.72.132] (unknown [9.43.72.132])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 26 Feb 2026 15:38:00 +0000 (GMT)
Message-ID: <80246de3-f22e-46ba-8a78-17282190224c@linux.ibm.com>
Date: Thu, 26 Feb 2026 21:07:58 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: break pcpu_alloc_mutex dependency on freeze_lock
To: yukuai@fnnas.com, linux-block@vger.kernel.org
Cc: axboe@kernel.dk, hch@lst.de, ming.lei@redhat.com, yi.zhang@redhat.com,
        shinichiro.kawasaki@wdc.com, gjoyce@ibm.com
References: <20260225124556.1152510-1-nilay@linux.ibm.com>
 <1a2c39d4-5d39-42c6-89f9-3ec473b44b06@fnnas.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <1a2c39d4-5d39-42c6-89f9-3ec473b44b06@fnnas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: CZj2i_XJOH1olpZkACwR0U-uIjA2NiV2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDEzNiBTYWx0ZWRfXyBlmpBPjOHPF
 LJg3CQyB47uc70Gc2+CEe2Im2YnMB/4LlU/lnPPqEaGrALBdXxQ4e7REkIAheGNllPbvvUpHeXs
 jbYJ5aoA6RNqqJJ6hnk149wFLEYCCDllQMYiAmnnRA4H9CyfO9rPFoz7DbZGgBRW465fDaZifsP
 cvUN9kCJ5qt1bOItVWt6IHzaejeYKdUf81jcvVm9KZWzLmC+04eSOLSPZUHiq+PEW9RI42Cu7A+
 7SPkEx0GfDawjvvbdYfV6u688WZ/jNY4DW+vQ6+Vf597JzA5EV0g4+DZdfql+qpytnzTD9RI+cs
 4nYWeltGkJYW0kXxnLVs+aHWcE0wvqzGKHuvH+sNd5mfT9letKjKJL/uNVSNFR2YjL2xwYFuBe/
 fF/fRDz+lY6tirmcikFise+Gs8u7ujrBAukLTtDJLOrvZyf/fWR4F8s6sEe+ZkRrbw6b4+6LtXY
 sO4GZXFqEZZwtSvbSYA==
X-Authority-Analysis: v=2.4 cv=eNceTXp1 c=1 sm=1 tr=0 ts=69a068e0 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=3GNCSvPvoGDAPeXhQ7gA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: CZj2i_XJOH1olpZkACwR0U-uIjA2NiV2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-26_01,2026-02-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 phishscore=0 suspectscore=0 adultscore=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602260136



On 2/25/26 9:20 PM, Yu Kuai wrote:
> Hi,
> 
> 在 2026/2/25 20:44, Nilay Shroff 写道:
>> While nr_hw_update allocates tagset tags it acquires ->pcpu_alloc_mutex
>> after ->freeze_lock is acquired or queue is frozen. This potentially
>> creates a circular dependency involving ->fs_reclaim if reclaim is
>> triggered simultaneously in a code path which first acquires ->pcpu_
>> alloc_mutex. As the queue is already frozen while nr_hw_queue update
>> allocates tagsets, the reclaim can't forward progress and thus it could
>> cause a potential deadlock as reported in lockdep splat[1].
>>
>> Fix this by  pre-allocating tagset tags before we freeze queue during
>> nr_hw_queue update. Later the allocated tagset tags could be safely
>> installed and used after queue is frozen.
>>
>> Reported-by: Yi Zhang <yi.zhang@redhat.com>
>> Closes: https://lore.kernel.org/all/CAHj4cs8F=OV9s3La2kEQ34YndgfZP-B5PHS4Z8_b9euKG6J4mw@mail.gmail.com/ [1]
>> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
>> ---
>>   block/blk-mq.c | 53 +++++++++++++++++++++++++++++++++++---------------
>>   1 file changed, 37 insertions(+), 16 deletions(-)
>>
>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>> index d5602ff62c7c..687fd47786a6 100644
>> --- a/block/blk-mq.c
>> +++ b/block/blk-mq.c
>> @@ -4793,10 +4793,10 @@ static void blk_mq_update_queue_map(struct blk_mq_tag_set *set)
>>   	}
>>   }
>>   
>> -static int blk_mq_realloc_tag_set_tags(struct blk_mq_tag_set *set,
>> -				       int new_nr_hw_queues)
>> +static int blk_mq_prealloc_tag_set_tags(struct blk_mq_tag_set *set,
>> +		       int new_nr_hw_queues, struct blk_mq_tags ***tags)
> 
> Personally I don't like the last parameter, since the return value is not
> used at all, I feel it's better to return the new_tags instead.
> 

Hmm ok I could return new_tags and then use ERR_PTR when it fails to 
alloc tags. Then at call site we could use IS_ERR to distinguish 
between success vs fail case.

>>   {
>> -	struct blk_mq_tags **new_tags;
>> +	struct blk_mq_tags **new_tags = NULL;
>>   	int i;
>>   
>>   	if (set->nr_hw_queues >= new_nr_hw_queues)
>> @@ -4807,24 +4807,42 @@ static int blk_mq_realloc_tag_set_tags(struct blk_mq_tag_set *set,
>>   	if (!new_tags)
>>   		return -ENOMEM;
>>   
>> -	if (set->tags)
>> -		memcpy(new_tags, set->tags, set->nr_hw_queues *
>> -		       sizeof(*set->tags));
>> -	kfree(set->tags);
>> -	set->tags = new_tags;
>> -
>>   	for (i = set->nr_hw_queues; i < new_nr_hw_queues; i++) {
>> -		if (!__blk_mq_alloc_map_and_rqs(set, i)) {
>> -			while (--i >= set->nr_hw_queues)
>> -				__blk_mq_free_map_and_rqs(set, i);
>> -			return -ENOMEM;
>> +		if (blk_mq_is_shared_tags(set->flags))
>> +			new_tags[i] = set->shared_tags;
>> +		else {
>> +			new_tags[i] = blk_mq_alloc_map_and_rqs(set, i,
>> +					set->queue_depth);
>> +			if (!new_tags[i])
>> +				goto out_unwind;
>>   		}
>>   		cond_resched();
>>   	}
>>   
>>   done:
>> -	set->nr_hw_queues = new_nr_hw_queues;
>> +	*tags = new_tags;
>>   	return 0;
>> +out_unwind:
>> +	while (--i >= set->nr_hw_queues) {
>> +		if (!blk_mq_is_shared_tags(set->flags))
>> +			blk_mq_free_map_and_rqs(set, new_tags[i], i);
>> +	}
>> +	return -ENOMEM;
>> +}
>> +
>> +static void blk_mq_init_tag_set_tags(struct blk_mq_tag_set *set,
>> +		int new_nr_hw_queues, struct blk_mq_tags **new_tags)
>> +{
>> +	if (set->nr_hw_queues >= new_nr_hw_queues)
>> +		goto done;
>> +
>> +	if (set->tags)
>> +		memcpy(new_tags, set->tags, set->nr_hw_queues *
>> +		       sizeof(*set->tags));
>> +	kfree(set->tags);
>> +	set->tags = new_tags;
>> +done:
>> +	set->nr_hw_queues = new_nr_hw_queues;
>>   }
>>   
>>   /*
>> @@ -5113,6 +5131,7 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
>>   	unsigned int memflags;
>>   	int i;
>>   	struct xarray elv_tbl;
>> +	struct blk_mq_tags **new_tags;
>>   	bool queues_frozen = false;
>>   
>>   	lockdep_assert_held(&set->tag_list_lock);
>> @@ -5147,11 +5166,13 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
>>   		if (blk_mq_elv_switch_none(q, &elv_tbl))
>>   			goto switch_back;
>>   
>> +	if (blk_mq_prealloc_tag_set_tags(set, nr_hw_queues, &new_tags) < 0)
>> +		goto switch_back;
>> +
>>   	list_for_each_entry(q, &set->tag_list, tag_set_list)
>>   		blk_mq_freeze_queue_nomemsave(q);
>>   	queues_frozen = true;
>> -	if (blk_mq_realloc_tag_set_tags(set, nr_hw_queues) < 0)
>> -		goto switch_back;
>> +	blk_mq_init_tag_set_tags(set, nr_hw_queues, new_tags);
> 
> It looks ok just leave set->nr_hw_queues = nr_hw_queues, and the patch should
> be much simpler.
> 

I think you’re suggesting that blk_mq_init_tag_set_tags() can be removed and
the tag installation along with set->nr_hw_queues = nr_hw_queues can be done
inline at the call site. Makes sense. I will implement it in v2.

Thanks,
--Nilay

