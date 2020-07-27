Return-Path: <SRS0=68Kh=BG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED5ADC433E0
	for <linux-block@archiver.kernel.org>; Mon, 27 Jul 2020 22:13:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDDC82075D
	for <linux-block@archiver.kernel.org>; Mon, 27 Jul 2020 22:13:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="mE+igJq0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbgG0WNe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Jul 2020 18:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbgG0WNd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Jul 2020 18:13:33 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90726C061794
        for <linux-block@vger.kernel.org>; Mon, 27 Jul 2020 15:13:33 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id k4so8889049pld.12
        for <linux-block@vger.kernel.org>; Mon, 27 Jul 2020 15:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6a95zXSN/3Ne4hUmXR/5l/w4mugoC555WVp08JuUcsM=;
        b=mE+igJq0yQSPQ5HU1MFiLoThv1VoxQy0O3MKpHebvgVqbBGaAPDUiyXMdy0wbVc116
         Mb+4CNOOWX9c+uUyJj9emhcqrrf9AQrtUSvmiZk4yr0Ym+NU06kYKBPAfKkk1swidG+G
         rEbDSB+XCbTCwxulH7YEV2UCTyt9tmQMszVhV/lJTjyr+uiCBBA+Dx0YN0WevgBJxGfs
         1CCfa10xqCsE7hNCUBZDQ0IJRAkP8tZyTotzknCLTkJ0L4LQnbt+gzSW71/LouVAZnk5
         aZg1VbCB5TqJkICr/SQVU3Sank/QINcSANug7RiULbXN6/4TzXAAE0iwvS/R1gHdNY5n
         WaNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6a95zXSN/3Ne4hUmXR/5l/w4mugoC555WVp08JuUcsM=;
        b=JhEqtZKKB5iZJOsW5t2egpc/RylThIoTzBFoSwwiLxvOqePUVj/dL6vBlMFDQu7uXx
         10Y0kO1arJr1RxEME4I1YdiY3pmySewpW6r2GiUqz3O6TuO6wse8bHBRXGj3LVF5JhKW
         t7MMxiGraoyaznmQIB2l+ocdM3jv5Drw1T4TJnqoPGvKYZ903un/3apgSNQHlFUrnHDw
         b1Ssy4kQhRgnzQKhTwv7zbMictzjCLKP7gcnCvkNgxPHolrKXD8ffwomAeWrHJ+dyfO4
         de+tuRLx3ZiN8wQg68aaQz95PHHZCKmvsKcLlJ7kVOArg5/wZAed565D7Kh9uDRpXJyN
         fQ9Q==
X-Gm-Message-State: AOAM530YGJWwheqeJMSCZIOmHCtGWByxE4fXwqur9l4Uzc3zmisOxhO4
        uGB+oKGW2JRS0uimDHZ0ffaZeg==
X-Google-Smtp-Source: ABdhPJzJ/ebKlyaHGQl6M67GcDmNahnW3IwGWH/CFCfLw+j478VPPMhzoQ4X3/l1B6myJW7X7YI8QQ==
X-Received: by 2002:a17:90b:350f:: with SMTP id ls15mr1330378pjb.84.1595888012995;
        Mon, 27 Jul 2020 15:13:32 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id r2sm15878201pfh.106.2020.07.27.15.13.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2020 15:13:32 -0700 (PDT)
Subject: Re: [PATCH v4 1/2] blk-mq: add async quiesce interface
To:     Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
        Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc:     linux-block@vger.kernel.org, Ming Lin <mlin@kernel.org>,
        Chao Leng <lengchao@huawei.com>
References: <20200727220717.278116-1-sagi@grimberg.me>
 <20200727220717.278116-2-sagi@grimberg.me>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <fe247bae-8428-bca8-81b5-a7015bc39591@kernel.dk>
Date:   Mon, 27 Jul 2020 16:13:31 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200727220717.278116-2-sagi@grimberg.me>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/27/20 4:07 PM, Sagi Grimberg wrote:
> Drivers that may have to quiesce a large amount of request queues at once
> (e.g. controller or adapter reset). These drivers would benefit from an
> async quiesce interface such that the can trigger quiesce asynchronously
> and wait for all in parallel.
> 
> This leaves the synchronization responsibility to the driver, but adds
> a convenient interface to quiesce async and wait in a single pass.
> 
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>  block/blk-mq.c         | 46 ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/blk-mq.h |  4 ++++
>  2 files changed, 50 insertions(+)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index abcf590f6238..d913924117d2 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -209,6 +209,52 @@ void blk_mq_quiesce_queue_nowait(struct request_queue *q)
>  }
>  EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue_nowait);
>  
> +void blk_mq_quiesce_queue_async(struct request_queue *q)
> +{
> +	struct blk_mq_hw_ctx *hctx;
> +	unsigned int i;
> +	int rcu = false;
> +
> +	blk_mq_quiesce_queue_nowait(q);
> +
> +	queue_for_each_hw_ctx(q, hctx, i) {
> +		hctx->rcu_sync = kmalloc(sizeof(*hctx->rcu_sync), GFP_KERNEL);
> +		if (!hctx->rcu_sync) {
> +			/* fallback to serial rcu sync */
> +			if (hctx->flags & BLK_MQ_F_BLOCKING)
> +				synchronize_srcu(hctx->srcu);
> +			else
> +				rcu = true;
> +		} else {
> +			init_completion(&hctx->rcu_sync->completion);
> +			init_rcu_head(&hctx->rcu_sync->head);
> +			if (hctx->flags & BLK_MQ_F_BLOCKING)
> +				call_srcu(hctx->srcu, &hctx->rcu_sync->head,
> +					wakeme_after_rcu);
> +			else
> +				call_rcu(&hctx->rcu_sync->head,
> +					wakeme_after_rcu);
> +		}
> +	}
> +	if (rcu)
> +		synchronize_rcu();
> +}
> +EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue_async);

This won't always be async, and that might matter to some users. I think
it'd be better to put the fallback path into the _wait() part instead,
since the caller should expect that to be blocking/waiting as the name
implies.

Nit picking, but...

-- 
Jens Axboe

