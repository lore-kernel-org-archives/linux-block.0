Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E43621CA0C;
	Wed, 20 Aug 2025 05:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755668106; cv=none; b=IbtLhA3h76KSmvQ+YYEr8YgaX7/whk3rWLZ13N6ZBkJp+gAJpTldSdjozUqd98ZzvbACJDh6MT4jdhqny0yqh0LwTRyjqara7MZQ1+XmfIaLpHw5sKiH2hxdGoCETN1g3zfHM8oAj8EUcAE6AvY8OPYPFPHqcibayyHR5aljNUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755668106; c=relaxed/simple;
	bh=PGbpKjjkK7U6vif653Y/08jQ0Nh4rHCGe/3YW/sH7y4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FdDZjLmYkBflwG9L16hc24h+qBeWHf59NtDgiMBjEXEjXNFLRBfqNuQ5aGDN/5gxu1dS1YyXpEUrd61tQsrFfRNlCPHmMrXY3gNpyCNC0jWXOGwYdhUJzAibQKhl/28o9RVckrUu+rE3ddIXJemni8fKEdR3iZrnBMzQcT6JIV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Er5bMhua; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Er5bMhua"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57JNo8P7028827;
	Wed, 20 Aug 2025 05:34:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=dp+z/2
	bNtY/qwwyQQqfQ1AQdVSFA4KaNWU9fNir3iNg=; b=Er5bMhuavlteR8n14v6+O3
	MqBuoy05xJxgv/XXL2TD1VO/8xpPG9DmNIWT6kKWOFQ4NMisFfsrETAcWiR/8CCs
	qqmXvTWhfOOUfvDdx2IGtEDuYTAumgtdc1MpGcGAMqA/gj52v/cvDbeIXWFHGKWV
	8FalkCDlcK92xWWt3qomi6qY1x10oOx+WmaC8MqhdPY4yCLeUh0EcyIEwKFvxcWK
	6VR95bLBmU23nLObfZv76x82axlsSF/NKglYE2s2aPcbVw0C/2XUqQzzhfCJ/RwC
	tDhaZyxrby9wFHoWKQfrR9S4WiCqbY+SrNc9fW9D2q8KPdufeVete9DIHUEANNKQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48n38v95dv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Aug 2025 05:34:28 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57K4srw4024192;
	Wed, 20 Aug 2025 05:34:27 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 48my43hvq1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Aug 2025 05:34:27 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57K5YQoX21758482
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Aug 2025 05:34:27 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D7A4658068;
	Wed, 20 Aug 2025 05:34:26 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 78F4458067;
	Wed, 20 Aug 2025 05:34:23 +0000 (GMT)
Received: from [9.109.198.214] (unknown [9.109.198.214])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 20 Aug 2025 05:34:23 +0000 (GMT)
Message-ID: <bb74795a-29f2-4ea6-932a-46b9f9095df0@linux.ibm.com>
Date: Wed, 20 Aug 2025 11:04:22 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] blk-mq: fix elevator depth_updated method
To: Yu Kuai <yukuai1@huaweicloud.com>, axboe@kernel.dk, bvanassche@acm.org,
        ming.lei@redhat.com, hare@suse.de
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com, johnny.chenyi@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20250819012917.523272-1-yukuai1@huaweicloud.com>
 <20250819012917.523272-2-yukuai1@huaweicloud.com>
 <f0abcc02-48c6-4d09-86d6-5ca8b968dcde@linux.ibm.com>
 <0206ea4f-4efd-b7d0-088a-9257d06dcffb@huaweicloud.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <0206ea4f-4efd-b7d0-088a-9257d06dcffb@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDIyMiBTYWx0ZWRfXxpI6sgN61Ev7
 Wp8uQtO8zuS3ybBmhMyIpHZkD2r8rP8/Htfy/GtUpvsS66Fp1W3mLV2NQjYzPRVjpJNQaObDftS
 beO4fBO8G9vXNSTnveHiIrdgdhVM8ZLVgwGfxC0/MstqbewANoJdliS7t7DTOrj7eUtujnUCJ2W
 t5Y0jut70hIyCVunWWR904VQMZNgbTWlyujnEUkoUoS9jcAd//SWmkdydD+1XDnV1TBmSscP/e6
 C5CCiUlTjAptKmX1EzMcSY13tNmS48419gJ+SVZg8M+MN667kUVO/8EdjA3BzEbcMQ7l5nxoH9q
 g4dJJCWeF6Y1TF/3ORCwdB3bsxmghJlvK6YLn19F2N7DERNTMYKkrQW7YOc2o3mpuEbGQv/fESr
 pXZg3mfELjRR+wUTZVCQB9+RTAA2wA==
X-Authority-Analysis: v=2.4 cv=PMlWOfqC c=1 sm=1 tr=0 ts=68a55e64 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=i0EeH86SAAAA:8 a=BM1hubmVBTbMqI6o2TUA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=HhbK4dLum7pmb74im6QT:22
 a=cPQSjfK2_nFv0Q5t_7PE:22 a=pHzHmUro8NiASowvMSCR:22 a=Ew2E2A-JSTLzCXPT_086:22
X-Proofpoint-GUID: qoUmJ-I2erK5Omrk9P51FVTb2Bz7vp1z
X-Proofpoint-ORIG-GUID: qoUmJ-I2erK5Omrk9P51FVTb2Bz7vp1z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_02,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2508110000
 definitions=main-2508190222



On 8/20/25 6:26 AM, Yu Kuai wrote:
> Hi,
> 
> 在 2025/08/19 20:20, Nilay Shroff 写道:
>>
>>
>> On 8/19/25 6:59 AM, Yu Kuai wrote:
>>> From: Yu Kuai <yukuai3@huawei.com>
>>>
>>> Current depth_updated has some problems:
>>>
>>> 1) depth_updated() will be called for each hctx, while all elevators
>>> will update async_depth for the disk level, this is not related to hctx;
>>> 2) In blk_mq_update_nr_requests(), if previous hctx update succeed and
>>> this hctx update failed, q->nr_requests will not be updated, while
>>> async_depth is already updated with new nr_reqeuests in previous
>>> depth_updated();
>>> 3) All elevators are using q->nr_requests to calculate async_depth now,
>>> however, q->nr_requests is still the old value when depth_updated() is
>>> called from blk_mq_update_nr_requests();
>>>
>>> Fix those problems by:
>>>
>>> - pass in request_queue instead of hctx;
>>> - move depth_updated() after q->nr_requests is updated in
>>>    blk_mq_update_nr_requests();
>>> - add depth_updated() call in blk_mq_init_sched();
>>> - remove init_hctx() method for mq-deadline and bfq that is useless now;
>>>
>>> Fixes: 77f1e0a52d26 ("bfq: update internal depth state when queue depth changes")
>>> Fixes: 39823b47bbd4 ("block/mq-deadline: Fix the tag reservation code")
>>> Fixes: 42e6c6ce03fd ("lib/sbitmap: convert shallow_depth from one word to the whole sbitmap")
>>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>>> ---
>>>   block/bfq-iosched.c   | 21 ++++-----------------
>>>   block/blk-mq-sched.c  |  3 +++
>>>   block/blk-mq-sched.h  | 11 +++++++++++
>>>   block/blk-mq.c        | 23 ++++++++++++-----------
>>>   block/elevator.h      |  2 +-
>>>   block/kyber-iosched.c | 10 ++++------
>>>   block/mq-deadline.c   | 15 ++-------------
>>>   7 files changed, 37 insertions(+), 48 deletions(-)
>>>
>>> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
>>> index 50e51047e1fe..c0c398998aa1 100644
>>> --- a/block/bfq-iosched.c
>>> +++ b/block/bfq-iosched.c
>>> @@ -7109,9 +7109,10 @@ void bfq_put_async_queues(struct bfq_data *bfqd, struct bfq_group *bfqg)
>>>    * See the comments on bfq_limit_depth for the purpose of
>>>    * the depths set in the function. Return minimum shallow depth we'll use.
>>>    */
>>> -static void bfq_update_depths(struct bfq_data *bfqd, struct sbitmap_queue *bt)
>>> +static void bfq_depth_updated(struct request_queue *q)
>>>   {
>>> -    unsigned int nr_requests = bfqd->queue->nr_requests;
>>> +    struct bfq_data *bfqd = q->elevator->elevator_data;
>>> +    unsigned int nr_requests = q->nr_requests;
>>>         /*
>>>        * In-word depths if no bfq_queue is being weight-raised:
>>> @@ -7143,21 +7144,8 @@ static void bfq_update_depths(struct bfq_data *bfqd, struct sbitmap_queue *bt)
>>>       bfqd->async_depths[1][0] = max((nr_requests * 3) >> 4, 1U);
>>>       /* no more than ~37% of tags for sync writes (~20% extra tags) */
>>>       bfqd->async_depths[1][1] = max((nr_requests * 6) >> 4, 1U);
>>> -}
>>> -
>>> -static void bfq_depth_updated(struct blk_mq_hw_ctx *hctx)
>>> -{
>>> -    struct bfq_data *bfqd = hctx->queue->elevator->elevator_data;
>>> -    struct blk_mq_tags *tags = hctx->sched_tags;
>>>   -    bfq_update_depths(bfqd, &tags->bitmap_tags);
>>> -    sbitmap_queue_min_shallow_depth(&tags->bitmap_tags, 1);
>>> -}
>>> -
>>> -static int bfq_init_hctx(struct blk_mq_hw_ctx *hctx, unsigned int index)
>>> -{
>>> -    bfq_depth_updated(hctx);
>>> -    return 0;
>>> +    blk_mq_set_min_shallow_depth(q, 1);
>>>   }
>>>     static void bfq_exit_queue(struct elevator_queue *e)
>>> @@ -7628,7 +7616,6 @@ static struct elevator_type iosched_bfq_mq = {
>>>           .request_merged        = bfq_request_merged,
>>>           .has_work        = bfq_has_work,
>>>           .depth_updated        = bfq_depth_updated,
>>> -        .init_hctx        = bfq_init_hctx,
>>>           .init_sched        = bfq_init_queue,
>>>           .exit_sched        = bfq_exit_queue,
>>>       },
>>> diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
>>> index e2ce4a28e6c9..bf7dd97422ec 100644
>>> --- a/block/blk-mq-sched.c
>>> +++ b/block/blk-mq-sched.c
>>> @@ -585,6 +585,9 @@ int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e,
>>>               }
>>>           }
>>>       }
>>> +
>>> +    if (e->ops.depth_updated)
>>> +        e->ops.depth_updated(q);
>>>       return 0;
>>>   
>>
>> Overall changes look good. That said, I think it might be cleaner to structure
>> it this way:
>>
>> elevator_switch -> blk_mq_init_sched ->init_sched ==> sets async_depth
>> blk_mq_update_nr_requests ->depth_updated ==> updates async_depth
>>
>> This way, we don’t need to call ->depth_updated from blk_mq_init_sched.
> 
> Just to be sure, you mean calling the depth_updated method directly
> inside the init_sched() method? This is indeed cleaner, each elevator
> has to use this method to initialize async_dpeth.

Yes you're right. As ->init_sched() already has pointer to request queue,
you may now directly call ->depth_update() method of the respective 
elevator from ->init_sched().

Thanks,
--Nilay
