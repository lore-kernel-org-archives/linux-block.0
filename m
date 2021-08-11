Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6AADC4338F
	for <linux-block@archiver.kernel.org>; Wed, 11 Aug 2021 15:11:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8B1760FC0
	for <linux-block@archiver.kernel.org>; Wed, 11 Aug 2021 15:11:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232812AbhHKPLc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Aug 2021 11:11:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48018 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232440AbhHKPLb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Aug 2021 11:11:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628694667;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q+40xNMQU/xc7D8FDU5P7zNo8j1ccgVTJ1hMs7u/sBg=;
        b=FyXiDMBFIaiBXOKjziMTaITwhLw8KgW83D6fOBdRROZnyIidxVjH1c5f1ZtPfKJaquQIon
        ijZItvURoIEwC3E9sxtAb+NCyQXyoLHPZXT5xfBbhXawveizNmO88Uxy2/e3R6FnjlPtJE
        0ahD+8dSGDVCVANmUesEC1I6ZEeROB4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-8-Pc3Pl7AhOKeYZbSQ1admfA-1; Wed, 11 Aug 2021 11:11:05 -0400
X-MC-Unique: Pc3Pl7AhOKeYZbSQ1admfA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 68CBA801B3C;
        Wed, 11 Aug 2021 15:11:04 +0000 (UTC)
Received: from T590 (ovpn-12-52.pek2.redhat.com [10.72.12.52])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6628D2B0A9;
        Wed, 11 Aug 2021 15:10:57 +0000 (UTC)
Date:   Wed, 11 Aug 2021 23:10:52 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>,
        John Garry <john.garry@huawei.com>
Subject: Re: [PATCH] blk-mq: don't grab rq's refcount in
 blk_mq_check_expired()
Message-ID: <YRPofJh/dKafevpV@T590>
References: <20210811143838.622001-1-ming.lei@redhat.com>
 <20210811145525.GA61802@C02WT3WMHTD6>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210811145525.GA61802@C02WT3WMHTD6>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Aug 11, 2021 at 08:55:25AM -0600, Keith Busch wrote:
> On Wed, Aug 11, 2021 at 10:38:38PM +0800, Ming Lei wrote:
> > Inside blk_mq_queue_tag_busy_iter() we already grabbed request's
> > refcount before calling ->fn(), so needn't to grab it one more time
> > in blk_mq_check_expired().
> > 
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  block/blk-mq.c | 25 +++++++------------------
> >  1 file changed, 7 insertions(+), 18 deletions(-)
> > 
> > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > index d2725f94491d..4d3457d2957f 100644
> > --- a/block/blk-mq.c
> > +++ b/block/blk-mq.c
> > @@ -917,6 +917,10 @@ void blk_mq_put_rq_ref(struct request *rq)
> >  		__blk_mq_free_request(rq);
> >  }
> >  
> > +/*
> > + * This request won't be re-allocated because its refcount is held when
> > + * calling this callback.
> > + */
> >  static bool blk_mq_check_expired(struct blk_mq_hw_ctx *hctx,
> >  		struct request *rq, void *priv, bool reserved)
> >  {
> > @@ -930,27 +934,12 @@ static bool blk_mq_check_expired(struct blk_mq_hw_ctx *hctx,
> >  		return true;
> >  
> >  	/*
> > -	 * We have reason to believe the request may be expired. Take a
> > -	 * reference on the request to lock this request lifetime into its
> > -	 * currently allocated context to prevent it from being reallocated in
> > -	 * the event the completion by-passes this timeout handler.
> > -	 *
> > -	 * If the reference was already released, then the driver beat the
> > -	 * timeout handler to posting a natural completion.
> > -	 */
> > -	if (!refcount_inc_not_zero(&rq->ref))
> > -		return true;
> > -
> > -	/*
> > -	 * The request is now locked and cannot be reallocated underneath the
> > -	 * timeout handler's processing. Re-verify this exact request is truly
> > -	 * expired; if it is not expired, then the request was completed and
> > -	 * reallocated as a new request.
> > +	 * Re-verify this exact request is truly expired; if it is not expired,
> > +	 * then the request was completed and reallocated as a new request
> > +	 * after returning from blk_mq_check_expired().
> >  	 */
> >  	if (blk_mq_req_expired(rq, next))
> >  		blk_mq_rq_timed_out(rq, reserved);
> 
> There's no need to check expired twice if the iterator is already taking a
> reference. I had this double check because I didn't want to penalize normal IO
> by preventing it from completing while the timeout handler is running, but it
> looks like the current timeout iterator is going to do that anyway.

Indeed, will clean that in V2.


Thanks,
Ming

