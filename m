Return-Path: <linux-block-owner@vger.kernel.org>
Received: from userp2130.oracle.com ([156.151.31.86]:54282 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726785AbeH0JlM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Aug 2018 05:41:12 -0400
To: Ming Lei <ming.lei@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Subject: No protection on the hctx->dispatch_busy
Message-ID: <306399af-99d9-ed45-bf3b-75908ff9187c@oracle.com>
Date: Mon, 27 Aug 2018 13:56:39 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Ming

Currently, blk_mq_update_dispatch_busy is hooked in blk_mq_dispatch_rq_list
and __blk_mq_issue_directly. blk_mq_update_dispatch_busy could be invoked on multiple
cpus concurrently. But there is not any protection on the hctx->dispatch_busy. We cannot
ensure the update on the dispatch_busy atomically.


Look at the test result after applied the debug patch below:

             fio-1761  [000] ....   227.246251: blk_mq_update_dispatch_busy.part.50: old 0 ewma 2 cur 2
             fio-1766  [004] ....   227.246252: blk_mq_update_dispatch_busy.part.50: old 2 ewma 1 cur 1
             fio-1755  [000] ....   227.246366: blk_mq_update_dispatch_busy.part.50: old 1 ewma 0 cur 0
             fio-1754  [003] ....   227.266050: blk_mq_update_dispatch_busy.part.50: old 2 ewma 3 cur 3
             fio-1763  [007] ....   227.266050: blk_mq_update_dispatch_busy.part.50: old 0 ewma 2 cur 2
             fio-1761  [000] ....   227.266051: blk_mq_update_dispatch_busy.part.50: old 3 ewma 2 cur 2
             fio-1766  [004] ....   227.266051: blk_mq_update_dispatch_busy.part.50: old 3 ewma 2 cur 2
             fio-1760  [005] ....   227.266165: blk_mq_update_dispatch_busy.part.50: old 2 ewma 1 cur 1

--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1088,11 +1088,12 @@ static bool blk_mq_mark_tag_wait(struct blk_mq_hw_ctx *hctx,
 static void blk_mq_update_dispatch_busy(struct blk_mq_hw_ctx *hctx, bool busy)
 {
        unsigned int ewma;
+       unsigned int old;
 
        if (hctx->queue->elevator)
                return;
 
-       ewma = hctx->dispatch_busy;
+       old = ewma = hctx->dispatch_busy;
 
        if (!ewma && !busy)
                return;
@@ -1103,6 +1104,8 @@ static void blk_mq_update_dispatch_busy(struct blk_mq_hw_ctx *hctx, bool busy)
        ewma /= BLK_MQ_DISPATCH_BUSY_EWMA_WEIGHT;
 
        hctx->dispatch_busy = ewma;
+
+       trace_printk("old %u ewma %u cur %u\n", old, ewma, READ_ONCE(hctx->dispatch_busy));
 }


Is it expected ?

Thanks
Jianchao
