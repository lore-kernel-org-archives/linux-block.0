Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE3A61FCF;
	Tue, 13 Aug 2024 16:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723566034; cv=none; b=o7kVVteOmXVfV6aF0O9WknzbY/8fotOQOxN8OEpBmwK30bHUPILY2/O8BPvFVVPC59ti8TRYd7Wl2SEMnqvUkSaklRFsUn1joAKjgDkQhEV9vwqTvR44Vnz8GoXlPQ1YA9exveJ/RB6ZGOZwzUOAIsEgfY+3mU8wfOHWAClldf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723566034; c=relaxed/simple;
	bh=rUjKakylGmaur9CYp1scGQ8kw8n7K7iDDZ1hQtQBJQo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HN7bCbuprxVb1AIdqWvWosi9yP4+5NfxK+an8srRpFLXQVNchX9yhstQDt9I55Fg4wCrUvqhe8O7OZN31SYjAX5TmIaktmpYgY4/uey1GZrIYzqicM5e+9qMDczgEfGyMIHiOkeKRkN7IeuY1SmiqUeSS/Luf1/UAePJ9Jy/5ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6304F12FC;
	Tue, 13 Aug 2024 09:20:57 -0700 (PDT)
Received: from [10.57.84.20] (unknown [10.57.84.20])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 178B53F6A8;
	Tue, 13 Aug 2024 09:20:26 -0700 (PDT)
Message-ID: <a225f9e0-5335-4c58-8e94-960c2557f9c0@arm.com>
Date: Tue, 13 Aug 2024 17:20:25 +0100
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
 <e5f0349e-6c72-4847-bf0c-4afb57404907@arm.com>
 <20240809002321.3k5g2isqmiuflrmd@airbuntu>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20240809002321.3k5g2isqmiuflrmd@airbuntu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/9/24 01:23, Qais Yousef wrote:
> On 08/05/24 11:18, Christian Loehle wrote:
> 
>>> My understanding of rq_affinity=1 is to match the perf of requester. Given that
>>> the characteristic of HMP system is that power has an equal importance to perf
>>> (I think this now has become true for all systems by the way), saying that the
>>> match in one direction is better than the other is sort of forcing a policy of
>>> perf first which I don't think is a good thing to enforce. We don't have enough
>>> info to decide at this level. And our users care about both.
>>
>> I would argue rq_affinity=1 matches the perf, so that flag should already bias
>> perf in favor of power slightly?
> 
> Not on this type of systems. If perf was the only thing important, just use
> equally big cpus. Balancing perf and power is important on those systems, and
> I don't think we have enough info to decide which decision is best when
> capacities are not the same. Matching the perf level the requesting on makes
> sense when irq_affinity=1.

Well you could still want a
"IO performance always beats power considerations" and still go HMP because
sometimes for non-IO you prefer power, but I agree that we don't have enough
information about what the user wants from the system/kernel.

> 
>> Although the actual effect on power probably isn't that significant, given
>> that the (e.g. big) CPU has submitted the IO, is woken up soon, so you could
>> almost ignore a potential idle wakeup and the actual CPU time spent in the block
>> completion is pretty short of course.
>>
>>> If no matching is required, it makes sense to set rq_affinity to 0. When
>>> matching is enabled, we need to rely on per-task iowait boost to help the
>>> requester to run at a bigger CPU, and naturally the completion will follow when
>>> rq_affinity=1. If the requester doesn't need the big perf, but the irq
>>> triggered on a bigger core, I struggle to understand why it is good for
>>> completion to run on bigger core without the requester also being on a similar
>>> bigger core to truly maximize perf.
>>
>> So first of all, per-task iowait boosting has nothing to do with it IMO.
> 
> It has. If the perf is not good because the requester is running on little
> core, the requester need to move up to ensure the overall IO perf is better.

See below but also
"the requester need to move up to ensure the overall IO perf is better" is
just not true, with asynchronous IO submission done right, the submission
runtime isn't critical to the IO throughput, therefore it should run the
most power-efficient way.
This can be observed e.g. with any io_uring fio workload with significant
iodepth (and possibly multi-threading).
Completion may be a different story, depending on the device stack, if we're
dealing with !MCQ then the completion path (irq + block layer completion)
is absolutely critical.
For any mmc / ufs<4.0 system the performance difference between
fio --name=little --filename=/dev/sda --runtime=10 --rw=randread --bs=4k --ioengine=io_uring --numjobs=4 --iodepth=32 --group_reporting --cpus_allowed=$LITTLE_CPUS
and
fio --name=big --filename=/dev/sda --runtime=10 --rw=randread --bs=4k --ioengine=io_uring --numjobs=4 --iodepth=32 --group_reporting --cpus_allowed=$BIG_CPUS
is (usually) only because of the completion path and setting irq affinity of
/dev/sda to $BIG_CPUS will make the difference disappear (rq_affinity=0 and
implying LLC is the same).
Running the submission on little CPUs will usually be the most power-efficient
way then.

> 
>> Plenty of IO workloads build up utilization perfectly fine.
> 
> These ones have no problems, no? They should migrate to big core and the
> completion will follow them when they move.

So if I understood Manish correctly the only reason they want the completion
to run on a bigger CPU than the submission is because the submission is already
saturating the CPU, therefore utilization of submission is no issue whatsoever.
They don't want to run (submission) on big though because of power
considerations.

> 
>> I wouldn't consider the setup: requester little perf, irq+completion big perf
>> invalid necessarily, it does decrease IO latency for the application.
> 
> I didn't say invalid. But it is not something we can guess automatically when
> irq_affinity=1. We don't have enough info to judge. The only info we have the
> requester that originated the request is running at different perf level
> (whther higher or lower), so we follow it.
>
Anyway, Manish's problem should be solved by rq_affinity=0 in that case (with
irq affinities set to big CPU then the completion will be run on the irq CPU)
and "rq_affinity=1 <=> equal capacity CPU" is the correct interpretation, is that
more or less agreed upon now?

