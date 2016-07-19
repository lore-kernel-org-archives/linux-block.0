Return-Path: <linux-scsi-owner@vger.kernel.org>
From: Hannes Reinecke <hare@suse.de>
To: Jens Axboe <axboe@fb.com>
Cc: linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
	Damien Le Moal <damien.lemoal@hgst.com>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 1/6] blk-sysfs: Add 'chunk_sectors' to sysfs attributes
Date: Tue, 19 Jul 2016 15:20:34 +0200
Message-Id: <1468934439-93579-2-git-send-email-hare@suse.de>
In-Reply-To: <1468934439-93579-1-git-send-email-hare@suse.de>
References: <1468934439-93579-1-git-send-email-hare@suse.de>
Sender: linux-scsi-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

The queue limits already have a 'chunk_sectors' setting, so
we should be presenting it via sysfs.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 block/blk-sysfs.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 9920596..73200b8 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -130,6 +130,11 @@ static ssize_t queue_physical_block_size_show(struct request_queue *q, char *pag
 	return queue_var_show(queue_physical_block_size(q), page);
 }
 
+static ssize_t queue_chunk_sectors_show(struct request_queue *q, char *page)
+{
+	return queue_var_show(q->limits.chunk_sectors, page);
+}
+
 static ssize_t queue_io_min_show(struct request_queue *q, char *page)
 {
 	return queue_var_show(queue_io_min(q), page);
@@ -438,6 +443,11 @@ static struct queue_sysfs_entry queue_physical_block_size_entry = {
 	.show = queue_physical_block_size_show,
 };
 
+static struct queue_sysfs_entry queue_chunk_sectors_entry = {
+	.attr = {.name = "chunk_sectors", .mode = S_IRUGO },
+	.show = queue_chunk_sectors_show,
+};
+
 static struct queue_sysfs_entry queue_io_min_entry = {
 	.attr = {.name = "minimum_io_size", .mode = S_IRUGO },
 	.show = queue_io_min_show,
@@ -528,6 +538,7 @@ static struct attribute *default_attrs[] = {
 	&queue_hw_sector_size_entry.attr,
 	&queue_logical_block_size_entry.attr,
 	&queue_physical_block_size_entry.attr,
+	&queue_chunk_sectors_entry.attr,
 	&queue_io_min_entry.attr,
 	&queue_io_opt_entry.attr,
 	&queue_discard_granularity_entry.attr,
-- 
1.8.5.6

