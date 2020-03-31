Return-Path: <SRS0=+91Y=5Q=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46A57C43331
	for <linux-block@archiver.kernel.org>; Tue, 31 Mar 2020 09:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22820208E0
	for <linux-block@archiver.kernel.org>; Tue, 31 Mar 2020 09:41:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730461AbgCaJlh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 31 Mar 2020 05:41:37 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:34092 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730182AbgCaJlh (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 Mar 2020 05:41:37 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 02V9f5TW024518;
        Tue, 31 Mar 2020 11:41:05 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Denis Efremov <efremov@linux.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Willy Tarreau <w@1wt.eu>
Subject: [PATCH 11/23] floppy: cleanup: make show_floppy() not rely on current_fdc anymore
Date:   Tue, 31 Mar 2020 11:40:42 +0200
Message-Id: <20200331094054.24441-12-w@1wt.eu>
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
 drivers/block/floppy.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index 6c98f8d169a9..dd739594fce7 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -1104,7 +1104,7 @@ static void setup_DMA(void)
 #endif
 }
 
-static void show_floppy(void);
+static void show_floppy(int fdc);
 
 /* waits until the fdc becomes ready */
 static int wait_til_ready(void)
@@ -1121,7 +1121,7 @@ static int wait_til_ready(void)
 	}
 	if (initialized) {
 		DPRINT("Getstatus times out (%x) on fdc %d\n", status, current_fdc);
-		show_floppy();
+		show_floppy(current_fdc);
 	}
 	fdc_state[current_fdc].reset = 1;
 	return -1;
@@ -1147,7 +1147,7 @@ static int output_byte(char byte)
 	if (initialized) {
 		DPRINT("Unable to send byte %x to FDC. Fdc=%x Status=%x\n",
 		       byte, current_fdc, status);
-		show_floppy();
+		show_floppy(current_fdc);
 	}
 	return -1;
 }
@@ -1176,7 +1176,7 @@ static int result(void)
 	if (initialized) {
 		DPRINT("get result error. Fdc=%d Last status=%x Read bytes=%d\n",
 		       current_fdc, status, i);
-		show_floppy();
+		show_floppy(current_fdc);
 	}
 	fdc_state[current_fdc].reset = 1;
 	return -1;
@@ -1819,7 +1819,7 @@ static void reset_fdc(void)
 	}
 }
 
-static void show_floppy(void)
+static void show_floppy(int fdc)
 {
 	int i;
 
@@ -1842,7 +1842,7 @@ static void show_floppy(void)
 	print_hex_dump(KERN_INFO, "", DUMP_PREFIX_NONE, 16, 1,
 		       reply_buffer, resultsize, true);
 
-	pr_info("status=%x\n", fdc_inb(current_fdc, FD_STATUS));
+	pr_info("status=%x\n", fdc_inb(fdc, FD_STATUS));
 	pr_info("fdc_busy=%lu\n", fdc_busy);
 	if (do_floppy)
 		pr_info("do_floppy=%ps\n", do_floppy);
@@ -1868,7 +1868,7 @@ static void floppy_shutdown(struct work_struct *arg)
 	unsigned long flags;
 
 	if (initialized)
-		show_floppy();
+		show_floppy(current_fdc);
 	cancel_activity();
 
 	flags = claim_dma_lock();
-- 
2.20.1

