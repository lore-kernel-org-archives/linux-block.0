Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4479CC433EF
	for <linux-block@archiver.kernel.org>; Thu, 17 Feb 2022 08:52:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238192AbiBQIxB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Feb 2022 03:53:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238191AbiBQIxA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Feb 2022 03:53:00 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62CFEEC5EB;
        Thu, 17 Feb 2022 00:52:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=cvQG4BWhdc8p53V04JqrldrVc4SgI+kEEpWOktB7E/0=; b=ZsIYJwbOjAwlmwwOfolJ/ZPt4R
        40J358K8RSOv9CCESxuKWoo+heGFbWHqp49tJVbTTzo2UZcZlyVljbfQJavpP6kIlClV/t7eL8Myt
        x3FrilwVYh1/oo+xVOfNLt0thqzDGhejwaksmDgPcXXXjtaShTTuvdzrj5ps8ZEVqV3rPQcVVPnA8
        bLfMfQ3eTTSlfIcRQxJRdFsOLJTne6ulbeMuEbyOQBpnTxJuC2HxrUVh2N0LF53GsKde1JRxSZbGH
        g7C3go0IxTWNTmK6n9+u9qpHaqmdhUT+ACDTER/sszCY6oNXwDHOOYE5AjJodLf5R6uo+jqz4AFth
        RswebEGw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nKcWp-009bmM-Ey; Thu, 17 Feb 2022 08:52:43 +0000
Date:   Thu, 17 Feb 2022 00:52:43 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Wang Jianchao (Kuaishou)" <jianchao.wan9@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Josef Bacik <jbacik@fb.com>,
        Tejun Heo <tj@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC V4 4/6] blk-iocost: make iocost pluggable
Message-ID: <Yg4M2+eG1EGY/+vV@infradead.org>
References: <20220217031349.98561-1-jianchao.wan9@gmail.com>
 <20220217031349.98561-5-jianchao.wan9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220217031349.98561-5-jianchao.wan9@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Feb 17, 2022 at 11:13:47AM +0800, Wang Jianchao (Kuaishou) wrote:
> Make blk-iocost pluggable. Then we can close or open it through
> /sys/block/xxx/queue/qos.
> 
> Signed-off-by: Wang Jianchao (Kuaishou) <jianchao.wan9@gmail.com>
> ---
>  block/blk-iocost.c     | 52 ++++++++++++++++++++++++++----------------
>  block/blk-mq-debugfs.c |  2 --
>  block/blk-rq-qos.h     |  1 -
>  3 files changed, 32 insertions(+), 23 deletions(-)
> 
> diff --git a/block/blk-iocost.c b/block/blk-iocost.c
> index 769b64394298..5a3a45985b49 100644
> --- a/block/blk-iocost.c
> +++ b/block/blk-iocost.c
> @@ -660,9 +660,10 @@ static struct ioc *rqos_to_ioc(struct rq_qos *rqos)
>  	return container_of(rqos, struct ioc, rqos);
>  }
>  
> +static struct rq_qos_ops ioc_rqos_ops;
>  static struct ioc *q_to_ioc(struct request_queue *q)
>  {
> -	return rqos_to_ioc(rq_qos_id(q, RQ_QOS_COST));
> +	return rqos_to_ioc(rq_qos_by_id(q, ioc_rqos_ops.id));
>  }

This has a single caller, so just open code it.

> +static int blk_iocost_init(struct request_queue *q);
> +
>  static struct rq_qos_ops ioc_rqos_ops = {
> +	.name = "blk-iocost",
> +	.flags = RQOS_FLAG_CGRP_POL,
>  	.throttle = ioc_rqos_throttle,
>  	.merge = ioc_rqos_merge,
>  	.done_bio = ioc_rqos_done_bio,
>  	.done = ioc_rqos_done,
>  	.queue_depth_changed = ioc_rqos_queue_depth_changed,
>  	.exit = ioc_rqos_exit,
> +	.init = blk_iocost_init,
>  };

Again, move rq_qos_ops below the init function to avoid the forward
declaration.
