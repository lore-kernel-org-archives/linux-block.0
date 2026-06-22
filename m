Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCC034104E
	for <linux-block@vger.kernel.org>; Mon, 22 Jun 2026 17:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782150186; cv=none; b=SIpqVnXblbVuhsc2xLfHqlt+ceixVhPxYQyf23WQak4rTKb32g6xbNjHI077H3KHsTG4MbNVmswewFBOcfvnta78f48lMNiais/1sVwoY5zqQ9coVzwVSFIajac2x2e9+pv5Mad9jMH76aPMXiDIQgTFxHPAscEuL+SAVRn2nXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782150186; c=relaxed/simple;
	bh=n5ksvNst397l+VMOtxSnIEmKY6BEbGxOtXQdHzzHT+A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DUhwHd+Cl2yVEFFOCy9eM5c9XR1wbBaLhhDWxuxTZn6mkXySumRIBQtYIcyN4Z9Zg3BE/nt9WxaGrgY0MW4XzPPjtAriZGAPySdIrEzuZyeYMSW7gTjcs5+eNT4YTrZB32Qwcwn55X95CQ6YPJ9KdeFlvbbG/e/MLHDb7QVvg8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=HzUQ0rkt; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="HzUQ0rkt"
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65MHVZ342375540
	for <linux-block@vger.kernel.org>; Mon, 22 Jun 2026 10:43:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=BCEC6ojtpv/CLRv6wwQZLM4wTIQf7c5sMaYy+YbszdU=; b=HzUQ0rktxPZe
	Lw5lJ4VMOl5aYs78sQniXC+2wQEye/aR4cErQcIW6fuT49yYbL6uROoKsufkwjoj
	FNz6b2V84z7DergwmsOSYe+VF20dTUoNYkjv39CY1gfg1irSYQ4TE1/BT0//5wVx
	m84V+m6DYQAeuKL4bOmHNQTXIrzUQ88xY3495QZE2DuON5jkGDWnmF7JqSSV18wQ
	IdLzTwBAFRVSUWME+T1UZ34rsiXF6AyaM/yHzgME6/Z889XKdZMEL9/6z6cqK+NY
	k1FHNKTSALFDfd/sHW3pgfg+6B7Me095fzRi4ZWNFjdUJkyhoYEKf6cbX5Co7Fq2
	20vRZ73mdg==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4ewt5jvkp8-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Mon, 22 Jun 2026 10:43:04 -0700 (PDT)
Received: from twshared16966.02.snb1.facebook.com (2620:10d:c0a8:1c::11) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.41; Mon, 22 Jun 2026 17:43:01 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id CAB9523A15DE2; Mon, 22 Jun 2026 10:42:46 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
CC: <dm-devel@lists.linux.dev>, <hch@lst.de>, <axboe@kernel.dk>,
        <brauner@kernel.org>, <djwong@kernel.org>, <viro@zeniv.linux.org.uk>,
        Keith
 Busch <kbusch@kernel.org>
Subject: [PATCHv2 4/6] loop: set dma_alignment from the backing file for direct I/O
Date: Mon, 22 Jun 2026 10:42:39 -0700
Message-ID: <20260622174241.2299563-5-kbusch@meta.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260622174241.2299563-1-kbusch@meta.com>
References: <20260622174241.2299563-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=I65Vgtgg c=1 sm=1 tr=0 ts=6a397428 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=crHB47gyY4rKiduisYu9:22 a=VwQbUJbxAAAA:8 a=w3YrK2sSALtTPwlh2GsA:9
X-Proofpoint-GUID: KC3VvU6QbTGn7J2Zc8d-Z_E0W1UGjTCu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDE3MyBTYWx0ZWRfXy7IgNuBp6b29
 dnfHyrX+xCuchlVdoedLsjRqy/z3lPbAbIHC75+/puBnGYFfPOQtB7UVdf2NPA2nnIqcUkh/P5/
 aClE63XDRlUGegMxOIOOWGG8P4LgLos7XZso71+m3GtlM9qJFl2c2+MvoIxjnpZSXu8PD+CKV87
 jmaJJYJepN7CNrHgnISNAvB597DWEs3yRljyfIuuxMYVp2jsQQaoGrCt2jybDamSK9cyMm2C/Pa
 1rXjQjN00EBPATKqBrU6CrwNRftYYP56LDtjzj8K/HmJ236pb3vPuXagNVStezodP8fkITqcqXU
 xEolSqiv4padtxc+H8GNcdS5BQWm87/LjKl8vbhy1Vh9tG1Als3RMmZ8FlndQm+WyVEcg7OA0G9
 4alvpbtQiHPVg3pi4zziouFn4utcE2qKZmPcnOTBQA7VOqgq0779nx4qFtj204teEPPtToZdu9z
 Eo7P+rXOCQcICsxXAFw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDE3MyBTYWx0ZWRfX0OX8RdstYkTg
 t+zi90J2qIdCgFqFfwKXVIU0UQXAzoiPBerZibFkJ0Y8hh4y3TB1r3ZXyiXGNvOnb3O6GTCS+on
 IzNzxnsP9TdvKiTtqLeV8gQsDk+BZ+Y=
X-Proofpoint-ORIG-GUID: KC3VvU6QbTGn7J2Zc8d-Z_E0W1UGjTCu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_03,2026-06-22_01,2025-10-01_01

From: Keith Busch <kbusch@kernel.org>

Direct I/O user pages are forwarded to the backing file unchanged, so
the backing's DMA alignment requirement applies to them. Track the
backing's dio_mem_align and advertise it as the loop device's
dma_alignment so we advertise proper limits and misaligned I/O is
rejected here instead of being dispatched to the backend.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/block/loop.c | 50 +++++++++++++++++++++++++++++++++++++-------
 1 file changed, 42 insertions(+), 8 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 310de0463beb1..7114f80ab162a 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -54,6 +54,7 @@ struct loop_device {
=20
 	struct file	*lo_backing_file;
 	unsigned int	lo_min_dio_size;
+	unsigned int	lo_dio_mem_align;
 	struct block_device *lo_device;
=20
 	gfp_t		old_gfp_mask;
@@ -447,26 +448,37 @@ static void loop_reread_partitions(struct loop_devi=
ce *lo)
 			__func__, lo->lo_number, lo->lo_file_name, rc);
 }
=20
-static unsigned int loop_query_min_dio_size(struct loop_device *lo)
+static void loop_update_dio_alignment(struct loop_device *lo)
 {
 	struct file *file =3D lo->lo_backing_file;
 	struct block_device *sb_bdev =3D file->f_mapping->host->i_sb->s_bdev;
 	struct kstat st;
=20
 	/*
-	 * Use the minimal dio alignment of the file system if provided.
+	 * Use the dio alignment of the file system if provided.  dio_offset_al=
ign
+	 * is the minimum dio size and offset; dio_mem_align is the buffer memo=
ry
+	 * alignment, kept as a mask to become the loop device's dma_alignment =
in
+	 * direct I/O mode where the buffer is handed to the backing file uncha=
nged.
 	 */
 	if (!vfs_getattr(&file->f_path, &st, STATX_DIOALIGN, 0) &&
-	    (st.result_mask & STATX_DIOALIGN))
-		return st.dio_offset_align;
+	    (st.result_mask & STATX_DIOALIGN)) {
+		lo->lo_min_dio_size =3D st.dio_offset_align;
+		lo->lo_dio_mem_align =3D st.dio_mem_align - 1;
+		return;
+	}
=20
 	/*
 	 * In a perfect world this wouldn't be needed, but as of Linux 6.13 onl=
y
 	 * a handful of file systems support the STATX_DIOALIGN flag.
 	 */
-	if (sb_bdev)
-		return bdev_logical_block_size(sb_bdev);
-	return SECTOR_SIZE;
+	if (sb_bdev) {
+		lo->lo_min_dio_size =3D bdev_logical_block_size(sb_bdev);
+		lo->lo_dio_mem_align =3D bdev_dma_alignment(sb_bdev);
+		return;
+	}
+
+	lo->lo_min_dio_size =3D SECTOR_SIZE;
+	lo->lo_dio_mem_align =3D SECTOR_SIZE - 1;
 }
=20
 static inline int is_loop_device(struct file *file)
@@ -509,7 +521,7 @@ static void loop_assign_backing_file(struct loop_devi=
ce *lo, struct file *file)
 			lo->old_gfp_mask & ~(__GFP_IO | __GFP_FS));
 	if (lo->lo_backing_file->f_flags & O_DIRECT)
 		lo->lo_flags |=3D LO_FLAGS_DIRECT_IO;
-	lo->lo_min_dio_size =3D loop_query_min_dio_size(lo);
+	loop_update_dio_alignment(lo);
 }
=20
 static int loop_check_backing_file(struct file *file)
@@ -961,6 +973,17 @@ static void loop_update_limits(struct loop_device *l=
o, struct queue_limits *lim,
 	lim->logical_block_size =3D bsize;
 	lim->physical_block_size =3D bsize;
 	lim->io_min =3D bsize;
+	/*
+	 * In direct I/O the user pages are handed to the backing file as-is, s=
o
+	 * the backing's DMA alignment requirement applies to them.  Advertise =
it
+	 * so misaligned I/O is rejected at this device's entry instead of bein=
g
+	 * dispatched to the backend.  Buffered I/O copies through the page cac=
he
+	 * and imposes no such requirement.
+	 */
+	if (lo->lo_flags & LO_FLAGS_DIRECT_IO)
+		lim->dma_alignment =3D lo->lo_dio_mem_align;
+	else
+		lim->dma_alignment =3D SECTOR_SIZE - 1;
 	lim->features &=3D ~(BLK_FEAT_WRITE_CACHE | BLK_FEAT_ROTATIONAL);
 	if (file->f_op->fsync && !(lo->lo_flags & LO_FLAGS_READ_ONLY))
 		lim->features |=3D BLK_FEAT_WRITE_CACHE;
@@ -1416,6 +1439,7 @@ static int loop_set_dio(struct loop_device *lo, uns=
igned long arg)
 {
 	bool use_dio =3D !!arg;
 	unsigned int memflags;
+	struct queue_limits lim;
=20
 	if (lo->lo_state !=3D Lo_bound)
 		return -ENXIO;
@@ -1434,6 +1458,16 @@ static int loop_set_dio(struct loop_device *lo, un=
signed long arg)
 		lo->lo_flags |=3D LO_FLAGS_DIRECT_IO;
 	else
 		lo->lo_flags &=3D ~LO_FLAGS_DIRECT_IO;
+	/*
+	 * Direct I/O forwards the user pages to the backing file unchanged, so
+	 * track the backing's DMA alignment requirement as the mode is toggled=
.
+	 */
+	lim =3D queue_limits_start_update(lo->lo_queue);
+	if (lo->lo_flags & LO_FLAGS_DIRECT_IO)
+		lim.dma_alignment =3D lo->lo_dio_mem_align;
+	else
+		lim.dma_alignment =3D SECTOR_SIZE - 1;
+	queue_limits_commit_update(lo->lo_queue, &lim);
 	blk_mq_unfreeze_queue(lo->lo_queue, memflags);
 	return 0;
 }
--=20
2.52.0

