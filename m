Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 760321D2780
	for <linux-block@vger.kernel.org>; Fri,  2 Aug 2024 09:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722589404; cv=none; b=FP6YItfNq2AkAPT8rCPC807njfQpDQHcMqlPIQW86l3dGXU4NS/bhMm9BGb5aXXoda3t6s2AfSlgimR63T826E9I9yedKRYIiJtwhpXYjeKzVd9UNV5W5IMUjgh6cUb8LsAsK/lXqPS5XDklV7ogkfuU7YjIFYZ+gArXlrFJsy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722589404; c=relaxed/simple;
	bh=dTy6B+aMgjJXgKWZZpJo0RGO1lPj5Et0DkE0K0v6DIk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LSwBKxifBXanKhcsNlwZ8r7Aw9oEURI+X2k9anA6vFCMk9cKJ9QRX0EZIyMyyiR8lufqVIKP2Xz4G5pL/qPjVu6bam3ZPa+DLlu/HF7iuYspiW6K4Em44EcWNvg2ExDsniZ0uaxv6umJ7z79oVSyLk4lmq5dGe7f4GWhfqtnJdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5AA3A1007;
	Fri,  2 Aug 2024 02:03:47 -0700 (PDT)
Received: from [10.1.33.26] (e127648.arm.com [10.1.33.26])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D3DD73F766;
	Fri,  2 Aug 2024 02:03:17 -0700 (PDT)
Message-ID: <3feb5226-7872-432b-9781-29903979d34a@arm.com>
Date: Fri, 2 Aug 2024 10:03:16 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Regarding patch "block/blk-mq: Don't complete locally if
 capacities are different"
To: MANISH PANDEY <quic_mapa@quicinc.com>, qyousef@layalina.io
Cc: axboe@kernel.dk, mingo@kernel.org, peterz@infradead.org,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
 linux-block@vger.kernel.org, sudeep.holla@arm.com,
 Jaegeuk Kim <jaegeuk@kernel.org>, Bart Van Assche <bvanassche@acm.org>,
 Christoph Hellwig <hch@infradead.org>, kailash@google.com, tkjos@google.com,
 dhavale@google.com, bvanassche@google.com, quic_nitirawa@quicinc.com,
 quic_cang@quicinc.com, quic_rampraka@quicinc.com, quic_narepall@quicinc.com
References: <10c7f773-7afd-4409-b392-5d987a4024e4@quicinc.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <10c7f773-7afd-4409-b392-5d987a4024e4@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/31/24 14:46, MANISH PANDEY wrote:
> Hi Qais Yousef,

Qais already asked the important question, still some from my end.

> Recently we observed below patch has been merged
> https://lore.kernel.org/all/20240223155749.2958009-3-qyousef@layalina.io
> 
> This patch is causing performance degradation ~20% in Random IO along with significant drop in Sequential IO performance. So we would like to revert this patch as it impacts MCQ UFS devices heavily. Though Non MCQ devices are also getting impacted due to this.

I'm curious about the sequential IO part in particular, what's the blocksize and throughput?
If blocksize is large enough the completion and submission parts are hopefully not as critical.

> 
> We have several concerns with the patch
> 1. This patch takes away the luxury of affining best possible cpus from   device drivers and limits driver to fall in same group of CPUs.
> 
> 2. Why can't device driver use irq affinity to use desired CPUs to complete the IO request, instead of forcing it from block layer.
> 
> 3. Already CPUs are grouped based on LLC, then if a new categorization is required ?

As Qais hinted at, because of systems that share LLC on all CPUs but are HMP.

> 
>> big performance impact if the IO request
>> was done from a CPU with higher capacity but the interrupt is serviced
>> on a lower capacity CPU.
> 
> This patch doesn't considers the issue of contention in submission path and completion path. Also what if we want to complete the request of smaller capacity CPU to Higher capacity CPU?
> Shouldn't a device driver take care of this and allow the vendors to use the best possible combination they want to use?
> Does it considers MCQ devices and different SQ<->CQ mappings?

So I'm assuming you're seeing something like the following:
Some CPU(s) (call them S) are submitting IO, hardirq triggers on
S.
Before the patch the completion softirq could run on a !S CPU,
now it runs on S. Am I then correct in assuming your workload
is CPU-bound on S? Would you share some details about the
workload, too?

What's the capacity of CPU(s) S then?
IOW does this help?

-->8--

diff --git a/block/blk-mq.c b/block/blk-mq.c
index e3c3c0c21b55..a4a2500c4ef6 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1164,7 +1164,7 @@ static inline bool blk_mq_complete_need_ipi(struct request *rq)
        if (cpu == rq->mq_ctx->cpu ||
            (!test_bit(QUEUE_FLAG_SAME_FORCE, &rq->q->queue_flags) &&
             cpus_share_cache(cpu, rq->mq_ctx->cpu) &&
-            cpus_equal_capacity(cpu, rq->mq_ctx->cpu)))
+            arch_scale_cpu_capacity(cpu) >= arch_scale_cpu_capacity(rq->mq_ctx->cpu)))
                return false;
 
        /* don't try to IPI to an offline CPU */
