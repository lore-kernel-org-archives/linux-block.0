Return-Path: <ming.lei@redhat.com>
Date: Mon, 23 Oct 2017 18:00:55 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Israel Rukshin <israelr@mellanox.com>
Cc: Linux-nvme <linux-nvme-bounces@lists.infradead.org>,
	linux-block@vger.kernel.org, Max Gurtovoy <maxg@mellanox.com>,
	Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] blk-mq: Iterate also over sched_tags requests at
 blk_mq_tagset_iter()
Message-ID: <20171023100048.GA28556@ming.t460p>
References: <1508680074-2417-1-git-send-email-israelr@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1508680074-2417-1-git-send-email-israelr@mellanox.com>
List-ID: <linux-block@vger.kernel.org>

On Sun, Oct 22, 2017 at 01:47:54PM +0000, Israel Rukshin wrote:
> Currently, blk_mq_tagset_iter() iterate over initial hctx tags only.
> In case scheduler is used, it doesn't iterate the hctx scheduler tags
> and the static request aren't been updated.
> For example, while using NVMe over Fabrics RDMA host, this cause us not to
> reinit the scheduler requests and thus not re-register all the memory regions
> during the tagset re-initialization in the reconnect flow.
> 
> This may lead to a memory registration error:
> "MEMREG for CQE 0xffff88044c14dce8 failed with status memory
> management operation error (6)"
> 
> Signed-off-by: Israel Rukshin <israelr@mellanox.com>
> Reviewed-by: Max Gurtovoy <maxg@mellanox.com>
> ---
> 
> The commit is based on nvme branch for 4.15 which includes
> Sagi's patches for reinit_tagset.
> 
> ---
>  block/blk-mq-sched.c   |  3 +++
>  block/blk-mq-tag.c     | 16 ++++++++++++++++
>  block/blk-mq.c         | 14 +++++++++++++-
>  include/linux/blk-mq.h |  1 +
>  4 files changed, 33 insertions(+), 1 deletion(-)
> 
> diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
> index 4ab6943..4db9797 100644
> --- a/block/blk-mq-sched.c
> +++ b/block/blk-mq-sched.c
> @@ -426,6 +426,7 @@ static void blk_mq_sched_free_tags(struct blk_mq_tag_set *set,
>  		blk_mq_free_rqs(set, hctx->sched_tags, hctx_idx);
>  		blk_mq_free_rq_map(hctx->sched_tags);
>  		hctx->sched_tags = NULL;
> +		set->sched_tags[hctx_idx] = NULL;
>  	}
>  }
>  
> @@ -441,6 +442,8 @@ static int blk_mq_sched_alloc_tags(struct request_queue *q,
>  	if (!hctx->sched_tags)
>  		return -ENOMEM;
>  
> +	set->sched_tags[hctx_idx] = hctx->sched_tags;
> +
>  	ret = blk_mq_alloc_rqs(set, hctx->sched_tags, hctx_idx, q->nr_requests);
>  	if (ret)
>  		blk_mq_sched_free_tags(set, hctx, hctx_idx);
> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> index c81b40e..c290de0 100644
> --- a/block/blk-mq-tag.c
> +++ b/block/blk-mq-tag.c
> @@ -322,6 +322,22 @@ int blk_mq_tagset_iter(struct blk_mq_tag_set *set, void *data,
>  		}
>  	}
>  
> +	for (i = 0; i < set->nr_hw_queues; i++) {
> +		struct blk_mq_tags *sched_tags = set->sched_tags[i];
> +
> +		if (!sched_tags)
> +			continue;
> +
> +		for (j = 0; j < sched_tags->nr_tags; j++) {
> +			if (!sched_tags->static_rqs[j])
> +				continue;
> +
> +			ret = fn(data, sched_tags->static_rqs[j]);
> +			if (ret)
> +				goto out;
> +		}
> +	}
> +
>  out:
>  	return ret;
>  }
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 7f01d69..d7675b7 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2576,10 +2576,16 @@ int blk_mq_alloc_tag_set(struct blk_mq_tag_set *set)
>  		return -ENOMEM;
>  
>  	ret = -ENOMEM;
> +
> +	set->sched_tags = kzalloc_node(nr_cpu_ids * sizeof(struct blk_mq_tags *),
> +				       GFP_KERNEL, set->numa_node);
> +	if (!set->sched_tags)
> +		goto out_free_tags;
> +
>  	set->mq_map = kzalloc_node(sizeof(*set->mq_map) * nr_cpu_ids,
>  			GFP_KERNEL, set->numa_node);
>  	if (!set->mq_map)
> -		goto out_free_tags;
> +		goto out_free_sched_tags;
>  
>  	ret = blk_mq_update_queue_map(set);
>  	if (ret)
> @@ -2597,6 +2603,9 @@ int blk_mq_alloc_tag_set(struct blk_mq_tag_set *set)
>  out_free_mq_map:
>  	kfree(set->mq_map);
>  	set->mq_map = NULL;
> +out_free_sched_tags:
> +	kfree(set->sched_tags);
> +	set->sched_tags = NULL;
>  out_free_tags:
>  	kfree(set->tags);
>  	set->tags = NULL;
> @@ -2614,6 +2623,9 @@ void blk_mq_free_tag_set(struct blk_mq_tag_set *set)
>  	kfree(set->mq_map);
>  	set->mq_map = NULL;
>  
> +	kfree(set->sched_tags);
> +	set->sched_tags = NULL;
> +
>  	kfree(set->tags);
>  	set->tags = NULL;
>  }
> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> index cfd64e5..9ec629f 100644
> --- a/include/linux/blk-mq.h
> +++ b/include/linux/blk-mq.h
> @@ -78,6 +78,7 @@ struct blk_mq_tag_set {
>  	void			*driver_data;
>  
>  	struct blk_mq_tags	**tags;
> +	struct blk_mq_tags	**sched_tags;

It isn't a good idea to put 'sched_tags' here because
scheduler tags shouldn't be shared, not like driver tags.

If you want to do something on scheduler tags, you have to
get the 'hctx' instance first.

-- 
Ming
