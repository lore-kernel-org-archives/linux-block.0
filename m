Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C22C6C77B7A
	for <linux-block@archiver.kernel.org>; Tue, 13 Jun 2023 05:03:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234814AbjFMFDE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 13 Jun 2023 01:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbjFMFDE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Jun 2023 01:03:04 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 285568E;
        Mon, 12 Jun 2023 22:03:03 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id AA06668BFE; Tue, 13 Jun 2023 07:02:59 +0200 (CEST)
Date:   Tue, 13 Jun 2023 07:02:59 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jingbo Xu <jefflexu@linux.alibaba.com>
Cc:     axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, tianjia.zhang@linux.alibaba.com,
        xiang@kernel.org, casey@schaufler-ca.com
Subject: Re: [PATCH v2] block: fine-granular CAP_SYS_ADMIN for Persistent
 Reservation ioctl
Message-ID: <20230613050259.GA13751@lst.de>
References: <20230612074103.4866-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612074103.4866-1-jefflexu@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> +static bool blkdev_pr_allowed(struct block_device *bdev, fmode_t mode)

With my resent series the use of fmode_t in the block layer has been
replaced with a new blk_mode_t, so you'll need to rebase.

> +{
> +	if (capable(CAP_SYS_ADMIN))
> +		return true;
> +
> +	/* no sense to make reservations for partitions */
> +	if (bdev_is_partition(bdev))
> +		return false;

I think we should disallow the PR ioctls for partitions entirely.
Yes, that's a change of behavior (and should be a separate patch),
but this is the right time to fix it.

Otherwise this change log good, thanks a lot!

