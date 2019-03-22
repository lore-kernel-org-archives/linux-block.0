Return-Path: <SRS0=iCYb=RZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB495C43381
	for <linux-block@archiver.kernel.org>; Fri, 22 Mar 2019 15:02:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA96F218B0
	for <linux-block@archiver.kernel.org>; Fri, 22 Mar 2019 15:02:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="zuIV4sft"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729252AbfCVPCs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Mar 2019 11:02:48 -0400
Received: from merlin.infradead.org ([205.233.59.134]:48806 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727931AbfCVPCs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Mar 2019 11:02:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=93Bo35ShWrINOI20JeldiTLqfX/K3cNJS8ZX+/n6yBw=; b=zuIV4sftWfYPbJ3k5RS3bEdw+
        bfhfYA+iUYu24LRlIUjjR4sLSmhXuUHuXpGyW3TZ/v5MT4xddoJ44knuwQdEL5kn4L9+Mt8omh3VJ
        2Soci5Bdj6givBpz27T/MDD2cuHWWbjWT4iDC/cOYeP8pLG5W0kX4pNkUNCz4A3RSjJ/0m9QABkpk
        SYMqK+k28k0I2Fes9SeqvSOMupvAex2e/0Kl/D3WacE0QtqpvzKlqsrCbFEB+Qd4fmjZj+MnjcBdS
        jfpF+q9Q3Pd8jlA9lgdn3jCdcnDFiTDpTuvH8iCyxxjAcBNAHge5ziKB2xDlggu1/XeOoilQoGn+c
        jkeB2SeHA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h7Lgw-0002RB-0s; Fri, 22 Mar 2019 15:02:42 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C655C287233D0; Fri, 22 Mar 2019 16:02:40 +0100 (CET)
Date:   Fri, 22 Mar 2019 16:02:40 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yufen Yu <yuyufen@huawei.com>
Cc:     axboe@kernel.dk, dwindsor@gmail.com, linux-block@vger.kernel.org
Subject: Re: [PATCH 2/2] blk-mq: covert blk_mq_tag.active_queues to refcount_t
Message-ID: <20190322150240.GA6058@hirez.programming.kicks-ass.net>
References: <20190322144818.987-1-yuyufen@huawei.com>
 <20190322144818.987-3-yuyufen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190322144818.987-3-yuyufen@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Mar 22, 2019 at 10:48:18PM +0800, Yufen Yu wrote:
> We convert 'active_queues' from atomic_t to newly provied
> refcount_t type and API, which can prevent accidental counter
> overflows and underflows.

There is no initialization using refcount_set(), which leads me to
believe we're 0 initialized and then it's broken again.

> Signed-off-by: Yufen Yu <yuyufen@huawei.com>
> ---
>  block/blk-mq-debugfs.c | 2 +-
>  block/blk-mq-tag.c     | 6 +++---
>  block/blk-mq-tag.h     | 2 +-
>  3 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
> index 81536b7201be..48f0cc2c90ba 100644
> --- a/block/blk-mq-debugfs.c
> +++ b/block/blk-mq-debugfs.c
> @@ -473,7 +473,7 @@ static void blk_mq_debugfs_tags_show(struct seq_file *m,
>  	seq_printf(m, "nr_tags=%u\n", tags->nr_tags);
>  	seq_printf(m, "nr_reserved_tags=%u\n", tags->nr_reserved_tags);
>  	seq_printf(m, "active_queues=%d\n",
> -		   atomic_read(&tags->active_queues));
> +		   refcount_read(&tags->active_queues));
>  
>  	seq_puts(m, "\nbitmap_tags:\n");
>  	sbitmap_queue_show(&tags->bitmap_tags, m);
> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> index 3fcb15fa6398..1d713f221bf7 100644
> --- a/block/blk-mq-tag.c
> +++ b/block/blk-mq-tag.c
> @@ -31,7 +31,7 @@ bool __blk_mq_tag_busy(struct blk_mq_hw_ctx *hctx)
>  {
>  	if (!test_bit(BLK_MQ_S_TAG_ACTIVE, &hctx->state) &&
>  	    !test_and_set_bit(BLK_MQ_S_TAG_ACTIVE, &hctx->state))
> -		atomic_inc(&hctx->tags->active_queues);
> +		refcount_inc(&hctx->tags->active_queues);
>  
>  	return true;
>  }
> @@ -57,7 +57,7 @@ void __blk_mq_tag_idle(struct blk_mq_hw_ctx *hctx)
>  	if (!test_and_clear_bit(BLK_MQ_S_TAG_ACTIVE, &hctx->state))
>  		return;
>  
> -	atomic_dec(&tags->active_queues);
> +	refcount_dec(&tags->active_queues);
>  
>  	blk_mq_tag_wakeup_all(tags, false);
>  }
> @@ -82,7 +82,7 @@ static inline bool hctx_may_queue(struct blk_mq_hw_ctx *hctx,
>  	if (bt->sb.depth == 1)
>  		return true;
>  
> -	users = atomic_read(&hctx->tags->active_queues);
> +	users = refcount_read(&hctx->tags->active_queues);
>  	if (!users)
>  		return true;
>  
> diff --git a/block/blk-mq-tag.h b/block/blk-mq-tag.h
> index 61deab0b5a5a..e948b4833a2a 100644
> --- a/block/blk-mq-tag.h
> +++ b/block/blk-mq-tag.h
> @@ -11,7 +11,7 @@ struct blk_mq_tags {
>  	unsigned int nr_tags;
>  	unsigned int nr_reserved_tags;
>  
> -	atomic_t active_queues;
> +	refcount_t active_queues;
>  
>  	struct sbitmap_queue bitmap_tags;
>  	struct sbitmap_queue breserved_tags;
> -- 
> 2.16.2.dirty
> 
