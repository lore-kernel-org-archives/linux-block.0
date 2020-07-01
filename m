Return-Path: <SRS0=s14/=AM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 481C5C433DF
	for <linux-block@archiver.kernel.org>; Wed,  1 Jul 2020 13:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23FFC20663
	for <linux-block@archiver.kernel.org>; Wed,  1 Jul 2020 13:51:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VmmIzLxw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731181AbgGANvx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 Jul 2020 09:51:53 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:26889 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730408AbgGANvx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 1 Jul 2020 09:51:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593611512;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=o9+wvHf4EhMOC7EtJKRx4gVvmTjL560eBnKQZls3AmE=;
        b=VmmIzLxwS2NgdHw/ES9D5e4FdxcZBU88Xf6Eer3x5xGSsnIxtTfoK9JAyH6/EEDvLZbk60
        kxXCTnudPK30jVhbPgCy89TQCg7LEf5MKIF5KSVRj3Z2DC4+xa9vW7MLVHZ3N2c6hVlV3E
        fYEDufKOxzcQsB9pJ1OoffbZn2x+XgM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-86-b5ntXv5hPiC4inrOabGHXQ-1; Wed, 01 Jul 2020 09:51:50 -0400
X-MC-Unique: b5ntXv5hPiC4inrOabGHXQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 92F18835B67;
        Wed,  1 Jul 2020 13:51:49 +0000 (UTC)
Received: from T590 (ovpn-12-33.pek2.redhat.com [10.72.12.33])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A34D45C1C5;
        Wed,  1 Jul 2020 13:51:44 +0000 (UTC)
Date:   Wed, 1 Jul 2020 21:51:39 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH] blk-mq: streamline handling of q->mq_ops->queue_rq result
Message-ID: <20200701135139.GB2443512@T590>
References: <20200701101617.2434985-1-ming.lei@redhat.com>
 <20200701125409.GA13335@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200701125409.GA13335@infradead.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jul 01, 2020 at 01:54:09PM +0100, Christoph Hellwig wrote:
> On Wed, Jul 01, 2020 at 06:16:17PM +0800, Ming Lei wrote:
> > Current handling of q->mq_ops->queue_rq result is a bit ugly:
> > 
> > - two branches which needs to 'continue' have to check if the
> > dispatch local list is empty, otherwise one bad request may
> > be retrieved via 'rq = list_first_entry(list, struct request, queuelist);'
> > 
> > - the branch of 'if (unlikely(ret != BLK_STS_OK))' isn't easy
> > to follow, since it is actually one error branch.
> > 
> > Streamline this handling, so the code becomes more readable, meantime
> > potential kernel oops can be avoided in case that the last request in
> > local dispatch list is failed.
> 
> I don't really find that much easier to read.  If we want to clean
> this up for rea we should use a proper switch statement.  Something like
> this:
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index a9aa6d1e44cf32..f3721f274b800e 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1275,30 +1275,28 @@ bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list,
>  		}
>  
>  		ret = q->mq_ops->queue_rq(hctx, &bd);
> -		if (ret == BLK_STS_RESOURCE || ret == BLK_STS_DEV_RESOURCE) {
> -			blk_mq_handle_dev_resource(rq, list);
> +		switch (ret) {
> +		case BLK_STS_OK:
> +			queued++;
>  			break;
> -		} else if (ret == BLK_STS_ZONE_RESOURCE) {
> +		case BLK_STS_RESOURCE:
> +		case BLK_STS_DEV_RESOURCE:
> +			blk_mq_handle_dev_resource(rq, list);
> +			goto out;
> +		case BLK_STS_ZONE_RESOURCE:
>  			/*
>  			 * Move the request to zone_list and keep going through
>  			 * the dispatch list to find more requests the drive can
>  			 * accept.
>  			 */
>  			blk_mq_handle_zone_resource(rq, &zone_list);
> -			if (list_empty(list))
> -				break;
> -			continue;
> -		}
> -
> -		if (unlikely(ret != BLK_STS_OK)) {
> +			break;
> +		default:
>  			errors++;
>  			blk_mq_end_request(rq, BLK_STS_IOERR);
> -			continue;
>  		}
> -
> -		queued++;
>  	} while (!list_empty(list));
> -
> +out:
>  	if (!list_empty(&zone_list))
>  		list_splice_tail_init(&zone_list, list);

I am fine to switch back to 'switch'. I doesn't take 'switch' because you
changed 'switch' to 'if else' before.


Thanks,
Ming

