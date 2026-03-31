Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857B02BE05E
	for <linux-block@vger.kernel.org>; Tue, 31 Mar 2026 05:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774935457; cv=none; b=WqgGdKbEqT3ZNpK0kJuUKQ9wGBWCabEE0pbWS9Q769IxVnIt/h6pr6NoI71Kh7u/4VYpfU95Xr3Ep5A7FRYLj4/3KH4KOVxmZ0TJww9KFhZoPmqLdX4OpaX+z+4UlWzpNULAAWqV2EvAW8wAEbGhKU5IicYmcnsyjHM5iD/xdCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774935457; c=relaxed/simple;
	bh=KsNbyMurvg81fizoHa0lX+lFgFCOtBYU2UaInpmhGN0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dxFjytEk2mYsjUlNsJ3q0ZMQgUdXMk17O5219ijV1rgXYVBTopgLtgIJl9Fvkh9FC2jgQP293EtbCSctN3RuPxeoa1Mq7VFikFqL+F8ngIY27dWfm8q59SsPwKKDReU1/aZeb+4FjVr/HE+lQiwAM9riBE/DiWuYhJQur1EXDco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eRy2IkDD; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eRy2IkDD"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62UGpOTH503870;
	Tue, 31 Mar 2026 05:37:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Fp9HQG
	Hr7FlbjW4qPGTRWOsRkr1LKYQyMV5zf0RbIm4=; b=eRy2IkDDuz6sPA5s0BhEVF
	SOMlDlj+bqZ4XfSSk452Ob9buFVA6xMXMGRSDeu0i+UQfE6oPd0t5tECKxHM5RBR
	+w3AIKAE4X29t6KfUOrvdmd2TlrLfMkl6glFrs3bem+U7ozurl75hPTL+AnyFOmw
	DwUwKtpWaE4mSIcN0egAcWvXHwf0xewEO4keQ/MjnMLbHZqkwArQGZptwMAKCrZP
	u8FdKhiLR9ZpMVhav2YLGjerK/J1tnvlDo4aXojaXovmI65ER6hMHdg6YWD3x0t/
	Kl1JTzLny1iwttDXToPas31Gksn6CJ7Sj5tTJ2efVPB83h8n+Z9JAsdzZ0Lb5OOw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66q31t1h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 31 Mar 2026 05:37:16 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62V1QoqH013936;
	Tue, 31 Mar 2026 05:37:15 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d6ttkfn2d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 31 Mar 2026 05:37:15 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62V5bEYm29885162
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 31 Mar 2026 05:37:14 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CEB7158071;
	Tue, 31 Mar 2026 05:37:14 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B7F2C5805D;
	Tue, 31 Mar 2026 05:37:10 +0000 (GMT)
Received: from [9.124.210.45] (unknown [9.124.210.45])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 31 Mar 2026 05:37:10 +0000 (GMT)
Message-ID: <746b98bb-d56b-468b-a59e-6de6ea5282f1@linux.ibm.com>
Date: Tue, 31 Mar 2026 11:07:09 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 20/26] null_blk: Enable lock context analysis
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <dlemoal@kernel.org>, Tejun Heo <tj@kernel.org>,
        Keith Busch <kbusch@kernel.org>, Chaitanya Kulkarni <kch@nvidia.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Kees Cook
 <kees@kernel.org>, Genjian Zhang <zhanggenjian@kylinos.cn>,
        Marco Elver <elver@google.com>
References: <20260325214518.2854494-1-bvanassche@acm.org>
 <20260325214518.2854494-21-bvanassche@acm.org>
 <b9cbbd2b-4c2a-497a-84f8-f1bda0e7c40f@linux.ibm.com>
 <3820ca93-bcdc-419e-92a9-251b8d430cec@acm.org>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <3820ca93-bcdc-419e-92a9-251b8d430cec@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: nBDQtOZfZ1G4UmaVcxQYOM0q9QAIn4QH
X-Authority-Analysis: v=2.4 cv=frzRpV4f c=1 sm=1 tr=0 ts=69cb5d8d cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=lUidTSh3bHBoYPQXGEYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 7vdDIKepF-xOoWao7JOg63BWFolc3wB8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDA0NyBTYWx0ZWRfX1RWqiFw2fUtx
 zjkUbfGZdLy1yeWusdMhFEqbhgvwXkXn7x8JbKcjC9/zliq79Q23iMLLk5RrP51l0j1pEU8m4ug
 OlY+5L2+jYxuTl1qT9uTBv2asDamsnUvjTaQih3k+L/KVTa+A33EIounL39BHMN8/80kifJRbit
 k1WhXvJJ0lVWsKhokcwAr5/PikjxqEA1kwwvfEQB07sIhLr6Y9OAPkurmbHNQyXYvntc0e/Db1l
 8A+jG4saYjHXfHxLddwZ1F0qU+L1ecI/a5egiRqD65l3y9pFhoeAFRWCnX5h4ugRIR9n1Nwe39T
 wjcfr9cJw6q4bJKS807wJxOk2NCVlYKsrpyEak3bdc2cD/YjyYDMeEsbUj77ECIBHwEP98hSwfG
 Mu5A7UthJnc+kx0SAaMcR8iOz4g3FNL2euuwfPdf527jxKmSyemVT+C8OrxeTbe3Oc0uNlpx2Mf
 6e/9dY9Pv2ov6XXr0uw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-31_01,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603310047

On 3/30/26 9:55 PM, Bart Van Assche wrote:
> (+Marco)
> 
> On 3/30/26 3:23 AM, Nilay Shroff wrote:
>> On 3/26/26 3:15 AM, Bart Van Assche wrote:
>>> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/ main.c
>>> index f8c0fd57e041..677ac829ef80 100644
>>> --- a/drivers/block/null_blk/main.c
>>> +++ b/drivers/block/null_blk/main.c
>>> @@ -1004,8 +1004,7 @@ static struct nullb_page *null_lookup_page(struct nullb *nullb,
>>>   static struct nullb_page *null_insert_page(struct nullb *nullb,
>>>                          sector_t sector, bool ignore_cache)
>>> -    __releases(&nullb->lock)
>>> -    __acquires(&nullb->lock)
>>> +    __must_hold(&nullb->lock)
>>
>> This function temporarily drops the &nullb->lock and requires it.
>> So why do we need to replace __releases/__acquires with __must_hold?
>> This is not clear.
> 
> __must_hold() has the same meaning as __releases() + __acquires(). The
> only difference between these two annotations is that __must_hold() is
> more compact. I can leave out this change if this change is considered
> confusing.
> 
Hmm, but per the documentation of __must_hold() it seems that this attribute
signifies the caller of the function must hold the exclusive context lock.
On contrary, __releases() attribute is meant to be used when function releases
a context lock exclusively and __acquires() should be used when function acquires
context lock exclusively.

 From the above rational, it seems that null_insert_page() should have all
the above three attributes applicable, isn't it?

>>> diff --git a/drivers/block/null_blk/zoned.c b/drivers/block/null_blk/ zoned.c
>>> index 384bdce6a9b7..a7f94e76034f 100644
>>> --- a/drivers/block/null_blk/zoned.c
>>> +++ b/drivers/block/null_blk/zoned.c
>>> @@ -32,6 +32,7 @@ static inline void null_init_zone_lock(struct nullb_device *dev,
>>>   static inline void null_lock_zone(struct nullb_device *dev,
>>>                     struct nullb_zone *zone)
>>> +    __no_context_analysis /* conditional locking */
>>
>> I see we already have __context_unsafe(comment) macro defined
>> which may be used instead for inline comment.
> 
> context_unsafe() suppresses warnings triggered by __guarded_by() and
> __guarded_by_ptr() but does not suppress analysis of functions in the
> function body annotated with __releases() and __acquired(). If I remove
> the __no_context_analysis annotation and surround the function body with
> context_unsafe(), the following appears:
> 
> drivers/block/null_blk/zoned.c:37:2: error: spinlock 'zone->.spinlock' is not held on every path through here [-Werror,-Wthread-safety-analysis]
>     37 |         context_unsafe(
>        |         ^
> ./include/linux/compiler-context-analysis.h:201:30: note: expanded from macro 'context_unsafe'
>    201 | #define context_unsafe(...)             \
>        |                                         ^
> drivers/block/null_blk/zoned.c:39:3: note: spinlock acquired here
>     39 |                 spin_lock_irq(&zone->spinlock);
>        |                 ^
> 
> drivers/block/null_blk/zoned.c:37:2: error: mutex 'zone->.mutex' is not held on every path through here [-Werror,-Wthread-safety-analysis]
>     37 |         context_unsafe(
>        |         ^
> ./include/linux/compiler-context-analysis.h:201:30: note: expanded from macro 'context_unsafe'
>    201 | #define context_unsafe(...)             \
>        |                                         ^
> drivers/block/null_blk/zoned.c:41:3: note: mutex acquired here
>     41 |                 mutex_lock(&zone->mutex);
>        |                 ^
> 2 errors generated.
> 
I am not sure why did compiler generate the above errors? If I look at the
macro definition then it seems __context_unsafe(/* comment */) should simply
expand to __no_context_analysis.

// From include/linux/compiler-context-analysis.h:

#define __context_unsafe(comment) __no_context_analysis

Thanks,
--Nilay


