Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35741 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729126AbeJLB7E (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Oct 2018 21:59:04 -0400
Received: by mail-pg1-f193.google.com with SMTP id v133-v6so4577350pgb.2
        for <linux-block@vger.kernel.org>; Thu, 11 Oct 2018 11:30:40 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@fb.com>, kernel-team@fb.com
Subject: [PATCH 04/13] swim3: end whole request on error
Date: Thu, 11 Oct 2018 11:30:14 -0700
Message-Id: <3e2de6e6c66ab09f7fcf91ac7ad12228cdbcabb4.1539282366.git.osandov@fb.com>
In-Reply-To: <cover.1539282366.git.osandov@fb.com>
References: <cover.1539282366.git.osandov@fb.com>
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

When swim3_end_request() gets passed an error, it seems that the intent
is to end the whole request, but we're only ending the current segment.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 drivers/block/swim3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/swim3.c b/drivers/block/swim3.c
index df7ebe016e2c..24e121ee274b 100644
--- a/drivers/block/swim3.c
+++ b/drivers/block/swim3.c
@@ -266,7 +266,7 @@ static bool swim3_end_request(struct floppy_state *fs, blk_status_t err, unsigne
 		  err, nr_bytes, req);
 
 	if (err)
-		nr_bytes = blk_rq_cur_bytes(req);
+		nr_bytes = blk_rq_bytes(req);
 	rc = __blk_end_request(req, err, nr_bytes);
 	if (rc)
 		return true;
-- 
2.19.1
