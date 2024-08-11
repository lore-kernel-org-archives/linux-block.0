Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AAAD27447;
	Sun, 11 Aug 2024 17:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723398104; cv=none; b=GtNX9aDe6PBEJP6ekhjtk+EApcgqGw3rk00+cxHzBzMtMCY/0CEGJLzFTnHdSVmyRUqSGKoJihd0zQPDbC0ZtFxpz7LmE+kCCICxbg+0EuSrIgqRakuQxXAdUaRnvETjqUR5u/3g1epTJIp/KlLO4Ga3C8K26LUoVKZFlDQy9QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723398104; c=relaxed/simple;
	bh=hphTYSkZTnY9Y9aQRf2FyLxh27Y2wAch0ANmN7fhwXo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qD7pE/sRWCAAbFCfN5cYXXmT/jNUegbhQrmpokKFt6vManDxY09LobBUpYo35OP07XqCtxO5jISf3EWpkG4I+Qz+mCNtFax39cYKmgduoCXOZaMfa03PgnVnkCA9b0bky0jLt9FVT8Hi/8YJZfV6frixjsxMgUqLp+JE4rv/SZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ADE92FEC;
	Sun, 11 Aug 2024 10:42:00 -0700 (PDT)
Received: from [192.168.13.84] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5A98D3F71E;
	Sun, 11 Aug 2024 10:41:14 -0700 (PDT)
Message-ID: <c151b6d5-7e02-48ee-951f-c23594f6be6f@arm.com>
Date: Sun, 11 Aug 2024 19:41:08 +0200
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
 Bart Van Assche <bvanassche@acm.org>, Qais Yousef <qyousef@layalina.io>,
 Christian Loehle <christian.loehle@arm.com>
Cc: axboe@kernel.dk, mingo@kernel.org, peterz@infradead.org,
 vincent.guittot@linaro.org, linux-block@vger.kernel.org,
 sudeep.holla@arm.com, Jaegeuk Kim <jaegeuk@kernel.org>,
 Christoph Hellwig <hch@infradead.org>, kailash@google.com, tkjos@google.com,
 dhavale@google.com, bvanassche@google.com, quic_nitirawa@quicinc.com,
 quic_cang@quicinc.com, quic_rampraka@quicinc.com, quic_narepall@quicinc.com,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <10c7f773-7afd-4409-b392-5d987a4024e4@quicinc.com>
 <3feb5226-7872-432b-9781-29903979d34a@arm.com>
 <20240805020748.d2tvt7c757hi24na@airbuntu>
 <25909f08-12a5-4625-839d-9e31df4c9c72@acm.org>
 <1d9c27b2-77c7-462f-bde9-1207f931ea9f@quicinc.com>
 <17bf99ad-d64d-40ef-864f-ce266d3024c7@acm.org>
 <e2c19f3a-13b0-4e88-ba44-7674f3a1ea87@quicinc.com>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Language: en-US
In-Reply-To: <e2c19f3a-13b0-4e88-ba44-7674f3a1ea87@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

+ linux-kernel@vger.kernel.org

On 08/08/2024 08:05, MANISH PANDEY wrote:
>  
> On 8/5/2024 11:22 PM, Bart Van Assche wrote:
>> On 8/5/24 10:35 AM, MANISH PANDEY wrote:

[...]

>> Please use an approach that is supported by the block layer. I don't
>> think that dynamically changing the IRQ affinity is compatible with the
>> block layer.
> 
> For UFS with MCQ, ESI IRQs are bounded at the time of initialization.
> so basically i would like to use High Performance cluster CPUs to
> migrate few completions from Mid clusters and take the advantage of high
> capacity CPUs. The new change takes away this opportunity from driver.
> So basically we should be able to use High Performance CPUs like below
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index e3c3c0c21b55..a4a2500c4ef6 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1164,7 +1164,7 @@ static inline bool blk_mq_complete_need_ipi(struct
> request *rq)
>         if (cpu == rq->mq_ctx->cpu ||
>             (!test_bit(QUEUE_FLAG_SAME_FORCE, &rq->q->queue_flags) &&
>              cpus_share_cache(cpu, rq->mq_ctx->cpu) &&
> -            cpus_equal_capacity(cpu, rq->mq_ctx->cpu)))
> +            arch_scale_cpu_capacity(cpu) >=     
> arch_scale_cpu_capacity(rq->mq_ctx->cpu)))
>                 return false;
> 
> This way driver can use best possible CPUs for it's use case.

So the issue for you with commit af550e4c9682 seems to be that those
completions don't happen on big CPUs (cpu_capacity = 1024) anymore,
since the condition in  blk_mq_complete_need_ipi() (1):

 if (!QUEUE_FLAG_SAME_FORCE && cpus_share_cache(cpu, rq->mq_ctx->cpu) &&
     cpus_equal_capacity(cpu, rq->mq_ctx->cpu))

is no longer true if 'rq->mq_ctx->cpu != big CPU' so (1) returns true
and blk_mq_complete_request_remote() sends an ipi to 'rq->mq_ctx->cpu'.


I tried to simulate this with a 6 CPUs aarch64 QEMU tri-gear (3
different cpu_capacity values) system:

cat /sys/devices/system/cpu/online
0-5

# cat /sys/devices/system/cpu/cpu*/cpu_capacity
446
446
871
871
1024
1024

# grep -i virtio /proc/interrupts | while read a b; do grep -aH .
/proc/irq/${a%:}/smp_affinity; done
/proc/irq/15/smp_affinity:3f /* block device */
/proc/irq/16/smp_affinity:3f /* network device */

So you set the block device irq affine to the big CPUs (0x30).

# echo 30 > /proc/irq/15/smp_affinity

And with the patch, you send ipi's in blk_mq_complete_request_remote()
in case 'rq->mq_ctx->cpu=[0-4]' whereas w/o the patch or the change to:

 arch_scale_cpu_capacity(cpu) >=
                            arch_scale_cpu_capacity(rq->mq_ctx->cpu) (2)

you would complete the request locally (i.e. on CPU4/5):

gic_handle_irq() -> ... -> handle_irq_event() -> ... -> vm_interrupt()
-> ... -> virtblk_done() (callback) -> blk_mq_complete_request() ->
blk_mq_complete_request_remote(), rq->q->mq_ops->complete(rq)

The patch IMHO was introduced to avoid running local when 'local =
little CPU'. Since you use system knowledge and set IRQ affinity
explicitly to big CPU's to run local on them, maybe (2) is the way to
allow both?
