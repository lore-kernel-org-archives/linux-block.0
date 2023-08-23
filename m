Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D99FAEE49A0
	for <linux-block@archiver.kernel.org>; Wed, 23 Aug 2023 09:15:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235067AbjHWJPM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Aug 2023 05:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235080AbjHWJMS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Aug 2023 05:12:18 -0400
Received: from out-23.mta0.migadu.com (out-23.mta0.migadu.com [91.218.175.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7881D10D2
        for <linux-block@vger.kernel.org>; Wed, 23 Aug 2023 02:05:14 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1692781513;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P8W3+vOTfQOXGit1QxzQtrjlMaY4uGL5zXFxfZ2DGWU=;
        b=fWrqr/S0/e4dZQuGdBtg4BfFmNqU/bFbd22dl9t+Ol5yQhPg1xah8tecQmTMQIeGxnlrv0
        cKOvwaJWF4u0MV250xC4QZuQm3Gs3MHY6nCswSWlrqeWqn16rz0wcGlkQ86xFWRz4k1ZDs
        JHzl+eGBLrLt0Z6OuDoxm4PwDBgxoXI=
From:   chengming.zhou@linux.dev
To:     axboe@kernel.dk, ming.lei@redhat.com, bvanassche@acm.org,
        hch@lst.de
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhouchengming@bytedance.com
Subject: [PATCH v2 4/6] blk-mq: delete superfluous check in iterate callback
Date:   Wed, 23 Aug 2023 17:04:39 +0800
Message-ID: <20230823090441.3986631-5-chengming.zhou@linux.dev>
In-Reply-To: <20230823090441.3986631-1-chengming.zhou@linux.dev>
References: <20230823090441.3986631-1-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Chengming Zhou <zhouchengming@bytedance.com>

The previous patch in this series changed the behavior of
blk_mq_queue_tag_busy_iter() from iterating over all allocated tags into
iterating over started requests only. Leave out the code from
blk_mq_rq_inflight() that became superfluous because of this change.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 block/blk-mq.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 953f08354c8c..f1bafbae0a61 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1516,19 +1516,15 @@ EXPORT_SYMBOL(blk_mq_delay_kick_requeue_list);
 
 static bool blk_mq_rq_inflight(struct request *rq, void *priv)
 {
+	bool *busy = priv;
+
 	/*
 	 * If we find a request that isn't idle we know the queue is busy
 	 * as it's checked in the iter.
 	 * Return false to stop the iteration.
 	 */
-	if (blk_mq_request_started(rq)) {
-		bool *busy = priv;
-
-		*busy = true;
-		return false;
-	}
-
-	return true;
+	*busy = true;
+	return false;
 }
 
 bool blk_mq_queue_inflight(struct request_queue *q)
-- 
2.41.0

