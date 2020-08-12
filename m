Return-Path: <SRS0=wHaM=BW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5428C433E0
	for <linux-block@archiver.kernel.org>; Wed, 12 Aug 2020 02:53:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7CD1207DA
	for <linux-block@archiver.kernel.org>; Wed, 12 Aug 2020 02:53:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C//CxCW9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbgHLCxV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Aug 2020 22:53:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28644 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726430AbgHLCxU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Aug 2020 22:53:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597200798;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wa4kA9V++qveSb+eG2KornNzk7POibDapr96+q0COqo=;
        b=C//CxCW90Plpds6YRicmXXtI4oq8tscQQ09Soe75x5EVB7Y138POwkkj2irhAUkVbo4Lqi
        YesCoxmApBCzjQlNMzUuMMqcmF+etAYhhXiL95Rc5RaIplpVrMtwDcdSXjeqzPxQ2zOScx
        Scpv8iSaAkk6KrSq2qJQ1r4LRl0UEJ4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-87-EwSIK19xOSaapmJkY8cEVg-1; Tue, 11 Aug 2020 22:53:17 -0400
X-MC-Unique: EwSIK19xOSaapmJkY8cEVg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DB64A1853DA3;
        Wed, 12 Aug 2020 02:53:15 +0000 (UTC)
Received: from T590 (ovpn-13-156.pek2.redhat.com [10.72.13.156])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 11FA587D8E;
        Wed, 12 Aug 2020 02:53:02 +0000 (UTC)
Date:   Wed, 12 Aug 2020 10:52:58 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Changpeng Liu <changpeng.liu@intel.com>,
        Daniel Verkamp <dverkamp@chromium.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH V2 2/3] block: virtio_blk: fix handling single range
 discard request
Message-ID: <20200812025258.GA2304706@T590>
References: <20200811234420.2297137-1-ming.lei@redhat.com>
 <20200811234420.2297137-3-ming.lei@redhat.com>
 <20200812020706.GA69794@VM20190228-100.tbsite.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200812020706.GA69794@VM20190228-100.tbsite.net>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Aug 12, 2020 at 10:07:06AM +0800, Baolin Wang wrote:
> Hi Ming,
> 
> On Wed, Aug 12, 2020 at 07:44:19AM +0800, Ming Lei wrote:
> > 1f23816b8eb8 ("virtio_blk: add discard and write zeroes support") starts
> > to support multi-range discard for virtio-blk. However, the virtio-blk
> > disk may report max discard segment as 1, at least that is exactly what
> > qemu is doing.
> > 
> > So far, block layer switches to normal request merge if max discard segment
> > limit is 1, and multiple bios can be merged to single segment. This way may
> > cause memory corruption in virtblk_setup_discard_write_zeroes().
> > 
> > Fix the issue by handling single max discard segment in straightforward
> > way.
> > 
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > Fixes: 1f23816b8eb8 ("virtio_blk: add discard and write zeroes support")
> > Cc: Christoph Hellwig <hch@lst.de>
> > Cc: Changpeng Liu <changpeng.liu@intel.com>
> > Cc: Daniel Verkamp <dverkamp@chromium.org>
> > Cc: Michael S. Tsirkin <mst@redhat.com>
> > Cc: Stefan Hajnoczi <stefanha@redhat.com>
> > Cc: Stefano Garzarella <sgarzare@redhat.com>
> > ---
> >  drivers/block/virtio_blk.c | 31 +++++++++++++++++++++++--------
> >  1 file changed, 23 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > index 63b213e00b37..b2e48dac1ebd 100644
> > --- a/drivers/block/virtio_blk.c
> > +++ b/drivers/block/virtio_blk.c
> > @@ -126,16 +126,31 @@ static int virtblk_setup_discard_write_zeroes(struct request *req, bool unmap)
> >  	if (!range)
> >  		return -ENOMEM;
> >  
> > -	__rq_for_each_bio(bio, req) {
> > -		u64 sector = bio->bi_iter.bi_sector;
> > -		u32 num_sectors = bio->bi_iter.bi_size >> SECTOR_SHIFT;
> > -
> > -		range[n].flags = cpu_to_le32(flags);
> > -		range[n].num_sectors = cpu_to_le32(num_sectors);
> > -		range[n].sector = cpu_to_le64(sector);
> > -		n++;
> > +	/*
> > +	 * Single max discard segment means multi-range discard isn't
> > +	 * supported, and block layer only runs contiguity merge like
> > +	 * normal RW request. So we can't reply on bio for retrieving
> > +	 * each range info.
> > +	 */
> > +	if (queue_max_discard_segments(req->q) == 1) {
> > +		range[0].flags = cpu_to_le32(flags);
> > +		range[0].num_sectors = cpu_to_le32(blk_rq_sectors(req));
> > +		range[0].sector = cpu_to_le64(blk_rq_pos(req));
> > +		n = 1;
> > +	} else {
> > +		__rq_for_each_bio(bio, req) {
> > +			u64 sector = bio->bi_iter.bi_sector;
> > +			u32 num_sectors = bio->bi_iter.bi_size >> SECTOR_SHIFT;
> > +
> > +			range[n].flags = cpu_to_le32(flags);
> > +			range[n].num_sectors = cpu_to_le32(num_sectors);
> > +			range[n].sector = cpu_to_le64(sector);
> > +			n++;
> > +		}
> >  	}
> >  
> > +	WARN_ON_ONCE(n != segments);
> 
> I wonder should we return an error if the discard segments are
> incorrect like NVMe did[1]? In case the DMA may do some serious
> damages in this case.

It is an unlikely case:

1) if queue_max_discard_segments() is 1, the warning can't be triggered

2) otherwise, ELEVATOR_DISCARD_MERGE is always handled in bio_attempt_discard_merge(),
and segment number is really same with number of bios in the request.

If the warning is triggered, it is simply one serious bug in block
layer.

BTW, suppose the warning is triggered:

1) if n < segments, it is simply one warning

2) if n > segments, no matter if something like nvme_setup_discard() is
done, serious memory corruption issue has been caused.

So it doesn't matter to handle it in nvme's style.

Thanks,
Ming

