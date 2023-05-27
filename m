Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0CE8C77B7E
	for <linux-block@archiver.kernel.org>; Sat, 27 May 2023 03:16:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231550AbjE0DQv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 May 2023 23:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjE0DQt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 May 2023 23:16:49 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81815E4
        for <linux-block@vger.kernel.org>; Fri, 26 May 2023 20:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IDvnB9XgiI3ohtceV2cKm3xwbOAP+KIRQ2Ii1aeB6gQ=; b=tjuYAQ8NzUXLBVunNPbylcjPvP
        c55jQQNzPpX9av4iy2fP0n7ZOw7C9w9RRq+gd+qsPsw2yk10YaRq33fX1mNECuBaH42wXirxv4HRL
        fD4FPAB5Qtx/9FanTTEHGo5RkwrKxuaIfr7MhpaZQImVOGvUXMpy/ulYps4g2EIuyiMGnQS9izbgE
        TNJH85GHIb+iHkIHrqbc+UwVjroBQvZLCN4rjcaBclH7paMgZw6rHjF4azscgkRIpRKHtJQO6UxE4
        BVCgANhrBzJuMv3nEl/0PVQ/bSdr16v8iaryzcsCdIcoN0fdU/8jQMGjvRSwtlfBR4vzgefgpFpYe
        YorvulSA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q2kQ9-004ipe-2q;
        Sat, 27 May 2023 03:16:45 +0000
Date:   Fri, 26 May 2023 20:16:45 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, jyescas@google.com,
        Ming Lei <ming.lei@redhat.com>, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH v5 3/9] block: Support configuring limits below the page
 size
Message-ID: <ZHF2Hbv5qBJl9CZl@bombadil.infradead.org>
References: <20230522222554.525229-1-bvanassche@acm.org>
 <20230522222554.525229-4-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522222554.525229-4-bvanassche@acm.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, May 22, 2023 at 03:25:35PM -0700, Bart Van Assche wrote:
> Allow block drivers to configure the following:
> * Maximum number of hardware sectors values smaller than
>   PAGE_SIZE >> SECTOR_SHIFT. For PAGE_SIZE = 4096 this means that values
>   below 8 become supported.
> * A maximum segment size below the page size. This is most useful
>   for page sizes above 4096 bytes.
> 
> The blk_sub_page_segments static branch will be used in later patches to
> prevent that performance of block drivers that support segments >=
> PAGE_SIZE and max_hw_sectors >= PAGE_SIZE >> SECTOR_SHIFT would be affected.
> 
> This patch may change the behavior of existing block drivers from not
> working into working.

That's quite an understatement.

> If a block driver calls
> blk_queue_max_hw_sectors() or blk_queue_max_segment_size(), this is
> usually done to configure the maximum supported limits. An attempt to
> configure a limit below what is supported by the block layer causes the
> block layer to select a larger value. If that value is not supported by
> the block driver, this may cause other data to be transferred than
> requested, a kernel crash or other undesirable behavior.

Right, which in the worst case could expose a firmware bug or whatever.

So I see this as a critical fix too. And it gets me wondering what has
happened for 512 byte controllers on 4K PAGE_SIZE?

> + * blk_enable_sub_page_limits - enable support for max_segment_size values smaller than PAGE_SIZE and for max_hw_sectors values below PAGE_SIZE >> SECTOR_SHIFT
Length, 100 is an exception. I'm sticking to the old school 80.

> + * blk_disable_sub_page_limits - disable support for max_segment_size values smaller than PAGE_SIZE and for max_hw_sectors values below PAGE_SIZE >> SECTOR_SHIFT

Same.

> @@ -126,6 +173,11 @@ void blk_queue_max_hw_sectors(struct request_queue *q, unsigned int max_hw_secto
>  	unsigned int min_max_hw_sectors = PAGE_SIZE >> SECTOR_SHIFT;
>  	unsigned int max_sectors;
>  
> +	if (max_hw_sectors < min_max_hw_sectors) {
> +		blk_enable_sub_page_limits(limits);
> +		min_max_hw_sectors = 1;
> +	}
> +
>  	if (max_hw_sectors < min_max_hw_sectors) {
>  		max_hw_sectors = min_max_hw_sectors;
>  		pr_info("%s: set to minimum %u\n", __func__, max_hw_sectors);

It would seem like max_dev_sectors would have saved the day too,
but that is said to be set by the "disk" on the documentation.
I see scsi/sd.c and drivers/s390/block/dasd_*.c set this too,
is that a layering violation, or was that to help perhaps with
similar problems? If not could stroage controller have used this
for this issue as well?

Could the documentation for blk_queue_max_hw_sectors() be enhanced to
clarify this?

The way I'm thinking about this is, if this is a fix for stable too,
what would a minimum safe stable fix be like? And then after whatever
we need to make it better (non stable fixes).

  Luis
