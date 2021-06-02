Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24A24C4708F
	for <linux-block@archiver.kernel.org>; Wed,  2 Jun 2021 12:29:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07DD7613BA
	for <linux-block@archiver.kernel.org>; Wed,  2 Jun 2021 12:29:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbhFBMbA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Jun 2021 08:31:00 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:62713 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbhFBMa7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Jun 2021 08:30:59 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20210602122915epoutp026316186a6e2c0dbadae524f6e1062afd~Ew7bAm-My0256502565epoutp02i
        for <linux-block@vger.kernel.org>; Wed,  2 Jun 2021 12:29:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20210602122915epoutp026316186a6e2c0dbadae524f6e1062afd~Ew7bAm-My0256502565epoutp02i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1622636955;
        bh=eUZTj1M0+JvhrhsGNMSsdOfN3rW3wIlScH41VlTusFU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XVCg5XKhSHv+dca12Nk/zArothjhWeMYZEuy+35YspZgSYORR9KMNpVqTIRSMBV2d
         8/UxV+2oOiifHAHVsiqvzSUVYvQ68jfJmEsXeb4eCVhiULyXsiecXbci2hsKZ6+vN/
         9wLoRJc0IJOQm3Qrbi/6+FmrYhw1KtHA3chQoEm0=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20210602122914epcas1p1ee63d323b8d02232f22be4a8c488aa65~Ew7aKcjPH1289512895epcas1p1i;
        Wed,  2 Jun 2021 12:29:14 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.163]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4Fw7cl1sbyz4x9Pv; Wed,  2 Jun
        2021 12:29:11 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        4E.33.09736.79977B06; Wed,  2 Jun 2021 21:29:11 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20210602122910epcas1p17ab868175c38cf3f143b64f4ec59f75c~Ew7WbSqig1052410524epcas1p1J;
        Wed,  2 Jun 2021 12:29:10 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210602122910epsmtrp2d8a5d8e03d239e3f2263fb8aa859fe4b~Ew7WZtuNP2283522835epsmtrp2Z;
        Wed,  2 Jun 2021 12:29:10 +0000 (GMT)
X-AuditID: b6c32a39-8d9ff70000002608-fa-60b77997418c
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        6F.0C.08637.69977B06; Wed,  2 Jun 2021 21:29:10 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.99.105]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210602122910epsmtip1fb6b8197cbb443d5e4392c0214dc7fe5~Ew7WEqYFB0369203692epsmtip1X;
        Wed,  2 Jun 2021 12:29:10 +0000 (GMT)
From:   Changheun Lee <nanich.lee@samsung.com>
To:     hch@infradead.org, Johannes.Thumshirn@wdc.com, alex_y_xu@yahoo.ca,
        asml.silence@gmail.com, axboe@kernel.dk, bgoncalv@redhat.com,
        bvanassche@acm.org, damien.lemoal@wdc.com,
        gregkh@linuxfoundation.org, jaegeuk@kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ming.lei@redhat.com, osandov@fb.com, patchwork-bot@kernel.org,
        tj@kernel.org, tom.leiming@gmail.com, yi.zhang@redhat.com
Cc:     jisoo2146.oh@samsung.com, junho89.kim@samsung.com,
        mj0123.lee@samsung.com, seunghwan.hyun@samsung.com,
        sookwan7.kim@samsung.com, woosung2.lee@samsung.com,
        yt0928.kim@samsung.com, Changheun Lee <nanich.lee@samsung.com>
Subject: [PATCH v11 1/3] bio: control bio max size
Date:   Wed,  2 Jun 2021 21:10:35 +0900
Message-Id: <20210602121037.11083-2-nanich.lee@samsung.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210602121037.11083-1-nanich.lee@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Tf1STZRTHz7MX3g1l+TbQHkfamvWHGLgxBg+/gtSD7zlEoeJJ+yO24JUR
        Y1t7WUEditP41RgCBwKZKBxGWPyQmMqPnaY09HRApRSJRAEROpQlEAMSQWpj48R/3/vcz73f
        c+9zLgvjFDG5rBRFOqVWSOV8fJNbe89ugV9lZodE8HSOic7fb2ai6sZ2gJpGinFkvlUDUMXs
        EoZy8xcZSGtsxdH1kjoGmmw1YEg/+YU7eqYbZaCFcRpZhvegAXM1jqxlWgaqvFCNoV/GbjBR
        z+igGxqvL8VQf++cOzo7EYWenrsG0MyTISbq6yzD0FB/BY5aLUt4FJccuBNDlmqnmWSXYYRJ
        XvjGlxy4qSFNjV/i5JUzzUxy5vIgTp682AhIm2knmd9dyCCt1gYszvNdebiMkiZRah6lSFQm
        pSiSI/gxRxL2J4iDBEI/YQgK5vMU0jQqgn/gzTi/6BS5fQV83kdSucb+FCelaf7e18PVSk06
        xZMp6fQIPqVKkquEApU/LU2jNYpk/0RlWqhQIAgQ20mJXDbV1MtQ/RaVof9hmpkNTAId8GBB
        IhCaT5UxdWATi0N0Ami2NLqCOQAr60pcwaI9MA66rZcsfX0OdyYsAN7V9rkoG4Arpx8wHBRO
        vAZPPh7GHdqbqMGgeYR2QBgxAeCd3ry1hBcRACev5wKHdiNehQX9P61ZsIkw2Lb4lbvT7iW4
        MqbHHNqDCIemBybcyTwPe6sm13jMzmgvncYcBpAwesArwzeBs/gArFq95mrkBR/9eJHp1Fxo
        m7bgzoJCALV5NcAZlABYP9XAcFIiOGez2RMsu8Vu2Gre63x+GXYtnwFO5+fg9ILe3YFAgg0L
        8jhO5BV4I2cMW/eaaulydSTh92XFrnUVA1j7V617CeAZNgxk2DCQ4X/nWoA1gm2Uik5Lpmih
        Srzxl01g7S58QzpB5eNZfytgsIAVQBbG92YfVFyScNhJ0sxPKLUyQa2RU7QViO3rLsW4WxOV
        9sNSpCcIxQEikQgFBgUHiUX8F9jJ+z+VcIhkaTqVSlEqSr1ex2B5cLMZOp8Xyw28ipBUH2sG
        /kfovl/bM4danuR1b97+eVX98dXLffWTxt5vdR36ooaRoph7Z1HtQE7VVGRcVOaR+7Et+dnz
        tuBWa8pA/OFTngtZPVv3CSWDV49tb7fUxL99qN9ovddQeuJht2T27kJcbstK8BYU6RmYw54Z
        v7189VlqW9KuEGVGcXlW8xYNtrygswTMS+oyPyPjN5eb8Mjg7ur3fU7g3D210r/LD97eYfr4
        WCy0Bf1+fMeoV3zoob7ixb5/JE313w0X7GvDZI+i31rSz//7oSwwXBj7xtGwLvPEO0dHDdt2
        pZ2XZ+zUHJb/aWr6wBim8Ih+T6S41bFayPmZ9s/yfsh3o2VSoS+mpqX/ARboaq2gBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEIsWRmVeSWpSXmKPExsWy7bCSnO60yu0JBqv+ilisu7OG3WLOqm2M
        Fqvv9rNZ7Lo4n9Fi2oefzBat7d+YLJoXr2ezOD1hEZPFk/WzmC16njSxWvztusdk8fVhscXe
        W9oWl3fNYbM4NLmZyWL65jnMFtfun2G3OHzvKovFwyUTmS3OnfzEajHvsYPFr+VHGS3e/7jO
        bnFqx2Rmi+vnprFZrN/7k81ByuPyFW+Pic3v2D12zrrL7rF5hZbH5bOlHptWdbJ57J+7ht3j
        /b6rbB59W1YxenzeJOfRfqCbyePQoWXMATxRXDYpqTmZZalF+nYJXBnPV59kKnjqUNFz8B17
        A+Mmgy5GTg4JAROJn0uXs3UxcnEICexmlFhzZQE7REJK4viJt6xdjBxAtrDE4cPFEDUfGSUu
        LLnMDFLDJqAj0ff2FhuILSKwlVnicYs8SBGzwGtGia7Hi1hAEsICRhJPTrcygtgsAqoSHefO
        g8V5BawlNn6bygqxTF7iz/0esKGcAjYSmx5sYgNZLARUM21KJES5oMTJmU/AWpmBypu3zmae
        wCgwC0lqFpLUAkamVYySqQXFuem5xYYFhnmp5XrFibnFpXnpesn5uZsYwdGspbmDcfuqD3qH
        GJk4GA8xSnAwK4nwuudtTRDiTUmsrEotyo8vKs1JLT7EKM3BoiTOe6HrZLyQQHpiSWp2ampB
        ahFMlomDU6qBKTEmv/mKzrQ27eSYyqepN9KcbuRt+7pTOmnS5btqh64YPhIW7V7byp0c++an
        otBslYTiHS+4nscK5Z/PFNSRme3B9uiw4JpTn+tK5dZWzX7qlnryVNqW7zF3O37Mepi1sD5O
        5VD+dv7flz4d1mPqdzm9Ni3xzv2rQhuvlU2Vn+7cs3pqy7FqM+GLVwS2aby6wBDQIa2tPa3w
        TMi6N2q1Km7pLNYl+hlBO9yCTptWN81YWnpj7jP56TJ33YpUu45dPvp5ZVibvZHRydhM280H
        uw7f4I2pro/besJJaPP8dYHbL/XXeBR8lp/5Is/7eFzC0hpJgwzFaSc6dDKWlld0l/9/rbP1
        YOnkff5iRV2iSizFGYmGWsxFxYkArOzfq1UDAAA=
X-CMS-MailID: 20210602122910epcas1p17ab868175c38cf3f143b64f4ec59f75c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210602122910epcas1p17ab868175c38cf3f143b64f4ec59f75c
References: <20210602121037.11083-1-nanich.lee@samsung.com>
        <CGME20210602122910epcas1p17ab868175c38cf3f143b64f4ec59f75c@epcas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

bio size can grow up to 4GB after muli-page bvec has been enabled.
But sometimes large size of bio would lead to inefficient behaviors.
Control of bio max size will be helpful to improve inefficiency.

Below is a example for inefficient behaviours.
In case of large chunk direct I/O, - 32MB chunk read in user space -
all pages for 32MB would be merged to a bio structure if the pages
physical addresses are contiguous. It makes some delay to submit
until merge complete. bio max size should be limited to a proper size.

When 32MB chunk read with direct I/O option is coming from userspace,
kernel behavior is below now in do_direct_IO() loop. It's timeline.

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
 block/bio.c            | 17 ++++++++++++++---
 block/blk-settings.c   | 19 +++++++++++++++++++
 include/linux/bio.h    |  4 +++-
 include/linux/blkdev.h |  3 +++
 4 files changed, 39 insertions(+), 4 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 44205dfb6b60..c52639bb80cd 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -255,6 +255,13 @@ void bio_init(struct bio *bio, struct bio_vec *table,
 }
 EXPORT_SYMBOL(bio_init);
 
+unsigned int bio_max_size(struct bio *bio)
+{
+	struct block_device *bdev = bio->bi_bdev;
+
+	return bdev ? bdev->bd_disk->queue->limits.max_bio_bytes : UINT_MAX;
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
@@ -995,6 +1002,7 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 {
 	unsigned short nr_pages = bio->bi_max_vecs - bio->bi_vcnt;
 	unsigned short entries_left = bio->bi_max_vecs - bio->bi_vcnt;
+	unsigned int bytes_left = bio_max_size(bio) - bio->bi_iter.bi_size;
 	struct bio_vec *bv = bio->bi_io_vec + bio->bi_vcnt;
 	struct page **pages = (struct page **)bv;
 	bool same_page = false;
@@ -1010,7 +1018,8 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 	BUILD_BUG_ON(PAGE_PTRS_PER_BVEC < 2);
 	pages += entries_left * (PAGE_PTRS_PER_BVEC - 1);
 
-	size = iov_iter_get_pages(iter, pages, LONG_MAX, nr_pages, &offset);
+	size = iov_iter_get_pages(iter, pages, bytes_left, nr_pages,
+				  &offset);
 	if (unlikely(size <= 0))
 		return size ? size : -EFAULT;
 
@@ -1038,6 +1047,7 @@ static int __bio_iov_append_get_pages(struct bio *bio, struct iov_iter *iter)
 {
 	unsigned short nr_pages = bio->bi_max_vecs - bio->bi_vcnt;
 	unsigned short entries_left = bio->bi_max_vecs - bio->bi_vcnt;
+	unsigned int bytes_left = bio_max_size(bio) - bio->bi_iter.bi_size;
 	struct request_queue *q = bio->bi_bdev->bd_disk->queue;
 	unsigned int max_append_sectors = queue_max_zone_append_sectors(q);
 	struct bio_vec *bv = bio->bi_io_vec + bio->bi_vcnt;
@@ -1058,7 +1068,8 @@ static int __bio_iov_append_get_pages(struct bio *bio, struct iov_iter *iter)
 	BUILD_BUG_ON(PAGE_PTRS_PER_BVEC < 2);
 	pages += entries_left * (PAGE_PTRS_PER_BVEC - 1);
 
-	size = iov_iter_get_pages(iter, pages, LONG_MAX, nr_pages, &offset);
+	size = iov_iter_get_pages(iter, pages, bytes_left, nr_pages,
+				  &offset);
 	if (unlikely(size <= 0))
 		return size ? size : -EFAULT;
 
diff --git a/block/blk-settings.c b/block/blk-settings.c
index 902c40d67120..e270e31519a1 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -32,6 +32,7 @@ EXPORT_SYMBOL_GPL(blk_queue_rq_timeout);
  */
 void blk_set_default_limits(struct queue_limits *lim)
 {
+	lim->max_bio_bytes = UINT_MAX;
 	lim->max_segments = BLK_MAX_SEGMENTS;
 	lim->max_discard_segments = 1;
 	lim->max_integrity_segments = 0;
@@ -100,6 +101,24 @@ void blk_queue_bounce_limit(struct request_queue *q, enum blk_bounce bounce)
 }
 EXPORT_SYMBOL(blk_queue_bounce_limit);
 
+/**
+ * blk_queue_max_bio_bytes - set bio max size for queue
+ * @q: the request queue for the device
+ * @bytes : bio max bytes to be set
+ *
+ * Description:
+ *    Set proper bio max size to optimize queue operating.
+ **/
+void blk_queue_max_bio_bytes(struct request_queue *q, unsigned int bytes)
+{
+	struct queue_limits *limits = &q->limits;
+	unsigned int max_bio_bytes = round_up(bytes, PAGE_SIZE);
+
+	limits->max_bio_bytes = max_t(unsigned int, max_bio_bytes,
+				      BIO_MAX_VECS * PAGE_SIZE);
+}
+EXPORT_SYMBOL(blk_queue_max_bio_bytes);
+
 /**
  * blk_queue_max_hw_sectors - set max sectors for a request for this queue
  * @q:  the request queue for the device
diff --git a/include/linux/bio.h b/include/linux/bio.h
index a0b4cfdf62a4..f1a99f0a240c 100644
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
index 1255823b2bc0..861888501fc0 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -326,6 +326,8 @@ enum blk_bounce {
 };
 
 struct queue_limits {
+	unsigned int		max_bio_bytes;
+
 	enum blk_bounce		bounce;
 	unsigned long		seg_boundary_mask;
 	unsigned long		virt_boundary_mask;
@@ -1132,6 +1134,7 @@ extern void blk_abort_request(struct request *);
  * Access functions for manipulating queue properties
  */
 extern void blk_cleanup_queue(struct request_queue *);
+extern void blk_queue_max_bio_bytes(struct request_queue *, unsigned int);
 void blk_queue_bounce_limit(struct request_queue *q, enum blk_bounce limit);
 extern void blk_queue_max_hw_sectors(struct request_queue *, unsigned int);
 extern void blk_queue_chunk_sectors(struct request_queue *, unsigned int);
-- 
2.29.0

