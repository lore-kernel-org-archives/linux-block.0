Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597F91D4320
	for <linux-block@vger.kernel.org>; Mon,  7 Oct 2024 15:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728315167; cv=none; b=UAR4Xd0n9qXj1FzPS2+dlFsZ+UzZcFRD9peeyiP81wCj0kVKRORls91r8l1fNH7hrWRa7Mki0W7m5FO7iyp3xRZUQaWelYxXY7zhAo+6yvBGVp0/C9kUsqgABzPRJbHpYBP9gAy8JPViEbTCAwgcl8KLnJkJOeNT7bPIcrjTRRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728315167; c=relaxed/simple;
	bh=YVYu0sKqjpi29uGWvdwCTq6gOnJbPjTO+O2Tu51mXDg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=K2vKyDe4RzTtspagDTtqcc3yMlxiV8RjogklsdS2i9li8PRx56XYZSuUP2kPKT7usGGMupwJhZrhvigvUHzjNa9BXR3SQAp6mIEv4FJM/pKEZvuR9V789AbR9EunqWW4u0YG8C1wKOH/V8Br7kG+7fFFKNlv5+/qwpqXjcaEj+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=j1uOpgWW; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="j1uOpgWW"
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 497BiB5o012931
	for <linux-block@vger.kernel.org>; Mon, 7 Oct 2024 08:32:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2021-q4; bh=mz0ZXVB2Pp5wTPk9EA
	Wb62/gkqTs3NDpTKaDoGyTTlE=; b=j1uOpgWW09deErS6DElQUrZ4/NlvrY1Fc7
	Xq9elIej1QH8E6N+uxfGUiBXubneZhWiDFoeSUgNec8m5VoYM0mJobKoRt0KxKu1
	AMJjELok5NNHSdJ1iex9+wZ0w3cow9U3x5Rb8BZ7eYiJdFvRNa3iN6baluQxfIXn
	bkKNJa61vR/jfcXpti+aIaUc9hmW7ZsGCZguQs7s0wbsTgvsx/y+xBHSr6/sA5ZL
	UbV5QBrHU2fD3gboTibxeGT/uoeb49PZ+TBWaCIPEgFmswKU296udo/b/LPU49Kb
	+PSfyRmwi7hOepg8ed5eXh5OyuyHoWL4yrTR+vBDD8s+63c8W3ww==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 42339rs6rv-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Mon, 07 Oct 2024 08:32:44 -0700 (PDT)
Received: from twshared60308.03.ash8.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Mon, 7 Oct 2024 15:32:41 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 742BD13E69239; Mon,  7 Oct 2024 08:32:36 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <axboe@kernel.dk>, <linux-block@vger.kernel.org>
CC: <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv3] block: enable passthrough command statistics
Date: Mon, 7 Oct 2024 08:32:35 -0700
Message-ID: <20241007153236.2818562-1-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: ggg7RMzyW0pJ8-Q1jEJDEkPHGAbrDnpX
X-Proofpoint-ORIG-GUID: ggg7RMzyW0pJ8-Q1jEJDEkPHGAbrDnpX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

From: Keith Busch <kbusch@kernel.org>

Applications using the passthrough interfaces for IO want to continue
seeing the disk stats. These requests had been fenced off from this
block layer feature. While the block layer doesn't necessarily know what
a passthrough command does, we do know the data size and direction,
which is enough to account for the command's stats.

Since tracking these has the potential to produce unexpected results,
the passthrough stats are locked behind a new queue flag that needs to
be enabled with the /sys/block/<dev>/queue/iostats_passthrough
attribute.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
v2->v3:

  Use the queue's limit.flag instead of the queue flags

  More descriptive comments on statistics tracking criteria

 Documentation/ABI/stable/sysfs-block |  7 ++++++
 block/blk-mq.c                       | 32 +++++++++++++++++++++++++++-
 block/blk-sysfs.c                    | 30 ++++++++++++++++++++++++++
 include/linux/blkdev.h               |  5 +++++
 4 files changed, 73 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/stable/sysfs-block b/Documentation/ABI/sta=
ble/sysfs-block
index cea8856f798dd..8353611107154 100644
--- a/Documentation/ABI/stable/sysfs-block
+++ b/Documentation/ABI/stable/sysfs-block
@@ -424,6 +424,13 @@ Description:
 		[RW] This file is used to control (on/off) the iostats
 		accounting of the disk.
=20
+What:		/sys/block/<disk>/queue/iostats_passthrough
+Date:		October 2024
+Contact:	linux-block@vger.kernel.org
+Description:
+		[RW] This file is used to control (on/off) the iostats
+		accounting of the disk for passthrough commands.
+
=20
 What:		/sys/block/<disk>/queue/logical_block_size
 Date:		May 2009
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 03f68a8e74078..64aba14170f7e 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -988,13 +988,43 @@ static inline void blk_account_io_done(struct reque=
st *req, u64 now)
 	}
 }
=20
+static inline bool blk_rq_passthrough_stats(struct request *req)
+{
+	struct bio *bio =3D req->bio;
+
+	if (!blk_queue_passthrough_stat(req->q))
+		return false;
+
+	/* Requests without a bio do not transfer data. */
+	if (!bio)
+		return false;
+
+	/*
+	 * Stats are accumulated in the bdev, so must have one attached to a
+	 * bio to track stats. Most drivers do not set the bdev for passthrough
+	 * requests, but nvme is one that will set it.
+	 */
+	if (!bio->bi_bdev)
+		return false;
+
+	/*
+	 * We don't know what a passthrough command does, but we know the
+	 * payload size and data direction. Ensuring the size is aligned to the
+	 * block size filters out most commands with payloads that don't
+	 * represent sector access.
+	 */
+	if (blk_rq_bytes(req) & (bdev_logical_block_size(bio->bi_bdev) - 1))
+		return false;
+	return true;
+}
+
 static inline void blk_account_io_start(struct request *req)
 {
 	trace_block_io_start(req);
=20
 	if (!blk_queue_io_stat(req->q))
 		return;
-	if (blk_rq_is_passthrough(req))
+	if (blk_rq_is_passthrough(req) && !blk_rq_passthrough_stats(req))
 		return;
=20
 	req->rq_flags |=3D RQF_IO_STAT;
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index e85941bec857b..0914494494f3c 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -272,6 +272,34 @@ static ssize_t queue_nr_zones_show(struct gendisk *d=
isk, char *page)
 	return queue_var_show(disk_nr_zones(disk), page);
 }
=20
+static ssize_t queue_iostats_passthrough_show(struct gendisk *disk, char=
 *page)
+{
+	return queue_var_show(blk_queue_passthrough_stat(disk->queue), page);
+}
+
+static ssize_t queue_iostats_passthrough_store(struct gendisk *disk,
+					       const char *page, size_t count)
+{
+	struct queue_limits lim;
+	unsigned long ios;
+	ssize_t ret;
+
+	ret =3D queue_var_store(&ios, page, count);
+	if (ret < 0)
+		return ret;
+
+	lim =3D queue_limits_start_update(disk->queue);
+	if (ios)
+		lim.flags |=3D BLK_FLAG_IOSTATS_PASSTHROUGH;
+	else
+		lim.flags &=3D ~BLK_FLAG_IOSTATS_PASSTHROUGH;
+
+	ret =3D queue_limits_commit_update(disk->queue, &lim);
+	if (ret)
+		return ret;
+
+	return count;
+}
 static ssize_t queue_nomerges_show(struct gendisk *disk, char *page)
 {
 	return queue_var_show((blk_queue_nomerges(disk->queue) << 1) |
@@ -460,6 +488,7 @@ QUEUE_RO_ENTRY(queue_max_open_zones, "max_open_zones"=
);
 QUEUE_RO_ENTRY(queue_max_active_zones, "max_active_zones");
=20
 QUEUE_RW_ENTRY(queue_nomerges, "nomerges");
+QUEUE_RW_ENTRY(queue_iostats_passthrough, "iostats_passthrough");
 QUEUE_RW_ENTRY(queue_rq_affinity, "rq_affinity");
 QUEUE_RW_ENTRY(queue_poll, "io_poll");
 QUEUE_RW_ENTRY(queue_poll_delay, "io_poll_delay");
@@ -586,6 +615,7 @@ static struct attribute *queue_attrs[] =3D {
 	&queue_max_open_zones_entry.attr,
 	&queue_max_active_zones_entry.attr,
 	&queue_nomerges_entry.attr,
+	&queue_iostats_passthrough_entry.attr,
 	&queue_iostats_entry.attr,
 	&queue_stable_writes_entry.attr,
 	&queue_add_random_entry.attr,
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index a6aae750b4ac9..6b78a68e0bd9c 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -349,6 +349,9 @@ typedef unsigned int __bitwise blk_flags_t;
 /* I/O topology is misaligned */
 #define BLK_FLAG_MISALIGNED		((__force blk_flags_t)(1u << 1))
=20
+/* passthrough command IO accounting */
+#define BLK_FLAG_IOSTATS_PASSTHROUGH	((__force blk_flags_t)(1u << 2))
+
 struct queue_limits {
 	blk_features_t		features;
 	blk_flags_t		flags;
@@ -617,6 +620,8 @@ void blk_queue_flag_clear(unsigned int flag, struct r=
equest_queue *q);
 	test_bit(QUEUE_FLAG_NOXMERGES, &(q)->queue_flags)
 #define blk_queue_nonrot(q)	(!((q)->limits.features & BLK_FEAT_ROTATIONA=
L))
 #define blk_queue_io_stat(q)	((q)->limits.features & BLK_FEAT_IO_STAT)
+#define blk_queue_passthrough_stat(q)	\
+	((q)->limits.flags & BLK_FLAG_IOSTATS_PASSTHROUGH)
 #define blk_queue_dax(q)	((q)->limits.features & BLK_FEAT_DAX)
 #define blk_queue_pci_p2pdma(q)	((q)->limits.features & BLK_FEAT_PCI_P2P=
DMA)
 #ifdef CONFIG_BLK_RQ_ALLOC_TIME
--=20
2.43.5

