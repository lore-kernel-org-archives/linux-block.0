Return-Path: <SRS0=ObBg=6G=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3059DC54FCB
	for <linux-block@archiver.kernel.org>; Wed, 22 Apr 2020 17:40:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BB952082E
	for <linux-block@archiver.kernel.org>; Wed, 22 Apr 2020 17:40:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbgDVRj4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Apr 2020 13:39:56 -0400
Received: from verein.lst.de ([213.95.11.211]:53895 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726060AbgDVRj4 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Apr 2020 13:39:56 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0878E68CEC; Wed, 22 Apr 2020 19:39:52 +0200 (CEST)
Date:   Wed, 22 Apr 2020 19:39:51 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Martijn Coenen <maco@android.com>
Cc:     axboe@kernel.dk, hch@lst.de, ming.lei@redhat.com,
        narayan@google.com, zezeozue@google.com, kernel-team@android.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        maco@google.com, bvanassche@acm.org, Chaitanya.Kulkarni@wdc.com,
        jaegeuk@kernel.org
Subject: Re: [PATCH v2 1/5] loop: Refactor size calculation
Message-ID: <20200422173951.GA30852@lst.de>
References: <20200422100636.46357-1-maco@android.com> <20200422100636.46357-2-maco@android.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422100636.46357-2-maco@android.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Apr 22, 2020 at 12:06:32PM +0200, Martijn Coenen wrote:
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index f1754262fc94..4f5c765c73d8 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -228,23 +228,42 @@ static void __loop_update_dio(struct loop_device *lo, bool dio)
>  		blk_mq_unfreeze_queue(lo->lo_queue);
>  }
>  
> +/**
> + * loop_set_size - sets device size and notifies userspace
> + * @lo: struct loop_device to set the size for
> + * @size: new size of the loop device
> + *
> + * Callers must validate that the size passed into this function fits into
> + * a sector_t.
> + */
> +static void loop_set_size(struct loop_device *lo, loff_t size)
> +{
> +	struct block_device *bdev = lo->lo_device;
> +
> +	set_capacity(lo->lo_disk, size);
> +	bd_set_size(bdev, size << SECTOR_SHIFT);
> +	/* let user-space know about the new size */
> +	kobject_uevent(&disk_to_dev(bdev->bd_disk)->kobj, KOBJ_CHANGE);

I think this should use set_capacity_revalidate_and_notify, although
that probably should be a separate patch.

Also I'm having a bit of a hard time following all the different changes
(even if the all look good).  Maybe at least the loop_set_size
factoring should be split into another separate prep patch.

> +/**
> + * loop_update_size - updates device size from the backing file
> + * @lo: struct loop_device to update the size for
> + *
> + * Recomputes the device size from the backing file, and updates the device
> + * with the new size.
> + */
>  static int
> -figure_loop_size(struct loop_device *lo, loff_t offset, loff_t sizelimit)
> +loop_update_size(struct loop_device *lo)
>  {
> +	loff_t size = get_loop_size(lo, lo->lo_backing_file);
>  	sector_t x = (sector_t)size;
>  
>  	if (unlikely((loff_t)x != size))
>  		return -EFBIG;
> +
> +	loop_set_size(lo, size);
> +
>  	return 0;
>  }

With all the other nice helper, I think this can actually be open coded
in the caller.  Another useful helper would be one that checks for the
size truncation, as that is duplicated in a few places.
