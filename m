Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEFF8C77B7E
	for <linux-block@archiver.kernel.org>; Tue, 18 Apr 2023 22:40:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbjDRWk1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Apr 2023 18:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232681AbjDRWkX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Apr 2023 18:40:23 -0400
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 386D493E4
        for <linux-block@vger.kernel.org>; Tue, 18 Apr 2023 15:40:12 -0700 (PDT)
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-63b73203e0aso12172382b3a.1
        for <linux-block@vger.kernel.org>; Tue, 18 Apr 2023 15:40:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681857611; x=1684449611;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V5JB4ZNYPPKiOFWoJNfkhNFu9XV3lVyy0nfKwRV+Z6o=;
        b=gaP6NVedSDIsWWzGBIh3KsS2iCYTppVxDXpA5ZRV6dtr+PwqRETEFF4TYUde+j98PY
         l4BJ6fijnmZKAPuVhJy/yx6JNkwzPcMBt4bqk+nnTQWqWiiGwL76odjU6CL6i7Q0Zemc
         OrDmj7sTq+NS10wFoNq691KbvOoKkDhepH1JR2lMkrzxZwDgSk13lkduI+mTNv+SY1I9
         zQTW2GSVCTeAMEIoZXsTiClo6Rg6tY6/AUzZ87tfPj+X4s31q/xwtOdB4HVnLusp7kiI
         TUiGm25wky5doGq9e4tcyANiiIwqlsB0XANfny+IlPWE908NlMTSa53qwSZSNaWDqXee
         kRXA==
X-Gm-Message-State: AAQBX9eX8rkaRcvEilVyua7YpLxRquWV77Wz2BCSVRTS+V18p/4c5tP4
        mMpldlqQWTZwn9R4kOolN+A=
X-Google-Smtp-Source: AKy350YgepGuT92qJw0DsQu6wMD9lLwiBV+UwAzkQumo18ElVZQfgUlYM6fltvUKwX4n66A4kpFZOA==
X-Received: by 2002:a17:902:e5c5:b0:1a6:48e6:ea8e with SMTP id u5-20020a170902e5c500b001a648e6ea8emr420764plf.4.1681857611694;
        Tue, 18 Apr 2023 15:40:11 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:5d9b:263d:206c:895a])
        by smtp.gmail.com with ESMTPSA id bb6-20020a170902bc8600b001a4ee93efa2sm8285646plb.137.2023.04.18.15.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 15:40:11 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v2 03/11] block: Introduce blk_rq_is_seq_zoned_write()
Date:   Tue, 18 Apr 2023 15:39:54 -0700
Message-ID: <20230418224002.1195163-4-bvanassche@acm.org>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
In-Reply-To: <20230418224002.1195163-1-bvanassche@acm.org>
References: <20230418224002.1195163-1-bvanassche@acm.org>
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
 block/blk-zoned.c      | 25 +++++++++++++++++++++----
 include/linux/blk-mq.h |  6 ++++++
 2 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index c93a26ce4670..9b9cd6adfd1b 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -52,6 +52,26 @@ const char *blk_zone_cond_str(enum blk_zone_cond zone_cond)
 }
 EXPORT_SYMBOL_GPL(blk_zone_cond_str);
 
+/**
+ * blk_rq_is_seq_zoned_write() - Whether @rq is a zoned write for which the order matters.
+ * @rq: Request to examine.
+ *
+ * In this context sequential zone means either a sequential write required or
+ * to a sequential write preferred zone.
+ */
+bool blk_rq_is_seq_zoned_write(struct request *rq)
+{
+	switch (req_op(rq)) {
+	case REQ_OP_WRITE:
+	case REQ_OP_WRITE_ZEROES:
+		return blk_rq_zone_is_seq(rq);
+	case REQ_OP_ZONE_APPEND:
+	default:
+		return false;
+	}
+}
+EXPORT_SYMBOL_GPL(blk_rq_is_seq_zoned_write);
+
 /*
  * Return true if a request is a write requests that needs zone write locking.
  */
@@ -60,10 +80,7 @@ bool blk_req_needs_zone_write_lock(struct request *rq)
 	if (!rq->q->disk->seq_zones_wlock)
 		return false;
 
-	if (queue_op_is_zoned_write(rq->q, req_op(rq)))
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
