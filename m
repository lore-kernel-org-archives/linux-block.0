Return-Path: <SRS0=xbel=O2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 346EFC43387
	for <linux-block@archiver.kernel.org>; Mon, 17 Dec 2018 08:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CDAB217F4
	for <linux-block@archiver.kernel.org>; Mon, 17 Dec 2018 08:38:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbeLQIiV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Dec 2018 03:38:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37894 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726706AbeLQIiV (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Dec 2018 03:38:21 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BADD880F79;
        Mon, 17 Dec 2018 08:38:20 +0000 (UTC)
Received: from ming.t460p (ovpn-8-31.pek2.redhat.com [10.72.8.31])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2A7C35D70A;
        Mon, 17 Dec 2018 08:38:10 +0000 (UTC)
Date:   Mon, 17 Dec 2018 16:38:06 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Mike Snitzer <snitzer@redhat.com>,
        linux-block@vger.kernel.org, Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [PATCH 3/4] blk-mq: deal with shared queue mapping reliably
Message-ID: <20181217083804.GB1329@ming.t460p>
References: <20181216022517.26650-1-ming.lei@redhat.com>
 <20181216022517.26650-4-ming.lei@redhat.com>
 <20181216161650.GD9957@lst.de>
 <20181216183937.GA25476@redhat.com>
 <c410c10e-f992-5a67-0dce-1ba6bc428de5@kernel.dk>
 <20181217010407.GB1223@ming.t460p>
 <20181217074442.GA2273@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181217074442.GA2273@lst.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Mon, 17 Dec 2018 08:38:20 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Dec 17, 2018 at 08:44:42AM +0100, Christoph Hellwig wrote:
> I suspect we want something like this to make sure we never look
> at queue maps that don't have nr_queues set, and then just don't
> have to initialize them in nvme:
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


>  
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index fb9d8270f32c..698b350b38cf 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -496,11 +496,7 @@ static int nvme_pci_map_queues(struct blk_mq_tag_set *set)
>  		map->nr_queues = dev->io_queues[i];
>  		if (!map->nr_queues) {
>  			BUG_ON(i == HCTX_TYPE_DEFAULT);
> -
> -			/* shared set, resuse read set parameters */
> -			map->nr_queues = dev->io_queues[HCTX_TYPE_DEFAULT];
> -			qoff = 0;
> -			offset = queue_irq_offset(dev);
> +			continue;
>  		}
>  
>  		/*

This way works just with a bit cost in blk_mq_map_queue(), given
we have cached hctx in rq->mq_hctx, I think this approach is good.


Thanks,
Ming
