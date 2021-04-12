Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90F82C433ED
	for <linux-block@archiver.kernel.org>; Mon, 12 Apr 2021 03:16:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63BFD6120A
	for <linux-block@archiver.kernel.org>; Mon, 12 Apr 2021 03:16:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235700AbhDLDQk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 11 Apr 2021 23:16:40 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:17914 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235439AbhDLDQj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 11 Apr 2021 23:16:39 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20210412031620epoutp0275deba76136a2b969bbdeb92a5d2fd7c~0-fGSKQwE3269832698epoutp02q
        for <linux-block@vger.kernel.org>; Mon, 12 Apr 2021 03:16:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20210412031620epoutp0275deba76136a2b969bbdeb92a5d2fd7c~0-fGSKQwE3269832698epoutp02q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1618197380;
        bh=j1YhnX5ISNNBFoQEctD+V8cBoDWL1TmpmbxO1C7wpYE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FxJR5Wuimy8j5hp9Zpr5jRaDBHLwnts294NNVYwAUC4ykRwfQpFqp6VzfV4RH+xjf
         c/cxGD4JvAGoPhZKjihkbTGJ3eziJKhWHnRCsaOh5u8DDsGS4MDiX3mwAurV5hGiRr
         XP51rfTcoKIrIpULJZ93oTDl3L2mEXnLXVg9gJW4=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20210412031619epcas1p25d0b32bb3ef515c32704ba485d082536~0-fFpGxlh2247922479epcas1p2M;
        Mon, 12 Apr 2021 03:16:19 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.163]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4FJYmJ4xH9z4x9QB; Mon, 12 Apr
        2021 03:16:16 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        B1.8B.02277.08BB3706; Mon, 12 Apr 2021 12:16:16 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20210412031616epcas1p4002efe42935c89c66b879f15a7446d7f~0-fCrcY2C2011120111epcas1p4P;
        Mon, 12 Apr 2021 03:16:16 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210412031616epsmtrp2b5d9aec349794f728d9d020bcf55f17c~0-fCqI6nO1761817618epsmtrp2L;
        Mon, 12 Apr 2021 03:16:16 +0000 (GMT)
X-AuditID: b6c32a36-4edff700000108e5-cb-6073bb806f7a
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        36.74.33967.08BB3706; Mon, 12 Apr 2021 12:16:16 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.99.105]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210412031615epsmtip1dd705227b22e1ea636cd1ed65d141f46~0-fCccGlC2593925939epsmtip1n;
        Mon, 12 Apr 2021 03:16:15 +0000 (GMT)
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
Subject: [PATCH v6 1/3] bio: limit bio max size
Date:   Mon, 12 Apr 2021 11:58:29 +0900
Message-Id: <20210412025831.31498-2-nanich.lee@samsung.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210412025831.31498-1-nanich.lee@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0xbdRTH/d3b3paZkku7zV9QEDpYHPJoocAPhYXMDa8ZOnDGROMCtVyB
        WNrSWwgoMd14jY6w4jYehcECdc4CQoABnQGUPaSCGMfDMXkMIRs+gI0K4bGHLXeL/HfO+X3O
        +Z5zfr8fHxcuEe78VJWO1qrkSjGxg9NxdV9QgP47JlFSY/NB1ZYOgBomTxOo7P46jvILVzGU
        W99MoAFjHYaK505w0SPDFIZWZhjUfftVNHylmkB9Z3IxVN5WjaOx6UEeujo1ykEz5lIcDdmW
        uahmNhptfH0doKW133jop64zOGruXieid1PDI4ep0txFHmU1TfKotkt+1PDPGVSrpYiges83
        8qilnlGCKmm3AMre6kkVfn8Ki3v+Q2VkCi1PorVetEqhTkpVJUeJDx9NeCMhNEwiDZBGoHCx
        l0qeRkeJD8bGBcSkKh2Tir0y5coMRyhOzjDioP2RWnWGjvZKUTO6KDGtSVJqpBJNICNPYzJU
        yYEKddprUokkONRBJipTLhbyNevBWSd7/ubqQY2vAfD5kJTBsvlsA9jBF5JdAA7YNwnWWQaw
        6/IJjgG4OJxVAKfGt2xnQm9eGZeFugGc/9fyNMMOYL/tEuGkCNIflizc3jrYSdowuNYwAJwO
        Ts4COGIr2KJEZBDseNKCOxvhkL7QPC1xhgXk67C1c5bLyr0MH04X407bhYyEE/1/ECzjBm2V
        c1st4Q4m93IV7qwPySd8aD6Xj7PDHYSrcylsHRH868d2Hmu7Q/tiN8HypwDMLagFrGME0Hzv
        IsZSIXDZbgfOQji5DzZfCWLD3tC6eR6wwq5wcaWYy2oJ4MkCIYv4wMG8afyZ1r0m69OKFGzq
        rMDYlZ4GsLLe3Qi8TNvGMW0bx/S/8AWAW8BuWsOkJdOMVBO8/YJbwdbL9wvrAl8u3A/sAxgf
        9AHIx8U7BR9nM4lCQZI8+zNaq07QZihppg+EOnZdirvvUqgdX0elS5CGBoeEhCBZWHhYaIj4
        BYFccidBSCbLdfSnNK2htc/yML6Lux4r+v2seZZ7zEPs1mo4IqVvDIOix3oXwuMxoSXiX3ql
        olBnVy7+6vlF5jvn4vcWxPq/7zf0QRZfVq54r3F5AZNZa+0v5sd8Nf+o51veD52ertnaO6Z3
        x+pyBExbfwQvfiO7wmfj7J7oC75D6TG/uLq6Jh65a+RkPedvHEuv0omuYSXhjYN518BNynS8
        fr9wLSCnOk3tpl9t8TYbNx8+0NcpBmWDsaPpnzfxBH/eii8fz/Ru+Uf0ZmXFbP9QQXDdIUO0
        ov3AhKjKrsp520c7PnF0+ZtProuGblqDeuveenBrc68VHThYOywr29VS7DK5R9Vy46NjHmTF
        SkOE73GppXhk5q6Yw6TIpX64lpH/Bz9L7/yCBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJIsWRmVeSWpSXmKPExsWy7bCSnG7D7uIEg4NzOSzmrNrGaLH6bj+b
        xbQPP5ktWtu/MVk0L17PZnF6wiImi54nTawWf7vuMVl8fVhssfeWtsXlXXPYLA5NbmaymL55
        DrPFtftn2C0O37vKYvFwyURmi3MnP7FazHvsYPFr+VFGi/c/rrNbnNoxmdli/d6fbA5iHpev
        eHtMbH7H7rFz1l12j80rtDwuny312LSqk81j/9w17B7v911l8+jbsorR4/MmOY/2A91MAdxR
        XDYpqTmZZalF+nYJXBnL2jkKfhpVdOx7zdrAOE+1i5GTQ0LARGJ/yzTWLkYuDiGB3YwSh16t
        ZYVISEkcP/EWyOYAsoUlDh8uhqj5yCjx/lgTO0gNm4CORN/bW2wgCRGB20wSl7YcZQFxmAVe
        M0p0PV7EAlIlLKAvse3/BmaQSSwCqhJL7huAhHkFrCU2bX8MtUxe4s/9HmYQm1PARuLOiUds
        ILYQUM3bNS/ZIOoFJU7OfAI2khmovnnrbOYJjAKzkKRmIUktYGRaxSiZWlCcm55bbFhgmJda
        rlecmFtcmpeul5yfu4kRHJtamjsYt6/6oHeIkYmD8RCjBAezkghvUmVxghBvSmJlVWpRfnxR
        aU5q8SFGaQ4WJXHeC10n44UE0hNLUrNTUwtSi2CyTBycUg1MMTXXJllrnKloY3y2SvjQvo/M
        p145L+liE3a0meChfSMkxmVunDzvwyXsBRN3FhR/a/9Vl3RLRbp83/23JSYihoJnNB9923+d
        Y/f+bvk9nI3ewR//Pll7VTbFU3aqAavHy7RnLecFZzvqSK6y3eh9RG9VZKn9Se0PXhIlPUfP
        1s9l7Pz00Cj1Evu/NgXXm0uPph0WXhCzxjOY0/nRHq6+/+5iMkeK64tumfBkJCYrCapHTN5V
        obyrRsZaLrekQ4Ppq42FpPkD54dd/YeuuD0+Up1k8fL1/xlNx+WOvs7wlVjEPuXDrZKnC10j
        5X/xnzp7YUv5i37ughUHD+2dKF69U/1v55Rj+9jql+mw19YrsRRnJBpqMRcVJwIA7YXZfzwD
        AAA=
X-CMS-MailID: 20210412031616epcas1p4002efe42935c89c66b879f15a7446d7f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210412031616epcas1p4002efe42935c89c66b879f15a7446d7f
References: <20210412025831.31498-1-nanich.lee@samsung.com>
        <CGME20210412031616epcas1p4002efe42935c89c66b879f15a7446d7f@epcas1p4.samsung.com>
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
 include/linux/bio.h    |  2 +-
 include/linux/blkdev.h |  4 ++++
 4 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 50e579088aca..e4d6169106b6 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -255,6 +255,17 @@ void bio_init(struct bio *bio, struct bio_vec *table,
 }
 EXPORT_SYMBOL(bio_init);
 
+unsigned int bio_max_size(struct bio *bio)
+{
+	struct request_queue *q = bio->bi_disk->queue;
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
index d0246c92a6e8..830c784967c0 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -119,7 +119,7 @@ static inline bool bio_full(struct bio *bio, unsigned len)
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

