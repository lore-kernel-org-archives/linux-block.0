Return-Path: <SRS0=7dNq=DE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A204C4346E
	for <linux-block@archiver.kernel.org>; Sun, 27 Sep 2020 07:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1243023899
	for <linux-block@archiver.kernel.org>; Sun, 27 Sep 2020 07:11:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qWk3kR+j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbgI0HLS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 27 Sep 2020 03:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726311AbgI0HLS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 27 Sep 2020 03:11:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 450ABC0613CE
        for <linux-block@vger.kernel.org>; Sun, 27 Sep 2020 00:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=GF29ddvUDQRmo+QBlS3oADycQnacX4BmB6VR6eIx0uc=; b=qWk3kR+jTVCZ1AL/pkGJvbGrWa
        hf4IMpNbZBhB95yVdRnD2fPgix5XWNS4wu8EsdiTKjCivpEByrFLzNchd6k/bNnK6C97cktKk5lG9
        +qhaSMV56fRM2R7x9Z8OppWBrIyrvIYUm3A+PNdUuaaN3h5jN0MQQlNBtcJZFS25qXh4nAjWO6MPy
        MxOsSn17p1zmC/DNq6HaD3txM9xNEv6qLOw4WlXHzW72FfjNcqk4voWwVPYaN9AEiBcBaj4H4IklB
        HlueQdeIAd5eJIOQZRDbdmdjQIjuwjSLXIaTgFC/dlUAxEq7Hyqa2DjzE4u7sjA43TkiJ7wBDFu65
        o+jYa/wg==;
Received: from [46.189.67.162] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kMQq4-0000W5-2z; Sun, 27 Sep 2020 07:11:16 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH] block: change the hash used for looking up block devices
Date:   Sun, 27 Sep 2020 09:11:15 +0200
Message-Id: <20200927071115.372289-1-hch@lst.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Adding the minor to the major creates tons of pointless conflicts. Just
use the dev_t itself, which is 32-bits and thus is guaranteed to fit
into ino_t.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/block_dev.c | 25 +------------------------
 1 file changed, 1 insertion(+), 24 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 6b9d19ffa5af7b..da7d4868057632 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -870,35 +870,12 @@ void __init bdev_cache_init(void)
 	blockdev_superblock = bd_mnt->mnt_sb;   /* For writeback */
 }
 
-/*
- * Most likely _very_ bad one - but then it's hardly critical for small
- * /dev and can be fixed when somebody will need really large one.
- * Keep in mind that it will be fed through icache hash function too.
- */
-static inline unsigned long hash(dev_t dev)
-{
-	return MAJOR(dev)+MINOR(dev);
-}
-
-static int bdev_test(struct inode *inode, void *data)
-{
-	return BDEV_I(inode)->bdev.bd_dev == *(dev_t *)data;
-}
-
-static int bdev_set(struct inode *inode, void *data)
-{
-	BDEV_I(inode)->bdev.bd_dev = *(dev_t *)data;
-	return 0;
-}
-
 struct block_device *bdget(dev_t dev)
 {
 	struct block_device *bdev;
 	struct inode *inode;
 
-	inode = iget5_locked(blockdev_superblock, hash(dev),
-			bdev_test, bdev_set, &dev);
-
+	inode = iget_locked(blockdev_superblock, dev);
 	if (!inode)
 		return NULL;
 
-- 
2.28.0

