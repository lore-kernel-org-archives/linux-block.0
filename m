Return-Path: <SRS0=iNmo=5T=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA554C43331
	for <linux-block@archiver.kernel.org>; Fri,  3 Apr 2020 06:39:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DC7220757
	for <linux-block@archiver.kernel.org>; Fri,  3 Apr 2020 06:39:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pKdAXqAj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732862AbgDCGj5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Apr 2020 02:39:57 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47036 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730759AbgDCGj5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Apr 2020 02:39:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bW9B1lP0XvAu62P5OjUE495sCbKgpxIMKSif/W1M0FM=; b=pKdAXqAjBugOD+svVrb5Yy+CDU
        UT/IumPJThJnlAd26XkI+OIxigkPYn4xMaMGPio7ticQZ4hlD80NmBZODeRWU0GCz6SA5pHnnsXr3
        06vJtLjDfi9n9XsI3njF2qLnJz/XC6kgeho3pzO+e5J1h+QKh5lUbstbD34XTjVPDKtYDrvZVzAJW
        doYdhOOMv9y8/B0R8JdjRqFQ6C+P6rl7krCa7/6Efbx6gPYwTqS3UeEb9KADrpFYBicqmm+xd7k/H
        eXsOpnmFNCl3FFOdAORSRaFwjdnt+HKiCHktO9VOogPfBliMcBDiw4UYqWPTAq5nhrr1w8n8PEoF6
        wIxrRxDA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jKFzf-0007hQ-7z; Fri, 03 Apr 2020 06:39:55 +0000
Date:   Thu, 2 Apr 2020 23:39:55 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Cc:     evgreen@chromium.org, asavery@chromium.org, axboe@kernel.dk,
        bvanassche@acm.org, darrick.wong@oracle.com, dianders@chromium.org,
        gwendal@chromium.org, hch@infradead.org,
        linux-block@vger.kernel.org, martin.petersen@oracle.com,
        ming.lei@redhat.com, kernel@collabora.com
Subject: Re: [PATCH v8 2/2] loop: Better discard support for block devices
Message-ID: <20200403063955.GB28875@infradead.org>
References: <20200402170603.19649-1-andrzej.p@collabora.com>
 <20200402170603.19649-3-andrzej.p@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200402170603.19649-3-andrzej.p@collabora.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Apr 02, 2020 at 07:06:03PM +0200, Andrzej Pietrasiewicz wrote:
> From: Evan Green <evgreen@chromium.org>
> 
> If the backing device for a loop device is itself a block device,
> then mirror the "write zeroes" capabilities of the underlying
> block device into the loop device. Copy this capability into both
> max_write_zeroes_sectors and max_discard_sectors of the loop device.
> 
> The reason for this is that REQ_OP_DISCARD on a loop device translates
> into blkdev_issue_zeroout(), rather than blkdev_issue_discard(). This
> presents a consistent interface for loop devices (that discarded data
> is zeroed), regardless of the backing device type of the loop device.
> There should be no behavior change for loop devices backed by regular
> files.
> 
> This change fixes blktest block/003, and removes an extraneous
> error print in block/013 when testing on a loop device backed
> by a block device that does not support discard.
> 
> Signed-off-by: Evan Green <evgreen@chromium.org>
> Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
> Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> [used updated version of Evan's comment in loop_config_discard()]
> Signed-off-by: Andrzej Pietrasiewicz <andrzej.p@collabora.com>
> ---
>  drivers/block/loop.c | 41 ++++++++++++++++++++++++++++++-----------
>  1 file changed, 30 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 6969be9a855a..d7f30338b8ec 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -427,11 +427,12 @@ static int lo_fallocate(struct loop_device *lo, struct request *rq, loff_t pos,
>  	 * information.
>  	 */
>  	struct file *file = lo->lo_backing_file;
> +	struct request_queue *q = lo->lo_queue;
>  	int ret;
>  
>  	mode |= FALLOC_FL_KEEP_SIZE;
>  
> -	if ((!file->f_op->fallocate) || lo->lo_encrypt_key_size) {
> +	if (!blk_queue_discard(q)) {
>  		ret = -EOPNOTSUPP;
>  		goto out;
>  	}
> @@ -864,6 +865,22 @@ static void loop_config_discard(struct loop_device *lo)
>  	struct file *file = lo->lo_backing_file;
>  	struct inode *inode = file->f_mapping->host;
>  	struct request_queue *q = lo->lo_queue;
> +	struct request_queue *backingq;
> +
> +	/*
> +	 * If the backing device is a block device, mirror its zeroing
> +	 * capability. Set the discard sectors to the block device's zeroing
> +	 * capabilities because loop discards result in blkdev_issue_zeroout(),
> +	 * not blkdev_issue_discard(). This maintains consistent behavior with
> +	 * file-backed loop devices: discarded regions read back as zero.
> +	 */
> +	if (S_ISBLK(inode->i_mode) && !lo->lo_encrypt_key_size) {
> +		backingq = bdev_get_queue(inode->i_bdev);

The backingq could move into this local scope.

> +	} else if ((!file->f_op->fallocate) || lo->lo_encrypt_key_size) {

No need for the inner braces.

But the actual functionality looks good to me.
