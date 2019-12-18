Return-Path: <SRS0=ocaT=2I=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F3A6C43603
	for <linux-block@archiver.kernel.org>; Wed, 18 Dec 2019 00:23:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BD1D2176D
	for <linux-block@archiver.kernel.org>; Wed, 18 Dec 2019 00:23:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbfLRAXg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 Dec 2019 19:23:36 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39793 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbfLRAXg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Dec 2019 19:23:36 -0500
Received: by mail-pg1-f196.google.com with SMTP id b137so225634pga.6
        for <linux-block@vger.kernel.org>; Tue, 17 Dec 2019 16:23:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N9W9yUgcvKXs4XHF/mDXHZmrLG54A/evsL0mHnPR1C0=;
        b=mlTTy1jSwat8ctyDdTjpdvkAXOBeSvczfN9dex17Y3tGR4BA1qzsCx/1aL6CdPQgbi
         oFwX+qeT9OThY+/LF8vm8a0x4jUMEsaMMNOXGnDjaDrXstWdvYEpXp9XUG1CTdTi9GVU
         mbQ13DGnKs/7ic6f+nexsiAE8tF8sKnccgKCtmNHfnLxP+CY4XdJTdrmc14MnjMRMwrO
         9U5O6IhKOGINWHzBFrPyzQ01PbrwLmIc1pEXEowuR89SRNGXajR/qDKY2wnle8SHbTjE
         UbfvMcCozcyExM1lgoBwzIX5VXiDXKZNDBR8UfopmPh3T/SW4mnPBVZVP1boGaUYdSDY
         MXcg==
X-Gm-Message-State: APjAAAW8Y3fd82317RA0z89JdnyPKErdrmZAMZ7+XPaIgAmeC9VnE/6b
        DSivA/Xs1/AiuQ0Y9l5MnUqXl9cT
X-Google-Smtp-Source: APXvYqwA/yupulEfnBfB3pMusNExMBAXLCgZ0WR+4SnviYoRmo/j+URwtePCThkmx3kDO017rnVscg==
X-Received: by 2002:a63:483:: with SMTP id 125mr136324pge.217.1576628615796;
        Tue, 17 Dec 2019 16:23:35 -0800 (PST)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id r62sm218177pfc.89.2019.12.17.16.23.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 16:23:35 -0800 (PST)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Martin Wilck <mwilck@suse.com>
Subject: [PATCH] block: Fix the type of 'sts' in bsg_queue_rq()
Date:   Tue, 17 Dec 2019 16:23:29 -0800
Message-Id: <20191218002329.48593-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch fixes the following sparse warnings:

block/bsg-lib.c:269:19: warning: incorrect type in initializer (different base types)
block/bsg-lib.c:269:19:    expected int sts
block/bsg-lib.c:269:19:    got restricted blk_status_t [usertype]
block/bsg-lib.c:286:16: warning: incorrect type in return expression (different base types)
block/bsg-lib.c:286:16:    expected restricted blk_status_t
block/bsg-lib.c:286:16:    got int [assigned] sts

Cc: Martin Wilck <mwilck@suse.com>
Fixes: d46fe2cb2dce ("block: drop device references in bsg_queue_rq()")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/bsg-lib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/bsg-lib.c b/block/bsg-lib.c
index 347dda16c2f4..6cbb7926534c 100644
--- a/block/bsg-lib.c
+++ b/block/bsg-lib.c
@@ -266,7 +266,7 @@ static blk_status_t bsg_queue_rq(struct blk_mq_hw_ctx *hctx,
 	struct request *req = bd->rq;
 	struct bsg_set *bset =
 		container_of(q->tag_set, struct bsg_set, tag_set);
-	int sts = BLK_STS_IOERR;
+	blk_status_t sts = BLK_STS_IOERR;
 	int ret;
 
 	blk_mq_start_request(req);
