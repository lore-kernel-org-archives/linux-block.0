Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E07C4C433E0
	for <linux-block@archiver.kernel.org>; Tue, 16 Mar 2021 08:02:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DC7164FC4
	for <linux-block@archiver.kernel.org>; Tue, 16 Mar 2021 08:02:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233252AbhCPIBp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Mar 2021 04:01:45 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:56900 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231782AbhCPIBN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Mar 2021 04:01:13 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20210316080111epoutp0153383ba67af5525dad4dd404b78d38a7~sw9HB5TOE1206312063epoutp01-
        for <linux-block@vger.kernel.org>; Tue, 16 Mar 2021 08:01:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20210316080111epoutp0153383ba67af5525dad4dd404b78d38a7~sw9HB5TOE1206312063epoutp01-
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1615881672;
        bh=ok7IJjIXz6xGgJxQYwq++bBOaNrRRQtln/5yQX/Ab8E=;
        h=From:To:Cc:Subject:Date:References:From;
        b=iTNIzFlViEeTZoxpRTBaKigtbVPE96WurR5kVzcPUEIRD+4UkftyoEmlDnuxsQHVw
         cmdxRRwE+YA4vyo/ezIomDjIwFy+CLg6g9DiM9v5I0LTEd6Ikj5bztL4ak1SeSJhRw
         cnDX+4fdczIr9xKKuL+YS6gqO0fgqdBp1Db7XmtI=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20210316080107epcas1p2c4af5c34116a9155ea9c48525dc90f4e~sw9CtBSC62840628406epcas1p2X;
        Tue, 16 Mar 2021 08:01:07 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.165]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4F05MQ06vKz4x9Pv; Tue, 16 Mar
        2021 08:01:06 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        65.9C.63458.1C560506; Tue, 16 Mar 2021 17:01:05 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20210316080104epcas1p11483035c927c2e65600ae90309334b24~sw9AT7RK30551905519epcas1p1A;
        Tue, 16 Mar 2021 08:01:04 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210316080104epsmtrp21486afa8beac66edb369a920be2fc362~sw9ASMiIj0276102761epsmtrp2I;
        Tue, 16 Mar 2021 08:01:04 +0000 (GMT)
X-AuditID: b6c32a36-6c9ff7000000f7e2-9b-605065c1e359
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        97.73.08745.0C560506; Tue, 16 Mar 2021 17:01:04 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.99.105]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210316080104epsmtip2effc8cf32bce778e9ba4fdda63b21d1a~sw9ACnqG61116211162epsmtip2i;
        Tue, 16 Mar 2021 08:01:04 +0000 (GMT)
From:   Changheun Lee <nanich.lee@samsung.com>
To:     Johannes.Thumshirn@wdc.com, asml.silence@gmail.com,
        axboe@kernel.dk, damien.lemoal@wdc.com, gregkh@linuxfoundation.org,
        hch@infradead.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, ming.lei@redhat.com, osandov@fb.com,
        patchwork-bot@kernel.org, tj@kernel.org, tom.leiming@gmail.com
Cc:     jisoo2146.oh@samsung.com, junho89.kim@samsung.com,
        mj0123.lee@samsung.com, seunghwan.hyun@samsung.com,
        sookwan7.kim@samsung.com, woosung2.lee@samsung.com,
        yt0928.kim@samsung.com, Changheun Lee <nanich.lee@samsung.com>
Subject: [RESEND PATCH v5 1/2] bio: limit bio max size
Date:   Tue, 16 Mar 2021 16:44:00 +0900
Message-Id: <20210316074401.4594-1-nanich.lee@samsung.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01TfUxTVxTffa99rZiaZ8F512yDvWiU75bScmWyuYy4l4DafRAzh4Fa3oCt
        tE1fYQJL7FYGCoyPwWTWCgYJbkxFW2BAxnAl03Q4ZAMlYvgKbC46PkLHUAu6lgcb/537+/3O
        +Z1z7r1CXDxKSISZOhNj1Km1FOHHa+sJjgz/kVGlSr+bVCBbUxtA346UE+izon8wZDnXTKDe
        inoMlU59ykfLxaMYWphgUddwKBrotBHIWWXBUI3DhqPbYzcEqGf0Fg9NNFTiqM81z0e1k3vQ
        4/M/ATT7cEiAfm6vwlFz1yNizxa60jIjoDusIwLa8XUIPfBLNm1vOkHQ3WcuCOjZH24RdFlL
        E6Dd9hfpoqslmMrvkHZ3BqNOY4xBjE6jT8vUpcdRCW+nvJ6iUEpl4bJdKIYK0qmzmDgqPlEV
        vjdT6x2QCspRa7O9kErNslTkK7uN+mwTE5ShZ01xFGNI0xpkUkMEq85is3XpERp9VqxMKo1S
        eJWp2own8618Q8/Oo4VjHp4ZuJ4vBhuEkIyGJ3/r5hcDP6GYbAfQ/Osg30eIyXkAG4f2cYQb
        wPMTJ3lrGc6iP3kc0QnglaLj+H8ql/kbgU9FkGGwbHqY8BEBZCsGC273rKhwchLAQVch4VP5
        k0rYtfw38MU8cju0XazGfbGIjIVXWq8JOL9AuDRWuopvhq5TUyt94F7c0np6pSgkB4Wwp9yF
        cwnxsG6xYbVZf3j/estqIQl0z3QRXEIJgJbCOsAdKgBsuNeIcSo5nHe7vYTQaxEMmzsjOfgl
        2OE5AzjnTXBmoZTvk0BSBI8XijnJNnijYAxf87p3sWO1Ig2Xzp0G3FYPw6GrtVgFCLSum8e6
        bh7r/8ZnAd4EnmUMbFY6w8oMUesv1g5WHnqIsh18MT0X4QSYEDgBFOJUgMgdti9VLEpT5+Yx
        Rn2KMVvLsE6g8G64Epds0ei9P0VnSpEpouRyOYpWxigVcmqrSC0dTxGT6WoT8yHDGBjjWh4m
        3CAxY5ILd5Orn6k5GLorqXTBMpR+wlrTErnYtyP4j6RNqry2vHD71sa/Qt9H/ZKNdY5h6tXX
        HtxdDPwkr6w69gBhixb8nrPI+IVMv3Xs85Gp/fJ8fxL4J85NmA+2Ji3N7X+5/4PgzEOOaMoT
        dv/OsRf8eg3djiNL3yeD9p2X8ibfSz4sHuuPzyo3dL9bTaVpHI14r8Fj387GxJsvTx5NWEgY
        kn4kmNXatzlzSyo3Pr2+XH9ZI7xWYX14IJeKmaOVjQ2zniemB6r2m4p3BlJtobqP73xZpauv
        8eQ3BzzKHxVrEkWPIwsC3bNM9803J+qO9OWc2lwbO174RuVXyvHw58CM/dLTRIrHZqhlIbiR
        Vf8LoWz+CnEEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupikeLIzCtJLcpLzFFi42LZdlhJXvdAakCCwbW7ahZzVm1jtFh9t5/N
        orX9G5NF8+L1bBanJyxisuh50sRq8bfrHpPF14fFFntvaVtc3jWHzeLQ5GYmi+mb5zBbXLt/
        ht3i8L2rLBYPl0xktjh38hOrxbzHDha/lh9ltHj/4zq7xakdk5kt1u/9yeYg6jGx+R27x85Z
        d9k9Nq/Q8rh8ttRj06pONo/9c9ewe7zfd5XNo2/LKkaPz5vkPNoPdDMFcEVx2aSk5mSWpRbp
        2yVwZfz7tJW14LBGRdv93ywNjCdluhg5OSQETCQOtb9g6WLk4hAS2MEosebMHVaIhJTE8RNv
        gWwOIFtY4vDhYoiaj4wSsza8BKthE9CR6Ht7iw0kISJwlEliw9VjzCAOs8BrRomux4tYQKqE
        Bcwk9v79wghiswioSsxZO4UZxOYVsJLYuPUYO8Q2eYk/93ug4oISJ2c+AetlBoo3b53NPIGR
        bxaS1CwkqQWMTKsYJVMLinPTc4sNC4zyUsv1ihNzi0vz0vWS83M3MYKjS0trB+OeVR/0DjEy
        cTAeYpTgYFYS4f2s45sgxJuSWFmVWpQfX1Sak1p8iFGag0VJnPdC18l4IYH0xJLU7NTUgtQi
        mCwTB6dUA1NZWuSupyfs571/dNKnKu70Sh8RhoP+zm+ze50V2fJnzd9pPpl1w46qgG9L7RjT
        M5Is57rNiJ24Opu9Z8X1rkeKy7devyZllSO3fPGmNZOvC6m4p5k8Efp05Vu2hri4eEOH648P
        SsEt/ZY/qq7wJflf39K/WfvopbCpPzMKTiWk8047+pX3pe2ablPBuypRjFZTOMP/fGYX+Oy7
        TSG0tdh07nOPQxlNDb2fCtcutvV6Hf8/tMrbUXNpkf7xZ07/fWRb9v2abKH1T+j/iRSDT/GP
        5ZT8as9eVChsLyvyc9+2YWLRw7Pyah1sp9K3ap0q7b2mfNt623Fl8bS7Kxq2bLx6K1/jSSaH
        WGzZzE0syUosxRmJhlrMRcWJAGihtuYdAwAA
X-CMS-MailID: 20210316080104epcas1p11483035c927c2e65600ae90309334b24
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210316080104epcas1p11483035c927c2e65600ae90309334b24
References: <CGME20210316080104epcas1p11483035c927c2e65600ae90309334b24@epcas1p1.samsung.com>
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
 include/linux/bio.h    |  2 +-
 include/linux/blkdev.h |  3 +++
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 1f2cc1fbe283..c528e1f944c7 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -287,6 +287,17 @@ void bio_init(struct bio *bio, struct bio_vec *table,
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
@@ -877,7 +888,7 @@ bool __bio_try_merge_page(struct bio *bio, struct page *page,
 		struct bio_vec *bv = &bio->bi_io_vec[bio->bi_vcnt - 1];
 
 		if (page_is_mergeable(bv, page, len, off, same_page)) {
-			if (bio->bi_iter.bi_size > UINT_MAX - len) {
+			if (bio->bi_iter.bi_size > bio_max_size(bio) - len) {
 				*same_page = false;
 				return false;
 			}
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 1edda614f7ce..13b6f6562a5b 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -113,7 +113,7 @@ static inline bool bio_full(struct bio *bio, unsigned len)
 	if (bio->bi_vcnt >= bio->bi_max_vecs)
 		return true;
 
-	if (bio->bi_iter.bi_size > UINT_MAX - len)
+	if (bio->bi_iter.bi_size > bio_max_size(bio) - len)
 		return true;
 
 	return false;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index f94ee3089e01..3aeab9e7e97b 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -621,6 +621,7 @@ struct request_queue {
 #define QUEUE_FLAG_RQ_ALLOC_TIME 27	/* record rq->alloc_time_ns */
 #define QUEUE_FLAG_HCTX_ACTIVE	28	/* at least one blk-mq hctx is active */
 #define QUEUE_FLAG_NOWAIT       29	/* device supports NOWAIT */
+#define QUEUE_FLAG_LIMIT_BIO_SIZE 30	/* limit bio size */
 
 #define QUEUE_FLAG_MQ_DEFAULT	((1 << QUEUE_FLAG_IO_STAT) |		\
 				 (1 << QUEUE_FLAG_SAME_COMP) |		\
@@ -667,6 +668,8 @@ bool blk_queue_flag_test_and_set(unsigned int flag, struct request_queue *q);
 #define blk_queue_fua(q)	test_bit(QUEUE_FLAG_FUA, &(q)->queue_flags)
 #define blk_queue_registered(q)	test_bit(QUEUE_FLAG_REGISTERED, &(q)->queue_flags)
 #define blk_queue_nowait(q)	test_bit(QUEUE_FLAG_NOWAIT, &(q)->queue_flags)
+#define blk_queue_limit_bio_size(q)	\
+	test_bit(QUEUE_FLAG_LIMIT_BIO_SIZE, &(q)->queue_flags)
 
 extern void blk_set_pm_only(struct request_queue *q);
 extern void blk_clear_pm_only(struct request_queue *q);
-- 
2.28.0

