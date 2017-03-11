Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v5] blkcg: allocate struct blkcg_gq outside request queue
 spinlock
To: Tahsin Erdogan <tahsin@google.com>, Tejun Heo <tj@kernel.org>
References: <20170306200319.GF19696@htj.duckdns.org>
 <20170309080531.9048-1-tahsin@google.com>
Cc: linux-block@vger.kernel.org, David Rientjes <rientjes@google.com>,
 linux-kernel@vger.kernel.org
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <bb97baf4-b08a-b909-1bff-7c933b95be4e@kernel.dk>
Date: Sat, 11 Mar 2017 15:42:49 -0700
MIME-Version: 1.0
In-Reply-To: <20170309080531.9048-1-tahsin@google.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

> @@ -185,31 +187,53 @@ static struct blkcg_gq *blkg_create(struct blkcg *blkcg,
>  		goto err_free_blkg;
>  	}
>  
> +	if (drop_locks) {
> +		spin_unlock_irq(q->queue_lock);
> +		rcu_read_unlock();
> +	}

I have a general dislike for code like that, where you conditionally
drop locks. And this one seems even worse, since the knowledge of
whether the locks should/could be dropped or not is embedded in the gfp
flags.

> +/**
> + * blkg_lookup_create - lookup blkg, try to create one if not there
> + *
> + * Performs an initial queue bypass check and then passes control to
> + * __blkg_lookup_create().
> + */
> +struct blkcg_gq *blkg_lookup_create(struct blkcg *blkcg,
> +				    struct request_queue *q, gfp_t gfp,
> +				    const struct blkcg_policy *pol)
> +{
> +	WARN_ON_ONCE(!rcu_read_lock_held());
> +	lockdep_assert_held(q->queue_lock);

This seems problematic, as blkcg_bio_issue_check() calls with the rcu
read lock held.

-- 
Jens Axboe
