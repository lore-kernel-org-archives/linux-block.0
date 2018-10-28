Return-Path: <BATV+f6810342bdcd0158e5a3+5544+infradead.org+hch@bombadil.srs.infradead.org>
Date: Sun, 28 Oct 2018 09:10:58 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 01/14] blk-mq: kill q->mq_map
Message-ID: <20181028161058.GA26904@infradead.org>
References: <20181025211626.12692-1-axboe@kernel.dk>
 <20181025211626.12692-2-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20181025211626.12692-2-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Thu, Oct 25, 2018 at 03:16:13PM -0600, Jens Axboe wrote:
>  static inline struct blk_mq_hw_ctx *blk_mq_map_queue(struct request_queue *q,
>  		int cpu)
>  {
> -	return q->queue_hw_ctx[q->mq_map[cpu]];
> +	struct blk_mq_tag_set *set = q->tag_set;
> +
> +	return q->queue_hw_ctx[set->mq_map[cpu]];

Nitpick: this would be a little more readable without the local
set variable:

	return q->queue_hw_ctx[q->tag_set->mq_map[cpu]];

Otherwise this looks good to me:

Reviewed-by: Christoph Hellwig <hch@lst.de>
