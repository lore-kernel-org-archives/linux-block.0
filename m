Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A901C43334
	for <linux-block@archiver.kernel.org>; Thu, 16 Jun 2022 01:32:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347849AbiFPBcq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Jun 2022 21:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344002AbiFPBcp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Jun 2022 21:32:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D50DDDFC8
        for <linux-block@vger.kernel.org>; Wed, 15 Jun 2022 18:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655343163;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TkF9qoOOSam0uwfPFME0iL1wUxvMcaLdUnHvhgypc00=;
        b=XVvbrI7in2SwxCSwOUd2br9eFEh2vxH37RRWl/qEZCP8mSYO4c6HtPYOB6XZvfghh+7+Wf
        6BfasftOuA2eRkr27vMuWi+AR9abNTCjQOD1Tu8QPY/h4FDd8D4L6bpVQSGqqh7/DKLXz2
        gXKsnJtvRyhlMno0u4f4LMvVmoYA7o8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-48-JqZG3eJEMpWKdx4LlssbRw-1; Wed, 15 Jun 2022 21:32:37 -0400
X-MC-Unique: JqZG3eJEMpWKdx4LlssbRw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 660B9185A79C;
        Thu, 16 Jun 2022 01:32:37 +0000 (UTC)
Received: from T590 (ovpn-8-22.pek2.redhat.com [10.72.8.22])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7E79240CFD0A;
        Thu, 16 Jun 2022 01:32:34 +0000 (UTC)
Date:   Thu, 16 Jun 2022 09:32:29 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 3/3] block: Improve blk_mq_get_sq_hctx()
Message-ID: <YqqILdzCPbwB+Pk7@T590>
References: <20220615210136.1032199-1-bvanassche@acm.org>
 <20220615210136.1032199-4-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220615210136.1032199-4-bvanassche@acm.org>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jun 15, 2022 at 02:01:36PM -0700, Bart Van Assche wrote:
> Since the introduction of blk_mq_get_hctx_type() the operation type in
> the second argument of blk_mq_get_hctx_type() matters. Make sure that
> blk_mq_get_sq_hctx() selects a hardware queue of type HCTX_TYPE_DEFAULT
> instead of a hardware queue of type HCTX_TYPE_READ.
> 
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  block/blk-mq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index e9bf950983c7..7a5558bbc7f6 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2168,7 +2168,7 @@ static struct blk_mq_hw_ctx *blk_mq_get_sq_hctx(struct request_queue *q)
>  	 * just causes lock contention inside the scheduler and pointless cache
>  	 * bouncing.
>  	 */
> -	struct blk_mq_hw_ctx *hctx = blk_mq_map_queue(q, 0, ctx);
> +	struct blk_mq_hw_ctx *hctx = ctx->hctxs[HCTX_TYPE_DEFAULT];
>  
>  	if (!blk_mq_hctx_stopped(hctx))
>  		return hctx;

Looks fine, since the original behavior is to return hctx with HCTX_TYPE_DEFAULT
before commit 5d05426e2d5f ("blk-mq: don't touch ->tagset in blk_mq_get_sq_hctx").

Reviewed-by: Ming Lei <ming.lei@redhat.com>



thanks,
Ming

