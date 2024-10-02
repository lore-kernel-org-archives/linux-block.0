Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D23216A3E
	for <linux-block@vger.kernel.org>; Wed,  2 Oct 2024 21:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727903281; cv=none; b=U3HrzWbFrxOOvd7tG7xxoslBqQ2n26dmd3n0gEKRzgKGZtkNbZj4wU0btfQYxpJFruK5RcGrysvYItlLKTPcGwmRDhYReJeKPZ5navkdRUUCa7fmeY2jckWFGxsH4o9fW0U8P5AYwCK0fIZcWrggWkZwGJNGjQ+GGG8bU6ECvvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727903281; c=relaxed/simple;
	bh=uIU9/dvL8/00wNevP6Qa65WaqGjvlFsIsh0/t0VoZaY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WJV9ogJmxXcwc29zWT8snaUx1FG6r2aOEBJKSGx8NCus2aVHZ0/xFoIKOtkgEdSW5JdkK0/NFRFrONU6eug+K0dV/KF+/CUeiT4rqFweEXukOJdeYW35P1e+3fWb+B0JTh6IqaxvVidy+4uG8mqchUvwz93zMbUsFZBv0FZDlRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=ZlWn2Vsy; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="ZlWn2Vsy"
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 492KQ5lj021768
	for <linux-block@vger.kernel.org>; Wed, 2 Oct 2024 14:07:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=s2048-2021-q4; bh=BSv
	1UtrntDyJE+pBH0762wAgPVpHlECcxkaxdgUXrQQ=; b=ZlWn2Vsy6QzyuLKo0r3
	urtIKNNbTd7pGfmBiLKU2sSewjZ+juImlNp4hl0KVrg0e8Ex7uMGxymSbETRX/iO
	A9/+H9wJ3Z/+HYQyKL/Y4yFtQwX7iW9MGeHHCdTGRWpa6kbtVwRKtoOm7fAiNDdM
	haDwA6xMyadZBhzMgZI+s0ZcrFoM5hogISAG1D5ebn1Ef3MTyP7VpIUTYfd5vlBk
	xQyosIudxF/xkAaIjXEOzURqH1ml7R8+SDFqz4kqmtxE8FA5tG8BYC7tGmMKTQ7g
	TRQji9rGn1aa1WYyMuKeFBjkfDxbQO5zHJSggkkxzoibxNv7m1ssSSLnmj/teLjG
	X8w==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 42163x3fwk-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Wed, 02 Oct 2024 14:07:57 -0700 (PDT)
Received: from twshared23455.15.frc2.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Wed, 2 Oct 2024 21:07:52 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 0D39D13B8B09E; Wed,  2 Oct 2024 14:07:44 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <axboe@kernel.dk>, <linux-block@vger.kernel.org>
CC: <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH] block: enable passthrough command statistics
Date: Wed, 2 Oct 2024 14:07:44 -0700
Message-ID: <20241002210744.72321-1-kbusch@meta.com>
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
X-Proofpoint-GUID: TbyqSYcmZdE-q4VxXi662jplc6IuHAHz
X-Proofpoint-ORIG-GUID: TbyqSYcmZdE-q4VxXi662jplc6IuHAHz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-02_21,2024-09-30_01,2024-09-30_01

From: Keith Busch <kbusch@kernel.org>

Applications using the passthrough interfaces for advance protocol IO
want to continue seeing the disk stats. These requests had been fenced
off from this block layer feature. While the block layer doesn't
necessarily know what a passthrough command does, we do know the data
size and direction, which is enough to account for the command's stats.

Since tracking these has the potential to produce unexpected results,
the passthrough stats are locked behind a new queue feature flag that
needs to be enabled using the /sys/block/<dev>/queue/iostats attribute.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
This is based off the recently created for-6.13/block tree here:

  https://git.kernel.dk/cgit/linux-block/log/?h=3Dfor-6.13/block

 Documentation/ABI/stable/sysfs-block |  4 +++-
 block/blk-mq.c                       | 17 +++++++++++++-
 block/blk-sysfs.c                    | 35 +++++++++++++++++++++++++++-
 include/linux/blkdev.h               |  4 ++++
 4 files changed, 57 insertions(+), 3 deletions(-)

diff --git a/Documentation/ABI/stable/sysfs-block b/Documentation/ABI/sta=
ble/sysfs-block
index cea8856f798dd..bcf6ebedc9199 100644
--- a/Documentation/ABI/stable/sysfs-block
+++ b/Documentation/ABI/stable/sysfs-block
@@ -422,7 +422,9 @@ Date:		January 2009
 Contact:	linux-block@vger.kernel.org
 Description:
 		[RW] This file is used to control (on/off) the iostats
-		accounting of the disk.
+		accounting of the disk. Set to 0 to disable all stats. Set to 1
+		to enable block IO stats. Set to 2 to enable passthrough stats
+		in addition to block IO.
=20
=20
 What:		/sys/block/<disk>/queue/logical_block_size
diff --git a/block/blk-mq.c b/block/blk-mq.c
index ee6cde39e52b7..55809f4bd09e3 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -994,13 +994,28 @@ static inline void blk_account_io_done(struct reque=
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
+	if (!bio)
+		return false;
+	if (!bio->bi_bdev)
+		return false;
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
index e85941bec857b..99f438beb6c67 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -246,7 +246,6 @@ static ssize_t queue_##_name##_store(struct gendisk *=
disk,		\
=20
 QUEUE_SYSFS_FEATURE(rotational, BLK_FEAT_ROTATIONAL)
 QUEUE_SYSFS_FEATURE(add_random, BLK_FEAT_ADD_RANDOM)
-QUEUE_SYSFS_FEATURE(iostats, BLK_FEAT_IO_STAT)
 QUEUE_SYSFS_FEATURE(stable_writes, BLK_FEAT_STABLE_WRITES);
=20
 #define QUEUE_SYSFS_FEATURE_SHOW(_name, _feature)			\
@@ -272,6 +271,40 @@ static ssize_t queue_nr_zones_show(struct gendisk *d=
isk, char *page)
 	return queue_var_show(disk_nr_zones(disk), page);
 }
=20
+static ssize_t queue_iostats_show(struct gendisk *disk, char *page)
+{
+	return queue_var_show((bool)blk_queue_passthrough_stat(disk->queue) +
+			      (bool)blk_queue_io_stat(disk->queue), page);
+}
+
+static ssize_t queue_iostats_store(struct gendisk *disk, const char *pag=
e,
+				   size_t count)
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
+	if (!ios)
+		lim.features &=3D ~(BLK_FEAT_IO_STAT | BLK_FEAT_PASSTHROUGH_STAT);
+	else if (ios =3D=3D 2)
+		lim.features |=3D BLK_FEAT_IO_STAT | BLK_FEAT_PASSTHROUGH_STAT;
+	else if (ios =3D=3D 1) {
+		lim.features |=3D BLK_FEAT_IO_STAT;
+		lim.features &=3D ~BLK_FEAT_PASSTHROUGH_STAT;
+	}
+
+	ret =3D queue_limits_commit_update(disk->queue, &lim);
+	if (ret)
+		return ret;
+
+	return count;
+}
+
 static ssize_t queue_nomerges_show(struct gendisk *disk, char *page)
 {
 	return queue_var_show((blk_queue_nomerges(disk->queue) << 1) |
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 50c3b959da281..9a66334a6e356 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -332,6 +332,8 @@ typedef unsigned int __bitwise blk_features_t;
 #define BLK_FEAT_RAID_PARTIAL_STRIPES_EXPENSIVE \
 	((__force blk_features_t)(1u << 15))
=20
+#define BLK_FEAT_PASSTHROUGH_STAT	((__force blk_features_t)(1u << 16))
+
 /*
  * Flags automatically inherited when stacking limits.
  */
@@ -617,6 +619,8 @@ void blk_queue_flag_clear(unsigned int flag, struct r=
equest_queue *q);
 	test_bit(QUEUE_FLAG_NOXMERGES, &(q)->queue_flags)
 #define blk_queue_nonrot(q)	(!((q)->limits.features & BLK_FEAT_ROTATIONA=
L))
 #define blk_queue_io_stat(q)	((q)->limits.features & BLK_FEAT_IO_STAT)
+#define blk_queue_passthrough_stat(q)	\
+	((q)->limits.features & BLK_FEAT_PASSTHROUGH_STAT)
 #define blk_queue_dax(q)	((q)->limits.features & BLK_FEAT_DAX)
 #define blk_queue_pci_p2pdma(q)	((q)->limits.features & BLK_FEAT_PCI_P2P=
DMA)
 #ifdef CONFIG_BLK_RQ_ALLOC_TIME
--=20
2.43.5

