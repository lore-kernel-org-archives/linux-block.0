Return-Path: <SRS0=nOxH=S6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D53CC43219
	for <linux-block@archiver.kernel.org>; Sun, 28 Apr 2019 12:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EDB42075D
	for <linux-block@archiver.kernel.org>; Sun, 28 Apr 2019 12:12:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbfD1MM5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 28 Apr 2019 08:12:57 -0400
Received: from verein.lst.de ([213.95.11.211]:60132 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726522AbfD1MM5 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 28 Apr 2019 08:12:57 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 8912B68B05; Sun, 28 Apr 2019 14:12:40 +0200 (CEST)
Date:   Sun, 28 Apr 2019 14:12:40 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Dongli Zhang <dongli.zhang@oracle.com>,
        James Smart <james.smart@broadcom.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Subject: Re: [PATCH V8 4/7] blk-mq: split blk_mq_alloc_and_init_hctx into
 two parts
Message-ID: <20190428121240.GC4281@lst.de>
References: <20190428081408.27331-1-ming.lei@redhat.com> <20190428081408.27331-5-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190428081408.27331-5-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> +static struct blk_mq_hw_ctx *
> +blk_mq_alloc_hctx(struct request_queue *q,
> +		struct blk_mq_tag_set *set,

Nit: The second paramter would easily fit on the first line.

> +		unsigned hctx_idx, int node)
> +{
> +	struct blk_mq_hw_ctx *hctx;
> +
> +	hctx = kzalloc_node(blk_mq_hw_ctx_size(set),
> +			GFP_NOIO | __GFP_NOWARN | __GFP_NORETRY,
> +			node);
> +	if (!hctx)
> +		goto fail_alloc_hctx;
> +
> +	if (!zalloc_cpumask_var_node(&hctx->cpumask,
> +				GFP_NOIO | __GFP_NOWARN | __GFP_NORETRY,
> +				node))

Nit: I still think a local variable for the gfp_t would be very useful
here.

> +	atomic_set(&hctx->nr_active, 0);
> +	hctx->numa_node = node;
>  	if (node == NUMA_NO_NODE)
> -		node = hctx->numa_node = set->numa_node;
> +		hctx->numa_node = set->numa_node;
> +	node = hctx->numa_node;

Why not:

	if (node == NUMA_NO_NODE)
		set->numa_node;
	hctx->numa_node = node;

?

Otherwise looks fine:


Reviewed-by: Christoph Hellwig <hch@lst.de>
