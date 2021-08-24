Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29654C4338F
	for <linux-block@archiver.kernel.org>; Tue, 24 Aug 2021 15:19:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06A8B6128A
	for <linux-block@archiver.kernel.org>; Tue, 24 Aug 2021 15:19:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238247AbhHXPUH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 24 Aug 2021 11:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbhHXPUD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Aug 2021 11:20:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E81DC061757
        for <linux-block@vger.kernel.org>; Tue, 24 Aug 2021 08:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=TS3plikARb9oHXwa9tCoRD0jeVnL2l6419OBNsWIpIg=; b=UinpYX6rdVkquVDXVVqI3Ui1rq
        0MS53MjvJH9FDdijtsSOWXx0VsM8fCy0ds4CBSuYDJFGkLhERpeud9jpF/x0h0FTWgK6CoA4atk2p
        lxvT6h9rFU7RTkVqGpc/n1w8REGtD7P7cPI0eJz7TzO1KBLfI6EE4maRAFrIHrIaE/IHeGVlA/Pva
        jv6J3HDnBRRjAOeAMKzXH+GtsEP9UaYkPTQS6L7OjsWamT1XDsIEs6+SfJZB4WMAeOqZ3oaD8zTCc
        8UC/P52174ZAHgY/RCFlE4Dn3B+GkMtQrO7APYMaYO/TQNlrqdy3iSYOOQovph1AjZQ1ihZ/DI+Iq
        /02QkJqw==;
Received: from [2001:4bb8:193:fd10:b8ba:7bad:652e:75fa] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mIYC1-00BDP2-3F; Tue, 24 Aug 2021 15:18:32 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH] block: mark blkdev_fsync static
Date:   Tue, 24 Aug 2021 17:18:23 +0200
Message-Id: <20210824151823.1575100-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

blkdev_fsync is only used inside of block_dev.c since the
removal of the raw drіver.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/block_dev.c     | 4 ++--
 include/linux/fs.h | 4 ----
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 7b8deda57e74..45df6cbccf12 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -689,7 +689,8 @@ static loff_t block_llseek(struct file *file, loff_t offset, int whence)
 	return retval;
 }
 	
-int blkdev_fsync(struct file *filp, loff_t start, loff_t end, int datasync)
+static int blkdev_fsync(struct file *filp, loff_t start, loff_t end,
+		int datasync)
 {
 	struct inode *bd_inode = bdev_file_inode(filp);
 	struct block_device *bdev = I_BDEV(bd_inode);
@@ -710,7 +711,6 @@ int blkdev_fsync(struct file *filp, loff_t start, loff_t end, int datasync)
 
 	return error;
 }
-EXPORT_SYMBOL(blkdev_fsync);
 
 /**
  * bdev_read_page() - Start reading a page from a block device
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 96a0affa7b2d..0e49b0e9b943 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3249,10 +3249,6 @@ ssize_t vfs_iocb_iter_read(struct file *file, struct kiocb *iocb,
 ssize_t vfs_iocb_iter_write(struct file *file, struct kiocb *iocb,
 			    struct iov_iter *iter);
 
-/* fs/block_dev.c */
-extern int blkdev_fsync(struct file *filp, loff_t start, loff_t end,
-			int datasync);
-
 /* fs/splice.c */
 extern ssize_t generic_file_splice_read(struct file *, loff_t *,
 		struct pipe_inode_info *, size_t, unsigned int);
-- 
2.30.2

