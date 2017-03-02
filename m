Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 2 Mar 2017 14:32:05 -0500
From: Tejun Heo <tj@kernel.org>
To: Tahsin Erdogan <tahsin@google.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	David Rientjes <rientjes@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] blkcg: allocate struct blkcg_gq outside request queue
 spinlock
Message-ID: <20170302193205.GB8519@wtj.duckdns.org>
References: <20170301165501.GB3662@htj.duckdns.org>
 <20170301234319.29584-1-tahsin@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170301234319.29584-1-tahsin@google.com>
List-ID: <linux-block@vger.kernel.org>

Hello, Tahsin.

On Wed, Mar 01, 2017 at 03:43:19PM -0800, Tahsin Erdogan wrote:
> @@ -258,18 +258,22 @@ static struct blkcg_gq *blkg_create(struct blkcg *blkcg,
>  struct blkcg_gq *blkg_lookup_create(struct blkcg *blkcg,
> -				    struct request_queue *q)
> +				    struct request_queue *q, bool wait_ok)

I'm okay with this direction but it probably would be better if the
parameter is gfp_mask and we branch on __GFP_WAIT in the function.

>  {
>  	struct blkcg_gq *blkg;
>  
> @@ -300,7 +304,30 @@ struct blkcg_gq *blkg_lookup_create(struct blkcg *blkcg,
>  			parent = blkcg_parent(parent);
>  		}
>  
> -		blkg = blkg_create(pos, q, NULL);
> +		if (wait_ok) {
> +			struct blkcg_gq *new_blkg;
> +
> +			spin_unlock_irq(q->queue_lock);
> +			rcu_read_unlock();
> +
> +			new_blkg = blkg_alloc(pos, q, GFP_KERNEL);
> +
> +			rcu_read_lock();
> +			spin_lock_irq(q->queue_lock);
> +
> +			if (unlikely(!new_blkg))
> +				return ERR_PTR(-ENOMEM);
> +
> +			if (unlikely(blk_queue_bypass(q))) {
> +				blkg_free(new_blkg);
> +				return ERR_PTR(blk_queue_dying(q) ?
> +							-ENODEV : -EBUSY);
> +			}
> +
> +			blkg = blkg_create(pos, q, new_blkg);
> +		} else
> +			blkg = blkg_create(pos, q, NULL);

So, while I'm okay with the approach, now we're creating a hybrid
approach where we have both pre-allocation and allocation mode
altering mechanisms.  If we're going to take this route, I think the
right thing to do is passing down @gfp_mask all the way down to
blkg_create().

> @@ -789,6 +816,7 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
>  {
>  	struct gendisk *disk;
>  	struct blkcg_gq *blkg;
> +	struct request_queue *q;
>  	struct module *owner;
>  	unsigned int major, minor;
>  	int key_len, part, ret;
> @@ -812,18 +840,27 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
>  		return -ENODEV;
>  	}
>  
> +	q = disk->queue;
> +
>  	rcu_read_lock();
> -	spin_lock_irq(disk->queue->queue_lock);
> +	spin_lock_irq(q->queue_lock);
>  
> -	if (blkcg_policy_enabled(disk->queue, pol))
> -		blkg = blkg_lookup_create(blkcg, disk->queue);
> -	else
> +	if (blkcg_policy_enabled(q, pol)) {
> +		blkg = blkg_lookup_create(blkcg, q, true /* wait_ok */);
> +
> +		/*
> +		 * blkg_lookup_create() may have dropped and reacquired the
> +		 * queue lock. Check policy enabled state again.
> +		 */
> +		if (!IS_ERR(blkg) && unlikely(!blkcg_policy_enabled(q, pol)))
> +			blkg = ERR_PTR(-EOPNOTSUPP);

And let blkg_create() verify these conditions after releasing and
regrabbing the lock.

This also means that the init path can simply pass in GFP_KERNEL.

Thanks.

-- 
tejun
