Return-Path: <SRS0=EWxa=7Q=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93375C433E1
	for <linux-block@archiver.kernel.org>; Wed,  3 Jun 2020 13:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7293C206C3
	for <linux-block@archiver.kernel.org>; Wed,  3 Jun 2020 13:36:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ey2wXXFH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725973AbgFCNgX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Jun 2020 09:36:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60912 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725810AbgFCNgX (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 Jun 2020 09:36:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591191382;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oo6s/JO+X2E+cKvgOaAKL4AKc/FphCKKwEj9u5En6xc=;
        b=ey2wXXFHhfcMZ5wK0eoXbq/8pyrkipxOcQafS091mforKw2VHNy1UbJJf3icRjqvcDLVfn
        v00m9DzuRTmAZoP/LguIOof+hqBoQs1cudM2BEKMYVA6XiWik31hClVnfPETbMQf5R3SI2
        VDjEk7R/eGibvwycsh8MVS4fc87VRX4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-229-_oEJK1HqOgumsuebyKMnVA-1; Wed, 03 Jun 2020 09:36:20 -0400
X-MC-Unique: _oEJK1HqOgumsuebyKMnVA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 09D8080058E;
        Wed,  3 Jun 2020 13:36:19 +0000 (UTC)
Received: from T590 (ovpn-12-82.pek2.redhat.com [10.72.12.82])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B649E7F0BE;
        Wed,  3 Jun 2020 13:36:12 +0000 (UTC)
Date:   Wed, 3 Jun 2020 21:36:08 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Dongli Zhang <dongli.zhang@oracle.com>,
        John Garry <john.garry@huawei.com>,
        Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>
Subject: Re: [PATCH] blk-mq: don't fail driver tag allocation because of
 inactive hctx
Message-ID: <20200603133608.GA2149752@T590>
References: <20200603105128.2147139-1-ming.lei@redhat.com>
 <20200603115347.GA8653@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200603115347.GA8653@lst.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jun 03, 2020 at 01:53:47PM +0200, Christoph Hellwig wrote:
> On Wed, Jun 03, 2020 at 06:51:27PM +0800, Ming Lei wrote:
> > Commit bf0beec0607d ("blk-mq: drain I/O when all CPUs in a hctx are offline")
> > prevents new request from being allocated on hctx which is going to be inactive,
> > meantime drains all in-queue requests.
> > 
> > We needn't to prevent driver tag from being allocated during cpu hotplug, more
> > importantly we have to provide driver tag for requests, so that the cpu hotplug
> > handling can move on. blk_mq_get_tag() is shared for allocating both internal
> > tag and drive tag, so driver tag allocation may fail because the hctx is
> > marked as inactive.
> > 
> > Fix the issue by moving BLK_MQ_S_INACTIVE check to __blk_mq_alloc_request().
> 
> This looks correct, but a little ugly.  How about we resurrect my
> patch to split off blk_mq_get_driver_tag entirely?  Quick untested rebase

OK, I am fine.

> below, still needs a better changelog and fixes tg:
> 
> ---
> From e432011e2eb5ac7bd1046bbf936645e9f7b74e64 Mon Sep 17 00:00:00 2001
> From: Christoph Hellwig <hch@lst.de>
> Date: Sat, 16 May 2020 08:03:48 +0200
> Subject: blk-mq: split out a __blk_mq_get_driver_tag helper
> 
> Allocation of the driver tag in the case of using a scheduler shares very
> little code with the "normal" tag allocation.  Split out a new helper to
> streamline this path, and untangle it from the complex normal tag
> allocation.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/blk-mq-tag.c | 27 +++++++++++++++++++++++++++
>  block/blk-mq-tag.h |  8 ++++++++
>  block/blk-mq.c     | 29 -----------------------------
>  block/blk-mq.h     |  1 -
>  4 files changed, 35 insertions(+), 30 deletions(-)
> 
> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> index 96a39d0724a29..cded7fdcad8ef 100644
> --- a/block/blk-mq-tag.c
> +++ b/block/blk-mq-tag.c
> @@ -191,6 +191,33 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
>  	return tag + tag_offset;
>  }
>  
> +bool __blk_mq_get_driver_tag(struct request *rq)
> +{
> +	struct sbitmap_queue *bt = &rq->mq_hctx->tags->bitmap_tags;
> +	unsigned int tag_offset = rq->mq_hctx->tags->nr_reserved_tags;
> +	bool shared = blk_mq_tag_busy(rq->mq_hctx);

Not necessary to add 'shared' which is just used once.

> +	int tag;
> +
> +	if (blk_mq_tag_is_reserved(rq->mq_hctx->sched_tags, rq->internal_tag)) {
> +		bt = &rq->mq_hctx->tags->breserved_tags;

Too many rq->mq_hctx->tags, you can add one local variable to store it.

Otherwise, looks fine:

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks, 
Ming

