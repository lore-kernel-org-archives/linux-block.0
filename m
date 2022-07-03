Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BFECC43334
	for <linux-block@archiver.kernel.org>; Sun,  3 Jul 2022 16:05:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232746AbiGCQFv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 3 Jul 2022 12:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbiGCQFu (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 3 Jul 2022 12:05:50 -0400
Received: from smtp.smtpout.orange.fr (smtp06.smtpout.orange.fr [80.12.242.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 786F05588
        for <linux-block@vger.kernel.org>; Sun,  3 Jul 2022 09:05:47 -0700 (PDT)
Received: from pop-os.home ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id 826ToL9zNWo1m826TovmZ7; Sun, 03 Jul 2022 18:05:46 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sun, 03 Jul 2022 18:05:46 +0200
X-ME-IP: 90.11.190.129
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-block@vger.kernel.org
Subject: [PATCH] block: null_blk: Use the bitmap API to allocate bitmaps
Date:   Sun,  3 Jul 2022 18:05:43 +0200
Message-Id: <7c4d3116ba843fc4a8ae557dd6176352a6cd0985.1656864320.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use bitmap_zalloc()/bitmap_free() instead of hand-writing them.

It is less verbose and it improves the semantic.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/block/null_blk/main.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index d695ea29efa6..f76fedf64449 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1656,7 +1656,7 @@ static blk_status_t null_queue_rq(struct blk_mq_hw_ctx *hctx,
 
 static void cleanup_queue(struct nullb_queue *nq)
 {
-	kfree(nq->tag_map);
+	bitmap_free(nq->tag_map);
 	kfree(nq->cmds);
 }
 
@@ -1783,14 +1783,13 @@ static const struct block_device_operations null_rq_ops = {
 static int setup_commands(struct nullb_queue *nq)
 {
 	struct nullb_cmd *cmd;
-	int i, tag_size;
+	int i;
 
 	nq->cmds = kcalloc(nq->queue_depth, sizeof(*cmd), GFP_KERNEL);
 	if (!nq->cmds)
 		return -ENOMEM;
 
-	tag_size = ALIGN(nq->queue_depth, BITS_PER_LONG) / BITS_PER_LONG;
-	nq->tag_map = kcalloc(tag_size, sizeof(unsigned long), GFP_KERNEL);
+	nq->tag_map = bitmap_zalloc(nq->queue_depth, GFP_KERNEL);
 	if (!nq->tag_map) {
 		kfree(nq->cmds);
 		return -ENOMEM;
-- 
2.34.1

