Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9AAEC433B4
	for <linux-block@archiver.kernel.org>; Mon, 12 Apr 2021 08:03:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 757786120B
	for <linux-block@archiver.kernel.org>; Mon, 12 Apr 2021 08:03:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236808AbhDLIDj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 12 Apr 2021 04:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbhDLIDj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Apr 2021 04:03:39 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A254C061574
        for <linux-block@vger.kernel.org>; Mon, 12 Apr 2021 01:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=JrnFi4ncJ3q6klF1Ad8vLS0Q/BEpANsNZY5rJgYc9cM=; b=yjlsAa9X5siSq2/skB57EX0ZdV
        BtwnEOQBSTevirrBFwb54r/VD95ikAdZFRiKQQfs5fO5KvX7QvvgG7ynjSLKv/NgAEyD1Xd3ooTPU
        HzuK4/sZflNosJsTPJo/aj2dKd/pdtFLGjGyj6KYr83VuB8VBAQTGvXtF9Hcn85zGNSM96jPToToa
        cZe0bZhwOxhj8IEFukbMkxpm9o8RKK5P+64Gm6C7O+tzqPK7oI5Kmfk8tIRKb0gHcrHr2C5DExnJc
        5wxJq77tiCmCSYXVggwQMnMAxhkzRcmSv6nfANnBhKmThDqgeo38iBvjU53YRkkXIw2rJ+4+B12/U
        XhN+O1aw==;
Received: from [2001:4bb8:199:e2bd:3218:1918:85d1:2852] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lVrXU-005xIF-JZ; Mon, 12 Apr 2021 08:03:21 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH for-5.13/drivers] block: remove the -ERESTARTSYS handling in blkdev_get_by_dev
Date:   Mon, 12 Apr 2021 10:03:18 +0200
Message-Id: <20210412080318.2583748-1-hch@lst.de>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Now that md has been cleaned up we can get rid of this hack.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/block_dev.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index ae16054cb08c6d..d726d20ffd22ce 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1436,10 +1436,6 @@ struct block_device *blkdev_get_by_dev(dev_t dev, fmode_t mode, void *holder)
 	if (ret)
 		return ERR_PTR(ret);
 
-	/*
-	 * If we lost a race with 'disk' being deleted, try again.  See md.c.
-	 */
-retry:
 	bdev = blkdev_get_no_open(dev);
 	if (!bdev)
 		return ERR_PTR(-ENXIO);
@@ -1486,8 +1482,6 @@ struct block_device *blkdev_get_by_dev(dev_t dev, fmode_t mode, void *holder)
 	disk_unblock_events(disk);
 put_blkdev:
 	blkdev_put_no_open(bdev);
-	if (ret == -ERESTARTSYS)
-		goto retry;
 	return ERR_PTR(ret);
 }
 EXPORT_SYMBOL(blkdev_get_by_dev);
-- 
2.30.1

