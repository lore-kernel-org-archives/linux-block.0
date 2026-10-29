Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793292694;
	b=BJpu2+eU7Y8KH8NPV5TDZ9WEv2QroYfZmKnsZUpTnL+uiDi0vMiFCrHq/J6ccHFOuhAq
	 YH54qbR9+zBlQsRFS8pAhcsgPw3J29xAkcXkQpYLmQKLYqxjbLNQr9cpYu/zMmVy4S4ss
	 M0xbduIsLQinBiombWB+E7ACiOS0ls60yH/8nNFPHMoLDCYXvoxX2mSa2OTXLo6nITyE6
	 Xo+TPSTZ6SKSJIFkcZzGTZWJGHmmCCYdORGbIPnG839hv2/pfJ45MIApysaSkOgAi0e4i
	 4ouz8Bbvb+W+lib6hnxFFQu4JsDf3oMSCdGQZdaJ+DMzohCcVhmzpN/yiulHxbS5cIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793292694;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=pWgPGu381ohE/0+Mv+vLDHYoV3MjJ2nDSyBklO6/DPI=;
	b=tE9hOl7zxlv+ROAPVocV4Efpz+HpJElkat47nKDmgFJq3OVM7hX4WPTzKaNP5o5jaL9j
	 HJrxCtgl9Rgp8bgPMH1Gt4v/V0CH5kIkzEHJwayNM0GlzwxYEmhlULpNmRV/eExftOP9N
	 IYK7akFTsgYJH4lLuKo0pM19Sumyqkmw519+JvR9FhHjY+z0wuv2WxxaVQ4YCIdAJreZb
	 SP2P02CuDnIIzboq3QcTYcmRQ9EoGpLSLXg6NUoIk2Ca1+qN6EJwiQkOslpgYusNuLts6
	 kT3P5RaOmtY8Uv90QLh86GnivKDZwj1cne8RmZHeFE+3B08yjj4/E0U90K5sogMBkjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=SIyKE4re;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBFFF606A31A
	for <linux-block@vger.kernel.org>; Thu, 29 Oct 2026 16:51:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CBFFF606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=SIyKE4re
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69TGEIZM409737;
	Thu, 29 Oct 2026 16:51:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=pWgPGu
	381ohE/0+Mv+vLDHYoV3MjJ2nDSyBklO6/DPI=; b=SIyKE4reZNRpnFj+r7tqUY
	Xn+8y9TBDjMzN/1/CLAyQ1J6Xr8i7iQo5DUSs8ijywVfTP4Bc9q0UaU740pwRuNr
	c/qZ9D7pGsbJVe8kwyMx8ktfdhl/DFMHq6ed8Snfyg9eKu0I4VgfX8aeRXRJmOoS
	F6NDn1YxzmJPt5+aDAT8S0H4hE0G/QQGU1Lj1gXFtIhHaIuUqMAPjpL1GkapygFj
	4tLKjciXlfsCb0x9s2V8wip6KicqCsIlWgEa5DT9XjgKMbBH1MP43Q1ILnQDzpPH
	UIYnrLUsn3Mfi5nNXfA7NqGFpg3rMRCOsnnAPGcX+HMSxKFpsYOhPtLWO6wPXSiw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgj3mkpn8-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 29 Oct 2026 16:51:20 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69TGK4HK2213963;
	Thu, 29 Oct 2026 16:51:19 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hk010s5hv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Oct 2026 16:51:19 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69TGpJK932965324
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Oct 2026 16:51:19 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0DC8B58043;
	Thu, 29 Oct 2026 16:51:19 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3DEB45805D;
	Thu, 29 Oct 2026 16:51:17 +0000 (GMT)
Received: from [9.61.35.48] (unknown [9.61.35.48])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 29 Oct 2026 16:51:16 +0000 (GMT)
Message-ID: <ca936b43-14df-4d7f-8b8e-47567fd1334f@linux.ibm.com>
Date: Thu, 29 Oct 2026 22:21:15 +0530
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 37/98] blk-mq: exit the hctxs of a queue under
 tag_list_lock
To: Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        Bart Van Assche <bvanassche@acm.org>
References: <20261028164415.1262013-1-axboe@kernel.dk>
 <20261028164415.1262013-38-axboe@kernel.dk> <auNFqyGofX79OZVx@infradead.org>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <auNFqyGofX79OZVx@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA2NSBTYWx0ZWRfX/OnNsGHRJLGB
 WwN0/iAWuwJG8vDtXIj6isfN46TR45gPGfr9/qMcsuWtxU/6pTLGZ/RvAJiktwl4orlRLd59BVL
 1s+94xztrKb9WEwzm8e2npWdxKhuHiM=
X-Proofpoint-ORIG-GUID: iYg06wxyV-SJlu1Fg_aOmbfnLOk3JXKo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA2NSBTYWx0ZWRfXxT60sIQ+EWoo
 tmHyquExiVfAfd6CMTXJd8KZAWsljNX+6lwXF1JrUoGLO4HKUdGn5nGh2sxQdBCVvovIQWQlUQU
 /03UjzE/z3zqX3kw2MyGky3iR/K/PIzzqoPmXBKNQL7jT4If+k2VJxPUd3VOmCCIHHgIYF29vBE
 0f7rIFbtG12u/zdGMBlEyI4kxKT8NhPnwkqGv50EMYwdeVIeHb5obX4+3k+x5RWBl2jq0gZiy9a
 vaMwQgW0mT2ycbGQz8vprlrubsCUATqXNKHmtDmJNa0F1LGhciw/3C6DeYGEo0egDLsWZNkNVSK
 mhY58d8htB4TQboMVSpoN+qK9C55I73n4EgHPfshCZ9MVXmm3/5MKDdOMo0rkbz9JvGqXsXNQWQ
 ztakvjeGMAOSKnxXvrbIAJT7mYLTdg==
X-Authority-Analysis: v=2.4 cv=G7uJgNk5 c=1 sm=1 tr=0 ts=6ae37988 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=maIFttP_AAAA:8
 a=VnNF1IyMAAAA:8 a=yIXgrgR-2AY0ub3CGwAA:9 a=QEXdDO2ut3YA:10
 a=qR24C9TJY6iBuJVj_x8Y:22
X-Proofpoint-GUID: iYg06wxyV-SJlu1Fg_aOmbfnLOk3JXKo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2610190000 definitions=main-2610290065

On 10/29/26 6:40 PM, Christoph Hellwig wrote:
> On Wed, Oct 28, 2026 at 10:41:40AM -0600, Jens Axboe wrote:
>> From: Josef Bacik <josef@toxicpanda.com>
>>
>> blk_mq_update_nr_hw_queues() exits and replaces the hctxs of every queue
>> on set->tag_list under tag_list_lock. blk_mq_exit_queue() exits its
>> hctxs without the lock and only then takes the queue off the list, so an
>> update running at the same time exits them again and sets up new ones
>> that nobody exits. del_gendisk() is kept away by update_nr_hwq_lock,
>> disk_release() of a never added disk and blk_mq_destroy_queue() are not,
>> and nvme_alloc_ns() drops such a disk when it finds the queues frozen by
>> a reset.
>>
>> Hold tag_list_lock for both steps.
> 
> I'm a bit worried about cpu hotplug lock interaction as that always
> lead to the craziest imaginable lock chains, but otherwise this looks
> ok.
> 
Yes, CPU hotplug lock interactions have caused numerous lockdep splats in the
past. However, looking at this change, the lock chains appear to remain consistent.
I reviewed all possible paths leading to hctx exit and cpu_hotplug_lock and
those appears to be consistent.

It seems the new order is consistent across all relevant paths:

blk_mq_update_nr_hw_queues(): update_nr_hwq_lock (write) -> tag_list_lock.

Registered-disk teardown: update_nr_hwq_lock (read) -> tag_list_lock.

Never-registered disk release and blk_mq_destroy_queue(): tag_list_lock only.

HCTX exit callbacks already run under tag_list_lock during hardware-queue resizing,
so the new exit path does not introduce a new locking context.

CPU-hotplug removal remains tag_list_lock -> blk_mq_cpuhp_lock -> cpu_hotplug_lock,
the same order already used by the resize path; there is no reverse acquisition.

So With that,

Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>

>>
>> Fixes: 630ef623ed26 ("blk-mq: Swap two calls in blk_mq_exit_queue()")
>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>> ---
>>   block/blk-mq.c | 10 ++++++++--
>>   1 file changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>> index 0e8449424c9a..37c8f68e23c4 100644
>> --- a/block/blk-mq.c
>> +++ b/block/blk-mq.c
>> @@ -4339,7 +4339,8 @@ static void blk_mq_del_queue_tag_set(struct request_queue *q)
>>   {
>>   	struct blk_mq_tag_set *set = q->tag_set;
>>   
>> -	mutex_lock(&set->tag_list_lock);
>> +	lockdep_assert_held(&set->tag_list_lock);
>> +
>>   	list_del_rcu(&q->tag_set_list);
>>   	if (list_is_singular(&set->tag_list)) {
>>   		/* just transitioned to unshared */
>> @@ -4347,7 +4348,6 @@ static void blk_mq_del_queue_tag_set(struct request_queue *q)
>>   		/* update existing queue */
>>   		blk_mq_update_tag_set_shared(set, false);
>>   	}
>> -	mutex_unlock(&set->tag_list_lock);
>>   }
>>   
>>   static void blk_mq_add_queue_tag_set(struct blk_mq_tag_set *set,
>> @@ -4711,10 +4711,16 @@ void blk_mq_exit_queue(struct request_queue *q)
>>   {
>>   	struct blk_mq_tag_set *set = q->tag_set;
>>   
>> +	/*
>> +	 * As long as the queue is on set->tag_list, its hctxs belong to
>> +	 * blk_mq_update_nr_hw_queues() as well, which exits and replaces them.
>> +	 */
>> +	mutex_lock(&set->tag_list_lock);
>>   	/* Checks hctx->flags & BLK_MQ_F_TAG_QUEUE_SHARED. */
>>   	blk_mq_exit_hw_queues(q, set, set->nr_hw_queues);
>>   	/* May clear BLK_MQ_F_TAG_QUEUE_SHARED in hctx->flags. */
>>   	blk_mq_del_queue_tag_set(q);
>> +	mutex_unlock(&set->tag_list_lock);
>>   }
>>   
>>   static int __blk_mq_alloc_rq_maps(struct blk_mq_tag_set *set)
>> -- 
>> 2.56.0
>>
>>
> ---end quoted text---

