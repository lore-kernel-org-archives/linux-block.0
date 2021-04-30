Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4C8FC433B4
	for <linux-block@archiver.kernel.org>; Fri, 30 Apr 2021 03:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 709A66143D
	for <linux-block@archiver.kernel.org>; Fri, 30 Apr 2021 03:13:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbhD3DNs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Apr 2021 23:13:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44790 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229577AbhD3DNs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Apr 2021 23:13:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619752380;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xkCOAQn3mAeIKP/aVUs7yTeyXp9Pf/9akrFUxGqjLBw=;
        b=WBnsd3CzoNaBsrOiNbLSftPUTtmnAFg5UT8AXdGYHVb3IFOAd+Ri8ND+++Q0JAuwfQEIDp
        BU5YmY9z+usDPAngcMUKGEy7DGzQqEDDBS4JC6rsK5+sEpmLHOlGTK6pDRg/to0VM4Lzsl
        vmXcEs7ndYSOGv/lvNYfhAZHemmcDpk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-303-cTvOTTfZNbG6TRI9iiJFtw-1; Thu, 29 Apr 2021 23:12:58 -0400
X-MC-Unique: cTvOTTfZNbG6TRI9iiJFtw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1EC99107ACC7;
        Fri, 30 Apr 2021 03:12:57 +0000 (UTC)
Received: from T590 (ovpn-12-77.pek2.redhat.com [10.72.12.77])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E5A984EE1C;
        Fri, 30 Apr 2021 03:12:47 +0000 (UTC)
Date:   Fri, 30 Apr 2021 11:12:58 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Khazhy Kumykov <khazhy@google.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        John Garry <john.garry@huawei.com>,
        David Jeffery <djeffery@redhat.com>
Subject: Re: [PATCH V4 1/4] block: avoid double io accounting for flush
 request
Message-ID: <YIt1uuo8GK3ePovh@T590>
References: <20210429023458.3044317-1-ming.lei@redhat.com>
 <20210429023458.3044317-2-ming.lei@redhat.com>
 <254e529e-f07c-b87a-e117-07dbb02312af@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <254e529e-f07c-b87a-e117-07dbb02312af@acm.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Apr 29, 2021 at 07:51:37PM -0700, Bart Van Assche wrote:
> On 4/28/21 7:34 PM, Ming Lei wrote:
> > For flush request, rq->end_io() may be called two times, one is from
> > timeout handling(blk_mq_check_expired()), another is from normal
> > completion(__blk_mq_end_request()).
> > 
> > Move blk_account_io_flush() after flush_rq->ref drops to zero, so
> > io accounting can be done just once for flush request.
> > 
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  block/blk-flush.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/block/blk-flush.c b/block/blk-flush.c
> > index 7942ca6ed321..1002f6c58181 100644
> > --- a/block/blk-flush.c
> > +++ b/block/blk-flush.c
> > @@ -219,8 +219,6 @@ static void flush_end_io(struct request *flush_rq, blk_status_t error)
> >  	unsigned long flags = 0;
> >  	struct blk_flush_queue *fq = blk_get_flush_queue(q, flush_rq->mq_ctx);
> >  
> > -	blk_account_io_flush(flush_rq);
> > -
> >  	/* release the tag's ownership to the req cloned from */
> >  	spin_lock_irqsave(&fq->mq_flush_lock, flags);
> >  
> > @@ -230,6 +228,7 @@ static void flush_end_io(struct request *flush_rq, blk_status_t error)
> >  		return;
> >  	}
> >  
> > +	blk_account_io_flush(flush_rq);
> >  	/*
> >  	 * Flush request has to be marked as IDLE when it is really ended
> >  	 * because its .end_io() is called from timeout code path too for
> 
> How about adding the following:
> 
> Fixes: b68663186577 ("block: add iostat counters for flush requests")

Yeah, good point, thanks!

Jens, I guess you may cover that, or please let me know if V5 is needed. 

Thanks, 
Ming

