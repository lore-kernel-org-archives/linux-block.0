Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 298D8C433EF
	for <linux-block@archiver.kernel.org>; Wed, 29 Jun 2022 23:32:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbiF2XcW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Jun 2022 19:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231580AbiF2XcU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jun 2022 19:32:20 -0400
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4A8B31F
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 16:32:19 -0700 (PDT)
Received: by mail-pl1-f171.google.com with SMTP id x20so9875288plx.6
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 16:32:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EOHw2Ela6ONVG3cG7sxun53FEDew2jp8yf1pgz8H1xk=;
        b=NnJQU/2+x4IxF2Rcnx2ugP3cjlutVJ1I3PA9zgEMVjz2bNcUkKSciNDahCMktcE/XK
         O++RKV4hLz8R5GKa2h8FbNoadI5MF5yvXFSlkhp6BdoGWWgoqWdSVCGYCDGTkOTMEIwH
         QeiKPHLD6P8scHe7mXbgFS7OFsHuDnXe9/8SLScCP+ZKG3NkrefsRd4AKV6hhGQuT1rk
         l+gZbZqcxo+ZACDqHkvqVL/xxlNBhz6gvrCvKqrm6QmTBj+pTGXJtmKlMH6ij1M8Sn9J
         +nBl7XyCMQpq1ePIy5Oev7OZHMCKwwLhE5mzB7tALQzmTFyYD/c/VjSQiWZ4E6Jg30Bd
         D0Mg==
X-Gm-Message-State: AJIora+upthRp8Pt5O83k+MwUgStYsQBjzynel7+XqO4Sne5Z7ZQHx99
        n85C7xw0ooQWZP/Gk9tL3AA=
X-Google-Smtp-Source: AGRyM1vUrsZUVVQVJ87lw0TqsfMxl89LiZAsE5wKbfoBIqWWuC+x8YZZupp2XWcVBwPtA5M5pueMQA==
X-Received: by 2002:a17:90b:1e4f:b0:1ed:4837:5f94 with SMTP id pi15-20020a17090b1e4f00b001ed48375f94mr8404558pjb.68.1656545539197;
        Wed, 29 Jun 2022 16:32:19 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:3841:49ce:cba5:1586])
        by smtp.gmail.com with ESMTPSA id b21-20020a17090a8c9500b001ec8d191db4sm2763687pjo.17.2022.06.29.16.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 16:32:18 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        "Md . Haris Iqbal" <haris.iqbal@ionos.com>,
        Jack Wang <jinpu.wang@ionos.com>
Subject: [PATCH v2 16/63] block/rnbd: Use blk_opf_t where appropriate
Date:   Wed, 29 Jun 2022 16:30:58 -0700
Message-Id: <20220629233145.2779494-17-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220629233145.2779494-1-bvanassche@acm.org>
References: <20220629233145.2779494-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Improve static type checking by using the new blk_opf_t type to represent
the combination of a request and request flags.

Cc: Md. Haris Iqbal <haris.iqbal@ionos.com>
Cc: Jack Wang <jinpu.wang@ionos.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/rnbd/rnbd-proto.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-proto.h b/drivers/block/rnbd/rnbd-proto.h
index bfb08dd434d1..ea7ac8bca63c 100644
--- a/drivers/block/rnbd/rnbd-proto.h
+++ b/drivers/block/rnbd/rnbd-proto.h
@@ -229,9 +229,9 @@ static inline bool rnbd_flags_supported(u32 flags)
 	return true;
 }
 
-static inline u32 rnbd_to_bio_flags(u32 rnbd_opf)
+static inline blk_opf_t rnbd_to_bio_flags(u32 rnbd_opf)
 {
-	u32 bio_opf;
+	blk_opf_t bio_opf;
 
 	switch (rnbd_op(rnbd_opf)) {
 	case RNBD_OP_READ:
@@ -286,7 +286,8 @@ static inline u32 rq_to_rnbd_flags(struct request *rq)
 		break;
 	default:
 		WARN(1, "Unknown request type %d (flags %llu)\n",
-		     req_op(rq), (unsigned long long)rq->cmd_flags);
+		     (__force u32)req_op(rq),
+		     (__force unsigned long long)rq->cmd_flags);
 		rnbd_opf = 0;
 	}
 
