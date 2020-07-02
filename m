Return-Path: <SRS0=sMug=AN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9318CC433E0
	for <linux-block@archiver.kernel.org>; Thu,  2 Jul 2020 08:49:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69A7720884
	for <linux-block@archiver.kernel.org>; Thu,  2 Jul 2020 08:49:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QRLMMTFs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbgGBItY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Jul 2020 04:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725287AbgGBItY (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Jul 2020 04:49:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D2F9C08C5C1
        for <linux-block@vger.kernel.org>; Thu,  2 Jul 2020 01:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=A/I1vcnEOWPovRd4d32sgJlzY0F1UatPERDEAW8X52Y=; b=QRLMMTFsc/svpBXpLjllssJp1+
        whFAtpb9cPFE4gbAjV4byQETZOpwy3yZvBZ4JIJBVXghoI94dPMpwNB4OCJgn9TMwUK+2SrfNdG1V
        jg3MUWomq0PB6yRCaGhCr3y9oLJ+gd9mVmb4/xJOpZI30a6+amM0i0x6vyu4EkFzsFSDUXxz2jg4A
        F7S74CrHKkNuDx6oSX9Z+zzkQMWfwAovDr3STOEhc/o72IJYGP43Rn3Kk+hIITZeGRUqM2denlMIY
        dPyCwGA4swE1ZlBFvgC+GlREIv7cpBDa1rO6rY2q3SDKfs7hv0wuRNiBsJSOOq4Py/8LJXcuMmvRO
        wWj4GAuA==;
Received: from [213.208.157.36] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jquuH-0001VR-Ql; Thu, 02 Jul 2020 08:49:22 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tejun Heo <tj@kernel.org>, linux-block@vger.kernel.org
Subject: [PATCH 1/4] block: simplify the restart case in __blkdev_get
Date:   Thu,  2 Jul 2020 10:49:16 +0200
Message-Id: <20200702084919.3720275-2-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200702084919.3720275-1-hch@lst.de>
References: <20200702084919.3720275-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Insted of duplicating all the cleanup logic jump to the code that cleans
up anyway, and restart after that.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/block_dev.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 2d2fcb50e78eac..175161359664ca 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1533,7 +1533,7 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, int for_part)
 	int ret;
 	int partno;
 	int perm = 0;
-	bool first_open = false;
+	bool first_open = false, need_restart;
 
 	if (mode & FMODE_READ)
 		perm |= MAY_READ;
@@ -1549,7 +1549,7 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, int for_part)
 	}
 
  restart:
-
+	need_restart = false;
 	ret = -ENXIO;
 	disk = bdev_get_gendisk(bdev, &partno);
 	if (!disk)
@@ -1572,19 +1572,12 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, int for_part)
 			ret = 0;
 			if (disk->fops->open) {
 				ret = disk->fops->open(bdev, mode);
-				if (ret == -ERESTARTSYS) {
-					/* Lost a race with 'disk' being
-					 * deleted, try again.
-					 * See md.c
-					 */
-					disk_put_part(bdev->bd_part);
-					bdev->bd_part = NULL;
-					bdev->bd_disk = NULL;
-					mutex_unlock(&bdev->bd_mutex);
-					disk_unblock_events(disk);
-					put_disk_and_module(disk);
-					goto restart;
-				}
+				/*
+				 * If we lost a race with 'disk' being deleted,
+				 * try again.  See md.c
+				 */
+				if (ret == -ERESTARTSYS)
+					need_restart = true;
 			}
 
 			if (!ret) {
@@ -1663,6 +1656,8 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, int for_part)
 	mutex_unlock(&bdev->bd_mutex);
 	disk_unblock_events(disk);
 	put_disk_and_module(disk);
+	if (need_restart)
+		goto restart;
  out:
 
 	return ret;
-- 
2.26.2

