Return-Path: <linux-block-owner@vger.kernel.org>
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:43019 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S936093AbeEYOli (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 May 2018 10:41:38 -0400
From: Liu Bo <bo.liu@linux.alibaba.com>
To: <linux-block@vger.kernel.org>
Subject: [PATCH] Block: null_blk: add blocking description and remove lightnvm
Date: Fri, 25 May 2018 22:40:04 +0800
Message-Id: <1527259204-79604-1-git-send-email-bo.liu@linux.alibaba.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

- The description of 'blocking' is missing in null_blk.txt

- The 'lightnvm' parameter has been removed in null_blk.c

This updates both in null_blk.txt.

Signed-off-by: Liu Bo <bo.liu@linux.alibaba.com>
---
 Documentation/block/null_blk.txt | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/block/null_blk.txt b/Documentation/block/null_blk.txt
index 733927a7b501..07f147381f32 100644
--- a/Documentation/block/null_blk.txt
+++ b/Documentation/block/null_blk.txt
@@ -71,13 +71,16 @@ use_per_node_hctx=[0/1]: Default: 0
   1: The multi-queue block layer is instantiated with a hardware dispatch
      queue for each CPU node in the system.
 
-use_lightnvm=[0/1]: Default: 0
-  Register device with LightNVM. Requires blk-mq and CONFIG_NVM to be enabled.
-
 no_sched=[0/1]: Default: 0
   0: nullb* use default blk-mq io scheduler.
   1: nullb* doesn't use io scheduler.
 
+blocking=[0/1]: Default: 0
+  0: Register as a non-blocking blk-mq driver device.
+  1: Register as a blocking blk-mq driver device, null_blk will set
+     the BLK_MQ_F_BLOCKING flag, indicating that it sometimes/always
+     needs to block in its ->queue_rq() function.
+
 shared_tags=[0/1]: Default: 0
   0: Tag set is not shared.
   1: Tag set shared between devices for blk-mq. Only makes sense with
-- 
1.8.3.1
