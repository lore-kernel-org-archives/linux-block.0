Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.didichuxing.com ([111.202.154.82]:8011 "EHLO
        BJEXCAS006.didichuxing.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750973AbdJMQ0f (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Oct 2017 12:26:35 -0400
Date: Sat, 14 Oct 2017 00:26:28 +0800
From: weiping zhang <zhangweiping@didichuxing.com>
To: <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>
Subject: [PATCH 1/2] null_blk: update usage hints for submit_queues
Message-ID: <a9cb7326db5e4aa4461289c0561f6af29efcbe70.1507911414.git.zhangweiping@didichuxing.com>
References: <cover.1507911414.git.zhangweiping@didichuxing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <cover.1507911414.git.zhangweiping@didichuxing.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

update the range of submits_queues, and correct usage hints.

Signed-off-by: weiping zhang <zhangweiping@didichuxing.com>
---
 Documentation/block/null_blk.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/block/null_blk.txt b/Documentation/block/null_blk.txt
index 3140dbd860d8..1f8d92c70458 100644
--- a/Documentation/block/null_blk.txt
+++ b/Documentation/block/null_blk.txt
@@ -55,10 +55,10 @@ irqmode=[0-2]: Default: 1-Soft-irq
 completion_nsec=[ns]: Default: 10.000ns
   Combined with irqmode=2 (timer). The time each completion event must wait.
 
-submit_queues=[0..nr_cpus]:
+submit_queues=[1..nr_cpus]:
   The number of submission queues attached to the device driver. If unset, it
-  defaults to 1 on single-queue and bio-based instances. For multi-queue,
-  it is ignored when use_per_node_hctx module parameter is 1.
+  defaults to 1. For multi-queue, it is ignored when use_per_node_hctx module
+  parameter is 1.
 
 hw_queue_depth=[0..qdepth]: Default: 64
   The hardware queue depth of the device.
-- 
2.14.2
