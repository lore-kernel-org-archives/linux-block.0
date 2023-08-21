Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87284EE4996
	for <linux-block@archiver.kernel.org>; Mon, 21 Aug 2023 07:41:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233805AbjHUHl7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Aug 2023 03:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233790AbjHUHlx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Aug 2023 03:41:53 -0400
Received: from out-58.mta0.migadu.com (out-58.mta0.migadu.com [91.218.175.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E12E4E2
        for <linux-block@vger.kernel.org>; Mon, 21 Aug 2023 00:41:49 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1692603708;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e7XmU4eBUseJwLDn+i68ugkxvRTXytLdSl9ghJWat70=;
        b=b4ZGRggoaSZQI8UfzuJIRD+MWsBzUuPhBcnbgQUBm3AJRLLdDNR03g/dhILzom91MP3smc
        9jixlYj5LzBmuIt4IdWkhcxzr7tdhLkRNZxqLjFQn/gXsdwSOnEgTADz6cWuWazpdqTCKw
        58MNPP80cuNT/bmVla+JT9sJ0BtDrQ8=
From:   chengming.zhou@linux.dev
To:     axboe@kernel.dk, ming.lei@redhat.com, hch@lst.de,
        bvanassche@acm.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhouchengming@bytedance.com
Subject: [PATCH 3/4] blk-mq: delete superfluous check in iterate callback
Date:   Mon, 21 Aug 2023 15:35:27 +0800
Message-ID: <20230821073528.3469210-4-chengming.zhou@linux.dev>
In-Reply-To: <20230821073528.3469210-1-chengming.zhou@linux.dev>
References: <20230821073528.3469210-1-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Chengming Zhou <zhouchengming@bytedance.com>

The blk_mq_queue_tag_busy_iter() already has BT_TAG_ITER_STARTED flag
filter set, only started requests will be iterated over.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 block/blk-mq.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index f14b8669ac69..0b03963e0854 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1496,19 +1496,15 @@ EXPORT_SYMBOL(blk_mq_delay_kick_requeue_list);
 
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

