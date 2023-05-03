Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47739C77B78
	for <linux-block@archiver.kernel.org>; Wed,  3 May 2023 22:52:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbjECWwV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 May 2023 18:52:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjECWwU (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 May 2023 18:52:20 -0400
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AE5B7D80
        for <linux-block@vger.kernel.org>; Wed,  3 May 2023 15:52:19 -0700 (PDT)
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1aaf70676b6so32389375ad.3
        for <linux-block@vger.kernel.org>; Wed, 03 May 2023 15:52:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683154338; x=1685746338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X1FERwJPWE0K365CHeTe4/kveRb+PbTQZ9v8otJCzHg=;
        b=QrIGOMWt0/HmX1SbXkw4R+9AtQx6NNftto8vSJeyZ7xz2mdw2tb1hKu3pUiGYQZbM8
         SZmdtf9lqD4YAHdx9rAXBqKWzbz5UjH1+YEJCi1DPAzU2jjrmnDGijTJoo/MK1Hr1tki
         mNjcY0CimSJnD7Aq9unXhidgN9PCVwz4VDfJhpgIn/i/qQyqSI+Wd5ySJ5CB/fxie/tJ
         DpP7qAFpvcLBtaO0/4rGOmfwieKdxQzZRkNR0hXrDf5D4/S5ncr98KDrrePQHBqedr9Z
         S0aqhYUEHT3Lr08kKxfsMQ2r3y5nbEapYOZAO/Q79231+hjnWXKeaERpcdqWJS4t8diB
         lscA==
X-Gm-Message-State: AC+VfDw3jq6tFmNBgFP+QcAP3aJGfXajz6gh1RhA8QWxp+1CequrPM28
        +8bA0GpWACVRjYSoGqUPwAEA3JWD/v4=
X-Google-Smtp-Source: ACHHUZ6+U7G7euj/CJJpwT1KKZQE8EbGRvux9XBMJCcPrpSRyGuMop/eINxCDvYOcFs7aFNAlDE3mw==
X-Received: by 2002:a17:902:7087:b0:1aa:fbaa:ee01 with SMTP id z7-20020a170902708700b001aafbaaee01mr1492882plk.48.1683154338395;
        Wed, 03 May 2023 15:52:18 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:2c3b:81e:ce21:2437])
        by smtp.gmail.com with ESMTPSA id e3-20020a170902744300b001aad4be4503sm227085plt.2.2023.05.03.15.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 15:52:18 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v4 04/11] block: Introduce blk_rq_is_seq_zoned_write()
Date:   Wed,  3 May 2023 15:52:01 -0700
Message-ID: <20230503225208.2439206-5-bvanassche@acm.org>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
In-Reply-To: <20230503225208.2439206-1-bvanassche@acm.org>
References: <20230503225208.2439206-1-bvanassche@acm.org>
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

Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-zoned.c      | 17 +++++++++++++----
 include/linux/blk-mq.h |  6 ++++++
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 835d9e937d4d..4f44b74ba4df 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -52,6 +52,18 @@ const char *blk_zone_cond_str(enum blk_zone_cond zone_cond)
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
+	return op_is_zoned_write(req_op(rq)) && blk_rq_zone_is_seq(rq);
+}
+EXPORT_SYMBOL_GPL(blk_rq_is_seq_zoned_write);
+
 /*
  * Return true if a request is a write requests that needs zone write locking.
  */
@@ -60,10 +72,7 @@ bool blk_req_needs_zone_write_lock(struct request *rq)
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
