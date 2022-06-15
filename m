Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD49CC43334
	for <linux-block@archiver.kernel.org>; Wed, 15 Jun 2022 00:31:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbiFOAbh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Jun 2022 20:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbiFOAbg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Jun 2022 20:31:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CF9D033E84
        for <linux-block@vger.kernel.org>; Tue, 14 Jun 2022 17:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655253093;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=M1F3F9uqNCZgf4x+Naqow03ujnp0tEQlqtA+JPX2pBE=;
        b=UdFA7DkK4C4xA23SpH/Q4kYhYP3zaGLHrWeig9d2W5oU4rstrqPoQ3sduXN+abnQEmOTWa
        ZjCHOh8cwlF2LMCD6lYP2kD+WhwHJrn02JVjiWkBhtRj7TTQUv1ALkx75p29QYUH+ylRYA
        el+jGeonkW3eTF6m+lJejqVfb1jogeA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-453-QTVhEMBrN5m_VFt_v4XVng-1; Tue, 14 Jun 2022 20:31:30 -0400
X-MC-Unique: QTVhEMBrN5m_VFt_v4XVng-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E42A13804510;
        Wed, 15 Jun 2022 00:31:29 +0000 (UTC)
Received: from T590 (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AC1132166B26;
        Wed, 15 Jun 2022 00:31:26 +0000 (UTC)
Date:   Wed, 15 Jun 2022 08:31:21 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 3/3] block: Specify the operation type when calling
 blk_mq_map_queue()
Message-ID: <YqkoWUjOPgpqzn4E@T590>
References: <20220614175725.612878-1-bvanassche@acm.org>
 <20220614175725.612878-4-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220614175725.612878-4-bvanassche@acm.org>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 14, 2022 at 10:57:25AM -0700, Bart Van Assche wrote:
> Since the introduction of blk_mq_get_hctx_type() the operation type in
> the second argument of blk_mq_get_hctx_type() matters. Make sure that
> a hardware queue of type HCTX_TYPE_DEFAULT is selected instead of a
> hardware queue of type HCTX_TYPE_READ.
> 
> Cc: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  block/blk-mq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index e9bf950983c7..9b1518ef1aa1 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2168,7 +2168,7 @@ static struct blk_mq_hw_ctx *blk_mq_get_sq_hctx(struct request_queue *q)
>  	 * just causes lock contention inside the scheduler and pointless cache
>  	 * bouncing.
>  	 */
> -	struct blk_mq_hw_ctx *hctx = blk_mq_map_queue(q, 0, ctx);
> +	struct blk_mq_hw_ctx *hctx = blk_mq_map_queue(q, REQ_OP_WRITE, ctx);

The change itself doesn't make a difference, since both results in choosing
HCTX_TYPE_DEFAULT, but passing REQ_OP_WRITE is a bit misleading.


Thanks,
Ming

