Return-Path: <SRS0=xbel=O2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84B88C43387
	for <linux-block@archiver.kernel.org>; Mon, 17 Dec 2018 11:24:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FCE02133F
	for <linux-block@archiver.kernel.org>; Mon, 17 Dec 2018 11:24:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731961AbeLQLYQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Dec 2018 06:24:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57828 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727418AbeLQLYJ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Dec 2018 06:24:09 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6421681F11;
        Mon, 17 Dec 2018 11:24:09 +0000 (UTC)
Received: from ming.t460p (ovpn-8-31.pek2.redhat.com [10.72.8.31])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7B4B518682;
        Mon, 17 Dec 2018 11:24:03 +0000 (UTC)
Date:   Mon, 17 Dec 2018 19:23:58 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/2] blk-mq: only dispatch to non-defauly queue maps if
 they have queues
Message-ID: <20181217112357.GE1329@ming.t460p>
References: <20181217111627.22635-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181217111627.22635-1-hch@lst.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Mon, 17 Dec 2018 11:24:09 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Dec 17, 2018 at 12:16:26PM +0100, Christoph Hellwig wrote:
> We should check if a given queue map actually has queues enabled before
> dispatching to it.  This allows drivers to not initialize optional but
> not used map types, which subsequently will allow fixing problems with
> queue map rebuilds for that case.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/blk-mq.h | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/block/blk-mq.h b/block/blk-mq.h
> index b63a0de8a07a..d1ed096723fb 100644
> --- a/block/blk-mq.h
> +++ b/block/blk-mq.h
> @@ -105,14 +105,17 @@ static inline struct blk_mq_hw_ctx *blk_mq_map_queue(struct request_queue *q,
>  {
>  	enum hctx_type type = HCTX_TYPE_DEFAULT;
>  
> -	if (q->tag_set->nr_maps > HCTX_TYPE_POLL &&
> -	    ((flags & REQ_HIPRI) && test_bit(QUEUE_FLAG_POLL, &q->queue_flags)))
> +	if ((flags & REQ_HIPRI) &&
> +	    q->tag_set->nr_maps > HCTX_TYPE_POLL && 
> +	    q->tag_set->map[HCTX_TYPE_POLL].nr_queues &&
> +	    test_bit(QUEUE_FLAG_POLL, &q->queue_flags))
>  		type = HCTX_TYPE_POLL;
>  
> -	else if (q->tag_set->nr_maps > HCTX_TYPE_READ &&
> -		 ((flags & REQ_OP_MASK) == REQ_OP_READ))
> +	else if (((flags & REQ_OP_MASK) == REQ_OP_READ) &&
> +	         q->tag_set->nr_maps > HCTX_TYPE_READ &&
> +		 q->tag_set->map[HCTX_TYPE_READ].nr_queues)
>  		type = HCTX_TYPE_READ;
> -
> +	
>  	return blk_mq_map_queue_type(q, type, cpu);
>  }

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming
