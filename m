Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39985 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729175AbeJLB7M (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Oct 2018 21:59:12 -0400
Received: by mail-pg1-f194.google.com with SMTP id n31-v6so4570696pgm.7
        for <linux-block@vger.kernel.org>; Thu, 11 Oct 2018 11:30:48 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@fb.com>, kernel-team@fb.com
Subject: [PATCH 12/13] floppy: end whole request on error
Date: Thu, 11 Oct 2018 11:30:22 -0700
Message-Id: <4b575ac74fab6d233b891f8c12dadaea3873931c.1539282366.git.osandov@fb.com>
In-Reply-To: <cover.1539282366.git.osandov@fb.com>
References: <cover.1539282366.git.osandov@fb.com>
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

If floppy_end_request() gets passed an error, it should end the whole
request, not just the current segment.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 drivers/block/floppy.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index f2b6f4da1034..acbafd831ea3 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -2210,13 +2210,15 @@ static int do_format(int drive, struct format_descr *tmp_format_req)
 
 static void floppy_end_request(struct request *req, blk_status_t error)
 {
-	unsigned int nr_sectors = current_count_sectors;
+	unsigned int nr_bytes;
 	unsigned int drive = (unsigned long)req->rq_disk->private_data;
 
 	/* current_count_sectors can be zero if transfer failed */
 	if (error)
-		nr_sectors = blk_rq_cur_sectors(req);
-	if (__blk_end_request(req, error, nr_sectors << 9))
+		nr_bytes = blk_rq_bytes(req);
+	else
+		nr_bytes = current_count_sectors << 9;
+	if (__blk_end_request(req, error, nr_bytes))
 		return;
 
 	/* We're done with the request */
-- 
2.19.1
