Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3694AC4332F
	for <linux-block@archiver.kernel.org>; Mon, 30 Oct 2023 14:46:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231919AbjJ3Oqc convert rfc822-to-8bit (ORCPT
        <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 Oct 2023 10:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231598AbjJ3Oqb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Oct 2023 10:46:31 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E16BC6
        for <linux-block@vger.kernel.org>; Mon, 30 Oct 2023 07:46:27 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 24DF36340E17;
        Mon, 30 Oct 2023 15:46:26 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 83_rsuiJP0iL; Mon, 30 Oct 2023 15:46:25 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id ABA436340DE6;
        Mon, 30 Oct 2023 15:46:25 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id F8QdIGKLfYwY; Mon, 30 Oct 2023 15:46:25 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 830996342D49;
        Mon, 30 Oct 2023 15:46:25 +0100 (CET)
Date:   Mon, 30 Oct 2023 15:46:25 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     hch <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-block <linux-block@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        zhongjinghua@huawei.com, yukuai1@huaweicloud.com
Message-ID: <400425098.23787.1698677185386.JavaMail.zimbra@nod.at>
In-Reply-To: <20231030140106.1393384-1-hch@lst.de>
References: <20231030140106.1393384-1-hch@lst.de>
Subject: Re: [PATCH 1/2] ubi: block: don't use gendisk->first_minor for the
 idr_alloc return value
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: block: don't use gendisk->first_minor for the idr_alloc return value
Thread-Index: z+akUlFSTPw9+Ic4xTj+k92LkiWxmQ==
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

----- Ursprüngliche Mail -----
> idr_alloc returns an int that is either a negative errno, or the
> identifier actually allocated.  Use signed integer ret variable to
> catch the return value and only assign it to gd->first_minor to prepare
> for marking the first_minor field in the gendisk structure as unsigned.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
> drivers/mtd/ubi/block.c | 5 +++--
> 1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mtd/ubi/block.c b/drivers/mtd/ubi/block.c
> index 437c5b83ffe513..51d00b518d3197 100644
> --- a/drivers/mtd/ubi/block.c
> +++ b/drivers/mtd/ubi/block.c
> @@ -402,13 +402,14 @@ int ubiblock_create(struct ubi_volume_info *vi)
> 	gd->fops = &ubiblock_ops;
> 	gd->major = ubiblock_major;
> 	gd->minors = 1;
> -	gd->first_minor = idr_alloc(&ubiblock_minor_idr, dev, 0, 0, GFP_KERNEL);
> -	if (gd->first_minor < 0) {
> +	ret = idr_alloc(&ubiblock_minor_idr, dev, 0, 0, GFP_KERNEL);
> +	if (ret < 0) {
> 		dev_err(disk_to_dev(gd),
> 			"block: dynamic minor allocation failed");
> 		ret = -ENODEV;
> 		goto out_cleanup_disk;
> 	}
> +	gd->first_minor  = ret;

Super minor nit, redundant space.

Acked-by: Richard Weinberger <richard@nod.at>

Thanks,
//richard
