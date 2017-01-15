Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:50097 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750907AbdAODmi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 14 Jan 2017 22:42:38 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v0F3dQ4c016909
        for <linux-block@vger.kernel.org>; Sat, 14 Jan 2017 19:42:37 -0800
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 27yjkk1c0x-4
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Sat, 14 Jan 2017 19:42:37 -0800
Received: from facebook.com (2401:db00:21:603d:face:0:19:0)     by
 mx-out.facebook.com (10.102.107.99) with ESMTP id
 a793079edad411e6ac470002c99293a0-721f6a50 for <linux-block@vger.kernel.org>;
        Sat, 14 Jan 2017 19:42:36 -0800
From: Shaohua Li <shli@fb.com>
To: <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>
CC: <Kernel-team@fb.com>, <tj@kernel.org>, <axboe@fb.com>,
        <vgoyal@redhat.com>
Subject: [PATCH V6 09/18] blk-throttle: choose a small throtl_slice for SSD
Date: Sat, 14 Jan 2017 19:42:26 -0800
Message-ID: <4705da8bf1e43a023c0613c5f303674d7f9b87f6.1484451062.git.shli@fb.com>
In-Reply-To: <cover.1484451062.git.shli@fb.com>
References: <cover.1484451062.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

The throtl_slice is 100ms by default. This is a long time for SSD, a lot
of IO can run. To make cgroups have smoother throughput, we choose a
small value (20ms) for SSD.

Signed-off-by: Shaohua Li <shli@fb.com>
---
 block/blk-sysfs.c    |  2 ++
 block/blk-throttle.c | 18 +++++++++++++++---
 block/blk.h          |  2 ++
 3 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 0e3fb2a..7285f74 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -907,6 +907,8 @@ int blk_register_queue(struct gendisk *disk)
 
 	blk_wb_init(q);
 
+	blk_throtl_register_queue(q);
+
 	if (!q->request_fn)
 		return 0;
 
diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 49cad9a..2d05c91 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -18,8 +18,9 @@ static int throtl_grp_quantum = 8;
 /* Total max dispatch from all groups in one round */
 static int throtl_quantum = 32;
 
-/* Throttling is performed over 100ms slice and after that slice is renewed */
-#define DFL_THROTL_SLICE (HZ / 10)
+/* Throttling is performed over a slice and after that slice is renewed */
+#define DFL_THROTL_SLICE_HD (HZ / 10)
+#define DFL_THROTL_SLICE_SSD (HZ / 50)
 #define MAX_THROTL_SLICE (HZ)
 
 static struct blkcg_policy blkcg_policy_throtl;
@@ -1957,7 +1958,6 @@ int blk_throtl_init(struct request_queue *q)
 
 	q->td = td;
 	td->queue = q;
-	td->throtl_slice = DFL_THROTL_SLICE;
 
 	td->limit_valid[LIMIT_MAX] = true;
 	td->limit_index = LIMIT_MAX;
@@ -1978,6 +1978,18 @@ void blk_throtl_exit(struct request_queue *q)
 	kfree(q->td);
 }
 
+void blk_throtl_register_queue(struct request_queue *q)
+{
+	struct throtl_data *td;
+
+	td = q->td;
+	BUG_ON(!td);
+	if (blk_queue_nonrot(q))
+		td->throtl_slice = DFL_THROTL_SLICE_SSD;
+	else
+		td->throtl_slice = DFL_THROTL_SLICE_HD;
+}
+
 ssize_t blk_throtl_sample_time_show(struct request_queue *q, char *page)
 {
 	if (!q->td)
diff --git a/block/blk.h b/block/blk.h
index e83e757..186c67d 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -293,10 +293,12 @@ extern void blk_throtl_exit(struct request_queue *q);
 extern ssize_t blk_throtl_sample_time_show(struct request_queue *q, char *page);
 extern ssize_t blk_throtl_sample_time_store(struct request_queue *q,
 	const char *page, size_t count);
+extern void blk_throtl_register_queue(struct request_queue *q);
 #else /* CONFIG_BLK_DEV_THROTTLING */
 static inline void blk_throtl_drain(struct request_queue *q) { }
 static inline int blk_throtl_init(struct request_queue *q) { return 0; }
 static inline void blk_throtl_exit(struct request_queue *q) { }
+static inline void blk_throtl_register_queue(struct request_queue *q) { }
 #endif /* CONFIG_BLK_DEV_THROTTLING */
 
 #endif /* BLK_INTERNAL_H */
-- 
2.9.3

