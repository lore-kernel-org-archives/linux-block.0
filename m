Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 396C1C433EF
	for <linux-block@archiver.kernel.org>; Wed, 15 Sep 2021 06:44:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B62961179
	for <linux-block@archiver.kernel.org>; Wed, 15 Sep 2021 06:44:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbhIOGpq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Sep 2021 02:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbhIOGpq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Sep 2021 02:45:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FC35C061574
        for <linux-block@vger.kernel.org>; Tue, 14 Sep 2021 23:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=tnhpzZXm161/s6Z0/Ca61iqLk/E4L57vqHSRc5j3Q/Y=; b=RTpLbfRGX++Dt0iQfskmJDqoRB
        3MP8mBc1fBvd/ZsgY2wC+Myi17FX5WHRtzo/pW8BWAmVp5VB2EOPTwPbTTKXUiKzNNZfJkb0siOUA
        +U+L1V6QGWIqOa+HLyNmwas8cArjKjLM5lDf9ZTiDtu2fXPCt9sjBh1UDxJoDdgR4lcWbO/pzt4qr
        tqBnM833+/dM3DU4chIwUWkRl6x4oJjJoEuXwQn+XP0b+9LY/gbRryQ4CW1Xq6Eyk6Aury5Mao67k
        9hC4lUDURbIuv9PbaU5ERpV+uAe9GWzM9InrLVGW1heQZjX25p28D0yLIeuo83eBH2Dp37WODOSO7
        09d/fLfQ==;
Received: from [2001:4bb8:184:72db:8457:d7a:6e21:dd20] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mQOda-00FQgW-4m; Wed, 15 Sep 2021 06:43:30 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 03/17] mm: don't include <linux/blkdev.h> in <linux/backing-dev.h>
Date:   Wed, 15 Sep 2021 08:40:30 +0200
Message-Id: <20210915064044.950534-4-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210915064044.950534-1-hch@lst.de>
References: <20210915064044.950534-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Move inode_to_bdi out of line to avoid having to include blkdev.h.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/mtd/mtdsuper.c      |  1 +
 fs/ntfs/file.c              |  1 +
 fs/ntfs3/file.c             |  1 +
 fs/orangefs/inode.c         |  2 +-
 include/linux/backing-dev.h | 16 +---------------
 mm/backing-dev.c            | 16 ++++++++++++++++
 6 files changed, 21 insertions(+), 16 deletions(-)

diff --git a/drivers/mtd/mtdsuper.c b/drivers/mtd/mtdsuper.c
index 38b6aa849c638..5ff001140ef4a 100644
--- a/drivers/mtd/mtdsuper.c
+++ b/drivers/mtd/mtdsuper.c
@@ -15,6 +15,7 @@
 #include <linux/slab.h>
 #include <linux/major.h>
 #include <linux/backing-dev.h>
+#include <linux/blkdev.h>
 #include <linux/fs_context.h>
 #include "mtdcore.h"
 
diff --git a/fs/ntfs/file.c b/fs/ntfs/file.c
index ab4f3362466d0..373dbb6276570 100644
--- a/fs/ntfs/file.c
+++ b/fs/ntfs/file.c
@@ -5,6 +5,7 @@
  * Copyright (c) 2001-2015 Anton Altaparmakov and Tuxera Inc.
  */
 
+#include <linux/blkdev.h>
 #include <linux/backing-dev.h>
 #include <linux/buffer_head.h>
 #include <linux/gfp.h>
diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index 424450e77ad52..7592ba8944572 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/backing-dev.h>
+#include <linux/blkdev.h>
 #include <linux/buffer_head.h>
 #include <linux/compat.h>
 #include <linux/falloc.h>
diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index c1bb4c4b5d672..e5e3e500ed462 100644
--- a/fs/orangefs/inode.c
+++ b/fs/orangefs/inode.c
@@ -10,7 +10,7 @@
  *  Linux VFS inode operations.
  */
 
-#include <linux/bvec.h>
+#include <linux/blkdev.h>
 #include <linux/fileattr.h>
 #include "protocol.h"
 #include "orangefs-kernel.h"
diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
index 843bf4be675f3..4ac7ce0960139 100644
--- a/include/linux/backing-dev.h
+++ b/include/linux/backing-dev.h
@@ -12,7 +12,6 @@
 #include <linux/kernel.h>
 #include <linux/fs.h>
 #include <linux/sched.h>
-#include <linux/blkdev.h>
 #include <linux/device.h>
 #include <linux/writeback.h>
 #include <linux/backing-dev-defs.h>
@@ -134,20 +133,7 @@ static inline bool writeback_in_progress(struct bdi_writeback *wb)
 	return test_bit(WB_writeback_running, &wb->state);
 }
 
-static inline struct backing_dev_info *inode_to_bdi(struct inode *inode)
-{
-	struct super_block *sb;
-
-	if (!inode)
-		return &noop_backing_dev_info;
-
-	sb = inode->i_sb;
-#ifdef CONFIG_BLOCK
-	if (sb_is_blkdev_sb(sb))
-		return I_BDEV(inode)->bd_disk->bdi;
-#endif
-	return sb->s_bdi;
-}
+struct backing_dev_info *inode_to_bdi(struct inode *inode);
 
 static inline int wb_congested(struct bdi_writeback *wb, int cong_bits)
 {
diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index 5245744437dc9..c878d995af06e 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -978,6 +978,22 @@ void bdi_put(struct backing_dev_info *bdi)
 }
 EXPORT_SYMBOL(bdi_put);
 
+struct backing_dev_info *inode_to_bdi(struct inode *inode)
+{
+	struct super_block *sb;
+
+	if (!inode)
+		return &noop_backing_dev_info;
+
+	sb = inode->i_sb;
+#ifdef CONFIG_BLOCK
+	if (sb_is_blkdev_sb(sb))
+		return I_BDEV(inode)->bd_disk->bdi;
+#endif
+	return sb->s_bdi;
+}
+EXPORT_SYMBOL(inode_to_bdi);
+
 const char *bdi_dev_name(struct backing_dev_info *bdi)
 {
 	if (!bdi || !bdi->dev)
-- 
2.30.2

