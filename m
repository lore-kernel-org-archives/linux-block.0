Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D3C3C433FE
	for <linux-block@archiver.kernel.org>; Thu, 10 Dec 2020 04:09:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6603A23A02
	for <linux-block@archiver.kernel.org>; Thu, 10 Dec 2020 04:09:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730557AbgLJEJw convert rfc822-to-8bit (ORCPT
        <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Dec 2020 23:09:52 -0500
Received: from smtp.h3c.com ([60.191.123.56]:18606 "EHLO h3cspam01-ex.h3c.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730328AbgLJEJw (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 9 Dec 2020 23:09:52 -0500
Received: from DAG2EX01-BASE.srv.huawei-3com.com ([10.8.0.64])
        by h3cspam01-ex.h3c.com with ESMTP id 0BA48DCZ034913;
        Thu, 10 Dec 2020 12:08:13 +0800 (GMT-8)
        (envelope-from tian.xianting@h3c.com)
Received: from DAG2EX03-BASE.srv.huawei-3com.com (10.8.0.66) by
 DAG2EX01-BASE.srv.huawei-3com.com (10.8.0.64) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 10 Dec 2020 12:08:15 +0800
Received: from DAG2EX03-BASE.srv.huawei-3com.com ([fe80::5d18:e01c:bbbd:c074])
 by DAG2EX03-BASE.srv.huawei-3com.com ([fe80::5d18:e01c:bbbd:c074%7]) with
 mapi id 15.01.2106.002; Thu, 10 Dec 2020 12:08:15 +0800
From:   Tianxianting <tian.xianting@h3c.com>
To:     Ming Lei <ming.lei@redhat.com>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] blk-mq-tag: make blk_mq_tag_busy() return void
Thread-Topic: [PATCH] blk-mq-tag: make blk_mq_tag_busy() return void
Thread-Index: AQHWzTbPLVQryLH5fkSeJ0U/VBp/EKnvMY+AgACHgrA=
Date:   Thu, 10 Dec 2020 04:08:14 +0000
Message-ID: <c067fbee320e4810ae599cde9680a366@h3c.com>
References: <20201208074002.31539-1-tian.xianting@h3c.com>
 <20201210040051.GA1377508@T590>
In-Reply-To: <20201210040051.GA1377508@T590>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.99.141.128]
x-sender-location: DAG2
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-DNSRBL: 
X-MAIL: h3cspam01-ex.h3c.com 0BA48DCZ034913
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Thanks for the comments,
So blk_mq_tag_idle() can be also simplified as below,  I will send v2 patch for reviewing.

static inline void blk_mq_tag_idle(struct blk_mq_hw_ctx *hctx)
 {
-       if (!(hctx->flags & BLK_MQ_F_TAG_QUEUE_SHARED))
-               return;
-
-       __blk_mq_tag_idle(hctx);
+       if (hctx->flags & BLK_MQ_F_TAG_QUEUE_SHARED)
+               __blk_mq_tag_idle(hctx);
 }

-----Original Message-----
From: Ming Lei [mailto:ming.lei@redhat.com] 
Sent: Thursday, December 10, 2020 12:01 PM
To: tianxianting (RD) <tian.xianting@h3c.com>
Cc: axboe@kernel.dk; linux-block@vger.kernel.org; linux-kernel@vger.kernel.org
Subject: Re: [PATCH] blk-mq-tag: make blk_mq_tag_busy() return void

On Tue, Dec 08, 2020 at 03:40:02PM +0800, Xianting Tian wrote:
> As no one cares about the return value of blk_mq_tag_busy() and 
> __blk_mq_tag_busy(), so make them return void.
> 
> Signed-off-by: Xianting Tian <tian.xianting@h3c.com>
> ---
>  block/blk-mq-tag.c | 4 ++--
>  block/blk-mq-tag.h | 8 ++++----
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c index 
> 9c92053e7..21ff7d156 100644
> --- a/block/blk-mq-tag.c
> +++ b/block/blk-mq-tag.c
> @@ -21,7 +21,7 @@
>   * to get tag when first time, the other shared-tag users could reserve
>   * budget for it.
>   */
> -bool __blk_mq_tag_busy(struct blk_mq_hw_ctx *hctx)
> +void __blk_mq_tag_busy(struct blk_mq_hw_ctx *hctx)
>  {
>  	if (blk_mq_is_sbitmap_shared(hctx->flags)) {
>  		struct request_queue *q = hctx->queue; @@ -36,7 +36,7 @@ bool 
> __blk_mq_tag_busy(struct blk_mq_hw_ctx *hctx)
>  			atomic_inc(&hctx->tags->active_queues);
>  	}
>  
> -	return true;
> +	return;
>  }
>  
>  /*
> diff --git a/block/blk-mq-tag.h b/block/blk-mq-tag.h index 
> 7d3e6b333..dd80e5a85 100644
> --- a/block/blk-mq-tag.h
> +++ b/block/blk-mq-tag.h
> @@ -60,15 +60,15 @@ enum {
>  	BLK_MQ_TAG_MAX		= BLK_MQ_NO_TAG - 1,
>  };
>  
> -extern bool __blk_mq_tag_busy(struct blk_mq_hw_ctx *);
> +extern void __blk_mq_tag_busy(struct blk_mq_hw_ctx *);
>  extern void __blk_mq_tag_idle(struct blk_mq_hw_ctx *);
>  
> -static inline bool blk_mq_tag_busy(struct blk_mq_hw_ctx *hctx)
> +static inline void blk_mq_tag_busy(struct blk_mq_hw_ctx *hctx)
>  {
>  	if (!(hctx->flags & BLK_MQ_F_TAG_QUEUE_SHARED))
> -		return false;
> +		return;
>  
> -	return __blk_mq_tag_busy(hctx);
> +	__blk_mq_tag_busy(hctx);

The above can be simplified as:

  	if (hctx->flags & BLK_MQ_F_TAG_QUEUE_SHARED)
		__blk_mq_tag_busy(hctx);

Otherwise, looks fine:

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming

