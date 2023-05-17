Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F356C77B75
	for <linux-block@archiver.kernel.org>; Wed, 17 May 2023 17:45:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbjEQRpd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 May 2023 13:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjEQRpb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 May 2023 13:45:31 -0400
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 992965FD0
        for <linux-block@vger.kernel.org>; Wed, 17 May 2023 10:44:58 -0700 (PDT)
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-643995a47f7so1120701b3a.1
        for <linux-block@vger.kernel.org>; Wed, 17 May 2023 10:44:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684345477; x=1686937477;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=at01WkjHCkf+9Zq8PAzpbm1lmLYzBF4o5syCToTTzgM=;
        b=Kg9EXEK7vZF/8kqJFzl7Ss1xn4RddAJAavbLYEWs2rSWtrHwk+xzm/WdCK+EpHM+c9
         LtB7RnjpL+u15zONZP+ZbVZNMzQaHL23k9UVA5lkPrF1mtlHsJyCnNHYZfi05IrfBLJd
         OCabpgnccXlyOK8HVW8l6856Nfb3FKc5Ow3jkUr5kIi7Y0Af5ItBsAVe0WXt3gA4UeIB
         c6lRZ1Zq4BBNjTfP0rjN9lO0vHkYyvFJaWifQGhfad6f81PN15L4+qR6Kv1roWw4BtR/
         Iu+n7rsJurlQkkuH3A3NdTeZo+Z2LNgt9qkFvZFKm/vaB2U1GRcz0HnOFL6FnuS90vlR
         A2Qw==
X-Gm-Message-State: AC+VfDzJVZ+lh4ZCfUobdPssk2l1WM29t4J2V/0lMPa5+CcWPRdZ7EOd
        Fj8yx+TOwq9EecdzeEGEhGE=
X-Google-Smtp-Source: ACHHUZ6IO0beZvYlKgRtrx0RC13Cy4nBCOin7GgFoZT8YWX9EmVNvNaF58dHuBVpjcuXABEyb7re3g==
X-Received: by 2002:a05:6a20:a11f:b0:106:a78f:be1d with SMTP id q31-20020a056a20a11f00b00106a78fbe1dmr11192501pzk.20.1684345476871;
        Wed, 17 May 2023 10:44:36 -0700 (PDT)
Received: from bvanassche-glaptop2.roam.corp.google.com ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id d22-20020aa78e56000000b00646e7d2b5a7sm15334410pfr.112.2023.05.17.10.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 10:44:36 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v6 05/11] block: Introduce blk_rq_is_seq_zoned_write()
Date:   Wed, 17 May 2023 10:42:23 -0700
Message-ID: <20230517174230.897144-6-bvanassche@acm.org>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
In-Reply-To: <20230517174230.897144-1-bvanassche@acm.org>
References: <20230517174230.897144-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Introduce the function blk_rq_is_seq_zoned_write(). This function will
be used in later patches to preserve the order of zoned writes that
require write serialization.

This patch includes an optimization: instead of using
rq->q->disk->part0->bd_queue to check whether or not the queue is
associated with a zoned block device, use rq->q->disk->queue.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Damien Le Moal <dlemoal@kernel.org>
Cc: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-zoned.c      |  5 +----
 include/linux/blk-mq.h | 17 +++++++++++++++++
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 835d9e937d4d..096b6b47561f 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -60,10 +60,7 @@ bool blk_req_needs_zone_write_lock(struct request *rq)
 	if (!rq->q->disk->seq_zones_wlock)
 		return false;
 
-	if (bdev_op_is_zoned_write(rq->q->disk->part0, req_op(rq)))
-		return blk_rq_zone_is_seq(rq);
-
-	return false;
+	return blk_rq_is_seq_zoned_write(rq);
 }
 EXPORT_SYMBOL_GPL(blk_req_needs_zone_write_lock);
 
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 06caacd77ed6..937493249aae 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -1164,6 +1164,18 @@ static inline unsigned int blk_rq_zone_is_seq(struct request *rq)
 	return disk_zone_is_seq(rq->q->disk, blk_rq_pos(rq));
 }
 
+/**
+ * blk_rq_is_seq_zoned_write() - Check if @rq requires write serialization.
+ * @rq: Request to examine.
+ *
+ * Note: REQ_OP_ZONE_APPEND requests do not require serialization.
+ */
+static inline bool blk_rq_is_seq_zoned_write(struct request *rq)
+{
+	return op_needs_zoned_write_locking(req_op(rq)) &&
+		blk_rq_zone_is_seq(rq);
+}
+
 bool blk_req_needs_zone_write_lock(struct request *rq);
 bool blk_req_zone_write_trylock(struct request *rq);
 void __blk_req_zone_write_lock(struct request *rq);
@@ -1194,6 +1206,11 @@ static inline bool blk_req_can_dispatch_to_zone(struct request *rq)
 	return !blk_req_zone_is_write_locked(rq);
 }
 #else /* CONFIG_BLK_DEV_ZONED */
+static inline bool blk_rq_is_seq_zoned_write(struct request *rq)
+{
+	return false;
+}
+
 static inline bool blk_req_needs_zone_write_lock(struct request *rq)
 {
 	return false;
