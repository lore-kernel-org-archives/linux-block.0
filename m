Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9517C76196
	for <linux-block@archiver.kernel.org>; Fri,  7 Apr 2023 00:17:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232254AbjDGAR3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Apr 2023 20:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237881AbjDGARZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Apr 2023 20:17:25 -0400
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A79A255
        for <linux-block@vger.kernel.org>; Thu,  6 Apr 2023 17:17:24 -0700 (PDT)
Received: by mail-pl1-f174.google.com with SMTP id w4so38849056plg.9
        for <linux-block@vger.kernel.org>; Thu, 06 Apr 2023 17:17:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680826644; x=1683418644;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MitvE+a1WFK76wqNn1WUiMU2nEet4MTVmJfoebGVEI0=;
        b=qoCwl70gZR+k/SIKX78e5F8ZID/Aj4NiR+XHGEhwJQL1q0dWgSV7LHCgnaFmY8/k/X
         68aUEvICMss+fg2lyJdaYeuAxUPRv+UTQlJ0gGU93rQraRRbINtG84ylJ2ctIc8qc8Pf
         7g4R6frxCYqR/XS3L+VZy27hGP1EjjaO+25g+xKXtNCCqVkekNl3p0XfhJJPhDl43UJ7
         a2OjpuBCCR1gg4JDOWUNdNR+rUu4j7wit34McHx7XWIiCPtC+TNaDlYq7BojKwPKclBV
         8UpflAxmERv2lacHVIRJ4yY+c5yPbycHlMu3/wtlzdbqyjFlw+rfv8oei7VGDi3um22c
         Qpxg==
X-Gm-Message-State: AAQBX9cvweArGCTg5zMqcWN1UBWMe0NtTE808JKBUqzpcPjqPbkTJBRG
        O9pWYuPoa8fTFJ1CqXIRZDY=
X-Google-Smtp-Source: AKy350YSWGEzFu1obHqjjZkMJXnKta2yoYu9j4b2nhDb8+vryke7QF1d2mVK4fVjTHySOci0/PEWLw==
X-Received: by 2002:a17:903:18b:b0:19f:188c:3e34 with SMTP id z11-20020a170903018b00b0019f188c3e34mr927018plg.53.1680826643848;
        Thu, 06 Apr 2023 17:17:23 -0700 (PDT)
Received: from bvanassche-glaptop2.roam.corp.google.com ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id x9-20020a1709028ec900b0019a773419a6sm1873676plo.170.2023.04.06.17.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 17:17:23 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 07/12] block: Make it easier to debug zoned write reordering
Date:   Thu,  6 Apr 2023 17:17:05 -0700
Message-Id: <20230407001710.104169-8-bvanassche@acm.org>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
In-Reply-To: <20230407001710.104169-1-bvanassche@acm.org>
References: <20230407001710.104169-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Issue a kernel warning if reordering could happen.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-mq.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 2cf317d49f56..07426dbbe720 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2480,6 +2480,8 @@ void blk_mq_request_bypass_insert(struct request *rq, bool at_head,
 {
 	struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
 
+	WARN_ON_ONCE(rq->q->elevator && blk_rq_is_seq_zoned_write(rq));
+
 	spin_lock(&hctx->lock);
 	if (at_head)
 		list_add(&rq->queuelist, &hctx->dispatch);
@@ -2572,6 +2574,8 @@ static blk_status_t __blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 	bool run_queue = true;
 	int budget_token;
 
+	WARN_ON_ONCE(q->elevator && blk_rq_is_seq_zoned_write(rq));
+
 	/*
 	 * RCU or SRCU read lock is needed before checking quiesced flag.
 	 *
