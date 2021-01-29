Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD80AC433DB
	for <linux-block@archiver.kernel.org>; Fri, 29 Jan 2021 04:05:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DAE064DFD
	for <linux-block@archiver.kernel.org>; Fri, 29 Jan 2021 04:05:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbhA2EFf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Jan 2021 23:05:35 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:46599 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbhA2EFd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Jan 2021 23:05:33 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20210129040449epoutp04813e36d22b5dc223c29893185803cd4c~emDmS0rIG0749307493epoutp04J
        for <linux-block@vger.kernel.org>; Fri, 29 Jan 2021 04:04:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20210129040449epoutp04813e36d22b5dc223c29893185803cd4c~emDmS0rIG0749307493epoutp04J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1611893089;
        bh=DKdDmc2BwI95ik1uoUnV9yV1lcg8gJDJ3kpQd3Ye82E=;
        h=From:To:Cc:Subject:Date:References:From;
        b=INqLTBhuJ0UHOTLt3XndKzjJPONEIXCCMxxm8Llvp65XXP1IHFW3OxG67Z3YF32Bm
         hqlsUNUNIv56MQ8/t+4/upBhU2bnZEQ1x+xOp540KmFdggQOWah1FZgGZ5Mo8LdjoU
         xMmtp6GR3IL4GzC2g89qvA4zlDZq+BM4dACfSb/0=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20210129040449epcas1p2e76c725fcad1256e5a910e7d5e8fe242~emDltbf9l1278112781epcas1p2n;
        Fri, 29 Jan 2021 04:04:49 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.165]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4DRkHz5JF4z4x9Q7; Fri, 29 Jan
        2021 04:04:47 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        4E.50.09582.F5983106; Fri, 29 Jan 2021 13:04:47 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20210129040447epcas1p4531f0bf1ddebf0b469af87e85199cc43~emDj3MRa51322813228epcas1p4N;
        Fri, 29 Jan 2021 04:04:47 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210129040447epsmtrp26f65cb3842acfce27ab2c88faa8dd138~emDj2NOOn0874108741epsmtrp2Z;
        Fri, 29 Jan 2021 04:04:47 +0000 (GMT)
X-AuditID: b6c32a37-8afff7000000256e-ac-6013895fa677
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        1A.A8.13470.E5983106; Fri, 29 Jan 2021 13:04:46 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.99.105]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210129040446epsmtip290f8ecf54d30dfa0e34d7ed9a5b47543~emDjmFMm61343513435epsmtip2I;
        Fri, 29 Jan 2021 04:04:46 +0000 (GMT)
From:   Changheun Lee <nanich.lee@samsung.com>
To:     hch@infradead.org, Johannes.Thumshirn@wdc.com,
        asml.silence@gmail.com, axboe@kernel.dk, damien.lemoal@wdc.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ming.lei@redhat.com, osandov@fb.com, patchwork-bot@kernel.org,
        tj@kernel.org, tom.leiming@gmail.com
Cc:     jisoo2146.oh@samsung.com, junho89.kim@samsung.com,
        mj0123.lee@samsung.com, seunghwan.hyun@samsung.com,
        sookwan7.kim@samsung.com, woosung2.lee@samsung.com,
        yt0928.kim@samsung.com, Changheun Lee <nanich.lee@samsung.com>
Subject: [PATCH v4 1/2] bio: limit bio max size
Date:   Fri, 29 Jan 2021 12:49:08 +0900
Message-Id: <20210129034909.18785-1-nanich.lee@samsung.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Te0xbVRj33FtuC7F6V1COxDC8PMZQoF1XepRhZsaWq7JBID6HKV25Flxp
        a2/rK3Ni2RjtBoOBoMBAgfCaYwt7hEdgs2xOJmMYOtAtgAQGYQYwVJCHiG0vRP77ft/3e+Q7
        DwEu6if8BOlaI2PQKjUU4cW72rVdHK6weKeIe5uCUXnjVYDODZ0m0PETCxj6Ob8KQ6fGzR5o
        1TqMoflRFnXcfx71t5UTyFaYhaGSS+U4Ghjp4aOu4Xs8NFpTgKPe7jkPVDG2Gy3X3QRodnGQ
        j263FOLoQscSsduHLsia4dOtpUN8+lJ9GN1/x0Q3N1oIerbzHkHnXW4EtKPZnz5x/SSW4Pmu
        Zlcao0xlDAGMVqVLTdeqY6jXkxR7FLIosSRc8iKSUwFaZQYTQ8XGJYTvS9c416ICPlJqTM5W
        gpJlqciXdxl0JiMTkKZjjTEUo0/V6CVifQSrzGBNWnWESpfxkkQs3iFzMlM0abmrdkz/fegn
        jbnzeCa48qwVeAoguRP++90ysAIvgYhsAfDXgW4+B+YAXKxd4HFgAcBVax6xIWlfKV8fdAD4
        w2D9ut4B4PWz83wXiyBfgHnT9wnXwIcsweD80k23MU6OAWjvznZ7eZORcM32t1vBI4NhX9Gc
        h6sWktHwy1EHzuVthQ9z63CuvwV2fzPOc9W4s591pQx3mUKyRwCzc8acA4ETxEL7rW2c1hs+
        unWZz9V+0DHTQXD8kwBmZVcCDuQDWDNZi3EsKZxzOIDLCCe3wwttkVz7Odi6chZwwU/AmflT
        HlyWEOZkizhKEOw5NoJvZE2eb113pKF9rc/tKCLfg22Vh/LB1tJN25Ru2qb0/9xvAd4Inmb0
        bIaaYSV66eZ7bQbu1x0mbwHF039G2AAmADYABTjlI5wuF6WIhKnKTz9jDDqFwaRhWBuQOc+3
        APd7SqVzfg+tUSGR7ZBKpWhnlDxKJqV8hYfEvytEpFppZA4zjJ4xbOgwgadfJoaumY6UhM6p
        qn9jLTXHP16j41Oa4i2nc5IXAzPjfwqq7fRpTx87WjesqPpg3/KgBk3cWJ6UPhkpK/Ppjtqy
        rWviTG9QSNtCmejx9upX3txbYA95xhFaUFzB3tYnFffUVRZ9XX1j8GIgaFU/NluUmF28NPPa
        jPirvvfjE95KKfJT0ZT8ztu/RO0dfvDqFxP8NdmxgQfnE/nwYPDBlX+aUg83sP5TAb7vxAXl
        1nr58/+Q5FpCzwTt6Uy29o7J979h/hxVWR/Zo0OMB+wfXmxriO2bigNm6RFcKkiKPFrXYGbv
        /nhuccS8QqhWzMkjIxW+1/4av5uYXx8TnTeVMJT8sNBDGEjx2DSlJAw3sMr/ACm+i79mBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgkeLIzCtJLcpLzFFi42LZdlhJXjeuUzjBoHuulcWcVdsYLVbf7Wez
        aG3/xmRxesIiJoueJ02sFn+77jFZfH1YbLH3lrbF5V1z2CwOTW5mspi+eQ6zxbX7Z9gtDt+7
        ymLxcMlEZotzJz+xWsx77GDxa/lRRov3P66zW5zaMZnZYv3en2wOIh4Tm9+xe+ycdZfdY/MK
        LY/LZ0s9Nq3qZPN4v+8qm0ffllWMHp83yXm0H+hmCuCM4rJJSc3JLEst0rdL4Mro/XuFqWCN
        RsWq3q/MDYxbZboYOTkkBEwkdv+ew9LFyMUhJLCbUeLhuwvsEAkpieMn3rJ2MXIA2cIShw8X
        Q9R8ZJSYs/I7I0gNm4CORN/bW2wgCRGB5UwSB36vZgVxmAVeM0p0PV7EAlIlLKAv8f/Qd7Cp
        LAKqEhemfGIFsXkFrCUaH35mhtgmL/G0dzkzRFxQ4uTMJ2C9zEDx5q2zmScw8s1CkpqFJLWA
        kWkVo2RqQXFuem6xYYFhXmq5XnFibnFpXrpecn7uJkZwJGlp7mDcvuqD3iFGJg7GQ4wSHMxK
        Irxv5wglCPGmJFZWpRblxxeV5qQWH2KU5mBREue90HUyXkggPbEkNTs1tSC1CCbLxMEp1cCU
        +PKUV5b4onvWWZmpkvEJ97clpZzgm/pJQfzwZ7XEXXIP393r0S9YbhPkWqDBlv7y6tZTO/W9
        wrecumf5lOe7FuO0OXLHWG5JqLn7FK3M2L9p7aS17CGzd3OHzJRa+u/S1OZf18pMrYU3ht98
        nt+3xbLq4+KcWac+KD5Qr8s8pSzKXPsj/uR5/fsBMd12Gr+P33KwntB2f9qm0NMrcoqr9r3J
        N3/dIOkb1GS91+/0w8aisxrZD7MjVphUWeSsz55oe8amPfL87GtszX9LuR7JX+Ww2sdesvSO
        ybduqz75zIrkqc+je/fejlE9f082d/mcxJMhuvefvd7h9E37UUmc0cE2HeNT3/ezht92iJZX
        YinOSDTUYi4qTgQATNzi4hMDAAA=
X-CMS-MailID: 20210129040447epcas1p4531f0bf1ddebf0b469af87e85199cc43
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210129040447epcas1p4531f0bf1ddebf0b469af87e85199cc43
References: <CGME20210129040447epcas1p4531f0bf1ddebf0b469af87e85199cc43@epcas1p4.samsung.com>
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

