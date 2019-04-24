Return-Path: <SRS0=lHMQ=S2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F381EC10F11
	for <linux-block@archiver.kernel.org>; Wed, 24 Apr 2019 16:22:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C983E208E4
	for <linux-block@archiver.kernel.org>; Wed, 24 Apr 2019 16:22:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731178AbfDXQWk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Apr 2019 12:22:40 -0400
Received: from verein.lst.de ([213.95.11.211]:55074 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727393AbfDXQWj (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Apr 2019 12:22:39 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 5B0E367358; Wed, 24 Apr 2019 18:22:23 +0200 (CEST)
Date:   Wed, 24 Apr 2019 18:22:23 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Hannes Reinecke <hare@suse.com>,
        Keith Busch <keith.busch@intel.com>,
        linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>,
        Dongli Zhang <dongli.zhang@oracle.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Subject: Re: [PATCH V7 4/9] blk-mq: move all hctx alloction &
 initialization into __blk_mq_alloc_and_init_hctx
Message-ID: <20190424162223.GD23854@lst.de>
References: <20190424110221.17435-1-ming.lei@redhat.com> <20190424110221.17435-5-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190424110221.17435-5-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Apr 24, 2019 at 07:02:16PM +0800, Ming Lei wrote:
> Move all hctx related allocation and initialization into
> __blk_mq_alloc_and_init_hctx, and prepare for splitting blk_mq_alloc_and_init_hctx
> into real two functions, one is for allocate everything, and another is for
> initializing everyting.
> 
> Cc: Dongli Zhang <dongli.zhang@oracle.com>
> Cc: James Smart <james.smart@broadcom.com>
> Cc: Bart Van Assche <bart.vanassche@wdc.com>
> Cc: linux-scsi@vger.kernel.org,
> Cc: Martin K . Petersen <martin.petersen@oracle.com>,
> Cc: Christoph Hellwig <hch@lst.de>,
> Cc: James E . J . Bottomley <jejb@linux.vnet.ibm.com>,
> Reviewed-by: Hannes Reinecke <hare@suse.com>
> Tested-by: James Smart <james.smart@broadcom.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  block/blk-mq.c | 93 +++++++++++++++++++++++++++-------------------------------
>  1 file changed, 44 insertions(+), 49 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 862eb41f24f8..fea25363488d 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2290,15 +2290,45 @@ static void blk_mq_exit_hw_queues(struct request_queue *q,
>  	}
>  }
>  
> -static int blk_mq_init_hctx(struct request_queue *q,
> -		struct blk_mq_tag_set *set,
> -		struct blk_mq_hw_ctx *hctx, unsigned hctx_idx)
> +static int blk_mq_hw_ctx_size(struct blk_mq_tag_set *tag_set)
>  {
> -	int node;
> +	int hw_ctx_size = sizeof(struct blk_mq_hw_ctx);
> +
> +	BUILD_BUG_ON(ALIGN(offsetof(struct blk_mq_hw_ctx, srcu),
> +			   __alignof__(struct blk_mq_hw_ctx)) !=
> +		     sizeof(struct blk_mq_hw_ctx));
> +
> +	if (tag_set->flags & BLK_MQ_F_BLOCKING)
> +		hw_ctx_size += sizeof(struct srcu_struct);
> +
> +	return hw_ctx_size;
> +}
> +
> +static struct blk_mq_hw_ctx *
> +__blk_mq_alloc_and_init_hctx(struct request_queue *q,
> +			     struct blk_mq_tag_set *set,
> +			     unsigned hctx_idx, int node)
> +{
> +	struct blk_mq_hw_ctx *hctx;
> +
> +	hctx = kzalloc_node(blk_mq_hw_ctx_size(set),
> +			GFP_NOIO | __GFP_NOWARN | __GFP_NORETRY,
> +			node);
> +	if (!hctx)
> +		goto fail_alloc_hctx;
> +
> +	if (!zalloc_cpumask_var_node(&hctx->cpumask,
> +				GFP_NOIO | __GFP_NOWARN | __GFP_NORETRY,

Maybe throw in a

	const gfp_t gfp = GFP_NOIO | __GFP_NOWARN | __GFP_NORETRY;

as the first line to shorten these two a bit..

>  static struct blk_mq_hw_ctx *blk_mq_alloc_and_init_hctx(
>  		struct blk_mq_tag_set *set, struct request_queue *q,
>  		int hctx_idx, int node)
>  {
> +	return __blk_mq_alloc_and_init_hctx(q, set, hctx_idx, node);
>  }

I really don't the point of this wrapper.  If we need it later
we should introduce it there.
