Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77E1CC433B4
	for <linux-block@archiver.kernel.org>; Fri,  7 May 2021 00:11:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 387CA61104
	for <linux-block@archiver.kernel.org>; Fri,  7 May 2021 00:11:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233453AbhEGAMW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 May 2021 20:12:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25404 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233434AbhEGAMV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 6 May 2021 20:12:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620346282;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DA5EB4tu/veYnHeUscglRA5Ki4isbRLp5IGAM/vLYmo=;
        b=Z4ks3oT/MM2xxz/MJnx3FfrwaIeQYIQ7MC0bXRTU1ZfcVEsWXswtl9aBdoOXWbLQ4DBC3H
        7ePH5vCeGvYwltaohCOR8z+mQ3kWzTjGjzAb7uHl7EQHt58c/vB0HwEcZT8CkcH1wShVd5
        0/rUqXuOnUBvOASL2IVcUOCyOLmzydM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-589-lbfAtcRmPOiB-fQk8FNq9g-1; Thu, 06 May 2021 20:11:21 -0400
X-MC-Unique: lbfAtcRmPOiB-fQk8FNq9g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7426164097;
        Fri,  7 May 2021 00:11:19 +0000 (UTC)
Received: from T590 (ovpn-12-93.pek2.redhat.com [10.72.12.93])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1785160CF1;
        Fri,  7 May 2021 00:11:11 +0000 (UTC)
Date:   Fri, 7 May 2021 08:11:07 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>,
        John Garry <john.garry@huawei.com>,
        David Jeffery <djeffery@redhat.com>
Subject: Re: [PATCH V5 3/4] blk-mq: clear stale request in tags->rq[] before
 freeing one request pool
Message-ID: <YJSFm99PUlLedF+D@T590>
References: <20210505145855.174127-1-ming.lei@redhat.com>
 <20210505145855.174127-4-ming.lei@redhat.com>
 <20210506071256.GD328487@infradead.org>
 <YJOb+a85Cpb56Mdz@T590>
 <20210506121849.GA400362@infradead.org>
 <b21d9e07-577b-f9cd-257f-323a82d8d74d@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b21d9e07-577b-f9cd-257f-323a82d8d74d@acm.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, May 06, 2021 at 07:51:53AM -0700, Bart Van Assche wrote:
> On 5/6/21 5:18 AM, Christoph Hellwig wrote:
> > On Thu, May 06, 2021 at 03:34:17PM +0800, Ming Lei wrote:
> >>> {
> >>> 	struct blk_mq_tags *drv_tags = set->tags[hctx_idx];
> >>> 	unsigned int i = 0;
> >>> 	unsigned long flags;
> >>>
> >>> 	spin_lock_irqsave(&drv_tags->lock, flags);
> >>> 	for (i = 0; i < set->queue_depth; i++)
> >>> 		WARN_ON_ONCE(refcount_read(&drv_tags->rqs[i]->ref) != 0);
> >>> 		drv_tags->rqs[i] = NULL;
> >>
> >> drv_tags->rqs[] may be assigned from another LUN at the same time, then
> >> the simple clearing will overwrite the active assignment. We just need
> >> to clear mapping iff the stored rq will be freed.
> > 
> > So.  Even a different LUN shares the same tagset.  So I can see the
> > need for the cmpxchg (please document it!), but I don't see the need
> > for the complex iteration.  All the rqs are freed in one single loop,
> > so we can just iterate through them sequentially.
> > 
> > Btw, I think ->lock might better be named ->clear_lock to document its
> > purpose better.
> 
> I'm not sure that would be a better name since I don't think that it is
> necessary to hold that lock around the cmpxchg() calls. How about using
> something like the following code in blk_mq_clear_rq_mapping() instead
> of the code in v5 of patch 3/4?
> 
> 	spin_lock_irqsave(&drv_tags->lock, flags);
> 	spin_unlock_irqrestore(&drv_tags->lock, flags);
> 
> 	list_for_each_entry(page, &tags->page_list, lru) {
> 		/* use cmpxchg() to clear request pointer selectively */
> 	}

This way won't work as expected because iterating may happen between
releasing drv_tags->lock and cmpxchg(->rqs[]), then freed requests
may still be touched during iteration after they are freed in blk_mq_free_rqs().


Thanks,
Ming

