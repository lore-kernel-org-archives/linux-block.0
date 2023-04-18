Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DE5DC77B76
	for <linux-block@archiver.kernel.org>; Tue, 18 Apr 2023 22:40:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232396AbjDRWk2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Apr 2023 18:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbjDRWkY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Apr 2023 18:40:24 -0400
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C009BA246
        for <linux-block@vger.kernel.org>; Tue, 18 Apr 2023 15:40:14 -0700 (PDT)
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-51b603bb360so881221a12.2
        for <linux-block@vger.kernel.org>; Tue, 18 Apr 2023 15:40:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681857614; x=1684449614;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QRIPRnJXdxDwvmScWEwNZSi3W/9tBQ9eOiqmVDtzpks=;
        b=LW2ZFSYr6QnOZNoAElrFigNM8AN8SuISufo5g2zZ8NVl4pEGUqVscPLAwll3Gaime0
         Y1kASuxqZr/c6VSnkPQwaenOMUmFn569HcthG2XZ93h9Ok46m+dKHDmtYsk2j4I6YHww
         7mPNQaW0SslqIYuaejAkwcs6brSQ2D5tmHBf/M230mpg/E4BKwAaWGCREzFY31+zZS22
         MTxanf7CeTEZewnIkNYyKu4akuWf5LBoaOxTjqH5RKziGnRO4urpenF/X+b8WriQ0Ugf
         tkDo0xJ9fEuNFTGLSB9nZSWXIegAvFx7iqoNwryt/+AXRzQpX/G0+0+iMGBNVCCS9CdF
         Y+VA==
X-Gm-Message-State: AAQBX9euYqFIokncZORKrf2gEKV3OghjJQXDTf7lgtsqzGLMCaThoKL9
        ryNj73NZ8oOxVbLpdPDyioQ=
X-Google-Smtp-Source: AKy350ZJbJhQRzbkZID4vbFwG6gtx6pf+Jn6kU5eaZjmbwWEBPJrAiSeJ1BOzkF7xC5HF3TjuZq3lQ==
X-Received: by 2002:a17:902:e881:b0:19a:9890:eac6 with SMTP id w1-20020a170902e88100b0019a9890eac6mr4157047plg.24.1681857614268;
        Tue, 18 Apr 2023 15:40:14 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:5d9b:263d:206c:895a])
        by smtp.gmail.com with ESMTPSA id bb6-20020a170902bc8600b001a4ee93efa2sm8285646plb.137.2023.04.18.15.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 15:40:13 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v2 05/11] block: mq-deadline: Improve deadline_skip_seq_writes()
Date:   Tue, 18 Apr 2023 15:39:56 -0700
Message-ID: <20230418224002.1195163-6-bvanassche@acm.org>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
In-Reply-To: <20230418224002.1195163-1-bvanassche@acm.org>
References: <20230418224002.1195163-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Make deadline_skip_seq_writes() do what its name suggests, namely to
skip sequential writes.

Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/mq-deadline.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 3dde720e2f59..4a0a269db382 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -311,7 +311,7 @@ static struct request *deadline_skip_seq_writes(struct deadline_data *dd,
 {
 	sector_t pos = blk_rq_pos(rq);
 
-	while (rq && blk_rq_pos(rq) == pos) {
+	while (rq && blk_rq_pos(rq) == pos && blk_rq_is_seq_zoned_write(rq)) {
 		pos += blk_rq_sectors(rq);
 		rq = deadline_latter_request(rq);
 	}
