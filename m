Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76610C77B71
	for <linux-block@archiver.kernel.org>; Sat, 15 Apr 2023 02:44:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbjDOCoB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 Apr 2023 22:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjDOCoA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Apr 2023 22:44:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84AF73ABC
        for <linux-block@vger.kernel.org>; Fri, 14 Apr 2023 19:43:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1E6986111C
        for <linux-block@vger.kernel.org>; Sat, 15 Apr 2023 02:43:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18245C433EF;
        Sat, 15 Apr 2023 02:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681526638;
        bh=hSxZeE+NsCKPs/EuUwNXBIGOPMv+a0oopsBYdPsrkqk=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=AzDtR7Zbbep2un2/8PLc4alFfYP6YO/9jdg+3xwFrP8fAwomOAD0fqN6S2920u19z
         dsYYJ1LcfXvNvltoe95bj+4fq8TvoA5SqvPLPcgLToFR8N5vFPt3B8n+8NwL2T84IT
         MnhzxIWbAWXdRpFS6XpSKBIYY2peyyfu8i2HnMN09yc7eeuL4TAllliwbyqVoabI96
         eq1ZneQhPTZL0ucbFqV3sPLozSW4WPIb2lN/NoUT+RKFbtQYmOTJBV5Bil9VYl1eQ6
         uaUm6uz/DV/vfgHCEMAXFTosKyb4P32PblacdiZJWOa+ejelxXZTrMsXp47G3Ycu5J
         XSeZrGJV67KhA==
Message-ID: <61ee258c-b330-ba93-cab5-83e7bd9cd105@kernel.org>
Date:   Sat, 15 Apr 2023 11:43:56 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 2/2] block: store bdev->bd_disk->fops->submit_bio state in
 bdev
Content-Language: en-US
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
References: <20230414134848.91563-1-axboe@kernel.dk>
 <20230414134848.91563-3-axboe@kernel.dk>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230414134848.91563-3-axboe@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/14/23 22:48, Jens Axboe wrote:
> We have a long chain of memory dereferencing just to whether or not
> this disk has a special submit_bio helper. As that's not necessarily
> the common case, add a bd_submit_bio state in the bdev to avoid
> traversing this memory dependency chain if we don't need to.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>  block/bdev.c              | 1 +
>  block/blk-core.c          | 8 ++++----
>  block/genhd.c             | 4 ++++
>  include/linux/blk_types.h | 1 +
>  4 files changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/block/bdev.c b/block/bdev.c
> index 1795c7d4b99e..31a5d25b2b44 100644
> --- a/block/bdev.c
> +++ b/block/bdev.c
> @@ -419,6 +419,7 @@ struct block_device *bdev_alloc(struct gendisk *disk, u8 partno)
>  	bdev->bd_inode = inode;
>  	bdev->bd_queue = disk->queue;
>  	bdev->bd_stats = alloc_percpu(struct disk_stats);
> +	bdev->bd_submit_bio = 0;

"= false;" would be better to match bd_submit_bio type.

[...]

> diff --git a/block/genhd.c b/block/genhd.c
> index 02d9cfb9e077..07736c5db988 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -420,6 +420,10 @@ int __must_check device_add_disk(struct device *parent, struct gendisk *disk,
>  	 */
>  	elevator_init_mq(disk->queue);
>  
> +	/* Mark bdev as having a submit_bio, if needed */
> +	if (disk->fops->submit_bio)
> +		disk->part0->bd_submit_bio = 1;

"= true;" would be better to match the type.

Note that this could also be:

disk->part0->bd_submit_bio = disk->fops->submit_bio;

thus removing the if.


