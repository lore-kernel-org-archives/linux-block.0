Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33695 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754518AbcJEVrf (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Oct 2016 17:47:35 -0400
Subject: Re: [PATCH v2 6/8] blk-mq: Rework blk_mq_realloc_hw_ctxs()
To: Alexander Gordeev <agordeev@redhat.com>,
        linux-kernel@vger.kernel.org
References: <cover.1475241231.git.agordeev@redhat.com>
 <7459c980dd965b5f7b91e3bf1c3114d658535229.1475241231.git.agordeev@redhat.com>
Cc: linux-block@vger.kernel.org
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <259f9d8c-e552-7565-5e05-88a1c8430317@grimberg.me>
Date: Thu, 6 Oct 2016 00:47:26 +0300
MIME-Version: 1.0
In-Reply-To: <7459c980dd965b5f7b91e3bf1c3114d658535229.1475241231.git.agordeev@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


> @@ -1908,33 +1909,36 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
>  		if (node == NUMA_NO_NODE)
>  			node = set->numa_node;
>
> -		hctxs[i] = kzalloc_node(sizeof(struct blk_mq_hw_ctx),
> -					GFP_KERNEL, node);
> -		if (!hctxs[i])
> +		hctx = kzalloc_node(sizeof(*hctx), GFP_KERNEL, node);
> +		if (!hctx)
>  			break;
>
> -		if (blk_mq_init_hctx(q, set, hctxs[i], i, node)) {
> -			kfree(hctxs[i]);
> -			hctxs[i] = NULL;
> +		if (blk_mq_init_hctx(q, set, hctx, i, node)) {
> +			kfree(hctx);
>  			break;
>  		}
> -		blk_mq_hctx_kobj_init(hctxs[i]);
> +
> +		blk_mq_hctx_kobj_init(hctx);
> +		hctxs[i] = hctx;
>  	}
>  	for (j = i; j < q->nr_hw_queues; j++) {
> -		struct blk_mq_hw_ctx *hctx = hctxs[j];
> +		hctx = hctxs[i];

Didn't you mean hctx[j]?
