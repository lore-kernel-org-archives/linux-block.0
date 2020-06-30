Return-Path: <SRS0=9ToN=AL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78D4DC433E1
	for <linux-block@archiver.kernel.org>; Tue, 30 Jun 2020 06:14:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FBBC20759
	for <linux-block@archiver.kernel.org>; Tue, 30 Jun 2020 06:14:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hhGoX3Ie"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730002AbgF3GN7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Jun 2020 02:13:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49241 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729768AbgF3GN7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Jun 2020 02:13:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593497638;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X43oPksfrR2Llm5cCzfoeSrgPCQRMZtjby3dRazA5LQ=;
        b=hhGoX3IeEGwfOq/v+cWQL+ftHySEghSPAahwy8Cx3+hAAn4JJYftg4AIBMZevPxye0loVq
        KaB34cHUgm+CVoq3hj6q5FV6dQOzAyIdFPvZnPUxAQm5o4jzIS7lV0fh8taEOPyTq0A338
        smNqIw97tVf6ngs3eEgxZtjfXSq7V98=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-197-J-Kb_wXxPHShluVNggIiXQ-1; Tue, 30 Jun 2020 02:13:56 -0400
X-MC-Unique: J-Kb_wXxPHShluVNggIiXQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C81151902EA0;
        Tue, 30 Jun 2020 06:13:54 +0000 (UTC)
Received: from T590 (ovpn-13-98.pek2.redhat.com [10.72.13.98])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 177DF741A7;
        Tue, 30 Jun 2020 06:13:49 +0000 (UTC)
Date:   Tue, 30 Jun 2020 14:13:45 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 3/3] blk-mq: centralise related handling into
 blk_mq_get_driver_tag
Message-ID: <20200630061345.GA2159457@T590>
References: <20200630022356.2149607-1-ming.lei@redhat.com>
 <20200630022356.2149607-4-ming.lei@redhat.com>
 <20200630050557.GE17653@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200630050557.GE17653@infradead.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 30, 2020 at 06:05:57AM +0100, Christoph Hellwig wrote:
> > index 21108a550fbf..3b0c5cfe922a 100644
> > --- a/block/blk-flush.c
> > +++ b/block/blk-flush.c
> > @@ -236,12 +236,10 @@ static void flush_end_io(struct request *flush_rq, blk_status_t error)
> >  		error = fq->rq_status;
> >  
> >  	hctx = flush_rq->mq_hctx;
> > +	if (!q->elevator)
> >  		flush_rq->tag = -1;
> > +	else
> >  		flush_rq->internal_tag = -1;
> 
> These should switch to BLK_MQ_NO_TAG which you're at it.

OK, we can do that in this patch.

> 
> > -	if (!(data->flags & BLK_MQ_REQ_INTERNAL))
> > -		blk_mq_tag_busy(data->hctx);
> 
> BLK_MQ_REQ_INTERNAL is gone now, so this won't apply.

blk_mq_tag_busy() is needed for either none and io scheduler, so it
is moved into blk_mq_get_driver_tag(), then check on BLK_MQ_REQ_INTERNAL
is gone.

> 
> >  static bool blk_mq_get_driver_tag(struct request *rq)
> >  {
> > +	struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
> > +	bool shared = blk_mq_tag_busy(rq->mq_hctx);
> > +
> > +	if (rq->tag == BLK_MQ_NO_TAG && !__blk_mq_get_driver_tag(rq))
> > +		return false;
> > +
> > +	if (shared) {
> > +		rq->rq_flags |= RQF_MQ_INFLIGHT;
> > +		atomic_inc(&hctx->nr_active);
> > +	}
> > +	hctx->tags->rqs[rq->tag] = rq;
> > +	return true;
> >  }
> 
> The function seems a bit misnamed now, although I don't have a good
> suggestion for a better name.

I think it is fine to leave it as-is, since what the patch does is just
to move blk_mq_tag_busy() & the RQF_MQ_INFLIGHT part from __blk_mq_get_driver_tag
to blk_mq_get_driver_tag().


Thanks,
Ming

