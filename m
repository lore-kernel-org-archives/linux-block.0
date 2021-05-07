Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEC5DC433ED
	for <linux-block@archiver.kernel.org>; Fri,  7 May 2021 00:14:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DC3061104
	for <linux-block@archiver.kernel.org>; Fri,  7 May 2021 00:14:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233418AbhEGAPO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 May 2021 20:15:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59010 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233434AbhEGAPO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 6 May 2021 20:15:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620346454;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=euJr+NGz5Z3ZPfc4xQr5pg0uKyrKnyrrSEI+ThooLOs=;
        b=HoW02DRDxNLNLvCI0BFHn9CEnUeTnrAT2nlyHHYLrCXPxqrD2C+sHkt9GM5z2uyNGyOwGl
        ACcfm2E4UoEQZwfqHHwz2Khu2LdARjsf5ZDmCwspvJJBl8D+4rKSXWR5JPKNxYFwBQQLRP
        RECM/pQ95j/eIwFKzSNwAitPpmCMB38=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-528-Pq97749RMdKZrk0EudDxxA-1; Thu, 06 May 2021 20:14:11 -0400
X-MC-Unique: Pq97749RMdKZrk0EudDxxA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 37EAA18B9EC3;
        Fri,  7 May 2021 00:14:10 +0000 (UTC)
Received: from T590 (ovpn-12-93.pek2.redhat.com [10.72.12.93])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0626960657;
        Fri,  7 May 2021 00:14:00 +0000 (UTC)
Date:   Fri, 7 May 2021 08:13:56 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>,
        John Garry <john.garry@huawei.com>,
        David Jeffery <djeffery@redhat.com>
Subject: Re: [PATCH V5 3/4] blk-mq: clear stale request in tags->rq[] before
 freeing one request pool
Message-ID: <YJSGRLEa/B4k8+9y@T590>
References: <20210505145855.174127-1-ming.lei@redhat.com>
 <20210505145855.174127-4-ming.lei@redhat.com>
 <db8a5f29-46b6-42c3-72c0-7ac70509e5d6@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db8a5f29-46b6-42c3-72c0-7ac70509e5d6@acm.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, May 06, 2021 at 08:02:53AM -0700, Bart Van Assche wrote:
> On 5/5/21 7:58 AM, Ming Lei wrote:
> > diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> > index 4a40d409f5dd..8b239dcce85f 100644
> > --- a/block/blk-mq-tag.c
> > +++ b/block/blk-mq-tag.c
> > @@ -203,9 +203,14 @@ static struct request *blk_mq_find_and_get_req(struct blk_mq_tags *tags,
> >  		unsigned int bitnr)
> >  {
> >  	struct request *rq = tags->rqs[bitnr];
> > +	unsigned long flags;
> >  
> > -	if (!rq || !refcount_inc_not_zero(&rq->ref))
> > +	spin_lock_irqsave(&tags->lock, flags);
> > +	if (!rq || !refcount_inc_not_zero(&rq->ref)) {
> > +		spin_unlock_irqrestore(&tags->lock, flags);
> >  		return NULL;
> > +	}
> > +	spin_unlock_irqrestore(&tags->lock, flags);
> >  	return rq;
> >  }
> Has it been considered to change the body of the if-statement into the
> following?
> 
> 		rq = NULL;
> 
> That change would reduce the number of return statements from two to one.

Looks cleaner, will take it in V6.


Thanks,
Ming

