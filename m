Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F005AC433F5
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 20:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9949610F9
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 20:44:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbhJMUqU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Oct 2021 16:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbhJMUqU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Oct 2021 16:46:20 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CDD6C061570
        for <linux-block@vger.kernel.org>; Wed, 13 Oct 2021 13:44:16 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id x1so1215893iof.7
        for <linux-block@vger.kernel.org>; Wed, 13 Oct 2021 13:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=paM2p8vZnf/TaoeqWLYwfHOHV/RT07ipuW657wI8IRE=;
        b=wEIlvbxYtP0xX22lUhJrh1g9IXuh8ZGkaoMNizecDRAI1/mcshw/q69Hahj/25jjGm
         RL1dFuQPW9DZZ1gNz1+HtrT6zRFGywZWnYOJKFnMxpwawzgBmEacJF60kE6ccXP8WOTH
         PnkDaQtWEDOxaAgZ6a3kJp/oo8r+WtAGysJn55EOBhKwT7xYfF9htE2TM4oVHhsiMDzA
         K/gr2KfV8gZsHQhuS47m4pT7auqyj+T5iSvGoYveYyCaQ3vtWdDuG5tsPCLu4dsIJgo7
         fPFoGlZb3+LYWxo09BoYIaLKxAuuWYP/ltngTW5FsFGDP3QuvpdR4G0QVarGsO032JZd
         BtyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=paM2p8vZnf/TaoeqWLYwfHOHV/RT07ipuW657wI8IRE=;
        b=0nEI+sHjCO2r/BSGtXegFACt4TPiZ1tZ/q0XTh2+wUucuPzNAnBD1nLbokPd4W9Ncv
         3mVRSrDVcSY8dT2Ul4ivHSnB8lKWQwXbTeLk/iaL1nOSgHzQucHVf6aWm4uQx1NF9aEj
         Bysrwy9pttwlrFnio43egzpfk0wPbewxSuNiEcOyt4NwYIu+NCF/QdiTf6OWK3c04HEp
         FKDlMViPnNH6SxGGzePjhKH4lGT0l9szUdGUMhLQrunSABj3BL16tRIQGWX1yeNiTfZw
         uSA09lNAJWcGJY6/M3HJh8/w2ZQPig/6+CBseXyukckXsrCN4YI2F/I8pv/0alydR9Sh
         SIIA==
X-Gm-Message-State: AOAM531GLIvIcesrnAX2rZ4lbbxYOxqfJsR6aNU3DAc77oLq3BuBA7FA
        NK7FU9Tlp6Pzc/PwbKWaaXwXsZBqqR4=
X-Google-Smtp-Source: ABdhPJw07TxJRO1CfEBXMjZmYCdrJGm/9rxuHl57wbdDOch0KQRZphM+B/W7WWrqE0DaRJQf8JBrSQ==
X-Received: by 2002:a02:ad05:: with SMTP id s5mr1176713jan.65.1634157855092;
        Wed, 13 Oct 2021 13:44:15 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id l6sm271521ilt.31.2021.10.13.13.44.14
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Oct 2021 13:44:14 -0700 (PDT)
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] block: handle fast path of bio splitting inline
Message-ID: <30045b11-0064-1849-5b10-f8fa05c6958d@kernel.dk>
Date:   Wed, 13 Oct 2021 14:44:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The fast path is no splitting needed. Separate the handling into a
check part we can inline, and an out-of-line handling path if we do
need to split.

Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 9a55b5070829..20ec9f00801a 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -14,6 +14,7 @@
 #include "blk.h"
 #include "blk-rq-qos.h"
 #include "blk-throttle.h"
+#include "blk-merge.h"
 
 static inline void bio_get_first_bvec(struct bio *bio, struct bio_vec *bv)
 {
@@ -92,10 +93,8 @@ static inline bool req_gap_front_merge(struct request *req, struct bio *bio)
 	return bio_will_gap(req->q, NULL, bio, req->bio);
 }
 
-static struct bio *blk_bio_discard_split(struct request_queue *q,
-					 struct bio *bio,
-					 struct bio_set *bs,
-					 unsigned *nsegs)
+struct bio *blk_bio_discard_split(struct request_queue *q, struct bio *bio,
+				  struct bio_set *bs, unsigned *nsegs)
 {
 	unsigned int max_discard_sectors, granularity;
 	int alignment;
@@ -136,8 +135,8 @@ static struct bio *blk_bio_discard_split(struct request_queue *q,
 	return bio_split(bio, split_sectors, GFP_NOIO, bs);
 }
 
-static struct bio *blk_bio_write_zeroes_split(struct request_queue *q,
-		struct bio *bio, struct bio_set *bs, unsigned *nsegs)
+struct bio *blk_bio_write_zeroes_split(struct request_queue *q, struct bio *bio,
+				       struct bio_set *bs, unsigned *nsegs)
 {
 	*nsegs = 0;
 
@@ -150,10 +149,8 @@ static struct bio *blk_bio_write_zeroes_split(struct request_queue *q,
 	return bio_split(bio, q->limits.max_write_zeroes_sectors, GFP_NOIO, bs);
 }
 
-static struct bio *blk_bio_write_same_split(struct request_queue *q,
-					    struct bio *bio,
-					    struct bio_set *bs,
-					    unsigned *nsegs)
+struct bio *blk_bio_write_same_split(struct request_queue *q, struct bio *bio,
+				     struct bio_set *bs, unsigned *nsegs)
 {
 	*nsegs = 1;
 
@@ -275,10 +272,8 @@ static bool bvec_split_segs(const struct request_queue *q,
  * responsible for ensuring that @bs is only destroyed after processing of the
  * split bio has finished.
  */
-static struct bio *blk_bio_segment_split(struct request_queue *q,
-					 struct bio *bio,
-					 struct bio_set *bs,
-					 unsigned *segs)
+struct bio *blk_bio_segment_split(struct request_queue *q, struct bio *bio,
+				  struct bio_set *bs, unsigned *segs)
 {
 	struct bio_vec bv, bvprv, *bvprvp = NULL;
 	struct bvec_iter iter;
@@ -322,67 +317,17 @@ static struct bio *blk_bio_segment_split(struct request_queue *q,
 	return bio_split(bio, sectors, GFP_NOIO, bs);
 }
 
-/**
- * __blk_queue_split - split a bio and submit the second half
- * @bio:     [in, out] bio to be split
- * @nr_segs: [out] number of segments in the first bio
- *
- * Split a bio into two bios, chain the two bios, submit the second half and
- * store a pointer to the first half in *@bio. If the second bio is still too
- * big it will be split by a recursive call to this function. Since this
- * function may allocate a new bio from q->bio_split, it is the responsibility
- * of the caller to ensure that q->bio_split is only released after processing
- * of the split bio has finished.
- */
-void __blk_queue_split(struct bio **bio, unsigned int *nr_segs)
+void blk_bio_handle_split(struct bio **bio, struct bio *split)
 {
-	struct request_queue *q = (*bio)->bi_bdev->bd_disk->queue;
-	struct bio *split = NULL;
-
-	switch (bio_op(*bio)) {
-	case REQ_OP_DISCARD:
-	case REQ_OP_SECURE_ERASE:
-		split = blk_bio_discard_split(q, *bio, &q->bio_split, nr_segs);
-		break;
-	case REQ_OP_WRITE_ZEROES:
-		split = blk_bio_write_zeroes_split(q, *bio, &q->bio_split,
-				nr_segs);
-		break;
-	case REQ_OP_WRITE_SAME:
-		split = blk_bio_write_same_split(q, *bio, &q->bio_split,
-				nr_segs);
-		break;
-	default:
-		/*
-		 * All drivers must accept single-segments bios that are <=
-		 * PAGE_SIZE.  This is a quick and dirty check that relies on
-		 * the fact that bi_io_vec[0] is always valid if a bio has data.
-		 * The check might lead to occasional false negatives when bios
-		 * are cloned, but compared to the performance impact of cloned
-		 * bios themselves the loop below doesn't matter anyway.
-		 */
-		if (!q->limits.chunk_sectors &&
-		    (*bio)->bi_vcnt == 1 &&
-		    ((*bio)->bi_io_vec[0].bv_len +
-		     (*bio)->bi_io_vec[0].bv_offset) <= PAGE_SIZE) {
-			*nr_segs = 1;
-			break;
-		}
-		split = blk_bio_segment_split(q, *bio, &q->bio_split, nr_segs);
-		break;
-	}
-
-	if (split) {
-		/* there isn't chance to merge the splitted bio */
-		split->bi_opf |= REQ_NOMERGE;
+	/* there isn't chance to merge the splitted bio */
+	split->bi_opf |= REQ_NOMERGE;
 
-		bio_chain(split, *bio);
-		trace_block_split(split, (*bio)->bi_iter.bi_sector);
-		submit_bio_noacct(*bio);
-		*bio = split;
+	bio_chain(split, *bio);
+	trace_block_split(split, (*bio)->bi_iter.bi_sector);
+	submit_bio_noacct(*bio);
+	*bio = split;
 
-		blk_throtl_charge_bio_split(*bio);
-	}
+	blk_throtl_charge_bio_split(*bio);
 }
 
 /**
@@ -397,9 +342,10 @@ void __blk_queue_split(struct bio **bio, unsigned int *nr_segs)
  */
 void blk_queue_split(struct bio **bio)
 {
+	struct request_queue *q = (*bio)->bi_bdev->bd_disk->queue;
 	unsigned int nr_segs;
 
-	__blk_queue_split(bio, &nr_segs);
+	__blk_queue_split(q, bio, &nr_segs);
 }
 EXPORT_SYMBOL(blk_queue_split);
 
diff --git a/block/blk-merge.h b/block/blk-merge.h
new file mode 100644
index 000000000000..8f0b7dec2dd2
--- /dev/null
+++ b/block/blk-merge.h
@@ -0,0 +1,71 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef BLK_MERGE_H
+#define BLK_MERGE_H
+
+#include "blk-mq.h"
+
+struct bio *blk_bio_discard_split(struct request_queue *q, struct bio *bio,
+				  struct bio_set *bs, unsigned *nsegs);
+struct bio *blk_bio_write_zeroes_split(struct request_queue *q, struct bio *bio,
+				       struct bio_set *bs, unsigned *nsegs);
+struct bio *blk_bio_write_same_split(struct request_queue *q, struct bio *bio,
+				     struct bio_set *bs, unsigned *nsegs);
+struct bio *blk_bio_segment_split(struct request_queue *q, struct bio *bio,
+				  struct bio_set *bs, unsigned *segs);
+void blk_bio_handle_split(struct bio **bio, struct bio *split);
+
+/**
+ * blk_queue_split - split a bio and submit the second half
+ * @bio:     [in, out] bio to be split
+ * @nr_segs: [out] number of segments in the first bio
+ *
+ * Split a bio into two bios, chain the two bios, submit the second half and
+ * store a pointer to the first half in *@bio. If the second bio is still too
+ * big it will be split by a recursive call to this function. Since this
+ * function may allocate a new bio from q->bio_split, it is the responsibility
+ * of the caller to ensure that q->bio_split is only released after processing
+ * of the split bio has finished.
+ */
+static inline void __blk_queue_split(struct request_queue *q, struct bio **bio,
+				     unsigned int *nr_segs)
+{
+	struct bio *split = NULL;
+
+	switch (bio_op(*bio)) {
+	case REQ_OP_DISCARD:
+	case REQ_OP_SECURE_ERASE:
+		split = blk_bio_discard_split(q, *bio, &q->bio_split, nr_segs);
+		break;
+	case REQ_OP_WRITE_ZEROES:
+		split = blk_bio_write_zeroes_split(q, *bio, &q->bio_split,
+				nr_segs);
+		break;
+	case REQ_OP_WRITE_SAME:
+		split = blk_bio_write_same_split(q, *bio, &q->bio_split,
+				nr_segs);
+		break;
+	default:
+		/*
+		 * All drivers must accept single-segments bios that are <=
+		 * PAGE_SIZE.  This is a quick and dirty check that relies on
+		 * the fact that bi_io_vec[0] is always valid if a bio has data.
+		 * The check might lead to occasional false negatives when bios
+		 * are cloned, but compared to the performance impact of cloned
+		 * bios themselves the loop below doesn't matter anyway.
+		 */
+		if (!q->limits.chunk_sectors &&
+		    (*bio)->bi_vcnt == 1 &&
+		    ((*bio)->bi_io_vec[0].bv_len +
+		     (*bio)->bi_io_vec[0].bv_offset) <= PAGE_SIZE) {
+			*nr_segs = 1;
+			break;
+		}
+		split = blk_bio_segment_split(q, *bio, &q->bio_split, nr_segs);
+		break;
+	}
+
+	if (split)
+		blk_bio_handle_split(bio, split);
+}
+
+#endif
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 7dadfac5bad0..54c510c0f3ee 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -42,6 +42,7 @@
 #include "blk-stat.h"
 #include "blk-mq-sched.h"
 #include "blk-rq-qos.h"
+#include "blk-merge.h"
 
 static DEFINE_PER_CPU(struct llist_head, blk_cpu_done);
 
@@ -2514,7 +2515,7 @@ void blk_mq_submit_bio(struct bio *bio)
 	blk_status_t ret;
 
 	blk_queue_bounce(q, &bio);
-	__blk_queue_split(&bio, &nr_segs);
+	__blk_queue_split(q, &bio, &nr_segs);
 
 	if (!bio_integrity_prep(bio))
 		goto queue_exit;
diff --git a/block/blk.h b/block/blk.h
index 0afee3e6a7c1..c0b59bc38a2e 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -262,7 +262,6 @@ ssize_t part_timeout_show(struct device *, struct device_attribute *, char *);
 ssize_t part_timeout_store(struct device *, struct device_attribute *,
 				const char *, size_t);
 
-void __blk_queue_split(struct bio **bio, unsigned int *nr_segs);
 int ll_back_merge_fn(struct request *req, struct bio *bio,
 		unsigned int nr_segs);
 bool blk_attempt_req_merge(struct request_queue *q, struct request *rq,

-- 
Jens Axboe

