Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C81ACC433F5
	for <linux-block@archiver.kernel.org>; Tue, 19 Apr 2022 06:33:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348855AbiDSGfw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Apr 2022 02:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237280AbiDSGfv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Apr 2022 02:35:51 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 611392611F;
        Mon, 18 Apr 2022 23:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Cxk+WPrkLvXUy5WBfq1DQOttUDV888u1Wm8RxmiOZ5c=; b=BapnGvRpa21Ngt4hbHoaIGgvB9
        WVvf/rjjr/3jRM1DksCm9WUkxwUmouFpC5NJ7FOgktpYlwkNR3GoCNLWUsqzIA4p19WskRXJcZTZJ
        ufo9hbOKvVExSENKpgVnaAPZJFlpoCM1Iwz6j4QDQ9R3DKCDEiex803D9oo/334roph/7x9eRmhlb
        zWhNab0KI8jLUx2g1Fp6S8joKmUjw20ihTqH6q9BxNtij126LqeEUYzP4v5BpU7e7oAe9aV2UTWzp
        7J4vlL9/ldLLDx3w69Erc8otuTVdzxGwJwJETdHRfLsE5EYLYpe7fFykWl39MGAdIxfwEjGW8zZIw
        KXidgDOQ==;
Received: from [2001:4bb8:191:364b:8ef6:df8:5a60:ae5d] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nghQB-001hzH-SC; Tue, 19 Apr 2022 06:33:08 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-block@vger.kernel.org, linux-spdx@vger.kernel.org
Subject: [PATCH 1/4] loop: remove loop.h
Date:   Tue, 19 Apr 2022 08:33:00 +0200
Message-Id: <20220419063303.583106-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220419063303.583106-1-hch@lst.de>
References: <20220419063303.583106-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Merge loop.h into loop.c as all the content is only used there.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/loop.c | 57 +++++++++++++++++++++++++++++++++--
 drivers/block/loop.h | 71 --------------------------------------------
 2 files changed, 54 insertions(+), 74 deletions(-)
 delete mode 100644 drivers/block/loop.h

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 0c7f0367200cc..f87bb136b66b4 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -59,7 +59,6 @@
 #include <linux/errno.h>
 #include <linux/major.h>
 #include <linux/wait.h>
-#include <linux/blkdev.h>
 #include <linux/blkpg.h>
 #include <linux/init.h>
 #include <linux/swap.h>
@@ -80,10 +79,62 @@
 #include <linux/blk-cgroup.h>
 #include <linux/sched/mm.h>
 #include <linux/statfs.h>
+#include <linux/uaccess.h>
+#include <linux/blk-mq.h>
+#include <linux/spinlock.h>
+#include <uapi/linux/loop.h>
+
+/* Possible states of device */
+enum {
+	Lo_unbound,
+	Lo_bound,
+	Lo_rundown,
+	Lo_deleting,
+};
 
-#include "loop.h"
+struct loop_func_table;
+
+struct loop_device {
+	int		lo_number;
+	loff_t		lo_offset;
+	loff_t		lo_sizelimit;
+	int		lo_flags;
+	char		lo_file_name[LO_NAME_SIZE];
+
+	struct file *	lo_backing_file;
+	struct block_device *lo_device;
+
+	gfp_t		old_gfp_mask;
+
+	spinlock_t		lo_lock;
+	int			lo_state;
+	spinlock_t              lo_work_lock;
+	struct workqueue_struct *workqueue;
+	struct work_struct      rootcg_work;
+	struct list_head        rootcg_cmd_list;
+	struct list_head        idle_worker_list;
+	struct rb_root          worker_tree;
+	struct timer_list       timer;
+	bool			use_dio;
+	bool			sysfs_inited;
+
+	struct request_queue	*lo_queue;
+	struct blk_mq_tag_set	tag_set;
+	struct gendisk		*lo_disk;
+	struct mutex		lo_mutex;
+	bool			idr_visible;
+};
 
-#include <linux/uaccess.h>
+struct loop_cmd {
+	struct list_head list_entry;
+	bool use_aio; /* use AIO interface to handle I/O */
+	atomic_t ref; /* only for aio */
+	long ret;
+	struct kiocb iocb;
+	struct bio_vec *bvec;
+	struct cgroup_subsys_state *blkcg_css;
+	struct cgroup_subsys_state *memcg_css;
+};
 
 #define LOOP_IDLE_WORKER_TIMEOUT (60 * HZ)
 #define LOOP_DEFAULT_HW_Q_DEPTH (128)
diff --git a/drivers/block/loop.h b/drivers/block/loop.h
deleted file mode 100644
index 449d562738c52..0000000000000
--- a/drivers/block/loop.h
+++ /dev/null
@@ -1,71 +0,0 @@
-/*
- * loop.h
- *
- * Written by Theodore Ts'o, 3/29/93.
- *
- * Copyright 1993 by Theodore Ts'o.  Redistribution of this file is
- * permitted under the GNU General Public License.
- */
-#ifndef _LINUX_LOOP_H
-#define _LINUX_LOOP_H
-
-#include <linux/bio.h>
-#include <linux/blkdev.h>
-#include <linux/blk-mq.h>
-#include <linux/spinlock.h>
-#include <linux/mutex.h>
-#include <uapi/linux/loop.h>
-
-/* Possible states of device */
-enum {
-	Lo_unbound,
-	Lo_bound,
-	Lo_rundown,
-	Lo_deleting,
-};
-
-struct loop_func_table;
-
-struct loop_device {
-	int		lo_number;
-	loff_t		lo_offset;
-	loff_t		lo_sizelimit;
-	int		lo_flags;
-	char		lo_file_name[LO_NAME_SIZE];
-
-	struct file *	lo_backing_file;
-	struct block_device *lo_device;
-
-	gfp_t		old_gfp_mask;
-
-	spinlock_t		lo_lock;
-	int			lo_state;
-	spinlock_t              lo_work_lock;
-	struct workqueue_struct *workqueue;
-	struct work_struct      rootcg_work;
-	struct list_head        rootcg_cmd_list;
-	struct list_head        idle_worker_list;
-	struct rb_root          worker_tree;
-	struct timer_list       timer;
-	bool			use_dio;
-	bool			sysfs_inited;
-
-	struct request_queue	*lo_queue;
-	struct blk_mq_tag_set	tag_set;
-	struct gendisk		*lo_disk;
-	struct mutex		lo_mutex;
-	bool			idr_visible;
-};
-
-struct loop_cmd {
-	struct list_head list_entry;
-	bool use_aio; /* use AIO interface to handle I/O */
-	atomic_t ref; /* only for aio */
-	long ret;
-	struct kiocb iocb;
-	struct bio_vec *bvec;
-	struct cgroup_subsys_state *blkcg_css;
-	struct cgroup_subsys_state *memcg_css;
-};
-
-#endif
-- 
2.30.2

