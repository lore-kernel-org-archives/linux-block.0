Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:45183 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S965677AbdD1Ozw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Apr 2017 10:55:52 -0400
From: Jens Axboe <axboe@fb.com>
To: <linux-block@vger.kernel.org>
CC: <ming.lei@redhat.com>, <hch@lst.de>, Jens Axboe <axboe@fb.com>
Subject: [PATCH 6/7] blk-mq-sched: remove hack that bypasses scheduler for reserved requests
Date: Fri, 28 Apr 2017 08:55:39 -0600
Message-ID: <1493391340-24629-7-git-send-email-axboe@fb.com>
In-Reply-To: <1493391340-24629-1-git-send-email-axboe@fb.com>
References: <1493391340-24629-1-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

We have update the troublesome driver (mtip32xx) to deal with this
appropriately. So kill the hack that bypassed scheduler allocation
and insertion for reserved requests.

Signed-off-by: Jens Axboe <axboe@fb.com>
---
 block/blk-mq-sched.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 8b361e192e8a..e79e9f18d7c2 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -82,11 +82,7 @@ struct request *blk_mq_sched_get_request(struct request_queue *q,
 	if (likely(!data->hctx))
 		data->hctx = blk_mq_map_queue(q, data->ctx->cpu);
 
-	/*
-	 * For a reserved tag, allocate a normal request since we might
-	 * have driver dependencies on the value of the internal tag.
-	 */
-	if (e && !(data->flags & BLK_MQ_REQ_RESERVED)) {
+	if (e) {
 		data->flags |= BLK_MQ_REQ_INTERNAL;
 
 		/*
-- 
2.7.4
