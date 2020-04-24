Return-Path: <SRS0=nYW3=6I=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4981C54FCB
	for <linux-block@archiver.kernel.org>; Fri, 24 Apr 2020 12:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98DF220706
	for <linux-block@archiver.kernel.org>; Fri, 24 Apr 2020 12:44:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726849AbgDXMoL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 Apr 2020 08:44:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:56942 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726667AbgDXMoL (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Apr 2020 08:44:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 69CD5AD0F;
        Fri, 24 Apr 2020 12:44:08 +0000 (UTC)
Subject: Re: [PATCH V8 03/11] blk-mq: mark blk_mq_get_driver_tag as static
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Garry <john.garry@huawei.com>
References: <20200424102351.475641-1-ming.lei@redhat.com>
 <20200424102351.475641-4-ming.lei@redhat.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <b6105b58-39e2-8915-26a6-36b0a3d191cd@suse.de>
Date:   Fri, 24 Apr 2020 14:44:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200424102351.475641-4-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/24/20 12:23 PM, Ming Lei wrote:
> Now all callers of blk_mq_get_driver_tag are in blk-mq.c, so mark
> it as static.
> 
> Cc: Bart Van Assche <bvanassche@acm.org>
> Cc: Hannes Reinecke <hare@suse.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: John Garry <john.garry@huawei.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   block/blk-mq.c | 2 +-
>   block/blk-mq.h | 1 -
>   2 files changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index a7785df2c944..79267f2e8960 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1027,7 +1027,7 @@ static inline unsigned int queued_to_index(unsigned int queued)
>   	return min(BLK_MQ_MAX_DISPATCH_ORDER - 1, ilog2(queued) + 1);
>   }
>   
> -bool blk_mq_get_driver_tag(struct request *rq)
> +static bool blk_mq_get_driver_tag(struct request *rq)
>   {
>   	struct blk_mq_alloc_data data = {
>   		.q = rq->q,
> diff --git a/block/blk-mq.h b/block/blk-mq.h
> index 10bfdfb494fa..e7d1da4b1f73 100644
> --- a/block/blk-mq.h
> +++ b/block/blk-mq.h
> @@ -44,7 +44,6 @@ bool blk_mq_dispatch_rq_list(struct request_queue *, struct list_head *, bool);
>   void blk_mq_add_to_requeue_list(struct request *rq, bool at_head,
>   				bool kick_requeue_list);
>   void blk_mq_flush_busy_ctxs(struct blk_mq_hw_ctx *hctx, struct list_head *list);
> -bool blk_mq_get_driver_tag(struct request *rq);
>   struct request *blk_mq_dequeue_from_ctx(struct blk_mq_hw_ctx *hctx,
>   					struct blk_mq_ctx *start);
>   
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare@suse.de                               +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
