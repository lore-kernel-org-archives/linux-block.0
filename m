Return-Path: <SRS0=3NZC=WI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5F69C31E40
	for <linux-block@archiver.kernel.org>; Mon, 12 Aug 2019 08:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE7162070C
	for <linux-block@archiver.kernel.org>; Mon, 12 Aug 2019 08:53:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbfHLIxS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 12 Aug 2019 04:53:18 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:51430 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726495AbfHLIxR (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Aug 2019 04:53:17 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 90514F5FCA48DD1BC675;
        Mon, 12 Aug 2019 16:53:14 +0800 (CST)
Received: from [127.0.0.1] (10.184.213.217) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.439.0; Mon, 12 Aug 2019
 16:53:06 +0800
Subject: Re: [PATCH] blk-mq: Fix memory leak in blk_mq_init_allocated_queue
 error handling
To:     <axboe@kernel.dk>, <ming.lei@redhat.com>,
        <linux-block@vger.kernel.org>
CC:     <yi.zhang@huawei.com>, <bvanassche@acm.org>
References: <1563891042-25448-1-git-send-email-zhengbin13@huawei.com>
From:   "zhengbin (A)" <zhengbin13@huawei.com>
Message-ID: <52cb9a64-b67f-114e-ddc2-338d8d201f40@huawei.com>
Date:   Mon, 12 Aug 2019 16:53:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <1563891042-25448-1-git-send-email-zhengbin13@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.184.213.217]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

ping

On 2019/7/23 22:10, zhengbin wrote:
> If blk_mq_init_allocated_queue->elevator_init_mq fails, need to release
> the previously requested resources.
>
> Fixes: d34849913 ("blk-mq-sched: allow setting of default IO scheduler")
> Signed-off-by: zhengbin <zhengbin13@huawei.com>
> ---
>  block/blk-mq.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index b038ec6..e001610 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2845,6 +2845,8 @@ static unsigned int nr_hw_queues(struct blk_mq_tag_set *set)
>  struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
>  						  struct request_queue *q)
>  {
> +	int ret = -ENOMEM;
> +
>  	/* mark the queue as mq asap */
>  	q->mq_ops = set->ops;
>
> @@ -2906,17 +2908,18 @@ struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
>  	blk_mq_map_swqueue(q);
>
>  	if (!(set->flags & BLK_MQ_F_NO_SCHED)) {
> -		int ret;
> -
>  		ret = elevator_init_mq(q);
>  		if (ret)
> -			return ERR_PTR(ret);
> +			goto err_tag_set;
>  	}
>
>  	return q;
>
> +err_tag_set:
> +	blk_mq_del_queue_tag_set(q);
>  err_hctxs:
>  	kfree(q->queue_hw_ctx);
> +	q->nr_hw_queues = 0;
>  err_sys_init:
>  	blk_mq_sysfs_deinit(q);
>  err_poll:
> --
> 2.7.4
>
>
> .
>

