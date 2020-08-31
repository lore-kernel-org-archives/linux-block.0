Return-Path: <SRS0=/PDd=CJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10906C433E2
	for <linux-block@archiver.kernel.org>; Mon, 31 Aug 2020 18:13:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDC9E2083E
	for <linux-block@archiver.kernel.org>; Mon, 31 Aug 2020 18:13:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gTKSr0Zw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728844AbgHaSNg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 31 Aug 2020 14:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727058AbgHaSNf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 31 Aug 2020 14:13:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77BAAC061573
        for <linux-block@vger.kernel.org>; Mon, 31 Aug 2020 11:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=N0P2D65c8qKkDDqHqvqYz4mnNdcwKx2MCBWBXiYwi0A=; b=gTKSr0ZwKklSpD8PbpO91aw6ZJ
        avK6aFWXh9Mklf78NBUid0DbhxYEK4RmgsgAb86SjmK38Z/2w81AywK7BP9+jJUtg91twtfXLFy5h
        VOmuUr7aiZf3ucDVmuC6u717WrWzPu51fPWAABJgqDhR6R5OBywhjbO1xzo6TxDREV5+Wjxrp84iH
        5VON0hLg09n3p1irhpX6Hqz+BMpuR8t2mNsSEpIMAiFWQ9Ndj7LzTPBhd8TouSkXh67isZajxMKQL
        7hX+Tg+++3QiwJRWAfBU6tIb8qMu6k8Vug1VLcO5Z8JJmDCGhr+f5HhpGl8bYdut1YLWVjdhlu9Mv
        prL+H4dQ==;
Received: from 213-225-6-196.nat.highway.a1.net ([213.225.6.196] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kCoJB-0002Ql-U6; Mon, 31 Aug 2020 18:13:34 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 4/7] block: move the devcgroup_inode_permission call to blkdev_get
Date:   Mon, 31 Aug 2020 20:02:36 +0200
Message-Id: <20200831180239.2372776-5-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200831180239.2372776-1-hch@lst.de>
References: <20200831180239.2372776-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

devcgroup_inode_permission is never called for the recusive case, so
move it out into blkdev_get.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/block_dev.c | 36 +++++++++++++++++-------------------
 1 file changed, 17 insertions(+), 19 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 08158bb2e76c85..990e97bcbeaf0d 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1449,22 +1449,8 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, void *holder,
 	struct gendisk *disk;
 	int ret;
 	int partno;
-	int perm = 0;
 	bool first_open = false, unblock_events = true, need_restart;
 
-	if (mode & FMODE_READ)
-		perm |= MAY_READ;
-	if (mode & FMODE_WRITE)
-		perm |= MAY_WRITE;
-	/*
-	 * hooks: /n/, see "layering violations".
-	 */
-	if (!for_part) {
-		ret = devcgroup_inode_permission(bdev->bd_inode, perm);
-		if (ret != 0)
-			return ret;
-	}
-
  restart:
 	need_restart = false;
 	ret = -ENXIO;
@@ -1637,12 +1623,24 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, void *holder,
  */
 int blkdev_get(struct block_device *bdev, fmode_t mode, void *holder)
 {
-	int res;
+	int ret, perm = 0;
 
-	res =__blkdev_get(bdev, mode, holder, 0);
-	if (res)
-		bdput(bdev);
-	return res;
+	if (mode & FMODE_READ)
+		perm |= MAY_READ;
+	if (mode & FMODE_WRITE)
+		perm |= MAY_WRITE;
+	ret = devcgroup_inode_permission(bdev->bd_inode, perm);
+	if (ret)
+		goto bdput;
+
+	ret =__blkdev_get(bdev, mode, holder, 0);
+	if (ret)
+		goto bdput;
+	return 0;
+
+bdput:
+	bdput(bdev);
+	return ret;
 }
 EXPORT_SYMBOL(blkdev_get);
 
-- 
2.28.0

