Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008B91A0BF6
	for <linux-block@vger.kernel.org>; Thu,  3 Oct 2024 15:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727969446; cv=none; b=kQAuvEV547rhk8Jx85JCtpYoOEQTj+w/gc5m1K7H9EWLU0SmgO37K5txAu0OfphBKMowShQNCMn6/NXOSPLR6gRlyzBebADjCT/jfBbAqPrFWBVOAOw6dvXsHN5AKkB3oqbD9b3Z5xZ+NH6229H1HYaoOHY4gQR9VWWSxmklZEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727969446; c=relaxed/simple;
	bh=ihyEuhf8RXDlWjMsvFJcHceP0BxEx8jEfPSnllxRU0U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uqyb0nW0+2BfnZhe6EPUkl2q95REI7V8oKSz89maUvFh+oJoEcax/qsMZTbD5unUgeWVNGhz9vKUvMQJemJie1frar2qMFA0RUpUIsijL5ilLz4sb7SnfHE8Mv/5Ip4faZnk+gCzSbwBbQrZRWYOYS2IHivd7YKkwz3Xc0E6HpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=CNcL7ho5; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="CNcL7ho5"
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4935dIJB001652
	for <linux-block@vger.kernel.org>; Thu, 3 Oct 2024 08:30:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=s2048-2021-q4; bh=lip
	KphSs6a9/GiT5Ho0ZLiFrRuNksaBKG9hDUS6DKVs=; b=CNcL7ho52H5RF3g1Q+E
	BxnS+GapWGTWNYEmZQyUTEGNMZmhbGyZb59itHC+Ce87gjF6uPSajNDb/u5CfF8e
	lhPsFKh+11Ek7LJLMAXdNU7sJCgaTTicvaXnwQJI59wn2bUZPKeRWIzFHCbYbhkG
	SVguSJx5wxYuKpzZYLU0dI5yWyPay6Ck8KSepd6tXJaxsSRnhWgChPWjhQlEQKVi
	P8ZlomG0G0DpDLEw2z24A/5rpdOFPJQQsbDB+fptIixLhF229eZbtk+KlC1tc6Oo
	glN5H7/vvI5cEIgAFbCiWmkW0cHmCPPFvHsDzwTe+rO2RqmXzNQueYBd9C/XiEW+
	7Dw==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 421cet5c3s-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Thu, 03 Oct 2024 08:30:43 -0700 (PDT)
Received: from twshared17102.15.frc2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Thu, 3 Oct 2024 15:30:41 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 556EE13C09D63; Thu,  3 Oct 2024 08:30:37 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <axboe@kernel.dk>
CC: <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv2] block: enable passthrough command statistics
Date: Thu, 3 Oct 2024 08:30:36 -0700
Message-ID: <20241003153036.411721-1-kbusch@meta.com>
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
X-Proofpoint-ORIG-GUID: nD78Y9k2eefqolwWsoN-5sASjzVUhy-a
X-Proofpoint-GUID: nD78Y9k2eefqolwWsoN-5sASjzVUhy-a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-03_15,2024-10-03_01,2024-09-30_01

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
v1->v2:

  Moved the passthrough stats enabling to its own attribute instead of
  overloading the existing iostats

  Added comments to the criteria for allowing passthrough stats

Based on block for-6.13/block tree:

  https://git.kernel.dk/cgit/linux-block/log/?h=3Dfor-6.13/block

 Documentation/ABI/stable/sysfs-block |  7 +++++++
 block/blk-mq-debugfs.c               |  1 +
 block/blk-mq.c                       | 27 ++++++++++++++++++++++++++-
 block/blk-sysfs.c                    | 26 ++++++++++++++++++++++++++
 include/linux/blkdev.h               |  3 +++
 5 files changed, 63 insertions(+), 1 deletion(-)

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
diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 5463697a84428..d9d7fd441297e 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -93,6 +93,7 @@ static const char *const blk_queue_flag_name[] =3D {
 	QUEUE_FLAG_NAME(RQ_ALLOC_TIME),
 	QUEUE_FLAG_NAME(HCTX_ACTIVE),
 	QUEUE_FLAG_NAME(SQ_SCHED),
+	QUEUE_FLAG_NAME(IOSTATS_PASSTHROUGH),
 };
 #undef QUEUE_FLAG_NAME
=20
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 8e75e3471ea58..cf309b39bac04 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -993,13 +993,38 @@ static inline void blk_account_io_done(struct reque=
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
+	/*
+	 * Stats are accumulated in the bdev part, so must have one attached to
+	 * a bio to do this
+	 */
+	if (!bio)
+		return false;
+	if (!bio->bi_bdev)
+		return false;
+
+	/*
+	 * Ensuring the size is aligned to the block size prevents observing an
+	 * invalid sectors stat.
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
index e85941bec857b..a4b32047ff680 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -272,6 +272,30 @@ static ssize_t queue_nr_zones_show(struct gendisk *d=
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
+	unsigned long ios;
+	ssize_t ret;
+
+	ret =3D queue_var_store(&ios, page, count);
+	if (ret < 0)
+		return ret;
+
+	if (ios)
+		blk_queue_flag_set(QUEUE_FLAG_IOSTATS_PASSTHROUGH,
+				   disk->queue);
+	else
+		blk_queue_flag_clear(QUEUE_FLAG_IOSTATS_PASSTHROUGH,
+				     disk->queue);
+
+	return count;
+}
 static ssize_t queue_nomerges_show(struct gendisk *disk, char *page)
 {
 	return queue_var_show((blk_queue_nomerges(disk->queue) << 1) |
@@ -460,6 +484,7 @@ QUEUE_RO_ENTRY(queue_max_open_zones, "max_open_zones"=
);
 QUEUE_RO_ENTRY(queue_max_active_zones, "max_active_zones");
=20
 QUEUE_RW_ENTRY(queue_nomerges, "nomerges");
+QUEUE_RW_ENTRY(queue_iostats_passthrough, "iostats_passthrough");
 QUEUE_RW_ENTRY(queue_rq_affinity, "rq_affinity");
 QUEUE_RW_ENTRY(queue_poll, "io_poll");
 QUEUE_RW_ENTRY(queue_poll_delay, "io_poll_delay");
@@ -586,6 +611,7 @@ static struct attribute *queue_attrs[] =3D {
 	&queue_max_open_zones_entry.attr,
 	&queue_max_active_zones_entry.attr,
 	&queue_nomerges_entry.attr,
+	&queue_iostats_passthrough_entry.attr,
 	&queue_iostats_entry.attr,
 	&queue_stable_writes_entry.attr,
 	&queue_add_random_entry.attr,
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 50c3b959da281..734a32efa77d7 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -602,6 +602,7 @@ enum {
 	QUEUE_FLAG_RQ_ALLOC_TIME,	/* record rq->alloc_time_ns */
 	QUEUE_FLAG_HCTX_ACTIVE,		/* at least one blk-mq hctx is active */
 	QUEUE_FLAG_SQ_SCHED,		/* single queue style io dispatch */
+	QUEUE_FLAG_IOSTATS_PASSTHROUGH,	/* passthrough command IO accounting */
 	QUEUE_FLAG_MAX
 };
=20
@@ -617,6 +618,8 @@ void blk_queue_flag_clear(unsigned int flag, struct r=
equest_queue *q);
 	test_bit(QUEUE_FLAG_NOXMERGES, &(q)->queue_flags)
 #define blk_queue_nonrot(q)	(!((q)->limits.features & BLK_FEAT_ROTATIONA=
L))
 #define blk_queue_io_stat(q)	((q)->limits.features & BLK_FEAT_IO_STAT)
+#define blk_queue_passthrough_stat(q)	\
+	test_bit(QUEUE_FLAG_IOSTATS_PASSTHROUGH, &(q)->queue_flags)
 #define blk_queue_dax(q)	((q)->limits.features & BLK_FEAT_DAX)
 #define blk_queue_pci_p2pdma(q)	((q)->limits.features & BLK_FEAT_PCI_P2P=
DMA)
 #ifdef CONFIG_BLK_RQ_ALLOC_TIME
--=20
2.43.5

