Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC539C433B4
	for <linux-block@archiver.kernel.org>; Wed, 21 Apr 2021 10:05:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A31DC61430
	for <linux-block@archiver.kernel.org>; Wed, 21 Apr 2021 10:05:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236018AbhDUKGW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Apr 2021 06:06:22 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:39797 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234536AbhDUKGV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Apr 2021 06:06:21 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20210421100546epoutp04daa1d6e05e71602cb3f6c3e8311a5d44~314KHsnXZ1624316243epoutp04-
        for <linux-block@vger.kernel.org>; Wed, 21 Apr 2021 10:05:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20210421100546epoutp04daa1d6e05e71602cb3f6c3e8311a5d44~314KHsnXZ1624316243epoutp04-
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1618999546;
        bh=VR8rouP0JzVMAgnzUeYqAnG/XSgynGblfIzoFBVDnPA=;
        h=From:To:Cc:Subject:Date:References:From;
        b=MygCF2Es1JcTXQn9hd6LZn7RkZnPFw70aAL4Ww/wHnb2VPIJzIHdK3GCyNKwGXv29
         9g75Ys30MxHXrEhc55lx+AFtOMLN8mt3FoaIbIae/4WKFI45jdfGyDIEfIep5M6Xno
         1xl4KzYzkEyx/7yBFFUJnY26Cn2DrHNiCVp/G9yg=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20210421100546epcas1p3f4d94189a868ea01dd6af882cb16ed9f~314JiGpOm2533125331epcas1p3f;
        Wed, 21 Apr 2021 10:05:46 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.162]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4FQGQc5DzLz4x9Pt; Wed, 21 Apr
        2021 10:05:44 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        0B.9E.10258.8F8FF706; Wed, 21 Apr 2021 19:05:44 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20210421100544epcas1p13c2c86e84102f0955dd591f72e45756a~314HtgKHX1657516575epcas1p1v;
        Wed, 21 Apr 2021 10:05:44 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210421100544epsmtrp2848e1eb09accada9e5a28931de385f58~314HsKKf30892408924epsmtrp2W;
        Wed, 21 Apr 2021 10:05:44 +0000 (GMT)
X-AuditID: b6c32a38-42fff70000002812-c9-607ff8f8b532
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        D4.5B.08163.7F8FF706; Wed, 21 Apr 2021 19:05:43 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.99.105]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210421100543epsmtip1fb5ee5175ec8a9732425d01c6f6a41a2~314Hbbjnn0202502025epsmtip1M;
        Wed, 21 Apr 2021 10:05:43 +0000 (GMT)
From:   Changheun Lee <nanich.lee@samsung.com>
To:     bvanassche@acm.org, Johannes.Thumshirn@wdc.com,
        asml.silence@gmail.com, axboe@kernel.dk, damien.lemoal@wdc.com,
        gregkh@linuxfoundation.org, hch@infradead.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ming.lei@redhat.com, osandov@fb.com, patchwork-bot@kernel.org,
        tj@kernel.org, tom.leiming@gmail.com
Cc:     jisoo2146.oh@samsung.com, junho89.kim@samsung.com,
        mj0123.lee@samsung.com, seunghwan.hyun@samsung.com,
        sookwan7.kim@samsung.com, woosung2.lee@samsung.com,
        yt0928.kim@samsung.com, Changheun Lee <nanich.lee@samsung.com>
Subject: [PATCH v8] bio: limit bio max size
Date:   Wed, 21 Apr 2021 18:47:45 +0900
Message-Id: <20210421094745.29660-1-nanich.lee@samsung.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOJsWRmVeSWpSXmKPExsWy7bCmnu6PH/UJBl/OqVjMWbWN0WL13X42
        i2kffjJbtLZ/Y7JoXryezeL0hEVMFj1Pmlgt/nbdY7L4+rDYYu8tbYvLu+awWRya3MxkMX3z
        HGaLa/fPsFscvneVxeLhkonMFudOfmK1mPfYweLX8qOMFu9/XGe3OLVjMrPF+r0/2RzEPC5f
        8faY2PyO3WPnrLvsHptXaHlcPlvqsWlVJ5vH/rlr2D3e77vK5tG3ZRWjx+dNch7tB7qZArij
        cmwyUhNTUosUUvOS81My89JtlbyD453jTc0MDHUNLS3MlRTyEnNTbZVcfAJ03TJzgD5VUihL
        zCkFCgUkFhcr6dvZFOWXlqQqZOQXl9gqpRak5BQYGhToFSfmFpfmpesl5+daGRoYGJkCVSbk
        ZNxsesJWcFqr4see6cwNjK1yXYycHBICJhL7ep6wdDFycQgJ7GCU6Dy6nRHC+cQoMe35LzYI
        5zOjxOEVR5hgWp4cfQ+V2MUosfvSC3a4qn2bdjGCVLEJ6Ej0vb0FViUicJJJ4smBdjCHWeAx
        o8SVk21sIFXCAtoSRz5uZe1i5OBgEVCV2NwQCxLmFbCWOPl7AzPEOnmJP/d7mCHighInZ4Jc
        ywk0R16ieetsZpCZEgIvOCT+T5rNBtHgIvHhzF5GCFtY4tXxLewQtpTE53d72SAauhklmtvm
        M0I4ExglljxfBvWdscSnz58ZQS5iFtCUWL9LHyKsKLHz91xGiM18Eu++9oAdLSHAK9HRJgRR
        oiJxpuU+M8yu52t3Qk30kJizowfsaCGBWIlVN6cwTmCUn4Xkn1lI/pmFsHgBI/MqRrHUguLc
        9NRiwwIT5IjdxAhO8VoWOxjnvv2gd4iRiYPxEKMEB7OSCO/92poEId6UxMqq1KL8+KLSnNTi
        Q4ymwACeyCwlmpwPzDJ5JfGGpkbGxsYWJmbmZqbGSuK86c7VCUIC6YklqdmpqQWpRTB9TByc
        Ug1Mfive1SsJinK8n77aVWdH46KZj8otqyKXpIbkir6ten3ablb/gV9hNQKX2dsnKVxymO7k
        kXKyuOPIHP/95fEZKdE73kzfxPNMycWDq7lJI0Rix6yWhVYTvt+YxF1Uzv6jVv+6alN8rlr3
        /hMnBZiSfkrKli+0l9STjeJ4Eq7N/nuSbXR+StC2+4Wh22f/nG6Q9S5ghv8Ru9C7W1Tz1TO2
        zOCUiFr88t+frSEHuMSNUs1rJ8Zbvf4Z9+LDmhn2t/11+2tlJ945y1Kvf+1HZ515dcyfUmXH
        paFvWJP2zc3schI8q7LeqvyU1ce08LMby9glrhjylWcbFinodEp1Ld06IbfOeNEphbCD5rf6
        w5RYijMSDbWYi4oTAbk8ax16BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEIsWRmVeSWpSXmKPExsWy7bCSnO73H/UJBvs3WVnMWbWN0WL13X42
        i2kffjJbtLZ/Y7JoXryezeL0hEVMFj1Pmlgt/nbdY7L4+rDYYu8tbYvLu+awWRya3MxkMX3z
        HGaLa/fPsFscvneVxeLhkonMFudOfmK1mPfYweLX8qOMFu9/XGe3OLVjMrPF+r0/2RzEPC5f
        8faY2PyO3WPnrLvsHptXaHlcPlvqsWlVJ5vH/rlr2D3e77vK5tG3ZRWjx+dNch7tB7qZArij
        uGxSUnMyy1KL9O0SuDJuNj1hKzitVfFjz3TmBsZWuS5GTg4JAROJJ0ffs3UxcnEICexglNjw
        dC47REJK4viJt6xdjBxAtrDE4cPFEDUfGSW+HHnKClLDJqAj0ff2FliziMBtJomjX/6zgDjM
        Aq8ZJboeL2IBqRIW0JY48nEr2CQWAVWJzQ2xIGFeAWuJk783MEMsk5f4c7+HGSIuKHFy5hOw
        VmagePPW2cwTGPlmIUnNQpJawMi0ilEytaA4Nz232LDAKC+1XK84Mbe4NC9dLzk/dxMjONq0
        tHYw7ln1Qe8QIxMH4yFGCQ5mJRHe+7U1CUK8KYmVValF+fFFpTmpxYcYpTlYlMR5L3SdjBcS
        SE8sSc1OTS1ILYLJMnFwSjUwHYkVtrf7p2L+sSfhg7rjntjMWu4jS58fu7mI6cyko3s+GGk+
        XLaiTWOH+gELIUP2tcELeCz/i+zeu/u0VEHS+s0H/vetPb+7uHPrgR3/2L/NzxfeuWJd6d4T
        81m7/mYuUcpUr9jSuW3DFf6e416TP8WVCC62jZgYd2ES62054Zn21uzrjuTevC/1Xm/dvrOG
        0oLffxjmF+7WeX6Vp6RDPYV3scAxu5mruetUW7p/eH0P5380VzjDcfeC2tgbB2fH5m+ZPttu
        2pMg7zTxqTJbJ6w8VJsRLnT2+36H0FPd0aelfdY6vjAQ1zRdc6Dt8+zrs7NagkWOO7Ff2M83
        bZpy8Flmh3/Nb4JnuWy40SjKZKbEUpyRaKjFXFScCABg3QPOJQMAAA==
X-CMS-MailID: 20210421100544epcas1p13c2c86e84102f0955dd591f72e45756a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210421100544epcas1p13c2c86e84102f0955dd591f72e45756a
References: <CGME20210421100544epcas1p13c2c86e84102f0955dd591f72e45756a@epcas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

bio size can grow up to 4GB when muli-page bvec is enabled.
but sometimes it would lead to inefficient behaviors.
in case of large chunk direct I/O, - 32MB chunk read in user space -
all pages for 32MB would be merged to a bio structure if the pages
physical addresses are contiguous. it makes some delay to submit
until merge complete. bio max size should be limited to a proper size.

When 32MB chunk read with direct I/O option is coming from userspace,
kernel behavior is below now in do_direct_IO() loop. it's timeline.

 | bio merge for 32MB. total 8,192 pages are merged.
 | total elapsed time is over 2ms.
 |------------------ ... ----------------------->|
                                                 | 8,192 pages merged a bio.
                                                 | at this time, first bio submit is done.
                                                 | 1 bio is split to 32 read request and issue.
                                                 |--------------->
                                                  |--------------->
                                                   |--------------->
                                                              ......
                                                                   |--------------->
                                                                    |--------------->|
                          total 19ms elapsed to complete 32MB read done from device. |

If bio max size is limited with 1MB, behavior is changed below.

 | bio merge for 1MB. 256 pages are merged for each bio.
 | total 32 bio will be made.
 | total elapsed time is over 2ms. it's same.
 | but, first bio submit timing is fast. about 100us.
 |--->|--->|--->|---> ... -->|--->|--->|--->|--->|
      | 256 pages merged a bio.
      | at this time, first bio submit is done.
      | and 1 read request is issued for 1 bio.
      |--------------->
           |--------------->
                |--------------->
                                      ......
                                                 |--------------->
                                                  |--------------->|
        total 17ms elapsed to complete 32MB read done from device. |

As a result, read request issue timing is faster if bio max size is limited.
Current kernel behavior with multipage bvec, super large bio can be created.
And it lead to delay first I/O request issue.

Signed-off-by: Changheun Lee <nanich.lee@samsung.com>
---
 block/bio.c            | 9 ++++++++-
 block/blk-settings.c   | 5 +++++
 include/linux/bio.h    | 4 +++-
 include/linux/blkdev.h | 2 ++
 4 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 50e579088aca..9e5061ecc317 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -255,6 +255,13 @@ void bio_init(struct bio *bio, struct bio_vec *table,
 }
 EXPORT_SYMBOL(bio_init);
 
+unsigned int bio_max_size(struct bio *bio)
+{
+	struct request_queue *q = bio->bi_bdev->bd_disk->queue;
+
+	return q->limits.bio_max_bytes;
+}
+
 /**
  * bio_reset - reinitialize a bio
  * @bio:	bio to reset
@@ -866,7 +873,7 @@ bool __bio_try_merge_page(struct bio *bio, struct page *page,
 		struct bio_vec *bv = &bio->bi_io_vec[bio->bi_vcnt - 1];
 
 		if (page_is_mergeable(bv, page, len, off, same_page)) {
-			if (bio->bi_iter.bi_size > UINT_MAX - len) {
+			if (bio->bi_iter.bi_size > bio_max_size(bio) - len) {
 				*same_page = false;
 				return false;
 			}
diff --git a/block/blk-settings.c b/block/blk-settings.c
index b4aa2f37fab6..cd3dcb5afe50 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -37,6 +37,7 @@ EXPORT_SYMBOL_GPL(blk_queue_rq_timeout);
  */
 void blk_set_default_limits(struct queue_limits *lim)
 {
+	lim->bio_max_bytes = UINT_MAX;
 	lim->max_segments = BLK_MAX_SEGMENTS;
 	lim->max_discard_segments = 1;
 	lim->max_integrity_segments = 0;
@@ -168,6 +169,10 @@ void blk_queue_max_hw_sectors(struct request_queue *q, unsigned int max_hw_secto
 				 limits->logical_block_size >> SECTOR_SHIFT);
 	limits->max_sectors = max_sectors;
 
+	if (check_shl_overflow(max_sectors, SECTOR_SHIFT,
+				&limits->bio_max_bytes))
+		limits->bio_max_bytes = UINT_MAX;
+
 	q->backing_dev_info->io_pages = max_sectors >> (PAGE_SHIFT - 9);
 }
 EXPORT_SYMBOL(blk_queue_max_hw_sectors);
diff --git a/include/linux/bio.h b/include/linux/bio.h
index d0246c92a6e8..e5add63da3af 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -106,6 +106,8 @@ static inline void *bio_data(struct bio *bio)
 	return NULL;
 }
 
+extern unsigned int bio_max_size(struct bio *bio);
+
 /**
  * bio_full - check if the bio is full
  * @bio:	bio to check
@@ -119,7 +121,7 @@ static inline bool bio_full(struct bio *bio, unsigned len)
 	if (bio->bi_vcnt >= bio->bi_max_vecs)
 		return true;
 
-	if (bio->bi_iter.bi_size > UINT_MAX - len)
+	if (bio->bi_iter.bi_size > bio_max_size(bio) - len)
 		return true;
 
 	return false;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 158aefae1030..c205d60ac611 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -312,6 +312,8 @@ enum blk_zoned_model {
 };
 
 struct queue_limits {
+	unsigned int		bio_max_bytes;
+
 	unsigned long		bounce_pfn;
 	unsigned long		seg_boundary_mask;
 	unsigned long		virt_boundary_mask;
-- 
2.29.0

