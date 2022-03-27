Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C13F7C433EF
	for <linux-block@archiver.kernel.org>; Sun, 27 Mar 2022 18:48:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236376AbiC0SuW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 27 Mar 2022 14:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236348AbiC0SuV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 27 Mar 2022 14:50:21 -0400
Received: from smtp.smtpout.orange.fr (smtp04.smtpout.orange.fr [80.12.242.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0701B1117D
        for <linux-block@vger.kernel.org>; Sun, 27 Mar 2022 11:48:41 -0700 (PDT)
Received: from pop-os.home ([90.126.236.122])
        by smtp.orange.fr with ESMTPA
        id YXwOnGdAcnyGdYXwOnJOlQ; Sun, 27 Mar 2022 20:48:40 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sun, 27 Mar 2022 20:48:40 +0200
X-ME-IP: 90.126.236.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-block@vger.kernel.org
Subject: [PATCH 2/2] null_blk: Update ida_simple_get()/ida_simple_remove() to the newer ida API
Date:   Sun, 27 Mar 2022 20:48:38 +0200
Message-Id: <0e758e026fae17eaaae7a5d918cce3490e476a2e.1648406899.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <876904b8334049a3be89d8bd278b04a421601baa.1648406899.git.christophe.jaillet@wanadoo.fr>
References: <876904b8334049a3be89d8bd278b04a421601baa.1648406899.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

ida_simple_get() and ida_simple_remove() are deprecated. Use ida_alloc()
and ida_free() instead. It is less verbose.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/block/null_blk/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index a330a118659d..6b4248cc310a 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1724,7 +1724,7 @@ static void null_del_dev(struct nullb *nullb)
 
 	dev = nullb->dev;
 
-	ida_simple_remove(&nullb_indexes, nullb->index);
+	ida_free(&nullb_indexes, nullb->index);
 
 	list_del_init(&nullb->list);
 
@@ -2044,7 +2044,7 @@ static int null_add_dev(struct nullb_device *dev)
 	blk_queue_flag_clear(QUEUE_FLAG_ADD_RANDOM, nullb->q);
 
 	mutex_lock(&lock);
-	nullb->index = ida_simple_get(&nullb_indexes, 0, 0, GFP_KERNEL);
+	nullb->index = ida_alloc(&nullb_indexes, GFP_KERNEL);
 	dev->index = nullb->index;
 	mutex_unlock(&lock);
 
-- 
2.32.0

