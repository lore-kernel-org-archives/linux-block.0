Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E80EC433EF
	for <linux-block@archiver.kernel.org>; Thu, 26 May 2022 01:06:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbiEZBGk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 25 May 2022 21:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239244AbiEZBGj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 May 2022 21:06:39 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71AFC8FD68
        for <linux-block@vger.kernel.org>; Wed, 25 May 2022 18:06:38 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24PGth3M009996
        for <linux-block@vger.kernel.org>; Wed, 25 May 2022 18:06:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=NDVPtsohLwJbs3chctEtWIn1Z10WtLG6eN0XAr5wzj8=;
 b=XHN+y8mvAlzSc8wJsZvMts2ARx95UAC/VrBMemjI6ca3QPggRWpK1DbOM4Jcem3/XZOJ
 nfKX0BZLQGm/5EVYh9cPpVvL2JvqsAxQYEXhrSpPiYI4CJgXt1hAFWapZpHXhtm9ZBV+
 ZgfMrsoCnxVyPIAREIfO2M0lNBl4Si5/1l8= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3g93upj24m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-block@vger.kernel.org>; Wed, 25 May 2022 18:06:38 -0700
Received: from twshared35748.07.ash9.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 25 May 2022 18:06:37 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
        id EDFBD45C0BDB; Wed, 25 May 2022 18:06:20 -0700 (PDT)
From:   Keith Busch <kbusch@fb.com>
To:     <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, Kernel Team <Kernel-team@fb.com>, <hch@lst.de>,
        <bvanassche@acm.org>, <damien.lemoal@opensource.wdc.com>,
        <ebiggers@kernel.org>, <pankydev8@gmail.com>,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCHv4 5/9] block: add a helper function for dio alignment
Date:   Wed, 25 May 2022 18:06:09 -0700
Message-ID: <20220526010613.4016118-6-kbusch@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220526010613.4016118-1-kbusch@fb.com>
References: <20220526010613.4016118-1-kbusch@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 2xhAkvd4MMN4BsIPI0pOBy83kLHn-QaT
X-Proofpoint-ORIG-GUID: 2xhAkvd4MMN4BsIPI0pOBy83kLHn-QaT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-25_07,2022-05-25_02,2022-02-23_01
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Keith Busch <kbusch@kernel.org>

This will make it easier to add more complex acceptable alignment
criteria in the future.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/fops.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index b9b83030e0df..bd6c2e13a4e3 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -42,6 +42,16 @@ static unsigned int dio_bio_write_op(struct kiocb *ioc=
b)
 	return op;
 }
=20
+static int blkdev_dio_aligned(struct block_device *bdev, loff_t pos,
+			      struct iov_iter *iter)
+{
+	if ((pos | iov_iter_alignment(iter)) &
+	    (bdev_logical_block_size(bdev) - 1))
+		return -EINVAL;
+
+	return 0;
+}
+
 #define DIO_INLINE_BIO_VECS 4
=20
 static ssize_t __blkdev_direct_IO_simple(struct kiocb *iocb,
@@ -54,9 +64,9 @@ static ssize_t __blkdev_direct_IO_simple(struct kiocb *=
iocb,
 	struct bio bio;
 	ssize_t ret;
=20
-	if ((pos | iov_iter_alignment(iter)) &
-	    (bdev_logical_block_size(bdev) - 1))
-		return -EINVAL;
+	ret =3D blkdev_dio_aligned(bdev, pos, iter);
+	if (ret)
+		return ret;
=20
 	if (nr_pages <=3D DIO_INLINE_BIO_VECS)
 		vecs =3D inline_vecs;
@@ -171,11 +181,11 @@ static ssize_t __blkdev_direct_IO(struct kiocb *ioc=
b, struct iov_iter *iter,
 	bool is_read =3D (iov_iter_rw(iter) =3D=3D READ), is_sync;
 	unsigned int opf =3D is_read ? REQ_OP_READ : dio_bio_write_op(iocb);
 	loff_t pos =3D iocb->ki_pos;
-	int ret =3D 0;
+	int ret;
=20
-	if ((pos | iov_iter_alignment(iter)) &
-	    (bdev_logical_block_size(bdev) - 1))
-		return -EINVAL;
+	ret =3D blkdev_dio_aligned(bdev, pos, iter);
+	if (ret)
+		return ret;
=20
 	if (iocb->ki_flags & IOCB_ALLOC_CACHE)
 		opf |=3D REQ_ALLOC_CACHE;
@@ -296,11 +306,11 @@ static ssize_t __blkdev_direct_IO_async(struct kioc=
b *iocb,
 	struct blkdev_dio *dio;
 	struct bio *bio;
 	loff_t pos =3D iocb->ki_pos;
-	int ret =3D 0;
+	int ret;
=20
-	if ((pos | iov_iter_alignment(iter)) &
-	    (bdev_logical_block_size(bdev) - 1))
-		return -EINVAL;
+	ret =3D blkdev_dio_aligned(bdev, pos, iter);
+	if (ret)
+		return ret;
=20
 	if (iocb->ki_flags & IOCB_ALLOC_CACHE)
 		opf |=3D REQ_ALLOC_CACHE;
--=20
2.30.2

