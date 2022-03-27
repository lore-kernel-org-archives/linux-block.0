Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7397C433F5
	for <linux-block@archiver.kernel.org>; Sun, 27 Mar 2022 18:48:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236361AbiC0SuQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 27 Mar 2022 14:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236348AbiC0SuP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 27 Mar 2022 14:50:15 -0400
Received: from smtp.smtpout.orange.fr (smtp04.smtpout.orange.fr [80.12.242.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 865141148
        for <linux-block@vger.kernel.org>; Sun, 27 Mar 2022 11:48:34 -0700 (PDT)
Received: from pop-os.home ([90.126.236.122])
        by smtp.orange.fr with ESMTPA
        id YXwFnGd76nyGdYXwFnJOjt; Sun, 27 Mar 2022 20:48:32 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sun, 27 Mar 2022 20:48:32 +0200
X-ME-IP: 90.126.236.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-block@vger.kernel.org
Subject: [PATCH 1/2] null_blk: Fix an error handling path in null_add_dev()
Date:   Sun, 27 Mar 2022 20:48:30 +0200
Message-Id: <876904b8334049a3be89d8bd278b04a421601baa.1648406899.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In case of error, call to ida_simple_get() must be undone in the error
handling path.

Fixes: a0725ab0c753 ("Merge branch 'for-4.14/block' of git://git.kernel.dk/linux-block")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/block/null_blk/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 05b1120e6623..a330a118659d 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -2074,6 +2074,7 @@ static int null_add_dev(struct nullb_device *dev)
 	return 0;
 out_cleanup_zone:
 	null_free_zoned_dev(dev);
+	ida_free(&nullb_indexes, nullb->index);
 out_cleanup_disk:
 	blk_cleanup_disk(nullb->disk);
 out_cleanup_tags:
-- 
2.32.0

