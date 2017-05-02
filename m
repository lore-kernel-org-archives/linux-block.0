Return-Path: <ming.lei@redhat.com>
Date: Tue, 2 May 2017 19:00:07 +0800
From: Ming Lei <ming.lei@redhat.com>
To: NeilBrown <neilb@suse.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Ming Lei <tom.leiming@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/13] blk: make the bioset rescue_workqueue optional.
Message-ID: <20170502105859.GC1803@ming.t460p>
References: <149369628671.5146.4865312503373040039.stgit@noble>
 <149369654434.5146.15331164625586213889.stgit@noble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <149369654434.5146.15331164625586213889.stgit@noble>
List-ID: <linux-block@vger.kernel.org>

On Tue, May 02, 2017 at 01:42:24PM +1000, NeilBrown wrote:
> This patch converts bioset_create() and
> bioset_create_nobvec() to not create a workqueue so
> alloctions will never trigger punt_bios_to_rescuer().  It
> also introduces bioset_create_rescued() and
> bioset_create_nobvec_rescued() which preserve the old
> behaviour.
> 
> All callers of bioset_create() and bioset_create_nobvec(),
> that are inside block device drivers, are converted to the
> _rescued() version.

The above comment about *_nobvec() need to be updated.

> 
> biosets used by filesystems or other top-level users do not
> need rescuing as the bio can never be queued behind other
> bios.  This includes fs_bio_set, blkdev_dio_pool,
> btrfs_bioset, xfs_ioend_bioset, drbd_md_io_bio_set,
> and one allocated by target_core_iblock.c.
> 
> biosets used by md/raid to not need rescuing as
> their usage was recently audited to revised to never
> risk deadlock.
> 
> It is hoped that most, if not all, of the remaining biosets
> can end up being the non-rescued version.
> 
> Signed-off-by: NeilBrown <neilb@suse.com>
> ---
>  block/bio.c               |   12 ++++++++++--
>  block/blk-core.c          |    2 +-
>  drivers/md/bcache/super.c |    6 ++++--
>  drivers/md/dm-crypt.c     |    2 +-
>  drivers/md/dm-io.c        |    2 +-
>  drivers/md/dm.c           |    5 +++--
>  include/linux/bio.h       |    1 +
>  7 files changed, 21 insertions(+), 9 deletions(-)

DRBD can stack on block device too, so I guess it might need
BIOSET_NEED_RESCUER?

> 
> diff --git a/block/bio.c b/block/bio.c
> index 3f1286ed301e..257606e742e0 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -363,6 +363,8 @@ static void punt_bios_to_rescuer(struct bio_set *bs)
>  	struct bio_list punt, nopunt;
>  	struct bio *bio;
>  
> +	if (!WARN_ON_ONCE(!bs->rescue_workqueue))
> +		return;

I guess the above check should have been the following?

	if (WARN_ON_ONCE(!bs->rescue_workqueue))
		return;

>  	/*
>  	 * In order to guarantee forward progress we must punt only bios that
>  	 * were allocated from this bio_set; otherwise, if there was a bio on
> @@ -474,7 +476,8 @@ struct bio *bio_alloc_bioset(gfp_t gfp_mask, unsigned int nr_iovecs,
>  
>  		if (current->bio_list &&
>  		    (!bio_list_empty(&current->bio_list[0]) ||
> -		     !bio_list_empty(&current->bio_list[1])))
> +		     !bio_list_empty(&current->bio_list[1])) &&
> +		    bs->rescue_workqueue)
>  			gfp_mask &= ~__GFP_DIRECT_RECLAIM;
>  
>  		p = mempool_alloc(bs->bio_pool, gfp_mask);
> @@ -1925,7 +1928,7 @@ EXPORT_SYMBOL(bioset_free);
>   * bioset_create  - Create a bio_set
>   * @pool_size:	Number of bio and bio_vecs to cache in the mempool
>   * @front_pad:	Number of bytes to allocate in front of the returned bio
> - * @flags:	Flags to modify behavior, currently only %BIOSET_NEED_BVECS
> + * @flags:	Flags to modify behavior, currently %BIOSET_NEED_BVECS and %BIOSET_NEED_RESCUER
>   *
>   * Description:
>   *    Set up a bio_set to be used with @bio_alloc_bioset. Allows the caller
> @@ -1936,6 +1939,8 @@ EXPORT_SYMBOL(bioset_free);
>   *    or things will break badly.
>   *    If %BIOSET_NEED_BVECS is set in @flags, a separate pool will be allocated
>   *    for allocating iovecs.  This pool is not needed e.g. for bio_clone_fast().
> + *    If %BIOSET_NEED_RESCUER is set, workqueue is create which can be used to
> + *    dispatch queued requests when the mempool runs out of space.
>   *
>   */
>  struct bio_set *bioset_create(unsigned int pool_size,
> @@ -1971,6 +1976,9 @@ struct bio_set *bioset_create(unsigned int pool_size,
>  			goto bad;
>  	}
>  
> +	if (!(flags & BIOSET_NEED_RESCUER))
> +		return bs;
> +
>  	bs->rescue_workqueue = alloc_workqueue("bioset", WQ_MEM_RECLAIM, 0);
>  	if (!bs->rescue_workqueue)
>  		goto bad;
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 3797753f4085..ae51f159a2ca 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -730,7 +730,7 @@ struct request_queue *blk_alloc_queue_node(gfp_t gfp_mask, int node_id)
>  	if (q->id < 0)
>  		goto fail_q;
>  
> -	q->bio_split = bioset_create(BIO_POOL_SIZE, 0, BIOSET_NEED_BVECS);
> +	q->bio_split = bioset_create(BIO_POOL_SIZE, 0, BIOSET_NEED_BVECS | BIOSET_NEED_RESCUER);
>  	if (!q->bio_split)
>  		goto fail_id;
>  
> diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
> index 8b9dae98cc7e..bb50991a82d3 100644
> --- a/drivers/md/bcache/super.c
> +++ b/drivers/md/bcache/super.c
> @@ -786,7 +786,8 @@ static int bcache_device_init(struct bcache_device *d, unsigned block_size,
>  
>  	minor *= BCACHE_MINORS;
>  
> -	if (!(d->bio_split = bioset_create(4, offsetof(struct bbio, bio), BIOSET_NEED_BVECS)) ||
> +	if (!(d->bio_split = bioset_create(4, offsetof(struct bbio, bio),
> +					   BIOSET_NEED_BVECS | BIOSET_NEED_RESCUER)) ||
>  	    !(d->disk = alloc_disk(BCACHE_MINORS))) {
>  		ida_simple_remove(&bcache_minor, minor);
>  		return -ENOMEM;
> @@ -1520,7 +1521,8 @@ struct cache_set *bch_cache_set_alloc(struct cache_sb *sb)
>  				sizeof(struct bbio) + sizeof(struct bio_vec) *
>  				bucket_pages(c))) ||
>  	    !(c->fill_iter = mempool_create_kmalloc_pool(1, iter_size)) ||
> -	    !(c->bio_split = bioset_create(4, offsetof(struct bbio, bio), BIOSET_NEED_BVECS)) ||
> +	    !(c->bio_split = bioset_create(4, offsetof(struct bbio, bio),
> +					   BIOSET_NEED_BVECS | BIOSET_NEED_RESCUER)) ||
>  	    !(c->uuids = alloc_bucket_pages(GFP_KERNEL, c)) ||
>  	    !(c->moving_gc_wq = alloc_workqueue("bcache_gc",
>  						WQ_MEM_RECLAIM, 0)) ||
> diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
> index 5a98c1eb87d9..87155eb7b39c 100644
> --- a/drivers/md/dm-crypt.c
> +++ b/drivers/md/dm-crypt.c
> @@ -1936,7 +1936,7 @@ static int crypt_ctr(struct dm_target *ti, unsigned int argc, char **argv)
>  		goto bad;
>  	}
>  
> -	cc->bs = bioset_create(MIN_IOS, 0, BIOSET_NEED_BVECS);
> +	cc->bs = bioset_create(MIN_IOS, 0, BIOSET_NEED_BVECS | BIOSET_NEED_RESCUER);
>  	if (!cc->bs) {
>  		ti->error = "Cannot allocate crypt bioset";
>  		goto bad;
> diff --git a/drivers/md/dm-io.c b/drivers/md/dm-io.c
> index 1d86d1d39d48..95b9ac98fe0c 100644
> --- a/drivers/md/dm-io.c
> +++ b/drivers/md/dm-io.c
> @@ -58,7 +58,7 @@ struct dm_io_client *dm_io_client_create(void)
>  	if (!client->pool)
>  		goto bad;
>  
> -	client->bios = bioset_create(min_ios, 0, BIOSET_NEED_BVECS);
> +	client->bios = bioset_create(min_ios, 0, BIOSET_NEED_BVECS | BIOSET_NEED_RESCUER);
>  	if (!client->bios)
>  		goto bad;
>  
> diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> index e21a7d58c8ef..4f96556cb8c5 100644
> --- a/drivers/md/dm.c
> +++ b/drivers/md/dm.c
> @@ -1014,7 +1014,8 @@ static void flush_current_bio_list(struct blk_plug_cb *cb, bool from_schedule)
>  
>  		while ((bio = bio_list_pop(&list))) {
>  			struct bio_set *bs = bio->bi_pool;
> -			if (unlikely(!bs) || bs == fs_bio_set) {
> +			if (unlikely(!bs) || bs == fs_bio_set ||
> +			    !bs->rescue_workqueue) {
>  				bio_list_add(&current->bio_list[i], bio);
>  				continue;
>  			}
> @@ -2601,7 +2602,7 @@ struct dm_md_mempools *dm_alloc_md_mempools(struct mapped_device *md, unsigned t
>  		BUG();
>  	}
>  
> -	pools->bs = bioset_create(pool_size, front_pad, 0);
> +	pools->bs = bioset_create(pool_size, front_pad, BIOSET_NEED_RESCUER);
>  	if (!pools->bs)
>  		goto out;
>  
> diff --git a/include/linux/bio.h b/include/linux/bio.h
> index 0975da6bebd9..40e5d7b62f29 100644
> --- a/include/linux/bio.h
> +++ b/include/linux/bio.h
> @@ -376,6 +376,7 @@ static inline struct bio *bio_next_split(struct bio *bio, int sectors,
>  extern struct bio_set *bioset_create(unsigned int, unsigned int, int flags);
>  enum {
>  	BIOSET_NEED_BVECS = BIT(0),
> +	BIOSET_NEED_RESCUER = BIT(1),
>  };
>  extern void bioset_free(struct bio_set *);
>  extern mempool_t *biovec_create_pool(int pool_entries);
> 
> 

Thanks,
Ming
