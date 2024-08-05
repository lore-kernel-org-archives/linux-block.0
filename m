Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A6018040;
	Mon,  5 Aug 2024 10:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722853110; cv=none; b=AcoMlhb4nfD6LszRS+r1N9t6BL6nXLQQ7YXNEgrletViqcPNuYHA5kaaNIRrzH5qRNKL6wswKIt/TSVpAZ2DKW+4OdXRn2Bryr8/TanpHAIR/dt/wpWagL5GwUoZk8Tc6CylfgpKSyq79X71sxi9Q0j9E+f6JdBpumtPaMANy6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722853110; c=relaxed/simple;
	bh=EJldXRMJVn3095IzSNVAin6hrSMalMe/S3EmCvh6qvM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=emHg0/Sx6IzZ9kbjzjX8yvCGJgWAFJtLQvGwTMxnKfGNdVhjvdP3SIHI0SD+CTXAyNxhz3cL07RYnnYorCsy/TQ/J0eUbCORzTmn0QxgrzIRRtz64Dg3qpOMwRMakdiGaCpmI2thfJyLy+ZQmpIrOvmEMZ9N39K6eQmdCIy+f/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6D60B143D;
	Mon,  5 Aug 2024 03:18:51 -0700 (PDT)
Received: from [10.57.66.48] (unknown [10.57.66.48])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 785553F5A1;
	Mon,  5 Aug 2024 03:18:21 -0700 (PDT)
Message-ID: <e5f0349e-6c72-4847-bf0c-4afb57404907@arm.com>
Date: Mon, 5 Aug 2024 11:18:19 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Regarding patch "block/blk-mq: Don't complete locally if
 capacities are different"
To: Qais Yousef <qyousef@layalina.io>
Cc: MANISH PANDEY <quic_mapa@quicinc.com>, axboe@kernel.dk, mingo@kernel.org,
 peterz@infradead.org, vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
 linux-block@vger.kernel.org, sudeep.holla@arm.com,
 Jaegeuk Kim <jaegeuk@kernel.org>, Bart Van Assche <bvanassche@acm.org>,
 Christoph Hellwig <hch@infradead.org>, kailash@google.com, tkjos@google.com,
 dhavale@google.com, bvanassche@google.com, quic_nitirawa@quicinc.com,
 quic_cang@quicinc.com, quic_rampraka@quicinc.com, quic_narepall@quicinc.com,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <10c7f773-7afd-4409-b392-5d987a4024e4@quicinc.com>
 <3feb5226-7872-432b-9781-29903979d34a@arm.com>
 <20240805020748.d2tvt7c757hi24na@airbuntu>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20240805020748.d2tvt7c757hi24na@airbuntu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Sorry, I didn't include linux-kernel, so my and Qais' reply that is missing
is quoted here in full. You can also find it here:
https://lore.kernel.org/all/d2009fca-57db-49e6-a874-e8291c3e27f5@quicinc.com/T/#m2f5195487d2e3ad0c0b6fc68f9967704c7aa4a70

On 8/5/24 03:07, Qais Yousef wrote:
> On 08/02/24 10:03, Christian Loehle wrote:
>> On 7/31/24 14:46, MANISH PANDEY wrote:
>>> Hi Qais Yousef,
>>
>> Qais already asked the important question, still some from my end.
>>
>>> Recently we observed below patch has been merged
>>> https://lore.kernel.org/all/20240223155749.2958009-3-qyousef@layalina.io
>>>
>>> This patch is causing performance degradation ~20% in Random IO along with significant drop in Sequential IO performance. So we would like to revert this patch as it impacts MCQ UFS devices heavily. Though Non MCQ devices are also getting impacted due to this.
>>
>> I'm curious about the sequential IO part in particular, what's the blocksize and throughput?
>> If blocksize is large enough the completion and submission parts are hopefully not as critical.
>>
>>>
>>> We have several concerns with the patch
>>> 1. This patch takes away the luxury of affining best possible cpus from   device drivers and limits driver to fall in same group of CPUs.
>>>
>>> 2. Why can't device driver use irq affinity to use desired CPUs to complete the IO request, instead of forcing it from block layer.
>>>
>>> 3. Already CPUs are grouped based on LLC, then if a new categorization is required ?
>>
>> As Qais hinted at, because of systems that share LLC on all CPUs but are HMP.
>>
>>>
>>>> big performance impact if the IO request
>>>> was done from a CPU with higher capacity but the interrupt is serviced
>>>> on a lower capacity CPU.
>>>
>>> This patch doesn't considers the issue of contention in submission path and completion path. Also what if we want to complete the request of smaller capacity CPU to Higher capacity CPU?
>>> Shouldn't a device driver take care of this and allow the vendors to use the best possible combination they want to use?
>>> Does it considers MCQ devices and different SQ<->CQ mappings?
>>
>> So I'm assuming you're seeing something like the following:
>> Some CPU(s) (call them S) are submitting IO, hardirq triggers on
>> S.
>> Before the patch the completion softirq could run on a !S CPU,
>> now it runs on S. Am I then correct in assuming your workload
>> is CPU-bound on S? Would you share some details about the
>> workload, too?
>>
>> What's the capacity of CPU(s) S then?
>> IOW does this help?
>>
>> -->8--
>>
>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>> index e3c3c0c21b55..a4a2500c4ef6 100644
>> --- a/block/blk-mq.c
>> +++ b/block/blk-mq.c
>> @@ -1164,7 +1164,7 @@ static inline bool blk_mq_complete_need_ipi(struct request *rq)
>>         if (cpu == rq->mq_ctx->cpu ||
>>             (!test_bit(QUEUE_FLAG_SAME_FORCE, &rq->q->queue_flags) &&
>>              cpus_share_cache(cpu, rq->mq_ctx->cpu) &&
>> -            cpus_equal_capacity(cpu, rq->mq_ctx->cpu)))
>> +            arch_scale_cpu_capacity(cpu) >= arch_scale_cpu_capacity(rq->mq_ctx->cpu)))
>>                 return false;
>>  
>>         /* don't try to IPI to an offline CPU */
> 
> FWIW, that's what I had in the first version of the patch, but moved away from
> it. I think this will constitute a policy.
> 
> Keep in mind that driver setting affinity like Manish case is not something
> represent a kernel driver as I don't anticipate in-kernel driver to hardcode
> affinities otherwise they won't be portable. irqbalancers usually move the
> interrupts, and I'm not sure we can make an assumption about the reason an
> interrupt is triggering on different capacity CPU.

FWIW that patch was mostly to narrow down the problem Manish is experiencing, I
wasn't proposing it as a proper patch.

> My understanding of rq_affinity=1 is to match the perf of requester. Given that
> the characteristic of HMP system is that power has an equal importance to perf
> (I think this now has become true for all systems by the way), saying that the
> match in one direction is better than the other is sort of forcing a policy of
> perf first which I don't think is a good thing to enforce. We don't have enough
> info to decide at this level. And our users care about both.

I would argue rq_affinity=1 matches the perf, so that flag should already bias
perf in favor of power slightly?
Although the actual effect on power probably isn't that significant, given
that the (e.g. big) CPU has submitted the IO, is woken up soon, so you could
almost ignore a potential idle wakeup and the actual CPU time spent in the block
completion is pretty short of course.

> If no matching is required, it makes sense to set rq_affinity to 0. When
> matching is enabled, we need to rely on per-task iowait boost to help the
> requester to run at a bigger CPU, and naturally the completion will follow when
> rq_affinity=1. If the requester doesn't need the big perf, but the irq
> triggered on a bigger core, I struggle to understand why it is good for
> completion to run on bigger core without the requester also being on a similar
> bigger core to truly maximize perf.

So first of all, per-task iowait boosting has nothing to do with it IMO.
Plenty of IO workloads build up utilization perfectly fine.
I wouldn't consider the setup: requester little perf, irq+completion big perf
invalid necessarily, it does decrease IO latency for the application.
Consider the IO being page faults (maybe even of various applications running
on little).

> 
> By the way, if we assume LLC wasn't the same, then assuming HMP system too, and
> reverting my patch, then the behavior was to move the completion from bigger
> core to little core.
> 
> So two things to observe:
> 
> 1. The patch keeps the behavior when LLC truly is not shared on such systems,
>    which was in the past.
> 2. LLC in this case is most likely L2, and the usual trend is that the bigger
>    the core the bigger L2. So the LLC characteristic is different and could
>    have impacted performance. No one seem to have cared in the past. I think
>    capacity gives this notion now implicitly.

