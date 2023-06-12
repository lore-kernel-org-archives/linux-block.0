Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2DC1C7EE2E
	for <linux-block@archiver.kernel.org>; Mon, 12 Jun 2023 20:33:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236274AbjFLUd1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 12 Jun 2023 16:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236307AbjFLUd0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Jun 2023 16:33:26 -0400
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB32710C9
        for <linux-block@vger.kernel.org>; Mon, 12 Jun 2023 13:33:25 -0700 (PDT)
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1b3d29cfb17so11909635ad.3
        for <linux-block@vger.kernel.org>; Mon, 12 Jun 2023 13:33:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686602005; x=1689194005;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qo39VGVNKAqYQuhvjR9+/XSsIZeV792czsUdbh6Q7Qk=;
        b=j/iTwHf2pXI3vhU0slyNvW0z5X7qbfZ/BfTCQAaco2FalLE89OsTDrjZRufXNGxWlz
         2eWULbrhbsgzlItO3rPfb9uDnG63jE72l+VUnGQVchcVqyqDEvHJae6nlSq4C+2ntOMV
         /CLx+TFm8HruhLqnMS/xf0qeXyjKeLJTyYAGclAfQGA24D+cp7QEmj827v3AepBahxnb
         tPpH5oAsAg6NJPZ0PYw2mPb4Rs02n0vRnf3hU+zGRahE0Z+P744eXOEcdpMUGs0RWgnp
         QrRMRaKqdiQPPb3NEOjVz7+DKw68iCPF70jb6Ex5rpAn650aAuqfAIH6ponw/nbocmt5
         c9NA==
X-Gm-Message-State: AC+VfDzCMOJEj43md+yz3av9ssWSTZysSePmvhwIz/pqgYngyPGy6KfV
        rDuxwUawTD/ZoTLOosJGfYE=
X-Google-Smtp-Source: ACHHUZ5wFhJjb9g/E2490NF5L48uzJhLdUJt7YLw7hmbdFJDs89hn7CpzfCM7PGdmFyNHLRXx+s/NQ==
X-Received: by 2002:a17:902:c407:b0:1ac:5717:fd5 with SMTP id k7-20020a170902c40700b001ac57170fd5mr10519253plk.60.1686602005320;
        Mon, 12 Jun 2023 13:33:25 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id ji1-20020a170903324100b001b016313b1dsm3324767plb.86.2023.06.12.13.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 13:33:24 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Sandeep Dhavale <dhavale@google.com>,
        Juan Yescas <jyescas@google.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH v6 5/8] block: Support submitting passthrough requests with small segments
Date:   Mon, 12 Jun 2023 13:33:11 -0700
Message-Id: <20230612203314.17820-6-bvanassche@acm.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230612203314.17820-1-bvanassche@acm.org>
References: <20230612203314.17820-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If the segment size is smaller than the page size there may be multiple
segments per bvec even if a bvec only contains a single page. Hence this
patch.

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Keith Busch <kbusch@kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-map.c |  2 +-
 block/blk.h     | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/block/blk-map.c b/block/blk-map.c
index 3551c3ff17cf..c1d92b0dcc5d 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -535,7 +535,7 @@ int blk_rq_append_bio(struct request *rq, struct bio *bio)
 	unsigned int nr_segs = 0;
 
 	bio_for_each_bvec(bv, bio, iter)
-		nr_segs++;
+		nr_segs += blk_segments(&rq->q->limits, bv.bv_len);
 
 	if (!rq->bio) {
 		blk_rq_bio_prep(rq, bio, nr_segs);
diff --git a/block/blk.h b/block/blk.h
index 065449e7d0bd..18b898a38c72 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -86,6 +86,24 @@ struct bio_vec *bvec_alloc(mempool_t *pool, unsigned short *nr_vecs,
 		gfp_t gfp_mask);
 void bvec_free(mempool_t *pool, struct bio_vec *bv, unsigned short nr_vecs);
 
+/* Number of DMA segments required to transfer @bytes data. */
+static inline unsigned int blk_segments(const struct queue_limits *limits,
+					unsigned int bytes)
+{
+	if (!blk_queue_sub_page_limits(limits))
+		return 1;
+
+	{
+		const unsigned int mss = limits->max_segment_size;
+
+		if (bytes <= mss)
+			return 1;
+		if (is_power_of_2(mss))
+			return round_up(bytes, mss) >> ilog2(mss);
+		return (bytes + mss - 1) / mss;
+	}
+}
+
 static inline bool biovec_phys_mergeable(struct request_queue *q,
 		struct bio_vec *vec1, struct bio_vec *vec2)
 {
