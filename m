Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.15.4]:54948 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751813AbdECSfa (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 3 May 2017 14:35:30 -0400
Subject: [PATCH 1/2] blk-mq-debugfs: Replace seven seq_puts() calls by
 seq_putc()
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: linux-block@vger.kernel.org,
        Bart Van Assche <bart.vanassche@sandisk.com>,
        Jens Axboe <axboe@kernel.dk>
Cc: LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
References: <507a3eee-6dfe-c218-1056-38221bd22be7@users.sourceforge.net>
Message-ID: <caf15567-45d2-2062-9fae-cf1d098f2f3c@users.sourceforge.net>
Date: Wed, 3 May 2017 20:35:23 +0200
MIME-Version: 1.0
In-Reply-To: <507a3eee-6dfe-c218-1056-38221bd22be7@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 3 May 2017 20:00:49 +0200

A few single characters should be put into a sequence.
Thus use the corresponding function "seq_putc".

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 block/blk-mq-debugfs.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index bcd2a7d4a3a5..2265b70b1121 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -53,7 +53,7 @@ static int blk_flags_show(struct seq_file *m, const unsigned long flags,
 		if (!(flags & BIT(i)))
 			continue;
 		if (sep)
-			seq_puts(m, " ");
+			seq_putc(m, ' ');
 		sep = true;
 		if (i < flag_name_count && flag_name[i])
 			seq_puts(m, flag_name[i]);
@@ -101,7 +101,7 @@ static int blk_queue_flags_show(struct seq_file *m, void *v)
 
 	blk_flags_show(m, q->queue_flags, blk_queue_flag_name,
 		       ARRAY_SIZE(blk_queue_flag_name));
-	seq_puts(m, "\n");
+	seq_putc(m, '\n');
 	return 0;
 }
 
@@ -159,11 +159,10 @@ static int queue_poll_stat_show(struct seq_file *m, void *v)
 	for (bucket = 0; bucket < BLK_MQ_POLL_STATS_BKTS/2; bucket++) {
 		seq_printf(m, "read  (%d Bytes): ", 1 << (9+bucket));
 		print_stat(m, &q->poll_stat[2*bucket]);
-		seq_puts(m, "\n");
-
+		seq_putc(m, '\n');
 		seq_printf(m, "write (%d Bytes): ",  1 << (9+bucket));
 		print_stat(m, &q->poll_stat[2*bucket+1]);
-		seq_puts(m, "\n");
+		seq_putc(m, '\n');
 	}
 	return 0;
 }
@@ -193,7 +192,7 @@ static int hctx_state_show(struct seq_file *m, void *v)
 
 	blk_flags_show(m, hctx->state, hctx_state_name,
 		       ARRAY_SIZE(hctx_state_name));
-	seq_puts(m, "\n");
+	seq_putc(m, '\n');
 	return 0;
 }
 
@@ -233,11 +232,11 @@ static int hctx_flags_show(struct seq_file *m, void *v)
 		seq_puts(m, alloc_policy_name[alloc_policy]);
 	else
 		seq_printf(m, "%d", alloc_policy);
-	seq_puts(m, " ");
+	seq_putc(m, ' ');
 	blk_flags_show(m,
 		       hctx->flags ^ BLK_ALLOC_POLICY_TO_MQ_FLAG(alloc_policy),
 		       hctx_flag_name, ARRAY_SIZE(hctx_flag_name));
-	seq_puts(m, "\n");
+	seq_putc(m, '\n');
 	return 0;
 }
 
-- 
2.12.2
