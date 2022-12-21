Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72D52C4332F
	for <linux-block@archiver.kernel.org>; Wed, 21 Dec 2022 10:49:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234651AbiLUKtI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Dec 2022 05:49:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234658AbiLUKs5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Dec 2022 05:48:57 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEA3F21892
        for <linux-block@vger.kernel.org>; Wed, 21 Dec 2022 02:48:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=G8BfwESgESTNnYvNeYuCU3HSzchk37wUY4xu9hlmTjk=; b=otvVEkZIWl9/t3BCnbtxXKY6rO
        d4t7QZr+4tBuq2CDIYERTqHcR9d/xd9lwXbuCZOYYLKwo77AJqLiqdrSqZbrY9VCfk5V1uPcJ5h1a
        sldq+uvJ1Dcfx9EiU8yiYmTGtNWXLugedGwnTNP5FvyUdlkwKBwfrgQNR6+PYx5RKlmBpAFmyCyw1
        5Z2ABoqUwTJGcevg0Y/YoW08Soe0SHmvrZFs6fGsfHYIJyO6gk+Lx0bkbQ104Y1pkWTZw4dnTfX2R
        +60DK0PZjn6RWXaQ1wqfXUj+1he5LQOrObWEGx3H58YnUpJBdPjWM59l0A3sLhfIYXXXdczldnZcA
        glvEGxtw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p7weE-00DhGc-Rt; Wed, 21 Dec 2022 10:48:30 +0000
Date:   Wed, 21 Dec 2022 02:48:30 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Suwan Kim <suwan.kim027@gmail.com>
Cc:     mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        pbonzini@redhat.com, hch@infradead.org, axboe@kernel.dk,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH v2 2/2] virtio-blk: support completion batching for the
 IRQ path
Message-ID: <Y6LkfrTVV/M2eye/@infradead.org>
References: <20221220153613.21675-1-suwan.kim027@gmail.com>
 <20221220153613.21675-3-suwan.kim027@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221220153613.21675-3-suwan.kim027@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> +		if (likely(!blk_should_fake_timeout(req->q)) &&
> +			!blk_mq_complete_request_remote(req) &&
> +			!blk_mq_add_to_batch(req, iob, vbr->status,
> +						virtblk_complete_batch))

One tab indents for line continuations are really confusing.  Please
make this:

		if (likely(!blk_should_fake_timeout(req->q)) &&
		    !blk_mq_complete_request_remote(req) &&
		    !blk_mq_add_to_batch(req, iob, vbr->status,
					 virtblk_complete_batch))

> +	found = virtblk_handle_req(vq, iob);
>  
>  	if (found)

You can drop the found variable here now:

	if (virtblk_handle_req(vq, iob))
 		blk_mq_start_stopped_hw_queues(vblk->disk->queue, true);

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
