Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46687C433DB
	for <linux-block@archiver.kernel.org>; Mon, 29 Mar 2021 03:03:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAD7A61934
	for <linux-block@archiver.kernel.org>; Mon, 29 Mar 2021 03:03:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbhC2DDG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 28 Mar 2021 23:03:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:36194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229645AbhC2DCx (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 28 Mar 2021 23:02:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9BFF261934;
        Mon, 29 Mar 2021 03:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616986973;
        bh=9KOBBDzHE9tm9f4m7NDK+j98f0TQKLYLgu4B/KF1CP0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EybvtdcSfJhmQHsxPltvuOfamtkALF7j9r2fpAdl8jCmerKrFEH/F5gQUjLK9SvJG
         TJaBKuLhKvSHQbEDBm9KrwJ8oSqk4ColwwMBNNwki6aIeWqCGvFbULq9sAmOwN6PTs
         L6xV91ot8Gvet/RxIOVeXfmtNsVmTcibjxQpi1aHZ8aykxcH/fagfhZ2emWlQaUxUr
         GwTofailRGWAAtPlwiJWNGMZ59hZ36YWI6OYdp4PQ3yF9Wh5d2BWJkrPJPESzGtp+E
         /Ml21VoWKnck8Eh2jCApP/ESkWG4nSm2n1Sk/Xj4973Hs+QDY+sQQ3UepfcHL1M4ws
         0zEFECz9OTK6Q==
Date:   Mon, 29 Mar 2021 12:02:46 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     Yufen Yu <yuyufen@huawei.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org, hch@lst.de,
        ming.lei@redhat.com, bvanassche@acm.org
Subject: Re: [RFC PATCH] block: protect bi_status with spinlock
Message-ID: <20210329030246.GA15392@redsun51.ssa.fujisawa.hgst.com>
References: <20210329022337.3992955-1-yuyufen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210329022337.3992955-1-yuyufen@huawei.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Mar 28, 2021 at 10:23:37PM -0400, Yufen Yu wrote:
>  static struct bio *__bio_chain_endio(struct bio *bio)
>  {
>  	struct bio *parent = bio->bi_private;
> +	unsigned long flags;
>  
> +	spin_lock_irqsave(&parent->bi_lock, flags);
>  	if (!parent->bi_status)
>  		parent->bi_status = bio->bi_status;
> +	spin_unlock_irqrestore(&parent->bi_lock, flags);


I don't see a spin_lock_init() on this new lock, though a spinlock seems
overkill here. If you need an atomic update, you could do:

	cmpxchg(&parent->bi_status, 0, bio->bi_status);

But I don't even think that's necessary. There really is no need to set
parent->bi_status if bio->bi_status is 0, so something like this should
be fine:

  	if (bio->bi_status && !parent->bi_status)
  		parent->bi_status = bio->bi_status;
