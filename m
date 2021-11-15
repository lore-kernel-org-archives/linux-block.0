Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB3F8C433EF
	for <linux-block@archiver.kernel.org>; Tue, 16 Nov 2021 00:00:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF05A60EFE
	for <linux-block@archiver.kernel.org>; Tue, 16 Nov 2021 00:00:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352295AbhKPAC7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 15 Nov 2021 19:02:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36279 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349602AbhKPAA4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 Nov 2021 19:00:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637020679;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CZ6ST8gfY4AhMZaVMz/YtZ60V0sbQfEZa3icc8pIPSM=;
        b=UGWkFKm09icC+ovalHIJJ0/t4T8KQRgkusTncjzxDgxEif+Lfm6Sktq0XKfjpZrozTdU7R
        Nu8wPlCSoCDMSgWzPb0g8+dtlXQjNPqY+zx9bzLV2iGsgvkivXguGot+NEU+oDWOKqI6+M
        PoZERxknGVcl9dOepmc/h4a9t+yd3UQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-192-mE32Y7F1MIyLHrAtym41RA-1; Mon, 15 Nov 2021 18:57:58 -0500
X-MC-Unique: mE32Y7F1MIyLHrAtym41RA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7EC5D8799E0;
        Mon, 15 Nov 2021 23:57:57 +0000 (UTC)
Received: from T590 (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0BC691980E;
        Mon, 15 Nov 2021 23:57:51 +0000 (UTC)
Date:   Tue, 16 Nov 2021 07:57:46 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Stephen Smith <stephenmsmith@blueyonder.co.uk>
Subject: Re: [PATCH] block: fix missing queue put in error path
Message-ID: <YZLz+t+ZiSpkV31B@T590>
References: <f39193ff-bc6b-53fa-dc05-3127012d70c5@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f39193ff-bc6b-53fa-dc05-3127012d70c5@kernel.dk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Nov 15, 2021 at 02:35:09PM -0700, Jens Axboe wrote:
> If we fail the submission queue checks, we don't put the queue afterwards.
> This can cause various issues like stalls on scheduler switch or failure
> to remove the device, or like in the original bug report, timeout waiting
> for the device on reboot/restart.
> 
> While in there, fix a few whitespace discrepancies in the surrounding
> code.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=215039
> Fixes: b637108a4022 ("blk-mq: fix filesystem I/O request allocation")
> Reported-and-tested-by: Stephen Smith <stephenmsmith@blueyonder.co.uk>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
> ---
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 3ab34c4f20da..5e1c9fd99353 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2543,8 +2543,7 @@ static struct request *blk_mq_get_new_requests(struct request_queue *q,
>  	return NULL;
>  }
>  
> -static inline bool blk_mq_can_use_cached_rq(struct request *rq,
> -		struct bio *bio)
> +static inline bool blk_mq_can_use_cached_rq(struct request *rq, struct bio *bio)
>  {
>  	if (blk_mq_get_hctx_type(bio->bi_opf) != rq->mq_hctx->type)
>  		return false;
> @@ -2565,7 +2564,6 @@ static inline struct request *blk_mq_get_request(struct request_queue *q,
>  	bool checked = false;
>  
>  	if (plug) {
> -
>  		rq = rq_list_peek(&plug->cached_rq);
>  		if (rq && rq->q == q) {
>  			if (unlikely(!submit_bio_checks(bio)))
> @@ -2587,12 +2585,14 @@ static inline struct request *blk_mq_get_request(struct request_queue *q,
>  fallback:
>  	if (unlikely(bio_queue_enter(bio)))
>  		return NULL;
> -	if (!checked && !submit_bio_checks(bio))
> -		return NULL;
> +	if (unlikely(!checked && !submit_bio_checks(bio)))
> +		goto out_put;
>  	rq = blk_mq_get_new_requests(q, plug, bio, nsegs, same_queue_rq);
> -	if (!rq)
> -		blk_queue_exit(q);
> -	return rq;
> +	if (rq)
> +		return rq;
> +out_put:
> +	blk_queue_exit(q);
> +	return NULL;

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming

