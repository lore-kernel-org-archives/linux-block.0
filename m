Return-Path: <SRS0=iCYb=RZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D288DC43381
	for <linux-block@archiver.kernel.org>; Fri, 22 Mar 2019 15:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C78F218FE
	for <linux-block@archiver.kernel.org>; Fri, 22 Mar 2019 15:01:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pKpQb44T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729241AbfCVPBW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Mar 2019 11:01:22 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42220 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727843AbfCVPBV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Mar 2019 11:01:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=EgTMKWHz0uBwQukACuWjiRNym5eVpJIbo0etG/vWlfE=; b=pKpQb44TZiwFukfwRCaLbc9xp
        gYw1hNJIWl53OMAvsbds928sGHPDfyICVuWZ26ehZi4CGQRC+NqFLV+w+rHg3Y2ebYWU7v6B9Z1Ly
        f5UuVWTNzAHrA7glMee+yX/YXoDXZqmQjt9EKqy6rw9MVF7s8XNXEd3Jx0LKop4WkSLPnzDVX6AoY
        GEtvnSo++aJuX3z1jn1pZh2XgTcipj5EvPHgIuLvJ380qMOFq17KxnxVjxCKsjUzNpbR9Ygw0y8P1
        Q1LfGcf8k6YCHuM1aiox8kuKgKviy5i2DMsoIsJ0uM1AS4gLx0wpsHAVwvkDVvT4xq47PVX+R8keS
        LnWOF30Iw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h7Lfb-0007x3-8d; Fri, 22 Mar 2019 15:01:19 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BC568287233CE; Fri, 22 Mar 2019 16:01:16 +0100 (CET)
Date:   Fri, 22 Mar 2019 16:01:16 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yufen Yu <yuyufen@huawei.com>
Cc:     axboe@kernel.dk, dwindsor@gmail.com, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/2] blk-mq: convert hctx.nr_active to refcount_t
Message-ID: <20190322150116.GZ6058@hirez.programming.kicks-ass.net>
References: <20190322144818.987-1-yuyufen@huawei.com>
 <20190322144818.987-2-yuyufen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190322144818.987-2-yuyufen@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Mar 22, 2019 at 10:48:17PM +0800, Yufen Yu wrote:
> @@ -2710,7 +2710,7 @@ static struct blk_mq_hw_ctx *blk_mq_alloc_and_init_hctx(
>  		return NULL;
>  	}
>  
> -	atomic_set(&hctx->nr_active, 0);
> +	refcount_set(&hctx->nr_active, 0);
>  	hctx->numa_node = node;
>  	hctx->queue_num = hctx_idx;
>  

That looks bogus, refcount_t cannot inc-from-zero.
