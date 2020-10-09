Return-Path: <SRS0=NSF0=DQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43528C433DF
	for <linux-block@archiver.kernel.org>; Fri,  9 Oct 2020 08:06:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD342221FC
	for <linux-block@archiver.kernel.org>; Fri,  9 Oct 2020 08:06:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732423AbgJIIGH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 9 Oct 2020 04:06:07 -0400
Received: from mail-m1271.qiye.163.com ([115.236.127.1]:51276 "EHLO
        mail-m1271.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732337AbgJIIGG (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 9 Oct 2020 04:06:06 -0400
X-Greylist: delayed 307 seconds by postgrey-1.27 at vger.kernel.org; Fri, 09 Oct 2020 04:06:05 EDT
Received: from ubuntu.localdomain (unknown [157.0.31.125])
        by mail-m1271.qiye.163.com (Hmail) with ESMTPA id BF05D581FBE;
        Fri,  9 Oct 2020 16:00:56 +0800 (CST)
From:   Yang Yang <yang.yang@vivo.com>
To:     Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     onlyfever@icloud.com, yang.yang@vivo.com
Subject: [PATCH] blk-mq: move cancel of hctx->run_work to the front of blk_exit_queue
Date:   Fri,  9 Oct 2020 01:00:14 -0700
Message-Id: <20201009080015.3217-1-yang.yang@vivo.com>
X-Mailer: git-send-email 2.17.1
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZGE1NSktDHkIYTkhMVkpNS0lJSEtPTk1CTUhVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS09ISVVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PD46Khw6IT8vAkxMDQ4xNQER
        Hh8wCj5VSlVKTUtJSUhLT05MSE1NVTMWGhIXVQIaFRxVAhoVHDsNEg0UVRgUFkVZV1kSC1lBWUpO
        TFVLVUhKVUpJTllXWQgBWUFJT0hINwY+
X-HM-Tid: 0a750c60924998b6kuuubf05d581fbe
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

blk_exit_queue will free elevator_data, while blk_mq_run_work_fn
will access it. Move cancel of hctx->run_work to the front of
blk_exit_queue to avoid use-after-free.

Fixes: 1b97871b501f ("blk-mq: move cancel of hctx->run_work into blk_mq_hw_sysfs_release")
Signed-off-by: Yang Yang <yang.yang@vivo.com>
---
 block/blk-mq-sysfs.c | 2 --
 block/blk-sysfs.c    | 9 ++++++++-
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c
index 062229395a50..7b52e7657b2d 100644
--- a/block/blk-mq-sysfs.c
+++ b/block/blk-mq-sysfs.c
@@ -36,8 +36,6 @@ static void blk_mq_hw_sysfs_release(struct kobject *kobj)
 	struct blk_mq_hw_ctx *hctx = container_of(kobj, struct blk_mq_hw_ctx,
 						  kobj);
 
-	cancel_delayed_work_sync(&hctx->run_work);
-
 	if (hctx->flags & BLK_MQ_F_BLOCKING)
 		cleanup_srcu_struct(hctx->srcu);
 	blk_free_flush_queue(hctx->fq);
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 7dda709f3ccb..8c6bafc801dd 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -934,9 +934,16 @@ static void blk_release_queue(struct kobject *kobj)
 
 	blk_free_queue_stats(q->stats);
 
-	if (queue_is_mq(q))
+	if (queue_is_mq(q)) {
+		struct blk_mq_hw_ctx *hctx;
+		int i;
+
 		cancel_delayed_work_sync(&q->requeue_work);
 
+		queue_for_each_hw_ctx(q, hctx, i)
+			cancel_delayed_work_sync(&hctx->run_work);
+	}
+
 	blk_exit_queue(q);
 
 	blk_queue_free_zone_bitmaps(q);
-- 
2.17.1

