Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD1115E5BD;
	Mon,  5 Aug 2024 17:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722878742; cv=none; b=lXaGSZQvnFtP4L9PbweBd7A7d2DOVNfdNn9lCztfd8JJHM7qcakT0+TOdbW9CL7PzZioSNtuyseIK3rwIAlIDhxZeERoHQjXEv4RJDiotqy5c35nOwK+AVmiG/zHql8y4+B3Wwll2fmD4GuHjYNiueldC4L2UFmcMEixclW11ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722878742; c=relaxed/simple;
	bh=nMsUvROW5o2JQv8z5zInMNojpTAXsecbr7SW67x3dSk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=e2d2epyxV+IMseaoAOYTA1zzzh/DgNx+48P9eRrMME8EkCR8KETEN++iw4hzYSAurA3rgzE7KpzLJY6Z+g5NZyDFoZqoNFg/PcwbvNrKVKxS4ak57O5Ek2jcvGWRY4UHa2ZjT3JzZXskp7b56ochlkaKBOk2OcaULqlgeSG7NrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mNVqft9u; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mNVqft9u"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 475BXxLm012124;
	Mon, 5 Aug 2024 17:24:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	27o1Eku60YMcAZmJ3UBpyS9H3eYL1dpEeF6V9d/0MNs=; b=mNVqft9uccq75KIF
	AANxHqFHYHL1qD2/3H5xzGfuAHmV0GUyLLrE9kA4Y9yjAtMnwN+Jfw7z4dh5u5X5
	TV50CjFNqIIuNZC9lQ2bwaKJKEJlBTAuXfR5ie7J82XRP+KumiGrA0mJudItAYFi
	m31F1eTtINrby3SXJkQ1ZeVBmcaM3Z3I6s2m2o3QE8/yd0mHw3pE6F0i6r+Rz3Zn
	dj6I0au6qNJe6HIG6FUlM/xzkU9eM2aNhnzhN/1jfVhfjKfpBq/D07KdH3YjmtfI
	Do4VCYlFR/7Z22kvELjTUSHt7zwCVpgEc/jI9vvWwcbmSFzhN+Om9ijTizBhwsl+
	21IlIQ==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40scx6mtj1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Aug 2024 17:24:12 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 475HOBUP028644
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 5 Aug 2024 17:24:11 GMT
Received: from [10.216.59.226] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 5 Aug 2024
 10:24:04 -0700
Message-ID: <aabce4b6-2d3d-45a9-8f75-b1a6b3ede6f3@quicinc.com>
Date: Mon, 5 Aug 2024 22:54:01 +0530
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
        Qais Yousef
	<qyousef@layalina.io>
CC: <axboe@kernel.dk>, <mingo@kernel.org>, <peterz@infradead.org>,
        <vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
        <linux-block@vger.kernel.org>, <sudeep.holla@arm.com>,
        Jaegeuk Kim
	<jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig
	<hch@infradead.org>, <kailash@google.com>,
        <tkjos@google.com>, <dhavale@google.com>, <bvanassche@google.com>,
        <quic_nitirawa@quicinc.com>, <quic_cang@quicinc.com>,
        <quic_rampraka@quicinc.com>, <quic_narepall@quicinc.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
References: <10c7f773-7afd-4409-b392-5d987a4024e4@quicinc.com>
 <3feb5226-7872-432b-9781-29903979d34a@arm.com>
 <20240805020748.d2tvt7c757hi24na@airbuntu>
 <e5f0349e-6c72-4847-bf0c-4afb57404907@arm.com>
From: MANISH PANDEY <quic_mapa@quicinc.com>
In-Reply-To: <e5f0349e-6c72-4847-bf0c-4afb57404907@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: nBj4hvlPiKoeh5tp6HLZE0Q8KdxesPMp
X-Proofpoint-GUID: nBj4hvlPiKoeh5tp6HLZE0Q8KdxesPMp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-05_06,2024-08-02_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 bulkscore=0 clxscore=1011 suspectscore=0 phishscore=0
 spamscore=0 adultscore=0 lowpriorityscore=0 mlxscore=0 priorityscore=1501
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408050125



On 8/5/2024 3:48 PM, Christian Loehle wrote:
> Sorry, I didn't include linux-kernel, so my and Qais' reply that is missing
> is quoted here in full. You can also find it here:
> https://lore.kernel.org/all/d2009fca-57db-49e6-a874-e8291c3e27f5@quicinc.com/T/#m2f5195487d2e3ad0c0b6fc68f9967704c7aa4a70
> 
> On 8/5/24 03:07, Qais Yousef wrote:
>> On 08/02/24 10:03, Christian Loehle wrote:
>>> On 7/31/24 14:46, MANISH PANDEY wrote:
>>>> Hi Qais Yousef,
>>>
>>> Qais already asked the important question, still some from my end.
>>>
>>>> Recently we observed below patch has been merged
>>>> https://lore.kernel.org/all/20240223155749.2958009-3-qyousef@layalina.io
>>>>
>>>> This patch is causing performance degradation ~20% in Random IO along with significant drop in Sequential IO performance. So we would like to revert this patch as it impacts MCQ UFS devices heavily. Though Non MCQ devices are also getting impacted due to this.
>>>
>>> I'm curious about the sequential IO part in particular, what's the blocksize and throughput?
>>> If blocksize is large enough the completion and submission parts are hopefully not as critical.
>>>
>>>>
>>>> We have several concerns with the patch
>>>> 1. This patch takes away the luxury of affining best possible cpus from   device drivers and limits driver to fall in same group of CPUs.
>>>>
>>>> 2. Why can't device driver use irq affinity to use desired CPUs to complete the IO request, instead of forcing it from block layer.
>>>>
>>>> 3. Already CPUs are grouped based on LLC, then if a new categorization is required ?
>>>
>>> As Qais hinted at, because of systems that share LLC on all CPUs but are HMP.
>>>
>>>>
>>>>> big performance impact if the IO request
>>>>> was done from a CPU with higher capacity but the interrupt is serviced
>>>>> on a lower capacity CPU.
>>>>
>>>> This patch doesn't considers the issue of contention in submission path and completion path. Also what if we want to complete the request of smaller capacity CPU to Higher capacity CPU?
>>>> Shouldn't a device driver take care of this and allow the vendors to use the best possible combination they want to use?
>>>> Does it considers MCQ devices and different SQ<->CQ mappings?
>>>
>>> So I'm assuming you're seeing something like the following:
>>> Some CPU(s) (call them S) are submitting IO, hardirq triggers on
>>> S.
>>> Before the patch the completion softirq could run on a !S CPU,
>>> now it runs on S. Am I then correct in assuming your workload
>>> is CPU-bound on S? Would you share some details about the
>>> workload, too?
>>>
I would like to share details with example:
Say in SoC we have 3 clusters S(small), M(Medium) and L(large) and all 
three clusters shares L3 as LLC.
Say on UFS with MCQ, most of the submission would be done from M 
clusters. So SQ's CPUs would be mostly bounded to M clusters. Now if we 
assign ESI IRQ for CQ on same M cluster cpu, these CPU's gets overloaded 
with SQ and IRQ bounded with that CQ ( IRQn <->CQn). So we intentionally 
want to affine IRQn <-> CQn on large clusters as LLC is shared, so we 
don't need IPI.
Earlier below code was working like blk_mq_complete_need_ipi() returning 
false and hence blk_mq_complete_request() returs false. Thus we complete 
CQ of M clusters on L clusters CPU in HardIRQ context and get better 
Perf numbers.

blk_mq_complete_need_ipi()
	/* same CPU or cache domain and capacity?  Complete locally */
	if (cpu == rq->mq_ctx->cpu ||
	    (!test_bit(QUEUE_FLAG_SAME_FORCE, &rq->q->queue_flags) &&
	     cpus_share_cache(cpu, rq->mq_ctx->cpu))
		return false;

void blk_mq_complete_request(struct request *rq)
{
	if (!blk_mq_complete_request_remote(rq))  --> true,
		rq->q->mq_ops->complete(rq);   --> execute here
}

But now with addition of cpus_equal_capacity(cpu, rq->mq_ctx->cpu)
blk_mq_complete_need_ipi() would try for IPI. Further 
blk_mq_complete_request_remote() would be true and hence
__blk_mq_complete_request_remote() would complete the request in SOFTIRQ 
context, which would cause low performance due to context switching.


>>> What's the capacity of CPU(s) S then?
>>> IOW does this help?
>>>
>>> -->8--
>>>
>>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>>> index e3c3c0c21b55..a4a2500c4ef6 100644
>>> --- a/block/blk-mq.c
>>> +++ b/block/blk-mq.c
>>> @@ -1164,7 +1164,7 @@ static inline bool blk_mq_complete_need_ipi(struct request *rq)
>>>          if (cpu == rq->mq_ctx->cpu ||
>>>              (!test_bit(QUEUE_FLAG_SAME_FORCE, &rq->q->queue_flags) &&
>>>               cpus_share_cache(cpu, rq->mq_ctx->cpu) &&
>>> -            cpus_equal_capacity(cpu, rq->mq_ctx->cpu)))
>>> +            arch_scale_cpu_capacity(cpu) >= arch_scale_cpu_capacity(rq->mq_ctx->cpu)))
>>>                  return false;
>>>   
>>>          /* don't try to IPI to an offline CPU */
>>
>> FWIW, that's what I had in the first version of the patch, but moved away from
>> it. I think this will constitute a policy.
>>
>> Keep in mind that driver setting affinity like Manish case is not something
>> represent a kernel driver as I don't anticipate in-kernel driver to hardcode
>> affinities otherwise they won't be portable. irqbalancers usually move the
>> interrupts, and I'm not sure we can make an assumption about the reason an
>> interrupt is triggering on different capacity CPU.
>
> FWIW that patch was mostly to narrow down the problem Manish is experiencing, I
> wasn't proposing it as a proper patch.
> 
>> My understanding of rq_affinity=1 is to match the perf of requester. Given that
>> the characteristic of HMP system is that power has an equal importance to perf
>> (I think this now has become true for all systems by the way), saying that the
>> match in one direction is better than the other is sort of forcing a policy of
>> perf first which I don't think is a good thing to enforce. We don't have enough
>> info to decide at this level. And our users care about both.
> 
> I would argue rq_affinity=1 matches the perf, so that flag should already bias
> perf in favor of power slightly?
> Although the actual effect on power probably isn't that significant, given
> that the (e.g. big) CPU has submitted the IO, is woken up soon, so you could
> almost ignore a potential idle wakeup and the actual CPU time spent in the block
> completion is pretty short of course.
> 
>> If no matching is required, it makes sense to set rq_affinity to 0. When
>> matching is enabled, we need to rely on per-task iowait boost to help the
>> requester to run at a bigger CPU, and naturally the completion will follow when
>> rq_affinity=1. If the requester doesn't need the big perf, but the irq
>> triggered on a bigger core, I struggle to understand why it is good for
>> completion to run on bigger core without the requester also being on a similar
>> bigger core to truly maximize perf.
> 
Not all the SoCs implements L3 as shared LLC. There are SoCs with L2 as 
LLC and not shared among all CPU clusters. So in this case, if we use 
rq=0, this would force to use a CPU, which doesn't shares L2 cache.
Say in a system cpu[0-5] shares L2 as LLC and cpu[6-7] shares L2 as LLC, 
then any request from CPU[0-5] / CPU[6-7] would force to serve IRQ on 
CPUs which actually doesn't shares cache, would would result low 
performance.


> So first of all, per-task iowait boosting has nothing to do with it IMO.
> Plenty of IO workloads build up utilization perfectly fine.
> I wouldn't consider the setup: requester little perf, irq+completion big perf
> invalid necessarily, it does decrease IO latency for the application.
> Consider the IO being page faults (maybe even of various applications running
> on little).
> 
>>
>> By the way, if we assume LLC wasn't the same, then assuming HMP system too, and
>> reverting my patch, then the behavior was to move the completion from bigger
>> core to little core.
>>
>> So two things to observe:
>>
>> 1. The patch keeps the behavior when LLC truly is not shared on such systems,
>>     which was in the past.
>> 2. LLC in this case is most likely L2, and the usual trend is that the bigger
>>     the core the bigger L2. So the LLC characteristic is different and could
>>     have impacted performance. No one seem to have cared in the past. I think
>>     capacity gives this notion now implicitly.
> 

So basically the change enforces to use SOFTIRQs for completing the IO 
requests, which could have been completed in HardIRQ context itself and 
this affects more to MCQ devices.

For Non MCQ devices, there is a case,where we can can use Low capacity 
CPUs for completing the request (handling IRQs on S CPUs) to save Power 
and avoiding wakeup of all CPUs of same capacity in order to submit and 
complete the IO requests.
