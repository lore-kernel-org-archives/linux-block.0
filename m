Return-Path: <SRS0=zlmp=6K=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D28A1C55186
	for <linux-block@archiver.kernel.org>; Sun, 26 Apr 2020 02:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7D6120724
	for <linux-block@archiver.kernel.org>; Sun, 26 Apr 2020 02:54:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fTGlEpJ2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbgDZCyG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 25 Apr 2020 22:54:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47665 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725952AbgDZCyF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 25 Apr 2020 22:54:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587869644;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1uPhAMtqHGB5U2FgSCo8OktpraHomkEwF0Bv26tlO0k=;
        b=fTGlEpJ2gn9Myb0zsR7gD7O0fwx0S10etCheZnxkvMRi1HdPkedm+TOZsYgj3bsmEjORjk
        IhfMBCQbVR9dWA6KF5Irwq9RO1wVIkCN8Q1zLP5JN6YlKPxuW9XMGsIQKKUVvgbWRwbw7/
        dbbq9YGIQgsy2h+GJTkS5MbTnVS/4nw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-128-Lpxbc5zbMaG-GjRaRwnyfw-1; Sat, 25 Apr 2020 22:54:02 -0400
X-MC-Unique: Lpxbc5zbMaG-GjRaRwnyfw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BDD3B107ACCD;
        Sun, 26 Apr 2020 02:54:01 +0000 (UTC)
Received: from T590 (ovpn-8-31.pek2.redhat.com [10.72.8.31])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C0FEE26553;
        Sun, 26 Apr 2020 02:53:56 +0000 (UTC)
Date:   Sun, 26 Apr 2020 10:53:52 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 06/11] block: optimize generic_make_request for direct to
 blk-mq issue
Message-ID: <20200426025352.GA512559@T590>
References: <20200425170944.968861-1-hch@lst.de>
 <20200425170944.968861-7-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200425170944.968861-7-hch@lst.de>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Apr 25, 2020 at 07:09:39PM +0200, Christoph Hellwig wrote:
> Don't bother with the on-stack bio list if we know that we directly
> issue to a request based driver that can't re-inject bios.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/blk-core.c | 29 +++++++++++++++++++----------
>  1 file changed, 19 insertions(+), 10 deletions(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 732d5b8d3cd25..e8c48203b2c55 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -1008,6 +1008,18 @@ generic_make_request_checks(struct bio *bio)
>  	return false;
>  }
>  
> +static inline blk_qc_t __direct_make_request(struct bio *bio)
> +{
> +	struct request_queue *q = bio->bi_disk->queue;
> +	blk_qc_t ret;
> +
> +	if (unlikely(bio_queue_enter(bio)))
> +		return BLK_QC_T_NONE;
> +	ret = blk_mq_make_request(q, bio);
> +	blk_queue_exit(q);
> +	return ret;
> +}
> +
>  static blk_qc_t do_make_request(struct bio *bio,
>  		struct bio_list bio_list_on_stack[2])
>  {
> @@ -1116,7 +1128,10 @@ blk_qc_t generic_make_request(struct bio *bio)
>  		return BLK_QC_T_NONE;
>  	}
>  
> -	return __generic_make_request(bio);
> +	if (bio->bi_disk->queue->make_request_fn)
> +		return __generic_make_request(bio);
> +	return __direct_make_request(bio);
> +

blk_mq_make_request() still calls into generic_make_request(), so bio
may be added to current->bio_list, then looks __direct_make_request()
can't cover recursive bio submission any more.

Thanks,
Ming

