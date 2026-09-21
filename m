Received: from mta1.migadu.com (out-224.mta1.migadu.com [95.215.58.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72AD456DE2
	for <linux-block@vger.kernel.org>; Mon, 21 Sep 2026 08:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789979902; cv=none; b=Mb4Teh7eVu3ob+6ah1eOYr6aDUVwdQg3NwM0xEQ+IBGRrrGBQyLV+Oh6sibkQ8hSJAUOaOxciIzB7krzyjEt5PKweCy3P8bfIgEmkeAt731MOK2s/o8Ku1SXtnWm6rBRiGKTfZd3s7wRoTYpknOSBBV9f50nvIqEreQC8J38lg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789979902; c=relaxed/simple;
	bh=CyYEsYiDmgMUgwn5djnlaruTgvmjRSRmVi5fM9yhJOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VOGwNNAoDJj6k2kglw1vwOG7Mckug25/4W3QEMrOA1kUceJWjzqzq7BnP71pxREz80Rk8Bn0mFZF7dWlqPjfJiNjecEfc+36qqBqh9YbmtaKILlSNeV6ak4JGdhTxHlIrGGEYoZuf9rEbnektBmT3H3S8LJI06nVTsO76VxdKCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kssizVvu; arc=none smtp.client-ip=95.215.58.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kssizVvu"
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=CyYEsYiDmgMUgwn5djnlaruTgvmjRSRmVi5fM9yhJOA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789979898; v=1; x=1790584698;
 b=kssizVvuQYWXQONWgTV9ccYkvMnwRyYculof1E3i23gElHD0EdrhHJYEPHUiwMQ7az414mgv
 Aui6S6+2hBjXN+peFXoIz2Mo0C6ZgQT6F/5Iq+hQI4eWw7Fuz80JIbWv2Xq7c8XPOARan0pv0gg
 6rQUdhJGYzpVTFBX+1AG71kM=
X-Envelope-To: linux-block@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id ba07615db5f16531;
	Mon, 21 Sep 2026 08:38:18 +0000
X-Mizu-Trace-ID: ba07615db5f16531
X-Migadu-Flow: FLOW_OUT
From: John Garry <john.garry@linux.dev>
To: axboe@kernel.dk,
	kbusch@kernel.org,
	sagi@grimberg.me,
	hch@lst.de
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	John Garry <john.garry@linux.dev>
Subject: [PATCH v4 4/4] nvme-multipath: fix diskstats for partitions
Date: Mon, 21 Sep 2026 09:37:52 +0100
Message-ID: <20260921083752.1154316-5-john.garry@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260921083752.1154316-1-john.garry@linux.dev>
References: <20260921083752.1154316-1-john.garry@linux.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently diskstats for partitions are never updated:
$ ./fio_read nvme1n1p1 # run traffic on /dev/nvme1n1p1
...
$ more /proc/diskstats | grep nvme1
259       2 nvme1c1n1 49857 0 400344 768565 0 0 0 0 0 2334 768565 0 0 0 0 0 0
259       3 nvme1n1 99710 0 800680 1599285 0 0 0 0 0 2346 1599285 0 0 0 0 0 0
259       5 nvme1n1p1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
259       4 nvme1c2n1 49853 0 400336 831472 0 0 0 0 0 2315 831472 0 0 0 0 0 0

This is because we only ever update the diskstats for the multipath disk in
nvme_mpath_end_request(), and we never take into account that the original
bi_bdev may been a partition of this disk.

Functions bdev_start_io_acct() and bdev_start_io_acct() do handle
updating diskstats for a partition, in that they also update the whole
disk also (if a partition), so use the partition (if applicable) when
calling those functions.

Change any functionality which used to lookup the gendisk part0 to now
lookup the specific gendisk partition.

Signed-off-by: John Garry <john.garry@linux.dev>
---
 drivers/nvme/host/multipath.c | 51 ++++++++++++++++++++++++++++-------
 1 file changed, 41 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index e871ad40d893..2969c0e5187c 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -144,6 +144,23 @@ void nvme_mpath_start_freeze(struct nvme_subsystem *subsys)
 			blk_freeze_queue_start(h->disk->queue);
 }
 
+static struct block_device *nvme_disk_to_part(struct gendisk *disk,
+						u8 partno)
+{
+	/* Quick lookup for whole disk */
+	if (!partno)
+		return disk->part0;
+	return xa_load(&disk->part_tbl, partno);
+}
+
+static struct block_device *nvme_to_disk_part(struct gendisk *disk,
+					struct block_device *bdev)
+{
+	if (!bdev)
+		return disk->part0;
+	return nvme_disk_to_part(disk, bdev_partno(bdev));
+}
+
 void nvme_failover_req(struct request *req)
 {
 	struct nvme_ns *ns = req->q->queuedata;
@@ -165,8 +182,10 @@ void nvme_failover_req(struct request *req)
 	}
 
 	spin_lock_irqsave(&ns->head->requeue_lock, flags);
-	for (bio = req->bio; bio; bio = bio->bi_next)
-		bio_set_dev(bio, ns->head->disk->part0);
+	for (bio = req->bio; bio; bio = bio->bi_next) {
+		bio_set_dev(bio, nvme_to_disk_part(ns->head->disk,
+				bio->bi_bdev));
+	}
 	blk_steal_bios(&ns->head->requeue_list, req);
 	spin_unlock_irqrestore(&ns->head->requeue_lock, flags);
 
@@ -194,8 +213,9 @@ void nvme_mpath_start_request(struct request *rq)
 		return;
 
 	nvme_req(rq)->flags |= NVME_MPATH_IO_STATS;
-	nvme_req(rq)->start_time = bdev_start_io_acct(disk->part0, req_op(rq),
-						      jiffies);
+	nvme_req(rq)->start_time = bdev_start_io_acct(
+			nvme_to_disk_part(disk, rq->part),
+			req_op(rq), jiffies);
 }
 EXPORT_SYMBOL_GPL(nvme_mpath_start_request);
 
@@ -208,7 +228,8 @@ void nvme_mpath_end_request(struct request *rq)
 
 	if (!(nvme_req(rq)->flags & NVME_MPATH_IO_STATS))
 		return;
-	bdev_end_io_acct(ns->head->disk->part0, req_op(rq),
+	bdev_end_io_acct(nvme_to_disk_part(ns->head->disk,
+			 rq->part), req_op(rq),
 			 blk_rq_bytes(rq) >> SECTOR_SHIFT,
 			 nvme_req(rq)->start_time);
 }
@@ -530,11 +551,21 @@ static bool nvme_available_path(struct nvme_ns_head *head)
 	return nvme_mpath_queue_if_no_path(head);
 }
 
+static struct block_device *nvme_find_path_bdev(struct nvme_ns_head *head,
+						u8 partno)
+{
+	struct nvme_ns *ns = nvme_find_path(head);
+
+	if (!ns)
+		return NULL;
+	return nvme_disk_to_part(ns->disk, partno);
+}
+
 static void nvme_ns_head_submit_bio(struct bio *bio)
 {
 	struct nvme_ns_head *head = bio->bi_bdev->bd_disk->private_data;
 	struct device *dev = disk_to_dev(head->disk);
-	struct nvme_ns *ns;
+	struct block_device *bdev;
 	int srcu_idx;
 
 	/*
@@ -547,9 +578,9 @@ static void nvme_ns_head_submit_bio(struct bio *bio)
 		return;
 
 	srcu_idx = srcu_read_lock(&head->srcu);
-	ns = nvme_find_path(head);
-	if (likely(ns)) {
-		bio_set_dev(bio, ns->disk->part0);
+	bdev = nvme_find_path_bdev(head, bdev_partno(bio->bi_bdev));
+	if (likely(bdev)) {
+		bio_set_dev(bio, bdev);
 		/*
 		 * Use BIO_REMAPPED to skip bio_check_eod() when this bio
 		 * enters submit_bio_noacct() for the per-path device. The EOD
@@ -557,7 +588,7 @@ static void nvme_ns_head_submit_bio(struct bio *bio)
 		 */
 		bio_set_flag(bio, BIO_REMAPPED);
 		bio->bi_opf |= REQ_NVME_MPATH;
-		trace_block_bio_remap(bio, disk_devt(ns->head->disk),
+		trace_block_bio_remap(bio, disk_devt(head->disk),
 				      bio->bi_iter.bi_sector);
 		submit_bio_noacct(bio);
 	} else if (nvme_available_path(head)) {
-- 
2.43.0

