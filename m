Return-Path: <SRS0=+91Y=5Q=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC324C2D0EF
	for <linux-block@archiver.kernel.org>; Tue, 31 Mar 2020 09:41:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C374A2073B
	for <linux-block@archiver.kernel.org>; Tue, 31 Mar 2020 09:41:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730216AbgCaJlW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 31 Mar 2020 05:41:22 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:34081 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730182AbgCaJlV (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 Mar 2020 05:41:21 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 02V9f6r2024524;
        Tue, 31 Mar 2020 11:41:06 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Denis Efremov <efremov@linux.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Willy Tarreau <w@1wt.eu>
Subject: [PATCH 17/23] floppy: cleanup: make fdc_configure() not rely on current_fdc anymore
Date:   Tue, 31 Mar 2020 11:40:48 +0200
Message-Id: <20200331094054.24441-18-w@1wt.eu>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20200331094054.24441-1-w@1wt.eu>
References: <20200331094054.24441-1-w@1wt.eu>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Now the fdc is passed in argument so that the function does not
use current_fdc anymore.

Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 drivers/block/floppy.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index fcccbb4c143e..c1338c4bb941 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -1240,16 +1240,15 @@ static void perpendicular_mode(int fdc)
 static int fifo_depth = 0xa;
 static int no_fifo;
 
-static int fdc_configure(void)
+static int fdc_configure(int fdc)
 {
 	/* Turn on FIFO */
-	output_byte(current_fdc, FD_CONFIGURE);
-	if (need_more_output(current_fdc) != MORE_OUTPUT)
+	output_byte(fdc, FD_CONFIGURE);
+	if (need_more_output(fdc) != MORE_OUTPUT)
 		return 0;
-	output_byte(current_fdc, 0);
-	output_byte(current_fdc, 0x10 | (no_fifo & 0x20) | (fifo_depth & 0xf));
-	output_byte(current_fdc, 0);		/* pre-compensation from track
-				   0 upwards */
+	output_byte(fdc, 0);
+	output_byte(fdc, 0x10 | (no_fifo & 0x20) | (fifo_depth & 0xf));
+	output_byte(fdc, 0);    /* pre-compensation from track 0 upwards */
 	return 1;
 }
 
@@ -1288,7 +1287,7 @@ static void fdc_specify(void)
 
 	if (fdc_state[current_fdc].need_configure &&
 	    fdc_state[current_fdc].version >= FDC_82072A) {
-		fdc_configure();
+		fdc_configure(current_fdc);
 		fdc_state[current_fdc].need_configure = 0;
 	}
 
@@ -4318,7 +4317,7 @@ static char __init get_fdc_version(void)
 		return FDC_UNKNOWN;
 	}
 
-	if (!fdc_configure()) {
+	if (!fdc_configure(current_fdc)) {
 		pr_info("FDC %d is an 82072\n", current_fdc);
 		return FDC_82072;	/* 82072 doesn't know CONFIGURE */
 	}
-- 
2.20.1

