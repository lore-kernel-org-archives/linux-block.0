Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:48203 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752770AbdBMQFH (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 Feb 2017 11:05:07 -0500
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id CB010AB9A
        for <linux-block@vger.kernel.org>; Mon, 13 Feb 2017 16:05:05 +0000 (UTC)
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
To: linux-block@vger.kernel.org
Cc: Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH] blk-mq: Call bio_io_error if request returned is NULL
Date: Mon, 13 Feb 2017 10:04:54 -0600
Message-Id: <20170213160454.30869-1-rgoldwyn@suse.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

If blk_mq_map_request returns NULL, bio_endio() function is not
called. Call bio_io_error() in case request returned is NULL.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 block/blk-mq.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 81caceb..7cd8912 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1286,8 +1286,10 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 		return BLK_QC_T_NONE;
 
 	rq = blk_mq_map_request(q, bio, &data);
-	if (unlikely(!rq))
+	if (unlikely(!rq)) {
+		bio_io_error(bio);
 		return BLK_QC_T_NONE;
+	}
 
 	cookie = blk_tag_to_qc_t(rq->tag, data.hctx->queue_num);
 
@@ -1381,8 +1383,10 @@ static blk_qc_t blk_sq_make_request(struct request_queue *q, struct bio *bio)
 		request_count = blk_plug_queued_count(q);
 
 	rq = blk_mq_map_request(q, bio, &data);
-	if (unlikely(!rq))
+	if (unlikely(!rq)) {
+		bio_io_error(bio);
 		return BLK_QC_T_NONE;
+	}
 
 	cookie = blk_tag_to_qc_t(rq->tag, data.hctx->queue_num);
 
-- 
2.10.2
