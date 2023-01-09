Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B85FBC54EBD
	for <linux-block@archiver.kernel.org>; Mon,  9 Jan 2023 23:28:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237884AbjAIX2I (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Jan 2023 18:28:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237913AbjAIX1u (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Jan 2023 18:27:50 -0500
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B56DFB49B
        for <linux-block@vger.kernel.org>; Mon,  9 Jan 2023 15:27:49 -0800 (PST)
Received: by mail-pg1-f172.google.com with SMTP id r18so6984562pgr.12
        for <linux-block@vger.kernel.org>; Mon, 09 Jan 2023 15:27:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S0TPuowUZcajvA95Bw/M67Fj3nH+Km848JrYffvVSDE=;
        b=thYOdn5GiEAlvvis5b1I/5hhIpMl1Q8Hhk1YXdu9xiGwF3bsaIYj0lVMzEOF9yFpPy
         yC5eApuYdrDR2Lr3jhq1Ip9sBB+poc5ffmckgsd9/LLA8kyBM7fBRg7Ywv8wec6BxC9d
         9Ha7tSkNdIOjW2R/OE5iM7N3BftS0LyqGQDBEXfTwxtA6SDmF8ak8CRQ7d6XmsALPOUl
         UaquO98wDQVVNhviKMBzpEwl8blBF6A2tf9vZf9XnSS3+ImEffp1qACZcjozv+tmFbo7
         ljhCIX6Wm/5wJyuMgp7a4iqloiuUfvobZI8B6uPENEnPUxTFLlQaSrmZD9l+6sIagoBi
         z2dg==
X-Gm-Message-State: AFqh2kqksIFyF5O4TpBF6bd6RTbfPVdhZazqxugGT7O/D174i0IWApcM
        qFSOCmdhKTFBOJeSYsqNz4c=
X-Google-Smtp-Source: AMrXdXvSb5pCqIkemxqgh4iJXcnMha6vtPPZTQvQPVIPql+NIa9oifXL73a6g2CQglcJMVnnsXNl0w==
X-Received: by 2002:a05:6a00:d2:b0:588:22ad:2928 with SMTP id e18-20020a056a0000d200b0058822ad2928mr5741993pfj.3.1673306869201;
        Mon, 09 Jan 2023 15:27:49 -0800 (PST)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:9f06:14dd:484f:e55c])
        by smtp.gmail.com with ESMTPSA id s2-20020a625e02000000b0057ef155103asm5032244pfb.155.2023.01.09.15.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 15:27:48 -0800 (PST)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: [PATCH 2/8] block: Introduce the blk_rq_is_seq_zone_write() function
Date:   Mon,  9 Jan 2023 15:27:32 -0800
Message-Id: <20230109232738.169886-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
In-Reply-To: <20230109232738.169886-1-bvanassche@acm.org>
References: <20230109232738.169886-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Introduce a function that makes it easy to verify whether a write
request is for a sequential write required or sequential write preferred
zone.

Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 include/linux/blk-mq.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 6735db1ad24d..29f834e5c3a9 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -1167,6 +1167,24 @@ static inline unsigned int blk_rq_zone_is_seq(struct request *rq)
 	return disk_zone_is_seq(rq->q->disk, blk_rq_pos(rq));
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
@@ -1197,6 +1215,11 @@ static inline bool blk_req_can_dispatch_to_zone(struct request *rq)
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
