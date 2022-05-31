Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79B12C433EF
	for <linux-block@archiver.kernel.org>; Tue, 31 May 2022 19:17:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347199AbiEaTRC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 31 May 2022 15:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346839AbiEaTRA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 May 2022 15:17:00 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24E779FEE
        for <linux-block@vger.kernel.org>; Tue, 31 May 2022 12:17:00 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24VFiDfE027306
        for <linux-block@vger.kernel.org>; Tue, 31 May 2022 12:17:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=/syWRQLdbwrWP/U7ok4pzvWePqWN4/CrD9PZetCXNl4=;
 b=YwCfTUP75q+4WI5W83LGCoFqnTlkwupdWDX5MdyV1Xju0IpQUru7kuh8o8hOVU+An/is
 eG8WNeh9n2jZmt4nQ1Ycnda6jY2xMzOc4RWqQ7YBvG7DcTiXHHMd5zf03G4r6eg+A89g
 H4k+skZK30wnm0cTfBf58eIq9H0ZpKHFnn0= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3gdj4su441-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-block@vger.kernel.org>; Tue, 31 May 2022 12:16:59 -0700
Received: from twshared4937.07.ash9.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 31 May 2022 12:16:58 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
        id 19F8A4924B1A; Tue, 31 May 2022 12:11:38 -0700 (PDT)
From:   Keith Busch <kbusch@fb.com>
To:     <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>
CC:     <axboe@kernel.dk>, Kernel Team <Kernel-team@fb.com>, <hch@lst.de>,
        <bvanassche@acm.org>, <damien.lemoal@opensource.wdc.com>,
        <ebiggers@kernel.org>, <pankydev8@gmail.com>,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCHv5 10/11] block: relax direct io memory alignment
Date:   Tue, 31 May 2022 12:11:36 -0700
Message-ID: <20220531191137.2291467-11-kbusch@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220531191137.2291467-1-kbusch@fb.com>
References: <20220531191137.2291467-1-kbusch@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: mowXHIkZJ5bueDOX1NLhaUQa9Ai6Z5bB
X-Proofpoint-ORIG-GUID: mowXHIkZJ5bueDOX1NLhaUQa9Ai6Z5bB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-05-31_07,2022-05-30_03,2022-02-23_01
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Keith Busch <kbusch@kernel.org>

Use the address alignment requirements from the block_device for direct
io instead of requiring addresses be aligned to the block size. User
space can discover the alignment requirements from the dma_alignment
queue attribute.

User space can specify any hardware compatible DMA offset for each
segment, but every segment length is still required to be a multiple of
the block size.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/bio.c  | 9 +++++++++
 block/fops.c | 4 ++--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 55d2a9c4e312..44658aa57784 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1219,7 +1219,16 @@ static int __bio_iov_iter_get_pages(struct bio *bi=
o, struct iov_iter *iter)
 	BUILD_BUG_ON(PAGE_PTRS_PER_BVEC < 2);
 	pages +=3D entries_left * (PAGE_PTRS_PER_BVEC - 1);
=20
+	/*
+	 * Each segment in the iov is required to be a block size multiple.
+	 * However, we may not be able to get the entire segment if it spans
+	 * more pages than bi_max_vecs allows, so we have to ALIGN_DOWN the
+	 * result to ensure the bio's total size is correct. The remainder of
+	 * the iov data will be picked up in the next bio iteration.
+	 */
 	size =3D iov_iter_get_pages(iter, pages, LONG_MAX, nr_pages, &offset);
+	if (size > 0)
+		size =3D ALIGN_DOWN(size, bdev_logical_block_size(bio->bi_bdev));
 	if (unlikely(size <=3D 0))
 		return size ? size : -EFAULT;
=20
diff --git a/block/fops.c b/block/fops.c
index 5aec9a130812..7a02b75009bb 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -45,8 +45,8 @@ static unsigned int dio_bio_write_op(struct kiocb *iocb=
)
 static bool blkdev_dio_unaligned(struct block_device *bdev, loff_t pos,
 			      struct iov_iter *iter)
 {
-	return ((pos | iov_iter_alignment(iter)) &
-	    (bdev_logical_block_size(bdev) - 1));
+	return pos & (bdev_logical_block_size(bdev) - 1) ||
+		!bvev_iter_is_aligned(bdev, iter);
 }
=20
 #define DIO_INLINE_BIO_VECS 4
--=20
2.30.2

