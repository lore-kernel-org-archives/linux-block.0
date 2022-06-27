Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B36FDC43334
	for <linux-block@archiver.kernel.org>; Mon, 27 Jun 2022 23:43:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242257AbiF0Xnx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Jun 2022 19:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242320AbiF0Xnw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Jun 2022 19:43:52 -0400
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3AC713D5C
        for <linux-block@vger.kernel.org>; Mon, 27 Jun 2022 16:43:51 -0700 (PDT)
Received: by mail-pg1-f181.google.com with SMTP id 23so10510939pgc.8
        for <linux-block@vger.kernel.org>; Mon, 27 Jun 2022 16:43:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dVBXKDUUQfCpF8OMFSZm33rUgwa4FkPVmBE8uu4g8Is=;
        b=x6tS9OwMB1EMc6+4soMuI8Hn145YfIBOE4ct5eQTcdCDs75wEhMM7w/ATbOapNe34u
         WYGc0qCgbyEdLNuXmfQ8CzSGlq1I10fJl0x0Va0v5GlhvkSg1vOz0KE+DwFEZ69hY/O3
         dxma8vbZvhzLIG/EjgVdvFpVFTy37DWHWVuEpvHgFGQIoPmdsYc2aguZBGEjosqfsF5+
         YcPdDlcVSraAuhQRWd+J0L/bQcNHqYMkZ6wXr1sE1sxBTHr35HE9UfiKTnibEPh8ECqU
         oXI06Paf8GrGu2iw8l8a8msaAaHtHzxIqeXe4Z6IBkYVXM+MBwr5HaSYfQPsZl8U1CHz
         lHug==
X-Gm-Message-State: AJIora8RDKeM2JWHpeGoOXF16dS/AZGNjog2wL/0BTSKks1bgk0qrumF
        UYo6L1lGkOjADwYghsX1hLA=
X-Google-Smtp-Source: AGRyM1u2BGr0oKNGwVeP3wFeXrpKPXeHZOEwZGXWH3cDEX+kFozVdiuipx7q9PE1CHDygfTptO8EKg==
X-Received: by 2002:a05:6a00:1c94:b0:527:c49a:3249 with SMTP id y20-20020a056a001c9400b00527c49a3249mr1339863pfw.18.1656373431259;
        Mon, 27 Jun 2022 16:43:51 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:3879:b18f:db0d:205])
        by smtp.gmail.com with ESMTPSA id md6-20020a17090b23c600b001e305f5cd22sm7907456pjb.47.2022.06.27.16.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 16:43:50 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@wdc.com>
Subject: [PATCH v3 2/8] block: Introduce the blk_rq_is_seq_zone_write() function
Date:   Mon, 27 Jun 2022 16:43:29 -0700
Message-Id: <20220627234335.1714393-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220627234335.1714393-1-bvanassche@acm.org>
References: <20220627234335.1714393-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Introduce a function that makes it easy to verify whether a write
request is for a sequential write required or sequential write preferred
zone. Simplify blk_req_needs_zone_write_lock() by using the new function.

Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-zoned.c      | 14 +-------------
 include/linux/blk-mq.h | 25 ++++++++++++++++++++++++-
 2 files changed, 25 insertions(+), 14 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 38cd840d8838..9da8cf1bb378 100644
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
+	return rq->q->seq_zones_wlock && blk_rq_is_seq_zone_write(rq);
 }
 EXPORT_SYMBOL_GPL(blk_req_needs_zone_write_lock);
 
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 909d47e34b7c..ccfcac9db879 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -1129,13 +1129,31 @@ static inline unsigned int blk_rq_zone_no(struct request *rq)
  * @rq: Request pointer.
  *
  * Return: true if and only if blk_rq_pos(@rq) refers either to a sequential
- * write required or a sequential write preferred zone.
+ * write required or to a sequential write preferred zone.
  */
 static inline unsigned int blk_rq_zone_is_seq(struct request *rq)
 {
 	return blk_queue_zone_is_seq(rq->q, blk_rq_pos(rq));
 }
 
+/**
+ * blk_rq_is_seq_zone_write() - Whether @rq is a write request for a sequential zone.
+ * @rq: Request to examine.
+ *
+ * In this context sequential zone means either a sequential write required or
+ * to a sequential write preferred zone.
+ */
+static inline bool blk_rq_is_seq_zone_write(struct request *rq)
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
+static inline bool blk_rq_is_seq_zone_write(struct request *rq)
+{
+	return false;
+}
+
 static inline bool blk_req_needs_zone_write_lock(struct request *rq)
 {
 	return false;
