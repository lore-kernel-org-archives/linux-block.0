Return-Path: <sagigrim@gmail.com>
Return-Path: <sagigrim@gmail.com>
Subject: Re: [PATCH 04/16] blk-mq: pass in request/bio flags to queue mapping
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20181030183252.17857-1-axboe@kernel.dk>
 <20181030183252.17857-5-axboe@kernel.dk>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <50a9c2d1-abc5-b04f-1f95-878f216a47b1@grimberg.me>
Date: Tue, 30 Oct 2018 17:37:59 -0700
MIME-Version: 1.0
In-Reply-To: <20181030183252.17857-5-axboe@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>


>   static inline struct blk_mq_hw_ctx *blk_mq_map_queue(struct request_queue *q,
> +						     unsigned int flags,
>   						     unsigned int cpu)
>   {
>   	struct blk_mq_tag_set *set = q->tag_set;
> @@ -84,7 +85,7 @@ static inline struct blk_mq_hw_ctx *blk_mq_map_queue_type(struct request_queue *
>   							  unsigned int hctx_type,
>   							  unsigned int cpu)
>   {
> -	return blk_mq_map_queue(q, cpu);
> +	return blk_mq_map_queue(q, hctx_type, cpu);
>   }

Haven't read through the rest of the patch set, but it looks a bit
strange that a type enumeration is being passed on as flags field.
