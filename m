Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f174.google.com ([209.85.192.174]:33133 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751375AbdAYQHZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Jan 2017 11:07:25 -0500
Received: by mail-pf0-f174.google.com with SMTP id y143so59229479pfb.0
        for <linux-block@vger.kernel.org>; Wed, 25 Jan 2017 08:07:24 -0800 (PST)
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: kernel-team@fb.com
Subject: [PATCH v2 04/10] blk-mq: add extra request information to debugfs
Date: Wed, 25 Jan 2017 08:06:43 -0800
Message-Id: <79c2ac5add8fc2ba90d2ef3867f45065006ffd5a.1485360145.git.osandov@fb.com>
In-Reply-To: <cover.1485360145.git.osandov@fb.com>
References: <cover.1485360145.git.osandov@fb.com>
In-Reply-To: <cover.1485360145.git.osandov@fb.com>
References: <cover.1485360145.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

The request pointers by themselves aren't super useful.

Reviewed-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 block/blk-mq-debugfs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 1967c06d80e0..ee947f2f605b 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -87,7 +87,9 @@ static int blk_mq_debugfs_rq_show(struct seq_file *m, void *v)
 {
 	struct request *rq = list_entry_rq(v);
 
-	seq_printf(m, "%p\n", rq);
+	seq_printf(m, "%p {.cmd_type=%u, .cmd_flags=0x%x, .rq_flags=0x%x, .tag=%d, .internal_tag=%d}\n",
+		   rq, rq->cmd_type, rq->cmd_flags, (unsigned int)rq->rq_flags,
+		   rq->tag, rq->internal_tag);
 	return 0;
 }
 
-- 
2.11.0

