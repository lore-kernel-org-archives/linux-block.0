Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CDE6C433EF
	for <linux-block@archiver.kernel.org>; Fri, 10 Jun 2022 20:04:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344427AbiFJUEQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 10 Jun 2022 16:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346801AbiFJUEP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 10 Jun 2022 16:04:15 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A68D928732
        for <linux-block@vger.kernel.org>; Fri, 10 Jun 2022 13:04:14 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 25AHLH0P003566
        for <linux-block@vger.kernel.org>; Fri, 10 Jun 2022 13:04:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=7uKXzg/OPyXABdABOidNCjnrvjXhXTUMSABSngag/3w=;
 b=SFVIqev8kpSEzX+JXUynTupOi/zwkrLNaKrcB9F30a3AYKQzM/Ds++cj4AS3OrpQg3Hp
 /ACIj9D+NMmAz4ZyyMJoEHIDgHs/yI4KAs2YsCltn9asi+dm8F2YNbOpUnyzfcbO32eS
 z7oVTKbTuXcxyhC9kdnfW4fQ0eW9sC4ClkE= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net (PPS) with ESMTPS id 3gma9e94wb-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-block@vger.kernel.org>; Fri, 10 Jun 2022 13:04:13 -0700
Received: from twshared14818.18.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 10 Jun 2022 13:04:12 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
        id 364FA4E9D6AB; Fri, 10 Jun 2022 12:58:31 -0700 (PDT)
From:   Keith Busch <kbusch@fb.com>
To:     <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>
CC:     <axboe@kernel.dk>, Kernel Team <Kernel-team@fb.com>, <hch@lst.de>,
        <bvanassche@acm.org>, <damien.lemoal@opensource.wdc.com>,
        <ebiggers@kernel.org>, <pankydev8@gmail.com>,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCHv6 10/11] block: relax direct io memory alignment
Date:   Fri, 10 Jun 2022 12:58:29 -0700
Message-ID: <20220610195830.3574005-11-kbusch@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220610195830.3574005-1-kbusch@fb.com>
References: <20220610195830.3574005-1-kbusch@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: ZwHld_SnbRQs4iyX7KS0Q3edRNHbKwkZ
X-Proofpoint-GUID: ZwHld_SnbRQs4iyX7KS0Q3edRNHbKwkZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-10_08,2022-06-09_02,2022-02-23_01
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
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 block/bio.c            | 9 +++++++++
 block/fops.c           | 4 ++--
 include/linux/blkdev.h | 5 +++++
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 5618c6a4b3a3..551f1d12208b 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1220,7 +1220,16 @@ static int __bio_iov_iter_get_pages(struct bio *bi=
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
index 9d32df6fc315..86d3cab9bf93 100644
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
+		!bdev_iter_is_aligned(bdev, iter);
 }
=20
 #define DIO_INLINE_BIO_VECS 4
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index fb5c177708d5..914c613d81da 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -425,6 +425,11 @@ struct request_queue {
 	unsigned long		nr_requests;	/* Max # of requests */
=20
 	unsigned int		dma_pad_mask;
+	/*
+	 * Drivers that set dma_alignment to less than 511 must be prepared to
+	 * handle individual bvec's that are not a multiple of a SECTOR_SIZE
+	 * due to possible offsets.
+	 */
 	unsigned int		dma_alignment;
=20
 #ifdef CONFIG_BLK_INLINE_ENCRYPTION
--=20
2.30.2

