Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2391DC433E6
	for <linux-block@archiver.kernel.org>; Mon, 22 Feb 2021 12:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF58964E15
	for <linux-block@archiver.kernel.org>; Mon, 22 Feb 2021 12:00:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbhBVMAh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Feb 2021 07:00:37 -0500
Received: from mx2.suse.de ([195.135.220.15]:47496 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230037AbhBVMAf (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Feb 2021 07:00:35 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EE33BACCF;
        Mon, 22 Feb 2021 11:59:53 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id A76A91E14ED; Mon, 22 Feb 2021 12:59:53 +0100 (CET)
Date:   Mon, 22 Feb 2021 12:59:53 +0100
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Jan Kara <jack@suse.cz>, stable@vger.kernel.org
Subject: Re: [PATCH v2] block: Try to handle busy underlying device on discard
Message-ID: <20210222115953.GD19630@quack2.suse.cz>
References: <20210222094809.21775-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210222094809.21775-1-jack@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon 22-02-21 10:48:09, Jan Kara wrote:
> Commit 384d87ef2c95 ("block: Do not discard buffers under a mounted
> filesystem") made paths issuing discard or zeroout requests to the
> underlying device try to grab block device in exclusive mode. If that
> failed we returned EBUSY to userspace. This however caused unexpected
> fallout in userspace where e.g. FUSE filesystems issue discard requests
> from userspace daemons although the device is open exclusively by the
> kernel. Also shrinking of logical volume by LVM issues discard requests
> to a device which may be claimed exclusively because there's another LV
> on the same PV. So to avoid these userspace regressions, fall back to
> invalidate_inode_pages2_range() instead of returning EBUSY to userspace
> and return EBUSY only of that call fails as well (meaning that there's
> indeed someone using the particular device range we are trying to
> discard).
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=211167
> Fixes: 384d87ef2c95 ("block: Do not discard buffers under a mounted filesystem")
> CC: stable@vger.kernel.org
> Signed-off-by: Jan Kara <jack@suse.cz>

Before I forget: I'd like to add two tested by tags to give credit to
people who helped with testing.

Tested-by: Richard W.M. Jones <rjones@redhat.com>
Tested-by: Andreas Klauer <Andreas.Klauer@metamorpher.de>

									Honza

> ---
>  fs/block_dev.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/block_dev.c b/fs/block_dev.c
> index 235b5042672e..c33151020bcd 100644
> --- a/fs/block_dev.c
> +++ b/fs/block_dev.c
> @@ -118,13 +118,22 @@ int truncate_bdev_range(struct block_device *bdev, fmode_t mode,
>  	if (!(mode & FMODE_EXCL)) {
>  		int err = bd_prepare_to_claim(bdev, truncate_bdev_range);
>  		if (err)
> -			return err;
> +			goto invalidate;
>  	}
>  
>  	truncate_inode_pages_range(bdev->bd_inode->i_mapping, lstart, lend);
>  	if (!(mode & FMODE_EXCL))
>  		bd_abort_claiming(bdev, truncate_bdev_range);
>  	return 0;
> +
> +invalidate:
> +	/*
> +	 * Someone else has handle exclusively open. Try invalidating instead.
> +	 * The 'end' argument is inclusive so the rounding is safe.
> +	 */
> +	return invalidate_inode_pages2_range(bdev->bd_inode->i_mapping,
> +					     lstart >> PAGE_SHIFT,
> +					     lend >> PAGE_SHIFT);
>  }
>  EXPORT_SYMBOL(truncate_bdev_range);
>  
> -- 
> 2.26.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
