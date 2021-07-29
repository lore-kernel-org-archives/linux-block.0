Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC05DC4338F
	for <linux-block@archiver.kernel.org>; Thu, 29 Jul 2021 09:18:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF7BC60F6F
	for <linux-block@archiver.kernel.org>; Thu, 29 Jul 2021 09:18:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235488AbhG2JSm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Jul 2021 05:18:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47743 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235462AbhG2JSj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Jul 2021 05:18:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627550316;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PI9JUHXs4GaYR/G3v16SHbU7oaOyoHc0jk0Afcy60+U=;
        b=MhtsXZX9i1ns+tm2dJKHlTEe731LcQeouwYS6T95oX4xxKsAS5kLkdUY4rR8u3BwE2ryvX
        wPCdp/eLg3vR7Mmke3sHfLje9dv3xNEZe//6LIBkqI4BEFdlRINIfsQ5vi5cVXPWztd2tW
        Kgx8zsHk+g9fNmbPSqdYkK9JxTpcwjg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-580-kihY6MXWN8CeeVt6c4AhZQ-1; Thu, 29 Jul 2021 05:18:33 -0400
X-MC-Unique: kihY6MXWN8CeeVt6c4AhZQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BE8E0801AE3;
        Thu, 29 Jul 2021 09:18:31 +0000 (UTC)
Received: from T590 (ovpn-12-146.pek2.redhat.com [10.72.12.146])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3847760BF1;
        Thu, 29 Jul 2021 09:18:24 +0000 (UTC)
Date:   Thu, 29 Jul 2021 17:18:26 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Oleksandr Natalenko <oleksandr@natalenko.name>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] block: return ELEVATOR_DISCARD_MERGE if possible
Message-ID: <YQJyYoGbfR7Ym17Q@T590>
References: <20210729034226.1591070-1-ming.lei@redhat.com>
 <67816551.sp8fIUDole@natalenko.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <67816551.sp8fIUDole@natalenko.name>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jul 29, 2021 at 09:17:28AM +0200, Oleksandr Natalenko wrote:
> On čtvrtek 29. července 2021 5:42:26 CEST Ming Lei wrote:
> > When merging one bio to request, if they are discard IO and the queue
> > supports multi-range discard, we need to return ELEVATOR_DISCARD_MERGE
> > because both block core and related drivers(nvme, virtio-blk) doesn't
> > handle mixed discard io merge(traditional IO merge together with
> > discard merge) well.
> > 
> > Fix the issue by returning ELEVATOR_DISCARD_MERGE in this situation,
> > so both blk-mq and drivers just need to handle multi-range discard.
> > 
> > Reported-by: Oleksandr Natalenko <oleksandr@natalenko.name>
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  block/bfq-iosched.c      |  3 +++
> >  block/blk-merge.c        | 16 ----------------
> >  block/elevator.c         |  3 +++
> >  block/mq-deadline-main.c |  2 ++
> >  include/linux/blkdev.h   | 16 ++++++++++++++++
> >  5 files changed, 24 insertions(+), 16 deletions(-)
> > 
> > diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> > index 727955918563..673a634eadd9 100644
> > --- a/block/bfq-iosched.c
> > +++ b/block/bfq-iosched.c
> > @@ -2361,6 +2361,9 @@ static int bfq_request_merge(struct request_queue *q,
> > struct request **req, __rq = bfq_find_rq_fmerge(bfqd, bio, q);
> >  	if (__rq && elv_bio_merge_ok(__rq, bio)) {
> >  		*req = __rq;
> > +
> > +		if (blk_discard_mergable(__rq))
> > +			return ELEVATOR_DISCARD_MERGE;
> >  		return ELEVATOR_FRONT_MERGE;
> >  	}
> > 
> > diff --git a/block/blk-merge.c b/block/blk-merge.c
> > index a11b3b53717e..f8707ff7e2fc 100644
> > --- a/block/blk-merge.c
> > +++ b/block/blk-merge.c
> > @@ -705,22 +705,6 @@ static void blk_account_io_merge_request(struct request
> > *req) }
> >  }
> > 
> > -/*
> > - * Two cases of handling DISCARD merge:
> > - * If max_discard_segments > 1, the driver takes every bio
> > - * as a range and send them to controller together. The ranges
> > - * needn't to be contiguous.
> > - * Otherwise, the bios/requests will be handled as same as
> > - * others which should be contiguous.
> > - */
> > -static inline bool blk_discard_mergable(struct request *req)
> > -{
> > -	if (req_op(req) == REQ_OP_DISCARD &&
> > -	    queue_max_discard_segments(req->q) > 1)
> > -		return true;
> > -	return false;
> > -}
> > -
> >  static enum elv_merge blk_try_req_merge(struct request *req,
> >  					struct request *next)
> >  {
> > diff --git a/block/elevator.c b/block/elevator.c
> > index 52ada14cfe45..a5fe2615ec0f 100644
> > --- a/block/elevator.c
> > +++ b/block/elevator.c
> > @@ -336,6 +336,9 @@ enum elv_merge elv_merge(struct request_queue *q, struct
> > request **req, __rq = elv_rqhash_find(q, bio->bi_iter.bi_sector);
> >  	if (__rq && elv_bio_merge_ok(__rq, bio)) {
> >  		*req = __rq;
> > +
> > +		if (blk_discard_mergable(__rq))
> > +			return ELEVATOR_DISCARD_MERGE;
> >  		return ELEVATOR_BACK_MERGE;
> >  	}
> > 
> > diff --git a/block/mq-deadline-main.c b/block/mq-deadline-main.c
> > index 6f612e6dc82b..294be0c0db65 100644
> > --- a/block/mq-deadline-main.c
> > +++ b/block/mq-deadline-main.c
> > @@ -677,6 +677,8 @@ static int dd_request_merge(struct request_queue *q,
> > struct request **rq,
> > 
> >  		if (elv_bio_merge_ok(__rq, bio)) {
> >  			*rq = __rq;
> > +			if (blk_discard_mergable(__rq))
> > +				return ELEVATOR_DISCARD_MERGE;
> >  			return ELEVATOR_FRONT_MERGE;
> >  		}
> >  	}
> > diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> > index 3177181c4326..87f00292fd7a 100644
> > --- a/include/linux/blkdev.h
> > +++ b/include/linux/blkdev.h
> > @@ -1521,6 +1521,22 @@ static inline int
> > queue_limit_discard_alignment(struct queue_limits *lim, sector return
> > offset << SECTOR_SHIFT;
> >  }
> > 
> > +/*
> > + * Two cases of handling DISCARD merge:
> > + * If max_discard_segments > 1, the driver takes every bio
> > + * as a range and send them to controller together. The ranges
> > + * needn't to be contiguous.
> > + * Otherwise, the bios/requests will be handled as same as
> > + * others which should be contiguous.
> > + */
> > +static inline bool blk_discard_mergable(struct request *req)
> > +{
> > +	if (req_op(req) == REQ_OP_DISCARD &&
> > +	    queue_max_discard_segments(req->q) > 1)
> > +		return true;
> > +	return false;
> > +}
> > +
> >  static inline int bdev_discard_alignment(struct block_device *bdev)
> >  {
> >  	struct request_queue *q = bdev_get_queue(bdev);
> 
> Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
> 
> Also,
> 
> Fixes: ?

Fixes: 2705dfb20947 ("block: fix discard request merge")

In theory, the fixes should be 1e739730c5b9 ("block: optionally merge
discontiguous discard bios into a single request"). The reason why it
isn't be triggered before 2705dfb20947 is that the nr_segment of each
bio is exactly 1 for multi-range device.

> 
> and possibly:
> 
> CC: stable@ # v5.x?

CC: stable@ # v5.13


Thanks,
Ming

