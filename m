Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3EDEC76196
	for <linux-block@archiver.kernel.org>; Fri,  7 Apr 2023 23:58:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbjDGX6t (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Apr 2023 19:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjDGX6s (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Apr 2023 19:58:48 -0400
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D68D4EFB6
        for <linux-block@vger.kernel.org>; Fri,  7 Apr 2023 16:58:45 -0700 (PDT)
Received: by mail-pl1-f175.google.com with SMTP id q2so5069934pll.7
        for <linux-block@vger.kernel.org>; Fri, 07 Apr 2023 16:58:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680911925; x=1683503925;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dTHZLSnxhEyvXySdFXAQP4I/WDGyYr95vE3AK3qZWvI=;
        b=b5NTHx+KFveBiKv3RqkGt5HmXBRahrpCEH3zDbNHVjlUAlICBWT9YsYpkV7ZiskDIe
         QrTvGr6aYje8MPy2oLUgSCvi1ZPdcGbew96SRlUA7+6WkqjXmKaLcwXPEavPHUVVDmny
         ytvcSoV6fms4sAduQlssELEa+yYlGNPWhPmmNm6b39EFsJMJLiJvjjx+GisXskmk3Bwz
         EujMs5yI3wm0rRdpOS3Mos4hysxYtOff6UQJMmgejtH1BJm0DWMyiShzHz/e4pA4WUX+
         oY8zCJbmU3tOp7J6njy+zJ7uu60uJBsh3dVjkFOcUEwApsYRdkN8BnJNDV+Jeq1AJJat
         bXPg==
X-Gm-Message-State: AAQBX9dsdTRiub+8jeRyU5f50ZtLZsPOboxTuXdYHwIsFmS9x4tUEDBA
        tVKmHG0UatB+0j9ALHGWL4s=
X-Google-Smtp-Source: AKy350Z/R77DsAWDh3N9mtwsvcHl561OvsSxZQhncpp/DFG3/c5y6gE6ym9sypmjARXQnqMDpiTOyA==
X-Received: by 2002:a05:6a20:29a4:b0:d9:2818:44d with SMTP id f36-20020a056a2029a400b000d92818044dmr3232465pzh.11.1680911925381;
        Fri, 07 Apr 2023 16:58:45 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:f2c:4ac2:6000:5900])
        by smtp.gmail.com with ESMTPSA id j16-20020a62e910000000b006258dd63a3fsm3556003pfh.56.2023.04.07.16.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 16:58:45 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>
Subject: [PATCH v2 04/12] block: Requeue requests if a CPU is unplugged
Date:   Fri,  7 Apr 2023 16:58:14 -0700
Message-Id: <20230407235822.1672286-5-bvanassche@acm.org>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
In-Reply-To: <20230407235822.1672286-1-bvanassche@acm.org>
References: <20230407235822.1672286-1-bvanassche@acm.org>
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
index 57315395434b..77fdaed4e074 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3495,9 +3495,17 @@ static int blk_mq_hctx_notify_dead(unsigned int cpu, struct hlist_node *node)
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
