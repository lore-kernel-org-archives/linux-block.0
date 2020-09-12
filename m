Return-Path: <SRS0=0HSq=CV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7183C433E2
	for <linux-block@archiver.kernel.org>; Sat, 12 Sep 2020 13:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6519920855
	for <linux-block@archiver.kernel.org>; Sat, 12 Sep 2020 13:58:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FVGV0svF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725854AbgILN6q (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 12 Sep 2020 09:58:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26995 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725848AbgILN6o (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 12 Sep 2020 09:58:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599919122;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sIS0z+OSHzxyt/gsTVJl97Jrp1M6RO4hEABRwxQ0KH8=;
        b=FVGV0svFjybEeGzLunzjnayDNkD0oze0G1oBF25EcUiojzQIWNnM+cT3BY9awBNt3fGrXt
        vHj0BGBTJeP2YEiIb5Pw7D6AJ1i54x8efROYqgCWKGrfhUZl35AhhYotzeNiYe4uliP4tX
        p5j/UTw229tZSGKVi+NEnORFC678/d0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-420-TEfeQITjOAWjHYtgOtea4w-1; Sat, 12 Sep 2020 09:58:38 -0400
X-MC-Unique: TEfeQITjOAWjHYtgOtea4w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EF2A58797DD;
        Sat, 12 Sep 2020 13:58:37 +0000 (UTC)
Received: from T590 (ovpn-12-84.pek2.redhat.com [10.72.12.84])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C6CEB75129;
        Sat, 12 Sep 2020 13:58:26 +0000 (UTC)
Date:   Sat, 12 Sep 2020 21:58:22 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Vijayendra Suman <vijayendra.suman@oracle.com>,
        dm-devel@redhat.com, linux-block@vger.kernel.org
Subject: Re: [PATCH 2/3] block: use lcm_not_zero() when stacking chunk_sectors
Message-ID: <20200912135822.GB210077@T590>
References: <20200911215338.44805-1-snitzer@redhat.com>
 <20200911215338.44805-3-snitzer@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200911215338.44805-3-snitzer@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Sep 11, 2020 at 05:53:37PM -0400, Mike Snitzer wrote:
> Like 'io_opt', blk_stack_limits() should stack 'chunk_sectors' using
> lcm_not_zero() rather than min_not_zero() -- otherwise the final
> 'chunk_sectors' could result in sub-optimal alignment of IO to
> component devices in the IO stack.
> 
> Also, if 'chunk_sectors' isn't a multiple of 'physical_block_size'
> then it is a bug in the driver and the device should be flagged as
> 'misaligned'.
> 
> Signed-off-by: Mike Snitzer <snitzer@redhat.com>
> ---
>  block/blk-settings.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/block/blk-settings.c b/block/blk-settings.c
> index 76a7e03bcd6c..b09642d5f15e 100644
> --- a/block/blk-settings.c
> +++ b/block/blk-settings.c
> @@ -534,6 +534,7 @@ int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
>  
>  	t->io_min = max(t->io_min, b->io_min);
>  	t->io_opt = lcm_not_zero(t->io_opt, b->io_opt);
> +	t->chunk_sectors = lcm_not_zero(t->chunk_sectors, b->chunk_sectors);
>  
>  	/* Physical block size a multiple of the logical block size? */
>  	if (t->physical_block_size & (t->logical_block_size - 1)) {
> @@ -556,6 +557,13 @@ int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
>  		ret = -1;
>  	}
>  
> +	/* chunk_sectors a multiple of the physical block size? */
> +	if (t->chunk_sectors & (t->physical_block_size - 1)) {
> +		t->chunk_sectors = 0;
> +		t->misaligned = 1;
> +		ret = -1;
> +	}
> +
>  	t->raid_partial_stripes_expensive =
>  		max(t->raid_partial_stripes_expensive,
>  		    b->raid_partial_stripes_expensive);
> @@ -594,10 +602,6 @@ int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
>  			t->discard_granularity;
>  	}
>  
> -	if (b->chunk_sectors)
> -		t->chunk_sectors = min_not_zero(t->chunk_sectors,
> -						b->chunk_sectors);
> -
>  	t->zoned = max(t->zoned, b->zoned);
>  	return ret;
>  }

Looks fine:

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming

