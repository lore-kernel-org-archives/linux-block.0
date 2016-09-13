Return-Path: <sbates@raithlin.com>
From: Stephen Bates <sbates@raithlin.com>
To: linux-block@vger.kernel.org
Cc: axboe@kernel.dk,
	hch@lst.de
Subject: [PATCH 2/2] Enable zeroing of io_poll statistics
Date: Tue, 13 Sep 2016 12:23:16 -0600
Message-Id: <1473790996-27038-3-git-send-email-sbates@raithlin.com>
In-Reply-To: <1473790996-27038-1-git-send-email-sbates@raithlin.com>
References: <1473790996-27038-1-git-send-email-sbates@raithlin.com>
List-ID: <linux-block@vger.kernel.org>

Allow the io_poll statistics to be zeroed to make for easier logging
of polling event.

Signed-off-by: Stephen Bates <sbates@raithlin.com>
---
 block/blk-mq-sysfs.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c
index ea8c3f5..ac5160e 100644
--- a/block/blk-mq-sysfs.c
+++ b/block/blk-mq-sysfs.c
@@ -181,6 +181,14 @@ static ssize_t blk_mq_hw_sysfs_poll_show(struct blk_mq_hw_ctx *hctx, char *page)
 		       hctx->poll_success);
 }
 
+static ssize_t blk_mq_hw_sysfs_poll_store(struct blk_mq_hw_ctx *hctx,
+					  const char *page, size_t size)
+{
+	hctx->poll_considered = hctx->poll_invoked = hctx->poll_success = 0;
+
+	return size;
+}
+
 static ssize_t blk_mq_hw_sysfs_queued_show(struct blk_mq_hw_ctx *hctx,
 					   char *page)
 {
@@ -303,8 +311,9 @@ static struct blk_mq_hw_ctx_sysfs_entry blk_mq_hw_sysfs_cpus = {
 	.show = blk_mq_hw_sysfs_cpus_show,
 };
 static struct blk_mq_hw_ctx_sysfs_entry blk_mq_hw_sysfs_poll = {
-	.attr = {.name = "io_poll", .mode = S_IRUGO },
+	.attr = {.name = "io_poll", .mode = S_IWUSR | S_IRUGO },
 	.show = blk_mq_hw_sysfs_poll_show,
+	.store = blk_mq_hw_sysfs_poll_store,
 };
 
 static struct attribute *default_hw_ctx_attrs[] = {
-- 
2.1.4
