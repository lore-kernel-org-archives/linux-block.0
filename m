Return-Path: <linux-scsi-owner@vger.kernel.org>
From: Damien Le Moal <damien.lemoal@wdc.com>
To: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>,
        Matias Bjorling <matias.bjorling@wdc.com>
Subject: [PATCH 09/11] block: Expose queue nr_zones in sysfs
Date: Wed, 10 Oct 2018 10:52:37 +0900
Message-Id: <20181010015239.24930-10-damien.lemoal@wdc.com>
In-Reply-To: <20181010015239.24930-1-damien.lemoal@wdc.com>
References: <20181010015239.24930-1-damien.lemoal@wdc.com>
Sender: linux-scsi-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

Expose through sysfs the nr_zones field of a zoned block device request
queue. This represents the total number of zones of the device
calculated using the known disk capacity and zone size.

Exposing this value helps in debugging disk issues as well as
facilitating scripts based use of the disk (e.g. blktests).

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 block/blk-sysfs.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 3772671cf2bc..f7060a938bf9 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -300,6 +300,11 @@ static ssize_t queue_zoned_show(struct request_queue *q, char *page)
 	}
 }
 
+static ssize_t queue_nr_zones_show(struct request_queue *q, char *page)
+{
+	return queue_var_show(q->nr_zones, page);
+}
+
 static ssize_t queue_nomerges_show(struct request_queue *q, char *page)
 {
 	return queue_var_show((blk_queue_nomerges(q) << 1) |
@@ -637,6 +642,11 @@ static struct queue_sysfs_entry queue_zoned_entry = {
 	.show = queue_zoned_show,
 };
 
+static struct queue_sysfs_entry queue_nr_zones_entry = {
+	.attr = {.name = "nr_zones", .mode = 0444 },
+	.show = queue_nr_zones_show,
+};
+
 static struct queue_sysfs_entry queue_nomerges_entry = {
 	.attr = {.name = "nomerges", .mode = 0644 },
 	.show = queue_nomerges_show,
@@ -727,6 +737,7 @@ static struct attribute *default_attrs[] = {
 	&queue_write_zeroes_max_entry.attr,
 	&queue_nonrot_entry.attr,
 	&queue_zoned_entry.attr,
+	&queue_nr_zones_entry.attr,
 	&queue_nomerges_entry.attr,
 	&queue_rq_affinity_entry.attr,
 	&queue_iostats_entry.attr,
-- 
2.17.1
