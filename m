Subject: Re: [PATCH 3/4] blk-mq: use hw tag for scheduling if hw tag space is
 big enough
To: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org
References: <20170428151539.25514-1-ming.lei@redhat.com>
 <20170428151539.25514-4-ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, Omar Sandoval <osandov@fb.com>
From: Jens Axboe <axboe@fb.com>
Message-ID: <c8984e2a-ecdc-fdf7-afba-484b823270c9@fb.com>
Date: Fri, 28 Apr 2017 12:22:45 -0600
MIME-Version: 1.0
In-Reply-To: <20170428151539.25514-4-ming.lei@redhat.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 04/28/2017 09:15 AM, Ming Lei wrote:  
> +/*
> + * If this queue has enough hardware tags and doesn't share tags with
> + * other queues, just use hw tag directly for scheduling.
> + */
> +static inline bool blk_mq_sched_may_use_hw_tag(struct request_queue *q)
> +{
> +	if (q->tag_set->flags & BLK_MQ_F_TAG_SHARED)
> +		return false;
> +
> +	if (blk_mq_get_queue_depth(q) < q->nr_requests)
> +		return false;

I think we should leave a bigger gap. Ideally, for scheduling, we should
have a hw queue depth that's around half of what the scheduler has to
work with. That will always leave us something to schedule with, if the
hw can't deplete the whole pool.

-- 
Jens Axboe
