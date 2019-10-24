Return-Path: <SRS0=pYcy=YR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9E19CA9EAF
	for <linux-block@archiver.kernel.org>; Thu, 24 Oct 2019 19:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A60C52070B
	for <linux-block@archiver.kernel.org>; Thu, 24 Oct 2019 19:59:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbfJXT7D (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Oct 2019 15:59:03 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56392 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbfJXT7D (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Oct 2019 15:59:03 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id A8E9926D7C1
Subject: Re: [PATCH 1/2] blk-mq: respect io scheduler
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Dave Chinner <dchinner@redhat.com>
References: <20190927072431.23901-1-ming.lei@redhat.com>
 <20190927072431.23901-2-ming.lei@redhat.com>
From:   =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>
Message-ID: <626beb0f-36fa-6f94-b01b-f5a02fec6b53@collabora.com>
Date:   Thu, 24 Oct 2019 16:57:36 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20190927072431.23901-2-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello Ming Lei,

On 9/27/19 4:24 AM, Ming Lei wrote:
> Now in case of real MQ, io scheduler may be bypassed, and not only this
> way may hurt performance for some slow MQ device, but also break zoned
> device which depends on mq-deadline for respecting the write order in
> one zone.
> 
> So don't bypass io scheduler if we have one setup.
> 
> This patch can double sequential write performance basically on MQ
> scsi_debug when mq-deadline is applied.
> 
> Cc: Bart Van Assche <bvanassche@acm.org>
> Cc: Hannes Reinecke <hare@suse.com>
> Cc: Damien Le Moal <damien.lemoal@wdc.com>
> Cc: Dave Chinner <dchinner@redhat.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  block/blk-mq.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 20a49be536b5..d7aed6518e62 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2003,6 +2003,8 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
>  		}
>  
>  		blk_add_rq_to_plug(plug, rq);
> +	} else if (q->elevator) {
> +		blk_mq_sched_insert_request(rq, false, true, true);
>  	} else if (plug && !blk_queue_nomerges(q)) {
>  		/*
>  		 * We do limited plugging. If the bio can be merged, do that.
> @@ -2026,8 +2028,8 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
>  			blk_mq_try_issue_directly(data.hctx, same_queue_rq,
>  					&cookie);
>  		}
> -	} else if ((q->nr_hw_queues > 1 && is_sync) || (!q->elevator &&
> -			!data.hctx->dispatch_busy)) {
> +	} else if ((q->nr_hw_queues > 1 && is_sync) ||
> +			!data.hctx->dispatch_busy) {
>  		blk_mq_try_issue_directly(data.hctx, rq, &cookie);
>  	} else {
>  		blk_mq_sched_insert_request(rq, false, true, true);
> 

This patch introduces identical branches, both "else if (q->elevator)"
and "else" do the same thing. Wouldn't be enough to just remove the
condition "!q->elevator" without adding a new if?

Thanks,
	André
