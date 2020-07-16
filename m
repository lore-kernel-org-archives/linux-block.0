Return-Path: <SRS0=Ci6H=A3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D74D4C433E2
	for <linux-block@archiver.kernel.org>; Thu, 16 Jul 2020 14:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5C0A206F4
	for <linux-block@archiver.kernel.org>; Thu, 16 Jul 2020 14:33:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rLYHFdOd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728345AbgGPOdQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Jul 2020 10:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727844AbgGPOdP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Jul 2020 10:33:15 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA8A1C061755
        for <linux-block@vger.kernel.org>; Thu, 16 Jul 2020 07:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=WbJncdurVVf0z70ZOfQahFzc+lpUBewmye/8KNALHHU=; b=rLYHFdOdN5xvl9Mlpxi6FkrgZV
        wCO974N+vj68r5FC8NNYVmHP/HVEAYggffgz5TvYGMt6RmBKdHb//n0QNTRLqPT8gOLbkuq3/4qqu
        pvorkBf47LXUYUARQ826fDk0cUFKZS7GHnK5NgGXPnCXnlPCMO2uYxcc2iHe5wVSoJUY49tl+IWpQ
        O8RCQ2LvunNntCt4LziqdMwOCGm/bis5sp9yMl7H2CzbmHrmHxyr0BljN1x3Bb96Gu4+6d4Z5xhFy
        XXT6meMFIhuoipN4RIIGtgLchYggZgUMGpuhup9vPj2dvJi6hWzdBmgMtHBqptGUfao3a1PcRfs6s
        t0NU3dVw==;
Received: from [2001:4bb8:105:4a81:1bd9:4dba:216e:37b8] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jw4wj-0000C1-9j; Thu, 16 Jul 2020 14:33:13 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tejun Heo <tj@kernel.org>, linux-block@vger.kernel.org
Subject: [PATCH 1/4] block: simplify the restart case in __blkdev_get
Date:   Thu, 16 Jul 2020 16:33:07 +0200
Message-Id: <20200716143310.473136-2-hch@lst.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200716143310.473136-1-hch@lst.de>
References: <20200716143310.473136-1-hch@lst.de>
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
index a36d5b6907ea4e..376832250c8e91 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1517,7 +1517,7 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, int for_part)
 	int ret;
 	int partno;
 	int perm = 0;
-	bool first_open = false;
+	bool first_open = false, need_restart;
 
 	if (mode & FMODE_READ)
 		perm |= MAY_READ;
@@ -1533,7 +1533,7 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, int for_part)
 	}
 
  restart:
-
+	need_restart = false;
 	ret = -ENXIO;
 	disk = bdev_get_gendisk(bdev, &partno);
 	if (!disk)
@@ -1556,19 +1556,12 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, int for_part)
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
@@ -1647,6 +1640,8 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, int for_part)
 	mutex_unlock(&bdev->bd_mutex);
 	disk_unblock_events(disk);
 	put_disk_and_module(disk);
+	if (need_restart)
+		goto restart;
  out:
 
 	return ret;
-- 
2.27.0

