Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE2DC433FE
	for <linux-block@archiver.kernel.org>; Fri, 17 Sep 2021 02:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45F2361108
	for <linux-block@archiver.kernel.org>; Fri, 17 Sep 2021 02:36:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243960AbhIQChr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Sep 2021 22:37:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:34322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243433AbhIQCgb (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Sep 2021 22:36:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 39D7061139;
        Fri, 17 Sep 2021 02:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631846110;
        bh=c3XCtVyOOmSN8//YWlQxWHyl3bALKGKJUAe/8BgASdE=;
        h=From:To:Cc:Subject:Date:From;
        b=WW56fg2DEIBXn6QuZKh5v44CDC+eBZrYk+P7TzbcmHtRKAPjrVK526CA3Vo9vRkl/
         d3j8ZZoTHmzw9eIxMn765ZrH275omKrfH+kuDTfXZSIxZTNx/k0QUdsONRqUUD8E/7
         nsckq/HSOwAYlRbLu2Yml9CaH4iDPRwXYv+YLT12dXaNeJEQgY6/fatXsI3My7yHXj
         +EUHkKZ8gZH4bt3jOpMXFClPptbscn2IBT+s3sqmB7LGiKiwIa/STu2TqG9Y4xToG5
         Ki6AZ3g7boIoR2JQL7M62lJ1Rq9LB77z1x+EDqJaktihdL7YXN2rtZXtgWuz97Bmh3
         vKBvx1nauHuOA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Li Jinlin <lijinlin3@huawei.com>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>, tj@kernel.org,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9] blk-throttle: fix UAF by deleteing timer in blk_throtl_exit()
Date:   Thu, 16 Sep 2021 22:35:08 -0400
Message-Id: <20210917023508.816980-1-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Li Jinlin <lijinlin3@huawei.com>

[ Upstream commit 884f0e84f1e3195b801319c8ec3d5774e9bf2710 ]

The pending timer has been set up in blk_throtl_init(). However, the
timer is not deleted in blk_throtl_exit(). This means that the timer
handler may still be running after freeing the timer, which would
result in a use-after-free.

Fix by calling del_timer_sync() to delete the timer in blk_throtl_exit().

Signed-off-by: Li Jinlin <lijinlin3@huawei.com>
Link: https://lore.kernel.org/r/20210907121242.2885564-1-lijinlin3@huawei.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-throttle.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 3a4c9a3c1427..6435dc25be0a 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -1584,6 +1584,7 @@ int blk_throtl_init(struct request_queue *q)
 void blk_throtl_exit(struct request_queue *q)
 {
 	BUG_ON(!q->td);
+	del_timer_sync(&q->td->service_queue.pending_timer);
 	throtl_shutdown_wq(q);
 	blkcg_deactivate_policy(q, &blkcg_policy_throtl);
 	kfree(q->td);
-- 
2.30.2

