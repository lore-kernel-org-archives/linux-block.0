Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CFE1A4E70;
	Tue,  9 Sep 2025 09:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757410631; cv=none; b=FLldp0yMkDdAAwwTdUcCCvWSCF8x3d5wD8kHGtDUCo3nQG/6DZyGt3B1lIb32f5QK+FyVcbxSQb5io4Stn42JjbRDSav8zRR+DRO/5zWZnkt4JV1360nWdIJhZGU2PnlqjcFvYxPx9gHelw5pqdZ4VhlDtpniYGNuxmQ4AYh3ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757410631; c=relaxed/simple;
	bh=iZKO3B3Q7KuNOQP/SmPPptnhkOve+k0UQcRQ6iXAbBw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m7X5OJMZNv/dO2CwxtfFwvHZWE0eUhRfrzbtqjIRr34Bsty+aTmJAZS7zTO+gsnStm0oLvZhouKb5dIQeOGXcq7n9YwWg5mKgendEsNw8ftjLzCX6EK2TapiWsAIb3A5ksx6ZVQD9HfCEYNTigUrYClxi/lQvU0Wgzpyd7j+zHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fSSiX84J; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fSSiX84J"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5896QOO5010165;
	Tue, 9 Sep 2025 09:36:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=6E2070
	tOZCJp5JyxAPY1/77mN2TBKJV9DTvYdGPJgG8=; b=fSSiX84JNQZi8BICXHKA36
	hLHxQE9S6GuVTKcbLpisH7w20kf9ptq9+zjYdNV+ALcgGF0o4cRQ+MbNVV8P5jaM
	M1AkPc0nYHzuyA1XcynFSVdMQi1I7M0k6LBmj37EC6lasedhrZZFFda4rUsaS4v4
	HTy9Qimw78sxJ94/rUX+E5bGLS0E4qlkSqeSQKb/XnCyMcJ0b1LuzA3mRgK5TM0S
	BU5lcC+ssB9Wocb0CW2cat6bfFXGRMWglDfInAZ4aqY4NZOySPaDtcx8C5TuoqyE
	9VSpE1xkHjMjPy7OWf8JApFkM0Vc3N5iezAhNgu0CtuyQt8exziyZkx1W4Usbq/g
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490ukec1cc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Sep 2025 09:36:51 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5896bO9a008428;
	Tue, 9 Sep 2025 09:36:50 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49109pjesr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Sep 2025 09:36:50 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5899aoX729950688
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Sep 2025 09:36:50 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3E1E65805D;
	Tue,  9 Sep 2025 09:36:50 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5E50658059;
	Tue,  9 Sep 2025 09:36:46 +0000 (GMT)
Received: from [9.43.86.190] (unknown [9.43.86.190])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  9 Sep 2025 09:36:46 +0000 (GMT)
Message-ID: <4a25f585-85be-4b58-99d3-9833bbeb4b3b@linux.ibm.com>
Date: Tue, 9 Sep 2025 15:06:44 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-6.18/block 08/10] blk-mq: fix potential deadlock while
 nr_requests grown
To: Yu Kuai <yukuai1@huaweicloud.com>, ming.lei@redhat.com, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com, johnny.chenyi@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20250908061533.3062917-1-yukuai1@huaweicloud.com>
 <20250908061533.3062917-9-yukuai1@huaweicloud.com>
 <484c552e-462f-488f-90bf-18fe5042f1bb@linux.ibm.com>
 <628d9525-dcef-2aaa-3434-64c7cdc0fb23@huaweicloud.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <628d9525-dcef-2aaa-3434-64c7cdc0fb23@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDE5NSBTYWx0ZWRfX+MmiihXJ6Pii
 OuI/Ug5hSYIiNR3V/yPPL3Jga4On2kDqgCJ2NNu4cT3fxbdJOglZg/Uz2EwJqeHWp3fzT94uiJ5
 zeTcujvDX3XKxyooAazZXbDsCvkkj8tEUxOC9/ido2GN3sFKc57iZTYbxF7/g68rFL444j1yZRw
 Ar/h1jo7GtiAiUWTTp3oSvCLhy4JH6lUmMF6hmxbbV4LtvrPObXmydbOx3Y99hfGRvsNV9Rs/nz
 JjlEpcDXpwbbYjVrtMQuAa3fwL750rH6gAfmZf9h5iU/xmSmwvGM1heXw1rfOLLlThzpfiD21vM
 3+Nt3znSxNxBcnn+TZnGiycK3fJ5kee+BfGNMQHJBxXuRXiOh5IUqVRfE2gQaV0fJMoiREp7bCP
 sGSfSAT+
X-Proofpoint-ORIG-GUID: ds7QzfiKxqKIxHU7mBFHI0TEFpRAtZQO
X-Proofpoint-GUID: ds7QzfiKxqKIxHU7mBFHI0TEFpRAtZQO
X-Authority-Analysis: v=2.4 cv=StCQ6OO0 c=1 sm=1 tr=0 ts=68bff533 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=i0EeH86SAAAA:8 a=CvrVc3EHEBBFqsY-YQIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_06,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 bulkscore=0 clxscore=1015 adultscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060195



On 9/9/25 1:07 PM, Yu Kuai wrote:
> Hi,
> 
> 在 2025/09/09 14:39, Nilay Shroff 写道:
>>
>>
>> On 9/8/25 11:45 AM, Yu Kuai wrote:
>>> From: Yu Kuai <yukuai3@huawei.com>
>>>
>>> Allocate and free sched_tags while queue is freezed can deadlock[1],
>>> this is a long term problem, hence allocate memory before freezing
>>> queue and free memory after queue is unfreezed.
>>>
>>> [1] https://lore.kernel.org/all/0659ea8d-a463-47c8-9180-43c719e106eb@linux.ibm.com/
>>> Fixes: e3a2b3f931f5 ("blk-mq: allow changing of queue depth through sysfs")
>>>
>>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>> [...]
>> [...]
>>
>>> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
>>> index 7ea15bf68b4b..a0a7ebad378f 100644
>>> --- a/block/blk-sysfs.c
>>> +++ b/block/blk-sysfs.c
>>> @@ -64,11 +64,12 @@ static ssize_t queue_requests_show(struct gendisk *disk, char *page)
>>>   static ssize_t
>>>   queue_requests_store(struct gendisk *disk, const char *page, size_t count)
>>>   {
>>> -    unsigned long nr;
>>> -    int ret, err;
>>> -    unsigned int memflags;
>>>       struct request_queue *q = disk->queue;
>>>       struct blk_mq_tag_set *set = q->tag_set;
>>> +    struct elevator_tags *et = NULL;
>>> +    unsigned int memflags;
>>> +    unsigned long nr;
>>> +    int ret;
>>>         ret = queue_var_store(&nr, page, count);
>>>       if (ret < 0)
>>> @@ -90,16 +91,24 @@ queue_requests_store(struct gendisk *disk, const char *page, size_t count)
>>>           goto unlock;
>>>       }
>>>   +    if (q->elevator && nr > q->elevator->et->nr_requests) {
>>> +        /* allocate memory before freezing queue to prevent deadlock */
>>> +        et = blk_mq_alloc_sched_tags(set, q->nr_hw_queues, nr);
>>> +        if (!et) {
>>> +            ret = -ENOMEM;
>>> +            goto unlock;
>>> +        }
>>> +    }
>>> +
>> I think we should add a comment above explaining why is it safe
>> to access q->elevator without holding ->elevator_lock.
>>
> 
> I already access q->elevator to check input nr from patch 4, and that's
> why I add comments to explain switching elevator is serialized, is this
> enough?
> 
yes in patch 04/10 you moved the ->elevator_lock after the 
usual sanity checks. However when we run those sanity checks
or the code in this patch where we have to access q->elevator,
it's good to add a comment here in the code (not in commit).
For reference, you may check blk_mq_alloc_sched_tags_batch.
I think similar comment may be added here as well.

Thanks,
--Nilay
