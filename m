Return-Path: <sagigrim@gmail.com>
Return-Path: <sagigrim@gmail.com>
Subject: Re: [PATCH 05/16] blk-mq: allow software queue to map to multiple
 hardware queues
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20181030183252.17857-1-axboe@kernel.dk>
 <20181030183252.17857-6-axboe@kernel.dk>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <f5bff9c7-2c94-8988-cf76-318fa0808cf0@grimberg.me>
Date: Tue, 30 Oct 2018 17:49:02 -0700
MIME-Version: 1.0
In-Reply-To: <20181030183252.17857-6-axboe@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>



> @@ -2342,10 +2346,16 @@ static void blk_mq_map_swqueue(struct request_queue *q)
>   
>   		ctx = per_cpu_ptr(q->queue_ctx, i);
>   		hctx = blk_mq_map_queue_type(q, 0, i);
> -
> +		hctx->type = 0;
>   		cpumask_set_cpu(i, hctx->cpumask);
> -		ctx->index_hw = hctx->nr_ctx;
> +		ctx->index_hw[hctx->type] = hctx->nr_ctx;
>   		hctx->ctxs[hctx->nr_ctx++] = ctx;
> +
> +		/*
> +		 * If the nr_ctx type overflows, we have exceeded the
> +		 * amount of sw queues we can support.
> +		 */
> +		BUG_ON(!hctx->nr_ctx);

Was this added because nr_ctx became short? What was the motivation
for that? save space? structure alignment?

Perhaps this should be mentioned in the change log (as it contradicts
that no functional changes exist in this patch). Or, if this can happen
even when 32bit nr_ctx, it should be a separate small patch?
