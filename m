Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 544E5C4361B
	for <linux-block@archiver.kernel.org>; Thu, 10 Dec 2020 06:25:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1674923C43
	for <linux-block@archiver.kernel.org>; Thu, 10 Dec 2020 06:25:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733199AbgLJGZY convert rfc822-to-8bit (ORCPT
        <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Dec 2020 01:25:24 -0500
Received: from smtp.h3c.com ([60.191.123.50]:27402 "EHLO h3cspam02-ex.h3c.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733186AbgLJGZY (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Dec 2020 01:25:24 -0500
Received: from DAG2EX03-BASE.srv.huawei-3com.com ([10.8.0.66])
        by h3cspam02-ex.h3c.com with ESMTP id 0BA6NNs7051288;
        Thu, 10 Dec 2020 14:23:23 +0800 (GMT-8)
        (envelope-from tian.xianting@h3c.com)
Received: from DAG2EX03-BASE.srv.huawei-3com.com (10.8.0.66) by
 DAG2EX03-BASE.srv.huawei-3com.com (10.8.0.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 10 Dec 2020 14:23:25 +0800
Received: from DAG2EX03-BASE.srv.huawei-3com.com ([fe80::5d18:e01c:bbbd:c074])
 by DAG2EX03-BASE.srv.huawei-3com.com ([fe80::5d18:e01c:bbbd:c074%7]) with
 mapi id 15.01.2106.002; Thu, 10 Dec 2020 14:23:25 +0800
From:   Tianxianting <tian.xianting@h3c.com>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] [v2] blk-mq-tag: make blk_mq_tag_busy() return void
Thread-Topic: [PATCH] [v2] blk-mq-tag: make blk_mq_tag_busy() return void
Thread-Index: AQHWzroykh4+9vclPkq1LnwbeddRv6nv3B4Q
Date:   Thu, 10 Dec 2020 06:23:24 +0000
Message-ID: <bb610b2693ef4c71aedfc6559afe123b@h3c.com>
References: <20201210055307.1024-1-tian.xianting@h3c.com>
 <BYAPR04MB4965FC5A5F69F18A1F0BB06486CB0@BYAPR04MB4965.namprd04.prod.outlook.com>
In-Reply-To: <BYAPR04MB4965FC5A5F69F18A1F0BB06486CB0@BYAPR04MB4965.namprd04.prod.outlook.com>
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
X-MAIL: h3cspam02-ex.h3c.com 0BA6NNs7051288
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Yes, 
Sorry, In V2. I missed it, so I sent v3 :)

-----Original Message-----
From: Chaitanya Kulkarni [mailto:Chaitanya.Kulkarni@wdc.com] 
Sent: Thursday, December 10, 2020 2:21 PM
To: tianxianting (RD) <tian.xianting@h3c.com>; axboe@kernel.dk
Cc: ming.lei@redhat.com; linux-block@vger.kernel.org; linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] blk-mq-tag: make blk_mq_tag_busy() return void

On 12/9/20 22:06, Xianting Tian wrote:
> As no one cares about the return value of blk_mq_tag_busy() and 
> __blk_mq_tag_busy(), so make them return void.
>
> Other change is to simplify blk_mq_tag_idle().
>
> Signed-off-by: Xianting Tian <tian.xianting@h3c.com>
> Reviewed-by: Ming Lei <ming.lei@redhat.com>
> ---
>  block/blk-mq-tag.c |  4 ++--
>  block/blk-mq-tag.h | 16 ++++++----------
>  2 files changed, 8 insertions(+), 12 deletions(-)
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
if above return is the last statement then you need to remove that instead of using return with no value.

Also, please add the version history.
