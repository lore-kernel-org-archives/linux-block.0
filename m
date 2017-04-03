Return-Path: <josef@toxicpanda.com>
Return-Path: <josef@toxicpanda.com>
From: Josef Bacik <josef@toxicpanda.com>
To: kernel-team@fb.com,
	axboe@kernel.dk,
	linux-block@vger.kernel.org
Subject: [PATCH] block: allow us to change max_segments on the fly
Date: Mon,  3 Apr 2017 15:13:18 -0400
Message-Id: <1491246798-1774-1-git-send-email-jbacik@fb.com>
List-ID: <linux-block@vger.kernel.org>

For things like NBD we want to be able to experiment with different
sized requests going over the wire.  Half of our limit is controled by
max_sectors_kb, but the other half is how many bvec's we can cram into a
request, which is controlled by max_segments.  Changing this sysfs knob
to be writeable allows us to be able to control our io limits more
precisely.

Signed-off-by: Josef Bacik <jbacik@fb.com>
---
 block/blk-sysfs.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 4585426..e7db3f8 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -116,6 +116,19 @@ static ssize_t queue_max_sectors_show(struct request_queue *q, char *page)
 	return queue_var_show(max_sectors_kb, (page));
 }
 
+static ssize_t queue_max_segments_store(struct request_queue *q,
+					const char *page, size_t count)
+{
+	unsigned long max_segments;
+	ssize_t ret = queue_var_store(&max_segments, page, count);
+
+	if (ret < 0)
+		return ret;
+
+	q->limits.max_segments = (short)max_segments;
+	return ret;
+}
+
 static ssize_t queue_max_segments_show(struct request_queue *q, char *page)
 {
 	return queue_var_show(queue_max_segments(q), (page));
@@ -527,8 +540,9 @@ static struct queue_sysfs_entry queue_max_hw_sectors_entry = {
 };
 
 static struct queue_sysfs_entry queue_max_segments_entry = {
-	.attr = {.name = "max_segments", .mode = S_IRUGO },
+	.attr = {.name = "max_segments", .mode = S_IRUGO | S_IWUSR },
 	.show = queue_max_segments_show,
+	.store = queue_max_segments_store,
 };
 
 static struct queue_sysfs_entry queue_max_discard_segments_entry = {
-- 
2.7.4
