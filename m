Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f176.google.com ([209.85.192.176]:36016 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751485AbdEDHbn (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 May 2017 03:31:43 -0400
Received: by mail-pf0-f176.google.com with SMTP id q66so3714360pfi.3
        for <linux-block@vger.kernel.org>; Thu, 04 May 2017 00:31:43 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: Bart Van Assche <bart.vanassche@sandisk.com>, kernel-team@fb.com
Subject: [PATCH v2 01/12] blk-mq-debugfs: separate flags with |
Date: Thu,  4 May 2017 00:31:23 -0700
Message-Id: <a93a27c6300f9a129b8d897bff289a19e4d59704.1493882751.git.osandov@fb.com>
In-Reply-To: <cover.1493882751.git.osandov@fb.com>
References: <cover.1493882751.git.osandov@fb.com>
In-Reply-To: <cover.1493882751.git.osandov@fb.com>
References: <cover.1493882751.git.osandov@fb.com>
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
