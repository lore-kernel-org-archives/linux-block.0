Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 717E9C433EF
	for <linux-block@archiver.kernel.org>; Wed, 17 Nov 2021 12:13:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F4066126A
	for <linux-block@archiver.kernel.org>; Wed, 17 Nov 2021 12:13:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236136AbhKQMQv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 Nov 2021 07:16:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233484AbhKQMQv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Nov 2021 07:16:51 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A8BAC061570
        for <linux-block@vger.kernel.org>; Wed, 17 Nov 2021 04:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7b6YzcTf6CqZm4aA16lnKi0MDorCo74ZlNBfL/C4How=; b=MYgkgm4kk1Yg0r+4gtaGsWESH+
        8rNrksBnVVQWnjeJEp/0Jhwh8Ps2nPFsBTyCGgFeDM27TxNU++d+ITAieRXwDGeh3osMPyZTRWqNX
        3AagXqrnQr4b9f+u+YTPWA0JrTQUnnDqjFunBQ5ps8O7EuMdCh68FAZrhZKstc+25ADCof6w9jmeq
        bkN2TOf6Vw3gXoGcQeJFtMVMaqqr3LgfZa6abk3N+pe07adehpH1bGat+PGQMfWUYSUuQ5NueHAdu
        0dpa+H35Tr92+TENVfFR1nycOhHBDe4zao5UwJZ2SznqtA6JuNaGqTTsxbJfwCtCfe3XfUuqw2syZ
        tRCyM6fA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mnJp1-004hPW-6p; Wed, 17 Nov 2021 12:13:51 +0000
Date:   Wed, 17 Nov 2021 04:13:51 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     NeilBrown <neilb@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH] pktdvd: stop using bdi congestion framework.
Message-ID: <YZTx/93/9cjYW4zI@infradead.org>
References: <163712340344.13692.2840899631949534137@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163712340344.13692.2840899631949534137@noble.neil.brown.name>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> -		set_bdi_congested(bio->bi_bdev->bd_disk->bdi, BLK_RW_ASYNC);
> -		do {
> -			spin_unlock(&pd->lock);
> -			congestion_wait(BLK_RW_ASYNC, HZ);
> -			spin_lock(&pd->lock);
> -		} while(pd->bio_queue_size > pd->write_congestion_off);
> +		___wait_var_event(&pd->congested,
> +				  pd->bio_queue_size <= pd->write_congestion_off,
> +				  TASK_UNINTERRUPTIBLE, 0, 0,
> +				  ({pd->congested = true;
> +				    spin_unlock(&pd->lock);
> +				    schedule();
> +				    spin_lock(&pd->lock);
> +				  })

I'd be tempted to open code the ___wait_var_event here as this is pretty
unreadable.  But otherwise this change looks good to me:

Reviewed-by: Christoph Hellwig <hch@lst.de>
