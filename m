Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8476CC433DB
	for <linux-block@archiver.kernel.org>; Tue, 16 Feb 2021 07:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33B9064D9A
	for <linux-block@archiver.kernel.org>; Tue, 16 Feb 2021 07:02:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbhBPHBp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Feb 2021 02:01:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:56780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229787AbhBPHBn (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Feb 2021 02:01:43 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 647A164DDA;
        Tue, 16 Feb 2021 07:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613458862;
        bh=qiM4d1H9+CTD9wzd4pdvrdgb3PnJTLiFotcr6vQnjv0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cmzQ0ZzCfNDitilMJa/qd5oFMvZudnPQOsOtI5t18TdguioeJ7rurCaOvhy7LNcDb
         LYeQR8cKzRAwwqv1mWziQV0aAKJCyPcQIZPN1BQYtYMnPp4zejYpoffHOzLzhXX1ti
         TVWS7+sx1G9p/Kns0fwaJV9Jz1YviijDNVbfjZpM=
Date:   Tue, 16 Feb 2021 08:00:58 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Changheun Lee <nanich.lee@samsung.com>
Cc:     Johannes.Thumshirn@wdc.com, asml.silence@gmail.com,
        axboe@kernel.dk, damien.lemoal@wdc.com, hch@infradead.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ming.lei@redhat.com, osandov@fb.com, patchwork-bot@kernel.org,
        tj@kernel.org, tom.leiming@gmail.com, jisoo2146.oh@samsung.com,
        junho89.kim@samsung.com, mj0123.lee@samsung.com,
        seunghwan.hyun@samsung.com, sookwan7.kim@samsung.com,
        woosung2.lee@samsung.com, yt0928.kim@samsung.com
Subject: Re: [PATCH v5 1/2] bio: limit bio max size
Message-ID: <YCttqriCZWUrFcMw@kroah.com>
References: <YCtkAZNIgehq3ewF@kroah.com>
 <CGME20210216065845epcas1p2dcb0d476c5118999d6d764badf05c1c5@epcas1p2.samsung.com>
 <20210216064242.14979-1-nanich.lee@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210216064242.14979-1-nanich.lee@samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Feb 16, 2021 at 03:42:42PM +0900, Changheun Lee wrote:
> > 
> > On Tue, Feb 16, 2021 at 11:00:32AM +0900, Changheun Lee wrote:
> > > Please feedback to me if more modification is needed to apply. :)
> > 
> > No context here :(
> > 
> 
> I'm so sorry. I missed it.
> 
> > bio size can grow up to 4GB when muli-page bvec is enabled.
> > but sometimes it would lead to inefficient behaviors.
> > in case of large chunk direct I/O, - 32MB chunk read in user space -
> > all pages for 32MB would be merged to a bio structure if the pages
> > physical addresses are contiguous. it makes some delay to submit
> > until merge complete. bio max size should be limited to a proper size.
> > 
> > When 32MB chunk read with direct I/O option is coming from userspace,
> > kernel behavior is below now in do_direct_IO() loop. it's timeline.
> > 
> >  | bio merge for 32MB. total 8,192 pages are merged.
> >  | total elapsed time is over 2ms.
> >  |------------------ ... ----------------------->|
> >                                                  | 8,192 pages merged a bio.
> >                                                  | at this time, first bio submit is done.
> >                                                  | 1 bio is split to 32 read request and issue.
> >                                                  |--------------->
> >                                                   |--------------->
> >                                                    |--------------->
> >                                                               ......
> >                                                                    |--------------->
> >                                                                     |--------------->|
> >                           total 19ms elapsed to complete 32MB read done from device. |
> > 
> > If bio max size is limited with 1MB, behavior is changed below.
> > 
> >  | bio merge for 1MB. 256 pages are merged for each bio.
> >  | total 32 bio will be made.
> >  | total elapsed time is over 2ms. it's same.
> >  | but, first bio submit timing is fast. about 100us.
> >  |--->|--->|--->|---> ... -->|--->|--->|--->|--->|
> >       | 256 pages merged a bio.
> >       | at this time, first bio submit is done.
> >       | and 1 read request is issued for 1 bio.
> >       |--------------->
> >            |--------------->
> >                 |--------------->
> >                                       ......
> >                                                  |--------------->
> >                                                   |--------------->|
> >         total 17ms elapsed to complete 32MB read done from device. |
> > 
> > As a result, read request issue timing is faster if bio max size is limited.
> > Current kernel behavior with multipage bvec, super large bio can be created.
> > And it lead to delay first I/O request issue.
> > 
> > Signed-off-by: Changheun Lee <nanich.lee@samsung.com>
> > ---
> >  block/bio.c            | 13 ++++++++++++-
> >  include/linux/bio.h    |  2 +-
> >  include/linux/blkdev.h |  3 +++
> >  3 files changed, 16 insertions(+), 2 deletions(-)
> > 
> > diff --git a/block/bio.c b/block/bio.c
> > index 1f2cc1fbe283..c528e1f944c7 100644
> > --- a/block/bio.c
> > +++ b/block/bio.c
> > @@ -287,6 +287,17 @@ void bio_init(struct bio *bio, struct bio_vec *table,
> >  }
> >  EXPORT_SYMBOL(bio_init);
> >  
> > +unsigned int bio_max_size(struct bio *bio)
> > +{
> > +	struct request_queue *q = bio->bi_disk->queue;
> > +
> > +	if (blk_queue_limit_bio_size(q))
> > +		return blk_queue_get_max_sectors(q, bio_op(bio))
> > +			<< SECTOR_SHIFT;
> > +
> > +	return UINT_MAX;
> > +}
> > +
> >  /**
> >   * bio_reset - reinitialize a bio
> >   * @bio:	bio to reset
> > @@ -877,7 +888,7 @@ bool __bio_try_merge_page(struct bio *bio, struct page *page,
> >  		struct bio_vec *bv = &bio->bi_io_vec[bio->bi_vcnt - 1];
> >  
> >  		if (page_is_mergeable(bv, page, len, off, same_page)) {
> > -			if (bio->bi_iter.bi_size > UINT_MAX - len) {
> > +			if (bio->bi_iter.bi_size > bio_max_size(bio) - len) {
> >  				*same_page = false;
> >  				return false;
> >  			}
> > diff --git a/include/linux/bio.h b/include/linux/bio.h
> > index 1edda614f7ce..13b6f6562a5b 100644
> > --- a/include/linux/bio.h
> > +++ b/include/linux/bio.h
> > @@ -113,7 +113,7 @@ static inline bool bio_full(struct bio *bio, unsigned len)
> >  	if (bio->bi_vcnt >= bio->bi_max_vecs)
> >  		return true;
> >  
> > -	if (bio->bi_iter.bi_size > UINT_MAX - len)
> > +	if (bio->bi_iter.bi_size > bio_max_size(bio) - len)
> >  		return true;
> >  
> >  	return false;
> > diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> > index f94ee3089e01..3aeab9e7e97b 100644
> > --- a/include/linux/blkdev.h
> > +++ b/include/linux/blkdev.h
> > @@ -621,6 +621,7 @@ struct request_queue {
> >  #define QUEUE_FLAG_RQ_ALLOC_TIME 27	/* record rq->alloc_time_ns */
> >  #define QUEUE_FLAG_HCTX_ACTIVE	28	/* at least one blk-mq hctx is active */
> >  #define QUEUE_FLAG_NOWAIT       29	/* device supports NOWAIT */
> > +#define QUEUE_FLAG_LIMIT_BIO_SIZE 30	/* limit bio size */
> >  
> >  #define QUEUE_FLAG_MQ_DEFAULT	((1 << QUEUE_FLAG_IO_STAT) |		\
> >  				 (1 << QUEUE_FLAG_SAME_COMP) |		\
> > @@ -667,6 +668,8 @@ bool blk_queue_flag_test_and_set(unsigned int flag, struct request_queue *q);
> >  #define blk_queue_fua(q)	test_bit(QUEUE_FLAG_FUA, &(q)->queue_flags)
> >  #define blk_queue_registered(q)	test_bit(QUEUE_FLAG_REGISTERED, &(q)->queue_flags)
> >  #define blk_queue_nowait(q)	test_bit(QUEUE_FLAG_NOWAIT, &(q)->queue_flags)
> > +#define blk_queue_limit_bio_size(q)	\
> > +	test_bit(QUEUE_FLAG_LIMIT_BIO_SIZE, &(q)->queue_flags)
> >  
> >  extern void blk_set_pm_only(struct request_queue *q);
> >  extern void blk_clear_pm_only(struct request_queue *q);
> > -- 
> > 2.28.0
> > 
> 
> Please feedback to me if more modification is needed to apply. :)

It's the middle of the merge window, no maintainers can add anything new
to their trees, so please wait until after 5.12-rc1 is out before we can
do anything...

thanks,

greg k-h
