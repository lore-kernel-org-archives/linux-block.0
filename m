Return-Path: <SRS0=j3P0=CX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A2F8C43461
	for <linux-block@archiver.kernel.org>; Mon, 14 Sep 2020 07:22:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02FE621548
	for <linux-block@archiver.kernel.org>; Mon, 14 Sep 2020 07:22:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725951AbgINHWH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Sep 2020 03:22:07 -0400
Received: from mail-m1271.qiye.163.com ([115.236.127.1]:26868 "EHLO
        mail-m1271.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbgINHWG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Sep 2020 03:22:06 -0400
Received: from ubuntu.localdomain (unknown [157.0.31.125])
        by mail-m1271.qiye.163.com (Hmail) with ESMTPA id C338D5822EA;
        Mon, 14 Sep 2020 15:21:54 +0800 (CST)
From:   Yang Yang <yang.yang@vivo.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     onlyfever@icloud.com, yang.yang@vivo.com
Subject: [PATCH] blk-mq: fix hang issue in blk_queue_enter()
Date:   Mon, 14 Sep 2020 00:19:03 -0700
Message-Id: <20200914071903.65704-1-yang.yang@vivo.com>
X-Mailer: git-send-email 2.17.1
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZSU1JSB1OSU9MT0gdVkpNS0tLTUNKSk9CQ0lVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZVUtZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NhQ6Exw5OT8qTxBDCB44Ng9J
        AQ9PCxpVSlVKTUtLS01DSkpOSE5JVTMWGhIXVQIaFRxVAhoVHDsNEg0UVRgUFkVZV1kSC1lBWUpO
        TFVLVUhKVUpJTllXWQgBWUFJQ05MNwY+
X-HM-Tid: 0a748b7dd9c798b6kuuuc338d5822ea
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

There is a race between blk_queue_enter() and block layer's runtime
suspend.

 CPU0                                CPU1
 ---------------------------------   -------------------------------
 blk_pre_runtime_suspend(q) {        blk_queue_enter() {
   /* q->rpm_status=RPM_ACTIVE */
   blk_set_pm_only(q)
   /* q->pm_only=1 */
   blk_freeze_queue_start(q)
   blk_mq_unfreeze_queue(q)
                                       if (percpu_ref_tryget_live()) {
                                         /* pm=0 && q->pm_only=1 */
                                         if (pm || !blk_queue_pm_only(q)) {
                                         } else {
                                           percpu_ref_put()
                                         }
                                       }
                                       wait_event(q->mq_freeze_wq,
                                         (!q->mq_freeze_depth &&
                                         /* q->rpm_status=RPM_ACTIVE
                                            q->pm_only=1 */
                                         (pm || (blk_pm_request_resume(q),
                                          !blk_queue_pm_only(q)))) ||
                                          blk_queue_dying(q))
                                     }
   spin_lock_irq(&q->queue_lock)
   q->rpm_status = RPM_SUSPENDING
   spin_unlock_irq(&q->queue_lock)
 }

At this point blk_pm_request_resume() missed the chance to resume the
queue, so blk_queue_enter() may wait here forever.
The solution is to wake up the mq_freeze_wq after runtime suspend
completed, make blk_pm_request_resume() reexamine the q->rpm_status flag.

Signed-off-by: Yang Yang <yang.yang@vivo.com>
---
 block/blk-pm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/blk-pm.c b/block/blk-pm.c
index b85234d758f7..dec7d0aef606 100644
--- a/block/blk-pm.c
+++ b/block/blk-pm.c
@@ -132,6 +132,8 @@ void blk_post_runtime_suspend(struct request_queue *q, int err)
 
 	if (err)
 		blk_clear_pm_only(q);
+	else
+		wake_up_all(&q->mq_freeze_wq);
 }
 EXPORT_SYMBOL(blk_post_runtime_suspend);
 
-- 
2.17.1

