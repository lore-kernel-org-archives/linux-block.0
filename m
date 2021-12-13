Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CA9CC433F5
	for <linux-block@archiver.kernel.org>; Mon, 13 Dec 2021 17:11:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240646AbhLMRLT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 13 Dec 2021 12:11:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236185AbhLMRLS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 Dec 2021 12:11:18 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 338AEC061574
        for <linux-block@vger.kernel.org>; Mon, 13 Dec 2021 09:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=hIBBX89mgsZzRBjzf/5bcBtwNfjkbeOufbk1YWyOG4Y=; b=RFyxSzlKjIMGVjLKosq+8fQ/Qk
        QXWPIIrtArgtZzBC9/IJXveyQBS709YEJWXg9H513C0D0G7mzde0yKdZAIZ6KPYoJoOocEFXJkDUy
        A9pKzq4kvgxQS3gsmSere6etw8opG2NgxJlTllEF6ePfqWwpJ8+t5ACpCijk6kVNNz+QBEp1287rc
        5XROGNZZ1XV33Cmo/ij2V7KLLKnQ+e6xwoaCI4GL7d+XYB6DF7eztKR3f3qcE1rWCU0OwMD5vnJ5v
        EquWEUWsH4+MogIf1VkY0eLltXHd/ZxzLp1joRV0szgL0I+8ZFPhWbTWY1jONuDsLLg/L6KNSV7RK
        xoEQ2wrg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mwor6-00Czqj-6o; Mon, 13 Dec 2021 17:11:16 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] bdev: Improve lookup_bdev documentation
Date:   Mon, 13 Dec 2021 17:11:13 +0000
Message-Id: <20211213171113.3097631-1-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add a Context section and rewrite the rest to be clearer.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 block/bdev.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index b1d087e5e205..b4780c211222 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -963,15 +963,15 @@ void blkdev_put(struct block_device *bdev, fmode_t mode)
 EXPORT_SYMBOL(blkdev_put);
 
 /**
- * lookup_bdev  - lookup a struct block_device by name
- * @pathname:	special file representing the block device
- * @dev:	return value of the block device's dev_t
+ * lookup_bdev() - Look up a struct block_device by name.
+ * @pathname: Name of the block device in the filesystem.
+ * @dev: Pointer to the block device's dev_t, if found.
  *
  * Lookup the block device's dev_t at @pathname in the current
- * namespace if possible and return it by @dev.
+ * namespace if possible and return it in @dev.
  *
- * RETURNS:
- * 0 if succeeded, errno otherwise.
+ * Context: May sleep.
+ * Return: 0 if succeeded, negative errno otherwise.
  */
 int lookup_bdev(const char *pathname, dev_t *dev)
 {
-- 
2.33.0

