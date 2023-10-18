Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D12CDB474
	for <linux-block@archiver.kernel.org>; Wed, 18 Oct 2023 00:52:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234843AbjJRAww (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 Oct 2023 20:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233726AbjJRAwu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Oct 2023 20:52:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF96DF9
        for <linux-block@vger.kernel.org>; Tue, 17 Oct 2023 17:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697590325;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FK1HTlHJ+0l3R06vHMoTLhT2NX6e511ARHCQNoD5obE=;
        b=Mll2DxNOqBO9xcRILQUG8Dzx/vvkyh+vlqt5RR+p6A9+H7g/8g2blIl9EHgq2XdECSgYRk
        luHJfAglCJIDNChRD+ItI2VkuJSzFif/CJ+oLdPpQ4uSwNODfSFxW+VA9IvCe9Noe3zzjn
        IEemTQJ2acCsLouSlgJAnWj7gljJVno=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-497-DgJGMUJmMgmQOAMWBlQL9g-1; Tue, 17 Oct 2023 20:52:03 -0400
X-MC-Unique: DgJGMUJmMgmQOAMWBlQL9g-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7788ce62d50so103771985a.3
        for <linux-block@vger.kernel.org>; Tue, 17 Oct 2023 17:52:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697590323; x=1698195123;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FK1HTlHJ+0l3R06vHMoTLhT2NX6e511ARHCQNoD5obE=;
        b=OrfWX9XUwUa8xgNxrsAm/95FW/SrHVh5Ah94CNAI0jvti+9pjeuDesMVhz6TSA4jbT
         usJZYIzgeEgH8Gri+2f6SQ8RyyjNENC+SL6bLBazGQE2J0AVRFmDyySndgOW0w0TsdSD
         4WKI3n+iB1DcFnNYel1QZdghZnRD+9+oQO4C0MWbZsXDUr8V8ARoRYisbPxnjSGWddrd
         KwidnheX/Lk6EzfOkDjPjtmqGjy+vuNp7lcvcTN0/OmpaBUBoQZr2ch9bbDeCWxKhOeE
         AZHdLtf5EG5BG3Y5fCk6XvctIFjJtzoVehmw13tPNoLSByl+tKrzyUaFXDghkMjjZap2
         8P5w==
X-Gm-Message-State: AOJu0YwUHWXStJXoIhTBjgikLYzpjWBrgHwvA/9YagLL9HQc6mojuobw
        V9tpuxMCfCgb4bQGpcfEsKBKK3yeEEgV3bZ2oFTjcJ+y0HExiPAYo/Q5cN5uT5v+thtlIffjaxQ
        gzkdtXfEA42RZldf851TBRPM=
X-Received: by 2002:a05:620a:404b:b0:778:91ee:a9fb with SMTP id i11-20020a05620a404b00b0077891eea9fbmr775775qko.5.1697590323302;
        Tue, 17 Oct 2023 17:52:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHir5AcRevEbyBxlM67AyCtcgYu4/8oXdFaF+eZVrQj0Vpe5aLV+xNdi/1ePelDyN7VpVyqQw==
X-Received: by 2002:a05:620a:404b:b0:778:91ee:a9fb with SMTP id i11-20020a05620a404b00b0077891eea9fbmr775761qko.5.1697590323028;
        Tue, 17 Oct 2023 17:52:03 -0700 (PDT)
Received: from [192.168.0.189] (pool-173-76-165-118.bstnma.fios.verizon.net. [173.76.165.118])
        by smtp.gmail.com with ESMTPSA id s17-20020ae9f711000000b0076f16e98851sm1077482qkg.102.2023.10.17.17.52.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 17:52:02 -0700 (PDT)
Message-ID: <f62c39ad-24a4-45e2-9f3e-52f033ac9807@redhat.com>
Date:   Tue, 17 Oct 2023 20:52:01 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] blk-mq: don't schedule block kworker on isolated CPUs
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
        Andrew Theurer <atheurer@redhat.com>,
        Sebastian Jug <sejug@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>
References: <20231013124758.1492796-1-ming.lei@redhat.com>
Content-Language: en-US
From:   Joe Mario <jmario@redhat.com>
In-Reply-To: <20231013124758.1492796-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Tested-by: Joe Mario <jmario@redhat.com>

Verified that block kworker threads no longer ran on isolated cpus.
Joe

On 10/13/23 8:47 AM, Ming Lei wrote:
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
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
> V2:
> 	- remove module parameter, meantime use queue map to check if
> 	all cpus in one hctx are offline
> 
>  block/blk-mq.c | 42 +++++++++++++++++++++++++++++++++---------
>  1 file changed, 33 insertions(+), 9 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index ec922c6bccbe..91055bdc4426 100644
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
> @@ -3476,14 +3477,27 @@ static bool blk_mq_hctx_has_requests(struct blk_mq_hw_ctx *hctx)
>  	return data.has_rq;
>  }
>  
> -static inline bool blk_mq_last_cpu_in_hctx(unsigned int cpu,
> -		struct blk_mq_hw_ctx *hctx)
> +static bool blk_mq_hctx_has_online_cpu(struct blk_mq_hw_ctx *hctx)
>  {
> -	if (cpumask_first_and(hctx->cpumask, cpu_online_mask) != cpu)
> -		return false;
> -	if (cpumask_next_and(cpu, hctx->cpumask, cpu_online_mask) < nr_cpu_ids)
> -		return false;
> -	return true;
> +	struct blk_mq_tag_set *tag_set = hctx->queue->tag_set;
> +	int cpu;
> +
> +	/*
> +	 * hctx->cpumask has rule out isolated CPUs, but userspace still
> +	 * might submit IOs on these isolated CPUs, so use queue map to
> +	 * check if all CPUs mapped to this hctx are offline
> +	 */
> +	for_each_possible_cpu(cpu) {
> +		unsigned idx = tag_set->map[hctx->type].mq_map[cpu];
> +
> +		if (idx != hctx->queue_num)
> +			continue;
> +
> +		if (cpu_online(cpu))
> +			return true;
> +	}
> +
> +	return false;
>  }
>  
>  static int blk_mq_hctx_notify_offline(unsigned int cpu, struct hlist_node *node)
> @@ -3491,8 +3505,7 @@ static int blk_mq_hctx_notify_offline(unsigned int cpu, struct hlist_node *node)
>  	struct blk_mq_hw_ctx *hctx = hlist_entry_safe(node,
>  			struct blk_mq_hw_ctx, cpuhp_online);
>  
> -	if (!cpumask_test_cpu(cpu, hctx->cpumask) ||
> -	    !blk_mq_last_cpu_in_hctx(cpu, hctx))
> +	if (blk_mq_hctx_has_online_cpu(hctx))
>  		return 0;
>  
>  	/*
> @@ -3900,6 +3913,8 @@ static void blk_mq_map_swqueue(struct request_queue *q)
>  	}
>  
>  	queue_for_each_hw_ctx(q, hctx, i) {
> +		int cpu;
> +
>  		/*
>  		 * If no software queues are mapped to this hardware queue,
>  		 * disable it and free the request entries.
> @@ -3926,6 +3941,15 @@ static void blk_mq_map_swqueue(struct request_queue *q)
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

