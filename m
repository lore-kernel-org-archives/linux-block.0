Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9784FC5519F
	for <linux-block@archiver.kernel.org>; Mon, 30 Nov 2020 06:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 379A92067D
	for <linux-block@archiver.kernel.org>; Mon, 30 Nov 2020 06:47:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725880AbgK3Gqw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 Nov 2020 01:46:52 -0500
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:37591 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725860AbgK3Gqw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Nov 2020 01:46:52 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R811e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0UGxEgXG_1606718768;
Received: from admindeMacBook-Pro-2.local(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0UGxEgXG_1606718768)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 30 Nov 2020 14:46:09 +0800
Subject: Re: [PATCH] block: fix inflight statistics of part0
From:   JeffleXu <jefflexu@linux.alibaba.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, joseph.qi@linux.alibaba.com
References: <20201126094833.61309-1-jefflexu@linux.alibaba.com>
Message-ID: <3d5f8d86-469f-0bb5-d055-6a79c63d0734@linux.alibaba.com>
Date:   Mon, 30 Nov 2020 14:46:08 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201126094833.61309-1-jefflexu@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello, any comment? Is this indeed a BUG or just a deliberate design?

-- 
Thanks,
Jeffle


On 11/26/20 5:48 PM, Jeffle Xu wrote:
> The inflight of partition 0 doesn't include inflight IOs to all
> sub-partitions, since currently mq calculates inflight of specific
> partition by simply camparing the value of the partition pointer.
> 
> Thus the following case is possible:
> 
> $ cat /sys/block/vda/inflight
>        0        0
> $ cat /sys/block/vda/vda1/inflight
>        0      128
> 
> Partition 0 should be specially handled since it represents the whole
> disk.
> 
> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> ---
>  block/blk-mq.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 55bcee5dc032..04b6b4d21ce6 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -105,7 +105,8 @@ static bool blk_mq_check_inflight(struct blk_mq_hw_ctx *hctx,
>  {
>  	struct mq_inflight *mi = priv;
>  
> -	if (rq->part == mi->part && blk_mq_rq_state(rq) == MQ_RQ_IN_FLIGHT)
> +	if ((!mi->part->partno || rq->part == mi->part) &&
> +	    blk_mq_rq_state(rq) == MQ_RQ_IN_FLIGHT)
>  		mi->inflight[rq_data_dir(rq)]++;
>  
>  	return true;
> 

