Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B707C433ED
	for <linux-block@archiver.kernel.org>; Mon,  3 May 2021 10:10:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51103611F0
	for <linux-block@archiver.kernel.org>; Mon,  3 May 2021 10:10:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233075AbhECKLG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 May 2021 06:11:06 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:52905 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232960AbhECKLF (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 May 2021 06:11:05 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20210503101011epoutp041bad5bbd66270e586730de46a66bb994~7hrbtcBh12071620716epoutp04I
        for <linux-block@vger.kernel.org>; Mon,  3 May 2021 10:10:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20210503101011epoutp041bad5bbd66270e586730de46a66bb994~7hrbtcBh12071620716epoutp04I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1620036611;
        bh=pBBghy3N6DYR/HgRt2kLF5zgx2DNa6AZfSr1aR6WWz8=;
        h=From:To:Cc:Subject:Date:References:From;
        b=oG/Q7Nbai1D0xxSlaXwfqwuHEObSnZOFhCM/g27Rfl0EtokuyZPv6bLom4WojGNym
         P01PeGZ9tUoD28cb1iGYgEmBMj3mn0W4fSNo9qHrOBA4WU6ePcU6t5T/eWqQxNPR0a
         Fac9CMmXQuNjRcJcvH6fC9oAnNiqjFg8r5pKMjgE=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20210503101010epcas1p3af02d492f5114b4cdae433862e824da5~7hra9OzYU3084730847epcas1p39;
        Mon,  3 May 2021 10:10:10 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.165]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4FYdy90mCwz4x9Pw; Mon,  3 May
        2021 10:10:09 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        68.C7.09824.00CCF806; Mon,  3 May 2021 19:10:08 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20210503101008epcas1p25d6b727dafcf9ff24db6aa41a3f611fa~7hrZOsJCu0409004090epcas1p2S;
        Mon,  3 May 2021 10:10:08 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210503101008epsmtrp2d99c813ec6678174d59233ae4cf813d5~7hrZN1DlZ2750727507epsmtrp2V;
        Mon,  3 May 2021 10:10:08 +0000 (GMT)
X-AuditID: b6c32a37-061ff70000002660-a3-608fcc004b2b
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E1.BB.08637.00CCF806; Mon,  3 May 2021 19:10:08 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.99.105]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210503101008epsmtip14d46bddcdccc60689925f5a914c30539~7hrZBZWvj2137021370epsmtip1k;
        Mon,  3 May 2021 10:10:08 +0000 (GMT)
From:   Changheun Lee <nanich.lee@samsung.com>
To:     axboe@kernel.dk, bvanassche@acm.org, yi.zhang@redhat.com,
        ming.lei@redhat.com, bgoncalv@redhat.com, hch@lst.de,
        jaegeuk@kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, patchwork-bot@kernel.org
Cc:     Changheun Lee <nanich.lee@samsung.com>
Subject: [PATCH v9] bio: limit bio max size
Date:   Mon,  3 May 2021 18:52:03 +0900
Message-Id: <20210503095203.29076-1-nanich.lee@samsung.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHJsWRmVeSWpSXmKPExsWy7bCmgS7Dmf4Eg56vVhar7/azWey6OJ/R
        YtqHn8wWK1cfZbJ4sn4Ws8XeW9oWl3fNYbM4NLmZyeLa/TPsFg+XTGS2uH5uGpsDt8flK94e
        l8+Wemxa1cnmsftmA5vH+31X2Tz6tqxi9Pi8SS6APSrHJiM1MSW1SCE1Lzk/JTMv3VbJOzje
        Od7UzMBQ19DSwlxJIS8xN9VWycUnQNctMwfoQiWFssScUqBQQGJxsZK+nU1RfmlJqkJGfnGJ
        rVJqQUpOgaFBgV5xYm5xaV66XnJ+rpWhgYGRKVBlQk7GobdHWAvWGVbs3f6BpYHxjHIXIyeH
        hICJxIyOHaxdjFwcQgI7GCWaFp5hgnA+MUrcv3MHKvONUWLRsh3sMC13Z35khkjsZZSYduIC
        I4TzmVHi+KKdjCBVbAI6En1vb7GBJEQEHjJKTN5+HSzBLKAlseX1M2YQW1hAW+LLjL9gY1kE
        VCXut00Hsjk4eAWsJa4+5IXYJi/x534PWDmvgKDEyZlPWCDGyEs0b50NdoWEwF92iZZz11kg
        Glwk5u2ZxgRhC0u8Or4F6mwpic/v9rJBNHQzSjS3zWeEcCYwSix5vgyqw1ji0+fPjCBXMAto
        SqzfpQ8RVpTY+Xsu1AN8Eu++9rCClEgI8Ep0tAlBlKhInGm5zwyz6/nanVATPSSazl0Au01I
        IFZi35r9zBMY5Wch+WcWkn9mISxewMi8ilEstaA4Nz212LDAGDleNzGCE6qW+Q7GaW8/6B1i
        ZOJgPMQowcGsJMJbsLY/QYg3JbGyKrUoP76oNCe1+BCjKTCAJzJLiSbnA1N6Xkm8oamRsbGx
        hYmZuZmpsZI4b7pzdYKQQHpiSWp2ampBahFMHxMHp1QD0wGprwJyfOs9ixbv5ReU/lDIYJrG
        XR3kuXTfNt1EZs43SnUK+WJGExdGvjN69z3I9fGBCzln+LdOWnImVjKMddeX178+Mljle3ZX
        aCu589fNSDqT7p61MebTPeOnb1tZc77yF3E1VGVWq54qsvDbqP3CP1tkZh3XccHSPfM4Wre/
        anqY56L85gTX80ubmk4EtUTz3VQ88uO2zPwlzs6Pw3Om36mbeZW52dt4qUF53aeA5BpN5xL3
        FyYHZzYs3SFeFvBMTYCzXXyXzNGMvG+OHjxdoV6O01+uYqyWTumcKmOqVXVyV9iDpBcqck6b
        r2zLe5ZoEzB7sjj3jfTgQEZdiSMaQj6TllpePvKlUEGJpTgj0VCLuag4EQDFeYzCMQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBLMWRmVeSWpSXmKPExsWy7bCSnC7Dmf4Eg8e7JS1W3+1ns9h1cT6j
        xbQPP5ktVq4+ymTxZP0sZou9t7QtLu+aw2ZxaHIzk8W1+2fYLR4umchscf3cNDYHbo/LV7w9
        Lp8t9di0qpPNY/fNBjaP9/uusnn0bVnF6PF5k1wAexSXTUpqTmZZapG+XQJXxqG3R1gL1hlW
        7N3+gaWB8YxyFyMnh4SAicTdmR+ZQWwhgd2MEifaHSDiUhLHT7xl7WLkALKFJQ4fLu5i5AIq
        +cgocXxWKztIDZuAjkTf21tsIAkRgbeMEk++3WUFSTALaElsef0MbKiwgLbElxl/wRpYBFQl
        7rdNZwcZyitgLXH1IS/ELnmJP/d7wMp5BQQlTs58wgIxRl6ieets5gmMfLOQpGYhSS1gZFrF
        KJlaUJybnltsWGCYl1quV5yYW1yal66XnJ+7iREc2FqaOxi3r/qgd4iRiYPxEKMEB7OSCG/B
        2v4EId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rwXuk7GCwmkJ5akZqemFqQWwWSZODilGphkLZNc
        dxV+2Hchs6aMPd7sotOJ695fJh2vYFkq+WBiL9duRSkX0Zwitaqs3SsXTP6muNfQpdx1dpTS
        jgVnLjxawT93t/6z8sfVepknqozUPxZO5530fWLB5Xetcr+9N2efr7Ro1NqteaBuQpOaqU34
        3Cgu3sUKPCt+JM0r/Fi3OPnEA+Xvi3Yxda83ftj79P06gYIoo8A7k7hLzJN46pP8ffNZ+k5n
        VgYrX6r8td0iM2tB4ooD5dkzb7+YuIlHxvhu78/Zl9Oqq3LXHJno9WthA+es+RNY1p3uErgq
        dihOUv8yV3mznye/quP37WZzawR1zZ9OXjD71SppIYEtsy6vyrbi8ZkZvVwyVEBj0wIlluKM
        REMt5qLiRADuowiG2wIAAA==
X-CMS-MailID: 20210503101008epcas1p25d6b727dafcf9ff24db6aa41a3f611fa
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210503101008epcas1p25d6b727dafcf9ff24db6aa41a3f611fa
References: <CGME20210503101008epcas1p25d6b727dafcf9ff24db6aa41a3f611fa@epcas1p2.samsung.com>
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
 block/bio.c            | 13 +++++++++++--
 block/blk-settings.c   |  5 +++++
 include/linux/bio.h    |  4 +++-
 include/linux/blkdev.h |  2 ++
 4 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 44205dfb6b60..221dc56ba22f 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -255,6 +255,13 @@ void bio_init(struct bio *bio, struct bio_vec *table,
 }
 EXPORT_SYMBOL(bio_init);
 
+unsigned int bio_max_size(struct bio *bio)
+{
+	struct block_device *bdev = bio->bi_bdev;
+
+	return bdev ? bdev->bd_disk->queue->limits.bio_max_bytes : UINT_MAX;
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
 
diff --git a/block/blk-settings.c b/block/blk-settings.c
index 9c009090c4b5..c646503e55d2 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -31,6 +31,7 @@ EXPORT_SYMBOL_GPL(blk_queue_rq_timeout);
  */
 void blk_set_default_limits(struct queue_limits *lim)
 {
+	lim->bio_max_bytes = UINT_MAX;
 	lim->max_segments = BLK_MAX_SEGMENTS;
 	lim->max_discard_segments = 1;
 	lim->max_integrity_segments = 0;
@@ -139,6 +140,10 @@ void blk_queue_max_hw_sectors(struct request_queue *q, unsigned int max_hw_secto
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
index b91ba6207365..40c7c4d87aa1 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -327,6 +327,8 @@ enum blk_bounce {
 };
 
 struct queue_limits {
+	unsigned int		bio_max_bytes;
+
 	enum blk_bounce		bounce;
 	unsigned long		seg_boundary_mask;
 	unsigned long		virt_boundary_mask;
-- 
2.29.0

