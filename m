Return-Path: <linux-block-owner@vger.kernel.org>
Received: from lb1.openmailbox.org ([5.79.108.160]:40326 "EHLO
        mail.openmailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751369AbdGLWWZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Jul 2017 18:22:25 -0400
From: Alex Ivanov <yourbestfriend@openmailbox.org>
To: linux-block@vger.kernel.org
Subject: [PATCH] elevator: allow specifying elevator by config boot param for blk-mq devices
Date: Wed, 12 Jul 2017 21:57:08 +0300
Message-Id: <20170712185708.5987-1-yourbestfriend@openmailbox.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

It's now makes sense to use elevator boot argument when blk-mq is in use,
since there is now a bunch of schedulers for it (deadline, kyber, bfq, none).

Signed-off-by: Alex Ivanov <yourbestfriend@openmailbox.org>
---
 block/elevator.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/elevator.c b/block/elevator.c
index 4bb2f0c93fa6..ef6b27f13dfd 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -208,12 +208,12 @@ int elevator_init(struct request_queue *q, char *name)
 	}
 
 	/*
-	 * Use the default elevator specified by config boot param for
-	 * non-mq devices, or by config option. Don't try to load modules
+	 * Use the default elevator specified by config boot param
+	 * or by config option. Don't try to load modules
 	 * as we could be running off async and request_module() isn't
 	 * allowed from async.
 	 */
-	if (!e && !q->mq_ops && *chosen_elevator) {
+	if (!e && *chosen_elevator) {
 		e = elevator_get(chosen_elevator, false);
 		if (!e)
 			printk(KERN_ERR "I/O scheduler %s not found\n",
-- 
2.13.2
