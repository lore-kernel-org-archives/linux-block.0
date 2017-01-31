Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f176.google.com ([209.85.192.176]:36502 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750828AbdAaWyI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 Jan 2017 17:54:08 -0500
Received: by mail-pf0-f176.google.com with SMTP id 189so112770027pfu.3
        for <linux-block@vger.kernel.org>; Tue, 31 Jan 2017 14:54:08 -0800 (PST)
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: kernel-team@fb.com
Subject: [PATCH 2/6] block: fix debugfs config conditional in struct request_queue
Date: Tue, 31 Jan 2017 14:53:18 -0800
Message-Id: <cdde45aec458721ccba950ab3a42f2030e2c69b6.1485902856.git.osandov@fb.com>
In-Reply-To: <cover.1485902856.git.osandov@fb.com>
References: <cover.1485902856.git.osandov@fb.com>
In-Reply-To: <cover.1485902856.git.osandov@fb.com>
References: <cover.1485902856.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

The debugfs dentries are only used for CONFIG_BLK_DEBUG_FS, so make them
conditional on that instead of CONFIG_DEBUG_FS.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 include/linux/blkdev.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 05675b1dfd20..0cd0066a3d48 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -571,7 +571,7 @@ struct request_queue {
 	struct list_head	tag_set_list;
 	struct bio_set		*bio_split;
 
-#ifdef CONFIG_DEBUG_FS
+#ifdef CONFIG_BLK_DEBUG_FS
 	struct dentry		*debugfs_dir;
 	struct dentry		*mq_debugfs_dir;
 #endif
-- 
2.11.0

