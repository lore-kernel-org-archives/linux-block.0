Return-Path: <ming.lei@redhat.com>
Date: Sat, 9 Dec 2017 07:54:52 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Michele Ballabio <barra_cuda@katamail.com>,
	linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	linux-block@vger.kernel.org
Subject: Re: block: oopses on 4.13.*, 4.14.* and 4.15-rc2 (bisected)
Message-ID: <20171208235446.GB15393@ming.t460p>
References: <20171208163851.0f3823b6@darkstar.example.org>
 <f59e66c4-e09b-95aa-a5a5-f26288beb3f0@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <f59e66c4-e09b-95aa-a5a5-f26288beb3f0@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Fri, Dec 08, 2017 at 01:08:37PM -0700, Jens Axboe wrote:
> On 12/08/2017 08:38 AM, Michele Ballabio wrote:
> > Hi,
> > 	kernels 4.13.*, 4.14.* 4.15-rc2 crash on occasion, especially
> > on x86-32 systems. To trigger the problem, run as root:
> > 
> > while true
> > do
> >         /sbin/udevadm trigger --type=subsystems --action=change
> >         /sbin/udevadm trigger --type=devices --action=change
> >         /sbin/udevadm settle --timeout=120
> > done
> > 
> > (Thanks to Patrick Volkerding for the reproducer).
> > 
> > Sometimes the kernel oopses immediately, sometimes a bit later (less than
> > five minutes).
> > 
> > The bisection pointed to commit caa4b02476e31fc7933d2138062f7f355d3cd8f7
> > (blk-map: call blk_queue_bounce from blk_rq_append_bio). A revert
> > fixes the problem (tested on 4.13 and master).
> 
> Thanks for your report - can you try the below patch? Totally
> untested...
> 
> 
> diff --git a/block/blk-map.c b/block/blk-map.c
> index b21f8e86f120..ad970719a1fc 100644
> --- a/block/blk-map.c
> +++ b/block/blk-map.c
> @@ -12,22 +12,22 @@
>  #include "blk.h"
>  
>  /*
> - * Append a bio to a passthrough request.  Only works can be merged into
> - * the request based on the driver constraints.
> + * Append a bio to a passthrough request.  Only works if the bio can be merged
> + * into the request based on the driver constraints.
>   */
> -int blk_rq_append_bio(struct request *rq, struct bio *bio)
> +int blk_rq_append_bio(struct request *rq, struct bio **bio)
>  {
> -	blk_queue_bounce(rq->q, &bio);
> +	blk_queue_bounce(rq->q, bio);
>  
>  	if (!rq->bio) {
> -		blk_rq_bio_prep(rq->q, rq, bio);
> +		blk_rq_bio_prep(rq->q, rq, *bio);
>  	} else {
> -		if (!ll_back_merge_fn(rq->q, rq, bio))
> +		if (!ll_back_merge_fn(rq->q, rq, *bio))
>  			return -EINVAL;
>  
> -		rq->biotail->bi_next = bio;
> -		rq->biotail = bio;
> -		rq->__data_len += bio->bi_iter.bi_size;
> +		rq->biotail->bi_next = *bio;
> +		rq->biotail = *bio;
> +		rq->__data_len += (*bio)->bi_iter.bi_size;
>  	}
>  
>  	return 0;
> @@ -73,8 +73,9 @@ static int __blk_rq_map_user_iov(struct request *rq,
>  	 * We link the bounce buffer in and could have to traverse it
>  	 * later so we have to get a ref to prevent it from being freed
>  	 */
> -	ret = blk_rq_append_bio(rq, bio);
>  	bio_get(bio);
> +
> +	ret = blk_rq_append_bio(rq, &bio);
>  	if (ret) {
>  		bio_endio(bio);
>  		__blk_rq_unmap_user(orig_bio);
> @@ -236,7 +237,7 @@ int blk_rq_map_kern(struct request_queue *q, struct request *rq, void *kbuf,
>  	if (do_copy)
>  		rq->rq_flags |= RQF_COPY_USER;
>  
> -	ret = blk_rq_append_bio(rq, bio);
> +	ret = blk_rq_append_bio(rq, &bio);
>  	if (unlikely(ret)) {
>  		/* request is too big */
>  		bio_put(bio);
> diff --git a/drivers/scsi/osd/osd_initiator.c b/drivers/scsi/osd/osd_initiator.c
> index a4f28b7e4c65..e18877177f1b 100644
> --- a/drivers/scsi/osd/osd_initiator.c
> +++ b/drivers/scsi/osd/osd_initiator.c
> @@ -1576,7 +1576,9 @@ static struct request *_make_request(struct request_queue *q, bool has_write,
>  		return req;
>  
>  	for_each_bio(bio) {
> -		ret = blk_rq_append_bio(req, bio);
> +		struct bio *bounce_bio = bio;
> +
> +		ret = blk_rq_append_bio(req, &bounce_bio);
>  		if (ret)
>  			return ERR_PTR(ret);
>  	}
> diff --git a/drivers/target/target_core_pscsi.c b/drivers/target/target_core_pscsi.c
> index 7c69b4a9694d..0d99b242e82e 100644
> --- a/drivers/target/target_core_pscsi.c
> +++ b/drivers/target/target_core_pscsi.c
> @@ -920,7 +920,7 @@ pscsi_map_sg(struct se_cmd *cmd, struct scatterlist *sgl, u32 sgl_nents,
>  					" %d i: %d bio: %p, allocating another"
>  					" bio\n", bio->bi_vcnt, i, bio);
>  
> -				rc = blk_rq_append_bio(req, bio);
> +				rc = blk_rq_append_bio(req, &bio);
>  				if (rc) {
>  					pr_err("pSCSI: failed to append bio\n");
>  					goto fail;
> @@ -938,7 +938,7 @@ pscsi_map_sg(struct se_cmd *cmd, struct scatterlist *sgl, u32 sgl_nents,
>  	}
>  
>  	if (bio) {
> -		rc = blk_rq_append_bio(req, bio);
> +		rc = blk_rq_append_bio(req, &bio);
>  		if (rc) {
>  			pr_err("pSCSI: failed to append bio\n");
>  			goto fail;
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 8089ca17db9a..06b88d38f611 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -948,7 +948,7 @@ extern int blk_rq_prep_clone(struct request *rq, struct request *rq_src,
>  extern void blk_rq_unprep_clone(struct request *rq);
>  extern blk_status_t blk_insert_cloned_request(struct request_queue *q,
>  				     struct request *rq);
> -extern int blk_rq_append_bio(struct request *rq, struct bio *bio);
> +extern int blk_rq_append_bio(struct request *rq, struct bio **bio);
>  extern void blk_delay_queue(struct request_queue *, unsigned long);
>  extern void blk_queue_split(struct request_queue *, struct bio **);
>  extern void blk_recount_segments(struct request_queue *, struct bio *);

Hi Jens,

I can reproduce this issue every time by forcing bounce on virtio-scsi
and enabling NEED_BOUNCE_POOL.

After applying your patch, there is still kernel oops[1].

I traced it a bit and found the following patch[2] makes a difference by
getting rid of copying iov_iter, but I guess this one is related with
the gcc(6.4.1 20170727).

Even though both your patch and the patch of 'bio_copy_to_iter: get rid
of copying iov_iter' are applied, there is still another oops[3].


[1] kernel oops after applying Jens's patch

https://pastebin.com/kn53fKY5

[2] patch of 'bio_copy_to_iter: get rid of copying iov_iter'
 block/bio.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 76bb3dafffea..baa8e447eeb1 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1090,7 +1090,7 @@ static int bio_copy_from_iter(struct bio *bio, struct iov_iter *iter)
  * Copy all pages from bio to iov_iter.
  * Returns 0 on success, or error on failure.
  */
-static int bio_copy_to_iter(struct bio *bio, struct iov_iter iter)
+static int bio_copy_to_iter(struct bio *bio, struct iov_iter *iter)
 {
 	int i;
 	struct bio_vec *bvec;
@@ -1101,9 +1101,9 @@ static int bio_copy_to_iter(struct bio *bio, struct iov_iter iter)
 		ret = copy_page_to_iter(bvec->bv_page,
 					bvec->bv_offset,
 					bvec->bv_len,
-					&iter);
+					iter);
 
-		if (!iov_iter_count(&iter))
+		if (!iov_iter_count(iter))
 			break;
 
 		if (ret < bvec->bv_len)
@@ -1144,7 +1144,7 @@ int bio_uncopy_user(struct bio *bio)
 		if (!current->mm)
 			ret = -EINTR;
 		else if (bio_data_dir(bio) == READ)
-			ret = bio_copy_to_iter(bio, bmd->iter);
+			ret = bio_copy_to_iter(bio, &bmd->iter);
 		if (bmd->is_our_pages)
 			bio_free_pages(bio);
 	}

[3] kernel oops after applying Jens's patch and the attached patch of
'bio_copy_to_iter: get rid of copying iov_iter'

https://pastebin.com/3fMEhkWy


-- 
Ming
