Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F06C3C433ED
	for <linux-block@archiver.kernel.org>; Tue, 13 Apr 2021 03:13:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C88D261222
	for <linux-block@archiver.kernel.org>; Tue, 13 Apr 2021 03:13:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242094AbhDMDNV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 12 Apr 2021 23:13:21 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:47992 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240266AbhDMDNU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Apr 2021 23:13:20 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20210413031300epoutp02b67d6aa67e926136b5a95ed591efa481~1TFegOtgP2704127041epoutp02C
        for <linux-block@vger.kernel.org>; Tue, 13 Apr 2021 03:13:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20210413031300epoutp02b67d6aa67e926136b5a95ed591efa481~1TFegOtgP2704127041epoutp02C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1618283580;
        bh=kNzCIu4qq4Wm9Hg+REw54vIgdkwzhXGBmueU1GQaocc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ww7XhEgx+1ueyOjIHI2nQxtx0TAyOR69LHQhC/7E5aHH4V8ukv6iT37Lm1tcvP41B
         9OqKppGEpd1AmpMXFDUQNk5mWEshF89BEmtDhLgZB/YYZhiX+6WHc248jRjx6VlEtu
         yeWUHnqBRHd7C89kLEwzEcWwvF4nTsRrFm19KrqM=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20210413031259epcas1p3b5ce298bab3c7569fa352367ac0aa828~1TFd3HdZR1038310383epcas1p3V;
        Tue, 13 Apr 2021 03:12:59 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.164]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4FK9f22pD2z4x9Pp; Tue, 13 Apr
        2021 03:12:58 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        77.02.23820.A3C05706; Tue, 13 Apr 2021 12:12:58 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20210413031257epcas1p329f38effa71445de2464cee32002e618~1TFcHzyIk2879828798epcas1p3G;
        Tue, 13 Apr 2021 03:12:57 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210413031257epsmtrp1843d7e0e7a8c5674c0676172f2c82b58~1TFcGhESY2206622066epsmtrp1K;
        Tue, 13 Apr 2021 03:12:57 +0000 (GMT)
X-AuditID: b6c32a37-a6fff70000015d0c-10-60750c3aa224
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        50.C5.08745.93C05706; Tue, 13 Apr 2021 12:12:57 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.99.105]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210413031257epsmtip2f0d356796c37dd87d7aef35b71b697d1~1TFbxHSnZ1314913149epsmtip2H;
        Tue, 13 Apr 2021 03:12:57 +0000 (GMT)
From:   Changheun Lee <nanich.lee@samsung.com>
To:     damien.lemoal@wdc.com, bvanassche@acm.org,
        Johannes.Thumshirn@wdc.com, asml.silence@gmail.com,
        axboe@kernel.dk, gregkh@linuxfoundation.org, hch@infradead.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ming.lei@redhat.com, osandov@fb.com, patchwork-bot@kernel.org,
        tj@kernel.org, tom.leiming@gmail.com
Cc:     jisoo2146.oh@samsung.com, junho89.kim@samsung.com,
        mj0123.lee@samsung.com, seunghwan.hyun@samsung.com,
        sookwan7.kim@samsung.com, woosung2.lee@samsung.com,
        yt0928.kim@samsung.com, Changheun Lee <nanich.lee@samsung.com>
Subject: [PATCH v7 1/3] bio: limit bio max size
Date:   Tue, 13 Apr 2021 11:55:00 +0900
Message-Id: <20210413025502.31579-2-nanich.lee@samsung.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210413025502.31579-1-nanich.lee@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Te1BUVRjv3LvsA13muiIdt6nWFZvhvcuycEBocES8M9RAr8lsCja47mL7
        au9uYWNGbSEvZQmUXEBwhXSQ2IlFhgXBBitaBWfiFTABkhiiAQZhgOi0Dyj+O9/v+/2+3/d9
        5xw2zvuLyWdnqvWUTi1TCpnejOZrAaKQmM2GNFH3lc2ooq4ZoEujRUx0+sEyjr48/hBDxvNW
        JrphsmCocPJzL/Q4fwxDixM0ah8JQn2tFUzUWWLEUJmtAkeD490sdG1sgIEmaopxdNMx74XO
        3o5HKxd+BGhu6VcWut5SgiNr+zIz3o/s608ii42zLNJuHmWRtouBZF+PgWysy2OSVyvrWeRc
        xwCTPNlUB8iFxufI498XYCmbDipjFZQsg9IJKHW6JiNTLY8TJr2WujdVGikSh4ijUZRQoJap
        qDhhwkspIYmZSuekQsGHMqXBCaXIaFoY9mKsTmPQUwKFhtbHCSlthlIrFmlDaZmKNqjloeka
        VYxYJAqXOplpSkX+ai6mHY3IutWSg2eD7hfyAYcNiQhoKTPh+cCbzSNaADRdrgauBI+YB/DM
        zyJPYgHAtv5yxrriuz+bmZ5EK4D2ypus/1iO8lW3nEkEw5MzI26WL+HA4NKlG8AV4MRtAPsd
        OUwXaysRBjttd911GcQuuFjyt5PEZnOJ3dA2kuyxex6ujhfiLphDxMIBi8oFc4kt0HFm0q3E
        nRTj5XL3DJAwcuAPhYOYR5sA82qr1treCu91NbE8Zz6cLspheQQFABpzqoAnMAFYM/XNmloC
        5xcW3A3hRAC0toZ54B3Q/qgSeJx94OxioZeLAgkuzM3heSj+sPuLcXzda+pb+1pFEra3lzI8
        +y0CsLpXbgIC84Z5zBvmMf9vXA3wOuBHaWmVnKLFWsnGK24E7rcfGNUCTs88CO0EGBt0AsjG
        hb7cxFJ9Go+bITvyMaXTpOoMSoruBFLnrotx/rZ0jfPzqPWpYmm4RCJBEZFRkVKJ8Gnue6Jb
        qTxCLtNT71OUltKt6zA2h5+N2SY6FLP48LngJb7ya2z+BDvo3tvbi+Nf5TzzhqWtpXabPO+r
        ZXsBp2e4rHjop5cPpSRWMmoi/a527TH4/FIzVJU1kLQnIWAo2diwsnJqqOQwZUsMrfAp3HnY
        KsgUfYSsvhG93ednvBuajiZEM9Sv+4jbhz+L4T5lP9RhKRo241ifyPTw6O7WKFZUWGXbrnNH
        bBP6hbsnnqx88O70MSxbNzj2yf3eO8Gb9rc1HQiCluSixIas/u3vHNvnF710Yf66ouPgPunk
        W/dfmZnllwfK67msOfNFi/hRadez/j25Km5Vze9T1tp/6k/9RnMnph/LP3UceHJH8Yf/FU3Q
        zh1vCnL3zoQLGbRCJg7EdbTsXzzr+RmEBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJIsWRmVeSWpSXmKPExsWy7bCSvK4lT2mCwaXDKhZzVm1jtFh9t5/N
        YtqHn8wWre3fmCyaF69nszg9YRGTRc+TJlaLv133mCy+Piy22HtL2+LyrjlsFocmNzNZTN88
        h9ni2v0z7BaH711lsXi4ZCKzxbmTn1gt5j12sPi1/Cijxfsf19ktTu2YzGyxfu9PNgcxj8tX
        vD0mNr9j99g56y67x+YVWh6Xz5Z6bFrVyeaxf+4ado/3+66yefRtWcXo8XmTnEf7gW6mAO4o
        LpuU1JzMstQifbsEroyuPx1MBXdNKh7saGNuYDyj1sXIySEhYCKx8c02ti5GLg4hgR2MEifX
        NDFDJKQkjp94y9rFyAFkC0scPlwMUfORUWLzu4uMIDVsAjoSfW9vgTWLCNxmkri05SgLiMMs
        8JpRouvxIhaQKmEBfYlDm1+A2SwCqhJfJ39hBJnKK2AtsfmWP8QyeYk/93uYQcKcAjYSVxfl
        goSFgCr+7joKdg+vgKDEyZlPwKYwA5U3b53NPIFRYBaS1CwkqQWMTKsYJVMLinPTc4sNC4zy
        Usv1ihNzi0vz0vWS83M3MYJjU0trB+OeVR/0DjEycTAeYpTgYFYS4XWbUpIgxJuSWFmVWpQf
        X1Sak1p8iFGag0VJnPdC18l4IYH0xJLU7NTUgtQimCwTB6dUA9Oa5o2J28RMH5yUO+E0s1+i
        aX7WYmsX15BF9e/WqP8oDEionvVHJVikt0NO0EBpzTlHTZd3Wi5RrzVyLm0u/d+9Qp2/4+Op
        4hsWX0qPBef+Npmw5he386Rfr2/8Odt8LTR4vsXh7G2HrCz1pZVml9Xf3LT/Vc08tbvWCXGf
        VN8539Hi8nM7JuBTEK7094e358vt8i6SErnnjNhX/+w/qvXmjJfKdX4t86bK8scVl9fOlUg5
        P026lJf14tINmx8fF79nV3Q+scnsvG+6yI0m9iNfTNOSajgVeLsWS0w6vdbf9Eq34hy3n+ZT
        uCUnT/zz8tKR842tsl7h/z727Ob8/qCSn4tlnffF7TcfvJwTJ6DEUpyRaKjFXFScCABTjtU8
        PAMAAA==
X-CMS-MailID: 20210413031257epcas1p329f38effa71445de2464cee32002e618
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210413031257epcas1p329f38effa71445de2464cee32002e618
References: <20210413025502.31579-1-nanich.lee@samsung.com>
        <CGME20210413031257epcas1p329f38effa71445de2464cee32002e618@epcas1p3.samsung.com>
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
 block/bio.c            | 13 ++++++++++++-
 block/blk-settings.c   | 17 +++++++++++++++++
 include/linux/bio.h    |  4 +++-
 include/linux/blkdev.h |  4 ++++
 4 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 50e579088aca..4bad97f1d37b 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -255,6 +255,17 @@ void bio_init(struct bio *bio, struct bio_vec *table,
 }
 EXPORT_SYMBOL(bio_init);
 
+unsigned int bio_max_size(struct bio *bio)
+{
+	struct request_queue *q = bio->bi_bdev->bd_disk->queue;
+
+	if (blk_queue_limit_bio_size(q))
+		return blk_queue_get_max_sectors(q, bio_op(bio))
+			<< SECTOR_SHIFT;
+
+	return UINT_MAX;
+}
+
 /**
  * bio_reset - reinitialize a bio
  * @bio:	bio to reset
@@ -866,7 +877,7 @@ bool __bio_try_merge_page(struct bio *bio, struct page *page,
 		struct bio_vec *bv = &bio->bi_io_vec[bio->bi_vcnt - 1];
 
 		if (page_is_mergeable(bv, page, len, off, same_page)) {
-			if (bio->bi_iter.bi_size > UINT_MAX - len) {
+			if (bio->bi_iter.bi_size > bio_max_size(bio) - len) {
 				*same_page = false;
 				return false;
 			}
diff --git a/block/blk-settings.c b/block/blk-settings.c
index b4aa2f37fab6..1d94b97cea4f 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -928,6 +928,23 @@ void blk_queue_set_zoned(struct gendisk *disk, enum blk_zoned_model model)
 }
 EXPORT_SYMBOL_GPL(blk_queue_set_zoned);
 
+/**
+ * blk_queue_set_limit_bio_size - set limit bio size flag
+ * @q:		the request queue for the device
+ * @limit:	limit bio size on(true), or off
+ *
+ * bio max size will be limited to queue max sectors size,
+ * if limit is true.
+ */
+void blk_queue_set_limit_bio_size(struct request_queue *q, bool limit)
+{
+	if (limit)
+		blk_queue_flag_set(QUEUE_FLAG_LIMIT_BIO_SIZE, q);
+	else
+		blk_queue_flag_clear(QUEUE_FLAG_LIMIT_BIO_SIZE, q);
+}
+EXPORT_SYMBOL_GPL(blk_queue_set_limit_bio_size);
+
 static int __init blk_settings_init(void)
 {
 	blk_max_low_pfn = max_low_pfn - 1;
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
index 158aefae1030..c69a6ed7a189 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -617,6 +617,7 @@ struct request_queue {
 #define QUEUE_FLAG_RQ_ALLOC_TIME 27	/* record rq->alloc_time_ns */
 #define QUEUE_FLAG_HCTX_ACTIVE	28	/* at least one blk-mq hctx is active */
 #define QUEUE_FLAG_NOWAIT       29	/* device supports NOWAIT */
+#define QUEUE_FLAG_LIMIT_BIO_SIZE 30	/* limit bio size */
 
 #define QUEUE_FLAG_MQ_DEFAULT	((1 << QUEUE_FLAG_IO_STAT) |		\
 				 (1 << QUEUE_FLAG_SAME_COMP) |		\
@@ -663,6 +664,8 @@ bool blk_queue_flag_test_and_set(unsigned int flag, struct request_queue *q);
 #define blk_queue_fua(q)	test_bit(QUEUE_FLAG_FUA, &(q)->queue_flags)
 #define blk_queue_registered(q)	test_bit(QUEUE_FLAG_REGISTERED, &(q)->queue_flags)
 #define blk_queue_nowait(q)	test_bit(QUEUE_FLAG_NOWAIT, &(q)->queue_flags)
+#define blk_queue_limit_bio_size(q)	\
+	test_bit(QUEUE_FLAG_LIMIT_BIO_SIZE, &(q)->queue_flags)
 
 extern void blk_set_pm_only(struct request_queue *q);
 extern void blk_clear_pm_only(struct request_queue *q);
@@ -1183,6 +1186,7 @@ extern void blk_queue_required_elevator_features(struct request_queue *q,
 						 unsigned int features);
 extern bool blk_queue_can_use_dma_map_merging(struct request_queue *q,
 					      struct device *dev);
+extern void blk_queue_set_limit_bio_size(struct request_queue *q, bool limit);
 
 /*
  * Number of physical segments as sent to the device.
-- 
2.29.0

