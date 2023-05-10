Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADB49C7EE22
	for <linux-block@archiver.kernel.org>; Wed, 10 May 2023 13:27:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237077AbjEJN14 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 May 2023 09:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237085AbjEJN1z (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 May 2023 09:27:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D0A4206
        for <linux-block@vger.kernel.org>; Wed, 10 May 2023 06:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gBDfQ5t+yEsJ49KJ0jUoM8X7ITo4U7Z6BZcKVEoWb6c=; b=kkD3VwIp5v1cD/exTGOsTAbGVk
        +LIVNoO/6pvuiJEezCELX4TJEHmecnSxhQ84ytfOijGkIglKBpGrFem4PYG3A6fUgQTpXv0jIHtC3
        yPPrbjU6bK1PLc/3B7AvxGFymWqoG83bQYjGe3DMRq5n4/3Xrv5ZxdTC5BuExCq/69mspx66lzx++
        Ui+jZH/G4QcrHanDMrvGevsXNQgKMnz4UEy3eCI/EEziKJN4BWPaDAYGW3/7D9H8CozHtmvpuaeUF
        Q4KIMri9KRD4m53DMf5h4CIwAuMhmSFDe82xUJ4kABhNfiXJaioD1hBRV8JdEis/vbnJgMrmAtApr
        tyx1ykGQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pwjrB-006EMM-1P;
        Wed, 10 May 2023 13:27:49 +0000
Date:   Wed, 10 May 2023 06:27:49 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Loic Poulain <loic.poulain@linaro.org>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org
Subject: Re: [PATCH] block: Deny writable memory mapping if block is read-only
Message-ID: <ZFub1U5f1qR5hOwX@infradead.org>
References: <20230510074223.991297-1-loic.poulain@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230510074223.991297-1-loic.poulain@linaro.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 10, 2023 at 09:42:23AM +0200, Loic Poulain wrote:
> User should not be able to write block device if it is read-only at
> block level (e.g force_ro attribute). This is ensured in the regular
> fops write operation (blkdev_write_iter) but not when writing via
> user mapping (mmap), allowing user to actually write a read-only
> block device via a PROT_WRITE mapping.
> 
> Example: This can lead to integrity issue of eMMC boot partition
> (e.g mmcblk0boot0) which is read-only by default.
> 
> To fix this issue, simply deny shared writable mapping if the block
> is readonly.
> 
> Note: Block remains writable if switch to read-only is performed
> after the initial mapping, but this is expected behavior according
> to commit a32e236eb93e ("Partially revert "block: fail op_is_write()
> requests to read-only partitions"")'.

We should not be able to every mmap something (shared-)writable if the
file descriptor.

And ... we don't failed writable opens for block devices ?!?

Something like this is what we would need, but I really need to look
into the history of this whole thing a bit more:


diff --git a/block/bdev.c b/block/bdev.c
index 1795c7d4b99efa..6dd6045672b8bf 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -724,6 +724,11 @@ struct block_device *blkdev_get_by_dev(dev_t dev, fmode_t mode, void *holder)
 		return ERR_PTR(-ENXIO);
 	disk = bdev->bd_disk;
 
+	if ((mode & FMODE_WRITE) && bdev_read_only(bdev)) {
+		ret = -EACCES;
+		goto put_blkdev;
+	}
+
 	if (mode & FMODE_EXCL) {
 		ret = bd_prepare_to_claim(bdev, holder);
 		if (ret)
@@ -798,7 +803,6 @@ EXPORT_SYMBOL(blkdev_get_by_dev);
 struct block_device *blkdev_get_by_path(const char *path, fmode_t mode,
 					void *holder)
 {
-	struct block_device *bdev;
 	dev_t dev;
 	int error;
 
@@ -806,13 +810,7 @@ struct block_device *blkdev_get_by_path(const char *path, fmode_t mode,
 	if (error)
 		return ERR_PTR(error);
 
-	bdev = blkdev_get_by_dev(dev, mode, holder);
-	if (!IS_ERR(bdev) && (mode & FMODE_WRITE) && bdev_read_only(bdev)) {
-		blkdev_put(bdev, mode);
-		return ERR_PTR(-EACCES);
-	}
-
-	return bdev;
+	return blkdev_get_by_dev(dev, mode, holder);
 }
 EXPORT_SYMBOL(blkdev_get_by_path);
 
