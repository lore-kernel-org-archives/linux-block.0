Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A6EC433F5
	for <linux-block@archiver.kernel.org>; Tue, 23 Nov 2021 18:50:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231955AbhKWSxp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Nov 2021 13:53:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbhKWSxo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Nov 2021 13:53:44 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B57C061574
        for <linux-block@vger.kernel.org>; Tue, 23 Nov 2021 10:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ivJ/0TAUP2zWL33NlZ93Hp1/GPnAEytigM04c2e17C4=; b=L+s/rkSSJiuh3r74S7rVhqtySk
        G+wN24qSFSKvm8cJggwkYhzWNLQJv9+/Xq5AYDOOep6hBMpRJvfKqVndvZwfUEHhvzX+5RvqX0G/w
        viPBl638AAQqyMgkFU1bH4nlZ2XkDUdmIql83xD1RQruucRF38vvd+rEsQxj9jnxFW7qy6PAWaBw8
        sUI5dDdj3pxnGJlV9FWkMF++aGXeM2uJdN5kvJ8ekAietA7fdS/jkadGwZ+nocMHKp3HFoGllxFRo
        HrtLT9IBDQ2r9YTL6v3xzfowj5q5lWm9mdZxgMhH+I4pTdUeKYHsSgOI7Gwb0SZ17HmLdjhhW8xLj
        Q/Y9Lj1g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mpasG-003F4F-2e; Tue, 23 Nov 2021 18:50:36 +0000
Date:   Tue, 23 Nov 2021 10:50:36 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: Re: [PATCH 3/3] block: only allocate poll_stats if there's a user of
 them
Message-ID: <YZ03/OVZcJ+KlfFm@infradead.org>
References: <20211123171058.346084-1-axboe@kernel.dk>
 <20211123171058.346084-4-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211123171058.346084-4-axboe@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> +	spin_lock_irq(&q->stats->lock);
> +	if (q->poll_stat) {
> +		spin_unlock_irq(&q->stats->lock);
> +		kfree(poll_stat);
> +		return true;
> +	}
> +	q->poll_stat = poll_stat;
> +	spin_unlock_irq(&q->stats->lock);

If we'd use a cmpxchg to install the pointer we could keep the
blk_queue_stats definition private.
