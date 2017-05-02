Return-Path: <BATV+0ce91e3c8ec9178008cb+5000+infradead.org+hch@bombadil.srs.infradead.org>
Date: Tue, 2 May 2017 01:14:25 -0700
From: Christoph Hellwig <hch@infradead.org>
To: NeilBrown <neilb@suse.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Ming Lei <tom.leiming@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/13] blk: make the bioset rescue_workqueue optional.
Message-ID: <20170502081425.GC5578@infradead.org>
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

Please avoid > 80 char lines.

Otherwise looks fine,

Reviewed-by: Christoph Hellwig <hch@lst.de>
