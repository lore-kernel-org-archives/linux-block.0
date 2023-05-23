Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D84DEC7EE23
	for <linux-block@archiver.kernel.org>; Tue, 23 May 2023 07:20:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235478AbjEWHU5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 May 2023 03:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235517AbjEWHU0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 May 2023 03:20:26 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1095DE41
        for <linux-block@vger.kernel.org>; Tue, 23 May 2023 00:20:00 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7754B67373; Tue, 23 May 2023 09:19:57 +0200 (CEST)
Date:   Tue, 23 May 2023 09:19:57 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Mike Snitzer <snitzer@kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH v3 4/7] block: Make it easier to debug zoned write
 reordering
Message-ID: <20230523071957.GD8758@lst.de>
References: <20230522183845.354920-1-bvanassche@acm.org> <20230522183845.354920-5-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522183845.354920-5-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, May 22, 2023 at 11:38:39AM -0700, Bart Van Assche wrote:
> @@ -2429,6 +2429,9 @@ static void blk_mq_request_bypass_insert(struct request *rq, blk_insert_t flags)
>  {
>  	struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
>  
> +	WARN_ON_ONCE(rq->rq_flags & RQF_USE_SCHED &&
> +		     blk_rq_is_seq_zoned_write(rq));
> +
>  	spin_lock(&hctx->lock);
>  	if (flags & BLK_MQ_INSERT_AT_HEAD)
>  		list_add(&rq->queuelist, &hctx->dispatch);
> @@ -2562,6 +2565,9 @@ static blk_status_t __blk_mq_issue_directly(struct blk_mq_hw_ctx *hctx,
>  	};
>  	blk_status_t ret;
>  
> +	WARN_ON_ONCE(rq->rq_flags & RQF_USE_SCHED &&
> +		     blk_rq_is_seq_zoned_write(rq));

What makes sequential writes here special vs other requests that are
supposed to be using the scheduler and not a bypass?
