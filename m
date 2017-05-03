Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f53.google.com ([74.125.83.53]:34661 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755354AbdECTTL (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 May 2017 15:19:11 -0400
Received: by mail-pg0-f53.google.com with SMTP id v1so83101628pgv.1
        for <linux-block@vger.kernel.org>; Wed, 03 May 2017 12:19:11 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: Bart Van Assche <bart.vanassche@sandisk.com>, kernel-team@fb.com
Subject: [PATCH 1/9] blk-mq-debugfs: separate flags with |
Date: Wed,  3 May 2017 12:18:54 -0700
Message-Id: <a93a27c6300f9a129b8d897bff289a19e4d59704.1493839103.git.osandov@fb.com>
In-Reply-To: <cover.1493839103.git.osandov@fb.com>
References: <cover.1493839103.git.osandov@fb.com>
In-Reply-To: <cover.1493839103.git.osandov@fb.com>
References: <cover.1493839103.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

This reads more naturally than spaces.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 block/blk-mq-debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index bcd2a7d4a3a5..1ff3d726fb03 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -53,7 +53,7 @@ static int blk_flags_show(struct seq_file *m, const unsigned long flags,
 		if (!(flags & BIT(i)))
 			continue;
 		if (sep)
-			seq_puts(m, " ");
+			seq_puts(m, "|");
 		sep = true;
 		if (i < flag_name_count && flag_name[i])
 			seq_puts(m, flag_name[i]);
-- 
2.12.2
