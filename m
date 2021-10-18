Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CF48C433F5
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 01:49:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 354FA61027
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 01:49:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242957AbhJRBvz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 17 Oct 2021 21:51:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36596 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235368AbhJRBvz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 17 Oct 2021 21:51:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634521784;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wvbqwT6JOn4vPU7EEG0cLC4MpIsizCcdEfa5JCFAlnE=;
        b=iLDNhf3hm+JtW0b+K+fTNVQ1czkmkp5NnvY/eAG1AkMjVcjV1MHQfS0AKIFZagbCnuhgvG
        0Ns7oxyLxDCRiDFDW802tMKeJ6XXZ5TFlJaaNr+W5KcvRfVWC5EZ4ZSeA2jTrs9ZcFQvvX
        uX7IiAmYt64/VoGHNzycuRZJUDKwJdg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-474-mkg1LEzjPhqsXt3jQmfiuQ-1; Sun, 17 Oct 2021 21:49:42 -0400
X-MC-Unique: mkg1LEzjPhqsXt3jQmfiuQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9F033180830C;
        Mon, 18 Oct 2021 01:49:41 +0000 (UTC)
Received: from T590 (ovpn-8-22.pek2.redhat.com [10.72.8.22])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 790F360BF4;
        Mon, 18 Oct 2021 01:49:36 +0000 (UTC)
Date:   Mon, 18 Oct 2021 09:49:31 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block: don't dereference request after flush insertion
Message-ID: <YWzSqzsuDF8Fl9jB@T590>
References: <f2f17f46-ff3a-01c4-bfd4-8dec836ec343@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2f17f46-ff3a-01c4-bfd4-8dec836ec343@kernel.dk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Oct 16, 2021 at 07:35:39PM -0600, Jens Axboe wrote:
> We could have a race here, where the request gets freed before we call
> into blk_mq_run_hw_queue(). If this happens, we cannot rely on the state
> of the request.
> 
> Grab the hardware context before inserting the flush.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
> ---
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 2197cfbf081f..22b30a89bf3a 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2468,9 +2468,10 @@ void blk_mq_submit_bio(struct bio *bio)
>  	}
>  
>  	if (unlikely(is_flush_fua)) {
> +		struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
>  		/* Bypass scheduler for flush requests */
>  		blk_insert_flush(rq);
> -		blk_mq_run_hw_queue(rq->mq_hctx, true);
> +		blk_mq_run_hw_queue(hctx, true);

If the request is freed before running queue, the request queue could
be released and the hctx may be freed.

Thanks,
Ming

