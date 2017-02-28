Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 28 Feb 2017 17:47:28 -0500
From: Tejun Heo <tj@kernel.org>
To: Tahsin Erdogan <tahsin@google.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	David Rientjes <rientjes@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] blkcg: allocate struct blkcg_gq outside request queue
 spinlock
Message-ID: <20170228224728.GJ15287@htj.duckdns.org>
References: <20170228024957.4314-1-tahsin@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170228024957.4314-1-tahsin@google.com>
List-ID: <linux-block@vger.kernel.org>

Hello,

Overall, the approach looks good to me but please see below.

On Mon, Feb 27, 2017 at 06:49:57PM -0800, Tahsin Erdogan wrote:
> @@ -806,44 +807,99 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
>  	if (!disk)
>  		return -ENODEV;
>  	if (part) {
> -		owner = disk->fops->owner;
> -		put_disk(disk);
> -		module_put(owner);
> -		return -ENODEV;
> +		ret = -ENODEV;
> +		goto fail;
> +	}
> +
> +	q = disk->queue;
> +
> +	if (!blkcg_policy_enabled(q, pol)) {
> +		ret = -EOPNOTSUPP;
> +		goto fail;

Pulling this out of the queue_lock doesn't seem safe to me.  This
function may end up calling into callbacks of disabled policies this
way.

> +	/*
> +	 * Create blkgs walking down from blkcg_root to @blkcg, so that all
> +	 * non-root blkgs have access to their parents.
> +	 */
> +	while (true) {
> +		struct blkcg *pos = blkcg;
> +		struct blkcg *parent;
> +		struct blkcg_gq *new_blkg;
> +
> +		parent = blkcg_parent(blkcg);
> +		while (parent && !__blkg_lookup(parent, q, false)) {
> +			pos = parent;
> +			parent = blkcg_parent(parent);
> +		}

Hmm... how about adding @new_blkg to blkg_lookup_create() and calling
it with non-NULL @new_blkg until it succeeds?  Wouldn't that be
simpler?

> +
> +		new_blkg = blkg_alloc(pos, q, GFP_KERNEL);
> +		if (unlikely(!new_blkg)) {
> +			ret = -ENOMEM;
> +			goto fail;
> +		}
> +
> +		rcu_read_lock();
> +		spin_lock_irq(q->queue_lock);
> +
> +		/* Lookup again since we dropped the lock for blkg_alloc(). */
> +		blkg = __blkg_lookup(pos, q, false);
> +		if (blkg) {
> +			blkg_free(new_blkg);
> +		} else {
> +			blkg = blkg_create(pos, q, new_blkg);
> +			if (unlikely(IS_ERR(blkg))) {
> +				ret = PTR_ERR(blkg);
> +				goto fail_unlock;
> +			}

than duplicating the same logic here?

Thanks.

-- 
tejun
