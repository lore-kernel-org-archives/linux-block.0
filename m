Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C80288C1A;
	Fri, 15 Aug 2025 11:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755259181; cv=none; b=WSKrnU+sIZrxJB76CmdDU6jvlTbTUu0nw+HYg7vuui5jrkiyREfXM1xtGGGkqmb06W6e0x4nRGpiLxNvsaIAghy3+BMJKBFZrJSRm2tEpxddKEvIuUtSbZ0QArHQceDYF6DBOMtNlcAxWWqK9ZluvvsWipI79lFCSV51r5p7gfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755259181; c=relaxed/simple;
	bh=AIycdL0Tk0Qnuzo+6UylC5XKgeoTWVpU71O7jN9JVlo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EAmJok+ZyDZn35QbDKkXE+GNdlIXBC0EQnsUylInX9XHlNK3YJr3HKIfdGaADZRq7LhJa+uAIplrN7n53EaLWYnTetq8CfEjAZicX0oYPnDOzoDPmNVPmwaoLlAOxIyiV8zsJ7u8YXLxf9cFvmOzmanAoeSb+kJDtTVBNMirCq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dKK1maa9; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dKK1maa9"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57F2VDQq004503;
	Fri, 15 Aug 2025 11:59:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=nojUB+
	GltUbSvYuAX7neLLtsgRhvOCrtHvrygasBGwQ=; b=dKK1maa9NOh5I1FvirSX7E
	1pk6JUlJhGWl/8ZN+94b7NpDCix8r6QARK3YyOH4XN6rojIqu74lJrLgQRf93aiM
	6+6vWl/hT9HWFYC/keNryljqwjpLLmytguLAmF0uGixwyDRqSQZY7JTspH0YbxVu
	i5rBq7gbsOa0BfAUCgfGeIxeE8FBNTJ+VW2fejx4SC8cR5ar7DA6Hah0Km9cUpKs
	SZgdqFpHG2LzPBO6pkuL3pOtqZBYP08OAjUX7iDKU4aNP/mltD5RjqEvVkY4r3oS
	ZMm/drsGWsQfOFA7IKfjkofoF8mqxVOnu+usMM/01BQnTRX1v7sHskRRtzPzso3w
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48ehaakcgs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Aug 2025 11:59:09 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57F8o8GB025657;
	Fri, 15 Aug 2025 11:59:08 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 48ejvmrh3n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Aug 2025 11:59:08 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57FBx7Z627722376
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Aug 2025 11:59:08 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AFAFE58045;
	Fri, 15 Aug 2025 11:59:07 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B2BC058050;
	Fri, 15 Aug 2025 11:59:03 +0000 (GMT)
Received: from [9.61.133.254] (unknown [9.61.133.254])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 15 Aug 2025 11:59:03 +0000 (GMT)
Message-ID: <bbbe1889-38e8-4ab9-bce5-a4371b976433@linux.ibm.com>
Date: Fri, 15 Aug 2025 17:29:01 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/16] blk-mq: remove useless checkings from
 blk_mq_update_nr_requests()
To: Yu Kuai <yukuai1@huaweicloud.com>, axboe@kernel.dk, bvanassche@acm.org,
        hare@suse.de, ming.lei@redhat.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com, johnny.chenyi@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20250814033522.770575-1-yukuai1@huaweicloud.com>
 <20250814033522.770575-4-yukuai1@huaweicloud.com>
 <97b63163-a122-48f0-805a-a06cf792903f@linux.ibm.com>
 <31a567ac-180a-b2de-2233-e758a9a977d8@huaweicloud.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <31a567ac-180a-b2de-2233-e758a9a977d8@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=KPRaDEFo c=1 sm=1 tr=0 ts=689f210d cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=i0EeH86SAAAA:8 a=VscZIbB_9VdVsRj_TFIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 0fCxtM7oHzTFN32oKHJyyiqMvDQaccTe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDIyNCBTYWx0ZWRfXxqBpMftCDyGu
 K3k5WZr4k88onQhls3jXyIjm9lttg/TAq+hysGLGSWG4Ksxei79Hzsh7BHk8YB1pbmG6YBtbYe5
 lxxw3ryhXen6QP5z9xF43b8hOnMfZXwk/yfrMiN+2vgJwwLLFDgjkHAKjVPsUASRffE64AT+Dn9
 6et0iniUJb4N2yV8wLbDvwhWSK9ZN/lCIepMuuR7tykN9x7j0uXh8EoWVJT+Kw1HWznhXswCZAv
 IHoCqFNqpctgHba8thAxa8q+4IQWGGzub0E444joYzx5v8N4RR4TT/yaqVlJrQgjQvc0c5uQQ8S
 D30No18oEy0SPawbHVCvuML4ju6g0DO7YpfF2WMV5JCBAXfon7Yd0bJuXe6LXQdGQZRWDSDHjw3
 SoM5QqC6
X-Proofpoint-GUID: 0fCxtM7oHzTFN32oKHJyyiqMvDQaccTe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-15_04,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 spamscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508120224



On 8/15/25 7:02 AM, Yu Kuai wrote:
> Hi,
> 
> 在 2025/08/14 20:23, Nilay Shroff 写道:
>>
>>
>> On 8/14/25 9:05 AM, Yu Kuai wrote:
>>> From: Yu Kuai <yukuai3@huawei.com>
>>>
>>> 1) queue_requests_store() is the only caller of
>>> blk_mq_update_nr_requests(), where queue is already freezed, no need to
>>> check mq_freeze_depth;
>>> 2) q->tag_set must be set for request_based device, and queue_is_mq() is
>>> already checked in blk_mq_queue_attr_visible(), no need to check
>>> q->tag_set.
>>> 3) During initialization, hctx->tags in initialized before queue
>>> kobject, and during del_gendisk, queue kobject is deleted before
>>> exiting hctx, hence checking hctx->tags is useless.
>>>
>>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>>> ---
>>>   block/blk-mq.c | 11 +----------
>>>   1 file changed, 1 insertion(+), 10 deletions(-)
>>>
>>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>>> index b67d6c02eceb..3a219b7b3688 100644
>>> --- a/block/blk-mq.c
>>> +++ b/block/blk-mq.c
>>> @@ -4921,24 +4921,15 @@ int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr)
>>>   {
>>>       struct blk_mq_tag_set *set = q->tag_set;
>>>       struct blk_mq_hw_ctx *hctx;
>>> -    int ret;
>>> +    int ret = 0;
>>>       unsigned long i;
>>>   -    if (WARN_ON_ONCE(!q->mq_freeze_depth))
>>> -        return -EINVAL;
>>> -
>>> -    if (!set)
>>> -        return -EINVAL;
>>> -
>>>       if (q->nr_requests == nr)
>>>           return 0;
>>>         blk_mq_quiesce_queue(q);
>>>   -    ret = 0;
>>>       queue_for_each_hw_ctx(q, hctx, i) {
>>> -        if (!hctx->tags)
>>> -            continue;
>> It's possible that hctx->tags is set to NULL in case no software
>> queues are mapped to the hardware queue. So it seems that this
>> check is valid. Please see blk_mq_map_swqueue().
> 
> Ok, thanks for the reviw.
> 
> I didn't notice this, just wonder how can this happen?
> nr_hw_queues > NR_CPUS?
> 
I think typically having nr_hw_queues > NR_CPUS is not allowed. 
But it's possible to have no software queues are mapped to hctx.
Check this commit 4412efecf7fd ("Revert "blk-mq: remove code for
dealing with remapping queue")

Thanks,
--Nilay




