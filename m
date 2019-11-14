Return-Path: <SRS0=aEt0=ZG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E7C1C432C3
	for <linux-block@archiver.kernel.org>; Thu, 14 Nov 2019 14:34:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D0ED2070E
	for <linux-block@archiver.kernel.org>; Thu, 14 Nov 2019 14:34:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gx6A+FwU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbfKNOe5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Nov 2019 09:34:57 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:38578 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbfKNOe5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Nov 2019 09:34:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=XyqchAItBPg2DuiomEGoMwutQ/Jwb24FTVfbMm/dTEA=; b=gx6A+FwUmTxb8Eb60qaIAffUTX
        3SRg20S88OYG7plxD6zc6rIbTxBsZJLTqYoa5aoFLlQwZjAgUwkA79AByXSY6iPQeTDncwHGeTGYx
        uf+y6hh8TsV8A5d8KF39Ym+3kD4GgZYmu83oCaUHBRsW/Oqv9n6tzbxIlBrVO/viLsOSrLWuXsPFX
        zX09RzqSmEVLRXyRVhTqBCol5Em8rHtkcmFzeXB+s9xXyYlrXPEb3VA3bWvjQxm9d2IBE35yyEYWo
        /oTwPBbJx762VKGS/8IFoCH2mSzyv+IcsKmf9St+KSe0lrMozDe1PVgvf+XtaD5F+zv/z1arW8sI+
        +DsuGQlg==;
Received: from [2001:4bb8:180:3806:c70:4a89:bc61:6] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iVGD1-0004l5-Vn; Thu, 14 Nov 2019 14:34:56 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>
Cc:     linux-block@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 6/7] block: move clearing bd_invalidated into check_disk_size_change
Date:   Thu, 14 Nov 2019 15:34:37 +0100
Message-Id: <20191114143438.14681-7-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191114143438.14681-1-hch@lst.de>
References: <20191114143438.14681-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Both callers of check_disk_size_change clear bd_invalidate directly
after the call, so move the clearing into check_disk_size_change
itself.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/block_dev.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 9558a2f064b1..ee63c2732fa2 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1433,6 +1433,7 @@ static void check_disk_size_change(struct gendisk *disk,
 		if (bdev_size > disk_size)
 			flush_disk(bdev, false);
 	}
+	bdev->bd_invalidated = 0;
 }
 
 /**
@@ -1462,7 +1463,6 @@ int revalidate_disk(struct gendisk *disk)
 
 		mutex_lock(&bdev->bd_mutex);
 		check_disk_size_change(disk, bdev, ret == 0);
-		bdev->bd_invalidated = 0;
 		mutex_unlock(&bdev->bd_mutex);
 		bdput(bdev);
 	}
@@ -1526,7 +1526,6 @@ int bdev_disk_changed(struct block_device *bdev, bool invalidate)
 		disk->fops->revalidate_disk(disk);
 
 	check_disk_size_change(disk, bdev, !invalidate);
-	bdev->bd_invalidated = 0;
 
 	if (get_capacity(disk)) {
 		ret = blk_add_partitions(disk, bdev);
-- 
2.20.1

