Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E398C4361B
	for <linux-block@archiver.kernel.org>; Wed,  9 Dec 2020 13:09:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C839523B45
	for <linux-block@archiver.kernel.org>; Wed,  9 Dec 2020 13:09:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732179AbgLINJN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Dec 2020 08:09:13 -0500
Received: from mx4.veeam.com ([104.41.138.86]:33940 "EHLO mx4.veeam.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731965AbgLINJD (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 9 Dec 2020 08:09:03 -0500
Received: from mail.veeam.com (prgmbx01.amust.local [172.24.0.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx4.veeam.com (Postfix) with ESMTPS id AE1BFB21AE;
        Wed,  9 Dec 2020 16:01:48 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com; s=mx4;
        t=1607518908; bh=lLQOJoAu/Swae9Mr2YfO+NjXg7KvcgY7sSBSh8vbgrc=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=aguFfSHAs4D+sJdd8mopcLSoynBgwVcc+NfMOCNt+KeQ3ZaT0mXY3TGm/3KEgMv1q
         VXo666GYT9ICgfZQiETJBzOTK4idsnBgBeGQmSthd7oJFB1HtATuuKOoGIorQjygvT
         7BnHPg+6/+g+68G700cxtvOJGHrch3SvERBTQArM=
Received: from prgdevlinuxpatch01.amust.local (172.24.14.5) by
 prgmbx01.amust.local (172.24.0.171) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2;
 Wed, 9 Dec 2020 14:01:47 +0100
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
To:     <axboe@kernel.dk>, <johannes.thumshirn@wdc.com>,
        <koct9i@gmail.com>, <ming.lei@redhat.com>, <snitzer@redhat.com>,
        <hare@suse.de>, <josef@toxicpanda.com>, <steve@sk2.org>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <pavel.tide@veeam.com>, <sergei.shtepa@veeam.com>
Subject: [PATCH 1/3] block: blk_interposer - Block Layer Interposer
Date:   Wed, 9 Dec 2020 16:01:49 +0300
Message-ID: <1607518911-30692-2-git-send-email-sergei.shtepa@veeam.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1607518911-30692-1-git-send-email-sergei.shtepa@veeam.com>
References: <1607518911-30692-1-git-send-email-sergei.shtepa@veeam.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.24.14.5]
X-ClientProxiedBy: prgmbx02.amust.local (172.24.0.172) To prgmbx01.amust.local
 (172.24.0.171)
X-EsetResult: clean, is OK
X-EsetId: 37303A29C604D26A627160
X-Veeam-MMEX: True
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The Block Layer Interposer (blk_interposer) allows to intercept bio.
This allows to connect device mapper and other kernel modules to
the block device stack on the fly.

This simple hook allows to work modules that previously relied on the
interception of the make_request_fn() function from the
request_queue structure. This interception capability was lost in
the v5.8.

Changes:
  * A new __submit_bio_interposed() function call is added
    to the submit_bio_noacct(). The call is made only if the
    interposer was connected.
  * A new bio flag BIO_INTERPOSED can indicate that bio has
    already been interposed or cannot be interposed.
  * The bi_flags member of the BIO structure is expanded
    to a 32-bit variable to accommodate the new flag.
  * New structure blk_interposer contains the interposer
    callback function.
Signed-off-by: Sergei Shtepa <sergei.shtepa@veeam.com>
---
 block/blk-core.c          | 32 ++++++++++++++++++++++++++++++++
 include/linux/blk_types.h |  6 ++++--
 include/linux/genhd.h     | 12 +++++++++++-
 3 files changed, 47 insertions(+), 3 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 2db8bda43b6e..682b9b5a93ff 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1030,6 +1030,35 @@ static blk_qc_t __submit_bio_noacct_mq(struct bio *bio)
 	return ret;
 }
 
+static blk_qc_t __submit_bio_interposed(struct bio *bio)
+{
+	struct bio_list bio_list[2] = { };
+	blk_qc_t ret = BLK_QC_T_NONE;
+
+	current->bio_list = bio_list;
+	if (likely(bio_queue_enter(bio) == 0)) {
+		struct gendisk *disk = bio->bi_disk;
+
+		bio_set_flag(bio, BIO_INTERPOSED);
+		if (likely(blk_has_interposer(disk))) {
+			struct blk_interposer *ip = disk->interposer;
+
+			ip->ip_submit_bio(ip, bio);
+		} else
+			/* interposer was removed */
+			bio_list_add(&current->bio_list[0], bio);
+
+		blk_queue_exit(disk->queue);
+	}
+	current->bio_list = NULL;
+
+	/* Resubmit the remaining bios */
+	while ((bio = bio_list_pop(&bio_list[0])))
+		ret = submit_bio_noacct(bio);
+
+	return ret;
+}
+
 /**
  * submit_bio_noacct - re-submit a bio to the block device layer for I/O
  * @bio:  The bio describing the location in memory and on the device.
@@ -1055,6 +1084,9 @@ blk_qc_t submit_bio_noacct(struct bio *bio)
 		return BLK_QC_T_NONE;
 	}
 
+	if (blk_has_interposer(bio->bi_disk) &&
+	    !bio_flagged(bio, BIO_INTERPOSED))
+		return __submit_bio_interposed(bio);
 	if (!bio->bi_disk->fops->submit_bio)
 		return __submit_bio_noacct_mq(bio);
 	return __submit_bio_noacct(bio);
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index d9b69bbde5cc..996b803e5aa1 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -207,7 +207,7 @@ struct bio {
 						 * top bits REQ_OP. Use
 						 * accessors.
 						 */
-	unsigned short		bi_flags;	/* status, etc and bvec pool number */
+	unsigned int		bi_flags;	/* status, etc and bvec pool number */
 	unsigned short		bi_ioprio;
 	unsigned short		bi_write_hint;
 	blk_status_t		bi_status;
@@ -284,6 +284,8 @@ enum {
 				 * of this bio. */
 	BIO_CGROUP_ACCT,	/* has been accounted to a cgroup */
 	BIO_TRACKED,		/* set if bio goes through the rq_qos path */
+	BIO_INTERPOSED,		/* bio has been interposed and can be moved to
+				 * a different disk */
 	BIO_FLAG_LAST
 };
 
@@ -302,7 +304,7 @@ enum {
  * freed.
  */
 #define BVEC_POOL_BITS		(3)
-#define BVEC_POOL_OFFSET	(16 - BVEC_POOL_BITS)
+#define BVEC_POOL_OFFSET	(32 - BVEC_POOL_BITS)
 #define BVEC_POOL_IDX(bio)	((bio)->bi_flags >> BVEC_POOL_OFFSET)
 #if (1<< BVEC_POOL_BITS) < (BVEC_POOL_NR+1)
 # error "BVEC_POOL_BITS is too small"
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 03da3f603d30..ea5fc57c3451 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -4,7 +4,7 @@
 
 /*
  * 	genhd.h Copyright (C) 1992 Drew Eckhardt
- *	Generic hard disk header file by  
+ *	Generic hard disk header file by
  * 		Drew Eckhardt
  *
  *		<drew@colorado.edu>
@@ -164,6 +164,13 @@ struct blk_integrity {
 	unsigned char				tag_size;
 };
 
+struct blk_interposer;
+typedef void (*ip_submit_bio_t) (struct blk_interposer *ip, struct bio *bio);
+
+struct blk_interposer {
+	ip_submit_bio_t ip_submit_bio;
+};
+
 struct gendisk {
 	/* major, first_minor and minors are input parameters only,
 	 * don't use directly.  Use disk_devt() and disk_max_parts().
@@ -188,6 +195,7 @@ struct gendisk {
 
 	const struct block_device_operations *fops;
 	struct request_queue *queue;
+	struct blk_interposer *interposer;
 	void *private_data;
 
 	int flags;
@@ -409,4 +417,6 @@ static inline dev_t blk_lookup_devt(const char *name, int partno)
 }
 #endif /* CONFIG_BLOCK */
 
+#define blk_has_interposer(d) ((d)->interposer != NULL)
+
 #endif /* _LINUX_GENHD_H */
-- 
2.20.1

