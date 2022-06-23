Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09247C433EF
	for <linux-block@archiver.kernel.org>; Thu, 23 Jun 2022 23:26:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbiFWX0N (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Jun 2022 19:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiFWX0N (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Jun 2022 19:26:13 -0400
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED7665639F
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 16:26:12 -0700 (PDT)
Received: by mail-pj1-f42.google.com with SMTP id g10-20020a17090a708a00b001ea8aadd42bso1161194pjk.0
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 16:26:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a0ETpIJc3DGDpQ1xz1PUuuQ2LfTUoB8PgHXjpILsX48=;
        b=jyDsNQ0Oi3mQUdJT0ZRNiMsCc+a5yIwOOC3RNygXUXmDKGhHxgOxKAarFxU66o2zab
         E1/xcjF1iH3Lt7F8twYp+KD0ihqjEkr4Qsm4QKRThiWh151ef/e2OGNQKv8Wj7f8KE9e
         l2wipYcxiQChAA4NVlDRp6eI9XNkvt21hiwKFVHCO6u8WtK/WOCUIlib3ITNb6FFVKVy
         mmnRn2n4zBFYpacGcSVyRxJtZiVKl9ZEXdSBhjyx1Ej3YgLDlBNEtAQJfxP/N+QL1OCe
         BRP48igx3jhObD1vOuta3rO9VGsmr2pz/wzx/QkjU3/rAiklmMWsjhSlOLz7C2efJlGu
         n14w==
X-Gm-Message-State: AJIora/xYAMFcTsyxSGbsu3ucxvqwTSIVfxKt1iZt9I2VuyUGH1LEDIo
        0vA0hR+QjIurv3fLOreU12zD9/HToPE3Vw==
X-Google-Smtp-Source: AGRyM1vxMonQTASoU8hvG9ThpSGV1RfZt7b3YUUYGTEiq0wLScmpGZY3pXBtaYIt4MAPQxn3TyJh5w==
X-Received: by 2002:a17:902:f78c:b0:169:b76f:2685 with SMTP id q12-20020a170902f78c00b00169b76f2685mr36385473pln.41.1656026772560;
        Thu, 23 Jun 2022 16:26:12 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:85b2:5fa3:f71e:1b43])
        by smtp.gmail.com with ESMTPSA id f11-20020a62380b000000b0051829b1595dsm184709pfa.130.2022.06.23.16.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 16:26:11 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@wdc.com>
Subject: [PATCH v2 2/6] block: Introduce the blk_rq_is_zoned_seq_write() function
Date:   Thu, 23 Jun 2022 16:25:59 -0700
Message-Id: <20220623232603.3751912-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220623232603.3751912-1-bvanassche@acm.org>
References: <20220623232603.3751912-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Introduce a function that makes it easy to verify whether a write
request is for a sequential write required or sequential write preferred
zone. Simplify blk_req_needs_zone_write_lock() by using the new function.

Cc: Damien Le Moal <damien.lemoal@wdc.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-zoned.c      | 14 +-------------
 include/linux/blk-mq.h | 23 +++++++++++++++++++++++
 2 files changed, 24 insertions(+), 13 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 38cd840d8838..cafcbc508dfb 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -57,19 +57,7 @@ EXPORT_SYMBOL_GPL(blk_zone_cond_str);
  */
 bool blk_req_needs_zone_write_lock(struct request *rq)
 {
-	if (!rq->q->seq_zones_wlock)
-		return false;
-
-	if (blk_rq_is_passthrough(rq))
-		return false;
-
-	switch (req_op(rq)) {
-	case REQ_OP_WRITE_ZEROES:
-	case REQ_OP_WRITE:
-		return blk_rq_zone_is_seq(rq);
-	default:
-		return false;
-	}
+	return rq->q->seq_zones_wlock && blk_rq_is_zoned_seq_write(rq);
 }
 EXPORT_SYMBOL_GPL(blk_req_needs_zone_write_lock);
 
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 909d47e34b7c..d5930797b84d 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -1136,6 +1136,24 @@ static inline unsigned int blk_rq_zone_is_seq(struct request *rq)
 	return blk_queue_zone_is_seq(rq->q, blk_rq_pos(rq));
 }
 
+/**
+ * blk_rq_is_zoned_seq_write() - Whether @rq is a write request for a sequential zone.
+ * @rq: Request to examine.
+ *
+ * In this context sequential zone means either a sequential write required or
+ * a sequential write preferred zone.
+ */
+static inline bool blk_rq_is_zoned_seq_write(struct request *rq)
+{
+	switch (req_op(rq)) {
+	case REQ_OP_WRITE:
+	case REQ_OP_WRITE_ZEROES:
+		return blk_rq_zone_is_seq(rq);
+	default:
+		return false;
+	}
+}
+
 bool blk_req_needs_zone_write_lock(struct request *rq);
 bool blk_req_zone_write_trylock(struct request *rq);
 void __blk_req_zone_write_lock(struct request *rq);
@@ -1166,6 +1184,11 @@ static inline bool blk_req_can_dispatch_to_zone(struct request *rq)
 	return !blk_req_zone_is_write_locked(rq);
 }
 #else /* CONFIG_BLK_DEV_ZONED */
+static inline bool blk_rq_is_zoned_seq_write(struct request *rq)
+{
+	return false;
+}
+
 static inline bool blk_req_needs_zone_write_lock(struct request *rq)
 {
 	return false;
