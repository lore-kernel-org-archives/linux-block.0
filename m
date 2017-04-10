Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:51948 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753358AbdDJP4P (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Apr 2017 11:56:15 -0400
From: Jens Axboe <axboe@fb.com>
To: <linux-block@vger.kernel.org>
CC: <osandov@fb.com>, <hch@lst.de>, <bart.vanassche@sandisk.com>,
        Jens Axboe <axboe@fb.com>
Subject: [PATCH 2/3] block: add kblock_mod_delayed_work_on()
Date: Mon, 10 Apr 2017 09:54:55 -0600
Message-ID: <1491839696-24783-3-git-send-email-axboe@fb.com>
In-Reply-To: <1491839696-24783-1-git-send-email-axboe@fb.com>
References: <1491839696-24783-1-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This modifies (or adds, if not currently pending) an existing
delayed work item.

Signed-off-by: Jens Axboe <axboe@fb.com>
---
 block/blk-core.c       | 7 +++++++
 include/linux/blkdev.h | 1 +
 2 files changed, 8 insertions(+)

diff --git a/block/blk-core.c b/block/blk-core.c
index d58541e4dc7b..bffb8640346b 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -3135,6 +3135,13 @@ int kblockd_schedule_work_on(int cpu, struct work_struct *work)
 }
 EXPORT_SYMBOL(kblockd_schedule_work_on);
 
+int kblockd_mod_delayed_work_on(int cpu, struct delayed_work *dwork,
+				unsigned long delay)
+{
+	return mod_delayed_work_on(cpu, kblockd_workqueue, dwork, delay);
+}
+EXPORT_SYMBOL(kblockd_mod_delayed_work_on);
+
 int kblockd_schedule_delayed_work(struct delayed_work *dwork,
 				  unsigned long delay)
 {
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index ec993573e0a8..71b978dedbbc 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1699,6 +1699,7 @@ int kblockd_schedule_work(struct work_struct *work);
 int kblockd_schedule_work_on(int cpu, struct work_struct *work);
 int kblockd_schedule_delayed_work(struct delayed_work *dwork, unsigned long delay);
 int kblockd_schedule_delayed_work_on(int cpu, struct delayed_work *dwork, unsigned long delay);
+int kblockd_mod_delayed_work_on(int cpu, struct delayed_work *dwork, unsigned long delay);
 
 #ifdef CONFIG_BLK_CGROUP
 /*
-- 
2.7.4
