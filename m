Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 806B4C77B61
	for <linux-block@archiver.kernel.org>; Mon, 24 Apr 2023 20:33:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232605AbjDXUdi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Apr 2023 16:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbjDXUdh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Apr 2023 16:33:37 -0400
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 808DC55AF
        for <linux-block@vger.kernel.org>; Mon, 24 Apr 2023 13:33:35 -0700 (PDT)
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-63b87d23729so4060408b3a.0
        for <linux-block@vger.kernel.org>; Mon, 24 Apr 2023 13:33:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682368415; x=1684960415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Meycj9u3JfaVnzaUnu3BPLSoAESUUt4GW23IhKc0tM8=;
        b=S5TN9v4lhNUu2ozRVhvy1rcn4CVaRTpqX3lrloIuUkMKuqYYGtH7Tx8wKaS/vWiun6
         U6igTQPM/3CfcgSz+o+EOKQWLI5TFxEMPzV3XMwt0yMJ9Y11ncS+te20HVgfNAcalCrS
         28WHzo5PBe9eahmmAnd+g85VnYyL1nLSfBAXBUo8jFjxy4zFBEqkkjbPfw2+ySAGn6UL
         BT+7SrZ5NGYCa7iMLdV1Jj+Y1gHkbN1BBzsxAYiIMmJS25YBnYlY7mOjOENwOUWhn9sC
         7n97RxUyxD4ECuZXX4l09m8nTBHxz1r+ZBIQTNOT0dv7QX4GeOvRUe/Y/qDalHJqsC9E
         aw+w==
X-Gm-Message-State: AAQBX9dIUqWfrdemVvRMyeT0T+7V3bRWXi5jQ+c3PLxUbrC2LJGXuY+H
        m1p85K/U0sFxO5CZ/Q1ywIc=
X-Google-Smtp-Source: AKy350ZpImJ7yn99lXYXaYrQ3W9Dko1JZyIBRUe4GrzXOgqV/CXWxdkqzZKdbq/aUAGu0rJtNa02Yg==
X-Received: by 2002:a05:6a00:b8a:b0:63d:23a7:ca62 with SMTP id g10-20020a056a000b8a00b0063d23a7ca62mr19807107pfj.19.1682368414921;
        Mon, 24 Apr 2023 13:33:34 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:56cb:b39a:c8b:8c37])
        by smtp.gmail.com with ESMTPSA id k16-20020aa788d0000000b00625616f59a1sm7417505pff.73.2023.04.24.13.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 13:33:34 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v3 1/9] block: Simplify blk_req_needs_zone_write_lock()
Date:   Mon, 24 Apr 2023 13:33:21 -0700
Message-ID: <20230424203329.2369688-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
In-Reply-To: <20230424203329.2369688-1-bvanassche@acm.org>
References: <20230424203329.2369688-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Remove the blk_rq_is_passthrough() check because it is redundant:
blk_req_needs_zone_write_lock() also calls bdev_op_is_zoned_write()
and the latter function returns false for pass-through requests.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-zoned.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index fce9082384d6..835d9e937d4d 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -57,9 +57,6 @@ EXPORT_SYMBOL_GPL(blk_zone_cond_str);
  */
 bool blk_req_needs_zone_write_lock(struct request *rq)
 {
-	if (blk_rq_is_passthrough(rq))
-		return false;
-
 	if (!rq->q->disk->seq_zones_wlock)
 		return false;
 
