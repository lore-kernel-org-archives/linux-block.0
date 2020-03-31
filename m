Return-Path: <SRS0=+91Y=5Q=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A6F3C43331
	for <linux-block@archiver.kernel.org>; Tue, 31 Mar 2020 09:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04FF92073B
	for <linux-block@archiver.kernel.org>; Tue, 31 Mar 2020 09:43:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730338AbgCaJnD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 31 Mar 2020 05:43:03 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:34174 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730273AbgCaJnD (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 Mar 2020 05:43:03 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 02V9f576024519;
        Tue, 31 Mar 2020 11:41:05 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Denis Efremov <efremov@linux.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Willy Tarreau <w@1wt.eu>
Subject: [PATCH 12/23] floppy: cleanup: make wait_til_ready() not rely on current_fdc anymore
Date:   Tue, 31 Mar 2020 11:40:43 +0200
Message-Id: <20200331094054.24441-13-w@1wt.eu>
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
 drivers/block/floppy.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index dd739594fce7..5dfddd4726fb 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -1107,30 +1107,30 @@ static void setup_DMA(void)
 static void show_floppy(int fdc);
 
 /* waits until the fdc becomes ready */
-static int wait_til_ready(void)
+static int wait_til_ready(int fdc)
 {
 	int status;
 	int counter;
 
-	if (fdc_state[current_fdc].reset)
+	if (fdc_state[fdc].reset)
 		return -1;
 	for (counter = 0; counter < 10000; counter++) {
-		status = fdc_inb(current_fdc, FD_STATUS);
+		status = fdc_inb(fdc, FD_STATUS);
 		if (status & STATUS_READY)
 			return status;
 	}
 	if (initialized) {
-		DPRINT("Getstatus times out (%x) on fdc %d\n", status, current_fdc);
-		show_floppy(current_fdc);
+		DPRINT("Getstatus times out (%x) on fdc %d\n", status, fdc);
+		show_floppy(fdc);
 	}
-	fdc_state[current_fdc].reset = 1;
+	fdc_state[fdc].reset = 1;
 	return -1;
 }
 
 /* sends a command byte to the fdc */
 static int output_byte(char byte)
 {
-	int status = wait_til_ready();
+	int status = wait_til_ready(current_fdc);
 
 	if (status < 0)
 		return -1;
@@ -1159,7 +1159,7 @@ static int result(void)
 	int status = 0;
 
 	for (i = 0; i < MAX_REPLIES; i++) {
-		status = wait_til_ready();
+		status = wait_til_ready(current_fdc);
 		if (status < 0)
 			break;
 		status &= STATUS_DIR | STATUS_READY | STATUS_BUSY | STATUS_DMA;
@@ -1186,7 +1186,7 @@ static int result(void)
 /* does the fdc need more output? */
 static int need_more_output(void)
 {
-	int status = wait_til_ready();
+	int status = wait_til_ready(current_fdc);
 
 	if (status < 0)
 		return -1;
-- 
2.20.1

