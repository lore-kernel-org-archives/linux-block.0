Subject: Re: [PATCH 2/4] blk-mq: introduce blk_mq_get_queue_depth()
To: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org
References: <20170428151539.25514-1-ming.lei@redhat.com>
 <20170428151539.25514-3-ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, Omar Sandoval <osandov@fb.com>
From: Jens Axboe <axboe@fb.com>
Message-ID: <01993bcb-da07-a8f5-1f00-09b808f9efc9@fb.com>
Date: Fri, 28 Apr 2017 12:23:38 -0600
MIME-Version: 1.0
In-Reply-To: <20170428151539.25514-3-ming.lei@redhat.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 04/28/2017 09:15 AM, Ming Lei wrote:
> The hardware queue depth can be resized via blk_mq_update_nr_requests(),
> so introduce this helper for retrieving queue's depth easily.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  block/blk-mq.c | 12 ++++++++++++
>  block/blk-mq.h |  1 +
>  2 files changed, 13 insertions(+)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index e530bc54f0d9..04761fb76ab4 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2637,6 +2637,18 @@ void blk_mq_free_tag_set(struct blk_mq_tag_set *set)
>  }
>  EXPORT_SYMBOL(blk_mq_free_tag_set);
>  
> +/*
> + * Queue depth can be changed via blk_mq_update_nr_requests(),
> + * so use this helper to retrieve queue's depth.
> + */
> +int blk_mq_get_queue_depth(struct request_queue *q)
> +{
> +	/* All queues have same queue depth */
> +	struct blk_mq_tags	*tags = q->tag_set->tags[0];
> +
> +	return tags->bitmap_tags.sb.depth;
> +}

What about the per-hw queue tag space? q->nr_requests is device side,
this might not be.

-- 
Jens Axboe
