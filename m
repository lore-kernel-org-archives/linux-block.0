Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBC5FC433E0
	for <linux-block@archiver.kernel.org>; Wed, 10 Mar 2021 08:46:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B2D664FD6
	for <linux-block@archiver.kernel.org>; Wed, 10 Mar 2021 08:46:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbhCJIpc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Mar 2021 03:45:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232663AbhCJIpa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Mar 2021 03:45:30 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05D09C06174A
        for <linux-block@vger.kernel.org>; Wed, 10 Mar 2021 00:45:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VSJArGkxxjdooUo4oxiNyaepmUms80gndOGZV5fVfUg=; b=BBSKZXy3CsFSU1Vm/TkvtRpbHX
        Bz7j3qMFA9wP+zvkr3/iwjm6rqfw5DLpV/mApIKIKjgi+GVB8y0RpjfrhIGZ6ioO0seiYVG02prVW
        xzCGxXhbcZcB6BKI39PSUWF6HUow4fl12f7UosQvsO/VCqrFDibFnIvGKROzmeYgIUnkQg7LazurU
        ahCPzNYeCkYirB+HkFQ/7DezPBvzjyXiqmpDmXMdWBo+JQ/1Kehkjj+3myv4F9DhV9vlcz+e1bVzR
        3dmjWlvtypgSLjMUKwRr9I0DE6jFjMK+nF7TOS9LAnBH3JzyYiYEEI98wEq3UrKVWwhQ29p1Fjpq+
        TizvOp6Q==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lJuT1-002uvC-Oo; Wed, 10 Mar 2021 08:45:24 +0000
Date:   Wed, 10 Mar 2021 08:45:19 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>, Jan Kara <jack@suse.cz>,
        Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [PATCH v2] block: Discard page cache of zone reset target range
Message-ID: <20210310084519.GB682482@infradead.org>
References: <20210310065003.573474-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210310065003.573474-1-shinichiro.kawasaki@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

>  	switch (cmd) {
>  	case BLKRESETZONE:
>  		op = REQ_OP_ZONE_RESET;
> +
> +		capacity = get_capacity(bdev->bd_disk);
> +		if (zrange.sector + zrange.nr_sectors <= zrange.sector ||
> +		    zrange.sector + zrange.nr_sectors > capacity)
> +			/* Out of range */
> +			return -EINVAL;
> +
> +		start = zrange.sector << SECTOR_SHIFT;
> +		end = ((zrange.sector + zrange.nr_sectors) << SECTOR_SHIFT) - 1;
> +
> +		/* Invalidate the page cache, including dirty pages. */
> +		ret = truncate_bdev_range(bdev, mode, start, end);
> +		if (ret)
> +			return ret;

Can we factor this out into a truncate_zone_range() helper?
