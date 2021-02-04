Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54988C433E6
	for <linux-block@archiver.kernel.org>; Thu,  4 Feb 2021 02:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 168DC64F65
	for <linux-block@archiver.kernel.org>; Thu,  4 Feb 2021 02:20:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233449AbhBDCUY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Feb 2021 21:20:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28515 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233186AbhBDCUX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 3 Feb 2021 21:20:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612405136;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+eTSAc/Nm4e5wbJf2v1zc0y+nloPYqY5QgY8wp4fPTM=;
        b=H5odTpO60YLFqaxkReXweITV0bGePNObAN2jlp8YoL9GbZmCCviJhhwLnSc7CQ0nkxUZSr
        58nY4N0Cy3c8QTHh4ODiNo3O/77ri0D+rzkFzAG9gwVgvwf5aEj2KdkH6vKWFpivczd3tq
        4XVD1L8HfybFg7wIpNfcPJwk9BkqKJA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-580-Gf5DzL76MIOnX2__HbSjDg-1; Wed, 03 Feb 2021 21:18:55 -0500
X-MC-Unique: Gf5DzL76MIOnX2__HbSjDg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E335A8030B3;
        Thu,  4 Feb 2021 02:18:53 +0000 (UTC)
Received: from T590 (ovpn-13-173.pek2.redhat.com [10.72.13.173])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BB7A85D762;
        Thu,  4 Feb 2021 02:18:47 +0000 (UTC)
Date:   Thu, 4 Feb 2021 10:18:43 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     David Jeffery <djeffery@redhat.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-kernel@vger.kernel.org,
        Laurence Oberman <loberman@redhat.com>
Subject: Re: [PATCH] block: recalculate segment count for multi-segment
 discard requests correctly
Message-ID: <20210204021843.GA1108591@T590>
References: <20210201164850.391332-1-djeffery@redhat.com>
 <20210202033343.GA165584@T590>
 <20210202204355.GA31803@redhat>
 <20210203023517.GA948998@T590>
 <20210203162337.GA40163@redhat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210203162337.GA40163@redhat>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Feb 03, 2021 at 11:23:37AM -0500, David Jeffery wrote:
> On Wed, Feb 03, 2021 at 10:35:17AM +0800, Ming Lei wrote:
> > 
> > On Tue, Feb 02, 2021 at 03:43:55PM -0500, David Jeffery wrote:
> > > The return 0 does seem to be an old relic that does not make sense anymore.
> > > Moving REQ_OP_SECURE_ERASE to be with discard and removing the old return 0,
> > > is this what you had in mind?
> > > 
> > >  
> > > diff --git a/block/blk-merge.c b/block/blk-merge.c
> > > index 808768f6b174..68458aa01b05 100644
> > > --- a/block/blk-merge.c
> > > +++ b/block/blk-merge.c
> > > @@ -383,8 +383,14 @@ unsigned int blk_recalc_rq_segments(struct request *rq)
> > >  	switch (bio_op(rq->bio)) {
> > >  	case REQ_OP_DISCARD:
> > >  	case REQ_OP_SECURE_ERASE:
> > > +		if (queue_max_discard_segments(rq->q) > 1) {
> > > +			struct bio *bio = rq->bio;
> > > +			for_each_bio(bio)
> > > +				nr_phys_segs++;
> > > +			return nr_phys_segs;
> > > +		}
> > > +		/* fall through */
> > >  	case REQ_OP_WRITE_ZEROES:
> > > -		return 0;
> > >  	case REQ_OP_WRITE_SAME:
> > >  		return 1;
> > 
> > WRITE_SAME uses same buffer, so the nr_segment is still one; WRITE_ZERO
> > doesn't need extra payload, so nr_segments is zero, see
> > blk_bio_write_zeroes_split(), blk_bio_write_same_split, attempt_merge()
> > and blk_rq_merge_ok().
> > 
> 
> I thought you mentioned virtio-blk because of how some drivers handle
> zeroing and discarding similarly and wanted to align the segment count with
> discard behavior for WRITE_ZEROES too. (Though that would also need an update

virtio-blk is just one example which supports both single discard range
and multiple discard range, meantime virtblk_setup_discard_write_zeroes()
simply maps write zero into discard directly.

Just found blk_rq_nr_discard_segments() returns >=1 segments always, so
looks your patch is enough for avoiding the warning.

> to blk_bio_write_zeroes_split as you pointed out.)  So you want me to leave
> WRITE_ZEROES behavior alone and let blk_rq_nr_discard_segments() keep doing
> the hiding of a 0 rq->nr_phys_segments as 1 segment in the WRITE_ZEROES treated
> as a discard case?
> 
> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index 808768f6b174..756473295f19 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -383,6 +383,14 @@ unsigned int blk_recalc_rq_segments(struct request *rq)
>  	switch (bio_op(rq->bio)) {
>  	case REQ_OP_DISCARD:
>  	case REQ_OP_SECURE_ERASE:
> +		if (queue_max_discard_segments(rq->q) > 1) {
> +			struct bio *bio = rq->bio;
> +
> +			for_each_bio(bio)
> +				nr_phys_segs++;
> +			return nr_phys_segs;
> +		}
> +		return 1;
>  	case REQ_OP_WRITE_ZEROES:
>  		return 0;
>  	case REQ_OP_WRITE_SAME:

This patch returns 1 for single-range discard explicitly. However, it
isn't necessary because of blk_rq_nr_discard_segments().

Maybe we can align to blk_bio_discard_split() in future, but that can be
done as cleanup.

Thanks,
Ming

