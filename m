Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 431D4EE49B0
	for <linux-block@archiver.kernel.org>; Wed, 23 Aug 2023 15:19:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237064AbjHWPTk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Aug 2023 11:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237071AbjHWPTk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Aug 2023 11:19:40 -0400
Received: from out-58.mta0.migadu.com (out-58.mta0.migadu.com [IPv6:2001:41d0:1004:224b::3a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F8410F3
        for <linux-block@vger.kernel.org>; Wed, 23 Aug 2023 08:19:07 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1692803930;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NnJXNO1JJg46Pgz2uwGFQLPJgin8MHVM0Z0oQpK/Ils=;
        b=eFJLHhd/F2DztuBt0cyRg6BIPbShiPNNTS3SfVTStzqddN3W/dZ0S6bQXgHcIvdh4VUlKV
        0+BliTZk1isVG3Uo+hiNfCTfNJJhnftijFUysiij2S3kCEhGmD+9Z7AvkmuglTCgKwPFr5
        riqq1MolxjyCbSUMVeZ4t+j4HtdK0qs=
From:   chengming.zhou@linux.dev
To:     axboe@kernel.dk, ming.lei@redhat.com, bvanassche@acm.org,
        hch@lst.de
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhouchengming@bytedance.com
Subject: [PATCH v3 6/6] blk-mq-tag: fix blk_mq_queue_tag_busy_iter() documentation
Date:   Wed, 23 Aug 2023 23:18:03 +0800
Message-ID: <20230823151803.926382-7-chengming.zhou@linux.dev>
In-Reply-To: <20230823151803.926382-1-chengming.zhou@linux.dev>
References: <20230823151803.926382-1-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Chengming Zhou <zhouchengming@bytedance.com>

The blk_mq_queue_tag_busy_iter() is only used to iterate over reqeusts
of the specified queue, fix the documentation.

Fixes: c7b1bf5cca76 ("blk-mq: Document the functions that iterate over requests")
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 block/blk-mq-tag.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 0d42f3c4d76e..69b156750559 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -433,8 +433,7 @@ EXPORT_SYMBOL(blk_mq_tagset_wait_completed_request);
  * @priv:	Will be passed as second argument to @fn.
  *
  * Note: if @q->tag_set is shared with other request queues then @fn will be
- * called for all requests on all queues that share that tag set and not only
- * for requests associated with @q.
+ * called only for requests associated with @q.
  */
 void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_tag_iter_fn *fn,
 		void *priv)
-- 
2.41.0

