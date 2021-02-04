Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BB37C433E0
	for <linux-block@archiver.kernel.org>; Thu,  4 Feb 2021 01:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F62364F41
	for <linux-block@archiver.kernel.org>; Thu,  4 Feb 2021 01:18:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233750AbhBDBS1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Feb 2021 20:18:27 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:47216 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233391AbhBDBS0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 Feb 2021 20:18:26 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210204011743epoutp035ab28f0f4f3a25dbabdbaa0bbe62b1f0~gZpakd4FD2137821378epoutp03S
        for <linux-block@vger.kernel.org>; Thu,  4 Feb 2021 01:17:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210204011743epoutp035ab28f0f4f3a25dbabdbaa0bbe62b1f0~gZpakd4FD2137821378epoutp03S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1612401463;
        bh=ok7IJjIXz6xGgJxQYwq++bBOaNrRRQtln/5yQX/Ab8E=;
        h=From:To:Cc:Subject:Date:References:From;
        b=NDxVyQkskiIXpsZdN5eHiieRm6hHvG17IdUkmaiOilFtPsd7eVwN7wpwIHALoGGe3
         Nd4i8VYHeJ0LyjvbP3eggRGXL85gPceLOcC9WTKUVObX9ljr/zaBj0QDAQlGp/ZxWm
         Efa5RbEHvteKgu90yD0d43Jjp1dpqE/bwpMSnQaI=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20210204011742epcas1p3073e2d76ccc10d36b4943328f8d4681d~gZpZrHRc51044210442epcas1p3Z;
        Thu,  4 Feb 2021 01:17:42 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.162]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4DWLJP2Dlmz4x9Ps; Thu,  4 Feb
        2021 01:17:41 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        C9.02.02418.53B4B106; Thu,  4 Feb 2021 10:17:41 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20210204011740epcas1p35481e568b664de42d7c5d4579f80787e~gZpXmdPYu1025810258epcas1p3M;
        Thu,  4 Feb 2021 01:17:40 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210204011740epsmtrp1b884dc5b23824ebb690752ffd589e966~gZpXiHFhs2863728637epsmtrp1E;
        Thu,  4 Feb 2021 01:17:40 +0000 (GMT)
X-AuditID: b6c32a35-c0dff70000010972-04-601b4b35a4bd
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        56.A0.13470.43B4B106; Thu,  4 Feb 2021 10:17:40 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.99.105]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210204011740epsmtip11122738e0e35d4b978fad8040b05d5db~gZpXSv5kr0345303453epsmtip1L;
        Thu,  4 Feb 2021 01:17:40 +0000 (GMT)
From:   Changheun Lee <nanich.lee@samsung.com>
To:     ming.lei@redhat.com, Johannes.Thumshirn@wdc.com,
        asml.silence@gmail.com, axboe@kernel.dk, damien.lemoal@wdc.com,
        hch@infradead.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, osandov@fb.com,
        patchwork-bot@kernel.org, tj@kernel.org, tom.leiming@gmail.com,
        gregkh@linuxfoundation.org
Cc:     jisoo2146.oh@samsung.com, junho89.kim@samsung.com,
        mj0123.lee@samsung.com, seunghwan.hyun@samsung.com,
        sookwan7.kim@samsung.com, woosung2.lee@samsung.com,
        yt0928.kim@samsung.com, Changheun Lee <nanich.lee@samsung.com>
Subject: [PATCH v5 1/2] bio: limit bio max size
Date:   Thu,  4 Feb 2021 10:01:55 +0900
Message-Id: <20210204010156.5105-1-nanich.lee@samsung.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01TbUxTVxjOube9rWyFS0V2gmxC4xbBAf2gcGaE6CTkZkDCsixOiCkXuCmM
        0ja91Gwkc4RqGd8gy5x8bOoUmuJGVoQACYgtjCAUEkFxgHRMFh3yFQgEJYy1u5Dx73me93nf
        57zn3CvExS4iQJitzWMMWlojIbx47Y4QaZgy4XCadGrZG9Vb2wFqflpJoMtFGxgy/dRCoKGq
        mxgqmyvko+2SGQytz7Koe/I4GuuqJ5C9xoShq631OHrsGhYgx8wjHpq9VY2jkcFVPvrh2Sn0
        uqkfoOXNCQF60FGDo5buV8SpQ1S1aUlAddY+FVCtllBqzGmkbNZigrrXcEdALfc8IqiKu1ZA
        rdneoYp6S7FkrxTNySyGzmQMQYw2Q5eZrVXHSBI+UZ1RKaOksjDZByhaEqSlc5kYSVxiclh8
        tsa9oCToAq0xuqVkmmUlEbEnDTpjHhOUpWPzYiSMPlOjl0n14Sydyxq16vAMXe4JmVQqV7qd
        aZqsf1bb+HrHsS/Mri1eARgMLAEHhJCMhKbSl4IS4CUUkx0ALjotgCOrAJZ3LOySDQBvz3aB
        vZaJxj8xrtAN4MqvZbtkDcDSgSrc4yLI92HF4iThKfiRbRi8MV3J9xCcfAbg+KCZ8LgOkhHQ
        YS3GPJhHvguH2+d4HiwiT8A7dZsCLu8I/Ku8Ced0Xzh4jfPgbt3UVod7hkJyXAhvvLbuHjAO
        PriyTnD4IJwfuLs7KAD+XWkWcA2lAJrMPwKOVAF463kjxrkUcHVtzV0QuiNCYEtXBCcHw86t
        BsAle8Ol9TK+xwJJEfzGLOYsR+HwJRe+l/X8587diRQcHVvje7CYPA+fmMrxKnCkdt8+tfv2
        qf0/+DrArcCf0bO5aoaV6WX7X9YG/vvSQ5UdoHpxJdwOMCGwAyjEJX4i2hyQJhZl0l/mMwad
        ymDUMKwdKN03XI0HHMrQuX8VbZ5KppQrFAoUGRUdpVRI3hKlS/9QiUk1ncfkMIyeMez1YcID
        AQWYcfyjb78S9cT4pF3/RbARuzDwovHyaeeLOb7vh7zte2/bV8sujKh+i7N4hexUU+ten/kd
        225OlPY+yf5uomhqerqX2in4uKH8+FViJevz+7aU7rowNS/WunNxymlLKh6AvvFvfh/ZXzN1
        X7aYdHasaU5/tOtxz9eB8SMNsfP5eEJHfg+THyif8RkN70s5X9v98nZQsD8ROST3a4iZdyQ9
        NH3qlEtHmeiLVxILr7GYvz48/w31UvrCdHnZaGq/bTy19b1z3i6H5uzWq5xgbWBLakKhz2b6
        zGKBadmS05yYmXMpfYgoPPfQ7uyrSKBcgVVO++kzv9PIYrxprpwcLD3cJ+GxWbQsFDew9L/f
        NUQpcgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkkeLIzCtJLcpLzFFi42LZdlhJTtfEWzrBYPdWSYs5q7YxWqy+289m
        0dr+jcmiefF6NovTExYxWfQ8aWK1+Nt1j8ni68Nii723tC0u75rDZnFocjOTxfTNc5gtrt0/
        w25x+N5VFouHSyYyW5w7+YnVYt5jB4tfy48yWrz/cZ3d4tSOycwW6/f+ZHMQ9ZjY/I7dY+es
        u+wem1doeVw+W+qxaVUnm8f+uWvYPd7vu8rm0bdlFaPH501yHu0HupkCuKK4bFJSczLLUov0
        7RK4Mv592spacFijou3+b5YGxpMyXYycHBICJhLXlz1i6mLk4hAS2M0oMXndTlaIhJTE8RNv
        gWwOIFtY4vDhYoiaj4wS3y+tYAepYRPQkeh7e4sNxBYROMokcWddHkgRs8BrRomux4tYQBLC
        AvoSh1d1MoHYLAKqEme2PQGL8wpYSayZ/YMdYpm8xNPe5cwQcUGJkzMhapiB4s1bZzNPYOSb
        hSQ1C0lqASPTKkbJ1ILi3PTcYsMCw7zUcr3ixNzi0rx0veT83E2M4NjS0tzBuH3VB71DjEwc
        jIcYJTiYlUR4E9ukEoR4UxIrq1KL8uOLSnNSiw8xSnOwKInzXug6GS8kkJ5YkpqdmlqQWgST
        ZeLglGpgqmtysch5/WGazJPXPXbfPy6USr+5pWqJqMn9n7XvNr/bGCTs+9x15bL77D/+LLH9
        sm2VSerk42rmK7KnSn64YGo85/cMLZFnvybKC09erKCSGHr/UURtCLt05xymwkdq/GZGkzbk
        LHP9+vfphFePGlPKnTYsandMkWWZ1uVoc0l1fsVH9o87qxkmikU5bqm8M/vGRVN1u+Z4sbkL
        ZX9NeuR7p0CFpb+GbzNPppHKhrmR2heUNm0JmfUqxUng6Z6bdgctF66S6PGYVynHzdvRrs27
        6MdGH9mVb8qCtfz/hX5f2Trpxq2NHLGJv0xnTGXruV5kOOvRfcOndT9qCxIPrmII0DmRPddU
        t3LenCeickosxRmJhlrMRcWJACiPNakcAwAA
X-CMS-MailID: 20210204011740epcas1p35481e568b664de42d7c5d4579f80787e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210204011740epcas1p35481e568b664de42d7c5d4579f80787e
References: <CGME20210204011740epcas1p35481e568b664de42d7c5d4579f80787e@epcas1p3.samsung.com>
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

