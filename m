Return-Path: <SRS0=pPwc=SA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43AF5C43381
	for <linux-block@archiver.kernel.org>; Fri, 29 Mar 2019 14:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12B382173C
	for <linux-block@archiver.kernel.org>; Fri, 29 Mar 2019 14:25:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Fed5aJcg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729212AbfC2OZB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 Mar 2019 10:25:01 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:57216 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729046AbfC2OZB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 Mar 2019 10:25:01 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2TENPkq017863;
        Fri, 29 Mar 2019 14:24:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=NURxUyFD4lB2MOp9stVN5wUgNSnnCHzTcE3XIZQbn4M=;
 b=Fed5aJcgZPEWwB52b/DZcXmFvwX909Juq0po9JEqULBxhCkF75XMFwc5cZGztUj5ZUHp
 tK8OeJGwKuuFd8X270OSgaY4WuRpfRD+29o6BFQ7pMIZLkrnVSPEsK2uLfgqQDTyuXJ/
 2jPfOVZDXquieCbbHQY9guqDYlR8MuGNlu3yYCrEOzmJPBJVnGehjssw3Z95s6UxZKZ3
 7KyROtQtju3iYIoRzqWSLIHDLkFiCAyLqHj89Fuk2h8CwmIntqPsM4rhUSnjnMAIU0hX
 TM22NRQHLLeqk0EigYLQvPNH6oTEGxtM7qqIAqsQBd1tdCUKjbQBtB+TjRlIXBTKFLtm bQ== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2re6djvs7b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Mar 2019 14:24:50 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x2TEOj42030167
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Mar 2019 14:24:45 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x2TEOiAu019449;
        Fri, 29 Mar 2019 14:24:44 GMT
Received: from localhost.localdomain (/180.165.90.201)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 29 Mar 2019 07:24:43 -0700
From:   Bob Liu <bob.liu@oracle.com>
To:     linux-block@vger.kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        martin.petersen@oracle.com, shirley.ma@oracle.com,
        allison.henderson@oracle.com, david@fromorbit.com,
        darrick.wong@oracle.com, hch@infradead.org, adilger@dilger.ca,
        axboe@kernel.dk, tytso@mit.edu, Bob Liu <bob.liu@oracle.com>
Subject: [PATCH v3 2/3] block: verify data when endio
Date:   Fri, 29 Mar 2019 22:23:45 +0800
Message-Id: <20190329142346.1677-3-bob.liu@oracle.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190329142346.1677-1-bob.liu@oracle.com>
References: <20190329142346.1677-1-bob.liu@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9210 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903290103
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Call verify callback same as bio integrity.
If verify fail, drivers like MD will try other mirrors until get a correct
one or return failure after all mirrors are tried.
The MD driver already works like this, so no extra changed.

Todo:
- union with "struct bio_integrity_payload *bi_integrity" to save bio space.

Signed-off-by: Bob Liu <bob.liu@oracle.com>
---
 block/bio-integrity.c     | 45 +++++++++++++++++++++++++++++++++++++++
 block/bio.c               |  3 +++
 block/blk-core.c          |  4 ++++
 block/blk.h               |  8 +++++++
 block/bounce.c            |  1 +
 drivers/md/raid1.c        |  1 +
 drivers/md/raid5-ppl.c    |  1 +
 include/linux/blk_types.h |  5 +++++
 8 files changed, 68 insertions(+)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index 1b633a3526d4..90a47ad31dbf 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -372,6 +372,51 @@ bool __bio_integrity_endio(struct bio *bio)
 	return true;
 }
 
+/**
+ * bio_verify_fn - Verify I/O completion worker
+ * @work:	Work struct stored in bio to be verified
+ *
+ * Description: This workqueue function is called to complete a READ
+ * request.  The function call verifier callack that fs pass down
+ * and then calls the original bio end_io function.
+ */
+static void bio_verify_fn(struct work_struct *work)
+{
+	struct bio *bio =
+		container_of(work, struct bio, bi_work);
+
+	bio->bi_status = bio->bi_verifier(bio);
+	/* Clear flag if verify succeed to avoid verifing
+	 * it unnecessary by parent bio
+	 */
+	if (!bio->bi_status)
+		bio->bi_opf &= ~REQ_VERIFY;
+	bio_endio(bio);
+}
+
+/**
+ * __bio_verify_endio - Verify I/O completion function
+ * @bio:	Protected bio
+ *
+ * Description: Completion for verify I/O
+ *
+ * Normally I/O completion is done in interrupt context.  However,
+ * verifying I/O is a time-consuming task which must be run
+ * in process context.	This function postpones completion
+ * accordingly.
+ */
+bool __bio_verify_endio(struct bio *bio)
+{
+	if (bio_op(bio) == REQ_OP_READ && !bio->bi_status &&
+	    (bio->bi_opf & REQ_VERIFY) && bio->bi_verifier) {
+		INIT_WORK(&bio->bi_work, bio_verify_fn);
+		queue_work(kintegrityd_wq, &bio->bi_work);
+		return false;
+	}
+
+	return true;
+}
+
 /**
  * bio_integrity_advance - Advance integrity vector
  * @bio:	bio whose integrity vector to update
diff --git a/block/bio.c b/block/bio.c
index 4db1008309ed..8928806acda6 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -608,6 +608,7 @@ void __bio_clone_fast(struct bio *bio, struct bio *bio_src)
 	bio->bi_write_hint = bio_src->bi_write_hint;
 	bio->bi_iter = bio_src->bi_iter;
 	bio->bi_io_vec = bio_src->bi_io_vec;
+	bio->bi_verifier = bio_src->bi_verifier;
 
 	bio_clone_blkg_association(bio, bio_src);
 	blkcg_bio_issue_init(bio);
@@ -1763,6 +1764,8 @@ void bio_endio(struct bio *bio)
 		return;
 	if (!bio_integrity_endio(bio))
 		return;
+	if (!bio_verify_endio(bio))
+		return;
 
 	if (bio->bi_disk)
 		rq_qos_done_bio(bio->bi_disk->queue, bio);
diff --git a/block/blk-core.c b/block/blk-core.c
index d265d2924c32..cbec80f2d73a 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1167,6 +1167,10 @@ EXPORT_SYMBOL_GPL(direct_make_request);
 blk_qc_t submit_bio_verify(struct bio *bio,
 		int (*verifier_cb_func)(struct bio *))
 {
+	if (verifier_cb_func) {
+		bio->bi_verifier = verifier_cb_func;
+		bio->bi_opf |= REQ_VERIFY;
+	}
 	/*
 	 * If it's a regular read/write or a barrier with data attached,
 	 * go through the normal accounting stuff before submission.
diff --git a/block/blk.h b/block/blk.h
index 848278c52030..cdf30c65d4a8 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -151,6 +151,14 @@ static inline bool bio_integrity_endio(struct bio *bio)
 }
 #endif /* CONFIG_BLK_DEV_INTEGRITY */
 
+bool __bio_verify_endio(struct bio *);
+static inline bool bio_verify_endio(struct bio *bio)
+{
+	if (bio->bi_opf & REQ_VERIFY)
+		return __bio_verify_endio(bio);
+	return true;
+}
+
 unsigned long blk_rq_timeout(unsigned long timeout);
 void blk_add_timer(struct request *req);
 
diff --git a/block/bounce.c b/block/bounce.c
index ffb9e9ecfa7e..7a2c3f536030 100644
--- a/block/bounce.c
+++ b/block/bounce.c
@@ -252,6 +252,7 @@ static struct bio *bounce_clone_bio(struct bio *bio_src, gfp_t gfp_mask,
 	bio->bi_write_hint	= bio_src->bi_write_hint;
 	bio->bi_iter.bi_sector	= bio_src->bi_iter.bi_sector;
 	bio->bi_iter.bi_size	= bio_src->bi_iter.bi_size;
+	bio->bi_verifier	= bio_src->bi_verifier;
 
 	switch (bio_op(bio)) {
 	case REQ_OP_DISCARD:
diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 1d54109071cc..11b29a3831e1 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -1103,6 +1103,7 @@ static void alloc_behind_master_bio(struct r1bio *r1_bio,
 	}
 
 	behind_bio->bi_write_hint = bio->bi_write_hint;
+	behind_bio->bi_verifier = bio->bi_verifier;
 
 	while (i < vcnt && size) {
 		struct page *page;
diff --git a/drivers/md/raid5-ppl.c b/drivers/md/raid5-ppl.c
index 3a7c36326589..4cdaa5dabfbe 100644
--- a/drivers/md/raid5-ppl.c
+++ b/drivers/md/raid5-ppl.c
@@ -505,6 +505,7 @@ static void ppl_submit_iounit(struct ppl_io_unit *io)
 			bio = bio_alloc_bioset(GFP_NOIO, BIO_MAX_PAGES,
 					       &ppl_conf->bs);
 			bio->bi_opf = prev->bi_opf;
+			bio->bi_verifier = prev->bi_verifier;
 			bio_copy_dev(bio, prev);
 			bio->bi_iter.bi_sector = bio_end_sector(prev);
 			bio_add_page(bio, sh->ppl_page, PAGE_SIZE, 0);
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index d66bf5f32610..e9f25f162138 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -18,6 +18,7 @@ struct block_device;
 struct io_context;
 struct cgroup_subsys_state;
 typedef void (bio_end_io_t) (struct bio *);
+typedef int (bio_verifier_t) (struct bio *);
 
 /*
  * Block error status values.  See block/blk-core:blk_errors for the details.
@@ -187,6 +188,8 @@ struct bio {
 		struct bio_integrity_payload *bi_integrity; /* data integrity */
 #endif
 	};
+	bio_verifier_t		*bi_verifier;	/* verify callback when endio */
+	struct work_struct      bi_work;	/* I/O completion */
 
 	unsigned short		bi_vcnt;	/* how many bio_vec's */
 
@@ -329,6 +332,7 @@ enum req_flag_bits {
 	/* for driver use */
 	__REQ_DRV,
 	__REQ_SWAP,		/* swapping request. */
+	__REQ_VERIFY,		/* verify IO when endio is called */
 	__REQ_NR_BITS,		/* stops here */
 };
 
@@ -351,6 +355,7 @@ enum req_flag_bits {
 
 #define REQ_DRV			(1ULL << __REQ_DRV)
 #define REQ_SWAP		(1ULL << __REQ_SWAP)
+#define REQ_VERIFY		(1ULL << __REQ_VERIFY)
 
 #define REQ_FAILFAST_MASK \
 	(REQ_FAILFAST_DEV | REQ_FAILFAST_TRANSPORT | REQ_FAILFAST_DRIVER)
-- 
2.17.1

