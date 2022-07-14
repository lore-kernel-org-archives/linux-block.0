Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84FAAC433EF
	for <linux-block@archiver.kernel.org>; Thu, 14 Jul 2022 18:07:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239145AbiGNSHs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Jul 2022 14:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240080AbiGNSHp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Jul 2022 14:07:45 -0400
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED2367CA3
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 11:07:44 -0700 (PDT)
Received: by mail-pj1-f52.google.com with SMTP id t5-20020a17090a6a0500b001ef965b262eso3830065pjj.5
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 11:07:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3A3OIJKH6e+SWDlSEoB6rMdvK3P+Zd27BmCPqlq7REg=;
        b=BOS5hUr3buXbGv/ue8nwuWfnhKV3mmYXGrFohjE+XgrITOa5rDA6ZAShlCOJsUYzKr
         pJ/IjimgfMlvBenVxSBRIBJ4CXD80CL5/r5+ntVRYTB5GwYrU3QbRyhWjO0K45dIjTnz
         u2vI6NRk7qQ/xZ3ap9Sy3EPhGo67t5XBReK96Q4S5z7qDLW2BT5HgEEanl7wJsC99hTW
         1skWoPfslX4T0226NMjtYClCEPolDCllna45rWEqE4DPvUQpbbyp4QV56x/ceb07OFes
         7g2ewxSr1iIkm0iBY+lsbn9Uxg7kTQR5FwnOjHvQg+wLjg8lJ48A3XnbWDcZ28uomT87
         FP9A==
X-Gm-Message-State: AJIora/ij3kkvF5lCcuII7b3A//PAltk8JnQbte4jlTOtD45Q459qOfD
        uC4XualThfMzXJCO7xdVpMw=
X-Google-Smtp-Source: AGRyM1ujEhtO8JxYnIF3WXYRwc6ioyf7Ag7hegfHp4Bd6e77GdT9wi8SjT9WqlJGGAd1cxIW66JIZg==
X-Received: by 2002:a17:90a:6c65:b0:1ef:9479:372c with SMTP id x92-20020a17090a6c6500b001ef9479372cmr10834986pjj.21.1657822063655;
        Thu, 14 Jul 2022 11:07:43 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:9fab:70d1:f0e7:922b])
        by smtp.gmail.com with ESMTPSA id m5-20020a170902db0500b0016bebb0cb96sm1781846plx.266.2022.07.14.11.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 11:07:43 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v3 05/63] block: Introduce the type blk_opf_t
Date:   Thu, 14 Jul 2022 11:06:31 -0700
Message-Id: <20220714180729.1065367-6-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
In-Reply-To: <20220714180729.1065367-1-bvanassche@acm.org>
References: <20220714180729.1065367-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Introduce the type blk_opf_t for the request operation and flags (REQ_OP_*
and REQ_*). This type will be used to improve documentation of the block
layer code and also to allow sparse to verify whether request flags are used
correctly.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Damien Le Moal <damien.lemoal@wdc.com>
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 include/linux/blk_types.h | 97 ++++++++++++++++++++-------------------
 1 file changed, 51 insertions(+), 46 deletions(-)

diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index e66cbe377ae8..1ef99790f6ed 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -240,6 +240,8 @@ static inline void bio_issue_init(struct bio_issue *issue,
 			((u64)size << BIO_ISSUE_SIZE_SHIFT));
 }
 
+typedef __u32 __bitwise blk_opf_t;
+
 typedef unsigned int blk_qc_t;
 #define BLK_QC_T_NONE		-1U
 
@@ -250,7 +252,7 @@ typedef unsigned int blk_qc_t;
 struct bio {
 	struct bio		*bi_next;	/* request queue link */
 	struct block_device	*bi_bdev;
-	unsigned int		bi_opf;		/* bottom bits REQ_OP, top bits
+	blk_opf_t		bi_opf;		/* bottom bits REQ_OP, top bits
 						 * req_flags.
 						 */
 	unsigned short		bi_flags;	/* BIO_* below */
@@ -338,7 +340,7 @@ enum {
 typedef __u32 __bitwise blk_mq_req_flags_t;
 
 #define REQ_OP_BITS	8
-#define REQ_OP_MASK	((1 << REQ_OP_BITS) - 1)
+#define REQ_OP_MASK	(__force blk_opf_t)((1 << REQ_OP_BITS) - 1)
 #define REQ_FLAG_BITS	24
 
 /**
@@ -356,35 +358,35 @@ typedef __u32 __bitwise blk_mq_req_flags_t;
  */
 enum req_op {
 	/* read sectors from the device */
-	REQ_OP_READ		= 0,
+	REQ_OP_READ		= (__force blk_opf_t)0,
 	/* write sectors to the device */
-	REQ_OP_WRITE		= 1,
+	REQ_OP_WRITE		= (__force blk_opf_t)1,
 	/* flush the volatile write cache */
-	REQ_OP_FLUSH		= 2,
+	REQ_OP_FLUSH		= (__force blk_opf_t)2,
 	/* discard sectors */
-	REQ_OP_DISCARD		= 3,
+	REQ_OP_DISCARD		= (__force blk_opf_t)3,
 	/* securely erase sectors */
-	REQ_OP_SECURE_ERASE	= 5,
+	REQ_OP_SECURE_ERASE	= (__force blk_opf_t)5,
 	/* write the zero filled sector many times */
-	REQ_OP_WRITE_ZEROES	= 9,
+	REQ_OP_WRITE_ZEROES	= (__force blk_opf_t)9,
 	/* Open a zone */
-	REQ_OP_ZONE_OPEN	= 10,
+	REQ_OP_ZONE_OPEN	= (__force blk_opf_t)10,
 	/* Close a zone */
-	REQ_OP_ZONE_CLOSE	= 11,
+	REQ_OP_ZONE_CLOSE	= (__force blk_opf_t)11,
 	/* Transition a zone to full */
-	REQ_OP_ZONE_FINISH	= 12,
+	REQ_OP_ZONE_FINISH	= (__force blk_opf_t)12,
 	/* write data at the current zone write pointer */
-	REQ_OP_ZONE_APPEND	= 13,
+	REQ_OP_ZONE_APPEND	= (__force blk_opf_t)13,
 	/* reset a zone write pointer */
-	REQ_OP_ZONE_RESET	= 15,
+	REQ_OP_ZONE_RESET	= (__force blk_opf_t)15,
 	/* reset all the zone present on the device */
-	REQ_OP_ZONE_RESET_ALL	= 17,
+	REQ_OP_ZONE_RESET_ALL	= (__force blk_opf_t)17,
 
 	/* Driver private requests */
-	REQ_OP_DRV_IN		= 34,
-	REQ_OP_DRV_OUT		= 35,
+	REQ_OP_DRV_IN		= (__force blk_opf_t)34,
+	REQ_OP_DRV_OUT		= (__force blk_opf_t)35,
 
-	REQ_OP_LAST,
+	REQ_OP_LAST		= (__force blk_opf_t)36,
 };
 
 enum req_flag_bits {
@@ -425,28 +427,31 @@ enum req_flag_bits {
 	__REQ_NR_BITS,		/* stops here */
 };
 
-#define REQ_FAILFAST_DEV	(1ULL << __REQ_FAILFAST_DEV)
-#define REQ_FAILFAST_TRANSPORT	(1ULL << __REQ_FAILFAST_TRANSPORT)
-#define REQ_FAILFAST_DRIVER	(1ULL << __REQ_FAILFAST_DRIVER)
-#define REQ_SYNC		(1ULL << __REQ_SYNC)
-#define REQ_META		(1ULL << __REQ_META)
-#define REQ_PRIO		(1ULL << __REQ_PRIO)
-#define REQ_NOMERGE		(1ULL << __REQ_NOMERGE)
-#define REQ_IDLE		(1ULL << __REQ_IDLE)
-#define REQ_INTEGRITY		(1ULL << __REQ_INTEGRITY)
-#define REQ_FUA			(1ULL << __REQ_FUA)
-#define REQ_PREFLUSH		(1ULL << __REQ_PREFLUSH)
-#define REQ_RAHEAD		(1ULL << __REQ_RAHEAD)
-#define REQ_BACKGROUND		(1ULL << __REQ_BACKGROUND)
-#define REQ_NOWAIT		(1ULL << __REQ_NOWAIT)
-#define REQ_CGROUP_PUNT		(1ULL << __REQ_CGROUP_PUNT)
-
-#define REQ_NOUNMAP		(1ULL << __REQ_NOUNMAP)
-#define REQ_POLLED		(1ULL << __REQ_POLLED)
-#define REQ_ALLOC_CACHE		(1ULL << __REQ_ALLOC_CACHE)
-
-#define REQ_DRV			(1ULL << __REQ_DRV)
-#define REQ_SWAP		(1ULL << __REQ_SWAP)
+#define REQ_FAILFAST_DEV	\
+			(__force blk_opf_t)(1ULL << __REQ_FAILFAST_DEV)
+#define REQ_FAILFAST_TRANSPORT	\
+			(__force blk_opf_t)(1ULL << __REQ_FAILFAST_TRANSPORT)
+#define REQ_FAILFAST_DRIVER	\
+			(__force blk_opf_t)(1ULL << __REQ_FAILFAST_DRIVER)
+#define REQ_SYNC	(__force blk_opf_t)(1ULL << __REQ_SYNC)
+#define REQ_META	(__force blk_opf_t)(1ULL << __REQ_META)
+#define REQ_PRIO	(__force blk_opf_t)(1ULL << __REQ_PRIO)
+#define REQ_NOMERGE	(__force blk_opf_t)(1ULL << __REQ_NOMERGE)
+#define REQ_IDLE	(__force blk_opf_t)(1ULL << __REQ_IDLE)
+#define REQ_INTEGRITY	(__force blk_opf_t)(1ULL << __REQ_INTEGRITY)
+#define REQ_FUA		(__force blk_opf_t)(1ULL << __REQ_FUA)
+#define REQ_PREFLUSH	(__force blk_opf_t)(1ULL << __REQ_PREFLUSH)
+#define REQ_RAHEAD	(__force blk_opf_t)(1ULL << __REQ_RAHEAD)
+#define REQ_BACKGROUND	(__force blk_opf_t)(1ULL << __REQ_BACKGROUND)
+#define REQ_NOWAIT	(__force blk_opf_t)(1ULL << __REQ_NOWAIT)
+#define REQ_CGROUP_PUNT	(__force blk_opf_t)(1ULL << __REQ_CGROUP_PUNT)
+
+#define REQ_NOUNMAP	(__force blk_opf_t)(1ULL << __REQ_NOUNMAP)
+#define REQ_POLLED	(__force blk_opf_t)(1ULL << __REQ_POLLED)
+#define REQ_ALLOC_CACHE	(__force blk_opf_t)(1ULL << __REQ_ALLOC_CACHE)
+
+#define REQ_DRV		(__force blk_opf_t)(1ULL << __REQ_DRV)
+#define REQ_SWAP	(__force blk_opf_t)(1ULL << __REQ_SWAP)
 
 #define REQ_FAILFAST_MASK \
 	(REQ_FAILFAST_DEV | REQ_FAILFAST_TRANSPORT | REQ_FAILFAST_DRIVER)
@@ -469,22 +474,22 @@ static inline enum req_op bio_op(const struct bio *bio)
 }
 
 /* obsolete, don't use in new code */
-static inline void bio_set_op_attrs(struct bio *bio, unsigned op,
-		unsigned op_flags)
+static inline void bio_set_op_attrs(struct bio *bio, enum req_op op,
+				    blk_opf_t op_flags)
 {
 	bio->bi_opf = op | op_flags;
 }
 
-static inline bool op_is_write(unsigned int op)
+static inline bool op_is_write(blk_opf_t op)
 {
-	return (op & 1);
+	return !!(op & (__force blk_opf_t)1);
 }
 
 /*
  * Check if the bio or request is one that needs special treatment in the
  * flush state machine.
  */
-static inline bool op_is_flush(unsigned int op)
+static inline bool op_is_flush(blk_opf_t op)
 {
 	return op & (REQ_FUA | REQ_PREFLUSH);
 }
@@ -494,13 +499,13 @@ static inline bool op_is_flush(unsigned int op)
  * PREFLUSH flag.  Other operations may be marked as synchronous using the
  * REQ_SYNC flag.
  */
-static inline bool op_is_sync(unsigned int op)
+static inline bool op_is_sync(blk_opf_t op)
 {
 	return (op & REQ_OP_MASK) == REQ_OP_READ ||
 		(op & (REQ_SYNC | REQ_FUA | REQ_PREFLUSH));
 }
 
-static inline bool op_is_discard(unsigned int op)
+static inline bool op_is_discard(blk_opf_t op)
 {
 	return (op & REQ_OP_MASK) == REQ_OP_DISCARD;
 }
