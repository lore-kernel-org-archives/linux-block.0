Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.didichuxing.com ([111.202.154.82]:11944 "EHLO
        BJEXCAS001.didichuxing.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751529AbdJMQ1C (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Oct 2017 12:27:02 -0400
Date: Sat, 14 Oct 2017 00:26:54 +0800
From: weiping zhang <zhangweiping@didichuxing.com>
To: <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>
Subject: [PATCH 2/2] null_blk: add usage hints for no_sched
Message-ID: <b780dcf35f4cda251e8608a3f69067c598c590d4.1507911414.git.zhangweiping@didichuxing.com>
References: <cover.1507911414.git.zhangweiping@didichuxing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <cover.1507911414.git.zhangweiping@didichuxing.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This parameter provide an option to disable io scheduler when nullb*
in multi-queue mode.

Signed-off-by: weiping zhang <zhangweiping@didichuxing.com>
---
 Documentation/block/null_blk.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/block/null_blk.txt b/Documentation/block/null_blk.txt
index 1f8d92c70458..b7161c8e70f2 100644
--- a/Documentation/block/null_blk.txt
+++ b/Documentation/block/null_blk.txt
@@ -73,3 +73,7 @@ use_per_node_hctx=[0/1]: Default: 0
 
 use_lightnvm=[0/1]: Default: 0
   Register device with LightNVM. Requires blk-mq and CONFIG_NVM to be enabled.
+
+no_sched=[0/1]: Default: 0
+  0: nullb* use default blk-mq io scheduler.
+  1: nullb* doesn't use io scheduler.
-- 
2.14.2
