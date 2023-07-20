Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41005EB64DA
	for <linux-block@archiver.kernel.org>; Thu, 20 Jul 2023 09:49:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbjGTJtl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Jul 2023 05:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbjGTJsp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Jul 2023 05:48:45 -0400
Received: from out-51.mta0.migadu.com (out-51.mta0.migadu.com [91.218.175.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFC683AAD
        for <linux-block@vger.kernel.org>; Thu, 20 Jul 2023 02:47:36 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1689846454;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p34J6xnRb86eKyDcpXgSq81rjV9gO+WCulIJcSmybAc=;
        b=FO6tJlnKG0PcTyIP5O724vhJaUPzs5PqLkd247BAIxAFGdYM4v7WurTFDGaN1YoOreq4c4
        b/h8BL7Yc08WxbDl3yG4Uw0l/8qSIJEuH5EsaTErtlXjMS1BEQPE+uV6BtlyiezOPVg7ob
        IdnA189BksTiUPxZouFvEL2EiJX56tI=
From:   chengming.zhou@linux.dev
To:     axboe@kernel.dk, osandov@fb.com, ming.lei@redhat.com,
        kbusch@kernel.org, krisman@suse.de
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        zhouchengming@bytedance.com
Subject: [PATCH 5/6] sbitmap: wake_index doesn't need to be atomic_t
Date:   Thu, 20 Jul 2023 17:45:54 +0800
Message-ID: <20230720094555.1397621-6-chengming.zhou@linux.dev>
In-Reply-To: <20230720094555.1397621-1-chengming.zhou@linux.dev>
References: <20230720094555.1397621-1-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Chengming Zhou <zhouchengming@bytedance.com>

We use wake_index to remember from which to wake up next time, which
doesn't need to be atomic_t since we only read it once before wakeups,
and write it once after wakeups.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 include/linux/sbitmap.h |  2 +-
 lib/sbitmap.c           | 12 ++++++------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/sbitmap.h b/include/linux/sbitmap.h
index d662cf136021..bdbe478ba4dc 100644
--- a/include/linux/sbitmap.h
+++ b/include/linux/sbitmap.h
@@ -116,7 +116,7 @@ struct sbitmap_queue {
 	/**
 	 * @wake_index: Next wait queue in @ws to wake up.
 	 */
-	atomic_t wake_index;
+	unsigned int wake_index;
 
 	/**
 	 * @ws: Wait queues.
diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index 50bdf3a31947..6778ab3fc6a5 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -419,7 +419,7 @@ int sbitmap_queue_init_node(struct sbitmap_queue *sbq, unsigned int depth,
 
 	sbq->min_shallow_depth = UINT_MAX;
 	sbq->wake_batch = sbq_calc_wake_batch(sbq, depth);
-	atomic_set(&sbq->wake_index, 0);
+	sbq->wake_index = 0;
 	atomic_set(&sbq->ws_active, 0);
 	atomic_set(&sbq->completion_cnt, 0);
 	atomic_set(&sbq->wakeup_cnt, 0);
@@ -549,7 +549,7 @@ static void __sbitmap_queue_wake_up(struct sbitmap_queue *sbq, int nr)
 	if (!atomic_read(&sbq->ws_active))
 		return;
 
-	wake_index = atomic_read(&sbq->wake_index);
+	wake_index = READ_ONCE(sbq->wake_index);
 	for (i = 0; i < SBQ_WAIT_QUEUES; i++) {
 		struct sbq_wait_state *ws = &sbq->ws[wake_index];
 
@@ -570,8 +570,8 @@ static void __sbitmap_queue_wake_up(struct sbitmap_queue *sbq, int nr)
 			break;
 	}
 
-	if (wake_index != atomic_read(&sbq->wake_index))
-		atomic_set(&sbq->wake_index, wake_index);
+	if (wake_index != READ_ONCE(sbq->wake_index))
+		WRITE_ONCE(sbq->wake_index, wake_index);
 }
 
 void sbitmap_queue_wake_up(struct sbitmap_queue *sbq, int nr)
@@ -672,7 +672,7 @@ void sbitmap_queue_wake_all(struct sbitmap_queue *sbq)
 	 * sbitmap_queue_wake_up().
 	 */
 	smp_mb();
-	wake_index = atomic_read(&sbq->wake_index);
+	wake_index = READ_ONCE(sbq->wake_index);
 	for (i = 0; i < SBQ_WAIT_QUEUES; i++) {
 		struct sbq_wait_state *ws = &sbq->ws[wake_index];
 
@@ -702,7 +702,7 @@ void sbitmap_queue_show(struct sbitmap_queue *sbq, struct seq_file *m)
 	seq_puts(m, "}\n");
 
 	seq_printf(m, "wake_batch=%u\n", sbq->wake_batch);
-	seq_printf(m, "wake_index=%d\n", atomic_read(&sbq->wake_index));
+	seq_printf(m, "wake_index=%d\n", READ_ONCE(sbq->wake_index));
 	seq_printf(m, "ws_active=%d\n", atomic_read(&sbq->ws_active));
 
 	seq_puts(m, "ws={\n");
-- 
2.41.0

