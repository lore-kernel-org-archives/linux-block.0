Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A936C433E9
	for <linux-block@archiver.kernel.org>; Tue, 26 Jan 2021 05:35:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCD4722B37
	for <linux-block@archiver.kernel.org>; Tue, 26 Jan 2021 05:35:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387826AbhAZFe0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Jan 2021 00:34:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60198 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732416AbhAZD7i (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Jan 2021 22:59:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611633490;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EK2/fEVOtBHw6/+Cycnygn+HlAZtj//OqqPZxrrvsc4=;
        b=ddQcFrKG61Xet7pNitvUfvV/ECq6r+PHWggOMMxG8q0ZM4bnIiUB4Ek17lljs/Qa5hzPOf
        SYv1MjkmfbgEcqPkaNh1qKlmQ0Lf+mJ3dmYYqpnhcDIx6X3DPJ1a7/1lUb0eJtTYim7sp3
        q5JUzQ7SNASXXGC0ayZzzc8YbcHBjwA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-516-psxH4RQFPCuGM1-W-EGWyw-1; Mon, 25 Jan 2021 22:58:05 -0500
X-MC-Unique: psxH4RQFPCuGM1-W-EGWyw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 90C92180A093;
        Tue, 26 Jan 2021 03:58:03 +0000 (UTC)
Received: from T590 (ovpn-13-71.pek2.redhat.com [10.72.13.71])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D0D8760C47;
        Tue, 26 Jan 2021 03:57:52 +0000 (UTC)
Date:   Tue, 26 Jan 2021 11:57:48 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Changheun Lee <nanich.lee@samsung.com>
Cc:     Johannes.Thumshirn@wdc.com, asml.silence@gmail.com,
        axboe@kernel.dk, damien.lemoal@wdc.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        osandov@fb.com, patchwork-bot@kernel.org, tj@kernel.org,
        tom.leiming@gmail.com, jisoo2146.oh@samsung.com,
        junho89.kim@samsung.com, mj0123.lee@samsung.com,
        seunghwan.hyun@samsung.com, sookwan7.kim@samsung.com,
        woosung2.lee@samsung.com, yt0928.kim@samsung.com
Subject: Re: [PATCH v3 1/2] bio: limit bio max size
Message-ID: <20210126035748.GA1071341@T590>
References: <CGME20210126014805epcas1p2c4fc40f01c9c89b0a94ff6cac5408347@epcas1p2.samsung.com>
 <20210126013235.28711-1-nanich.lee@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210126013235.28711-1-nanich.lee@samsung.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jan 26, 2021 at 10:32:34AM +0900, Changheun Lee wrote:
> bio size can grow up to 4GB when muli-page bvec is enabled.
> but sometimes it would lead to inefficient behaviors.
> in case of large chunk direct I/O, - 32MB chunk read in user space -
> all pages for 32MB would be merged to a bio structure if the pages
> physical addresses are contiguous. it makes some delay to submit
> until merge complete. bio max size should be limited to a proper size.
> 
> When 32MB chunk read with direct I/O option is coming from userspace,
> kernel behavior is below now. it's timeline.
> 
>  | bio merge for 32MB. total 8,192 pages are merged.
>  | total elapsed time is over 2ms.
>  |------------------ ... ----------------------->|
>                                                  | 8,192 pages merged a bio.
>                                                  | at this time, first bio submit is done.
>                                                  | 1 bio is split to 32 read request and issue.
>                                                  |--------------->
>                                                   |--------------->
>                                                    |--------------->
>                                                               ......
>                                                                    |--------------->
>                                                                     |--------------->|
>                           total 19ms elapsed to complete 32MB read done from device. |
> 
> If bio max size is limited with 1MB, behavior is changed below.
> 
>  | bio merge for 1MB. 256 pages are merged for each bio.
>  | total 32 bio will be made.
>  | total elapsed time is over 2ms. it's same.
>  | but, first bio submit timing is fast. about 100us.
>  |--->|--->|--->|---> ... -->|--->|--->|--->|--->|
>       | 256 pages merged a bio.
>       | at this time, first bio submit is done.
>       | and 1 read request is issued for 1 bio.
>       |--------------->
>            |--------------->
>                 |--------------->
>                                       ......
>                                                  |--------------->
>                                                   |--------------->|
>         total 17ms elapsed to complete 32MB read done from device. |
> 
> As a result, read request issue timing is faster if bio max size is limited.
> Current kernel behavior with multipage bvec, super large bio can be created.
> And it lead to delay first I/O request issue.
> 
> Signed-off-by: Changheun Lee <nanich.lee@samsung.com>
> ---
>  block/bio.c            | 17 ++++++++++++++++-
>  include/linux/bio.h    |  4 +++-
>  include/linux/blkdev.h |  3 +++
>  3 files changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/block/bio.c b/block/bio.c
> index 1f2cc1fbe283..ec0281889045 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -287,6 +287,21 @@ void bio_init(struct bio *bio, struct bio_vec *table,
>  }
>  EXPORT_SYMBOL(bio_init);
>  
> +unsigned int bio_max_size(struct bio *bio)
> +{
> +	struct request_queue *q;
> +
> +	if (!bio->bi_disk)
> +		return UINT_MAX;
> +
> +	q = bio->bi_disk->queue;
> +	if (!blk_queue_limit_bio_size(q))
> +		return UINT_MAX;
> +
> +	return blk_queue_get_max_sectors(q, bio_op(bio)) << SECTOR_SHIFT;
> +}
> +EXPORT_SYMBOL(bio_max_size);
> +
>  /**
>   * bio_reset - reinitialize a bio
>   * @bio:	bio to reset
> @@ -877,7 +892,7 @@ bool __bio_try_merge_page(struct bio *bio, struct page *page,
>  		struct bio_vec *bv = &bio->bi_io_vec[bio->bi_vcnt - 1];
>  
>  		if (page_is_mergeable(bv, page, len, off, same_page)) {
> -			if (bio->bi_iter.bi_size > UINT_MAX - len) {
> +			if (bio->bi_iter.bi_size > bio_max_size(bio) - len) {
>  				*same_page = false;
>  				return false;
>  			}

So far we don't need bio->bi_disk or bio->bi_bdev(will be changed in
Christoph's patch) during adding page to bio, so there is null ptr
refereance risk.

> diff --git a/include/linux/bio.h b/include/linux/bio.h
> index 1edda614f7ce..cdb134ca7bf5 100644
> --- a/include/linux/bio.h
> +++ b/include/linux/bio.h
> @@ -100,6 +100,8 @@ static inline void *bio_data(struct bio *bio)
>  	return NULL;
>  }
>  
> +extern unsigned int bio_max_size(struct bio *);
> +
>  /**
>   * bio_full - check if the bio is full
>   * @bio:	bio to check
> @@ -113,7 +115,7 @@ static inline bool bio_full(struct bio *bio, unsigned len)
>  	if (bio->bi_vcnt >= bio->bi_max_vecs)
>  		return true;
>  
> -	if (bio->bi_iter.bi_size > UINT_MAX - len)
> +	if (bio->bi_iter.bi_size > bio_max_size(bio) - len)
>  		return true;
>  
>  	return false;
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index f94ee3089e01..3aeab9e7e97b 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -621,6 +621,7 @@ struct request_queue {
>  #define QUEUE_FLAG_RQ_ALLOC_TIME 27	/* record rq->alloc_time_ns */
>  #define QUEUE_FLAG_HCTX_ACTIVE	28	/* at least one blk-mq hctx is active */
>  #define QUEUE_FLAG_NOWAIT       29	/* device supports NOWAIT */
> +#define QUEUE_FLAG_LIMIT_BIO_SIZE 30	/* limit bio size */
>  
>  #define QUEUE_FLAG_MQ_DEFAULT	((1 << QUEUE_FLAG_IO_STAT) |		\
>  				 (1 << QUEUE_FLAG_SAME_COMP) |		\
> @@ -667,6 +668,8 @@ bool blk_queue_flag_test_and_set(unsigned int flag, struct request_queue *q);
>  #define blk_queue_fua(q)	test_bit(QUEUE_FLAG_FUA, &(q)->queue_flags)
>  #define blk_queue_registered(q)	test_bit(QUEUE_FLAG_REGISTERED, &(q)->queue_flags)
>  #define blk_queue_nowait(q)	test_bit(QUEUE_FLAG_NOWAIT, &(q)->queue_flags)
> +#define blk_queue_limit_bio_size(q)	\
> +	test_bit(QUEUE_FLAG_LIMIT_BIO_SIZE, &(q)->queue_flags)

I don't think it is a good idea by adding queue flag for this purpose,
since this case just needs to limit bio size for not delay bio submission
too much, which is kind of logical thing, nothing to do with request queue.

Just wondering why you don't take the following way:


diff --git a/block/bio.c b/block/bio.c
index 99040a7e6656..35852f7f47d4 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1081,7 +1081,7 @@ static int __bio_iov_append_get_pages(struct bio *bio, struct iov_iter *iter)
  * It's intended for direct IO, so doesn't do PSI tracking, the caller is
  * responsible for setting BIO_WORKINGSET if necessary.
  */
-int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
+int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter, bool sync)
 {
 	int ret = 0;
 
@@ -1092,12 +1092,20 @@ int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 		bio_set_flag(bio, BIO_NO_PAGE_REF);
 		return 0;
 	} else {
+		/*
+		 * Don't add too many pages in case of sync dio for
+		 * avoiding delay bio submission too much especially
+		 * pinning user pages in memory isn't cheap.
+		 */
+		const unsigned int max_size = sync ? (1U << 12) : UINT_MAX;
+
 		do {
 			if (bio_op(bio) == REQ_OP_ZONE_APPEND)
 				ret = __bio_iov_append_get_pages(bio, iter);
 			else
 				ret = __bio_iov_iter_get_pages(bio, iter);
-		} while (!ret && iov_iter_count(iter) && !bio_full(bio, 0));
+		} while (!ret && iov_iter_count(iter) && !bio_full(bio, 0) &&
+				bio->bi_iter.bi_size < max_size);
 	}
 
 	/* don't account direct I/O as memory stall */
diff --git a/fs/block_dev.c b/fs/block_dev.c
index 6f5bd9950baf..0d1d436aca17 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -246,7 +246,7 @@ __blkdev_direct_IO_simple(struct kiocb *iocb, struct iov_iter *iter,
 	bio.bi_end_io = blkdev_bio_end_io_simple;
 	bio.bi_ioprio = iocb->ki_ioprio;
 
-	ret = bio_iov_iter_get_pages(&bio, iter);
+	ret = bio_iov_iter_get_pages(&bio, iter, true);
 	if (unlikely(ret))
 		goto out;
 	ret = bio.bi_iter.bi_size;
@@ -397,7 +397,7 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
 		bio->bi_end_io = blkdev_bio_end_io;
 		bio->bi_ioprio = iocb->ki_ioprio;
 
-		ret = bio_iov_iter_get_pages(bio, iter);
+		ret = bio_iov_iter_get_pages(bio, iter, is_sync);
 		if (unlikely(ret)) {
 			bio->bi_status = BLK_STS_IOERR;
 			bio_endio(bio);
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index ea1e8f696076..5105982a9bf8 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -277,7 +277,8 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
 		bio->bi_private = dio;
 		bio->bi_end_io = iomap_dio_bio_end_io;
 
-		ret = bio_iov_iter_get_pages(bio, dio->submit.iter);
+		ret = bio_iov_iter_get_pages(bio, dio->submit.iter,
+				is_sync_kiocb(dio->iocb));
 		if (unlikely(ret)) {
 			/*
 			 * We have to stop part way through an IO. We must fall
diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index bec47f2d074b..c95ac37f9305 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -690,7 +690,7 @@ static ssize_t zonefs_file_dio_append(struct kiocb *iocb, struct iov_iter *from)
 	if (iocb->ki_flags & IOCB_DSYNC)
 		bio->bi_opf |= REQ_FUA;
 
-	ret = bio_iov_iter_get_pages(bio, from);
+	ret = bio_iov_iter_get_pages(bio, from, is_sync_kiocb(iocb));
 	if (unlikely(ret))
 		goto out_release;
 
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 676870b2c88d..fa3a503b955c 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -472,7 +472,7 @@ bool __bio_try_merge_page(struct bio *bio, struct page *page,
 		unsigned int len, unsigned int off, bool *same_page);
 void __bio_add_page(struct bio *bio, struct page *page,
 		unsigned int len, unsigned int off);
-int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter);
+int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter, bool sync);
 void bio_release_pages(struct bio *bio, bool mark_dirty);
 extern void bio_set_pages_dirty(struct bio *bio);
 extern void bio_check_pages_dirty(struct bio *bio);


Thanks,
Ming

