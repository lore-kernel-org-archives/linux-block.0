Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09422C433DB
	for <linux-block@archiver.kernel.org>; Tue, 26 Jan 2021 19:54:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B77222A85
	for <linux-block@archiver.kernel.org>; Tue, 26 Jan 2021 19:54:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbhAZFam (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Jan 2021 00:30:42 -0500
Received: from verein.lst.de ([213.95.11.211]:43804 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726126AbhAYJQk (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Jan 2021 04:16:40 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7027768B05; Mon, 25 Jan 2021 09:20:42 +0100 (CET)
Date:   Mon, 25 Jan 2021 09:20:42 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: Re: [PATCH] block: unexport truncate_bdev_range
Message-ID: <20210125082042.GA11659@lst.de>
References: <20210109111332.1132424-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210109111332.1132424-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Jens,

can you pick this one up?

On Sat, Jan 09, 2021 at 12:13:32PM +0100, Christoph Hellwig wrote:
> truncate_bdev_range is only used in always built-in block layer code,
> so remove the export and the !CONFIG_BLOCK stub.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/block_dev.c         | 1 -
>  include/linux/blkdev.h | 9 ++-------
>  2 files changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/block_dev.c b/fs/block_dev.c
> index 3e5b02f6606c42..41a9b0cb2d8a16 100644
> --- a/fs/block_dev.c
> +++ b/fs/block_dev.c
> @@ -126,7 +126,6 @@ int truncate_bdev_range(struct block_device *bdev, fmode_t mode,
>  		bd_abort_claiming(bdev, truncate_bdev_range);
>  	return 0;
>  }
> -EXPORT_SYMBOL(truncate_bdev_range);
>  
>  static void set_init_blocksize(struct block_device *bdev)
>  {
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index f94ee3089e015e..22fc4f3141d555 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -2012,21 +2012,16 @@ void bdev_add(struct block_device *bdev, dev_t dev);
>  struct block_device *I_BDEV(struct inode *inode);
>  struct block_device *bdgrab(struct block_device *bdev);
>  void bdput(struct block_device *);
> +int truncate_bdev_range(struct block_device *bdev, fmode_t mode, loff_t lstart,
> +		loff_t lend);
>  
>  #ifdef CONFIG_BLOCK
>  void invalidate_bdev(struct block_device *bdev);
> -int truncate_bdev_range(struct block_device *bdev, fmode_t mode, loff_t lstart,
> -			loff_t lend);
>  int sync_blockdev(struct block_device *bdev);
>  #else
>  static inline void invalidate_bdev(struct block_device *bdev)
>  {
>  }
> -static inline int truncate_bdev_range(struct block_device *bdev, fmode_t mode,
> -				      loff_t lstart, loff_t lend)
> -{
> -	return 0;
> -}
>  static inline int sync_blockdev(struct block_device *bdev)
>  {
>  	return 0;
> -- 
> 2.29.2
---end quoted text---
