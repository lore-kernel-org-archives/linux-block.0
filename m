Return-Path: <linux-block-owner@vger.kernel.org>
Received: from LGEAMRELO13.lge.com ([156.147.23.53]:48118 "EHLO
        lgeamrelo13.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752363AbdCGGJL (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Mar 2017 01:09:11 -0500
Date: Tue, 7 Mar 2017 14:22:42 +0900
From: Minchan Kim <minchan@kernel.org>
To: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Jens Axboe <axboe@fb.com>, Nitin Gupta <ngupta@vflare.org>,
        Christoph Hellwig <hch@lst.de>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Hannes Reinecke <hare@suse.de>, yizhan@redhat.com,
        Linux Block Layer Mailinglist <linux-block@vger.kernel.org>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] zram: set physical queue limits to avoid array out of
 bounds accesses
Message-ID: <20170307052242.GA29458@bbox>
References: <20170306102335.9180-1-jthumshirn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170306102335.9180-1-jthumshirn@suse.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hello Johannes,

On Mon, Mar 06, 2017 at 11:23:35AM +0100, Johannes Thumshirn wrote:
> zram can handle at most SECTORS_PER_PAGE sectors in a bio's bvec. When using
> the NVMe over Fabrics loopback target which potentially sends a huge bulk of
> pages attached to the bio's bvec this results in a kernel panic because of
> array out of bounds accesses in zram_decompress_page().

First of all, thanks for the report and fix up!
Unfortunately, I'm not familiar with that interface of block layer.

It seems this is a material for stable so I want to understand it clear.
Could you say more specific things to educate me?

What scenario/When/How it is problem?  It will help for me to understand!

Thanks.

> 
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
> ---
>  drivers/block/zram/zram_drv.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> index e27d89a..dceb5ed 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -1189,6 +1189,8 @@ static int zram_add(void)
>  	blk_queue_io_min(zram->disk->queue, PAGE_SIZE);
>  	blk_queue_io_opt(zram->disk->queue, PAGE_SIZE);
>  	zram->disk->queue->limits.discard_granularity = PAGE_SIZE;
> +	zram->disk->queue->limits.max_sectors = SECTORS_PER_PAGE;
> +	zram->disk->queue->limits.chunk_sectors = 0;
>  	blk_queue_max_discard_sectors(zram->disk->queue, UINT_MAX);
>  	/*
>  	 * zram_bio_discard() will clear all logical blocks if logical block
> -- 
> 1.8.5.6
> 
