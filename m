Return-Path: <ming.lei@redhat.com>
Date: Tue, 2 May 2017 19:54:20 +0800
From: Ming Lei <ming.lei@redhat.com>
To: NeilBrown <neilb@suse.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Ming Lei <tom.leiming@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/13] blk: use non-rescuing bioset for q->bio_split.
Message-ID: <20170502115419.GD1803@ming.t460p>
References: <149369628671.5146.4865312503373040039.stgit@noble>
 <149369654452.5146.12018336836086489178.stgit@noble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <149369654452.5146.12018336836086489178.stgit@noble>
List-ID: <linux-block@vger.kernel.org>

On Tue, May 02, 2017 at 01:42:24PM +1000, NeilBrown wrote:
> A rescuing bioset is only useful if there might be bios from
> that same bioset on the bio_list_on_stack queue at a time
> when bio_alloc_bioset() is called.  This never applies to
> q->bio_split.
> 
> Allocations from q->bio_split are only ever made from
> blk_queue_split() which is only ever called early in each of
> various make_request_fn()s.  The original bio (call this A)
> is then passed to generic_make_request() and is placed on
> the bio_list_on_stack queue, and the bio that was allocated
> from q->bio_split (B) is processed.
> 
> The processing of this may cause other bios to be passed to
> generic_make_request() or may even cause the bio B itself to
> be passed, possible after some prefix has been split off
> (using some other bioset).
> 
> generic_make_request() now guarantees that all of these bios
> (B and dependants) will be fully processed before the tail
> of the original bio A gets handled.  None of these early bios
> can possible trigger an allocation from the original
> q->bio_split as they are either too small to require
> splitting or (more likely) are destined for a different queue.
> 
> The next time that the original q->bio_split might be used
> by this thread is when A is processed again, as it might
> still be too big to handle directly.  By this time there
> cannot be any other bios allocated from q->bio_split in the
> generic_make_request() queue.  So no rescuing will ever be
> needed.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: NeilBrown <neilb@suse.com>
> ---
>  block/blk-core.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index ae51f159a2ca..3797753f4085 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -730,7 +730,7 @@ struct request_queue *blk_alloc_queue_node(gfp_t gfp_mask, int node_id)
>  	if (q->id < 0)
>  		goto fail_q;
>  
> -	q->bio_split = bioset_create(BIO_POOL_SIZE, 0, BIOSET_NEED_BVECS | BIOSET_NEED_RESCUER);
> +	q->bio_split = bioset_create(BIO_POOL_SIZE, 0, BIOSET_NEED_BVECS);
>  	if (!q->bio_split)
>  		goto fail_id;
>  
> 
> 

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming
