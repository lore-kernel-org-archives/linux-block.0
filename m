Return-Path: <SRS0=EWxa=7Q=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 220FFC433DF
	for <linux-block@archiver.kernel.org>; Wed,  3 Jun 2020 07:36:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDE5B2074B
	for <linux-block@archiver.kernel.org>; Wed,  3 Jun 2020 07:36:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725867AbgFCHgS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Jun 2020 03:36:18 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:58596 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725275AbgFCHgS (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 3 Jun 2020 03:36:18 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 84F8D358CC9DE82D125C;
        Wed,  3 Jun 2020 15:36:13 +0800 (CST)
Received: from [127.0.0.1] (10.133.219.224) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Wed, 3 Jun 2020
 15:36:09 +0800
Subject: Re: [PATCH] block: account flush request in inflight sysfs files
From:   Hou Tao <houtao1@huawei.com>
To:     Jens Axboe <axboe@kernel.dk>, <linux-block@vger.kernel.org>
References: <20200526020139.21464-1-houtao1@huawei.com>
Message-ID: <43d81e4e-47be-64bd-5bc5-f0548fcdf2ca@huawei.com>
Date:   Wed, 3 Jun 2020 15:36:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20200526020139.21464-1-houtao1@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.219.224]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

ping ?

On 2020/5/26 10:01, Hou Tao wrote:
> So sysfs files which show the number of inflight IOs
> (e.g. /sys/block/xxx/inflight) will account the flush
> request. It's specially useful for debugging purpose
> when the completion of flush request is slow, but
> the containing request is fast.
> 
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
>  block/blk-flush.c |  1 +
>  block/blk-mq.c    | 12 ++++++++++--
>  2 files changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/block/blk-flush.c b/block/blk-flush.c
> index c7f396e3d5e2..14606f1e9273 100644
> --- a/block/blk-flush.c
> +++ b/block/blk-flush.c
> @@ -329,6 +329,7 @@ static void blk_kick_flush(struct request_queue *q, struct blk_flush_queue *fq,
>  	flush_rq->cmd_flags |= (flags & REQ_DRV) | (flags & REQ_FAILFAST_MASK);
>  	flush_rq->rq_flags |= RQF_FLUSH_SEQ;
>  	flush_rq->rq_disk = first_rq->rq_disk;
> +	flush_rq->part = first_rq->part;
>  	flush_rq->end_io = flush_end_io;
>  
>  	blk_flush_queue_rq(flush_rq, false);
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index a7785df2c944..1ed420a9a316 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -96,14 +96,22 @@ struct mq_inflight {
>  	unsigned int inflight[2];
>  };
>  
> +static inline int op_is_write_or_flush(unsigned int op)
> +{
> +	return op_is_write(op) || op == REQ_OP_FLUSH;
> +}
> +
>  static bool blk_mq_check_inflight(struct blk_mq_hw_ctx *hctx,
>  				  struct request *rq, void *priv,
>  				  bool reserved)
>  {
>  	struct mq_inflight *mi = priv;
>  
> -	if (rq->part == mi->part)
> -		mi->inflight[rq_data_dir(rq)]++;
> +	if (rq->part == mi->part) {
> +		int rw = op_is_write_or_flush(req_op(rq));
> +
> +		mi->inflight[rw]++;
> +	}
>  
>  	return true;
>  }
> 

