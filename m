Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F936C77B7A
	for <linux-block@archiver.kernel.org>; Wed, 31 May 2023 13:07:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236293AbjEaNHs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 31 May 2023 09:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236311AbjEaNHm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 31 May 2023 09:07:42 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7249138;
        Wed, 31 May 2023 06:07:16 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id A1FB968B05; Wed, 31 May 2023 15:01:14 +0200 (CEST)
Date:   Wed, 31 May 2023 15:01:14 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <kbusch@meta.com>
Cc:     linux-block@vger.kernel.org, io-uring@vger.kernel.org,
        linux-nvme@lists.infradead.org, hch@lst.de, axboe@kernel.dk,
        sagi@grimberg.me, joshi.k@samsung.com,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 1/2] block: add request polling helper
Message-ID: <20230531130114.GC27468@lst.de>
References: <20230530172343.3250958-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530172343.3250958-1-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> +int blk_mq_poll(struct request_queue *q, blk_qc_t cookie, struct io_comp_batch *iob,

It would be nice to fix the overly long line while you're at it.

> +		unsigned int flags)
> +{
> +	return blk_hctx_poll(q, blk_qc_to_hctx(q, cookie), iob, flags);
> +}

But looking at the two callers of blk_mq_poll, shouldn't one use
rq->mq_hctx to get the hctx anyway instead of doing repeated
blk_qc_to_hctx in the polling loop?  We could then just open code
blk_qc_to_hctx in the remaining one.

The rest looks good to me.
