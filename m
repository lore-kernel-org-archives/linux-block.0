Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:38215 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753888AbcHSLwo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Aug 2016 07:52:44 -0400
Received: by mail-wm0-f53.google.com with SMTP id o80so37096272wme.1
        for <linux-block@vger.kernel.org>; Fri, 19 Aug 2016 04:52:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1471334375-2585-1-git-send-email-adrian.hunter@intel.com>
References: <20160815181754.GA9918@lst.de> <1471334375-2585-1-git-send-email-adrian.hunter@intel.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 19 Aug 2016 13:52:41 +0200
Message-ID: <CAPDyKFpTtxX6k13kFZNQ0MiCXeaWneepZu4q1y=42ZBPQmu1ig@mail.gmail.com>
Subject: Re: [PATCH V2] block: Fix secure erase
To: Adrian Hunter <adrian.hunter@intel.com>, Jens Axboe <axboe@fb.com>
Cc: Christoph Hellwig <hch@lst.de>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        linux-block@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 16 August 2016 at 09:59, Adrian Hunter <adrian.hunter@intel.com> wrote:
> Commit 288dab8a35a0 ("block: add a separate operation type for secure
> erase") split REQ_OP_SECURE_ERASE from REQ_OP_DISCARD without considering
> all the places REQ_OP_DISCARD was being used to mean either. Fix those.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> Fixes: 288dab8a35a0 ("block: add a separate operation type for secure erase")

For the mmc parts:

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Jens, will you pick this up via your tree?

Kind regards
Uffe

> ---
>
>
> Changes in V2:
>         In elv_dispatch_sort() don't allow requests with different ops to pass
>         one another.
>
>
>  block/bio.c              | 21 +++++++++++----------
>  block/blk-merge.c        | 33 +++++++++++++++++++--------------
>  block/elevator.c         |  2 +-
>  drivers/mmc/card/block.c |  1 +
>  drivers/mmc/card/queue.c |  3 ++-
>  drivers/mmc/card/queue.h |  4 +++-
>  include/linux/bio.h      | 10 ++++++++--
>  include/linux/blkdev.h   |  6 ++++--
>  kernel/trace/blktrace.c  |  2 +-
>  9 files changed, 50 insertions(+), 32 deletions(-)
>
> diff --git a/block/bio.c b/block/bio.c
> index f39477538fef..aa7354088008 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -667,18 +667,19 @@ struct bio *bio_clone_bioset(struct bio *bio_src, gfp_t gfp_mask,
>         bio->bi_iter.bi_sector  = bio_src->bi_iter.bi_sector;
>         bio->bi_iter.bi_size    = bio_src->bi_iter.bi_size;
>
> -       if (bio_op(bio) == REQ_OP_DISCARD)
> -               goto integrity_clone;
> -
> -       if (bio_op(bio) == REQ_OP_WRITE_SAME) {
> +       switch (bio_op(bio)) {
> +       case REQ_OP_DISCARD:
> +       case REQ_OP_SECURE_ERASE:
> +               break;
> +       case REQ_OP_WRITE_SAME:
>                 bio->bi_io_vec[bio->bi_vcnt++] = bio_src->bi_io_vec[0];
> -               goto integrity_clone;
> +               break;
> +       default:
> +               bio_for_each_segment(bv, bio_src, iter)
> +                       bio->bi_io_vec[bio->bi_vcnt++] = bv;
> +               break;
>         }
>
> -       bio_for_each_segment(bv, bio_src, iter)
> -               bio->bi_io_vec[bio->bi_vcnt++] = bv;
> -
> -integrity_clone:
>         if (bio_integrity(bio_src)) {
>                 int ret;
>
> @@ -1788,7 +1789,7 @@ struct bio *bio_split(struct bio *bio, int sectors,
>          * Discards need a mutable bio_vec to accommodate the payload
>          * required by the DSM TRIM and UNMAP commands.
>          */
> -       if (bio_op(bio) == REQ_OP_DISCARD)
> +       if (bio_op(bio) == REQ_OP_DISCARD || bio_op(bio) == REQ_OP_SECURE_ERASE)
>                 split = bio_clone_bioset(bio, gfp, bs);
>         else
>                 split = bio_clone_fast(bio, gfp, bs);
> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index 3eec75a9e91d..72627e3cf91e 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -172,12 +172,18 @@ void blk_queue_split(struct request_queue *q, struct bio **bio,
>         struct bio *split, *res;
>         unsigned nsegs;
>
> -       if (bio_op(*bio) == REQ_OP_DISCARD)
> +       switch (bio_op(*bio)) {
> +       case REQ_OP_DISCARD:
> +       case REQ_OP_SECURE_ERASE:
>                 split = blk_bio_discard_split(q, *bio, bs, &nsegs);
> -       else if (bio_op(*bio) == REQ_OP_WRITE_SAME)
> +               break;
> +       case REQ_OP_WRITE_SAME:
>                 split = blk_bio_write_same_split(q, *bio, bs, &nsegs);
> -       else
> +               break;
> +       default:
>                 split = blk_bio_segment_split(q, *bio, q->bio_split, &nsegs);
> +               break;
> +       }
>
>         /* physical segments can be figured out during splitting */
>         res = split ? split : *bio;
> @@ -213,7 +219,7 @@ static unsigned int __blk_recalc_rq_segments(struct request_queue *q,
>          * This should probably be returning 0, but blk_add_request_payload()
>          * (Christoph!!!!)
>          */
> -       if (bio_op(bio) == REQ_OP_DISCARD)
> +       if (bio_op(bio) == REQ_OP_DISCARD || bio_op(bio) == REQ_OP_SECURE_ERASE)
>                 return 1;
>
>         if (bio_op(bio) == REQ_OP_WRITE_SAME)
> @@ -385,7 +391,9 @@ static int __blk_bios_map_sg(struct request_queue *q, struct bio *bio,
>         nsegs = 0;
>         cluster = blk_queue_cluster(q);
>
> -       if (bio_op(bio) == REQ_OP_DISCARD) {
> +       switch (bio_op(bio)) {
> +       case REQ_OP_DISCARD:
> +       case REQ_OP_SECURE_ERASE:
>                 /*
>                  * This is a hack - drivers should be neither modifying the
>                  * biovec, nor relying on bi_vcnt - but because of
> @@ -393,19 +401,16 @@ static int __blk_bios_map_sg(struct request_queue *q, struct bio *bio,
>                  * a payload we need to set up here (thank you Christoph) and
>                  * bi_vcnt is really the only way of telling if we need to.
>                  */
> -
> -               if (bio->bi_vcnt)
> -                       goto single_segment;
> -
> -               return 0;
> -       }
> -
> -       if (bio_op(bio) == REQ_OP_WRITE_SAME) {
> -single_segment:
> +               if (!bio->bi_vcnt)
> +                       return 0;
> +               /* Fall through */
> +       case REQ_OP_WRITE_SAME:
>                 *sg = sglist;
>                 bvec = bio_iovec(bio);
>                 sg_set_page(*sg, bvec.bv_page, bvec.bv_len, bvec.bv_offset);
>                 return 1;
> +       default:
> +               break;
>         }
>
>         for_each_bio(bio)
> diff --git a/block/elevator.c b/block/elevator.c
> index 7096c22041e7..f7d973a56fd7 100644
> --- a/block/elevator.c
> +++ b/block/elevator.c
> @@ -366,7 +366,7 @@ void elv_dispatch_sort(struct request_queue *q, struct request *rq)
>         list_for_each_prev(entry, &q->queue_head) {
>                 struct request *pos = list_entry_rq(entry);
>
> -               if ((req_op(rq) == REQ_OP_DISCARD) != (req_op(pos) == REQ_OP_DISCARD))
> +               if (req_op(rq) != req_op(pos))
>                         break;
>                 if (rq_data_dir(rq) != rq_data_dir(pos))
>                         break;
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> index 48a5dd740f3b..82503e6f04b3 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -1726,6 +1726,7 @@ static u8 mmc_blk_prep_packed_list(struct mmc_queue *mq, struct request *req)
>                         break;
>
>                 if (req_op(next) == REQ_OP_DISCARD ||
> +                   req_op(next) == REQ_OP_SECURE_ERASE ||
>                     req_op(next) == REQ_OP_FLUSH)
>                         break;
>
> diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
> index bf14642a576a..29578e98603d 100644
> --- a/drivers/mmc/card/queue.c
> +++ b/drivers/mmc/card/queue.c
> @@ -33,7 +33,8 @@ static int mmc_prep_request(struct request_queue *q, struct request *req)
>         /*
>          * We only like normal block requests and discards.
>          */
> -       if (req->cmd_type != REQ_TYPE_FS && req_op(req) != REQ_OP_DISCARD) {
> +       if (req->cmd_type != REQ_TYPE_FS && req_op(req) != REQ_OP_DISCARD &&
> +           req_op(req) != REQ_OP_SECURE_ERASE) {
>                 blk_dump_rq_flags(req, "MMC bad request");
>                 return BLKPREP_KILL;
>         }
> diff --git a/drivers/mmc/card/queue.h b/drivers/mmc/card/queue.h
> index d62531124d54..fee5e1271465 100644
> --- a/drivers/mmc/card/queue.h
> +++ b/drivers/mmc/card/queue.h
> @@ -4,7 +4,9 @@
>  static inline bool mmc_req_is_special(struct request *req)
>  {
>         return req &&
> -               (req_op(req) == REQ_OP_FLUSH || req_op(req) == REQ_OP_DISCARD);
> +               (req_op(req) == REQ_OP_FLUSH ||
> +                req_op(req) == REQ_OP_DISCARD ||
> +                req_op(req) == REQ_OP_SECURE_ERASE);
>  }
>
>  struct request;
> diff --git a/include/linux/bio.h b/include/linux/bio.h
> index 59ffaa68b11b..23ddf4b46a9b 100644
> --- a/include/linux/bio.h
> +++ b/include/linux/bio.h
> @@ -71,7 +71,8 @@ static inline bool bio_has_data(struct bio *bio)
>  {
>         if (bio &&
>             bio->bi_iter.bi_size &&
> -           bio_op(bio) != REQ_OP_DISCARD)
> +           bio_op(bio) != REQ_OP_DISCARD &&
> +           bio_op(bio) != REQ_OP_SECURE_ERASE)
>                 return true;
>
>         return false;
> @@ -79,7 +80,9 @@ static inline bool bio_has_data(struct bio *bio)
>
>  static inline bool bio_no_advance_iter(struct bio *bio)
>  {
> -       return bio_op(bio) == REQ_OP_DISCARD || bio_op(bio) == REQ_OP_WRITE_SAME;
> +       return bio_op(bio) == REQ_OP_DISCARD ||
> +              bio_op(bio) == REQ_OP_SECURE_ERASE ||
> +              bio_op(bio) == REQ_OP_WRITE_SAME;
>  }
>
>  static inline bool bio_is_rw(struct bio *bio)
> @@ -199,6 +202,9 @@ static inline unsigned bio_segments(struct bio *bio)
>         if (bio_op(bio) == REQ_OP_DISCARD)
>                 return 1;
>
> +       if (bio_op(bio) == REQ_OP_SECURE_ERASE)
> +               return 1;
> +
>         if (bio_op(bio) == REQ_OP_WRITE_SAME)
>                 return 1;
>
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 2c210b6a7bcf..e79055c8b577 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -882,7 +882,7 @@ static inline unsigned int blk_rq_cur_sectors(const struct request *rq)
>  static inline unsigned int blk_queue_get_max_sectors(struct request_queue *q,
>                                                      int op)
>  {
> -       if (unlikely(op == REQ_OP_DISCARD))
> +       if (unlikely(op == REQ_OP_DISCARD || op == REQ_OP_SECURE_ERASE))
>                 return min(q->limits.max_discard_sectors, UINT_MAX >> 9);
>
>         if (unlikely(op == REQ_OP_WRITE_SAME))
> @@ -913,7 +913,9 @@ static inline unsigned int blk_rq_get_max_sectors(struct request *rq,
>         if (unlikely(rq->cmd_type != REQ_TYPE_FS))
>                 return q->limits.max_hw_sectors;
>
> -       if (!q->limits.chunk_sectors || (req_op(rq) == REQ_OP_DISCARD))
> +       if (!q->limits.chunk_sectors ||
> +           req_op(rq) == REQ_OP_DISCARD ||
> +           req_op(rq) == REQ_OP_SECURE_ERASE)
>                 return blk_queue_get_max_sectors(q, req_op(rq));
>
>         return min(blk_max_size_offset(q, offset),
> diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
> index 7598e6ca817a..dbafc5df03f3 100644
> --- a/kernel/trace/blktrace.c
> +++ b/kernel/trace/blktrace.c
> @@ -223,7 +223,7 @@ static void __blk_add_trace(struct blk_trace *bt, sector_t sector, int bytes,
>         what |= MASK_TC_BIT(op_flags, META);
>         what |= MASK_TC_BIT(op_flags, PREFLUSH);
>         what |= MASK_TC_BIT(op_flags, FUA);
> -       if (op == REQ_OP_DISCARD)
> +       if (op == REQ_OP_DISCARD || op == REQ_OP_SECURE_ERASE)
>                 what |= BLK_TC_ACT(BLK_TC_DISCARD);
>         if (op == REQ_OP_FLUSH)
>                 what |= BLK_TC_ACT(BLK_TC_FLUSH);
> --
> 1.9.1
>
