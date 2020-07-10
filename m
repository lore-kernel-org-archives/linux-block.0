Return-Path: <SRS0=lEwc=AV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B663C433E0
	for <linux-block@archiver.kernel.org>; Fri, 10 Jul 2020 08:22:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 318AE206A5
	for <linux-block@archiver.kernel.org>; Fri, 10 Jul 2020 08:22:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbgGJIWO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 10 Jul 2020 04:22:14 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:34650 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726004AbgGJIWO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 10 Jul 2020 04:22:14 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R411e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01355;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0U2HJQxG_1594369331;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0U2HJQxG_1594369331)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 10 Jul 2020 16:22:11 +0800
Date:   Fri, 10 Jul 2020 16:22:10 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     axboe@kernel.dk
Cc:     ming.lei@redhat.com, baolin.wang7@gmail.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] blk-mq: Remove unnecessary local variable
Message-ID: <20200710082210.GA29262@VM20190228-100.tbsite.net>
Reply-To: Baolin Wang <baolin.wang@linux.alibaba.com>
References: <37baa5f3d47675b782652c85acf303662368e99f.1593846844.git.baolin.wang7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37baa5f3d47675b782652c85acf303662368e99f.1593846844.git.baolin.wang7@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

On Sat, Jul 04, 2020 at 03:26:14PM +0800, Baolin Wang wrote:
> Remove unnecessary local variable 'ret' in blk_mq_dispatch_hctx_list().
>

A gentle ping?

> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>  block/blk-mq-sched.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
> index 1c52e56a19b1..b8db72cf1043 100644
> --- a/block/blk-mq-sched.c
> +++ b/block/blk-mq-sched.c
> @@ -96,7 +96,6 @@ static bool blk_mq_dispatch_hctx_list(struct list_head *rq_list)
>  	struct request *rq;
>  	LIST_HEAD(hctx_list);
>  	unsigned int count = 0;
> -	bool ret;
>  
>  	list_for_each_entry(rq, rq_list, queuelist) {
>  		if (rq->mq_hctx != hctx) {
> @@ -108,8 +107,7 @@ static bool blk_mq_dispatch_hctx_list(struct list_head *rq_list)
>  	list_splice_tail_init(rq_list, &hctx_list);
>  
>  dispatch:
> -	ret = blk_mq_dispatch_rq_list(hctx, &hctx_list, count);
> -	return ret;
> +	return blk_mq_dispatch_rq_list(hctx, &hctx_list, count);
>  }
>  
>  #define BLK_MQ_BUDGET_DELAY	3		/* ms units */
> -- 
> 2.17.1
