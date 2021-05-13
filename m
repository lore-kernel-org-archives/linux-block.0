Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E95AC433ED
	for <linux-block@archiver.kernel.org>; Thu, 13 May 2021 10:20:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 027D861406
	for <linux-block@archiver.kernel.org>; Thu, 13 May 2021 10:20:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232331AbhEMKVg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 May 2021 06:21:36 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:46277 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232301AbhEMKVe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 May 2021 06:21:34 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20210513102022epoutp018d9be0675e65cd9db387ea17e4bc9c62~_mRL6Ci8N2897728977epoutp01y
        for <linux-block@vger.kernel.org>; Thu, 13 May 2021 10:20:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20210513102022epoutp018d9be0675e65cd9db387ea17e4bc9c62~_mRL6Ci8N2897728977epoutp01y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1620901222;
        bh=o/iTOjcvWFtRcWyAK0quFiplEhSDj5WlImovyyoXDOY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BI0QpoMkTziBPg9YKxf4345iNN/1lnt7CwM8shBO8jaw9JKIROvomG6IEGZufv/P6
         CqluGtJRGxdtaOu54NqP7ICEUxPHTlp5KgffqCrwT/9lyt528lNhjwS9NKP6OWIl4r
         QI3tU9p+Z0GDW7YPwc3EfeX4Jw47KkqZtV6lIa/4=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20210513102021epcas1p2bed00b76864ba276d5c2778ade100872~_mRLGA6dJ2795127951epcas1p2Y;
        Thu, 13 May 2021 10:20:21 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.164]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4FgnjJ3yPxz4x9Q0; Thu, 13 May
        2021 10:20:20 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        8B.D4.10258.46DFC906; Thu, 13 May 2021 19:20:20 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20210513102019epcas1p35d6740527dacd9bff7d8b07316e4cbfd~_mRJTZPy92497924979epcas1p3Q;
        Thu, 13 May 2021 10:20:19 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210513102019epsmtrp27062fdf1c0abaf312459af0c64deff85~_mRJSPIQU3217532175epsmtrp27;
        Thu, 13 May 2021 10:20:19 +0000 (GMT)
X-AuditID: b6c32a38-419ff70000002812-a0-609cfd64ccc8
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        4A.B4.08163.36DFC906; Thu, 13 May 2021 19:20:19 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.99.105]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210513102019epsmtip2e346f88670e80d45d30419eff3b356b7~_mRJBYrKH0239002390epsmtip2V;
        Thu, 13 May 2021 10:20:19 +0000 (GMT)
From:   Changheun Lee <nanich.lee@samsung.com>
To:     alex_y_xu@yahoo.ca, yi.zhang@redhat.com, jaegeuk@kernel.org,
        bgoncalv@redhat.com, Johannes.Thumshirn@wdc.com,
        asml.silence@gmail.com, axboe@kernel.dk, bvanassche@acm.org,
        damien.lemoal@wdc.com, gregkh@linuxfoundation.org,
        hch@infradead.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, ming.lei@redhat.com, osandov@fb.com,
        patchwork-bot@kernel.org, tj@kernel.org, tom.leiming@gmail.com
Cc:     jisoo2146.oh@samsung.com, junho89.kim@samsung.com,
        mj0123.lee@samsung.com, seunghwan.hyun@samsung.com,
        sookwan7.kim@samsung.com, woosung2.lee@samsung.com,
        yt0928.kim@samsung.com, Changheun Lee <nanich.lee@samsung.com>
Subject: [PATCH v10 1/1] bio: limit bio max size
Date:   Thu, 13 May 2021 19:02:05 +0900
Message-Id: <20210513100205.17965-2-nanich.lee@samsung.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210513100205.17965-1-nanich.lee@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Tf0xTVxjNfa99LcTCGzC5IRPqm0sGUmj55cXBxtDJ22QZhqlTE2kHb4Ws
        tF1LmTKTMepgAyYQN8ACisCA8TOpiBQHmgJxncpEBAMTGYPJXCwwGjY7+bGWpxv/nfN957sn
        37n5+LhHPs+Hn6bMYDRKmYIiXDmdff4iUcpKpVRsyPNGbfdaeKiyqROg5okiAnUPnQOodMGO
        o8/z/sKQvradQNeLazA0027AUeFMDhet5N/H0NKUFvWMb0fD3ZUEMp/WY6jsQiWORidv8FDf
        /REOmqorwdGgZZGLzk7HoH8aBgCaf3yXh37sOo2ju4OlBGrvsRMxPvTwnb10iX6OR5sMEzz6
        QmMAPXxTRxubviToK1UtPHq+d4SgT3U0Adpm9KXzrhZgtNlcjydsOqyISmVkKYxGyCiTVSlp
        Snk0tTcxaVdSeIRYIpJEoh2UUClLZ6Kp3fEJoj1pCkcElDBTptA5SgkyrZYKfjVKo9JlMMJU
        lTYjmmLUKQq1RKwO0srStTqlPChZlb5TIhaHhDuUUkVq/dA3mLo58thK3s/cbFAdkA/4fEiG
        wdF2aT5w5XuQXQCWDj/BWLIIYHnNRS5LbADOjt3m5APe+oRJkQ9cHOVuAK02t/8kjZY1nrNB
        kIHwlHWccDa8yCocnm95AJwEJ6cBvGPJJZwqT1IMe+91YE7MIV+CAwuj61hAvgLPGis4TgxJ
        P7g8WYg7sQsZBWus/RxW8xy0nJlZx7hDo79YgTsNINngApeKzuDs8G6YY6zgsdgT/nGt4yn2
        gba5HoIdKABQn3sOsKQYwLrZeoxVhcJFmw04U8JJf9jeHcyWt0LTkyrAOrvBuaVCLhukAH6R
        68FKtsEbJyfxZ16zraanL9Lwh2tfc9i8igD8viAXLwZCw4aFDBsWMvzvXA3wJrCZUWvT5YxW
        og7b+MVGsH4UAagLVFkXgswA4wMzgHyc8hJsfr9C6iFIkR3PYjSqJI1OwWjNINwRdwnu83yy
        ynFVyowkSXhIaGgoCovYEREeSnkL5Ls+kXqQclkG8yHDqBnNszmM7+KTjfkf6esaM77ZutV1
        0BdzdU/7LUwla0vqLF2oe7Gxy9RaF92wcD1x/s9LEWtl/YeutO2vr/5J/t2JW40f8Pd9PF/X
        sjYq+jWwc7nfWv5oOqjBztUYIl1xatUv88HAdh2ddfyddz8yxcbELx75Jau51v1YoDX7MUd0
        8DNziW/65dlGr96I29xlyf4taX1fKf0Kx6fsBy2v8T3j57DAEcBVBtfe+jTmQOwLeauCSnN5
        sa/hpOotmnq9sLj17diQ1MF+3H1q+KjtkH6L5eVE0Uz92NUVqX2fLW7be+OHT1w+uqqeyCEe
        Em1k5iX7TrffD3QPCR/t0Vu/LYorI+Ju/r2p/OEb570ZiqNNlUkCcI1W9i8nnXb9nQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEIsWRmVeSWpSXmKPExsWy7bCSvG7y3zkJBr8/6Visu7OG3WLOqm2M
        Fqvv9rNZ7Lo4n9Fi2oefzBat7d+YLJoXr2ezOD1hEZPFk/WzmC16njSxWvztusdk8fVhscXe
        W9oWl3fNYbM4NLmZyWL65jnMFtfun2G3OHzvKovFwyUTmS3OnfzEajHvsYPFr+VHGS3e/7jO
        bnFqx2Rmi+vnprFZrN/7k81ByuPyFW+Pic3v2D12zrrL7rF5hZbH5bOlHptWdbJ57J+7ht3j
        /b6rbB59W1YxenzeJOfRfqCbyePQoWXMATxRXDYpqTmZZalF+nYJXBnLLk5lKlhtWfG3/TZr
        A+MCrS5Gdg4JAROJnTldjFwcQgI7GCUev17H2MXICRSWkjh+4i1rFyMHkC0scfhwMUTNR0aJ
        p49msIPUsAnoSPS9vcUGkhAR2Mos8WXRFEYQh1ngNaNE1+NFLCBVwgIGEvvubGECsVkEVCWO
        frgGZvMKWEvM2zSbBWKbvMSf+z3MIDangI3EordHwOJCQDVzX+xkgagXlDg58wmYzQxU37x1
        NvMERoFZSFKzkKQWMDKtYpRMLSjOTc8tNiwwykst1ytOzC0uzUvXS87P3cQIjmYtrR2Me1Z9
        0DvEyMTBeIhRgoNZSYRXLGl2ghBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHeC10n44UE0hNLUrNT
        UwtSi2CyTBycUg1MkRqzpp0K6ZXRzX7W8zase9qOz26iOVVCDKLLN/qo7po7Zd2SVUYy2xJv
        rzJbHmZ8VWCOAP/Fds47CUwqX28+uatz1amgseWo7JSfsm//9/7jco7PM42W+m8kn/ao5Mvn
        dCOnA49b9qdoHA4Ov67yJ7y8Yf2fmBsMNxUKtx5Lutzw59XXpeJ9Rooamq37bulosK4M47Le
        bRCs++9edAvfsay2T8de1cTcnuI94VzN1j8regUW8Tw/L+K/n1VV/Zny5or1ShmaITEqlrss
        DIoND/wOcJp7xZU3VefCSsvL59YflM/Z2/TkNFvQ4owCnYfcLkvvlDFwZIoXRxUtSW5oyN29
        YcVd/ViG2O9FPTxKLMUZiYZazEXFiQCJk0iKVQMAAA==
X-CMS-MailID: 20210513102019epcas1p35d6740527dacd9bff7d8b07316e4cbfd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210513102019epcas1p35d6740527dacd9bff7d8b07316e4cbfd
References: <20210513100205.17965-1-nanich.lee@samsung.com>
        <CGME20210513102019epcas1p35d6740527dacd9bff7d8b07316e4cbfd@epcas1p3.samsung.com>
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
 block/bio.c            | 17 ++++++++++++++---
 block/blk-settings.c   |  7 +++++++
 include/linux/bio.h    |  4 +++-
 include/linux/blkdev.h |  2 ++
 4 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 44205dfb6b60..a79be441990a 100644
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
index 902c40d67120..6c67244d899e 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -32,6 +32,7 @@ EXPORT_SYMBOL_GPL(blk_queue_rq_timeout);
  */
 void blk_set_default_limits(struct queue_limits *lim)
 {
+	lim->bio_max_bytes = UINT_MAX;
 	lim->max_segments = BLK_MAX_SEGMENTS;
 	lim->max_discard_segments = 1;
 	lim->max_integrity_segments = 0;
@@ -140,6 +141,12 @@ void blk_queue_max_hw_sectors(struct request_queue *q, unsigned int max_hw_secto
 				 limits->logical_block_size >> SECTOR_SHIFT);
 	limits->max_sectors = max_sectors;
 
+	if (check_shl_overflow(max_sectors, SECTOR_SHIFT,
+				&limits->bio_max_bytes))
+		limits->bio_max_bytes = UINT_MAX;
+	limits->bio_max_bytes = max_t(unsigned int, limits->bio_max_bytes,
+				      BIO_MAX_VECS * PAGE_SIZE);
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
index 1255823b2bc0..9fb255b48a57 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -326,6 +326,8 @@ enum blk_bounce {
 };
 
 struct queue_limits {
+	unsigned int		bio_max_bytes;
+
 	enum blk_bounce		bounce;
 	unsigned long		seg_boundary_mask;
 	unsigned long		virt_boundary_mask;
-- 
2.29.0

