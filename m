Return-Path: <ming.lei@redhat.com>
Date: Fri, 7 Apr 2017 17:46:24 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH v3 1/5] blk-mq: Make it safe to use RCU to iterate over
 blk_mq_tag_set.tag_list
Message-ID: <20170407094623.GD27631@ming.t460p>
References: <20170406181050.12137-1-bart.vanassche@sandisk.com>
 <20170406181050.12137-2-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170406181050.12137-2-bart.vanassche@sandisk.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, Apr 06, 2017 at 11:10:46AM -0700, Bart Van Assche wrote:
> Since the next patch in this series will use RCU to iterate over
> tag_list, make this safe. Add lockdep_assert_held() statements
> in functions that iterate over tag_list to make clear that using
> list_for_each_entry() instead of list_for_each_entry_rcu() is
> fine in these functions.
> 
> Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Hannes Reinecke <hare@suse.com>
> ---
>  block/blk-mq.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index f7cd3208bcdf..b5580b09b4a5 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2076,6 +2076,8 @@ static void blk_mq_update_tag_set_depth(struct blk_mq_tag_set *set, bool shared)
>  {
>  	struct request_queue *q;
>  
> +	lockdep_assert_held(&set->tag_list_lock);
> +
>  	list_for_each_entry(q, &set->tag_list, tag_set_list) {
>  		blk_mq_freeze_queue(q);
>  		queue_set_hctx_shared(q, shared);
> @@ -2096,6 +2098,8 @@ static void blk_mq_del_queue_tag_set(struct request_queue *q)
>  		blk_mq_update_tag_set_depth(set, false);
>  	}
>  	mutex_unlock(&set->tag_list_lock);
> +
> +	synchronize_rcu();

Looks synchronize_rcu() is only needed in deletion path, so it can
be moved to blk_mq_del_queue_tag_set().

Also list_del_init/list_add_tail() need to be replaced with RCU
safe version in functions operating &set->tag_list.

>  }
>  
>  static void blk_mq_add_queue_tag_set(struct blk_mq_tag_set *set,
> @@ -2601,6 +2605,8 @@ void blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set, int nr_hw_queues)
>  {
>  	struct request_queue *q;
>  
> +	lockdep_assert_held(&set->tag_list_lock);
> +
>  	if (nr_hw_queues > nr_cpu_ids)
>  		nr_hw_queues = nr_cpu_ids;
>  	if (nr_hw_queues < 1 || nr_hw_queues == set->nr_hw_queues)
> -- 
> 2.12.0
> 

-- 
Ming
