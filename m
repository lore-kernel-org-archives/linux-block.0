Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:45646 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752735AbeDLOq3 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Apr 2018 10:46:29 -0400
Subject: Re: [PATCH 3/4] bcache: notify allocator to prepare for GC
To: tang.junhui@zte.com.cn
Cc: kent.overstreet@gmail.com, mlyle@lyle.org,
        linux-bcache@vger.kernel.org, linux-block@vger.kernel.org
References: <1523515124-2021-1-git-send-email-tang.junhui@zte.com.cn>
 <1523515124-2021-4-git-send-email-tang.junhui@zte.com.cn>
From: Coly Li <colyli@suse.de>
Message-ID: <0e320806-6804-a650-53a9-6c470e4437c4@suse.de>
Date: Thu, 12 Apr 2018 22:46:18 +0800
MIME-Version: 1.0
In-Reply-To: <1523515124-2021-4-git-send-email-tang.junhui@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 2018/4/12 2:38 PM, tang.junhui@zte.com.cn wrote:
> From: Tang Junhui <tang.junhui@zte.com.cn>
> 
> Since no new bucket can be allocated during GC, and front side I/Os would
> run out of all the buckets, so notify allocator to pack the free_inc queue
> full of buckets before GC, then we could have enough buckets for front side
> I/Os during GC period.
> 
> Signed-off-by: Tang Junhui <tang.junhui@zte.com.cn>

Hi Junhui,

This method is complicated IMHO. Why not in bch_allocator_thread()
simple call wake_up_gc(ca->set) after invalidate_buckets() ?

Thanks.

Coly Li

> ---
>  drivers/md/bcache/alloc.c  | 11 +++++++-
>  drivers/md/bcache/bcache.h |  2 ++
>  drivers/md/bcache/btree.c  | 69 ++++++++++++++++++++++++++++++++++++++++++++--
>  drivers/md/bcache/btree.h  |  4 +++
>  4 files changed, 83 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/md/bcache/alloc.c b/drivers/md/bcache/alloc.c
> index a0cc1bc..85020cc 100644
> --- a/drivers/md/bcache/alloc.c
> +++ b/drivers/md/bcache/alloc.c
> @@ -323,7 +323,8 @@ static int bch_allocator_thread(void *arg)
>  		 * possibly issue discards to them, then we add the bucket to
>  		 * the free list:
>  		 */
> -		while (!fifo_empty(&ca->free_inc)) {
> +		while (!fifo_empty(&ca->free_inc) &&
> +		       ca->prepare_gc != GC_PREPARING) {
>  			long bucket;
>  
>  			fifo_pop(&ca->free_inc, bucket);
> @@ -353,6 +354,14 @@ static int bch_allocator_thread(void *arg)
>  		invalidate_buckets(ca);
>  
>  		/*
> +		 * Let GC continue
> +		 */
> +		if (ca->prepare_gc == GC_PREPARING) {
> +			ca->prepare_gc = GC_PREPARED;
> +			wake_up_gc(ca->set);
> +		}
> +
> +		/*
>  		 * Now, we write their new gens to disk so we can start writing
>  		 * new stuff to them:
>  		 */
> diff --git a/drivers/md/bcache/bcache.h b/drivers/md/bcache/bcache.h
> index ab4c9ca..61a6ff2 100644
> --- a/drivers/md/bcache/bcache.h
> +++ b/drivers/md/bcache/bcache.h
> @@ -428,6 +428,8 @@ struct cache {
>  	 * cpu
>  	 */
>  	unsigned		invalidate_needs_gc;
> +	/* used to notify allocator to prepare GC*/
> +	unsigned int		prepare_gc;
>  
>  	bool			discard; /* Get rid of? */
>  
> diff --git a/drivers/md/bcache/btree.c b/drivers/md/bcache/btree.c
> index 10f967e..aba0700 100644
> --- a/drivers/md/bcache/btree.c
> +++ b/drivers/md/bcache/btree.c
> @@ -1805,6 +1805,46 @@ static void bch_btree_gc(struct cache_set *c)
>  	bch_moving_gc(c);
>  }
>  
> +static bool cache_gc_prepare_none(struct cache_set *c)
> +{
> +	struct cache *ca;
> +	unsigned int i;
> +
> +	for_each_cache(ca, c, i)
> +		if (ca->prepare_gc != GC_PREPARE_NONE)
> +			return false;
> +	return true;
> +}
> +
> +static bool cache_gc_prepare_ok(struct cache_set *c)
> +{
> +	struct cache *ca;
> +	unsigned int i;
> +
> +	for_each_cache(ca, c, i)
> +		if (ca->prepare_gc != GC_PREPARED)
> +			return false;
> +	return true;
> +}
> +
> +static void set_cache_gc_prepare_none(struct cache_set *c)
> +{
> +	struct cache *ca;
> +	unsigned int i;
> +
> +	for_each_cache(ca, c, i)
> +		ca->prepare_gc = GC_PREPARE_NONE;
> +}
> +
> +static void set_cache_gc_preparing(struct cache_set *c)
> +{
> +	struct cache *ca;
> +	unsigned int i;
> +
> +	for_each_cache(ca, c, i)
> +		ca->prepare_gc = GC_PREPARING;
> +}
> +
>  static bool gc_should_run(struct cache_set *c)
>  {
>  	struct cache *ca;
> @@ -1814,8 +1854,33 @@ static bool gc_should_run(struct cache_set *c)
>  		if (ca->invalidate_needs_gc)
>  			return true;
>  
> -	if (atomic_read(&c->sectors_to_gc) < 0)
> -		return true;
> +	if (atomic_read(&c->sectors_to_gc) < 0) {
> +		mutex_lock(&c->bucket_lock);
> +		if (cache_gc_prepare_none(c)) {
> +			/*
> +			 * notify allocator thread to prepare for GC
> +			 */
> +			set_cache_gc_preparing(c);
> +			mutex_unlock(&c->bucket_lock);
> +			pr_info("gc preparing");
> +			return false;
> +		} else if (cache_gc_prepare_ok(c)) {
> +			/*
> +			 * alloc thread finished preparing,
> +			 * and continue to GC
> +			 */
> +			set_cache_gc_prepare_none(c);
> +			mutex_unlock(&c->bucket_lock);
> +			pr_info("gc prepared ok");
> +			return true;
> +		} else {
> +			/*
> +			 * waitting allocator finishing prepareing
> +			 */
> +			mutex_unlock(&c->bucket_lock);
> +			return false;
> +		}
> +	}
>  
>  	return false;
>  }
> diff --git a/drivers/md/bcache/btree.h b/drivers/md/bcache/btree.h
> index d211e2c..e60bd7a 100644
> --- a/drivers/md/bcache/btree.h
> +++ b/drivers/md/bcache/btree.h
> @@ -102,6 +102,10 @@
>  #include "bset.h"
>  #include "debug.h"
>  
> +#define GC_PREPARE_NONE		0
> +#define GC_PREPARING		1
> +#define GC_PREPARED		2
> +
>  struct btree_write {
>  	atomic_t		*journal;
>  
> 
