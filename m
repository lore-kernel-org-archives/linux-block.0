Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 608EFC433EF
	for <linux-block@archiver.kernel.org>; Mon, 20 Sep 2021 12:34:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44EEF60F4B
	for <linux-block@archiver.kernel.org>; Mon, 20 Sep 2021 12:34:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238446AbhITMf5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Sep 2021 08:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238470AbhITMfy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Sep 2021 08:35:54 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8025C061574
        for <linux-block@vger.kernel.org>; Mon, 20 Sep 2021 05:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=3XLJkx1xJBDRFYY5RbMFeFC7f9hS3A59CTCdo3iTP9I=; b=gCI7ca9ipErvQwqROrRl28RDVl
        l9i91X2NQYQO/vCRQ6HIfMJcoLH513SMq1FCxC7ddG64ga7lB8GOn5BLmCCyGzR9aFlui1hNV2VB3
        2C8w+vZgRByRydqVcbVtuC9ldCheT4006yOYvvb5DjIg7y0AiGxR2o5bEwINug2aRKP1SRRigA60z
        FjgTafB9kW1DrUSzoriE0ht093+rf8N9A62Kxb3cDJbryttsShmCzectm83N2N/mELRgwkBqvyGbD
        Z/zh2FN3H5fylrPU/yCGjDHZetN7sfkV3dwoLs3aTs18+dqCY7qM4pd7eKRucTgoMCAS6iiUsb0hK
        DAyvxk9w==;
Received: from [2001:4bb8:184:72db:7ad9:14d9:8599:3025] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mSIUl-002ety-RL; Mon, 20 Sep 2021 12:34:10 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-mm@kvack.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 02/17] mm: don't include <linux/blk-cgroup.h> in <linux/backing-dev.h>
Date:   Mon, 20 Sep 2021 14:33:13 +0200
Message-Id: <20210920123328.1399408-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210920123328.1399408-1-hch@lst.de>
References: <20210920123328.1399408-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

There is no need to pull blk-cgroup.h and thus blkdev.h in here, so
break the include chain.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 arch/powerpc/platforms/cell/spufs/inode.c | 1 +
 block/blk-iolatency.c                     | 1 +
 block/blk-mq.c                            | 1 +
 block/bounce.c                            | 1 +
 drivers/md/dm-ima.c                       | 1 +
 fs/btrfs/compression.c                    | 1 +
 fs/btrfs/ctree.c                          | 1 +
 fs/f2fs/compress.c                        | 1 +
 fs/orangefs/super.c                       | 1 +
 fs/ramfs/inode.c                          | 1 +
 include/linux/backing-dev.h               | 3 ++-
 mm/backing-dev.c                          | 3 ++-
 mm/swapfile.c                             | 2 +-
 13 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/cell/spufs/inode.c b/arch/powerpc/platforms/cell/spufs/inode.c
index bed05b644c2c5..cb25acccd746e 100644
--- a/arch/powerpc/platforms/cell/spufs/inode.c
+++ b/arch/powerpc/platforms/cell/spufs/inode.c
@@ -21,6 +21,7 @@
 #include <linux/namei.h>
 #include <linux/pagemap.h>
 #include <linux/poll.h>
+#include <linux/seq_file.h>
 #include <linux/slab.h>
 
 #include <asm/prom.h>
diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
index c0545f9da549c..6593c7123b97e 100644
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -74,6 +74,7 @@
 #include <linux/sched/signal.h>
 #include <trace/events/block.h>
 #include <linux/blk-mq.h>
+#include <linux/blk-cgroup.h>
 #include "blk-rq-qos.h"
 #include "blk-stat.h"
 #include "blk.h"
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 108a352051be5..61264bff6103a 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -16,6 +16,7 @@
 #include <linux/slab.h>
 #include <linux/workqueue.h>
 #include <linux/smp.h>
+#include <linux/interrupt.h>
 #include <linux/llist.h>
 #include <linux/list_sort.h>
 #include <linux/cpu.h>
diff --git a/block/bounce.c b/block/bounce.c
index 05fc7148489d7..7af1a72835b99 100644
--- a/block/bounce.c
+++ b/block/bounce.c
@@ -14,6 +14,7 @@
 #include <linux/pagemap.h>
 #include <linux/mempool.h>
 #include <linux/blkdev.h>
+#include <linux/blk-cgroup.h>
 #include <linux/backing-dev.h>
 #include <linux/init.h>
 #include <linux/hash.h>
diff --git a/drivers/md/dm-ima.c b/drivers/md/dm-ima.c
index 2c5edfbd77117..957999998d703 100644
--- a/drivers/md/dm-ima.c
+++ b/drivers/md/dm-ima.c
@@ -12,6 +12,7 @@
 #include "dm-ima.h"
 
 #include <linux/ima.h>
+#include <linux/sched/mm.h>
 #include <crypto/hash.h>
 #include <linux/crypto.h>
 #include <crypto/hash_info.h>
diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 7869ad12bc6e1..ddc4f5436cc91 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -9,6 +9,7 @@
 #include <linux/fs.h>
 #include <linux/pagemap.h>
 #include <linux/highmem.h>
+#include <linux/kthread.h>
 #include <linux/time.h>
 #include <linux/init.h>
 #include <linux/string.h>
diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 84627cbd5b5b5..66290b214f2bc 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -7,6 +7,7 @@
 #include <linux/slab.h>
 #include <linux/rbtree.h>
 #include <linux/mm.h>
+#include <linux/error-injection.h>
 #include "ctree.h"
 #include "disk-io.h"
 #include "transaction.h"
diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index c1bf9ad4c2207..20a083dc90423 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -7,6 +7,7 @@
 
 #include <linux/fs.h>
 #include <linux/f2fs_fs.h>
+#include <linux/moduleparam.h>
 #include <linux/writeback.h>
 #include <linux/backing-dev.h>
 #include <linux/lzo.h>
diff --git a/fs/orangefs/super.c b/fs/orangefs/super.c
index 2f2e430461b21..8bb0a53a658b0 100644
--- a/fs/orangefs/super.c
+++ b/fs/orangefs/super.c
@@ -11,6 +11,7 @@
 
 #include <linux/parser.h>
 #include <linux/hashtable.h>
+#include <linux/seq_file.h>
 
 /* a cache for orangefs-inode objects (i.e. orangefs inode private data) */
 static struct kmem_cache *orangefs_inode_cache;
diff --git a/fs/ramfs/inode.c b/fs/ramfs/inode.c
index 65e7e56005b8f..e2302342a67f4 100644
--- a/fs/ramfs/inode.c
+++ b/fs/ramfs/inode.c
@@ -38,6 +38,7 @@
 #include <linux/uaccess.h>
 #include <linux/fs_context.h>
 #include <linux/fs_parser.h>
+#include <linux/seq_file.h>
 #include "internal.h"
 
 struct ramfs_mount_opts {
diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
index ac7f231b88258..843bf4be675f3 100644
--- a/include/linux/backing-dev.h
+++ b/include/linux/backing-dev.h
@@ -15,10 +15,11 @@
 #include <linux/blkdev.h>
 #include <linux/device.h>
 #include <linux/writeback.h>
-#include <linux/blk-cgroup.h>
 #include <linux/backing-dev-defs.h>
 #include <linux/slab.h>
 
+struct blkcg;
+
 static inline struct backing_dev_info *bdi_get(struct backing_dev_info *bdi)
 {
 	kref_get(&bdi->refcnt);
diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index 4a9d4e27d0d9b..5245744437dc9 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -2,8 +2,9 @@
 
 #include <linux/wait.h>
 #include <linux/rbtree.h>
-#include <linux/backing-dev.h>
 #include <linux/kthread.h>
+#include <linux/backing-dev.h>
+#include <linux/blk-cgroup.h>
 #include <linux/freezer.h>
 #include <linux/fs.h>
 #include <linux/pagemap.h>
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 22d10f7138487..30db362749c06 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -18,7 +18,7 @@
 #include <linux/pagemap.h>
 #include <linux/namei.h>
 #include <linux/shmem_fs.h>
-#include <linux/blkdev.h>
+#include <linux/blk-cgroup.h>
 #include <linux/random.h>
 #include <linux/writeback.h>
 #include <linux/proc_fs.h>
-- 
2.30.2

