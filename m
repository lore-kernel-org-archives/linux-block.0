Return-Path: <SRS0=vf5w=DV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF36AC433DF
	for <linux-block@archiver.kernel.org>; Wed, 14 Oct 2020 09:49:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C52B21527
	for <linux-block@archiver.kernel.org>; Wed, 14 Oct 2020 09:49:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZVHOEfIF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbgJNJtY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Oct 2020 05:49:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23307 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726491AbgJNJtY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Oct 2020 05:49:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602668962;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+7nTPdXwonaaObjH+9aIhWDcRRg+j2ycjiukz+YMaTU=;
        b=ZVHOEfIFF9V0TmAihg5g3h7+Do18Bi3p8HQieaQQW7AWyjKZYVbIdqtFXF2RIce1Amgwtm
        ebQSy9R9X2pPgSKCAdPRd4hD6/7DPP/pm3dJWRpuByUD9f+c9OAznR4Ad1WJDNBCnRGX90
        x1s3cQ02BtVw/m+1oy4smyXlziicbX8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-253-8FD2FY3XMA68z9wqunmn7g-1; Wed, 14 Oct 2020 05:49:18 -0400
X-MC-Unique: 8FD2FY3XMA68z9wqunmn7g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 124179CC06;
        Wed, 14 Oct 2020 09:49:17 +0000 (UTC)
Received: from T590 (ovpn-12-36.pek2.redhat.com [10.72.12.36])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E44701002382;
        Wed, 14 Oct 2020 09:49:10 +0000 (UTC)
Date:   Wed, 14 Oct 2020 17:49:06 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     JeffleXu <jefflexu@linux.alibaba.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        joseph.qi@linux.alibaba.com, xiaoguang.wang@linux.alibaba.com,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] block: set NOWAIT for sync polling
Message-ID: <20201014094906.GD775684@T590>
References: <20201013084051.27255-1-jefflexu@linux.alibaba.com>
 <20201013120913.GA614668@T590>
 <17357ee1-7662-f20b-0a49-2fb3fdf01ebc@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <17357ee1-7662-f20b-0a49-2fb3fdf01ebc@linux.alibaba.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Oct 14, 2020 at 04:31:49PM +0800, JeffleXu wrote:
> What about just disabling HIPRI in preadv2(2)/pwritev2(2)? Christoph Hellwig
> disabled HIPRI for libaio in

Then people will complain that poll can't be used for sync dio, and it is
an regression.

> 
> commit 154989e45fd8de9bfb52bbd6e5ea763e437e54c5 ("aio: clear IOCB_HIPRI").
> What do you think, @Christoph?
> 
> (cc Christoph Hellwig)
> 
> 
> >   static inline void bio_set_polled(struct bio *bio, struct kiocb *kiocb)
> >   {
> > -	bio->bi_opf |= REQ_HIPRI;
> > -	if (!is_sync_kiocb(kiocb))
> > -		bio->bi_opf |= REQ_NOWAIT;
> > +	bio->bi_opf |= REQ_HIPRI | REQ_NOWAIT;
> >   }
> 
> The original patch indeed could not fix the problem. Though it could fix the
> potential deadlock,
> 
> the VFS code read(2)/write(2) is not ready by handling the returned -EAGAIN
> gracefully. Currently
> 
> read(2)/write(2) will just return -EAGAIN to user space.
> 
> 
> 
> On 10/13/20 8:09 PM, Ming Lei wrote:
> > On Tue, Oct 13, 2020 at 04:40:51PM +0800, Jeffle Xu wrote:
> > > Sync polling also needs REQ_NOWAIT flag. One sync read/write may be
> > > split into several bios (and thus several requests), and can used up the
> > > queue depth sometimes. Thus the following bio in the same sync
> > > read/write will wait for usable request if REQ_NOWAIT flag not set, in
> > > which case the following sync polling will cause a deadlock.
> > > 
> > > One case (maybe the only case) for above situation is preadv2/pwritev2
> > > + direct + highpri. Two conditions need to be satisfied to trigger the
> > > deadlock.
> > > 
> > > 1. HIPRI IO in sync routine. Normal read(2)/pread(2)/readv(2)/preadv(2)
> > > and corresponding write family syscalls don't support high-priority IO and
> > > thus won't trigger polling routine. Only preadv2(2)/pwritev2(2) supports
> > > high-priority IO by RWF_HIPRI flag of @flags parameter.
> > > 
> > > 2. Polling support in sync routine. Currently both the blkdev and
> > > iomap-based fs (ext4/xfs, etc) support polling in direct IO routine. The
> > > general routine is described as follows.
> > > 
> > > submit_bio
> > >    wait for blk_mq_get_tag(), waiting for requests completion, which
> > >    should be done by the following polling, thus causing a deadlock.
> > Another blocking point is rq_qos_throttle(),
> 
> What is the issue here in rq_qos_throttle()? More details?

Like allocating request, rq_qos_throttle() may wait until rq completion
is done, see wbt_wait() and wbt_done().

> 
> 
> > so I guess falling back to
> > REQ_NOWAIT may not fix the issue completely.
> 
> 
> 
> > Given iopoll isn't supposed to in case of big IO, another solution
> > may be to disable iopoll when bio splitting is needed, something
> > like the following change:
> > 
> > diff --git a/block/blk-merge.c b/block/blk-merge.c
> > index bcf5e4580603..8e762215660b 100644
> > --- a/block/blk-merge.c
> > +++ b/block/blk-merge.c
> > @@ -279,6 +279,12 @@ static struct bio *blk_bio_segment_split(struct request_queue *q,
> >   	return NULL;
> >   split:
> >   	*segs = nsegs;
> > +
> > +	/*
> > +	 * bio splitting may cause more trouble for iopoll which isn't supposed
> > +	 * to be used in case of big IO
> > +	 */
> > +	bio->bi_opf &= ~REQ_HIPRI;
> >   	return bio_split(bio, sectors, GFP_NOIO, bs);
> >   }
> 
> Actually split is not only from blk_mq_submit_bio->__blk_queue_split. In
> __blkdev_direct_IO,
> 
> one input iov_iter could be split to several bios.
> 
> ```
> 
> __blkdev_direct_IO:
> 
> for (;;) {
>         ret = bio_iov_iter_get_pages(bio, iter);
>         submit_bio(bio);
> }
> 
> for (;;) {
>         blk_poll()
> 
>         ...
> 
> }
> 
> ```
> 
> Since  one single bio can contain at most BIO_MAX_PAGES, i.e. 256 bio_vec in
> @bio->bi_io_vec,

As Jens mentioned, it is weird to poll on multiple bios, so we can
disable io poll simply in __blkdev_direct_IO(). And it is reasonable from
user's viewpoint to not poll on big bio cause io poll is often used
in latency sensitive cases.

> 
> if the @iovcnt parameter of preadv2(2)/pwritev2(2) is larger than 256, then
> one call of
> 
> preadv2(2)/pwritev2(2) can be split into several bios. These bios are
> submitted at once, and then
> 
> start sync polling in the process context.
> 
> 
> If the number of bios split from one call of preadv2(2)/pwritev2(2) is
> larger than the queue depth,
> 
> bios from single preadv2(2)/pwritev2(2) call can exhaust the queue depth and
> thus cause deadlock.
> 
> Fortunately the maximum of @iovcnt parameter of preadv2(2)/pwritev2(2) is
> UIO_MAXIOV, i.e. 1024,
> 
> and the minimum of queue depth is BLKDEV_MIN_RQ i.e. 4. That means one
> preadv2(2)/pwritev2(2)
> 
> call can submit at most 4 bios, which will fill up the queue depth exactly
> and there's no deadlock in this
> 
> case. I'm not sure if the setting of UIO_MAXIOV/BIO_MAX_PAGES/BLKDEV_MIN_RQ
> is coincident or
> 
> deliberately tuned. At least it will not cause deadlock currently , though
> the constraint may be a little fragile.
> 
> 
> By the way, this patch could fix the potential hang I mentioned in
> 
> https://patchwork.kernel.org/project/linux-block/patch/20200911032958.125068-1-jefflexu@linux.alibaba.com/

Right, I remembered that race.


Thanks,
Ming

