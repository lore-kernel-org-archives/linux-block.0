Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F767C433ED
	for <linux-block@archiver.kernel.org>; Mon, 12 Apr 2021 10:19:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3129161353
	for <linux-block@archiver.kernel.org>; Mon, 12 Apr 2021 10:19:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237609AbhDLKTw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 12 Apr 2021 06:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237302AbhDLKTw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Apr 2021 06:19:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34983C061574
        for <linux-block@vger.kernel.org>; Mon, 12 Apr 2021 03:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UiPaR8F2CsFIZ3Nx/UaiOz4MtlXpJSiuFUAs99bLB74=; b=DjJiD2+hXrtnmsNxfNPIzlLLlH
        snGyhWj/cdnx4Eo2XF0ZX1YmWd0Pt5em2wvAObQIA4lJrS1djebiTWyQ5ZIiTkJ6ygKVUIUTcoaqq
        k8qPwOGsV8sAbwT4IVMZjV2a9zbcWA/+oBzTeotQXtzO61hNXz1ozxMbaWhE2aCbKjTij0Q+9ZoFO
        nlzBQFOJE9Oetou5VUfx1wPePTVefdLy8ZJyfKjcf3ox7r8W1RO++Bvz3D0qlD1dESMhOQyIr1D0W
        ubyu8ktdoo7pduv7Ss7DPDw5kEsL+lSpYnYIhx5Nj5MNcx3nE8nXanWaWzy/S+oqNKyxm1ioCcN4A
        /kqBucBA==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lVtfA-004B1K-NX; Mon, 12 Apr 2021 10:19:29 +0000
Date:   Mon, 12 Apr 2021 11:19:24 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH V5 03/12] block: create io poll context for submission
 and poll task
Message-ID: <20210412101924.GC993044@infradead.org>
References: <20210401021927.343727-1-ming.lei@redhat.com>
 <20210401021927.343727-4-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210401021927.343727-4-ming.lei@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

>  /**
>   * blk_poll - poll for IO completions

> @@ -3875,6 +3886,9 @@ int blk_poll(struct request_queue *q, blk_qc_t cookie, bool spin)
>  	if (current->plug)
>  		blk_flush_plug_list(current->plug, false);
>  
> +	if (!queue_is_mq(q))
> +		return blk_bio_poll(q, cookie, spin);
> +
>  	hctx = q->queue_hw_ctx[blk_qc_t_to_queue_num(cookie)];

Before doing this, blk_poll needs to be split into the public blk_poll
that should go into blk_poll, and a blk_mq_poll that should remain in
blk-mq.c.
