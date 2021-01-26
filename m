Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3E83C433E0
	for <linux-block@archiver.kernel.org>; Tue, 26 Jan 2021 14:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7979823101
	for <linux-block@archiver.kernel.org>; Tue, 26 Jan 2021 14:52:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391433AbhAZOwm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Jan 2021 09:52:42 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:29769 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391181AbhAZJh4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Jan 2021 04:37:56 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20210126093709epoutp01b00199676fe4815a20341cae7e7cece2~dvp6K1H082820528205epoutp01s
        for <linux-block@vger.kernel.org>; Tue, 26 Jan 2021 09:37:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20210126093709epoutp01b00199676fe4815a20341cae7e7cece2~dvp6K1H082820528205epoutp01s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1611653829;
        bh=6KJ5IrzEH2Lxqjn/7m4vNbGpTi5F2GTuLYWAuPNTtXk=;
        h=From:To:Cc:Subject:Date:References:From;
        b=UpP75/aTjqTkg/3nI/yJxb1+bOrlvA9aVe84cL6V9+5Cw4IXUE3V2DP0PmP54Msp/
         mPkWIuBSoCJ9ph+9noz31gAlZJjUkNmoYnZHy9fFxu4kG9LBuqP8JKsCypoKpxvk0a
         XNVGcbuUo9m+PjvYFsyyaBAPJZ4+vFNCepz53XU8=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20210126093708epcas1p2ef8c76fba4bbc05b1cff41e842f73068~dvp5M7zyT1425114251epcas1p2X;
        Tue, 26 Jan 2021 09:37:08 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.166]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4DQ1pq3CMkz4x9Pw; Tue, 26 Jan
        2021 09:37:07 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        AF.AA.10463.3C2EF006; Tue, 26 Jan 2021 18:37:07 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20210126093706epcas1p150e9b57a678f8724fa8ab9eddcec8a42~dvp3FoRL93218732187epcas1p1d;
        Tue, 26 Jan 2021 09:37:06 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210126093706epsmtrp25140fe84c0cd9c74f2229b3cfe439a2d~dvp3EU4fk3088930889epsmtrp2M;
        Tue, 26 Jan 2021 09:37:06 +0000 (GMT)
X-AuditID: b6c32a38-efbff700000028df-9c-600fe2c3d639
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        99.D2.08745.2C2EF006; Tue, 26 Jan 2021 18:37:06 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.99.105]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210126093706epsmtip2dd69f25523dc8dfb37b2ff61d9b51eea~dvp2z_M_k2925929259epsmtip2T;
        Tue, 26 Jan 2021 09:37:06 +0000 (GMT)
From:   Changheun Lee <nanich.lee@samsung.com>
To:     Johannes.Thumshirn@wdc.com, asml.silence@gmail.com,
        axboe@kernel.dk, damien.lemoal@wdc.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ming.lei@redhat.com, osandov@fb.com, patchwork-bot@kernel.org,
        tj@kernel.org, tom.leiming@gmail.com
Cc:     jisoo2146.oh@samsung.com, junho89.kim@samsung.com,
        mj0123.lee@samsung.com, seunghwan.hyun@samsung.com,
        sookwan7.kim@samsung.com, woosung2.lee@samsung.com,
        yt0928.kim@samsung.com, Changheun Lee <nanich.lee@samsung.com>
Subject: [PATCH v3 1/2] bio: limit bio max size
Date:   Tue, 26 Jan 2021 18:21:29 +0900
Message-Id: <20210126092129.6676-1-nanich.lee@samsung.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFJsWRmVeSWpSXmKPExsWy7bCmvu7hR/wJBlt7xS3mrNrGaLH6bj+b
        RWv7NyaLnidNrBZ/u+4xWXx9WGyx95a2xeVdc9gsDk1uZrKYvnkOs8W1+2fYLQ7fu8pi8XDJ
        RGaLcyc/sVrMe+xg8Wv5UUaL9z+us1uc2jGZ2WL93p9sDsIeE5vfsXvsnHWX3ePy2VKPTas6
        2Tze77vK5tG3ZRWjx+dNch7tB7qZAjiicmwyUhNTUosUUvOS81My89JtlbyD453jTc0MDHUN
        LS3MlRTyEnNTbZVcfAJ03TJzgL5RUihLzCkFCgUkFhcr6dvZFOWXlqQqZOQXl9gqpRak5BQY
        GhToFSfmFpfmpesl5+daGRoYGJkCVSbkZDzb+56x4LpWxdXjixgbGOfJdTFyckgImEgc2DuH
        sYuRi0NIYAejxL/j+9kgnE+MEifePWMHqRIS+MwocbJFHaZj1YFL7BBFu4A6lt9lgyvqnQw2
        lk1AR6Lv7S2wSSICLUwSbe+vMYM4zAKPGSWunGwD6xAW0Jfom7+OBcRmEVCV6LlzjxXE5hWw
        kni0o48NYp28xNPe5cwQcUGJkzOfgNUzA8Wbt84GGyohsIdD4s/dFUwQDS4Su7/2MUPYwhKv
        jm9hh7ClJD6/28sG0dDNKNHcNp8RwpnAKLHk+TKobmOJT58/AyU4gFZoSqzfpQ8RVpTY+Xsu
        I8RmPol3X3tYQUokBHglOtqEIEpUJM603GeG2fV87U6oiR4SJ5teM0OCKFbi2LO7zBMY5Wch
        +WcWkn9mISxewMi8ilEstaA4Nz212LDABDleNzGCE7WWxQ7GuW8/6B1iZOJgPMQowcGsJMK7
        W48nQYg3JbGyKrUoP76oNCe1+BCjKTCEJzJLiSbnA3NFXkm8oamRsbGxhYmZuZmpsZI4b5LB
        g3ghgfTEktTs1NSC1CKYPiYOTqkGpoQWl5dmZ3Q/7PEy2nZykubW8JDzvpW9pbMOcqV72Kno
        3xW6YH1HsPZG7Ec/DeW6G9bbbmUtjjW1r4jOEV3TlRu8M+LdUX2OF4o7wx/vPyj2c+P5K79W
        PguJW3VF6dXpxxUsB5/eThf4d4+34MVZBs+cQibnwx9b1VR26N+7bbjEp01cWedO/tKHwXsa
        1036Otng4wz/rqzfWdN3XN9T15/O9nrP85CNjcVH5baz3Gp9xxPvcvc23+Nwqe0+EuwqFQW7
        3vOumMo+IXiNxc6nFjsf8UeenHZZIvejgE+oe1Pb/OrJNuwW17P3fWBZVnh3o4n1gbt8Lqt8
        trkxGoZH6p7YPue51LTSDc9cVJSLjymxFGckGmoxFxUnAgATZ1WnXQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOLMWRmVeSWpSXmKPExsWy7bCSvO6hR/wJBvveilrMWbWN0WL13X42
        i9b2b0wWPU+aWC3+dt1jsvj6sNhi7y1ti8u75rBZHJrczGQxffMcZotr98+wWxy+d5XF4uGS
        icwW505+YrWY99jB4tfyo4wW739cZ7c4tWMys8X6vT/ZHIQ9Jja/Y/fYOesuu8fls6Uem1Z1
        snm833eVzaNvyypGj8+b5DzaD3QzBXBEcdmkpOZklqUW6dslcGU82/ueseC6VsXV44sYGxjn
        yXUxcnJICJhIrDpwib2LkYtDSGAHo8T6jf9YIRJSEsdPvAWyOYBsYYnDh4shaj4ySqxaux+s
        hk1AR6Lv7S02kISIwCQmib0HdzODOMwCrxkluh4vYgGpEhbQl+ibvw7MZhFQlei5cw+sm1fA
        SuLRjj42iG3yEk97lzNDxAUlTs58AlbPDBRv3jqbeQIj3ywkqVlIUgsYmVYxSqYWFOem5xYb
        FhjlpZbrFSfmFpfmpesl5+duYgTHjZbWDsY9qz7oHWJk4mA8xCjBwawkwrtbjydBiDclsbIq
        tSg/vqg0J7X4EKM0B4uSOO+FrpPxQgLpiSWp2ampBalFMFkmDk6pBqY1F37EbW5e2vh6xi2u
        6Dttkh6pK34JfmquD5R583zZ/ncKzXPajfZcZi1d3vgsMfx219K/nUk7Favehp2REj9wxdbi
        pP37HrucXnPm1DPbDn27LCB8be7M/qetmlt2RD89clK+OOyT5YzTEypOaM269SZdL9Yy7FHa
        25XmxTUmH1jPtj7Zz8xaLGITcEbajKWu8cfKm8wNtz+8/fju27s3D2b2KF+92FIpkfGhq+zA
        Tg2fpBfXN0++IjJnZ6evQ8PlZykuM8+9sTR64TXl2roKdj6GhaIuPKcmTegzrn779PDM5xP4
        O41zrE4tcE/geX9FctuhC+tfOzccW6yy0GH/Dd1CQ5cNRy6+9p944u3GE0osxRmJhlrMRcWJ
        AH43gCUKAwAA
X-CMS-MailID: 20210126093706epcas1p150e9b57a678f8724fa8ab9eddcec8a42
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210126093706epcas1p150e9b57a678f8724fa8ab9eddcec8a42
References: <CGME20210126093706epcas1p150e9b57a678f8724fa8ab9eddcec8a42@epcas1p1.samsung.com>
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
kernel behavior is below now. it's timeline.

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
 block/bio.c            | 17 ++++++++++++++++-
 include/linux/bio.h    |  4 +++-
 include/linux/blkdev.h |  3 +++
 3 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 1f2cc1fbe283..ec0281889045 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -287,6 +287,21 @@ void bio_init(struct bio *bio, struct bio_vec *table,
 }
 EXPORT_SYMBOL(bio_init);
 
+unsigned int bio_max_size(struct bio *bio)
+{
+	struct request_queue *q;
+
+	if (!bio->bi_disk)
+		return UINT_MAX;
+
+	q = bio->bi_disk->queue;
+	if (!blk_queue_limit_bio_size(q))
+		return UINT_MAX;
+
+	return blk_queue_get_max_sectors(q, bio_op(bio)) << SECTOR_SHIFT;
+}
+EXPORT_SYMBOL(bio_max_size);
+
 /**
  * bio_reset - reinitialize a bio
  * @bio:	bio to reset
@@ -877,7 +892,7 @@ bool __bio_try_merge_page(struct bio *bio, struct page *page,
 		struct bio_vec *bv = &bio->bi_io_vec[bio->bi_vcnt - 1];
 
 		if (page_is_mergeable(bv, page, len, off, same_page)) {
-			if (bio->bi_iter.bi_size > UINT_MAX - len) {
+			if (bio->bi_iter.bi_size > bio_max_size(bio) - len) {
 				*same_page = false;
 				return false;
 			}
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 1edda614f7ce..cdb134ca7bf5 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -100,6 +100,8 @@ static inline void *bio_data(struct bio *bio)
 	return NULL;
 }
 
+extern unsigned int bio_max_size(struct bio *);
+
 /**
  * bio_full - check if the bio is full
  * @bio:	bio to check
@@ -113,7 +115,7 @@ static inline bool bio_full(struct bio *bio, unsigned len)
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

