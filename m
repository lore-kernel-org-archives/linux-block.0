Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32371C4332F
	for <linux-block@archiver.kernel.org>; Wed, 14 Dec 2022 16:43:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbiLNQnl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Dec 2022 11:43:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbiLNQnk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Dec 2022 11:43:40 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EA3B2630;
        Wed, 14 Dec 2022 08:43:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Ta+FkplGhIQKdorRO8rZ4lONlODdKGw1emfoP2dg42Q=; b=JYDzwpAonrVhdqNUlrzeg2/AYt
        Ee5Z8uENr87qybhJnwlgvbnmQVfAm6sAde48sjjB9Ji6ZRkZeiyGJXYlK/lsiknTzDumZfpmwh/qn
        groS5dMaDBigUIaxg4Lo9Y4dNm6PGmaHVpt3kRx8JvgSOH9qXIoqTxDw5IaDGPwtLOUMC2FIpLfjR
        BUa5maQj2iVjl+2P9bv2/kA7C5sv7Y2ym0AIusZG3YDITRkkdJlJlgFi03oNiJVTIMdXLbOZK3xbk
        rUinHuAfTlsIfOzrjBWQRCSIYmKqnRxFMvKnb77Gdsc6GyE/BHBXL4rJPtOtTdhheYJNSzncy1IAZ
        qghj2D7Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p5Uqv-000m01-3e; Wed, 14 Dec 2022 16:43:29 +0000
Date:   Wed, 14 Dec 2022 08:43:29 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/4] init: move block device helpers from
 init/do_mounts.c
Message-ID: <Y5n9MYEkrnAF4Ztv@infradead.org>
References: <cover.1668644705.git.daniel@makrotopia.org>
 <e5e0ab0429b1fc8a4e3f9614d2d1cc43dea78093.1668644705.git.daniel@makrotopia.org>
 <Y3XM62P7CaeKXFsz@infradead.org>
 <Y3j+Pzy1JpqG8Yd8@makrotopia.org>
 <Y3zCdJr5dKsADsnM@infradead.org>
 <Y5NpsmN/npnG8lxY@makrotopia.org>
 <Y5buTVuu0pfqBQh+@infradead.org>
 <Y5cKSRmZ45OJq6Qq@makrotopia.org>
 <Y5ggLBy+XBjl/vYj@infradead.org>
 <Y5hz5+yXWDadDhRB@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5hz5+yXWDadDhRB@makrotopia.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Dec 13, 2022 at 12:45:27PM +0000, Daniel Golle wrote:
> > Yes, but a completely non-standard format that nests inside an
> > partition.
> 
> The reason for this current discussion (see subject line) is exactly
> that you didn't like the newly introduced partition type GUID which
> then calls the newly introduced partition parser taking care of the
> uImage.FIT content of a partition.

Which is the exact nesting I'm complaining about.  Why do you need
to use your format inside a GPT partition table?  What you're doing
is bascially nesting a partition table format inside another one,
which doesn't make any sense at all.

> This block driver (if built-into the kernel and relied upon to expose
> the block device used as root filesystem) will need to identify the
> lower device it should work on. And for that the helper functions such
> as devt_from_devname() need to be available for that driver.

And devt_from_devname must not be used by more non-init code.  It is
bad it got exposed at all, but new users are not acceptable.

> A block representation is the common denominator of all the
> above. Sure, I could implement splitting MTD devices according to
> uImage.FIT and then add MTD support to squashfs. Then implement
> splitting of UBI volumes and add UBI support to squashfs.

Implementing MTD and/or UBI support would allow you to build a
kernel without CONFIG_BLOCK, which will save you a lot more than
the 64k you were whining about above.

> > None of this explains the silly nesting inside the GPT partition.
> > It is not needed for the any use cases and the root probem here.
> 
> So where would you store the uImage (which will have to exist
> even to just load kernel and DTB in U-Boot, even without containing
> the root filesystem) on devices with eMMC then?

Straight on the block device, where else?

> Are you suggesting to come up with an entirely new type of partition
> table only for that purpose? Which will require its own tools and
> implementation in both, U-Boot and Linux? What would be the benefit
> over just using GPT partitioning?

Why do you need another layer of partitioning instead of storing
all your information either in the uImage, or in some other
partition format of your choice?

See, if you have GPT, DOS or whatever partitions, you just use
partitions and store all the bits your care about in them.
If you want a fancy not invented here syndrome image format you use that.
But don't use both.
