Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DMYpJvdz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5799AD5
	for <linux-block@vger.kernel.org>; Wed, 13 Dec 2023 13:43:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702503811;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VUIzpkZT2tagaDFtAx2/+eqPedGfJZcdJjiB2EH++mI=;
	b=DMYpJvdzWDtaDutech32+iEj/Yqy0dEYCMaeihYGC0ZByoT/VS5+UF6YeMAbCdVk1WiC/+
	z1diMIqLZ36RFMl95OHFVr0KckTbT1cCyBSSIAivzOe9h2rnuC9fdyomYFrYISh6RsFk7A
	W5HrwbX/78yKV73+NgsMm5wnF18Azvs=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-171-yeZcsSoWNyW5mC6HRaUvdQ-1; Wed, 13 Dec 2023 16:43:29 -0500
X-MC-Unique: yeZcsSoWNyW5mC6HRaUvdQ-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-421b20c9893so95107921cf.0
        for <linux-block@vger.kernel.org>; Wed, 13 Dec 2023 13:43:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702503808; x=1703108608;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VUIzpkZT2tagaDFtAx2/+eqPedGfJZcdJjiB2EH++mI=;
        b=r9BnZhThM0xx0DASeaLp/IOluRRbwvopZVceNm5G2OL+xY40t7FgLDirgCticE95hM
         nOJaumviqkvVWKh2I4o8vmtHBAXUQKnvuV+ELAavy1BHPWxTh4W4CcxpBAk2iSioqWr5
         7Cw9DOdzZ5Xr70pZqw1K4GN0sOtQ/z0byXzQN3cfMEPo2MlZSGNDUhVa6V2OGAlKBhW2
         24JIVXM/gOmBY3XQHRlkkeOESEG9i1voYFn1vImYEGsa1yRstt2GXGt9UDldQODzFqOc
         RvYurOZjDfH3CoCR00mLJCM9nhZFfAyU0ipmxCcsVsWnesTCI+niNtLhSd/xpSguNXrP
         qd8w==
X-Gm-Message-State: AOJu0YyqhngQbg2VyXJgnI4UlTgAr7sJxhjyCRRMyhfOn1ko8fpSHGjt
	kQa3W1/wRiwSJe6H1k1sRBFEr1qM2je4TGy+PDKBrPeh9KvrFckdNk24n3H4xvvK2qhNKaw/wwA
	5glzKcm2zuRFdHNP4SRKQvbQ=
X-Received: by 2002:a05:622a:3d1:b0:425:4043:7659 with SMTP id k17-20020a05622a03d100b0042540437659mr12147155qtx.129.1702503808737;
        Wed, 13 Dec 2023 13:43:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG3JkKf2jXKqJIVmrF8vr61mxKqw0lfl9UI+P3XlaspMCkY+qnqH8WWjINFNZQmZrsa94ouUA==
X-Received: by 2002:a05:622a:3d1:b0:425:4043:7659 with SMTP id k17-20020a05622a03d100b0042540437659mr12147135qtx.129.1702503808469;
        Wed, 13 Dec 2023 13:43:28 -0800 (PST)
Received: from [192.168.0.189] (pool-173-76-165-118.bstnma.fios.verizon.net. [173.76.165.118])
        by smtp.gmail.com with ESMTPSA id m26-20020ac866da000000b004240481cee0sm5234658qtp.58.2023.12.13.13.43.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Dec 2023 13:43:27 -0800 (PST)
Message-ID: <b5f2ccfb-0ec0-42f5-a676-187850ca8b4f@redhat.com>
Date: Wed, 13 Dec 2023 16:43:26 -0500
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3] blk-mq: don't schedule block kworker on isolated CPUs
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Tejun Heo <tj@kernel.org>,
 linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
 Andrew Theurer <atheurer@redhat.com>, Sebastian Jug <sejug@redhat.com>,
 Frederic Weisbecker <frederic@kernel.org>,
 Bart Van Assche <bvanassche@acm.org>
References: <20231025025737.358756-1-ming.lei@redhat.com>
Content-Language: en-US
From: Joe Mario <jmario@redhat.com>
In-Reply-To: <20231025025737.358756-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Tested-by: Joe Mario <jmario@redhat.com>

Running fio on an nvme, I verified that block kworker threads no longer ran on isolated cpus.
I used:
  # timeout -s INT 60 bpftrace -e 'kprobe:nvme_queue_rq{ @["CPU=",cpu] = count(); }'

The kernel with this V3 patch showed no hits on isolated cpus.
An unpatched kernel showed 40587 hits on isolated cpus.

Joe

On 10/24/23 10:57 PM, Ming Lei wrote:
> Kernel parameter of `isolcpus=` or 'nohz_full=' are used for isolating CPUs
> for specific task, and user often won't want block IO to disturb these CPUs,
> also long IO latency may be caused if blk-mq kworker is scheduled on these
> isolated CPUs.
> 
> Kernel workqueue only respects this limit for WQ_UNBOUND, for bound wq,
> the responsibility should be on wq user.
> 
> So don't not run block kworker on isolated CPUs by ruling out isolated CPUs
> from hctx->cpumask. Meantime in cpuhp handler, use queue map to check if
> all CPUs in this hw queue are offline, this way can avoid any cost in fast
> IO code path.
> 
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Andrew Theurer <atheurer@redhat.com>
> Cc: Joe Mario <jmario@redhat.com>
> Cc: Sebastian Jug <sejug@redhat.com>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Cc: Bart Van Assche <bvanassche@acm.org>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
> 
> V3:
> 	- avoid to check invalid cpu as reported by Bart
> 	- take current cpu(to be offline, not done yet) into account
> 	- simplify blk_mq_hctx_has_online_cpu()
> 
> V2:
> 	- remove module parameter, meantime use queue map to check if
> 	all cpus in one hctx are offline
> 
>  block/blk-mq.c | 51 ++++++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 41 insertions(+), 10 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index e2d11183f62e..4556978ce71b 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -29,6 +29,7 @@
>  #include <linux/prefetch.h>
>  #include <linux/blk-crypto.h>
>  #include <linux/part_stat.h>
> +#include <linux/sched/isolation.h>
>  
>  #include <trace/events/block.h>
>  
> @@ -2158,7 +2159,11 @@ static int blk_mq_hctx_next_cpu(struct blk_mq_hw_ctx *hctx)
>  	bool tried = false;
>  	int next_cpu = hctx->next_cpu;
>  
> -	if (hctx->queue->nr_hw_queues == 1)
> +	/*
> +	 * In case of single queue or no allowed CPU for scheduling
> +	 * worker, don't bound our worker with any CPU
> +	 */
> +	if (hctx->queue->nr_hw_queues == 1 || next_cpu >= nr_cpu_ids)
>  		return WORK_CPU_UNBOUND;
>  
>  	if (--hctx->next_cpu_batch <= 0) {
> @@ -3459,14 +3464,30 @@ static bool blk_mq_hctx_has_requests(struct blk_mq_hw_ctx *hctx)
>  	return data.has_rq;
>  }
>  
> -static inline bool blk_mq_last_cpu_in_hctx(unsigned int cpu,
> -		struct blk_mq_hw_ctx *hctx)
> +static bool blk_mq_hctx_has_online_cpu(struct blk_mq_hw_ctx *hctx,
> +		unsigned int this_cpu)
>  {
> -	if (cpumask_first_and(hctx->cpumask, cpu_online_mask) != cpu)
> -		return false;
> -	if (cpumask_next_and(cpu, hctx->cpumask, cpu_online_mask) < nr_cpu_ids)
> -		return false;
> -	return true;
> +	enum hctx_type type = hctx->type;
> +	int cpu;
> +
> +	/*
> +	 * hctx->cpumask has rule out isolated CPUs, but userspace still
> +	 * might submit IOs on these isolated CPUs, so use queue map to
> +	 * check if all CPUs mapped to this hctx are offline
> +	 */
> +	for_each_online_cpu(cpu) {
> +		struct blk_mq_hw_ctx *h = blk_mq_map_queue_type(hctx->queue,
> +				type, cpu);
> +
> +		if (h != hctx)
> +			continue;
> +
> +		/* this current CPU isn't put offline yet */
> +		if (this_cpu != cpu)
> +			return true;
> +	}
> +
> +	return false;
>  }
>  
>  static int blk_mq_hctx_notify_offline(unsigned int cpu, struct hlist_node *node)
> @@ -3474,8 +3495,7 @@ static int blk_mq_hctx_notify_offline(unsigned int cpu, struct hlist_node *node)
>  	struct blk_mq_hw_ctx *hctx = hlist_entry_safe(node,
>  			struct blk_mq_hw_ctx, cpuhp_online);
>  
> -	if (!cpumask_test_cpu(cpu, hctx->cpumask) ||
> -	    !blk_mq_last_cpu_in_hctx(cpu, hctx))
> +	if (blk_mq_hctx_has_online_cpu(hctx, cpu))
>  		return 0;
>  
>  	/*
> @@ -3883,6 +3903,8 @@ static void blk_mq_map_swqueue(struct request_queue *q)
>  	}
>  
>  	queue_for_each_hw_ctx(q, hctx, i) {
> +		int cpu;
> +
>  		/*
>  		 * If no software queues are mapped to this hardware queue,
>  		 * disable it and free the request entries.
> @@ -3909,6 +3931,15 @@ static void blk_mq_map_swqueue(struct request_queue *q)
>  		 */
>  		sbitmap_resize(&hctx->ctx_map, hctx->nr_ctx);
>  
> +		/*
> +		 * rule out isolated CPUs from hctx->cpumask for avoiding to
> +		 * run wq worker on isolated CPU
> +		 */
> +		for_each_cpu(cpu, hctx->cpumask) {
> +			if (cpu_is_isolated(cpu))
> +				cpumask_clear_cpu(cpu, hctx->cpumask);
> +		}
> +
>  		/*
>  		 * Initialize batch roundrobin counts
>  		 */

