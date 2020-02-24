Return-Path: <SRS0=9TSA=4M=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BF58C38BF9
	for <linux-block@archiver.kernel.org>; Mon, 24 Feb 2020 21:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D87D222C2
	for <linux-block@archiver.kernel.org>; Mon, 24 Feb 2020 21:40:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728039AbgBXVkt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Feb 2020 16:40:49 -0500
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:31498 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728104AbgBXVkp (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Feb 2020 16:40:45 -0500
X-Greylist: delayed 986 seconds by postgrey-1.27 at vger.kernel.org; Mon, 24 Feb 2020 16:40:39 EST
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 01OLO5T6008699;
        Mon, 24 Feb 2020 22:24:05 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Denis Efremov <efremov@linux.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Willy Tarreau <w@1wt.eu>
Subject: [PATCH 08/10] floppy: cleanup: expand macro DRWE
Date:   Mon, 24 Feb 2020 22:23:50 +0100
Message-Id: <20200224212352.8640-9-w@1wt.eu>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20200224212352.8640-1-w@1wt.eu>
References: <20200224212352.8640-1-w@1wt.eu>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This macro doesn't bring much value and only slightly obfuscates the
code by silently using global variable "current_drive", let's expand it.

Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 drivers/block/floppy.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index 6d4a2e1..d771579 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -306,8 +306,6 @@ static bool initialized;
 	/* reverse mapping from unit and fdc to drive */
 #define REVDRIVE(fdc, unit) ((unit) + ((fdc) << 2))
 
-#define DRWE	(&write_errors[current_drive])
-
 #define PH_HEAD(floppy, head) (((((floppy)->stretch & 2) >> 1) ^ head) << 2)
 #define STRETCH(floppy)	((floppy)->stretch & FD_STRETCH)
 
@@ -2069,7 +2067,7 @@ static void bad_flp_intr(void)
 			return;
 	}
 	err_count = ++(*errors);
-	INFBOUND(DRWE->badness, err_count);
+	INFBOUND(write_errors[current_drive].badness, err_count);
 	if (err_count > drive_params[current_drive].max_errors.abort)
 		cont->done(0);
 	if (err_count > drive_params[current_drive].max_errors.reset)
@@ -2274,13 +2272,13 @@ static void request_done(int uptodate)
 	} else {
 		if (rq_data_dir(req) == WRITE) {
 			/* record write error information */
-			DRWE->write_errors++;
-			if (DRWE->write_errors == 1) {
-				DRWE->first_error_sector = blk_rq_pos(req);
-				DRWE->first_error_generation = drive_state[current_drive].generation;
+			write_errors[current_drive].write_errors++;
+			if (write_errors[current_drive].write_errors == 1) {
+				write_errors[current_drive].first_error_sector = blk_rq_pos(req);
+				write_errors[current_drive].first_error_generation = drive_state[current_drive].generation;
 			}
-			DRWE->last_error_sector = blk_rq_pos(req);
-			DRWE->last_error_generation = drive_state[current_drive].generation;
+			write_errors[current_drive].last_error_sector = blk_rq_pos(req);
+			write_errors[current_drive].last_error_generation = drive_state[current_drive].generation;
 		}
 		floppy_end_request(req, BLK_STS_IOERR);
 	}
-- 
2.9.0

