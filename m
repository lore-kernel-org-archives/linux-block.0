Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:39773 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751108AbdBOLNb (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Feb 2017 06:13:31 -0500
Subject: Re: [PATCH 4/7] nonblocking aio: return on congested block device
To: Ming Lei <tom.leiming@gmail.com>,
        Goldwyn Rodrigues <rgoldwyn@suse.de>
References: <20170214024603.9563-1-rgoldwyn@suse.de>
 <20170214024603.9563-5-rgoldwyn@suse.de>
 <CACVXFVMx4=WBpYq0a3vtQri_D3NCnGJk4J5yyZwHzktTwO1yFw@mail.gmail.com>
Cc: Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>,
        linux-block <linux-block@vger.kernel.org>
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
Message-ID: <50b81116-efbd-77cd-7b9d-994938aefb09@suse.de>
Date: Wed, 15 Feb 2017 05:13:26 -0600
MIME-Version: 1.0
In-Reply-To: <CACVXFVMx4=WBpYq0a3vtQri_D3NCnGJk4J5yyZwHzktTwO1yFw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org



On 02/13/2017 09:55 PM, Ming Lei wrote:
> On Tue, Feb 14, 2017 at 10:46 AM, Goldwyn Rodrigues <rgoldwyn@suse.de> wrote:
>> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
>>
>> A new flag BIO_NONBLOCKING is introduced to identify bio's
>> orignating from iocb with IOCB_NONBLOCKING. struct request
>> are requested using BLK_MQ_REQ_NOWAIT if BIO_NONBLOCKING is set.
>>
>> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
>> ---
>>  block/blk-core.c          | 13 +++++++++++--
>>  block/blk-mq.c            | 18 ++++++++++++++++--
>>  fs/direct-io.c            | 11 +++++++++--
>>  include/linux/blk_types.h |  1 +
>>  4 files changed, 37 insertions(+), 6 deletions(-)
>>
>> diff --git a/block/blk-core.c b/block/blk-core.c
>> index 14d7c07..9767573 100644
>> --- a/block/blk-core.c
>> +++ b/block/blk-core.c
>> @@ -1257,6 +1257,11 @@ static struct request *get_request(struct request_queue *q, int op,
>>         if (!IS_ERR(rq))
>>                 return rq;
>>
>> +       if (bio_flagged(bio, BIO_NONBLOCKING)) {
>> +               blk_put_rl(rl);
>> +               return ERR_PTR(-EAGAIN);
>> +       }
>> +
>>         if (!gfpflags_allow_blocking(gfp_mask) || unlikely(blk_queue_dying(q))) {
>>                 blk_put_rl(rl);
>>                 return rq;
>> @@ -2035,7 +2040,7 @@ blk_qc_t generic_make_request(struct bio *bio)
>>         do {
>>                 struct request_queue *q = bdev_get_queue(bio->bi_bdev);
>>
>> -               if (likely(blk_queue_enter(q, false) == 0)) {
>> +               if (likely(blk_queue_enter(q, bio_flagged(bio, BIO_NONBLOCKING)) == 0)) {
>>                         ret = q->make_request_fn(q, bio);
>>
>>                         blk_queue_exit(q);
>> @@ -2044,7 +2049,11 @@ blk_qc_t generic_make_request(struct bio *bio)
>>                 } else {
>>                         struct bio *bio_next = bio_list_pop(current->bio_list);
>>
>> -                       bio_io_error(bio);
>> +                       if (unlikely(bio_flagged(bio, BIO_NONBLOCKING))) {
>> +                               bio->bi_error = -EAGAIN;
>> +                               bio_endio(bio);
>> +                       } else
>> +                               bio_io_error(bio);
>>                         bio = bio_next;
>>                 }
>>         } while (bio);
>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>> index 81caceb..7a7c674 100644
>> --- a/block/blk-mq.c
>> +++ b/block/blk-mq.c
>> @@ -1213,6 +1213,8 @@ static struct request *blk_mq_map_request(struct request_queue *q,
>>
>>         trace_block_getrq(q, bio, op);
>>         blk_mq_set_alloc_data(&alloc_data, q, 0, ctx, hctx);
>> +       if (bio_flagged(bio, BIO_NONBLOCKING))
>> +               alloc_data.flags |= BLK_MQ_REQ_NOWAIT;
>>         rq = __blk_mq_alloc_request(&alloc_data, op, op_flags);
>>
>>         data->hctx = alloc_data.hctx;
>> @@ -1286,8 +1288,14 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
>>                 return BLK_QC_T_NONE;
>>
>>         rq = blk_mq_map_request(q, bio, &data);
>> -       if (unlikely(!rq))
>> +       if (unlikely(!rq)) {
>> +               if (bio_flagged(bio, BIO_NONBLOCKING))
>> +                       bio->bi_error = -EAGAIN;
>> +               else
>> +                       bio->bi_error = -EIO;
>> +               bio_endio(bio);
>>                 return BLK_QC_T_NONE;
>> +       }
>>
>>         cookie = blk_tag_to_qc_t(rq->tag, data.hctx->queue_num);
>>
>> @@ -1381,8 +1389,14 @@ static blk_qc_t blk_sq_make_request(struct request_queue *q, struct bio *bio)
>>                 request_count = blk_plug_queued_count(q);
>>
>>         rq = blk_mq_map_request(q, bio, &data);
>> -       if (unlikely(!rq))
>> +       if (unlikely(!rq)) {
>> +               if (bio_flagged(bio, BIO_NONBLOCKING))
>> +                       bio->bi_error = -EAGAIN;
>> +               else
>> +                       bio->bi_error = -EIO;
>> +               bio_endio(bio);
>>                 return BLK_QC_T_NONE;
>> +       }
> 
> There are other places in which blocking may be triggered, such
> as allocating for bio clone, wbt_wait(), and sleep in .make_request(),
> like md, dm and bcache's.
> 
> IMO it should be hard to deal with all, so what is the expection for
> flag of BIO_NONBLOCKING?
> 


This is a part of the effort of making direct AIO nonblocking. I should
have posted all patches to all lists.

BIO_NONBLOCKING is a bio generated from a non-blocking AIO. Ideally it
should bail whenever it sees that it would block and sleep if the
blockqueue is congested (only). While earlier we had thought of limiting
it to get_request(), I expanded it to blk-mq (which now I think may not
be as useful).

>>
>>         cookie = blk_tag_to_qc_t(rq->tag, data.hctx->queue_num);
>>
>> diff --git a/fs/direct-io.c b/fs/direct-io.c
>> index fb9aa16..9997fed 100644
>> --- a/fs/direct-io.c
>> +++ b/fs/direct-io.c
>> @@ -386,6 +386,9 @@ dio_bio_alloc(struct dio *dio, struct dio_submit *sdio,
>>         else
>>                 bio->bi_end_io = dio_bio_end_io;
>>
>> +       if (dio->iocb->ki_flags & IOCB_NONBLOCKING)
>> +               bio_set_flag(bio, BIO_NONBLOCKING);
>> +
>>         sdio->bio = bio;
>>         sdio->logical_offset_in_bio = sdio->cur_page_fs_offset;
>>  }
>> @@ -480,8 +483,12 @@ static int dio_bio_complete(struct dio *dio, struct bio *bio)
>>         unsigned i;
>>         int err;
>>
>> -       if (bio->bi_error)
>> -               dio->io_error = -EIO;
>> +       if (bio->bi_error) {
>> +               if (bio_flagged(bio, BIO_NONBLOCKING))
>> +                       dio->io_error = bio->bi_error;
>> +               else
>> +                       dio->io_error = -EIO;
>> +       }
>>
>>         if (dio->is_async && dio->op == REQ_OP_READ && dio->should_dirty) {
>>                 err = bio->bi_error;
>> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
>> index cd395ec..94855cf 100644
>> --- a/include/linux/blk_types.h
>> +++ b/include/linux/blk_types.h
>> @@ -119,6 +119,7 @@ struct bio {
>>  #define BIO_QUIET      6       /* Make BIO Quiet */
>>  #define BIO_CHAIN      7       /* chained bio, ->bi_remaining in effect */
>>  #define BIO_REFFED     8       /* bio has elevated ->bi_cnt */
>> +#define BIO_NONBLOCKING 9      /* don't block over blk device congestion */
>>
>>  /*
>>   * Flags starting here get preserved by bio_reset() - this includes
>> --
>> 2.10.2
>>
> 
> 
> 

-- 
Goldwyn
