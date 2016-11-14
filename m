Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:55985 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S965087AbcKNWW1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Nov 2016 17:22:27 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id uAEMJVMY003002
        for <linux-block@vger.kernel.org>; Mon, 14 Nov 2016 14:22:26 -0800
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 26qjtr93s2-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Mon, 14 Nov 2016 14:22:26 -0800
Received: from facebook.com (2401:db00:21:603d:face:0:19:0)     by
 mx-out.facebook.com (10.212.236.87) with ESMTP id
 d186aaf2aab811e68f2c0002c9521c9e-612dba50 for <linux-block@vger.kernel.org>;
        Mon, 14 Nov 2016 14:22:24 -0800
From: Shaohua Li <shli@fb.com>
To: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <Kernel-team@fb.com>, <axboe@fb.com>, <tj@kernel.org>,
        <vgoyal@redhat.com>
Subject: [PATCH V4 11/15] blk-throttle: add interface to configure think time threshold
Date: Mon, 14 Nov 2016 14:22:18 -0800
Message-ID: <52aae27038728bf0fd1b2b3b6536fcc28c9f2e6c.1479161136.git.shli@fb.com>
In-Reply-To: <cover.1479161136.git.shli@fb.com>
References: <cover.1479161136.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Add interface to configure the threshold

Signed-off-by: Shaohua Li <shli@fb.com>
---
 block/blk-sysfs.c    |  7 +++++++
 block/blk-throttle.c | 25 +++++++++++++++++++++++++
 block/blk.h          |  4 ++++
 3 files changed, 36 insertions(+)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 3e284e4..f15aeed 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -532,6 +532,12 @@ static struct queue_sysfs_entry throtl_slice_entry = {
 	.show = blk_throtl_slice_show,
 	.store = blk_throtl_slice_store,
 };
+
+static struct queue_sysfs_entry throtl_idle_threshold_entry = {
+	.attr = {.name = "throttling_idle_threshold", .mode = S_IRUGO | S_IWUSR },
+	.show = blk_throtl_idle_threshold_show,
+	.store = blk_throtl_idle_threshold_store,
+};
 #endif
 
 static struct attribute *default_attrs[] = {
@@ -563,6 +569,7 @@ static struct attribute *default_attrs[] = {
 	&queue_dax_entry.attr,
 #ifdef CONFIG_BLK_DEV_THROTTLING
 	&throtl_slice_entry.attr,
+	&throtl_idle_threshold_entry.attr,
 #endif
 	NULL,
 };
diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index cb5fd85..e403e88 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -2139,6 +2139,31 @@ ssize_t blk_throtl_slice_store(struct request_queue *q,
 	return count;
 }
 
+ssize_t blk_throtl_idle_threshold_show(struct request_queue *q, char *page)
+{
+	u64 threshold = q->td->idle_ttime_threshold;
+
+	if (!q->td)
+		return -EINVAL;
+	do_div(threshold, 1000);
+	return sprintf(page, "%lluus\n", threshold);
+}
+
+ssize_t blk_throtl_idle_threshold_store(struct request_queue *q,
+	const char *page, size_t count)
+{
+	unsigned long v;
+
+	if (!q->td)
+		return -EINVAL;
+	if (kstrtoul(page, 10, &v))
+		return -EINVAL;
+	if (v == 0)
+		return -EINVAL;
+	q->td->idle_ttime_threshold = v * 1000;
+	return count;
+}
+
 static int __init throtl_init(void)
 {
 	kthrotld_workqueue = alloc_workqueue("kthrotld", WQ_MEM_RECLAIM, 0);
diff --git a/block/blk.h b/block/blk.h
index b433f35..2ebde12 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -292,6 +292,10 @@ extern void blk_throtl_exit(struct request_queue *q);
 extern ssize_t blk_throtl_slice_show(struct request_queue *q, char *page);
 extern ssize_t blk_throtl_slice_store(struct request_queue *q,
 	const char *page, size_t count);
+extern ssize_t blk_throtl_idle_threshold_show(struct request_queue *q,
+	char *page);
+extern ssize_t blk_throtl_idle_threshold_store(struct request_queue *q,
+	const char *page, size_t count);
 extern void blk_throtl_bio_endio(struct bio *bio);
 #else /* CONFIG_BLK_DEV_THROTTLING */
 static inline void blk_throtl_drain(struct request_queue *q) { }
-- 
2.9.3

