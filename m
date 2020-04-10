Return-Path: <SRS0=rO4A=52=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74001C2BA2B
	for <linux-block@archiver.kernel.org>; Fri, 10 Apr 2020 10:19:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50E1E206E9
	for <linux-block@archiver.kernel.org>; Fri, 10 Apr 2020 10:19:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725990AbgDJKTR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 10 Apr 2020 06:19:17 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:34485 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725912AbgDJKTR (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 10 Apr 2020 06:19:17 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 03AAJ96S014696;
        Fri, 10 Apr 2020 12:19:09 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Denis Efremov <efremov@linux.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Willy Tarreau <w@1wt.eu>
Subject: [PATCH 27/23] floppy: cleanup: make set_fdc() always set current_drive and current_fd
Date:   Fri, 10 Apr 2020 12:19:04 +0200
Message-Id: <20200410101904.14652-3-w@1wt.eu>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20200410101904.14652-1-w@1wt.eu>
References: <20200331094054.24441-23-w@1wt.eu>
 <20200410101904.14652-1-w@1wt.eu>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When called with a negative drive value, set_fdc() would stick to the
current fdc (which was assumed to reflect the current_drive's FDC). We
do not need this anymore as the last call place with a negative value
was just addressed. Let's make this function always set both current_fdc
and current_drive so that there's no more ambiguity. A few comments
stating this were added to a few non-obvious places.

Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 drivers/block/floppy.c | 43 ++++++++++++++++++++++++++++--------------
 1 file changed, 29 insertions(+), 14 deletions(-)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index 20646d4c5437..2817170dd403 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -851,31 +851,42 @@ static void reset_fdc_info(int fdc, int mode)
 			drive_state[drive].track = NEED_2_RECAL;
 }
 
-/* selects the fdc and drive, and enables the fdc's input/dma. */
+/*
+ * selects the fdc and drive, and enables the fdc's input/dma.
+ * Both current_drive and current_fdc are changed to match the new drive.
+ */
 static void set_fdc(int drive)
 {
-	unsigned int new_fdc = current_fdc;
+	unsigned int fdc;
 
-	if (drive >= 0 && drive < N_DRIVE) {
-		new_fdc = FDC(drive);
-		current_drive = drive;
+	if (drive < 0 || drive >= N_DRIVE) {
+		pr_info("bad drive value %d\n", drive);
+		return;
 	}
-	if (new_fdc >= N_FDC) {
+
+	fdc = FDC(drive);
+	if (fdc >= N_FDC) {
 		pr_info("bad fdc value\n");
 		return;
 	}
-	current_fdc = new_fdc;
-	set_dor(current_fdc, ~0, 8);
+
+	set_dor(fdc, ~0, 8);
 #if N_FDC > 1
-	set_dor(1 - current_fdc, ~8, 0);
+	set_dor(1 - fdc, ~8, 0);
 #endif
-	if (fdc_state[current_fdc].rawcmd == 2)
-		reset_fdc_info(current_fdc, 1);
-	if (fdc_inb(current_fdc, FD_STATUS) != STATUS_READY)
-		fdc_state[current_fdc].reset = 1;
+	if (fdc_state[fdc].rawcmd == 2)
+		reset_fdc_info(fdc, 1);
+	if (fdc_inb(fdc, FD_STATUS) != STATUS_READY)
+		fdc_state[fdc].reset = 1;
+
+	current_drive = drive;
+	current_fdc = fdc;
 }
 
-/* locks the driver */
+/*
+ * locks the driver.
+ * Both current_drive and current_fdc are changed to match the new drive.
+ */
 static int lock_fdc(int drive)
 {
 	if (WARN(atomic_read(&usage_count) == 0,
@@ -3000,6 +3011,10 @@ static const struct cont_t reset_cont = {
 	.done		= generic_done
 };
 
+/*
+ * Resets the FDC connected to drive <drive>.
+ * Both current_drive and current_fdc are changed to match the new drive.
+ */
 static int user_reset_fdc(int drive, int arg, bool interruptible)
 {
 	int ret;
-- 
2.20.1

