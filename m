Return-Path: <SRS0=3NZC=WI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2E2DC31E40
	for <linux-block@archiver.kernel.org>; Mon, 12 Aug 2019 13:00:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB46820679
	for <linux-block@archiver.kernel.org>; Mon, 12 Aug 2019 13:00:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728782AbfHLNAo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 12 Aug 2019 09:00:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33210 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728738AbfHLNAn (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Aug 2019 09:00:43 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 847AE3092775;
        Mon, 12 Aug 2019 13:00:43 +0000 (UTC)
Received: from ming.t460p (ovpn-8-23.pek2.redhat.com [10.72.8.23])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D958580231;
        Mon, 12 Aug 2019 13:00:27 +0000 (UTC)
Date:   Mon, 12 Aug 2019 21:00:20 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     zhengbin <zhengbin13@huawei.com>
Cc:     axboe@kernel.dk, bvanassche@acm.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-block@vger.kernel.org,
        houtao1@huawei.com
Subject: Re: [PATCH] blk-mq: move cancel of requeue_work to the front of
 blk_exit_queue
Message-ID: <20190812130018.GA29359@ming.t460p>
References: <1565613415-24807-1-git-send-email-zhengbin13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1565613415-24807-1-git-send-email-zhengbin13@huawei.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Mon, 12 Aug 2019 13:00:43 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Aug 12, 2019 at 08:36:55PM +0800, zhengbin wrote:
> blk_exit_queue will free elevator_data, while blk_mq_requeue_work
> will access it. Move cancel of requeue_work to the front of
> blk_exit_queue to avoid use-after-free.
> 
> blk_exit_queue                blk_mq_requeue_work
>   __elevator_exit               blk_mq_run_hw_queues
>     blk_mq_exit_sched             blk_mq_run_hw_queue
>       dd_exit_queue                 blk_mq_hctx_has_pending
>         kfree(elevator_data)          blk_mq_sched_has_work
>                                         dd_has_work
> 
> Fixes: fbc2a15e3433 ("blk-mq: move cancel of requeue_work into blk_mq_release")
> Signed-off-by: zhengbin <zhengbin13@huawei.com>
> ---
>  block/blk-mq.c    | 2 --
>  block/blk-sysfs.c | 3 +++
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index f78d328..a8e6a58 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2666,8 +2666,6 @@ void blk_mq_release(struct request_queue *q)
>  	struct blk_mq_hw_ctx *hctx, *next;
>  	int i;
> 
> -	cancel_delayed_work_sync(&q->requeue_work);
> -
>  	queue_for_each_hw_ctx(q, hctx, i)
>  		WARN_ON_ONCE(hctx && list_empty(&hctx->hctx_list));
> 
> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> index 977c659..9bfa3ea 100644
> --- a/block/blk-sysfs.c
> +++ b/block/blk-sysfs.c
> @@ -892,6 +892,9 @@ static void __blk_release_queue(struct work_struct *work)
> 
>  	blk_free_queue_stats(q->stats);
> 
> +	if (queue_is_mq(q))
> +		cancel_delayed_work_sync(&q->requeue_work);
> +
>  	blk_exit_queue(q);
> 
>  	blk_queue_free_zone_bitmaps(q);

Looks fine:

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming
