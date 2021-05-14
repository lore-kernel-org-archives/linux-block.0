Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 369E9C433B4
	for <linux-block@archiver.kernel.org>; Fri, 14 May 2021 00:56:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0087E61175
	for <linux-block@archiver.kernel.org>; Fri, 14 May 2021 00:56:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231799AbhENA5T (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 May 2021 20:57:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31338 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230305AbhENA5T (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 May 2021 20:57:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620953768;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Z+NGT/XiZFt8URJ5ME7n+FHpFG+LPcTCZIcJxDXp8wM=;
        b=BxAtmPETRvsO5mEPVqwzNRHTMT7ULjIbpTgwqAORHccBaQ2UX2pHSEqw4w9i77IloHN06D
        eMXXAiwPu+zh0hVhY1xKnzwulGiTsZ33FurIGeNHs/3L3bDmf1AM6EgSb1fCap1URxFaqw
        hlAhSadQI90Ggmj7F/lFf8wKIDpJhQc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-594-UjEd4xMPPtaFW2MesTAzzQ-1; Thu, 13 May 2021 20:56:04 -0400
X-MC-Unique: UjEd4xMPPtaFW2MesTAzzQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A182FFC91;
        Fri, 14 May 2021 00:56:03 +0000 (UTC)
Received: from T590 (ovpn-12-87.pek2.redhat.com [10.72.12.87])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6EE0B687E2;
        Fri, 14 May 2021 00:55:56 +0000 (UTC)
Date:   Fri, 14 May 2021 08:55:51 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Christoph Hellwig <hch@infradead.org>,
        Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH] blk-mq: Swap two calls in blk_mq_exit_queue()
Message-ID: <YJ3Kl37kPJo650mv@T590>
References: <20210513171529.7977-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210513171529.7977-1-bvanassche@acm.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, May 13, 2021 at 10:15:29AM -0700, Bart Van Assche wrote:
> If a tag set is shared across request queues (e.g. SCSI LUNs) then the
> block layer core keeps track of the number of active request queues in
> tags->active_queues. blk_mq_tag_busy() and blk_mq_tag_idle() update that
> atomic counter if the hctx flag BLK_MQ_F_TAG_QUEUE_SHARED is set. Make
> sure that blk_mq_exit_queue() calls blk_mq_tag_idle() before that flag is
> cleared by blk_mq_del_queue_tag_set().
> 
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Hannes Reinecke <hare@suse.com>
> Fixes: 0d2602ca30e4 ("blk-mq: improve support for shared tags maps")
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  block/blk-mq.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 1ea012de60eb..96b8e3164835 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -3289,10 +3289,12 @@ EXPORT_SYMBOL(blk_mq_init_allocated_queue);
>  /* tags can _not_ be used after returning from blk_mq_exit_queue */
>  void blk_mq_exit_queue(struct request_queue *q)
>  {
> -	struct blk_mq_tag_set	*set = q->tag_set;
> +	struct blk_mq_tag_set *set = q->tag_set;
>  
> -	blk_mq_del_queue_tag_set(q);
> +	/* Checks hctx->flags & BLK_MQ_F_TAG_QUEUE_SHARED. */
>  	blk_mq_exit_hw_queues(q, set, set->nr_hw_queues);
> +	/* May clear BLK_MQ_F_TAG_QUEUE_SHARED in hctx->flags. */
> +	blk_mq_del_queue_tag_set(q);
>  }
>  
>  static int __blk_mq_alloc_rq_maps(struct blk_mq_tag_set *set)
> 

Looks fine:

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming

