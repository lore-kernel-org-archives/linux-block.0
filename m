Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C95FC64EC4
	for <linux-block@archiver.kernel.org>; Mon,  6 Mar 2023 18:02:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbjCFSCb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 Mar 2023 13:02:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbjCFSC2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 Mar 2023 13:02:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 674856C8A4
        for <linux-block@vger.kernel.org>; Mon,  6 Mar 2023 10:02:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E8EABB81061
        for <linux-block@vger.kernel.org>; Mon,  6 Mar 2023 18:01:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 255ADC433D2;
        Mon,  6 Mar 2023 18:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678125680;
        bh=8+fX0DQF7AxWUzkAE7WOfShZIM9RFn5tL/qhNPkcHOs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fIwlz33RQfCI3MpSLUONo434fr2B/bgKX+x8s2H24pDXYTXGlwTQzbqTEaMDrCam3
         gaX1hxFWn6DzvE83Aui9k2b975FVUplwi9/RbAixgoqWMSce1ljaSUbO4VaWUN1UuY
         yVjGiGUNQux8WlvdjPGJ28szrKV2Un+CC+Hja5GE/WmVZu5hRG/5EusuQc9pHbTKRo
         iM5cg3ZcSSIbPAklXa1KqmsRLTmRYoErshqDfWPWncmlmGG04L++thYqS/l8lBzWBF
         cWOWE1qzEgJVL4Yk/yGC/IAprqiObsdnN1OX/z7rX2G4JAt8toBQDhlcgTadSU9YNO
         6QCxEbx/DHd9A==
Date:   Mon, 6 Mar 2023 11:01:17 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH 4/5] brd: limit maximal block size to 32M
Message-ID: <ZAYqbUEdGAD6rsp4@kbusch-mbp.dhcp.thefacebook.com>
References: <20230306120127.21375-1-hare@suse.de>
 <20230306120127.21375-5-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230306120127.21375-5-hare@suse.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Mar 06, 2023 at 01:01:26PM +0100, Hannes Reinecke wrote:
> Use an arbitrary limit of 32M for the maximal blocksize so as not
> to overflow the page cache.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>  drivers/block/brd.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/block/brd.c b/drivers/block/brd.c
> index 11bac3c3f1b6..1ed114cd5cb0 100644
> --- a/drivers/block/brd.c
> +++ b/drivers/block/brd.c
> @@ -348,6 +348,7 @@ static int max_part = 1;
>  module_param(max_part, int, 0444);
>  MODULE_PARM_DESC(max_part, "Num Minors to reserve between devices");
>  
> +#define RD_MAX_SECTOR_SIZE 65536
>  static unsigned int rd_blksize = PAGE_SIZE;
>  module_param(rd_blksize, uint, 0444);
>  MODULE_PARM_DESC(rd_blksize, "Blocksize of each RAM disk in bytes.");
> @@ -410,15 +411,14 @@ static int brd_alloc(int i)
>  	disk->private_data	= brd;
>  	strscpy(disk->disk_name, buf, DISK_NAME_LEN);
>  	set_capacity(disk, rd_size * 2);
> -	
> -	/*
> -	 * This is so fdisk will align partitions on 4k, because of
> -	 * direct_access API needing 4k alignment, returning a PFN
> -	 * (This is only a problem on very small devices <= 4M,
> -	 *  otherwise fdisk will align on 1M. Regardless this call
> -	 *  is harmless)
> -	 */
> +
> +	if (rd_blksize > RD_MAX_SECTOR_SIZE) {

rd_blkside is in bytes, but the above is ccomapring it to something in units of
SECTOR_SIZE.

> +		/* Arbitrary limit maximum block size to 32M */
> +		err = -EINVAL;
> +		goto out_cleanup_disk;
> +	}

rd_blksize also needs to be >= 512, and a power of 2.

>  	blk_queue_physical_block_size(disk->queue, rd_blksize);
> +	blk_queue_max_hw_sectors(disk->queue, RD_MAX_SECTOR_SIZE);
>  
>  	/* Tell the block layer that this is not a rotational device */
>  	blk_queue_flag_set(QUEUE_FLAG_NONROT, disk->queue);
