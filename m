Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36167 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933088AbcK1RCG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Nov 2016 12:02:06 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id uASH1qhL035835
        for <linux-block@vger.kernel.org>; Mon, 28 Nov 2016 12:02:05 -0500
Received: from e24smtp03.br.ibm.com (e24smtp03.br.ibm.com [32.104.18.24])
        by mx0a-001b2d01.pphosted.com with ESMTP id 270m8exa1t-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Mon, 28 Nov 2016 12:02:04 -0500
Received: from localhost
        by e24smtp03.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-block@vger.kernel.org> from <krisman@linux.vnet.ibm.com>;
        Mon, 28 Nov 2016 15:01:57 -0200
Received: from d24relay02.br.ibm.com (d24relay02.br.ibm.com [9.18.232.42])
        by d24dlp01.br.ibm.com (Postfix) with ESMTP id 3E6CF3520070
        for <linux-block@vger.kernel.org>; Mon, 28 Nov 2016 12:01:25 -0500 (EST)
Received: from d24av01.br.ibm.com (d24av01.br.ibm.com [9.8.31.91])
        by d24relay02.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id uASH1sYb33095828
        for <linux-block@vger.kernel.org>; Mon, 28 Nov 2016 15:01:54 -0200
Received: from d24av01.br.ibm.com (localhost [127.0.0.1])
        by d24av01.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id uASH1s2X009833
        for <linux-block@vger.kernel.org>; Mon, 28 Nov 2016 15:01:54 -0200
From: Gabriel Krisman Bertazi <krisman@linux.vnet.ibm.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@linux.vnet.ibm.com>,
        Ming Lei <ming.lei@canonical.com>
Subject: [PATCH] blk-mq: Drop explicit timeout sync in hotplug
Date: Mon, 28 Nov 2016 15:01:48 -0200
Message-Id: <1480352508-5810-1-git-send-email-krisman@linux.vnet.ibm.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Sorry for the dup.  Missed linux-block address.

>8

After commit 287922eb0b18 ("block: defer timeouts to a workqueue"),
deleting the timeout work after freezing the queue shouldn't be
necessary, since the synchronization is already enforced by the
acquisition of a q_usage_counter reference in blk_mq_timeout_work.

Signed-off-by: Gabriel Krisman Bertazi <krisman@linux.vnet.ibm.com>
Cc: Ming Lei <ming.lei@canonical.com>
---
 block/blk-mq.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 9d4a1d630d0b..bac12caece06 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2220,16 +2220,9 @@ static void blk_mq_queue_reinit_work(void)
 	 */
 	list_for_each_entry(q, &all_q_list, all_q_node)
 		blk_mq_freeze_queue_start(q);
-	list_for_each_entry(q, &all_q_list, all_q_node) {
+	list_for_each_entry(q, &all_q_list, all_q_node)
 		blk_mq_freeze_queue_wait(q);
 
-		/*
-		 * timeout handler can't touch hw queue during the
-		 * reinitialization
-		 */
-		del_timer_sync(&q->timeout);
-	}
-
 	list_for_each_entry(q, &all_q_list, all_q_node)
 		blk_mq_queue_reinit(q, &cpuhp_online_new);
 
-- 
2.7.4

