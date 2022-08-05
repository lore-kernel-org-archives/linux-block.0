Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED2DBC25B0C
	for <linux-block@archiver.kernel.org>; Fri,  5 Aug 2022 16:25:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbiHEQZ5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 5 Aug 2022 12:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237902AbiHEQZF (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 5 Aug 2022 12:25:05 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4874D71BF0
        for <linux-block@vger.kernel.org>; Fri,  5 Aug 2022 09:24:56 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 275G7biL003095
        for <linux-block@vger.kernel.org>; Fri, 5 Aug 2022 09:24:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=P6XL6+4vlHhOnyN2gEfiiQaDrdsakH/0m5jhLuk8f1I=;
 b=H8BRtgtEiP5SZkQzNopi3zOsfEore+qBS/UlSJUQIh6KI1TL3JOtMKuxqeJEzXeUMoiu
 t3sf1kYm+V3LpQRzEV5dEIQscXAD86zywRq5qF5AlArSsdVl+Fguvy8iRX6OBJ+fGWXg
 qTSHQOCeO8N69b3WVGLCJKEuHZAzfhi1U2M= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hrfvf84e9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-block@vger.kernel.org>; Fri, 05 Aug 2022 09:24:55 -0700
Received: from twshared33626.07.ash9.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 5 Aug 2022 09:24:55 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
        id 46B4A70374FF; Fri,  5 Aug 2022 09:24:45 -0700 (PDT)
From:   Keith Busch <kbusch@fb.com>
To:     <linux-nvme@lists.infradead.org>, <linux-block@vger.kernel.org>,
        <io-uring@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
CC:     <axboe@kernel.dk>, <hch@lst.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Kernel Team <Kernel-team@fb.com>,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCHv3 1/7] blk-mq: add ops to dma map bvec
Date:   Fri, 5 Aug 2022 09:24:38 -0700
Message-ID: <20220805162444.3985535-2-kbusch@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220805162444.3985535-1-kbusch@fb.com>
References: <20220805162444.3985535-1-kbusch@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: vjn5CSgeeogLC9Lq6iF7lMnOatkX_Knt
X-Proofpoint-ORIG-GUID: vjn5CSgeeogLC9Lq6iF7lMnOatkX_Knt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-05_08,2022-08-05_01,2022-06-22_01
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Keith Busch <kbusch@kernel.org>

The same buffer may be used for many subsequent IO's. Instead of setting
up the mapping per-IO, provide an interface that can allow a buffer to be
premapped just once and referenced again later.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/bdev.c           | 20 ++++++++++++++++++++
 include/linux/blk-mq.h | 13 +++++++++++++
 include/linux/blkdev.h | 16 ++++++++++++++++
 3 files changed, 49 insertions(+)

diff --git a/block/bdev.c b/block/bdev.c
index ce05175e71ce..c3d73ad86fae 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -1069,3 +1069,23 @@ void sync_bdevs(bool wait)
 	spin_unlock(&blockdev_superblock->s_inode_list_lock);
 	iput(old_inode);
 }
+
+#ifdef CONFIG_HAS_DMA
+void *block_dma_map(struct block_device *bdev, struct bio_vec *bvec,
+		    int nr_vecs)
+{
+	struct request_queue *q =3D bdev_get_queue(bdev);
+
+	if (q->mq_ops && q->mq_ops->dma_map)
+		return q->mq_ops->dma_map(q, bvec, nr_vecs);
+	return ERR_PTR(-EINVAL);
+}
+
+void block_dma_unmap(struct block_device *bdev, void *dma_tag)
+{
+	struct request_queue *q =3D bdev_get_queue(bdev);
+
+	if (q->mq_ops && q->mq_ops->dma_unmap)
+		return q->mq_ops->dma_unmap(q, dma_tag);
+}
+#endif
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index effee1dc715a..e10aabb36c2c 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -639,6 +639,19 @@ struct blk_mq_ops {
 	 */
 	void (*show_rq)(struct seq_file *m, struct request *rq);
 #endif
+
+#ifdef CONFIG_HAS_DMA
+	/**
+	 * @dma_map: Create a dma mapping. On success, returns an opaque cookie
+	 * that the can be referenced by the driver in future requests.
+	 */
+	void *(*dma_map)(struct request_queue *q, struct bio_vec *bvec, int nr_=
vecs);
+
+	/**
+	 * @dma_unmap: Tear down a previously created dma mapping.
+	 */
+	void (*dma_unmap)(struct request_queue *q, void *dma_tag);
+#endif
 };
=20
 enum {
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 49dcd31e283e..efc5e805a46e 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1527,4 +1527,20 @@ struct io_comp_batch {
=20
 #define DEFINE_IO_COMP_BATCH(name)	struct io_comp_batch name =3D { }
=20
+#ifdef CONFIG_HAS_DMA
+void *block_dma_map(struct block_device *bdev, struct bio_vec *bvec,
+		    int nr_vecs);
+void block_dma_unmap(struct block_device *bdev, void *dma_tag);
+#else
+static inline void *block_dma_map(struct block_device *bdev,
+				  struct bio_vec *bvec, int nr_vecs)
+{
+	return ERR_PTR(-ENOTSUPP);
+}
+
+static inline void block_dma_unmap(struct block_device *bdev, void *dma_=
tag)
+{
+}
+#endif
+
 #endif /* _LINUX_BLKDEV_H */
--=20
2.30.2

