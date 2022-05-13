Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8326CC4332F
	for <linux-block@archiver.kernel.org>; Fri, 13 May 2022 16:14:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379689AbiEMQO2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 13 May 2022 12:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358844AbiEMQOF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 May 2022 12:14:05 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B5E43ED21
        for <linux-block@vger.kernel.org>; Fri, 13 May 2022 09:14:04 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24DDBnd1010320
        for <linux-block@vger.kernel.org>; Fri, 13 May 2022 09:14:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=Ngx1M3+a4EOhn7oa2wX9HNTxKy75b3x4RgFOhBsXFKI=;
 b=YmWbMUxbo6EAncOpukm4SGM4g0lNAwNf1SVwYYfoiaw6ca7nyUqS9DV+Pco7qPIte1Le
 HRTWOepbj3lFLdomYjuzojvSQE6cTydyT/yadUC/S/aiNEzwTOxL1/gm02O9MFu0DxjJ
 gQTT/vuxV0w4UeXVWZrtcUDceMmZ3ZVrDbQ= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3g1r0bh4yy-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-block@vger.kernel.org>; Fri, 13 May 2022 09:14:03 -0700
Received: from twshared29473.14.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 13 May 2022 09:14:02 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
        id 55E7E3E459A3; Fri, 13 May 2022 09:13:56 -0700 (PDT)
From:   Keith Busch <kbusch@fb.com>
To:     <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, Kernel Team <kernel-team@fb.com>,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCH 2/3] block: relax direct io memory alignment
Date:   Fri, 13 May 2022 09:13:38 -0700
Message-ID: <20220513161339.1580042-2-kbusch@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220513161339.1580042-1-kbusch@fb.com>
References: <20220513161339.1580042-1-kbusch@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Q5lwMwzUy1V2C25RCAz0aiupV4aCaMQT
X-Proofpoint-GUID: Q5lwMwzUy1V2C25RCAz0aiupV4aCaMQT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-13_08,2022-05-13_01,2022-02-23_01
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Keith Busch <kbusch@kernel.org>

Use the address alignment requirements from the hardware for direct io
instead of requiring addresses be aligned to the block size. User space
can discover the alignment requirements from the dma_alignment queue
attribute.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/fops.c           | 15 +++++++++------
 fs/direct-io.c         | 11 +++++++----
 fs/iomap/direct-io.c   |  3 ++-
 include/linux/blkdev.h |  5 +++++
 4 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index 9f2ecec406b0..a6583bce1e7d 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -62,8 +62,9 @@ static ssize_t __blkdev_direct_IO_simple(struct kiocb *=
iocb,
 	struct bio bio;
 	ssize_t ret;
=20
-	if ((pos | iov_iter_alignment(iter)) &
-	    (bdev_logical_block_size(bdev) - 1))
+	if ((pos | iov_iter_count(iter)) & (bdev_logical_block_size(bdev) - 1))
+		return -EINVAL;
+	if (iov_iter_alignment(iter) & bdev_dma_alignment(bdev))
 		return -EINVAL;
=20
 	if (nr_pages <=3D DIO_INLINE_BIO_VECS)
@@ -193,8 +194,9 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb,=
 struct iov_iter *iter,
 	loff_t pos =3D iocb->ki_pos;
 	int ret =3D 0;
=20
-	if ((pos | iov_iter_alignment(iter)) &
-	    (bdev_logical_block_size(bdev) - 1))
+	if ((pos | iov_iter_count(iter)) & (bdev_logical_block_size(bdev) - 1))
+		return -EINVAL;
+	if (iov_iter_alignment(iter) & bdev_dma_alignment(bdev))
 		return -EINVAL;
=20
 	bio =3D bio_alloc_kiocb(iocb, bdev, nr_pages, opf, &blkdev_dio_pool);
@@ -316,8 +318,9 @@ static ssize_t __blkdev_direct_IO_async(struct kiocb =
*iocb,
 	loff_t pos =3D iocb->ki_pos;
 	int ret =3D 0;
=20
-	if ((pos | iov_iter_alignment(iter)) &
-	    (bdev_logical_block_size(bdev) - 1))
+	if ((pos | iov_iter_count(iter)) & (bdev_logical_block_size(bdev) - 1))
+		return -EINVAL;
+	if (iov_iter_alignment(iter) & bdev_dma_alignment(bdev))
 		return -EINVAL;
=20
 	bio =3D bio_alloc_kiocb(iocb, bdev, nr_pages, opf, &blkdev_dio_pool);
diff --git a/fs/direct-io.c b/fs/direct-io.c
index aef06e607b40..b3d249d7d91d 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -1132,7 +1132,7 @@ do_blockdev_direct_IO(struct kiocb *iocb, struct in=
ode *inode,
 	struct dio_submit sdio =3D { 0, };
 	struct buffer_head map_bh =3D { 0, };
 	struct blk_plug plug;
-	unsigned long align =3D offset | iov_iter_alignment(iter);
+	unsigned long align =3D iov_iter_alignment(iter);
=20
 	/*
 	 * Avoid references to bdev if not absolutely needed to give
@@ -1166,11 +1166,14 @@ do_blockdev_direct_IO(struct kiocb *iocb, struct =
inode *inode,
 		goto fail_dio;
 	}
=20
-	if (align & blocksize_mask) {
-		if (bdev)
+	if ((offset | align) & blocksize_mask) {
+		if (bdev) {
 			blkbits =3D blksize_bits(bdev_logical_block_size(bdev));
+			if (align & bdev_dma_alignment(bdev))
+				goto fail_dio;
+		}
 		blocksize_mask =3D (1 << blkbits) - 1;
-		if (align & blocksize_mask)
+		if ((offset | count) & blocksize_mask)
 			goto fail_dio;
 	}
=20
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index b08f5dc31780..c73b050b7026 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -243,7 +243,8 @@ static loff_t iomap_dio_bio_iter(const struct iomap_i=
ter *iter,
 	size_t copied =3D 0;
 	size_t orig_count;
=20
-	if ((pos | length | align) & ((1 << blkbits) - 1))
+	if ((pos | length) & ((1 << blkbits) - 1) ||
+	    align & bdev_dma_alignment(iomap->bdev))
 		return -EINVAL;
=20
 	if (iomap->type =3D=3D IOMAP_UNWRITTEN) {
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 60d016138997..dba6d411fc1e 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1378,6 +1378,11 @@ static inline int queue_dma_alignment(const struct=
 request_queue *q)
 	return q ? q->dma_alignment : 511;
 }
=20
+static inline unsigned int bdev_dma_alignment(struct block_device *bdev)
+{
+	return queue_dma_alignment(bdev_get_queue(bdev));
+}
+
 static inline int blk_rq_aligned(struct request_queue *q, unsigned long =
addr,
 				 unsigned int len)
 {
--=20
2.30.2

