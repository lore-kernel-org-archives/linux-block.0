Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB80BECAAA2
	for <linux-block@archiver.kernel.org>; Fri, 26 Aug 2022 03:15:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244922AbiHZDPb convert rfc822-to-8bit (ORCPT
        <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Aug 2022 23:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236923AbiHZDPa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Aug 2022 23:15:30 -0400
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6856EB4EB6
        for <linux-block@vger.kernel.org>; Thu, 25 Aug 2022 20:15:29 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R511e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=gumi@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VNHIWB9_1661483725;
Received: from LR9115VM81021(mailfrom:gumi@linux.alibaba.com fp:SMTPD_---0VNHIWB9_1661483725)
          by smtp.aliyun-inc.com;
          Fri, 26 Aug 2022 11:15:26 +0800
From:   <gumi@linux.alibaba.com>
To:     "'Damien Le Moal'" <damien.lemoal@opensource.wdc.com>,
        <axboe@kernel.dk>
Cc:     <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block: I/O error occurs during SATA disk stress test
Date:   Fri, 26 Aug 2022 11:15:25 +0800
Message-ID: <000701d8b8fa$16d85240$4488f6c0$@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: zh-cn
Thread-Index: Adi4+cLsMsMwgnI4QgWL/iksoeR/mQ==
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2022/08/24 4:36, Gu Mi wrote:
> The problem occurs in two async processes, One is when a new IO calls 
> the blk_mq_start_request() interface to start sending,The other is 
> that the block layer timer process calls the blk_mq_req_expired 
> interface to check whether there is an IO timeout.
> 
> When an instruction out of sequence occurs between blk_add_timer and 
> WRITE_ONCE(rq->state,MQ_RQ_IN_FLIGHT) in the interface 
> blk_mq_start_request,at this time, the block timer is checking the new 
> IO timeout, Since the req status has been set to MQ_RQ_IN_FLIGHT and 
> req->deadline is 0 at this time, the new IO will be misjudged as a 
> timeout.
> 
> Our repair plan is for the deadline to be 0, and we do not think that 
> a timeout occurs. At the same time, because the jiffies of the 32-bit 
> system will be reversed shortly after the system is turned on, we will 
> add 1 jiffies to the deadline at this time.
> 
> Signed-off-by: Gu Mi <gumi@linux.alibaba.com>
> ---
>  block/blk-mq.c      | 2 ++
>  block/blk-timeout.c | 4 ++++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c index 4b90d2d..6defaa1 
> 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1451,6 +1451,8 @@ static bool blk_mq_req_expired(struct request *rq, unsigned long *next)
>  		return false;
>  
>  	deadline = READ_ONCE(rq->deadline);
> +	if (unlikely(deadline == 0))
> +		return false;
>  	if (time_after_eq(jiffies, deadline))

Use time_after() instead of time_after_eq() ? Then the above change would not be needed.

>  		return true;
>  
> diff --git a/block/blk-timeout.c b/block/blk-timeout.c index 
> 1b8de041..6fc5088 100644
> --- a/block/blk-timeout.c
> +++ b/block/blk-timeout.c
> @@ -140,6 +140,10 @@ void blk_add_timer(struct request *req)
>  	req->rq_flags &= ~RQF_TIMED_OUT;
>  
>  	expiry = jiffies + req->timeout;
> +#ifndef CONFIG_64BIT
> +/* In case INITIAL_JIFFIES wraps on 32-bit */
> +	expiry |= 1UL;
> +#endif

time_after() and friends should handle the overflow. Why is this change needed ?

>  	WRITE_ONCE(req->deadline, expiry);
>  
>  	/*


--
Damien Le Moal
Western Digital Research


--
Sorry, my reply yesterday was wrong, please allow me to explain again，

> +#ifndef CONFIG_64BIT
> +/* In case INITIAL_JIFFIES wraps on 32-bit */
> +	expiry |= 1UL;

The purpose of this modification is not to handle overflow, but to distinguish it from the req->deadline initialization value of 0.
And guaranteeing that req->deadline is 0 means that it is initialized to 0 in blk_mq_req_expired().

