Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ADD5C433ED
	for <linux-block@archiver.kernel.org>; Wed,  7 Apr 2021 07:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CCFF613A0
	for <linux-block@archiver.kernel.org>; Wed,  7 Apr 2021 07:41:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233412AbhDGHlM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 7 Apr 2021 03:41:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:36886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233404AbhDGHlL (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 7 Apr 2021 03:41:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AC5E861019;
        Wed,  7 Apr 2021 07:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617781262;
        bh=N3z0Wp4t9wgZRh2ONhaA5RgnzG72aK0GDksMX2phyx0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sPsaMRqOvZOsvGXLqDveof4OhWGc2KKmRXitvVCP6R/fub+2VbioVObcTIXo1kgRx
         j8fGaGyhm1nid2cfpqYQtdHsWT5JWRVJHw829FQcNKaMGYmxNqxa/FU1MIo+m1s4XG
         qF21jN5Tk5R7Zf6pI8zQfWZ58R/rAOH4bvsJ6BAc=
Date:   Wed, 7 Apr 2021 09:40:59 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Changheun Lee <nanich.lee@samsung.com>
Cc:     Johannes.Thumshirn@wdc.com, asml.silence@gmail.com,
        axboe@kernel.dk, damien.lemoal@wdc.com, hch@infradead.org,
        jisoo2146.oh@samsung.com, junho89.kim@samsung.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ming.lei@redhat.com, mj0123.lee@samsung.com, osandov@fb.com,
        patchwork-bot@kernel.org, seunghwan.hyun@samsung.com,
        sookwan7.kim@samsung.com, tj@kernel.org, tom.leiming@gmail.com,
        woosung2.lee@samsung.com, yt0928.kim@samsung.com
Subject: Re: [RESEND PATCH v5 1/2] bio: limit bio max size
Message-ID: <YG1iC944hUkBniDM@kroah.com>
References: <YG1E2krVn5S+E1Da@kroah.com>
 <CGME20210407071241epcas1p2559ea674299b686c9001326894c933bc@epcas1p2.samsung.com>
 <20210407065507.6240-1-nanich.lee@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210407065507.6240-1-nanich.lee@samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Apr 07, 2021 at 03:55:07PM +0900, Changheun Lee wrote:
> > On Wed, Apr 07, 2021 at 02:06:33PM +0900, Changheun Lee wrote:
> > > > On Wed, Apr 07, 2021 at 09:16:12AM +0900, Changheun Lee wrote:
> > > > > > On Tue, Apr 06, 2021 at 10:31:28AM +0900, Changheun Lee wrote:
> > > > > > > > bio size can grow up to 4GB when muli-page bvec is enabled.
> > > > > > > > but sometimes it would lead to inefficient behaviors.
> > > > > > > > in case of large chunk direct I/O, - 32MB chunk read in user space -
> > > > > > > > all pages for 32MB would be merged to a bio structure if the pages
> > > > > > > > physical addresses are contiguous. it makes some delay to submit
> > > > > > > > until merge complete. bio max size should be limited to a proper size.
> > > > > > > > 
> > > > > > > > When 32MB chunk read with direct I/O option is coming from userspace,
> > > > > > > > kernel behavior is below now in do_direct_IO() loop. it's timeline.
> > > > > > > > 
> > > > > > > >  | bio merge for 32MB. total 8,192 pages are merged.
> > > > > > > >  | total elapsed time is over 2ms.
> > > > > > > >  |------------------ ... ----------------------->|
> > > > > > > >                                                  | 8,192 pages merged a bio.
> > > > > > > >                                                  | at this time, first bio submit is done.
> > > > > > > >                                                  | 1 bio is split to 32 read request and issue.
> > > > > > > >                                                  |--------------->
> > > > > > > >                                                   |--------------->
> > > > > > > >                                                    |--------------->
> > > > > > > >                                                               ......
> > > > > > > >                                                                    |--------------->
> > > > > > > >                                                                     |--------------->|
> > > > > > > >                           total 19ms elapsed to complete 32MB read done from device. |
> > > > > > > > 
> > > > > > > > If bio max size is limited with 1MB, behavior is changed below.
> > > > > > > > 
> > > > > > > >  | bio merge for 1MB. 256 pages are merged for each bio.
> > > > > > > >  | total 32 bio will be made.
> > > > > > > >  | total elapsed time is over 2ms. it's same.
> > > > > > > >  | but, first bio submit timing is fast. about 100us.
> > > > > > > >  |--->|--->|--->|---> ... -->|--->|--->|--->|--->|
> > > > > > > >       | 256 pages merged a bio.
> > > > > > > >       | at this time, first bio submit is done.
> > > > > > > >       | and 1 read request is issued for 1 bio.
> > > > > > > >       |--------------->
> > > > > > > >            |--------------->
> > > > > > > >                 |--------------->
> > > > > > > >                                       ......
> > > > > > > >                                                  |--------------->
> > > > > > > >                                                   |--------------->|
> > > > > > > >         total 17ms elapsed to complete 32MB read done from device. |
> > > > > > > > 
> > > > > > > > As a result, read request issue timing is faster if bio max size is limited.
> > > > > > > > Current kernel behavior with multipage bvec, super large bio can be created.
> > > > > > > > And it lead to delay first I/O request issue.
> > > > > > > > 
> > > > > > > > Signed-off-by: Changheun Lee <nanich.lee@samsung.com>
> > > > > > > > ---
> > > > > > > >  block/bio.c            | 13 ++++++++++++-
> > > > > > > >  include/linux/bio.h    |  2 +-
> > > > > > > >  include/linux/blkdev.h |  3 +++
> > > > > > > >  3 files changed, 16 insertions(+), 2 deletions(-)
> > > > > > > > 
> > > > > > > > diff --git a/block/bio.c b/block/bio.c
> > > > > > > > index 1f2cc1fbe283..c528e1f944c7 100644
> > > > > > > > --- a/block/bio.c
> > > > > > > > +++ b/block/bio.c
> > > > > > > > @@ -287,6 +287,17 @@ void bio_init(struct bio *bio, struct bio_vec *table,
> > > > > > > >  }
> > > > > > > >  EXPORT_SYMBOL(bio_init);
> > > > > > > >  
> > > > > > > > +unsigned int bio_max_size(struct bio *bio)
> > > > > > > > +{
> > > > > > > > +	struct request_queue *q = bio->bi_disk->queue;
> > > > > > > > +
> > > > > > > > +	if (blk_queue_limit_bio_size(q))
> > > > > > > > +		return blk_queue_get_max_sectors(q, bio_op(bio))
> > > > > > > > +			<< SECTOR_SHIFT;
> > > > > > > > +
> > > > > > > > +	return UINT_MAX;
> > > > > > > > +}
> > > > > > > > +
> > > > > > > >  /**
> > > > > > > >   * bio_reset - reinitialize a bio
> > > > > > > >   * @bio:	bio to reset
> > > > > > > > @@ -877,7 +888,7 @@ bool __bio_try_merge_page(struct bio *bio, struct page *page,
> > > > > > > >  		struct bio_vec *bv = &bio->bi_io_vec[bio->bi_vcnt - 1];
> > > > > > > >  
> > > > > > > >  		if (page_is_mergeable(bv, page, len, off, same_page)) {
> > > > > > > > -			if (bio->bi_iter.bi_size > UINT_MAX - len) {
> > > > > > > > +			if (bio->bi_iter.bi_size > bio_max_size(bio) - len) {
> > > > > > > >  				*same_page = false;
> > > > > > > >  				return false;
> > > > > > > >  			}
> > > > > > > > diff --git a/include/linux/bio.h b/include/linux/bio.h
> > > > > > > > index 1edda614f7ce..13b6f6562a5b 100644
> > > > > > > > --- a/include/linux/bio.h
> > > > > > > > +++ b/include/linux/bio.h
> > > > > > > > @@ -113,7 +113,7 @@ static inline bool bio_full(struct bio *bio, unsigned len)
> > > > > > > >  	if (bio->bi_vcnt >= bio->bi_max_vecs)
> > > > > > > >  		return true;
> > > > > > > >  
> > > > > > > > -	if (bio->bi_iter.bi_size > UINT_MAX - len)
> > > > > > > > +	if (bio->bi_iter.bi_size > bio_max_size(bio) - len)
> > > > > > > >  		return true;
> > > > > > > >  
> > > > > > > >  	return false;
> > > > > > > > diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> > > > > > > > index f94ee3089e01..3aeab9e7e97b 100644
> > > > > > > > --- a/include/linux/blkdev.h
> > > > > > > > +++ b/include/linux/blkdev.h
> > > > > > > > @@ -621,6 +621,7 @@ struct request_queue {
> > > > > > > >  #define QUEUE_FLAG_RQ_ALLOC_TIME 27	/* record rq->alloc_time_ns */
> > > > > > > >  #define QUEUE_FLAG_HCTX_ACTIVE	28	/* at least one blk-mq hctx is active */
> > > > > > > >  #define QUEUE_FLAG_NOWAIT       29	/* device supports NOWAIT */
> > > > > > > > +#define QUEUE_FLAG_LIMIT_BIO_SIZE 30	/* limit bio size */
> > > > > > > >  
> > > > > > > >  #define QUEUE_FLAG_MQ_DEFAULT	((1 << QUEUE_FLAG_IO_STAT) |		\
> > > > > > > >  				 (1 << QUEUE_FLAG_SAME_COMP) |		\
> > > > > > > > @@ -667,6 +668,8 @@ bool blk_queue_flag_test_and_set(unsigned int flag, struct request_queue *q);
> > > > > > > >  #define blk_queue_fua(q)	test_bit(QUEUE_FLAG_FUA, &(q)->queue_flags)
> > > > > > > >  #define blk_queue_registered(q)	test_bit(QUEUE_FLAG_REGISTERED, &(q)->queue_flags)
> > > > > > > >  #define blk_queue_nowait(q)	test_bit(QUEUE_FLAG_NOWAIT, &(q)->queue_flags)
> > > > > > > > +#define blk_queue_limit_bio_size(q)	\
> > > > > > > > +	test_bit(QUEUE_FLAG_LIMIT_BIO_SIZE, &(q)->queue_flags)
> > > > > > > >  
> > > > > > > >  extern void blk_set_pm_only(struct request_queue *q);
> > > > > > > >  extern void blk_clear_pm_only(struct request_queue *q);
> > > > > > > > -- 
> > > > > > > > 2.28.0
> > > > > > > > 
> > > > > > > 
> > > > > > > Please feedback to me if more modification is needed to apply. :)
> > > > > > 
> > > > > > You are adding code that tests for a value to be set, yet you never set
> > > > > > it in this code so why is it needed at all?
> > > > > 
> > > > > This patch is a solution for some inefficient case of multipage bvec like
> > > > > as current DIO scenario. So it's not set as a default.
> > > > > It will be set when bio size limitation is needed in runtime.
> > > > 
> > > > Set where?
> > > 
> > > In my environment, set it on init.rc file like as below.
> > > "echo 1 > /sys/block/sda/queue/limit_bio_size"
> > 
> > I do not see any sysfs file in this patch, and why would you ever want
> > to be forced to manually do this?  The hardware should know the limits
> > itself, and should automatically tune things like this, do not force a
> > user to do it as that's just not going to go well at all.
> 
> Patch for sysfs is sent "[RESEND,v5,2/2] bio: add limit_bio_size sysfs".
> Actually I just suggested constant - 1MB - value to limit bio size at first.
> But I got a feedback that patch will be better if it's optional, and
> getting meaningful value from device queue on patchwork.
> There are some differences for each system environment I think.
> 
> But there are inefficient logic obviously by applying of multipage bvec.
> So it will be shown in several system environment.
> Currently providing this patch as a option would be better to select
> according to each system environment, and policy I think.
> 
> Please, revisit applying this patch.
> 
> > 
> > So if this patch series is forcing a new option to be configured by
> > sysfs only, that's not acceptable, sorry.
> 
> If it is not acceptable ever with current, may I progress review again
> with default enabled?

I am sorry, I can not parse this, can you rephrase this?

thanks,

greg k-h
