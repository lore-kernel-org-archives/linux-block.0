Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C40E9C76196
	for <linux-block@archiver.kernel.org>; Fri,  7 Apr 2023 00:17:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbjDGARW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Apr 2023 20:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbjDGARV (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Apr 2023 20:17:21 -0400
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBAA89029
        for <linux-block@vger.kernel.org>; Thu,  6 Apr 2023 17:17:20 -0700 (PDT)
Received: by mail-pl1-f169.google.com with SMTP id n14so23009432plc.8
        for <linux-block@vger.kernel.org>; Thu, 06 Apr 2023 17:17:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680826640; x=1683418640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SUUWniA4uPgIfsv1JT2KAKD8sP6eQdC/K73aOS/Pwsg=;
        b=lKX1Al8EVMnulH7f8BfpUVwDJRRili9hRtSnw73JDoM9ctSjxYKblRNkuWpBsGNGgC
         KlcdISabZ+dHEIDDDlNjJoxtSsDzZoYxEKQyQ5sGhjkVBMpyEh60ZQRWdTSLa9n1rpfc
         S28ufh+ehznEEcZRNtw0mwG8Fx2lGLVrrl2CbalnWlnvDw/omA6F4im5jfeGeDNE7ahq
         qA3X6yEdLbl3+RLe3Ufkdl+0+tx6qy8oAG4l01mZIOhhnSqnS9aVx1j+nCgE4co1NBtT
         cftLteYMZzwxPa2z5EF5sT5mQjWgMQiwQdsKD5moqA38Of5of/gZEBg+uBmAlONiQhZH
         ezKQ==
X-Gm-Message-State: AAQBX9dR/lk8qAEORdWvva4CVzvQM7Q9TdxNOulYVvE9wy8JerSKZbPr
        qVpiJ/wqmqhz6ZFK8DAkUXw=
X-Google-Smtp-Source: AKy350b6ZvPR1mIH+NY2fWKKWmVbP8suS78IoYvOXmKGxX2FRk9OWiPhOYnATEnjz1JNWgdiiq33ZA==
X-Received: by 2002:a17:903:138b:b0:1a5:dfd:d16e with SMTP id jx11-20020a170903138b00b001a50dfdd16emr564991plb.42.1680826640248;
        Thu, 06 Apr 2023 17:17:20 -0700 (PDT)
Received: from bvanassche-glaptop2.roam.corp.google.com ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id x9-20020a1709028ec900b0019a773419a6sm1873676plo.170.2023.04.06.17.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 17:17:19 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 04/12] block: Requeue requests if a CPU is unplugged
Date:   Thu,  6 Apr 2023 17:17:02 -0700
Message-Id: <20230407001710.104169-5-bvanassche@acm.org>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
In-Reply-To: <20230407001710.104169-1-bvanassche@acm.org>
References: <20230407001710.104169-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Requeue requests instead of sending these to the dispatch list if a CPU
is unplugged to prevent reordering of zoned writes.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-mq.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index f6ffa76bc159..8bb35deff5ec 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3496,9 +3496,17 @@ static int blk_mq_hctx_notify_dead(unsigned int cpu, struct hlist_node *node)
 	if (list_empty(&tmp))
 		return 0;
 
-	spin_lock(&hctx->lock);
-	list_splice_tail_init(&tmp, &hctx->dispatch);
-	spin_unlock(&hctx->lock);
+	if (hctx->queue->elevator) {
+		struct request *rq, *next;
+
+		list_for_each_entry_safe(rq, next, &tmp, queuelist)
+			blk_mq_requeue_request(rq, false);
+		blk_mq_kick_requeue_list(hctx->queue);
+	} else {
+		spin_lock(&hctx->lock);
+		list_splice_tail_init(&tmp, &hctx->dispatch);
+		spin_unlock(&hctx->lock);
+	}
 
 	blk_mq_run_hw_queue(hctx, true);
 	return 0;
