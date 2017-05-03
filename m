Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.15.14]:63150 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750737AbdECSgX (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 3 May 2017 14:36:23 -0400
Subject: [PATCH 2/2] blk-mq-debugfs: Add spaces in queue_poll_stat_show()
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: linux-block@vger.kernel.org,
        Bart Van Assche <bart.vanassche@sandisk.com>,
        Jens Axboe <axboe@kernel.dk>
Cc: LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
References: <507a3eee-6dfe-c218-1056-38221bd22be7@users.sourceforge.net>
Message-ID: <49822157-111d-0f44-3a5f-bd070cf7ebc7@users.sourceforge.net>
Date: Wed, 3 May 2017 20:36:15 +0200
MIME-Version: 1.0
In-Reply-To: <507a3eee-6dfe-c218-1056-38221bd22be7@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 3 May 2017 20:18:22 +0200

Use space characters at some source code places according to
the Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 block/blk-mq-debugfs.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 2265b70b1121..34cdd5f2b511 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -156,12 +156,12 @@ static int queue_poll_stat_show(struct seq_file *m, void *v)
 	struct request_queue *q = m->private;
 	int bucket;
 
-	for (bucket = 0; bucket < BLK_MQ_POLL_STATS_BKTS/2; bucket++) {
-		seq_printf(m, "read  (%d Bytes): ", 1 << (9+bucket));
-		print_stat(m, &q->poll_stat[2*bucket]);
+	for (bucket = 0; bucket < BLK_MQ_POLL_STATS_BKTS / 2; bucket++) {
+		seq_printf(m, "read  (%d Bytes): ", 1 << (9 + bucket));
+		print_stat(m, &q->poll_stat[2 * bucket]);
 		seq_putc(m, '\n');
-		seq_printf(m, "write (%d Bytes): ",  1 << (9+bucket));
-		print_stat(m, &q->poll_stat[2*bucket+1]);
+		seq_printf(m, "write (%d Bytes): ",  1 << (9 + bucket));
+		print_stat(m, &q->poll_stat[2 * bucket + 1]);
 		seq_putc(m, '\n');
 	}
 	return 0;
-- 
2.12.2
