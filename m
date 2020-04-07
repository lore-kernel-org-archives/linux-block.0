Return-Path: <SRS0=69Bb=5X=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A737DC2BB1D
	for <linux-block@archiver.kernel.org>; Tue,  7 Apr 2020 11:44:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82C8B20678
	for <linux-block@archiver.kernel.org>; Tue,  7 Apr 2020 11:44:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbgDGLo1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Apr 2020 07:44:27 -0400
Received: from verein.lst.de ([213.95.11.211]:37685 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726399AbgDGLo1 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 7 Apr 2020 07:44:27 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3EDB668C4E; Tue,  7 Apr 2020 13:44:25 +0200 (CEST)
Date:   Tue, 7 Apr 2020 13:44:25 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk, linux-block@vger.kernel.org
Subject: Re: [PATCH] block: fix busy device checking in blk_drop_partitions
Message-ID: <20200407114425.GA14407@lst.de>
References: <20200404065120.655735-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200404065120.655735-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

ping?

On Sat, Apr 04, 2020 at 08:51:20AM +0200, Christoph Hellwig wrote:
> bd_super is only set by get_tree_bdev and mount_bdev, and thus not by
> other openers like btrfs or the XFS realtime and log devices, as well as
> block devices directly opened from user space.  Check bd_openers
> instead.
> 
> Fixes: 77032ca66f86 ("Return EBUSY from BLKRRPART for mounted whole-dev fs")
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/partitions/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/partitions/core.c b/block/partitions/core.c
> index b79c4513629b..1a0a829d8416 100644
> --- a/block/partitions/core.c
> +++ b/block/partitions/core.c
> @@ -496,7 +496,7 @@ int blk_drop_partitions(struct gendisk *disk, struct block_device *bdev)
>  
>  	if (!disk_part_scan_enabled(disk))
>  		return 0;
> -	if (bdev->bd_part_count || bdev->bd_super)
> +	if (bdev->bd_part_count || bdev->bd_openers)
>  		return -EBUSY;
>  	res = invalidate_partition(disk, 0);
>  	if (res)
> -- 
> 2.25.1
---end quoted text---
