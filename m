Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C58E184527;
	Fri, 23 Aug 2024 12:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724414589; cv=none; b=LvPucH1SpGvWi3zs0+HbYsCiSLQssjQT7w4dAVcQtWHoK+zbLnnUUJsYG6ZKyx3fmiSGsfPYGfbGEC5DVLYl0Kk2nD3FB94iIxlzXmAPzYk81l+hAy9pzwVgraCWTSkEvFfDzHNC+PcjhX5qrp2Ue/SJGnPh9TDaWInweosZF0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724414589; c=relaxed/simple;
	bh=hdHVAvPt7f0rZ3mUsNU7oNL1zeQ26mFD/AaIfLTMBu8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ebHyaDhv4luvSZQF56+gcq8paVQhEwYewv8QK35PgcFxTvnCtA12b3ZvFmu04DfXvDyG3yCIdqnej56u0bUtUbA5TLF/CnxxKNY8KdJ76nRiOmdQZxs1CpikBBJR+T7a7nVHnkRk0ttXrorYllnSN96Lbiiqv5iWFDfDrTM44e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A9ABEDA7;
	Fri, 23 Aug 2024 05:03:32 -0700 (PDT)
Received: from [10.57.47.154] (unknown [10.57.47.154])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9042A3F66E;
	Fri, 23 Aug 2024 05:03:02 -0700 (PDT)
Message-ID: <3d37e8ba-25a8-45c2-93a3-02888dad2c9e@arm.com>
Date: Fri, 23 Aug 2024 13:03:00 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Regarding patch "block/blk-mq: Don't complete locally if
 capacities are different"
To: MANISH PANDEY <quic_mapa@quicinc.com>,
 Bart Van Assche <bvanassche@acm.org>, Sandeep Dhavale <dhavale@google.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Qais Yousef <qyousef@layalina.io>, axboe@kernel.dk, mingo@kernel.org,
 peterz@infradead.org, vincent.guittot@linaro.org,
 linux-block@vger.kernel.org, sudeep.holla@arm.com,
 Jaegeuk Kim <jaegeuk@kernel.org>, Christoph Hellwig <hch@infradead.org>,
 kailash@google.com, tkjos@google.com, bvanassche@google.com,
 quic_nitirawa@quicinc.com, quic_cang@quicinc.com, quic_rampraka@quicinc.com,
 quic_narepall@quicinc.com,
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
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <66912a22-540d-4b9a-bd06-cce55b9ad304@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/23/24 08:57, MANISH PANDEY wrote:
> 
> 
> On 8/22/2024 7:54 PM, Bart Van Assche wrote:
>> On 8/22/24 3:46 AM, MANISH PANDEY wrote:
>>> On 8/21/2024 10:52 PM, Bart Van Assche wrote:
>>> > What is the performance impact of the above change?
>>  >
>>> No impact at all
>> Is this a good summary of this email thread?
>> * The first email in this thread reports an important performance
>>    regression.
>> * In your previous email there is a candidate fix for the performance
>>    regression.
>> * Above I read that the proposed fix has no performance impact at all
>>    on any setup.
>>
>> Is this a good summary of this email thread? If so, do you agree that
>> this must be confusing everyone who is following this email thread?
>>
>> Thanks,
>>
>> Bart.
> 
> Hi Bart,
> 
> Performance impact due to addition of cpu capacity check (https://lore.kernel.org/all/20240223155749.2958009-3-qyousef@layalina.io/) ...[1]
> is already mentioned in the first email.
> 
> But let me summarize it again:
> 
> We are not able to get advantage of affining the IRQ in different capacity CPU(s)/clusters and complete the request in higher cluster cpu(s), even though the LLC is shared between these clusters as it is causing the block completion to happen on SOFTIRQ context, if requester and completion clusters are different.
> 
> Below is the performance impact with the current patch [1]
> 
> 1. For MCQ capable UFS host (paired with UFS 4.x), we are observing ~20% random R/W performance drop.
> 
> 2. For single doorbell ufs hosts (paired with UFS 2.x/ UFS 3.x), we are observing ~7-10% random R/W performance drop.
> 

If you do decide to write your proposal up as a patch, a description of the
topology would be helpful as well.

> 
> Also in previous emails on this thread, below were few suggestions to add check for equal or greater capacity cpus by @Christian Loehle
> https://lore.kernel.org/all/3feb5226-7872-432b-9781-29903979d34a@arm.com/
> 
>> From: Christian Loehle @ 2024-08-02  9:03 UTC (permalink / raw)
>> [......]
>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>> index e3c3c0c21b55..a4a2500c4ef6 100644
>> --- a/block/blk-mq.c
>> +++ b/block/blk-mq.c
>> @@ -1164,7 +1164,7 @@ static inline bool
>> blk_mq_complete_need_ipi(struct request *rq)
>>        if (cpu == rq->mq_ctx->cpu ||
>>            (!test_bit(QUEUE_FLAG_SAME_FORCE, &rq->q->queue_flags) &&
>>             cpus_share_cache(cpu, rq->mq_ctx->cpu) &&
>> -            cpus_equal_capacity(cpu, rq->mq_ctx->cpu)))
>> +            arch_scale_cpu_capacity(cpu) >=
>>              arch_scale_cpu_capacity(rq->mq_ctx->cpu)))
>>                return false;
>>
>>       /* don't try to IPI to an offline CPU */
> 
> 
> There can be SoCs with different CPU cluster configurations and to have optimal IO load balancing or to avoid contention b/w submission path and completion path, we may need to complete IO request of large capacity CPU(s) on small cluster cpus. So the above propose solution may not be suffice to all the use cases.
> 
> Hence with below proposed solution, we are trying to propose a new rq flag QUEUE_FLAG_CPU_CAPACITY. The proposed solution will provide us a way such that users who are benefited with CPU capacity check [1] would be able to use the fix as it is, and if a user (including us) want to bypass cpu capacity fix [1], they can set rq_affinity to 3 and would be able to retain performance drop as mentioned in first email. This would give flexibility to user to choose what's the best for their system.
>

FWIW I'd agree with introducing a new queue_flag that behaves like
QUEUE_FLAG_SAME_COMP before commit af550e4c9682 ("block/blk-mq: Don't complete locally if capacities are different").
Equal capacity makes sense as the default behavior for
QUEUE_FLAG_SAME_COMP, but is limiting, there might be just one
CPU of that capacity and that might be fully utilized by submission
(and related work), so completing locally makes sense.

So QUEUE_FLAG_SAME_COMP I'd leave as-is and introduce
QUEUE_FLAG_SAME_LLC that actually just checks LLC.

Regards,
Christian

