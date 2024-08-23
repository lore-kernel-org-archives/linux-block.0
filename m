Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E70C1EA71;
	Fri, 23 Aug 2024 13:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724421002; cv=none; b=B29awluULT9qajD5ApI3WqfnTX9Bw4Tm0xM57Mgt0vilBJK9kIyKZc17zYkbeswNyWtGOdKlyOH4hntprldqyZLwznRFSjJHW2IxvaFHzq6RUFNLA4LpjaHMU8g9PnwOUK+M8iFK1Cyux8+QwxzfucXu3YMcm8U0NRNj/znEO1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724421002; c=relaxed/simple;
	bh=k4rvCOfdpa/cQJJJHfpTU8bpKskfwdaDid0vcv43haY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VP5bOeCcSgP2sFS30JbbLrCnDxmYR+QbKUMYo51JOBNybGHuuDawPyCG8lWcLBRHZTWyJGAxe+M9bQIOg38tN5F0bC1I3OlhhiWJGEPASAIyk0SnwjlvcBLT/K59T6iXWs/oUQrZs0so2YYvpYGqj7nFk+xA9/tfRuqYio7DLE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nw6Xsnmh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nw6Xsnmh"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47NBFYXt030929;
	Fri, 23 Aug 2024 13:49:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	biT9ksv6sV8h7VGM7zpO4Z6vpU8PzWezN7Boxoy7F9o=; b=nw6XsnmhL097+PxU
	LrcXG4NzGDFBWI8dtwekaFPFbTR88VXeO2nggXS4oqgM5VfbykO+zZu2K3W8U58a
	jO8vZJe10MlVKxHIMMTpKQxQb0PgmMjwGqqCKBs/7VEV078CKgMcTVpiL95Xdbt4
	fUaq5IK2ymPBQoCJfMm5JO5bcOOE9kBH0h6c077ZnuF7WW3oHCvRAM8be5Oq8fDd
	zQiu9EOlw4oC+04b3wgc4Ct1IsFBx8aKiCIP5WQCRFulR1BrBbIkMF7OO9z83mKY
	21Stg2ygWrKD4+jI+JDXTN52FzYSzvrTryjK7+ERHWwkH/GAm+uACaKuMUUbajo0
	LP04Aw==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 415ck9fucp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Aug 2024 13:49:41 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47NDnewC017394
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Aug 2024 13:49:40 GMT
Received: from [10.216.54.20] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 23 Aug
 2024 06:49:34 -0700
Message-ID: <22d1bd64-934f-49f1-bb82-1367f4a43f40@quicinc.com>
Date: Fri, 23 Aug 2024 19:19:31 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Regarding patch "block/blk-mq: Don't complete locally if
 capacities are different"
Content-Language: en-US
To: Christian Loehle <christian.loehle@arm.com>,
        Bart Van Assche
	<bvanassche@acm.org>,
        Sandeep Dhavale <dhavale@google.com>,
        Dietmar Eggemann
	<dietmar.eggemann@arm.com>
CC: Qais Yousef <qyousef@layalina.io>, <axboe@kernel.dk>, <mingo@kernel.org>,
        <peterz@infradead.org>, <vincent.guittot@linaro.org>,
        <linux-block@vger.kernel.org>, <sudeep.holla@arm.com>,
        Jaegeuk Kim
	<jaegeuk@kernel.org>,
        Christoph Hellwig <hch@infradead.org>, <kailash@google.com>,
        <tkjos@google.com>, <bvanassche@google.com>,
        <quic_nitirawa@quicinc.com>, <quic_cang@quicinc.com>,
        <quic_rampraka@quicinc.com>, <quic_narepall@quicinc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <10c7f773-7afd-4409-b392-5d987a4024e4@quicinc.com>
 <3feb5226-7872-432b-9781-29903979d34a@arm.com>
 <20240805020748.d2tvt7c757hi24na@airbuntu>
 <25909f08-12a5-4625-839d-9e31df4c9c72@acm.org>
 <1d9c27b2-77c7-462f-bde9-1207f931ea9f@quicinc.com>
 <17bf99ad-d64d-40ef-864f-ce266d3024c7@acm.org>
 <e2c19f3a-13b0-4e88-ba44-7674f3a1ea87@quicinc.com>
 <c151b6d5-7e02-48ee-951f-c23594f6be6f@arm.com>
 <CAB=BE-RHwqmSRt-RbmuJ4j1bOFqv1DrYD9m-E1H99hYRnTiXLw@mail.gmail.com>
 <ca78ada8-d68b-4759-a068-ac8f66c51b72@quicinc.com>
 <12a6f001-813e-4bc4-90c2-9f9ef7dc72e6@acm.org>
 <688ead11-c1c0-48b2-b4d1-feeb1278c692@quicinc.com>
 <1a95a60c-730a-4bb7-80c9-98b8a70f6521@acm.org>
 <66912a22-540d-4b9a-bd06-cce55b9ad304@quicinc.com>
 <3d37e8ba-25a8-45c2-93a3-02888dad2c9e@arm.com>
From: MANISH PANDEY <quic_mapa@quicinc.com>
In-Reply-To: <3d37e8ba-25a8-45c2-93a3-02888dad2c9e@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: lCJmfioFxfOZff3RxZ71MYSmlPxwWsKI
X-Proofpoint-ORIG-GUID: lCJmfioFxfOZff3RxZ71MYSmlPxwWsKI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-23_10,2024-08-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 mlxlogscore=999
 suspectscore=0 mlxscore=0 spamscore=0 bulkscore=0 adultscore=0
 clxscore=1015 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408230101



On 8/23/2024 5:33 PM, Christian Loehle wrote:
> On 8/23/24 08:57, MANISH PANDEY wrote:
>>
>>
>> On 8/22/2024 7:54 PM, Bart Van Assche wrote:
>>> On 8/22/24 3:46 AM, MANISH PANDEY wrote:
>>>> On 8/21/2024 10:52 PM, Bart Van Assche wrote:
>>>>> What is the performance impact of the above change?
>>>   >
>>>> No impact at all
>>> Is this a good summary of this email thread?
>>> * The first email in this thread reports an important performance
>>>     regression.
>>> * In your previous email there is a candidate fix for the performance
>>>     regression.
>>> * Above I read that the proposed fix has no performance impact at all
>>>     on any setup.
>>>
>>> Is this a good summary of this email thread? If so, do you agree that
>>> this must be confusing everyone who is following this email thread?
>>>
>>> Thanks,
>>>
>>> Bart.
>>
>> Hi Bart,
>>
>> Performance impact due to addition of cpu capacity check (https://lore.kernel.org/all/20240223155749.2958009-3-qyousef@layalina.io/) ...[1]
>> is already mentioned in the first email.
>>
>> But let me summarize it again:
>>
>> We are not able to get advantage of affining the IRQ in different capacity CPU(s)/clusters and complete the request in higher cluster cpu(s), even though the LLC is shared between these clusters as it is causing the block completion to happen on SOFTIRQ context, if requester and completion clusters are different.
>>
>> Below is the performance impact with the current patch [1]
>>
>> 1. For MCQ capable UFS host (paired with UFS 4.x), we are observing ~20% random R/W performance drop.
>>
>> 2. For single doorbell ufs hosts (paired with UFS 2.x/ UFS 3.x), we are observing ~7-10% random R/W performance drop.
>>
> 
> If you do decide to write your proposal up as a patch, a description of the
> topology would be helpful as well.
> 
Thanks Christian for meaningful discussions and suggestions.
We would mention the same in the commit text description in the patch.

>>
>> Also in previous emails on this thread, below were few suggestions to add check for equal or greater capacity cpus by @Christian Loehle
>> https://lore.kernel.org/all/3feb5226-7872-432b-9781-29903979d34a@arm.com/
>>
>>> From: Christian Loehle @ 2024-08-02  9:03 UTC (permalink / raw)
>>> [......]
>>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>>> index e3c3c0c21b55..a4a2500c4ef6 100644
>>> --- a/block/blk-mq.c
>>> +++ b/block/blk-mq.c
>>> @@ -1164,7 +1164,7 @@ static inline bool
>>> blk_mq_complete_need_ipi(struct request *rq)
>>>          if (cpu == rq->mq_ctx->cpu ||
>>>              (!test_bit(QUEUE_FLAG_SAME_FORCE, &rq->q->queue_flags) &&
>>>               cpus_share_cache(cpu, rq->mq_ctx->cpu) &&
>>> -            cpus_equal_capacity(cpu, rq->mq_ctx->cpu)))
>>> +            arch_scale_cpu_capacity(cpu) >=
>>>                arch_scale_cpu_capacity(rq->mq_ctx->cpu)))
>>>                  return false;
>>>
>>>         /* don't try to IPI to an offline CPU */
>>
>>
>> There can be SoCs with different CPU cluster configurations and to have optimal IO load balancing or to avoid contention b/w submission path and completion path, we may need to complete IO request of large capacity CPU(s) on small cluster cpus. So the above propose solution may not be suffice to all the use cases.
>>
>> Hence with below proposed solution, we are trying to propose a new rq flag QUEUE_FLAG_CPU_CAPACITY. The proposed solution will provide us a way such that users who are benefited with CPU capacity check [1] would be able to use the fix as it is, and if a user (including us) want to bypass cpu capacity fix [1], they can set rq_affinity to 3 and would be able to retain performance drop as mentioned in first email. This would give flexibility to user to choose what's the best for their system.
>>
> 
> FWIW I'd agree with introducing a new queue_flag that behaves like
> QUEUE_FLAG_SAME_COMP before commit af550e4c9682 ("block/blk-mq: Don't complete locally if capacities are different").
> Equal capacity makes sense as the default behavior for
> QUEUE_FLAG_SAME_COMP, but is limiting, there might be just one
> CPU of that capacity and that might be fully utilized by submission
> (and related work), so completing locally makes sense.
> 
> So QUEUE_FLAG_SAME_COMP I'd leave as-is and introduce
> QUEUE_FLAG_SAME_LLC that actually just checks LLC.
> 
> Regards,
> Christian
> 

Hi Christian,
while making the patch, i figured out that queue_flags is unsigned long 
type and we already reached up to 32 flags as of now.

So we need to figure out some other way.
Please let us know if you have some suggestions for the solution, which 
can provide flexibility of with and without cpu capacity check.


Regards
Manish

