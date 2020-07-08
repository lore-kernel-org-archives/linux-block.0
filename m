Return-Path: <SRS0=UAvt=AT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01B7BC433DF
	for <linux-block@archiver.kernel.org>; Wed,  8 Jul 2020 12:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE88320772
	for <linux-block@archiver.kernel.org>; Wed,  8 Jul 2020 12:28:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J1qeKRYz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728965AbgGHM2F (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 8 Jul 2020 08:28:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54972 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728897AbgGHM2E (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 Jul 2020 08:28:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594211283;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rfvluvNjseWs4DrHeUjkWwMv6bKVX/UGmIQ1X8AbaqY=;
        b=J1qeKRYz+ORgqibijUCUBcFCTNsnz29kf2lIdrgBYOIwHGGj4WfTK7jriASu43cW6tx1gQ
        hOs5ynHbvTcewGG/2sYBB7bgvkmmuuqTe1E3P6y6Mt3EEGvUo8cUoX9CCCwmNWVN0y73Sa
        bnHdRmdqmjnKREYNJ6QHZ8YQJ03UKVs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-260-H3RLhDKUMRO3f0d9R7OJjg-1; Wed, 08 Jul 2020 08:28:01 -0400
X-MC-Unique: H3RLhDKUMRO3f0d9R7OJjg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E6A3C107ACF2;
        Wed,  8 Jul 2020 12:28:00 +0000 (UTC)
Received: from T590 (ovpn-12-49.pek2.redhat.com [10.72.12.49])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9ED0173FC0;
        Wed,  8 Jul 2020 12:27:53 +0000 (UTC)
Date:   Wed, 8 Jul 2020 20:27:49 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH V2] blk-mq: streamline handling of q->mq_ops->queue_rq
 result
Message-ID: <20200708122749.GA3340386@T590>
References: <20200701135857.2445459-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200701135857.2445459-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jul 01, 2020 at 09:58:57PM +0800, Ming Lei wrote:
> Current handling of q->mq_ops->queue_rq result is a bit ugly:
> 
> - two branches which needs to 'continue' have to check if the
> dispatch local list is empty, otherwise one bad request may
> be retrieved via 'rq = list_first_entry(list, struct request, queuelist);'
> 
> - the branch of 'if (unlikely(ret != BLK_STS_OK))' isn't easy
> to follow, since it is actually one error branch.
> 
> Streamline this handling, so the code becomes more readable, meantime
> potential kernel oops can be avoided in case that the last request in
> local dispatch list is failed.
> 
> Fixes: fc17b6534eb8 ("blk-mq: switch ->queue_rq return value to blk_status_t")
> Cc: Christoph Hellwig <hch@infradead.org>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
> V2:
> 	- change 'if else' to switch as suggested by Christoph
> 
>  block/blk-mq.c | 24 +++++++++++-------------
>  1 file changed, 11 insertions(+), 13 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 65e0846fd065..cc85775fc372 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1407,30 +1407,28 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list,
>  		if (nr_budgets)
>  			nr_budgets--;
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
>  
> -- 
> 2.25.2
> 

Hello,

Ping...

-- 
Ming

