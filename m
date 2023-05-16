Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBB1EC77B7F
	for <linux-block@archiver.kernel.org>; Tue, 16 May 2023 17:34:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbjEPReh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 May 2023 13:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231639AbjEPReg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 May 2023 13:34:36 -0400
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BB3DC9
        for <linux-block@vger.kernel.org>; Tue, 16 May 2023 10:34:35 -0700 (PDT)
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1ae3c204e0aso6719875ad.2
        for <linux-block@vger.kernel.org>; Tue, 16 May 2023 10:34:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684258474; x=1686850474;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P5mgTzbY35hz66Qyd3QHtRcs/f/s3y6HjAxJD0HqNcI=;
        b=Ei4bpER1ADNpaAGq0S3kFvE344DBpHg9JS3blXE5j5wWc7ZsAi0HJvJrH2t0GFguTx
         Z6dPJcGyqnR9ymlSW9ZOGJ+XPKFMs9TFL44wzdUqFWGljwKIzOYuoB9w1exs/X8UybpO
         PuVD7rBLZRESYunePIEmm5JzzQHzBYKRJUlzKv/K60RTyybpUnTxgS3Iw3E/6L3ZXKH2
         rHa65BpnjdnHDSBGNHTt06GiobVuXib/akVhP3y7PvERVNT0fgomT4S3CMB/Dz0Poytb
         DgF/R0SlEkp0IMXu8No6SbAURMwJ1rMdPbPO/KjiNnnI0Pe9chV3KIKPHeLS2Jawkafl
         DNWA==
X-Gm-Message-State: AC+VfDwLZK04yK/uNS47ZhMQNEWrpE9k81Stf/Bu0lTxP98Z/Bd36x7K
        9dCAnCr8vCXU1nR+K3Kqb/o=
X-Google-Smtp-Source: ACHHUZ5VQEcKY/QJ/vZsNfaOXwH2WC1BkutE8/pU0z5zpzGYv2OOmeLt1dqyiL6NWVjOjz7Na8lKag==
X-Received: by 2002:a17:902:da8f:b0:1aa:e739:4092 with SMTP id j15-20020a170902da8f00b001aae7394092mr51945725plx.52.1684258474596;
        Tue, 16 May 2023 10:34:34 -0700 (PDT)
Received: from bvanassche-glaptop2.corp.google.com ([2620:0:1000:2514:b2f2:d6ed:29b8:214])
        by smtp.gmail.com with ESMTPSA id d10-20020a170902854a00b001a6e5c2ebfesm15780544plo.152.2023.05.16.10.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 10:34:33 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH] block: Decode all flag names in the debugfs output
Date:   Tue, 16 May 2023 10:34:26 -0700
Message-ID: <20230516173426.798414-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

See also:
* Commit 4d337cebcb1c ("blk-mq: avoid to touch q->elevator without any protection").
* Commit 414dd48e882c ("blk-mq: add tagset quiesce interface").

Cc: Christoph Hellwig <hch@lst.de>
Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-mq-debugfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index d23a8554ec4a..a0fd20b64a46 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -103,6 +103,8 @@ static const char *const blk_queue_flag_name[] = {
 	QUEUE_FLAG_NAME(RQ_ALLOC_TIME),
 	QUEUE_FLAG_NAME(HCTX_ACTIVE),
 	QUEUE_FLAG_NAME(NOWAIT),
+	QUEUE_FLAG_NAME(SQ_SCHED),
+	QUEUE_FLAG_NAME(SKIP_TAGSET_QUIESCE),
 };
 #undef QUEUE_FLAG_NAME
 
