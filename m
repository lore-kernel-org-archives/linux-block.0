Return-Path: <SRS0=9TSA=4M=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A94B5C38BFF
	for <linux-block@archiver.kernel.org>; Mon, 24 Feb 2020 21:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ABB122464
	for <linux-block@archiver.kernel.org>; Mon, 24 Feb 2020 21:40:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbgBXVkx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Feb 2020 16:40:53 -0500
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:31498 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728128AbgBXVks (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Feb 2020 16:40:48 -0500
X-Greylist: delayed 986 seconds by postgrey-1.27 at vger.kernel.org; Mon, 24 Feb 2020 16:40:39 EST
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 01OLO5Wx008701;
        Mon, 24 Feb 2020 22:24:05 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Denis Efremov <efremov@linux.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Willy Tarreau <w@1wt.eu>
Subject: [PATCH 10/10] floppy: cleanup: expand the reply_buffer macros
Date:   Mon, 24 Feb 2020 22:23:52 +0100
Message-Id: <20200224212352.8640-11-w@1wt.eu>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20200224212352.8640-1-w@1wt.eu>
References: <20200224212352.8640-1-w@1wt.eu>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Several macros were used to access reply_buffer[] at discrete positions
without making it obvious they were relying on this. These ones have
been replaced by their offset in the reply buffer to make these accesses
more obvious.

Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 drivers/block/floppy.c | 86 +++++++++++++++++++++++++++-----------------------
 1 file changed, 47 insertions(+), 39 deletions(-)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index 0d53335..d521899 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -341,14 +341,14 @@ static bool initialized;
 #define MAX_REPLIES 16
 static unsigned char reply_buffer[MAX_REPLIES];
 static int inr;		/* size of reply buffer, when called from interrupt */
-#define ST0		(reply_buffer[0])
-#define ST1		(reply_buffer[1])
-#define ST2		(reply_buffer[2])
-#define ST3		(reply_buffer[0])	/* result of GETSTATUS */
-#define R_TRACK		(reply_buffer[3])
-#define R_HEAD		(reply_buffer[4])
-#define R_SECTOR	(reply_buffer[5])
-#define R_SIZECODE	(reply_buffer[6])
+#define ST0		0
+#define ST1		1
+#define ST2		2
+#define ST3		0	/* result of GETSTATUS */
+#define R_TRACK		3
+#define R_HEAD		4
+#define R_SECTOR	5
+#define R_SIZECODE	6
 
 #define SEL_DLY		(2 * HZ / 100)
 
@@ -1366,34 +1366,37 @@ static int fdc_dtr(void)
 static void tell_sector(void)
 {
 	pr_cont(": track %d, head %d, sector %d, size %d",
-		R_TRACK, R_HEAD, R_SECTOR, R_SIZECODE);
+		reply_buffer[R_TRACK], reply_buffer[R_HEAD],
+		reply_buffer[R_SECTOR],
+		reply_buffer[R_SIZECODE]);
 }				/* tell_sector */
 
 static void print_errors(void)
 {
 	DPRINT("");
-	if (ST0 & ST0_ECE) {
+	if (reply_buffer[ST0] & ST0_ECE) {
 		pr_cont("Recalibrate failed!");
-	} else if (ST2 & ST2_CRC) {
+	} else if (reply_buffer[ST2] & ST2_CRC) {
 		pr_cont("data CRC error");
 		tell_sector();
-	} else if (ST1 & ST1_CRC) {
+	} else if (reply_buffer[ST1] & ST1_CRC) {
 		pr_cont("CRC error");
 		tell_sector();
-	} else if ((ST1 & (ST1_MAM | ST1_ND)) ||
-		   (ST2 & ST2_MAM)) {
+	} else if ((reply_buffer[ST1] & (ST1_MAM | ST1_ND)) ||
+		   (reply_buffer[ST2] & ST2_MAM)) {
 		if (!probing) {
 			pr_cont("sector not found");
 			tell_sector();
 		} else
 			pr_cont("probe failed...");
-	} else if (ST2 & ST2_WC) {	/* seek error */
+	} else if (reply_buffer[ST2] & ST2_WC) {	/* seek error */
 		pr_cont("wrong cylinder");
-	} else if (ST2 & ST2_BC) {	/* cylinder marked as bad */
+	} else if (reply_buffer[ST2] & ST2_BC) {	/* cylinder marked as bad */
 		pr_cont("bad cylinder");
 	} else {
 		pr_cont("unknown error. ST[0..2] are: 0x%x 0x%x 0x%x",
-			ST0, ST1, ST2);
+			reply_buffer[ST0], reply_buffer[ST1],
+			reply_buffer[ST2]);
 		tell_sector();
 	}
 	pr_cont("\n");
@@ -1417,28 +1420,28 @@ static int interpret_errors(void)
 	}
 
 	/* check IC to find cause of interrupt */
-	switch (ST0 & ST0_INTR) {
+	switch (reply_buffer[ST0] & ST0_INTR) {
 	case 0x40:		/* error occurred during command execution */
-		if (ST1 & ST1_EOC)
+		if (reply_buffer[ST1] & ST1_EOC)
 			return 0;	/* occurs with pseudo-DMA */
 		bad = 1;
-		if (ST1 & ST1_WP) {
+		if (reply_buffer[ST1] & ST1_WP) {
 			DPRINT("Drive is write protected\n");
 			clear_bit(FD_DISK_WRITABLE_BIT,
 				  &drive_state[current_drive].flags);
 			cont->done(0);
 			bad = 2;
-		} else if (ST1 & ST1_ND) {
+		} else if (reply_buffer[ST1] & ST1_ND) {
 			set_bit(FD_NEED_TWADDLE_BIT,
 				&drive_state[current_drive].flags);
-		} else if (ST1 & ST1_OR) {
+		} else if (reply_buffer[ST1] & ST1_OR) {
 			if (drive_params[current_drive].flags & FTD_MSG)
 				DPRINT("Over/Underrun - retrying\n");
 			bad = 0;
 		} else if (*errors >= drive_params[current_drive].max_errors.reporting) {
 			print_errors();
 		}
-		if (ST2 & ST2_WC || ST2 & ST2_BC)
+		if (reply_buffer[ST2] & ST2_WC || reply_buffer[ST2] & ST2_BC)
 			/* wrong cylinder => recal */
 			drive_state[current_drive].track = NEED_2_RECAL;
 		return bad;
@@ -1522,14 +1525,16 @@ static int blind_seek;
 static void seek_interrupt(void)
 {
 	debugt(__func__, "");
-	if (inr != 2 || (ST0 & 0xF8) != 0x20) {
+	if (inr != 2 || (reply_buffer[ST0] & 0xF8) != 0x20) {
 		DPRINT("seek failed\n");
 		drive_state[current_drive].track = NEED_2_RECAL;
 		cont->error();
 		cont->redo();
 		return;
 	}
-	if (drive_state[current_drive].track >= 0 && drive_state[current_drive].track != ST1 && !blind_seek) {
+	if (drive_state[current_drive].track >= 0 &&
+	    drive_state[current_drive].track != reply_buffer[ST1] &&
+	    !blind_seek) {
 		debug_dcl(drive_params[current_drive].flags,
 			  "clearing NEWCHANGE flag because of effective seek\n");
 		debug_dcl(drive_params[current_drive].flags, "jiffies=%lu\n",
@@ -1539,7 +1544,7 @@ static void seek_interrupt(void)
 					/* effective seek */
 		drive_state[current_drive].select_date = jiffies;
 	}
-	drive_state[current_drive].track = ST1;
+	drive_state[current_drive].track = reply_buffer[ST1];
 	floppy_ready();
 }
 
@@ -1559,8 +1564,8 @@ static void check_wp(void)
 		debug_dcl(drive_params[current_drive].flags,
 			  "checking whether disk is write protected\n");
 		debug_dcl(drive_params[current_drive].flags, "wp=%x\n",
-			  ST3 & 0x40);
-		if (!(ST3 & 0x40))
+			  reply_buffer[ST3] & 0x40);
+		if (!(reply_buffer[ST3] & 0x40))
 			set_bit(FD_DISK_WRITABLE_BIT,
 				&drive_state[current_drive].flags);
 		else
@@ -1634,7 +1639,7 @@ static void recal_interrupt(void)
 	debugt(__func__, "");
 	if (inr != 2)
 		fdc_state[fdc].reset = 1;
-	else if (ST0 & ST0_ECE) {
+	else if (reply_buffer[ST0] & ST0_ECE) {
 		switch (drive_state[current_drive].track) {
 		case NEED_1_RECAL:
 			debugt(__func__, "need 1 recal");
@@ -1672,7 +1677,7 @@ static void recal_interrupt(void)
 			break;
 		}
 	} else
-		drive_state[current_drive].track = ST1;
+		drive_state[current_drive].track = reply_buffer[ST1];
 	floppy_ready();
 }
 
@@ -1734,7 +1739,7 @@ irqreturn_t floppy_interrupt(int irq, void *dev_id)
 			if (do_print)
 				print_result("sensei", inr);
 			max_sensei--;
-		} while ((ST0 & 0x83) != UNIT(current_drive) &&
+		} while ((reply_buffer[ST0] & 0x83) != UNIT(current_drive) &&
 			 inr == 2 && max_sensei);
 	}
 	if (!handler) {
@@ -2292,7 +2297,7 @@ static void rw_interrupt(void)
 	int heads;
 	int nr_sectors;
 
-	if (R_HEAD >= 2) {
+	if (reply_buffer[R_HEAD] >= 2) {
 		/* some Toshiba floppy controllers occasionnally seem to
 		 * return bogus interrupts after read/write operations, which
 		 * can be recognized by a bad head number (>= 2) */
@@ -2305,7 +2310,7 @@ static void rw_interrupt(void)
 	nr_sectors = 0;
 	ssize = DIV_ROUND_UP(1 << raw_cmd->cmd[SIZECODE], 4);
 
-	if (ST1 & ST1_EOC)
+	if (reply_buffer[ST1] & ST1_EOC)
 		eoc = 1;
 	else
 		eoc = 0;
@@ -2315,17 +2320,20 @@ static void rw_interrupt(void)
 	else
 		heads = 1;
 
-	nr_sectors = (((R_TRACK - raw_cmd->cmd[TRACK]) * heads +
-		       R_HEAD - raw_cmd->cmd[HEAD]) * raw_cmd->cmd[SECT_PER_TRACK] +
-		      R_SECTOR - raw_cmd->cmd[SECTOR] + eoc) << raw_cmd->cmd[SIZECODE] >> 2;
+	nr_sectors = (((reply_buffer[R_TRACK] - raw_cmd->cmd[TRACK]) * heads +
+		       reply_buffer[R_HEAD] - raw_cmd->cmd[HEAD]) * raw_cmd->cmd[SECT_PER_TRACK] +
+		      reply_buffer[R_SECTOR] - raw_cmd->cmd[SECTOR] + eoc) << raw_cmd->cmd[SIZECODE] >> 2;
 
 	if (nr_sectors / ssize >
 	    DIV_ROUND_UP(in_sector_offset + current_count_sectors, ssize)) {
 		DPRINT("long rw: %x instead of %lx\n",
 		       nr_sectors, current_count_sectors);
-		pr_info("rs=%d s=%d\n", R_SECTOR, raw_cmd->cmd[SECTOR]);
-		pr_info("rh=%d h=%d\n", R_HEAD, raw_cmd->cmd[HEAD]);
-		pr_info("rt=%d t=%d\n", R_TRACK, raw_cmd->cmd[TRACK]);
+		pr_info("rs=%d s=%d\n", reply_buffer[R_SECTOR],
+			raw_cmd->cmd[SECTOR]);
+		pr_info("rh=%d h=%d\n", reply_buffer[R_HEAD],
+			raw_cmd->cmd[HEAD]);
+		pr_info("rt=%d t=%d\n", reply_buffer[R_TRACK],
+			raw_cmd->cmd[TRACK]);
 		pr_info("heads=%d eoc=%d\n", heads, eoc);
 		pr_info("spt=%d st=%d ss=%d\n",
 			raw_cmd->cmd[SECT_PER_TRACK], fsector_t, ssize);
-- 
2.9.0

