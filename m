Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B653CDBAB
	for <linux-block@vger.kernel.org>; Wed, 24 Jun 2026 17:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782320976; cv=none; b=lciPjs/NotXyeAkI+Y4Qym5FYtBAmfnxelxDybQ3XoXR68BkfWBYMovzGq/4sQlOIMo/lYfPA6nePW3wp/ewwjKR3wwJ+x7u1332eXQT18F/O2zityzRuMQte/nDl43agoQV0l7YQ/qm7vtmHzuKe0toYg8MnVJL0LEcA9ua9pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782320976; c=relaxed/simple;
	bh=5PFte3dtJ13IqCLaqOh94dH6sJNQlliqzoHztY9569Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l5AP9mqrRBEErMQMalMBJ3fuI6cO/yQhvOzkATj28QTP3AgqBhMWeM+IQHdFtGi3XtCKv7pljZ++NDv37TTTM9vMl6z4eqAckbN/soZ//pILnXig8uw5ZRyNFfGzMuwK2+QIXKfdFH9bpTsp2/XfYgWm0zxfHZxExs9iL7TzTG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=g1xYqaz9; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="g1xYqaz9"
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65OEjGWK3972421
	for <linux-block@vger.kernel.org>; Wed, 24 Jun 2026 10:09:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=DvmJMVrxsUgpi+CMIpoZC1g98SBwLk+AmGxexOeiL6w=; b=g1xYqaz9iKPD
	hgVDWvsAwLsU4minT3pi5WCbJwuvDTaZmo8SIoZSRWPI4lGVOa1+RpE5FXXk+kzw
	6ifMnHJ2NjybV7pqMX0thtqeofeBwt8fNI1nK8fkgmC93ahT5Z5v5m9a2LZrWB/V
	RlxeNO/K9xAWx9thaJOUWN1B0aXvl0FKjhUP/kjZ12f5yt2otI5RggOjiLTO+1kt
	hWPe5lJuQS7wBHd3+gEFd2ZMDEfyTPkYgfvA+gWKuRWdlnKAGS7WHWrAqZQJTvIM
	4wbf6r4M/CZSik/6znLaVO3de6hDOzAj1/8xlvuUTtTexzMDgWH9jU0m7+CqgPm2
	sMjnCiftQg==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4eyumssvg1-10
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Wed, 24 Jun 2026 10:09:30 -0700 (PDT)
Received: from twshared90881.15.frc2.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.41; Wed, 24 Jun 2026 17:09:26 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 833FE23C452BF; Wed, 24 Jun 2026 10:09:08 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
CC: <dm-devel@lists.linux.dev>, <hch@lst.de>, <axboe@kernel.dk>,
        <brauner@kernel.org>, <djwong@kernel.org>, <viro@zeniv.linux.org.uk>,
        Keith
 Busch <kbusch@kernel.org>
Subject: [PATCH v3 4/5] zloop: set dma_alignment from the backing files for direct I/O
Date: Wed, 24 Jun 2026 10:09:04 -0700
Message-ID: <20260624170905.3972095-5-kbusch@meta.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260624170905.3972095-1-kbusch@meta.com>
References: <20260624170905.3972095-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=eoTvCIpX c=1 sm=1 tr=0 ts=6a3c0f4a cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=JnKecZnUtZousrUlYMGU:22 a=VwQbUJbxAAAA:8 a=mpKBkMY7X3-XUUdAYUMA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDE0MyBTYWx0ZWRfX2TVHxVM1/z6U
 byPjehkay4Q9RHEJktFHgtIPandiS3Nl/Rd8tMflSCB4xDZS5g80ah/hEj7hDa9q7Y5CMrcZRDI
 VeOa02rM2HHOYPiABsFxmuOyA9nLrDtUA36BAGKM2drUMS323rIMXckLs4gZ6AEr4LeuBgfAtGA
 B9Gm3cRKBmJBDsk3L3Jp/c365rt5a3HlFBDr8HMVy7hzdpri9wmyp9ddfGzdueE56YaWG73wkzm
 +K7WC/i9a9+1bneWkF1lMhZufxmTMMnwxlITKrMJOefaTsKOoNbNb9VPXmaEXO4nZCzJ59QYlX8
 fCubXMizymvqof3BsDjuYf+Z2M3cg2QkotPBP4wNRH6gTQy83oF+d4p2nQMVTCD3o39NRvzzk1V
 Gq1RMKi6+3mDCb2GzMHHUkx1xyW//A==
X-Proofpoint-ORIG-GUID: 6PcedgW_BUlrVfJkrXkw_IxUda0Pl7Gv
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDE0MyBTYWx0ZWRfX4N611VEnGUhp
 xfpWvgo5hO2tqodT0Pf1r6KA9/UqZrlw+Nio9tjVc8jwXtDxtHF9aSv3VzzVsT0G9AMoWRLb4M3
 y0BpqGdEtAeekHH/4dJLOawNQfzP/dk=
X-Proofpoint-GUID: 6PcedgW_BUlrVfJkrXkw_IxUda0Pl7Gv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_03,2026-06-24_01,2025-10-01_01

From: Keith Busch <kbusch@kernel.org>

Direct I/O user pages are forwarded to the backing files unchanged, so
the backing's DMA alignment requirement applies to them. Track the
backing file's dio_mem_align and advertise it as the zloop device's
dma_alignment if it is larger than the default so we advertise proper
limits and misaligned I/O is rejected early instead of being dispatched
to the backend.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/block/zloop.c | 35 +++++++++++++++++++++++++----------
 1 file changed, 25 insertions(+), 10 deletions(-)

diff --git a/drivers/block/zloop.c b/drivers/block/zloop.c
index 55eeb6aac0ea3..f97a20cfdb7ce 100644
--- a/drivers/block/zloop.c
+++ b/drivers/block/zloop.c
@@ -144,6 +144,7 @@ struct zloop_device {
 	unsigned int		nr_conv_zones;
 	unsigned int		max_open_zones;
 	unsigned int		block_size;
+	unsigned int		dio_mem_align;
=20
 	spinlock_t		open_zones_lock;
 	struct list_head	open_zones_lru_list;
@@ -1037,20 +1038,30 @@ static int zloop_get_block_size(struct zloop_devi=
ce *zlo,
 	struct kstat st;
=20
 	/*
-	 * If the FS block size is lower than or equal to 4K, use that as the
-	 * device block size. Otherwise, fallback to the FS direct IO alignment
-	 * constraint if that is provided, and to the FS underlying device
-	 * physical block size if the direct IO alignment is unknown.
+	 * Use the dio alignment of the file system if provided.  The incoming
+	 * request's bio_vec is forwarded to the backing file unchanged, so its
+	 * required memory alignment becomes the device's dma_alignment when
+	 * used for direct-io.
 	 */
-	if (file_inode(zone->file)->i_sb->s_blocksize <=3D SZ_4K)
-		zlo->block_size =3D file_inode(zone->file)->i_sb->s_blocksize;
-	else if (!vfs_getattr(&zone->file->f_path, &st, STATX_DIOALIGN, 0) &&
-		 (st.result_mask & STATX_DIOALIGN))
+	if (!vfs_getattr(&zone->file->f_path, &st, STATX_DIOALIGN, 0) &&
+	    (st.result_mask & STATX_DIOALIGN)) {
 		zlo->block_size =3D st.dio_offset_align;
-	else if (sb_bdev)
+		zlo->dio_mem_align =3D st.dio_mem_align - 1;
+	} else if (sb_bdev) {
 		zlo->block_size =3D bdev_physical_block_size(sb_bdev);
-	else
+		zlo->dio_mem_align =3D bdev_dma_alignment(sb_bdev);
+	} else {
 		zlo->block_size =3D SECTOR_SIZE;
+		zlo->dio_mem_align =3D SECTOR_SIZE - 1;
+	}
+
+	/*
+	 * Prefer the FS block size for the device block size when it is no
+	 * larger than 4K; otherwise keep the direct I/O / physical block size
+	 * selected above.
+	 */
+	if (file_inode(zone->file)->i_sb->s_blocksize <=3D SZ_4K)
+		zlo->block_size =3D file_inode(zone->file)->i_sb->s_blocksize;
=20
 	if (zlo->zone_capacity & ((zlo->block_size >> SECTOR_SHIFT) - 1)) {
 		pr_err("Zone capacity is not aligned to block size %u\n",
@@ -1279,6 +1290,10 @@ static int zloop_ctl_add(struct zloop_options *opt=
s)
=20
 	lim.physical_block_size =3D zlo->block_size;
 	lim.logical_block_size =3D zlo->block_size;
+	/* Direct I/O forwards the request pages to the backing files as-is. */
+	if (!opts->buffered_io)
+		lim.dma_alignment =3D max_t(unsigned int, zlo->dio_mem_align,
+					  SECTOR_SIZE - 1);
 	if (zlo->zone_append)
 		lim.max_hw_zone_append_sectors =3D lim.max_hw_sectors;
 	lim.max_open_zones =3D zlo->max_open_zones;
--=20
2.53.0-Meta

