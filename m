Return-Path: <Damien.LeMoal@hgst.com>
From: Damien Le Moal <damien.lemoal@hgst.com>
To: Jens Axboe <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, <linux-scsi@vger.kernel.org>, Christoph
 Hellwig <hch@lst.de>, "Martin K . Petersen" <martin.petersen@oracle.com>,
	Hannes Reinecke <hare@suse.de>, Shaun Tancheff <shaun@tancheff.com>, Damien
 Le Moal <damien.lemoal@hgst.com>
Subject: [PATCH v5 2/7] blk-sysfs: Add 'chunk_sectors' to sysfs attributes
Date: Fri, 30 Sep 2016 13:11:34 +0900
Message-ID: <1475208699-27310-3-git-send-email-damien.lemoal@hgst.com>
In-Reply-To: <1475208699-27310-1-git-send-email-damien.lemoal@hgst.com>
References: <1475208699-27310-1-git-send-email-damien.lemoal@hgst.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: damien.lemoal@hgst.com
List-ID: <linux-block@vger.kernel.org>

From: Hannes Reinecke <hare@suse.de>

The queue limits already have a 'chunk_sectors' setting, so
we should be presenting it via sysfs.

Signed-off-by: Hannes Reinecke <hare@suse.de>

[Damien: Updated Documentation/ABI/testing/sysfs-block]

Signed-off-by: Damien Le Moal <damien.lemoal@hgst.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Reviewed-by: Shaun Tancheff <shaun.tancheff@seagate.com>
Tested-by: Shaun Tancheff <shaun.tancheff@seagate.com>

---
 Documentation/ABI/testing/sysfs-block | 13 +++++++++++++
 block/blk-sysfs.c                     | 11 +++++++++++
 2 files changed, 24 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-block b/Documentation/ABI/testing/sysfs-block
index 75a5055..ee2d5cd 100644
--- a/Documentation/ABI/testing/sysfs-block
+++ b/Documentation/ABI/testing/sysfs-block
@@ -251,3 +251,16 @@ Description:
 		since drive-managed zoned block devices do not support
 		zone commands, they will be treated as regular block
 		devices and zoned will report "none".
+
+What:		/sys/block/<disk>/queue/chunk_sectors
+Date:		September 2016
+Contact:	Hannes Reinecke <hare@suse.com>
+Description:
+		chunk_sectors has different meaning depending on the type
+		of the disk. For a RAID device (dm-raid), chunk_sectors
+		indicates the size in 512B sectors of the RAID volume
+		stripe segment. For a zoned block device, either
+		host-aware or host-managed, chunk_sectors indicates the
+		size of 512B sectors of the zones of the device, with
+		the eventual exception of the last zone of the device
+		which may be smaller.
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index ff9cd9c..488c2e2 100644
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
@@ -455,6 +460,11 @@ static struct queue_sysfs_entry queue_physical_block_size_entry = {
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
@@ -555,6 +565,7 @@ static struct attribute *default_attrs[] = {
 	&queue_hw_sector_size_entry.attr,
 	&queue_logical_block_size_entry.attr,
 	&queue_physical_block_size_entry.attr,
+	&queue_chunk_sectors_entry.attr,
 	&queue_io_min_entry.attr,
 	&queue_io_opt_entry.attr,
 	&queue_discard_granularity_entry.attr,
-- 
2.7.4

Western Digital Corporation (and its subsidiaries) E-mail Confidentiality Notice & Disclaimer:

This e-mail and any files transmitted with it may contain confidential or legally privileged information of WDC and/or its affiliates, and are intended solely for the use of the individual or entity to which they are addressed. If you are not the intended recipient, any disclosure, copying, distribution or any action taken or omitted to be taken in reliance on it, is prohibited. If you have received this e-mail in error, please notify the sender immediately and delete the e-mail in its entirety from your system.
