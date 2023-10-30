Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E5BC4332F
	for <linux-block@archiver.kernel.org>; Mon, 30 Oct 2023 14:06:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233512AbjJ3OGE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 Oct 2023 10:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233589AbjJ3OGD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Oct 2023 10:06:03 -0400
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23DE0ED
        for <linux-block@vger.kernel.org>; Mon, 30 Oct 2023 07:05:28 -0700 (PDT)
Received: from local
        by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96.2)
        (envelope-from <daniel@makrotopia.org>)
        id 1qxStJ-0006QX-0b;
        Mon, 30 Oct 2023 14:05:17 +0000
Date:   Mon, 30 Oct 2023 14:05:14 +0000
From:   Daniel Golle <daniel@makrotopia.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, richard@nod.at, miquel.raynal@bootlin.com,
        vigneshr@ti.com, linux-block@vger.kernel.org,
        linux-mtd@lists.infradead.org, zhongjinghua@huawei.com,
        yukuai1@huaweicloud.com
Subject: Re: [PATCH 1/2] ubi: block: don't use gendisk->first_minor for the
 idr_alloc return value
Message-ID: <ZT-4GlwthnOgEhqc@makrotopia.org>
References: <20231030140106.1393384-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231030140106.1393384-1-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Oct 30, 2023 at 03:01:05PM +0100, Christoph Hellwig wrote:
> idr_alloc returns an int that is either a negative errno, or the
> identifier actually allocated.  Use signed integer ret variable to
> catch the return value and only assign it to gd->first_minor to prepare
> for marking the first_minor field in the gendisk structure as unsigned.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Daniel Golle <daniel@makrotopia.org>

> ---
>  drivers/mtd/ubi/block.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mtd/ubi/block.c b/drivers/mtd/ubi/block.c
> index 437c5b83ffe513..51d00b518d3197 100644
> --- a/drivers/mtd/ubi/block.c
> +++ b/drivers/mtd/ubi/block.c
> @@ -402,13 +402,14 @@ int ubiblock_create(struct ubi_volume_info *vi)
>  	gd->fops = &ubiblock_ops;
>  	gd->major = ubiblock_major;
>  	gd->minors = 1;
> -	gd->first_minor = idr_alloc(&ubiblock_minor_idr, dev, 0, 0, GFP_KERNEL);
> -	if (gd->first_minor < 0) {
> +	ret = idr_alloc(&ubiblock_minor_idr, dev, 0, 0, GFP_KERNEL);
> +	if (ret < 0) {
>  		dev_err(disk_to_dev(gd),
>  			"block: dynamic minor allocation failed");
>  		ret = -ENODEV;
>  		goto out_cleanup_disk;
>  	}
> +	gd->first_minor  = ret;
>  	gd->flags |= GENHD_FL_NO_PART;
>  	gd->private_data = dev;
>  	sprintf(gd->disk_name, "ubiblock%d_%d", dev->ubi_num, dev->vol_id);
> -- 
> 2.39.2
> 
