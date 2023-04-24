Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E02C7618E
	for <linux-block@archiver.kernel.org>; Mon, 24 Apr 2023 20:33:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232615AbjDXUdn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Apr 2023 16:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232620AbjDXUdm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Apr 2023 16:33:42 -0400
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1161955AF
        for <linux-block@vger.kernel.org>; Mon, 24 Apr 2023 13:33:38 -0700 (PDT)
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-63b70f0b320so6661241b3a.1
        for <linux-block@vger.kernel.org>; Mon, 24 Apr 2023 13:33:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682368417; x=1684960417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hPXsN9StPRxhLtrCrqF+PfLLPQj82OhYioJmH8NV21o=;
        b=Lo0WUvx8a2u2t2fz9NSxHmfKmBYnsB1SZeTK0nVB/kgJuAdjHmTAsskKKKIrnQeisS
         Y0KWZ7VTPFsigno7ZDmbU2m9nk4PorGOd/awhKsfWC18OfcMc9BkjTzLZztpJEjW08OF
         NdIWaFUBK6E0J6QAKIhm4My8XbSw0Y+qM4HM9QunJ5rb9wDthO5o+DsM+cERgOOESfEV
         rErizJR+MdTL22u0KaKhpryf+jpItDYW2m5wxgKi6gtb27ePi+EN9HuOw2wZLMSUcRNn
         CXngvxGPrehtpwN0/sQp4a360FQYmt83bB1GyaxKA5OrUnGCSvKLhHnYu/ZFAnYXQmYH
         L5/w==
X-Gm-Message-State: AAQBX9egfGCp2DpHABL/vF4lVGg3oupiwgPlK1BMaxfcbQtUMcFNkaok
        XCYN0DQbzRvoRQFecsG9Q0tulqzC7qQ=
X-Google-Smtp-Source: AKy350blhO/jAd+gSLD64QSww/xT4cunqZwUum8e3KvF5uXtlgQV2tSglP4sbYa1vPncHXDqPPm9iw==
X-Received: by 2002:a05:6a00:2e0d:b0:63b:7119:64a9 with SMTP id fc13-20020a056a002e0d00b0063b711964a9mr21302100pfb.16.1682368417517;
        Mon, 24 Apr 2023 13:33:37 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:56cb:b39a:c8b:8c37])
        by smtp.gmail.com with ESMTPSA id k16-20020aa788d0000000b00625616f59a1sm7417505pff.73.2023.04.24.13.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 13:33:37 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v3 3/9] block: Introduce blk_rq_is_seq_zoned_write()
Date:   Mon, 24 Apr 2023 13:33:23 -0700
Message-ID: <20230424203329.2369688-4-bvanassche@acm.org>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
In-Reply-To: <20230424203329.2369688-1-bvanassche@acm.org>
References: <20230424203329.2369688-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Introduce the function blk_rq_is_seq_zoned_write(). This function will
be used in later patches to preserve the order of zoned writes for which
the order needs to be preserved.

Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-zoned.c      | 22 +++++++++++++++++++---
 include/linux/blk-mq.h |  6 ++++++
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 4640b75ae66f..78c39fc505bc 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -52,15 +52,31 @@ const char *blk_zone_cond_str(enum blk_zone_cond zone_cond)
 }
 EXPORT_SYMBOL_GPL(blk_zone_cond_str);
 
+/**
+ * blk_rq_is_seq_zoned_write() - Check if @rq requires write serialization.
+ * @rq: Request to examine.
+ *
+ * Note: REQ_OP_ZONE_APPEND requests do not require serialization.
+ */
+bool blk_rq_is_seq_zoned_write(struct request *rq)
+{
+	switch (req_op(rq)) {
+	case REQ_OP_WRITE:
+	case REQ_OP_WRITE_ZEROES:
+		return blk_rq_zone_is_seq(rq);
+	default:
+		return false;
+	}
+}
+EXPORT_SYMBOL_GPL(blk_rq_is_seq_zoned_write);
+
 /*
  * Return true if a request is a write requests that needs zone write locking.
  */
 bool blk_req_needs_zone_write_lock(struct request *rq)
 {
 	return rq->q->disk->seq_zones_wlock &&
-		(req_op(rq) == REQ_OP_WRITE ||
-		 req_op(rq) == REQ_OP_WRITE_ZEROES) &&
-		blk_rq_zone_is_seq(rq);
+		blk_rq_is_seq_zoned_write(rq);
 }
 EXPORT_SYMBOL_GPL(blk_req_needs_zone_write_lock);
 
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 06caacd77ed6..e498b85bc470 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -1164,6 +1164,7 @@ static inline unsigned int blk_rq_zone_is_seq(struct request *rq)
 	return disk_zone_is_seq(rq->q->disk, blk_rq_pos(rq));
 }
 
+bool blk_rq_is_seq_zoned_write(struct request *rq);
 bool blk_req_needs_zone_write_lock(struct request *rq);
 bool blk_req_zone_write_trylock(struct request *rq);
 void __blk_req_zone_write_lock(struct request *rq);
@@ -1194,6 +1195,11 @@ static inline bool blk_req_can_dispatch_to_zone(struct request *rq)
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
