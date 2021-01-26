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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53825C433E0
	for <linux-block@archiver.kernel.org>; Tue, 26 Jan 2021 19:49:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11FEA22A84
	for <linux-block@archiver.kernel.org>; Tue, 26 Jan 2021 19:49:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727472AbhAZFdp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Jan 2021 00:33:45 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:26259 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728919AbhAZBtO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Jan 2021 20:49:14 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210126014808epoutp03fc84481d5b70fd5e128b3a9a00bc4c88~dpQZfkw512147021470epoutp03s
        for <linux-block@vger.kernel.org>; Tue, 26 Jan 2021 01:48:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210126014808epoutp03fc84481d5b70fd5e128b3a9a00bc4c88~dpQZfkw512147021470epoutp03s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1611625688;
        bh=6KJ5IrzEH2Lxqjn/7m4vNbGpTi5F2GTuLYWAuPNTtXk=;
        h=From:To:Cc:Subject:Date:References:From;
        b=Y23T0gJcUyQwe05dsCuMb6lyLeO6om4fWMv65zfeK8jOaajg256Rg05Qe6BvhEV4I
         6Cor4Qpg7ti84msSPYRpm9Ea9EA2W53RWPs1mldTWzI2j/zzXxDW0ekJ9HWe7qeHzZ
         fri49DMSE+KVAbd2+EfnRw38SNhT7bbAvheRyiO8=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20210126014807epcas1p4f4216e7a28022dd0f946a67617b861cf~dpQYzxSc_0541605416epcas1p4Q;
        Tue, 26 Jan 2021 01:48:07 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.165]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4DPqPf1zBJz4x9QL; Tue, 26 Jan
        2021 01:48:06 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        CF.6D.63458.6D47F006; Tue, 26 Jan 2021 10:48:06 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20210126014805epcas1p2c4fc40f01c9c89b0a94ff6cac5408347~dpQWzbXLJ3020030200epcas1p23;
        Tue, 26 Jan 2021 01:48:05 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210126014805epsmtrp2f536e392057eb0eac2c059f21086608e~dpQWyZWDZ0582805828epsmtrp2E;
        Tue, 26 Jan 2021 01:48:05 +0000 (GMT)
X-AuditID: b6c32a36-6dfff7000000f7e2-c9-600f74d6b11e
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        18.18.08745.5D47F006; Tue, 26 Jan 2021 10:48:05 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.99.105]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210126014805epsmtip1be5c30d0e22673c01c2ddb598edc1fb4~dpQWitjmK2087020870epsmtip1-;
        Tue, 26 Jan 2021 01:48:05 +0000 (GMT)
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
Date:   Tue, 26 Jan 2021 10:32:34 +0900
Message-Id: <20210126013235.28711-1-nanich.lee@samsung.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNJsWRmVeSWpSXmKPExsWy7bCmvu61Ev4Eg+VPuCzmrNrGaLH6bj+b
        RWv7NyaLnidNrBZ/u+4xWXx9WGyx95a2xeVdc9gsDk1uZrKYvnkOs8W1+2fYLQ7fu8pi8XDJ
        RGaLcyc/sVrMe+xg8Wv5UUaL9z+us1uc2jGZ2WL93p9sDsIeE5vfsXvsnHWX3ePy2VKPTas6
        2Tze77vK5tG3ZRWjx+dNch7tB7qZAjiicmwyUhNTUosUUvOS81My89JtlbyD453jTc0MDHUN
        LS3MlRTyEnNTbZVcfAJ03TJzgL5RUihLzCkFCgUkFhcr6dvZFOWXlqQqZOQXl9gqpRak5BQY
        GhToFSfmFpfmpesl5+daGRoYGJkCVSbkZDzb+56x4LpWxdXjixgbGOfJdTFyckgImEicWv2c
        sYuRi0NIYAejxPyv89kgnE+MErevfGGHcD4zShzefogNpuXCul1QLbsYJT4dXccIVzVl80xm
        kCo2AR2Jvre3wGaJCLQwSbS9v8YM4jALPGaUuHKyDWyWsIC+RN/8dSwgNouAqsT5qbuAijg4
        eAWsJT7+5IBYJy/xtHc52FBeAUGJkzOfgJUzA8Wbt84GmykhcIRD4sqiB8wQDS4Sh/b0s0LY
        whKvjm9hh7ClJD6/28sG0dDNKNHcNp8RwpnAKLHk+TImiCpjiU+fPzOCXMEsoCmxfpc+RFhR
        YufvuYwQm/kk3n3tYQUpkRDglehoE4IoUZE403KfGWbX87U7oSZ6SOze+Q6sVUggVuLKpT3M
        ExjlZyH5ZxaSf2YhLF7AyLyKUSy1oDg3PbXYsMAIOWI3MYJTtZbZDsZJbz/oHWJk4mA8xCjB
        wawkwrtbjydBiDclsbIqtSg/vqg0J7X4EKMpMIAnMkuJJucDs0VeSbyhqZGxsbGFiZm5mamx
        kjhvosGDeCGB9MSS1OzU1ILUIpg+Jg5OqQam6Hi/CSWK8uGfHZjmTf1+JPFp+fHAV/Hvv3w3
        UpOdvfBAcUd6rND/g1sd9r4+INZ+evrm2Lb75pXVHd27lumxNu965Ky98LDdLJt9P9jCfPR3
        /RDIqs7wffwsLWJ3JYO1qmSal2nT/sv7Fh3fsjhC+bvspLOLnq/5bZ7GYnWwcc3NG6FGmR92
        KZj5RXGyblk4rZmx/m5xoD5jO9NByVaZq+Lz3GY5TZu/b75Hlb/nLf2XvwP1RSTObxE3/blP
        dcHqr6yLLmq/vjU/2v2ozx+/t2uiZMpjtV4di25Q8vyr+rvW4sKCwnVtZ7ZUyN+5vvjShG7e
        NdoTd/1MvJ6V/CWSZW84R/VK8zC+iZOLqjbKKrEUZyQaajEXFScCAPLwZ+heBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGLMWRmVeSWpSXmKPExsWy7bCSnO7VEv4Eg1mvpS3mrNrGaLH6bj+b
        RWv7NyaLnidNrBZ/u+4xWXx9WGyx95a2xeVdc9gsDk1uZrKYvnkOs8W1+2fYLQ7fu8pi8XDJ
        RGaLcyc/sVrMe+xg8Wv5UUaL9z+us1uc2jGZ2WL93p9sDsIeE5vfsXvsnHWX3ePy2VKPTas6
        2Tze77vK5tG3ZRWjx+dNch7tB7qZAjiiuGxSUnMyy1KL9O0SuDKe7X3PWHBdq+Lq8UWMDYzz
        5LoYOTkkBEwkLqzbxdjFyMUhJLCDUeLc+ytMEAkpieMn3rJ2MXIA2cIShw8XQ9R8ZJT4//cz
        C0gNm4CORN/bW2wgCRGBSUwSew/uZgZxmAVeM0p0PV4EViUsoC/RN38dmM0ioCpxfuouZpCp
        vALWEh9/ckAsk5d42rucGcTmFRCUODnzCVg5M1C8eets5gmMfLOQpGYhSS1gZFrFKJlaUJyb
        nltsWGCUl1quV5yYW1yal66XnJ+7iREcNVpaOxj3rPqgd4iRiYPxEKMEB7OSCO9uPZ4EId6U
        xMqq1KL8+KLSnNTiQ4zSHCxK4rwXuk7GCwmkJ5akZqemFqQWwWSZODilGpgWF8448OXQ946z
        65iMv6+JqY6RCumMYtL9ymoZ5Nd6esWDqp9Hti86dp9Z7f3tr/LuC74fclRTi+gSr/+zbdNr
        u7I3q68frZjbP7Mh7yLvoch/TkvsXOVEZ00yT8rcd1HlRcvzW9+PH1iuyX5h9r5XXp2d/RNW
        B0oXTzww580K6eximcOp1jtWLDJer5rbkirVeP7W+TDlzq22Alf/t99fuP+s8GntM96fav/2
        3Vt1hv1eVP9PDoHwmXcez8/WiHuq//P5ZLVPMUb/Nkz6c+BsgOCEBeJXpst28ms1FKZ+lJ9p
        OXfdDaF37xf837231tE+46vT6qPP9VID337lNrWd9Klim9fhK6E2HW/eMvAqeymxFGckGmox
        FxUnAgBE2fEDCQMAAA==
X-CMS-MailID: 20210126014805epcas1p2c4fc40f01c9c89b0a94ff6cac5408347
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210126014805epcas1p2c4fc40f01c9c89b0a94ff6cac5408347
References: <CGME20210126014805epcas1p2c4fc40f01c9c89b0a94ff6cac5408347@epcas1p2.samsung.com>
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

