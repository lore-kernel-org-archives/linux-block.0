Return-Path: <SRS0=kJV6=5Y=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D49B9C2D0EC
	for <linux-block@archiver.kernel.org>; Wed,  8 Apr 2020 01:38:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 792B2206F7
	for <linux-block@archiver.kernel.org>; Wed,  8 Apr 2020 01:38:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D+eGd8KG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbgDHBiq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Apr 2020 21:38:46 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:21397 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726421AbgDHBiq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 7 Apr 2020 21:38:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586309925;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EX654m5SzYXHo3s0O8Fk9j2QSRRVqZr+GuSNTZWrpkY=;
        b=D+eGd8KGdfFWu0TckNk2dPzVjAQtou2QFZ0bWa9L6pN/IN3UI5kSSHHtRiHFtRFmz3c5or
        Uc1fwXKahInIh8p2dXQRchXQHaQBQueN0Lnr7l+0aAlvEUXEW3P0sJHGFzb5jK9+V37/k6
        rLkolI2jQU2O78M0h5ODujI06e6L1cQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-460-FOQSbdUTM8iqvcWR7CBJ7Q-1; Tue, 07 Apr 2020 21:38:41 -0400
X-MC-Unique: FOQSbdUTM8iqvcWR7CBJ7Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 558B818A8C94;
        Wed,  8 Apr 2020 01:38:40 +0000 (UTC)
Received: from localhost.localdomain (ovpn-8-28.pek2.redhat.com [10.72.8.28])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A06C27E303;
        Wed,  8 Apr 2020 01:38:32 +0000 (UTC)
Date:   Wed, 8 Apr 2020 09:38:27 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Garry <john.garry@huawei.com>
Subject: Re: [PATCH V6 1/8] blk-mq: assign rq->tag in blk_mq_get_driver_tag
Message-ID: <20200408013827.GA337494@localhost.localdomain>
References: <20200407092901.314228-1-ming.lei@redhat.com>
 <20200407092901.314228-2-ming.lei@redhat.com>
 <20200407171405.GA5614@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200407171405.GA5614@lst.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 07, 2020 at 07:14:05PM +0200, Christoph Hellwig wrote:
> On Tue, Apr 07, 2020 at 05:28:54PM +0800, Ming Lei wrote:
> > @@ -472,14 +462,18 @@ static void __blk_mq_free_request(struct request *rq)
> >  	struct request_queue *q = rq->q;
> >  	struct blk_mq_ctx *ctx = rq->mq_ctx;
> >  	struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
> > -	const int sched_tag = rq->internal_tag;
> > +	const int tag = rq->internal_tag;
> > +	bool has_sched = !!hctx->sched_tags;
> >  
> >  	blk_pm_mark_last_busy(rq);
> >  	rq->mq_hctx = NULL;
> > +	if (!has_sched)
> > +		blk_mq_put_tag(hctx->tags, ctx, tag);
> > +	else if (rq->tag >= 0)
> >  		blk_mq_put_tag(hctx->tags, ctx, rq->tag);
> > +
> > +	if (has_sched)
> > +		blk_mq_put_tag(hctx->sched_tags, ctx, tag);
> 
> This looks weird to me.  Why not simply:
> 
> 	if (hctx->sched_tags) {
> 		if (rq->tag >= 0)
> 			blk_mq_put_tag(hctx->tags, ctx, rq->tag);
> 		blk_mq_put_tag(hctx->sched_tags, ctx, rq->internal_tag);
> 	} else {
> 		blk_mq_put_tag(hctx->tags, ctx, rq->internal_tag);
> 	}

Nice!

> 
> 
> > @@ -1037,14 +1031,21 @@ bool blk_mq_get_driver_tag(struct request *rq)
> 
> FYI, it seems like blk_mq_get_driver_tag can be marked static.
> 
> Otherwise this looks pretty sensible to me.

Indeed, just forgot to do that.


Thanks,
Ming

