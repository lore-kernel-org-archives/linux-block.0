Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F32FC433FE
	for <linux-block@archiver.kernel.org>; Tue, 31 May 2022 19:23:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347248AbiEaTXF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 31 May 2022 15:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347252AbiEaTXD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 May 2022 15:23:03 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 805716D1A0
        for <linux-block@vger.kernel.org>; Tue, 31 May 2022 12:22:59 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24VFiG8s021774
        for <linux-block@vger.kernel.org>; Tue, 31 May 2022 12:22:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=H+70oj3ezvDYkGSJCd4zURJxEMv8KpitIy6wxUbfHqM=;
 b=q+IY0UjXYLJA3O/ZX9ZLRgRz2qObxY89Ww6JUIUZ1TjeGhPxx441zt/IIGzRVh6hdrdC
 wAwuZq42hutwxD6usuPJ5e55GJ+zDvHr0uGRQlIK3SRg0b8KMk+jb+++pUndUU5rTh/V
 7Yi7WR/YhNgKSub1YTREkeDqgZjpjaqq8l8= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3gdbt64qew-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-block@vger.kernel.org>; Tue, 31 May 2022 12:22:59 -0700
Received: from twshared6696.05.ash7.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 31 May 2022 12:22:57 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
        id CD0454924B15; Tue, 31 May 2022 12:11:38 -0700 (PDT)
From:   Keith Busch <kbusch@fb.com>
To:     <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>
CC:     <axboe@kernel.dk>, Kernel Team <Kernel-team@fb.com>, <hch@lst.de>,
        <bvanassche@acm.org>, <damien.lemoal@opensource.wdc.com>,
        <ebiggers@kernel.org>, <pankydev8@gmail.com>,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCHv5 05/11] block: add a helper function for dio alignment
Date:   Tue, 31 May 2022 12:11:31 -0700
Message-ID: <20220531191137.2291467-6-kbusch@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220531191137.2291467-1-kbusch@fb.com>
References: <20220531191137.2291467-1-kbusch@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: wzUpKz8dmjv9LnloLwSpsGc9AJtZ1v0X
X-Proofpoint-GUID: wzUpKz8dmjv9LnloLwSpsGc9AJtZ1v0X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-05-31_07,2022-05-30_03,2022-02-23_01
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Keith Busch <kbusch@kernel.org>

This will make it easier to add more complex acceptable alignment
criteria in the future.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
v4->v5:

  Return a bool (Damien)

 block/fops.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index b9b83030e0df..5aec9a130812 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -42,6 +42,13 @@ static unsigned int dio_bio_write_op(struct kiocb *ioc=
b)
 	return op;
 }
=20
+static bool blkdev_dio_unaligned(struct block_device *bdev, loff_t pos,
+			      struct iov_iter *iter)
+{
+	return ((pos | iov_iter_alignment(iter)) &
+	    (bdev_logical_block_size(bdev) - 1));
+}
+
 #define DIO_INLINE_BIO_VECS 4
=20
 static ssize_t __blkdev_direct_IO_simple(struct kiocb *iocb,
@@ -54,8 +61,7 @@ static ssize_t __blkdev_direct_IO_simple(struct kiocb *=
iocb,
 	struct bio bio;
 	ssize_t ret;
=20
-	if ((pos | iov_iter_alignment(iter)) &
-	    (bdev_logical_block_size(bdev) - 1))
+	if (blkdev_dio_unaligned(bdev, pos, iter))
 		return -EINVAL;
=20
 	if (nr_pages <=3D DIO_INLINE_BIO_VECS)
@@ -173,8 +179,7 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb,=
 struct iov_iter *iter,
 	loff_t pos =3D iocb->ki_pos;
 	int ret =3D 0;
=20
-	if ((pos | iov_iter_alignment(iter)) &
-	    (bdev_logical_block_size(bdev) - 1))
+	if (blkdev_dio_unaligned(bdev, pos, iter))
 		return -EINVAL;
=20
 	if (iocb->ki_flags & IOCB_ALLOC_CACHE)
@@ -298,8 +303,7 @@ static ssize_t __blkdev_direct_IO_async(struct kiocb =
*iocb,
 	loff_t pos =3D iocb->ki_pos;
 	int ret =3D 0;
=20
-	if ((pos | iov_iter_alignment(iter)) &
-	    (bdev_logical_block_size(bdev) - 1))
+	if (blkdev_dio_unaligned(bdev, pos, iter))
 		return -EINVAL;
=20
 	if (iocb->ki_flags & IOCB_ALLOC_CACHE)
--=20
2.30.2

