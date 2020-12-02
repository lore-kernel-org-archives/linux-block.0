Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0713C64E7C
	for <linux-block@archiver.kernel.org>; Wed,  2 Dec 2020 11:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9073C22203
	for <linux-block@archiver.kernel.org>; Wed,  2 Dec 2020 11:18:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388666AbgLBLSk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Dec 2020 06:18:40 -0500
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:56641 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388640AbgLBLSk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 2 Dec 2020 06:18:40 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UHJfFS0_1606907875;
Received: from admindeMacBook-Pro-2.local(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0UHJfFS0_1606907875)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 02 Dec 2020 19:17:55 +0800
Subject: Re: [PATCH v2] block: fix inflight statistics of part0
From:   JeffleXu <jefflexu@linux.alibaba.com>
To:     axboe@kernel.dk
Cc:     joseph.qi@linux.alibaba.com, hch@infradead.org,
        linux-block@vger.kernel.org
References: <20201202111145.36000-1-jefflexu@linux.alibaba.com>
Message-ID: <4317c6c9-886f-c921-70c1-ccc12ba6ae79@linux.alibaba.com>
Date:   Wed, 2 Dec 2020 19:17:55 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201202111145.36000-1-jefflexu@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 12/2/20 7:11 PM, Jeffle Xu wrote:
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
> While single queue device (on a previous version, e.g. v3.10) has no
> this issue:
> 
> $cat /sys/block/sda/sda3/inflight
>        0       33
> $cat /sys/block/sda/inflight
>        0       33
> 
> Partition 0 should be specially handled since it represents the whole
> disk. This issue is introduced since commit bf0ddaba65dd ("blk-mq: fix
> sysfs inflight counter").
> 
> Besides, this patch can also fix the inflight statistics of part 0 in
> /proc/diskstats. Before this patch, the inflight statistics of part 0
> doesn't include that of sub partitions. (I have marked the 'inflight'
> field with asterisk.)
> 
> $cat /proc/diskstats
>  259       0 nvme0n1 45974469 0 367814768 6445794 1 0 1 0 *0* 111062 6445794 0 0 0 0 0 0
>  259       2 nvme0n1p1 45974058 0 367797952 6445727 0 0 0 0 *33* 111001 6445727 0 0 0 0 0 0
> 
> This is introduced since commit f299b7c7a9de ("blk-mq: provide internal
> in-flight variant").
> 
> Fixes: bf0ddaba65dd ("blk-mq: fix sysfs inflight counter")
> Fixes: f299b7c7a9de ("blk-mq: provide internal in-flight variant")
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> ---
> v2: update the commit log, adding 'Fixes' tag

Forgot to add 'stable' tag.

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

-- 
Thanks,
Jeffle
