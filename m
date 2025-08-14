Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387DF2E1C64;
	Thu, 14 Aug 2025 12:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755173748; cv=none; b=faYPY7CzJoYdcEtFnUB8AN1WsvwYYfjMMvJ8LJ8qfGc3ijrL+WPKwFb8ltnrKZAGs705G8RYieZC+Du7XgQmGmyrcC+ga0nNVZlTx6nfV2gKjhHnN5bbZVNOCdsGC+eq2sjpKolOqcrC03ByckHDhSKq1R7cKmIUjgBugokmv+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755173748; c=relaxed/simple;
	bh=Pd/b4svV5M05SKBeMyvfPAwsdplBC77zGbTanRckWJg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fhcs3iNT25qYcJEe3Yac5FLFfxQC8gC4QK9mw9HgcqkCpLvoDxtHxJQLjKENVIwxsXtS6fk7cJd5i7yjISmXcgTxkBnGQ4As/UAy7xEj3mxCfYi9xCKCPb8F+cE3QaBY+YHmNybPuk3g/sh/g6IKQFc7UHfoj6A39I2571ukBiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TvB/ErAX; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TvB/ErAX"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57EBj2fm025118;
	Thu, 14 Aug 2025 12:15:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=FGy2Uj
	ZnXbHAZAaF2f8XajEOLc/UCQwd8IuaLN0+3w8=; b=TvB/ErAXbwP89TAjP7KdV2
	4cPflp18MBwXXp4Zs6J3fwTO2EKS9/uJF2k+tvPyN2ULtcaKPU62mK6XFftSFfdC
	Jwz+CstxqlYO/a7DF5KS5f1WJ05go+eUs3Q+uj5Dm6wviVsDXCqcJB6IOKDpmsWL
	SrxVACPSGqplmJ5dbt7zdCpgU8VipSNk4J1UMbNfr+kR5BVdq9pbaqQMZrQw76WU
	eXdo+v85BRnjS4hL9DMwgHEEm5c4Fr17GYk8bPXuarEryxRODJFyx7bWmrjgtNyy
	6j6Nx4LoRb1dkbalG2QZBT6cG/oCas5R5RbPhCpaU1uHsCELOrGmCZu62zf6xxmA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48ehaae589-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Aug 2025 12:15:17 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57E8KAMg026279;
	Thu, 14 Aug 2025 12:15:17 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48eh21c7ts-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Aug 2025 12:15:17 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57ECFG9G28508712
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Aug 2025 12:15:16 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7808058061;
	Thu, 14 Aug 2025 12:15:16 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 41A1558057;
	Thu, 14 Aug 2025 12:15:13 +0000 (GMT)
Received: from [9.109.198.214] (unknown [9.109.198.214])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 14 Aug 2025 12:15:12 +0000 (GMT)
Message-ID: <822e6a29-7340-4c79-a23e-ff9221cac74f@linux.ibm.com>
Date: Thu, 14 Aug 2025 17:45:12 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/16] blk-mq: fix blk_mq_tags double free while
 nr_requests grown
To: Yu Kuai <yukuai1@huaweicloud.com>, axboe@kernel.dk, yukuai3@huawei.com,
        bvanassche@acm.org, hare@suse.de, ming.lei@redhat.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com, johnny.chenyi@huawei.com
References: <20250814033522.770575-1-yukuai1@huaweicloud.com>
 <20250814033522.770575-9-yukuai1@huaweicloud.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250814033522.770575-9-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=KPRaDEFo c=1 sm=1 tr=0 ts=689dd355 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=i0EeH86SAAAA:8 a=6NI6H_c-a1oXmsWDywsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: A1GXg7jICdt-jyK7CSn5JCBsfetQrQ2B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDIyNCBTYWx0ZWRfX3IYXDjq7EDq5
 DR+vUkvti/ILwuNXpFOJA78NGJzhutd8UEbWJo1bA6iN9ZL4115+zql2kIiayx+TsQwftlAX/66
 Nn67cmGdjyGjUbPbV/X0MLxfSLxXOw0rlRUUazgmh9GCBj32OE9taKbBgxn9U9p0eQCAMUJP3ky
 qIflWNmcL+qalJW/u6kAZJDSqPgQ7agFhkH2lTHJHMabXIZkuWEp2iNPhQGbpbuDbEFuS8d+ryD
 q0v1LxPMA1mOTiI/F3vrV+1tUHZQYnpDQpigwV4jgB3NccWQedXWXfDI8C7ior6oqbdkNClHtos
 nQx90kypgK0p0zyeaDPSlBOoBIZ9iT4wXgJUK5QZ3AlAX46Xe2B5iXG6CKlLlXOtHQ1sAC5PU5E
 p35U57h9
X-Proofpoint-GUID: A1GXg7jICdt-jyK7CSn5JCBsfetQrQ2B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_02,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 spamscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508120224



On 8/14/25 9:05 AM, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> In the case user trigger tags grow by queue sysfs attribute nr_requests,
> hctx->sched_tags will be freed directly and replaced with a new
> allocated tags, see blk_mq_tag_update_depth().
> 
> The problem is that hctx->sched_tags is from elevator->et->tags, while
> et->tags is still the freed tags, hence later elevator exist will try to
> free the tags again, causing kernel panic.
> 
> Fix this problem by using new halper blk_mq_alloc_sched_tags() to
> allocate a new sched_tags. Meanwhile, there is a longterm problem can be
> fixed as well:
> 
> If blk_mq_tag_update_depth() succeed for previous hctx, then bitmap depth
> is updated, however, if following hctx failed, q->nr_requests is not
> updated and the previous hctx->sched_tags endup bigger than q->nr_requests.
> 
> Fixes: f5a6604f7a44 ("block: fix lockdep warning caused by lock dependency in elv_iosched_store")
> Fixes: e3a2b3f931f5 ("blk-mq: allow changing of queue depth through sysfs")
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  block/blk-mq.c | 31 ++++++++++++++++++++-----------
>  1 file changed, 20 insertions(+), 11 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index a7d6a20c1524..f1c11f591c27 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -4917,6 +4917,23 @@ void blk_mq_free_tag_set(struct blk_mq_tag_set *set)
>  }
>  EXPORT_SYMBOL(blk_mq_free_tag_set);
>  
> +static int blk_mq_sched_grow_tags(struct request_queue *q, unsigned int nr)
> +{
> +	struct elevator_tags *et =
> +		blk_mq_alloc_sched_tags(q->tag_set, q->nr_hw_queues, nr);
> +	struct blk_mq_hw_ctx *hctx;
> +	unsigned long i;
> +
> +	if (!et)
> +		return -ENOMEM;
> +
> +	blk_mq_free_sched_tags(q->elevator->et, q->tag_set);
> +	queue_for_each_hw_ctx(q, hctx, i)
> +		hctx->sched_tags = et->tags[i];
> +	q->elevator->et = et;
> +	return 0;
> +}
> +
I see that we're allocating/freeing sched tags here after we freeze the 
queue and acquire ->elevator_lock. And so this shall cause the lockdep 
splat we saw earlier[1]. I'm not saying that your proposed change would
cause it, but I think this is one of the code path which we missed to
handle. So when you're at it, please ensure that we don't get into this
splat again. We've already fixed this splat from another code paths 
(elevator change and nr_hw_queue update) but it seems we also need to
handle that case here as well.

[1] https://lore.kernel.org/all/0659ea8d-a463-47c8-9180-43c719e106eb@linux.ibm.com/

Thanks,
--Nilay
